--[[ az-inventory:vehicle ]]--

vAZ.temp.vehicles = {}

vAZ.getVehicleInventory = function(plate, hash)    
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vehicles[plate] == nil then
        local vehicle = vRP.query('vAZ/GetPlayerVehiclePlate', {plate = plate})
        if #vehicle > 0 then
            local data = vAZgarage.getServerVehicle('model', vehicle[1].model)
            local maxweight = (data ~= nil) and data.trunk or 0
            local trunk = (vehicle[1].trunk == nil or vehicle[1].trunk == '') and {} or json.decode(vehicle[1].trunk)
            if type(trunk) ~= 'table' then
                trunk = {}
            end
            vAZ.temp.vehicles[plate] = {owner = vehicle[1].user_id, model = vehicle[1].model, hash = hash, maxweight = maxweight, players = {}, inventory = trunk}
        else          
            local data = vAZgarage.getServerVehicle('hash', hash)
            if data ~= nil then
                vAZ.temp.vehicles[plate] = {owner = 'temporary', model = data.model, hash = hash, maxweight = data.trunk, players = {}, inventory = {}}
            end
        end
    end
    if vAZ.temp.vehicles[plate] ~= nil then
        local inventory = {}
        for item,details in pairs(vAZ.temp.vehicles[plate].inventory) do
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
            print('[az-inventory][vehicle]['..plate..'] trunk request by user_id: '..user_id)
        end
        vAZ.addPlayerInVehicleTrunk(source, plate)
        return {plate = plate, weight = vAZ.getChestWeight(vAZ.temp.vehicles[plate].inventory), maxweight = vAZ.temp.vehicles[plate].maxweight, items = inventory}
    end
    return {}
end

vAZ.sendPlayerItemToVehicle = function(item, amount, plate, entity)
    if amount == nil or amount <= 0 or plate == nil or entity == nil then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vehicles[plate] ~= nil then
        if vAZ.temp.vehicles[plate].inventory ~= nil then
            if not vAZ.itemNotAllowed(item) then
                if vAZ.getChestWeight(vAZ.temp.vehicles[plate].inventory) + vAZ.items[item].weight * amount <= vAZ.temp.vehicles[plate].maxweight then
                    if item == 'money' and vRP.tryPayment(user_id, amount) or vRP.tryGetInventoryItem(user_id, item, amount, false) then
                        if vAZ.temp.vehicles[plate].inventory[item] then
                            vAZ.temp.vehicles[plate].inventory[item] = {amount = (vAZ.temp.vehicles[plate].inventory[item].amount + amount)}
                        else
                            vAZ.temp.vehicles[plate].inventory[item] = {amount = amount}
                        end
                    end
                    if vAZ.config.debug then
                        print('[az-inventory][vehicle]['..plate..'] send item ('..amount..'x '..item..') to vehicle: '..entity..' by user_id: '..user_id)
                    end
                    if vAZ.config.logs then
                        vAZ.webhook('vehicle', 'user_id: '..user_id..', colocou ('..amount..'x '..item..') no veiculo: '..vAZ.temp.vehicles[plate].model..', placa: '..plate)
                    end
                    for id,user in pairs(vAZ.getPlayersInVehicleTrunk(plate)) do
                        local target = vRP.getUserSource(user)
                        if target then
                            vAZclient.updateInventory(target, 'vehicle', entity, vAZ.getVehicleInventory(plate))
                        else
                            vAZ.removePlayerInVehicleTrunk(target, plate)
                        end
                    end
                    vAZclient.updateInventory(source, 'player', source, vAZ.getPlayerInventory(source)) 
                else
                    TriggerClientEvent('Notify', source, 'aviso', 'Espaço no porta malas insulficiente')
                end
            end
        end
    end
end

vAZ.sendVehicleItemToPlayer = function(item, amount, plate, entity)
    if amount == nil or amount <= 0 or plate == nil or entity == nil then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vehicles[plate] ~= nil then
        if vAZ.temp.vehicles[plate].inventory ~= nil then
            if vAZ.temp.vehicles[plate].inventory[item] then
                if vAZ.temp.vehicles[plate].inventory[item].amount >= amount then
                    if not vAZ.itemNotAllowed(item) then
                        if vRP.getInventoryWeight(user_id) + vAZ.items[item].weight * amount <= vRP.getInventoryMaxWeight(user_id) then
                            if (vAZ.temp.vehicles[plate].inventory[item].amount - amount) <= 0 then
                                vAZ.temp.vehicles[plate].inventory[item] = nil
                            else
                                vAZ.temp.vehicles[plate].inventory[item] = {amount = (vAZ.temp.vehicles[plate].inventory[item].amount - amount)}
                            end
                            if item == 'money' then
                                vRP.giveMoney(user_id, parseInt(amount))
                            else
                                vRP.giveInventoryItem(user_id, item, amount, false)
                            end
                            if vAZ.config.debug then
                                print('[az-inventory][vehicle]['..plate..'] send item ('..amount..'x '..item..') to player user_id: '..user_id)
                            end
                            if vAZ.config.logs then
                                vAZ.webhook('vehicle', 'user_id: '..user_id..', retirou ('..amount..'x '..item..') do veiculo: '..vAZ.temp.vehicles[plate].model..', placa: '..plate)
                            end
                            for id,user in pairs(vAZ.getPlayersInVehicleTrunk(plate)) do
                                local target = vRP.getUserSource(user)
                                if target then
                                    vAZclient.updateInventory(target, 'vehicle', entity, vAZ.getVehicleInventory(plate))
                                else
                                    vAZ.removePlayerInVehicleTrunk(target, plate)
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

vAZ.getPlayersInVehicleTrunk = function(plate)
    if vAZ.temp.vehicles[plate] then
        return vAZ.temp.vehicles[plate].players
    end
    return {}
end
  
vAZ.addPlayerInVehicleTrunk = function(source, plate)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vehicles[plate] then
        if vAZ.temp.vehicles[plate].players == nil then
            vAZ.temp.vehicles[plate].players = {}
        end
        local found = false
        for id,user in pairs(vAZ.temp.vehicles[plate].players) do
            if user == user_id then
                found = true
            end
        end
        if not found then
            if vAZ.config.debug then
                print('[az-inventory][vehicle]['..plate..'] player '..user_id..' added to trunk')
            end
            table.insert(vAZ.temp.vehicles[plate].players, user_id)
            return true
        end
    end
    return false
end
  
vAZ.removePlayerInVehicleTrunk = function(source, plate)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vehicles[plate] then
        if vAZ.temp.vehicles[plate].players ~= nil then
            for id,user in pairs(vAZ.temp.vehicles[plate].players) do
                if user == user_id then
                    if vAZ.config.debug then
                        print('[az-inventory][vehicle]['..plate..'] player '..user_id..' removed to trunk')
                    end
                    table.remove(vAZ.temp.vehicles[plate].players, id)
                end
            end 
            if #vAZ.temp.vehicles[plate].players <= 0 and vAZ.temp.vehicles[plate].owner ~= 'temporary' then
                if vAZ.config.debug then
                    print('[az-inventory][vehicle]['..plate..'] trunk saved')
                end
                vRP.execute('vAZ/SetPlayerTrunkVehicle', {plate = plate, trunk = json.encode(vAZ.temp.vehicles[plate].inventory)})       
                vAZ.temp.vehicles[plate] = nil
            end
        end
    end
end

AddEventHandler("vRP:playerLeave", function(user_id, source)
    for plate,vehicle in pairs(vAZ.temp.vehicles) do
        for id,user in pairs(vehicle.players) do
            if user_id == user then
                table.remove(vAZ.temp.vehicles[plate].players, id)
                if #vAZ.temp.vehicles[plate].players <= 0 and vAZ.temp.vehicles[plate].owner ~= 'temporary' then
                    if vAZ.config.debug then
                        print('[az-inventory][vehicle]['..plate..'] trunk saved')
                    end
                    vRP.execute('vAZ/SetPlayerTrunkVehicle', {plate = plate, trunk = json.encode(vAZ.temp.vehicles[plate].inventory)})       
                    vAZ.temp.vehicles[plate] = nil
                end                
            end
        end
    end
end)

Citizen.CreateThread(function()
    while vAZ.config.debug do            
        for plate,vehicle in pairs(vAZ.temp.vehicles) do
            print('[az-inventory][vehicle]['..plate..'] players: '..json.encode(vehicle.players)..' - count: '..#vehicle.players)
        end       
        Citizen.Wait(3000)
    end
end)