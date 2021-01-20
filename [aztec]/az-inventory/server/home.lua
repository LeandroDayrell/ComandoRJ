--[[ az-inventory:home ]]--

vAZ.homes = vAZhomes.getHomes() -- module('cfg/homes')
vAZ.temp.homes = {}

vRP._prepare('vAZ/getHomeByName', 'SELECT * FROM vrp_homes_permissions WHERE home = @home AND user_id = @user_id')
vRP._prepare('vAZ/updateChestHome', 'UPDATE vrp_homes_permissions SET chest = @chest WHERE home = @home AND user_id = @user_id')

vAZ.getHomeInventory = function(owner_id, slot)
    local source = source
    local user_id = vRP.getUserId(source)
    local shome = vAZ.findHomeBySlot(slot)
    if shome ~= nil then
        local name = slot..':'..owner_id
        if vAZ.temp.homes[name] == nil then
            local home = vRP.query('vAZ/getHomeByName', {home = shome.name, user_id = owner_id})
            if #home > 0 then                
                if home[1].chest == nil or home[1].chest == '' then
                    chest = {}
                else
                    chest = json.decode(home[1].chest)
                    if type(chest) ~= 'table' then
                        chest = {}
                    end
                end            
                vAZ.temp.homes[name] = {owner = home[1].user_id, name = name, maxweight = shome.weight, players = {}, inventory = chest}
            end
        end
        if vAZ.temp.homes[name] ~= nil then
            local inventory = {}
            for item,details in pairs(vAZ.temp.homes[name].inventory) do
                local data = vAZ.items[item]
                if data ~= nil then
                    table.insert(inventory, {
                        item = item,
                        label = data.label,
                        sendable = data.sendable or false,
                        usable = data.usable or false,
                        dropable = data.dropable or false,
                        weight = data.weight,
                        photo = data.photo,
                        amount = parseInt(details.amount),
                        description = data.description
                    })
                end
            end
            if vAZ.config.debug then
                print('[az-inventory][home]['..name..'] chest request by user_id: '..user_id)
            end
            vAZ.addPlayerInHomeChest(source, name)
            return {home = name, weight = vAZ.getChestWeight(vAZ.temp.homes[name].inventory), maxweight = vAZ.temp.homes[name].maxweight, items = inventory}
        end 
    end       
    return {}
end

vAZ.sendPlayerItemToHome = function(item, amount, name)
    if amount == nil or amount <= 0 then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.homes[name] ~= nil then
        if vAZ.temp.homes[name].inventory ~= nil then
            if not vAZ.itemNotAllowed(item) then
                if vAZ.getChestWeight(vAZ.temp.homes[name].inventory) + vAZ.items[item].weight * amount <= vAZ.temp.homes[name].maxweight then
                    if item == 'money' and vRP.tryPayment(user_id, amount) or vRP.tryGetInventoryItem(user_id, item, amount, false) then
                        if vAZ.temp.homes[name].inventory[item] then
                            vAZ.temp.homes[name].inventory[item] = {amount = (vAZ.temp.homes[name].inventory[item].amount + amount)}
                        else
                            vAZ.temp.homes[name].inventory[item] = {amount = amount}
                        end
                    end
                    if vAZ.config.debug then
                        print('[az-inventory][home]['..name..'] send item ('..amount..'x '..item..') to home: '..name..' by user_id: '..user_id)
                    end
                    if vAZ.config.logs then
                        vAZ.webhook('home', 'user_id: '..user_id..', colocou '..amount..'x '..item..' na casa: '..name)
                    end
                    local home = vAZ.splitHomeName(name)
                    for id,user in pairs(vAZ.getPlayersInHomeChest(name)) do
                        local user_source = vRP.getUserSource(user)
                        if user_source then
                            vAZclient.updateInventory(user_source, 'home', name, vAZ.getHomeInventory(home.owner_id, home.slot))
                        else
                            vAZ.removePlayerInVehicleTrunk(user_source, name)
                        end
                    end
                    vAZclient.updateInventory(source, 'player', source, vAZ.getPlayerInventory(source)) 
                end
            else
                TriggerClientEvent('Notify', source, 'aviso', 'Espaço no baú insulficiente')
            end
        end
    end
end

vAZ.sendHomeItemToPlayer = function(item, amount, name)    
    if amount == nil or amount <= 0 then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.homes[name] ~= nil then
        if vAZ.temp.homes[name].inventory ~= nil then
            if vAZ.temp.homes[name].inventory[item] then
                if vAZ.temp.homes[name].inventory[item].amount >= amount then
                    if not vAZ.itemNotAllowed(item) then
                        if vRP.getInventoryWeight(user_id) + vAZ.items[item].weight * amount <= vRP.getInventoryMaxWeight(user_id) then
                            if (vAZ.temp.homes[name].inventory[item].amount - amount) <= 0 then
                                vAZ.temp.homes[name].inventory[item] = nil
                            else
                                vAZ.temp.homes[name].inventory[item] = {amount = (vAZ.temp.homes[name].inventory[item].amount - amount)}
                            end
                            if item == 'money' then
                                vRP.giveMoney(user_id, parseInt(amount))
                            else
                                vRP.giveInventoryItem(user_id, item, amount, false)
                            end
                            if vAZ.config.debug then
                                print('[az-inventory][home]['..name..'] send item ('..amount..'x '..item..') to player user_id: '..user_id)
                            end
                            if vAZ.config.logs then
                                vAZ.webhook('home', 'user_id: '..user_id..', retirou '..amount..'x '..item..' da casa: '..name)
                            end
                            local home = vAZ.splitHomeName(name)
                            for id,user in pairs(vAZ.getPlayersInHomeChest(name)) do
                                local user_source = vRP.getUserSource(user)
                                if user_source then                                
                                    vAZclient.updateInventory(user_source, 'home', name, vAZ.getHomeInventory(home.owner_id, home.slot))
                                else
                                    vAZ.removePlayerInHomeChest(user_source, name)
                                end
                            end
                            vAZclient.updateInventory(source, 'player', source, vAZ.getPlayerInventory(source)) 
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Espaço na mochila insulficiente')
                        end
                    end                    
                else
                    TriggerClientEvent('Notify', source, 'aviso', 'Não há essa quantidade no porta malas.')
                end                
            end
        end
    end
end

vAZ.getPlayersInHomeChest = function(name)
    if vAZ.temp.homes[name] then
        return vAZ.temp.homes[name].players
    end
    return {}
end
  
vAZ.addPlayerInHomeChest = function(source, name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.homes[name] then
        if vAZ.temp.homes[name].players == nil then
            vAZ.temp.homes[name].players = {}
        end
        local found = false
        for id,user in pairs(vAZ.temp.homes[name].players) do
            if user == user_id then
                found = true
            end
        end
        if not found then
            if vAZ.config.debug then
                print('[az-inventory][home]['..name..'] player '..user_id..' added to chest')
            end
            table.insert(vAZ.temp.homes[name].players, user_id)
            return true
        end
    end
    return false
end

vAZ.removePlayerInHomeChest = function(source, name)
    local source = source
    local user_id = vRP.getUserId(source)
    local home = vAZ.splitHomeName(name)
    local shome = vAZ.findHomeBySlot(home.slot)
    if shome ~= nil then
        if vAZ.temp.homes[name] then
            if vAZ.temp.homes[name].players ~= nil then
                for id,user in pairs(vAZ.temp.homes[name].players) do
                    if user == user_id then
                        if vAZ.config.debug then
                            print('[az-inventory][home]['..name..'] player '..user_id..' removed to chest')
                        end
                        table.remove(vAZ.temp.homes[name].players, id)
                    end
                end 
                if #vAZ.temp.homes[name].players <= 0 then
                    if vAZ.config.debug then
                        print('[az-inventory][home]['..name..'] chest saved')
                    end
                    vRP.execute('vAZ/updateChestHome', {home = shome.name, user_id = vAZ.temp.homes[name].owner, chest = json.encode(vAZ.temp.homes[name].inventory)})       
                    vAZ.temp.homes[name] = nil
                end
            end
        end
    end    
end

AddEventHandler("vRP:playerLeave", function(user_id, source)
    for name,home in pairs(vAZ.temp.homes) do
        local vhome = vAZ.splitHomeName(name)
        local shome = vAZ.findHomeBySlot(vhome.slot)
        if shome ~= nil then
            for id,user in pairs(home.players) do
                if user_id == user then
                    table.remove(vAZ.temp.homes[name].players, id)
                    if #vAZ.temp.homes[name].players <= 0 then
                        if vAZ.config.debug then
                            print('[az-inventory][home]['..name..'] chest saved')
                        end
                        vRP.execute('vAZ/updateChestHome', {home = shome.name, user_id = vAZ.temp.homes[name].owner, chest = json.encode(vAZ.temp.homes[name].inventory)})       
                        vAZ.temp.homes[name] = nil
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while vAZ.config.debug do            
        for name,home in pairs(vAZ.temp.homes) do
            print('[az-inventory][home]['..name..'] players: '..json.encode(home.players)..' - count: '..#home.players)
        end       
        Citizen.Wait(3000)
    end
end)

vAZ.findHomeBySlot = function(slot)
    if vAZ.homes[slot] then
        return {name = slot, weight = vAZ.homes[slot][3]}
    end
    return nil
end

vAZ.splitHomeName = function(name)
    local split = splitString(name, ':')
    return {slot = split[1], owner_id = split[#split]}
end