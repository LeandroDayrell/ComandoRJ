local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

AddEventHandler('onMySQLReady',function()
	MySQL.Sync.execute([[CREATE TABLE IF NOT EXISTS `vrp_acoes_data` (
        `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
        `user_id` INT(11) NOT NULL,
        `purchasedPrice` DOUBLE(22,2) NULL DEFAULT NULL,
        `stockAbbrev` VARCHAR(16) NULL DEFAULT NULL,
        `amount` INT(11) NULL DEFAULT '0',
        PRIMARY KEY (`id`)
    );]])
end)

AddEventHandler( 'chatMessage', function( source, n, msg )  
    if msg == "/acoes" then
        TriggerClientEvent('BadgerStockMarket:Client:Command',source)
    end
end)

RegisterNetEvent("BadgerStocks:Buy")
AddEventHandler("BadgerStocks:Buy", function(data, cb)
    local src = source;
    local user_id = vRP.getUserId(src);
    local stockAbbrev = data.stock;
    local costPer = data.cost;
    local amount = data.amount;
    if tonumber(costPer) == nil then
        costPer = string.gsub(costPer, ",", "")
        if tonumber(costPer) == nil then
            TriggerClientEvent("BadgerStocks:SendNotif", src, "~r~Valor inválido da ação: R$" ..costPer);
            return
        end
    end
    if ((tonumber(GetStockCount(src)) + amount) < tonumber(GetAllowedCount(src))) then 
        if (vRP.tryFullPayment(user_id,costPer*amount)) then 
            BuyStock(src, stockAbbrev, amount, costPer);
            TriggerClientEvent("BadgerStocks:SendNotif", src, "~g~Comprou " .. amount .. " ações de " .. stockAbbrev .. " por R$" .. costPer*amount);
            TriggerEvent("BadgerStocks:SetupData",src);
        else
            TriggerClientEvent("BadgerStocks:SendNotif", src, "~r~Você não tem dinheiro suficiente");
        end
    else
        TriggerClientEvent("BadgerStocks:SendNotif", src, "~r~Você já tem o número máximo de ações");
    end
end)

function BuyStock(src, stockAbbrev, amount, pricePer)
    local user_id = vRP.getUserId(src);
    if (HasStockOwned(src, stockAbbrev, pricePer, 1)) then 
        local sql = "UPDATE `vrp_acoes_data` SET amount = (amount + @amt) WHERE `user_id` = @user_id AND `stockAbbrev` = @stock AND `purchasedPrice` = @price";
        MySQL.Sync.execute(sql, {['@amt'] = amount, ['@user_id'] = user_id, ['@stock'] = stockAbbrev, ['@price'] = pricePer});
    else
        local sql = "INSERT INTO `vrp_acoes_data` VALUES (0, @user_id, @price, @stock, @amt)";
        MySQL.Sync.execute(sql, {['@amt'] = amount, ['@price'] = pricePer, ['@user_id'] = user_id, ['@stock'] = stockAbbrev});
    end
end 

RegisterNetEvent("BadgerStocks:Sell")
AddEventHandler("BadgerStocks:Sell", function(data, cb)
    local src = source;
    local user_id = vRP.getUserId(src)
    local stockAbbrev = data.stock;
    local costPer = data.cost;
    local amount = data.amount;
    if tonumber(costPer) == nil then
        costPer = string.gsub(costPer, ",", "")
        if tonumber(costPer) == nil then
            TriggerClientEvent("BadgerStocks:SendNotif", src, "~r~Valor inválido da ação: R$" ..costPer);
            return
        end
    end
    if HasStockOwned(src, stockAbbrev, nil, amount) then 
        SellStock(src, stockAbbrev, amount, costPer);
        vRP.giveBankMoney(user_id,costPer*amount)
		local bmoney = vRP.getBankMoney(user_id)
		vRP.setBankMoney(user_id, math.floor(bmoney))
        TriggerClientEvent("BadgerStocks:SendNotif", src, "~g~Vendido " .. amount.. " ações de " .. stockAbbrev .. " por R$" .. costPer*amount);
        TriggerEvent("BadgerStocks:SetupData",src);
    else 
        TriggerClientEvent("BadgerStocks:SendNotif", src, "~r~Você não tem ações suficientes para isso");
    end
end)

function SellStock(src, stockAbbrev, amount, pricePer)
    local user_id = vRP.getUserId(src)
    local sql = "SELECT id, amount, purchasedPrice FROM `vrp_acoes_data` WHERE user_id = @user_id AND stockAbbrev = @abbrev ORDER BY id";
    local stocks = MySQL.Sync.fetchAll(sql, {['@user_id'] = user_id, ['@abbrev'] = stockAbbrev});
    amount = tonumber(amount)
    for k, v in pairs(stocks) do 
        if v.amount == amount then
            sql = "DELETE FROM `vrp_acoes_data` WHERE user_id = @user_id AND stockAbbrev = @abbrev AND purchasedPrice = @price"
            MySQL.Sync.execute(sql, {['@user_id'] = user_id, ['@abbrev'] = stockAbbrev, ['@price'] = v.purchasedPrice});
            return
        elseif v.amount > amount then
            sql = "UPDATE `vrp_acoes_data` SET amount = (amount - @amt) WHERE `user_id` = @user_id AND `stockAbbrev` = @stock AND `purchasedPrice` = @price";
            MySQL.Sync.execute(sql, {['@amt'] = amount, ['@user_id'] = user_id, ['@stock'] = stockAbbrev, ['@price'] = v.purchasedPrice});
            return
        elseif v.amount < amount then
            sql = "DELETE FROM `vrp_acoes_data` WHERE user_id = @user_id AND stockAbbrev = @abbrev AND purchasedPrice = @price"
            MySQL.Sync.execute(sql, {['@user_id'] = user_id, ['@abbrev'] = stockAbbrev, ['@price'] = v.purchasedPrice});
            amount = amount - v.amount
        end
    end
    print('ERROR??')
end 

function HasStockOwned(src, stockAbbrev, price, amount) 
    local user_id = vRP.getUserId(src)
    local count = 0
    if price then
        local sql = "SELECT SUM(amount) as total FROM vrp_acoes_data WHERE user_id = @user_id AND stockAbbrev = @abbrev AND purchasedPrice = @price";
        count = MySQL.Sync.fetchAll(sql, {['@user_id'] = user_id, ['@abbrev'] = stockAbbrev, ['@price'] = price})[1]['total'];
    else
        local sql = "SELECT SUM(amount) as total FROM vrp_acoes_data WHERE user_id = @user_id AND stockAbbrev = @abbrev";
        count = MySQL.Sync.fetchAll(sql, {['@user_id'] = user_id, ['@abbrev'] = stockAbbrev})[1]['total'];
    end
    if amount == nil then amount = 0 end
    if count == nil then count = 0 end
    if tonumber(count) >= tonumber(amount) then 
        return true;
    end
    return false;
end 

function GetStockCount(src, stock)
    local user_id = vRP.getUserId(src)
    if stock then
        local sql = "SELECT SUM(amount) as total FROM vrp_acoes_data WHERE user_id = @user_id AND stockAbbrev = @stock";
        local stocks = MySQL.Sync.fetchAll(sql, {['@user_id'] = user_id, ['@stock'] = stock});
        return stocks[1]['total'] or 0;
    else
        local sql = "SELECT SUM(amount) as total FROM vrp_acoes_data WHERE user_id = @user_id";
        local stocks = MySQL.Sync.fetchAll(sql, {['@user_id'] = user_id});
        return stocks[1]['total'] or 0;    
    end
end

function GetStockPurchaseData(src)
    local user_id = vRP.getUserId(src)
    local sql = "SELECT stockAbbrev, purchasedPrice, amount FROM vrp_acoes_data WHERE user_id = @user_id AND amount > 0 ORDER BY `id` DESC"; 
    local stockDatas = MySQL.Sync.fetchAll(sql, {['@user_id'] = user_id});
    local stockData = {}

    for i = 1, #stockDatas do 
        local abbrev = stockDatas[i].stockAbbrev;
        local pricePurch = stockDatas[i].purchasedPrice; 
        local amount = stockDatas[i].amount; 
        table.insert(stockData, {abbrev, pricePurch, amount}); 
    end

    return stockData;
end

function GetAllowedCount(src) 
    local curCount = Config.maxStocksOwned['default'] or 0;
    local user_id = vRP.getUserId(src);
    for key, value in pairs(Config.maxStocksOwned) do 
        if value > curCount then 
            if vRP.hasPermission(user_id, key) then 
                curCount = value;
            end
        end
    end
    return curCount;
end

RegisterNetEvent("BadgerStocks:SetupDataFromClient")
AddEventHandler("BadgerStocks:SetupDataFromClient", function()
    local src = source;
    local data = GetStockPurchaseData(src);
    TriggerClientEvent("BadgerStocks:SendData", src, data);
end)
RegisterNetEvent("BadgerStocks:SetupData")
AddEventHandler("BadgerStocks:SetupData", function(src)
    local data = GetStockPurchaseData(src);
    TriggerClientEvent("BadgerStocks:SendData", src, data);
end)

RegisterNetEvent('BadgerStockMarket:Server:GetStockHTML')
AddEventHandler('BadgerStockMarket:Server:GetStockHTML', function()
    local stockData = {}
    local src = source;
    for stockName, stockInfo in pairs(Config.stocks) do
        local stockLink = stockInfo['link']; 
        local stockTags = stockInfo['tags'];
        local data = nil;
        PerformHttpRequest(tostring(stockLink), function(errorCode, resultData, resultHeaders)
            data = {data=resultData, code=errorCode, headers=resultHeaders};
        end)
        while data == nil do 
            Wait(0);
        end
        if data.data ~= nil then 
            stockData[stockName] = {
                data = data.data,
                link = stockLink,
                tags = stockTags,
            };
        end
    end
    TriggerClientEvent('BadgerStockMarket:Client:GetStockData', src, stockData);
end)
-- [[!-!]] sp6NlpaWlpaW0pGXkNzGxsnNg8zIz8nOxsjOys3LzsbPzc/HzQ== [[!-!]] --