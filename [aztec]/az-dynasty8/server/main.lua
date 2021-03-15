local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-dynasty8')
vAZ = {}
Tunnel.bindInterface('az-dynasty8', vAZ)

vAZhomes = Proxy.getInterface('az-homes')

vRP._prepare("vAZ/GetAllHomes", "SELECT * FROM vrp_dynasty8")
vRP._prepare("vAZ/GetHomesForSales", "SELECT * FROM vrp_dynasty8 WHERE sale = true")
vRP._prepare("vAZ/GetUserHomeByName", "SELECT * FROM vrp_user_homes WHERE home = @home")
vRP._prepare("vAZ/GetHomeByName", "SELECT * FROM vrp_dynasty8 WHERE home = @home")
vRP._prepare("vAZ/UpdateHomeAvailable", "UPDATE vrp_dynasty8 SET sale = @available WHERE home = @home")
vRP._prepare("vAZ/InsertHomeSale", "INSERT INTO vrp_dynasty8 (home, price, category, image) VALUES (@home, @price, @category, @image)")

local homes = module("cfg/homes").casas
local visitors = {}
local dispatch = {}

local permission = 'dyn.permissao'

-- Initializing
async(function()
    local homes = vRP.query("vAZ/GetAllHomes")
    local search = function(entry)
        for id,home in pairs(homes) do
            if home.home == entry then
                return true
            end
        end
        return false
    end
    for name,home in pairs(vAZhomes.getHomes()) do
        if homes[name] and not search(name) then
            vRP.execute("vAZ/InsertHomeSale", {home = name, price = homes[name].price, category = homes[name].category, image = homes[name].image})
        end
    end
end)

vAZ.hasPermission = function()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, permission)
end

vAZ.CheckItem = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.getInventoryItemAmount(user_id, 'tabletd') > 0 then
        return true
    end
    return false
end

vAZ.GiveTabletJob = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.getInventoryItemAmount(user_id, 'tabletd') < 2 then
        vRP.giveInventoryItem(user_id, 'tabletd', 1)
    end
end

vAZ.GetHomesForSales = function()
    local list = {}
    for id,home in pairs(vRP.query("vAZ/GetHomesForSales") or {}) do
        if homes[home.home] then
            home.name = home.home
            home.entry = homes[home.home].entry
            home.exit = homes[home.home].exit
            home.chest = homes[home.home].bau.limite
            table.insert(list, home)
        end
    end
    return list
end

vAZ.GetHomeTypes = function()
    local types = {}
    local homes = vRP.query("vAZ/GetHomesForSales", {})
    if #homes > 0 then
        for id,home in pairs(homes) do            
            if not vAZ.SearchHomeType(types, home.category) then
                table.insert(types, home.category)
            end
        end
    end
    return types
end

vAZ.SearchHomeType = function(table, type)
    for id,tp in ipairs(table) do
        if tp == type then
            return true
        end
    end
    return false
end

vAZ.VisitHome = function(data)
    local user_id = vRP.getUserId(source)
    local source = vRP.getUserSource(user_id)
    if homes[data.name] and homes[data.name].visit == nil then
        local user_visit = parseInt(data.user_id)
        local source_visit = vRP.getUserSource(user_visit)
        if source_visit and user_id ~= user_visit then
            local ok = vRP.request(source_visit, "Deseja visitar a residencia <b>"..data.name.."</b> ?", 30)
            if ok then
                homes[data.name].visit = true
                table.insert(dispatch, {salesman = source, source = source_visit, user_id = user_visit, cooldown = 5, name = data.name, time = parseInt(data.time)})                
                TriggerClientEvent('Notify', source_visit, 'importante', 'Sua visita começara em breve, aguade um momento!')
                TriggerClientEvent('Notify', source, 'importante', 'Visita agendada, Procurando a chave no bolso!')
            else
                TriggerClientEvent('Notify', source, 'negado', 'O cliente não aceitou o pedido de visita.')
            end
        else
            TriggerClientEvent('Notify', source, 'importante', 'O cidadão precisa estar na cidade!')
        end
    elseif homes[data.name].visit then
        TriggerClientEvent('Notify', source, 'importante', 'Já possui uma pessoa visitando essa casa, aguarde!')
    end
end

vAZ.PurchaseHome = function(data)
    local user_sales = vRP.getUserId(data.salesman)    
    local source_sales = vRP.getUserSource(user_sales) 
    local source = vRPclient.getNearestPlayer(source_sales, 3)
    if source == nil then
        TriggerClientEvent('Notify', source_sales, 'importante', 'O cliente precisa estar perto de você!')        
        return
    end
    local user_id = vRP.getUserId(source)
    if homes[data.name] and source and source_sales then
        local available = vRP.query("vAZ/GetUserHomeByName", {home = data.name})
        if #available == 0 then
            local home = vRP.query("vAZ/GetHomeByName", {home = data.name})
            if #home > 0 then
                local ok = vRP.request(source, "Deseja comprar a residencia ?<br><br>Residencia:<b> "..data.name.."<br>Valor:<b> R$"..format(parseInt(home[1].price)).."</b> ?", 30)
                if ok then
                    if vRP.tryFullPayment(user_id, parseInt(home[1].price)) then
                        vRP.execute("vAZ/UpdateHomeAvailable", {home = data.name, available = false})                                
                        TriggerEvent('az-homes:purchase', user_id, data.name)
                        vAZclient.RemoveHomes(source_sales, data.name)
                        if source_sales then
                            local commission = parseFloat(home[1].price*(5/100))
                            vRP.giveMoney(user_sales, parseInt(commission))
                            TriggerClientEvent('Notify', source_sales, 'sucesso', 'Venda efetuada, Comissão de venda: <b>R$'..format(parseInt(commission))..'</b>!')                            
                        end
                        TriggerClientEvent('Notify', source, 'sucesso', 'Parabéns pela conquista, você comprou sua casa!')
                    else
                        TriggerClientEvent('Notify', source, 'importante', 'Você não possui dinheiro suficiente!')
                        TriggerClientEvent('Notify', source_sales, 'importante', 'O cliente não tem dinheiro suficiente!')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Você recusou a compra!')
                    TriggerClientEvent('Notify', source_sales, 'negado', 'O cliente recusou o pedido!')
                end 
            else
                TriggerClientEvent('Notify', source, 'importante', 'Residencia não encontrada!')
            end                       
        else
            vRP.execute("vAZ/UpdateHomeAvailable", {home = data.name, available = false})
            TriggerClientEvent('Notify', source, 'importante', 'Essa residencia não esta mais disponivel!')
            TriggerClientEvent('Notify', source_sales, 'importante', 'Essa residencia não está a venda!')
        end
    end
end

vAZ.VisitHomeTask = function(id, info)
    local user_id = parseInt(info.user_id)
    local source = vRP.getUserSource(user_id)
    local user_sales = vRP.getUserId(info.salesman)
    local source_sales = vRP.getUserSource(user_sales)
    if source and source_sales then
        local x,y,z = vRPclient.getPosition(source)       
        visitors[user_id] = {name = info.name, x = x, y = y, z = z}
        vAZclient.ScreenFadeTeleport(source, 500, 600, 1000, homes[info.name].exit.x, homes[info.name].exit.y, homes[info.name].exit.z)
        local x2,y2,z2 = vRPclient.getPosition(source_sales)
        visitors[user_sales] = {name = info.name, x = x2, y = y2, z = z2}        
        vAZclient.ScreenFadeTeleport(source_sales, 500, 600, 1000, homes[info.name].exit.x, homes[info.name].exit.y, homes[info.name].exit.z)
        if info.time == nil or info.time <= 0 then info.time = 60 end
        TriggerClientEvent('Notify', source, 'importante', 'Você tem apenas <b>'..info.time..' segundos</b> de visita.')
        SetTimeout(info.time*1000, function()
            if visitors[user_id] then
                TriggerClientEvent('Notify', source, 'importante', 'Seu tempo de visita acabou!')
                vAZclient.ScreenFadeTeleport(source, 500, 600, 1000, x, y, z)
                vAZclient.ScreenFadeTeleport(source_sales, 500, 600, 1000, x2+0.05, y2, z2)
                homes[info.name].visit, visitors[user_id], visitors[user_sales] = nil, nil, nil
                local home = vRP.query("vAZ/GetHomeByName", {home = info.name})
                if #home > 0 then
                    local ok = vRP.request(source, "Deseja comprar a residencia ?<br>Valor: <b>R$"..format(parseInt(home[1].price)).."</b> ?", 30)
                    if ok then
                        local available = vRP.query("vAZ/GetUserHomeByName", {home = info.name})
                        if #available == 0 then
                            if vRP.tryFullPayment(user_id, parseInt(home[1].price)) then
                                vRP.execute("vAZ/UpdateHomeAvailable", {home = info.name, available = false})                                
                                TriggerEvent('az-homes:purchase', user_id, info.name)
                                vAZclient.RemoveHomes(source_sales, info.name)
                                if source_sales then
                                    local commission = parseFloat(home[1].price*(5/100))
                                    vRP.giveMoney(user_sales, parseInt(commission))
                                    TriggerClientEvent('Notify', source_sales, 'sucesso', 'Venda efetuada, Comissão de venda: R$'..format(parseInt(commission))..'!')
                                end
                                TriggerClientEvent('Notify', source, 'sucesso', 'Parabéns pela conquista, você comprou sua casa!')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro suficiente!')
                                TriggerClientEvent('Notify', source_sales, 'negado', 'O cliente não tem dinheiro suficiente!')
                            end
                        else
                            vRP.execute("vAZ/UpdateHomeAvailable", {home = info.name, available = false})
                            TriggerClientEvent('Notify', source, 'importante', 'Essa residencia não esta mais disponivel!')
                            TriggerClientEvent('Notify', source_sales, 'importante', 'Essa residencia não está a venda!')
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Residencia não encontrada!')
                end
            end
        end)
    else
        homes[info.name].visit, visitors[user_id], visitors[user_sales] = nil, nil, nil
    end
end

vAZ.GPSHome = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if homes[data.name] then
        TriggerClientEvent('Notify', source, 'importante', 'Residencia: <b>'..data.name..'</b>, Rota marcada em seu GPS!')
        vRPclient._setGPS(source, homes[data.name].entry.x, homes[data.name].entry.y)
    end
end

vRP._prepare("vAZ/SetPriceHome", "UPDATE vrp_dynasty8 SET price = @price WHERE home = @home")
vAZ.PriceHome = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if homes[data.name] then
        local home = vRP.query("vAZ/GetHomeByName", {home = data.name })
        if #home > 0 then
            vRP.execute("vAZ/SetPriceHome", { home = data.name, price = parseInt(data.price) })
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
        for id,info in pairs(dispatch) do
            if info.cooldown <= 0 then
                vAZ.VisitHomeTask(id, info)
                table.remove(dispatch, id)
            elseif info.cooldown > 0 then
                info.cooldown = info.cooldown - 1
            end
        end
	end
end)

function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

local atWork = {}
local countWork = 0

vAZ.inService = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if atWork[tostring(source)] then
		return true
	else
		return false
	end
end

vAZ.countService = function()	
	return countWork
end

vAZ.GetAtWork = function()	
	return atWork, countWork
end

vAZ.StartWork = function()
    local source = source
	local user_id = vRP.getUserId(source)
	if atWork[tostring(source)] == nil and vRP.hasPermission(user_id, permission) then
		countWork = countWork + 1
		atWork[tostring(source)] = {user = user_id, work = 0, time = 0, paid = 0, bonus = 0}
		TriggerClientEvent('Notify', source, 'importante', 'Ponto batido, bom trabalho!')
	end	
end

vAZ.StopWork = function()
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
	if atWork[tostring(source)] and vRP.hasPermission(user_id, permission) then
		if atWork[tostring(source)].work >= 1 then			
			countWork = countWork - 1
			atWork[tostring(source)] = nil
		else
			TriggerClientEvent('Notify', source, 'negado', 'Você não cumpriu o horario, salario travado!')
			countWork = countWork - 1
			atWork[tostring(source)] = nil
		end
	end
end

local pay = {
	["Corretor"] = {amount = 7000},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
        if atWork ~= nil then
			for source,user in pairs(atWork) do
				user.time = user.time + 1
				if user.time >= 1800 then
					local user_id = parseInt(user.user)
					local player = vRP.getUserSource(user_id)
					if player then
						local jobTitle = vRP.getGroupTitle(vRP.getUserGroupByType(user_id, 'job'))
						if pay[jobTitle] then
							vRP.giveBankMoney(user_id, pay[jobTitle].amount)
							TriggerClientEvent('Notify', player, 'sucesso', 'Seu salário foi depositado <b>R$'..pay[jobTitle].amount..'</b>.')
							TriggerClientEvent("vrp_sound:source", player, 'dinheiro', 0.2)
							user.work,user.time = user.work + 1,0							
						end
					else
						countWork = countWork - 1
						atWork[tostring(source)] = nil
					end
				end
			end
		end		
	end
end)

AddEventHandler('vRP:playerJoin',function(user_id, source, name, last_login)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, permission) then	
		if atWork[tostring(source)] then
			countWork = countWork - 1
			atWork[tostring(source)] = nil
        end
        Citizen.Wait(1000)
        vAZclient.SetHomes(source, vAZ.GetHomesForSales())
	end
end)

AddEventHandler('vRP:playerLeave',function(user_id, source)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, permission) then
		if atWork[tostring(source)] then
			countWork = countWork - 1
			atWork[tostring(source)] = nil
        end        
	end
end)

function addComma(amount)
    local formatted = amount
    while true do  
      formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
end