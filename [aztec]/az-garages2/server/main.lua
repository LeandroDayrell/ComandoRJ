local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-garages')
vAZ = {}
Proxy.addInterface('az-garages', vAZ)
Tunnel.bindInterface('az-garages', vAZ)

-- server querys
vRP._prepare('vAZ/GetServerVehicles', 'SELECT * FROM vrp_vehicles')
vRP._prepare('vAZ/AddServerStockVehicle', 'UPDATE vrp_vehicles SET stock = stock + @amount WHERE model = @model')
vRP._prepare('vAZ/RemoveServerStockVehicle', 'UPDATE vrp_vehicles SET stock = stock - @amount WHERE model = @model')
vRP._prepare('vAZ/SetServerResetState', 'UPDATE vrp_user_vehicles SET state = 0 WHERE state < 2')
vRP._prepare("vAZ/MoveUserVehicle", "UPDATE vrp_user_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND model = @model")

-- garage querys
vRP._prepare('vAZ/GetPlayerVehicles', 'SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id')
vRP._prepare('vAZ/GetPlayerVehiclePlate', 'SELECT * FROM vrp_user_vehicles WHERE plate = @plate')
vRP._prepare('vAZ/GetPlayerVehicleModel', 'SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND model = @model')
vRP._prepare('vAZ/SetPlayerStateVehicle', 'UPDATE vrp_user_vehicles SET state = @state WHERE user_id = @user_id AND model = @model')
vRP._prepare('vAZ/SetPlayerFareVehicle', 'UPDATE vrp_user_vehicles SET state = @state, time = @time WHERE user_id = @user_id AND plate = @plate')
vRP._prepare('vAZ/SetPlayerSpecificVehicle', 'UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND model = @model')
vRP._prepare('vAZ/SetPlayerIpvaVehicle', 'UPDATE vrp_user_vehicles SET ipva = @ipva WHERE plate = @plate AND model = @model')
vRP._prepare('vAZ/SetPlayerModsVehicle', 'UPDATE vrp_user_vehicles SET mods = @mods WHERE plate = @plate')
vRP._prepare('vAZ/SetPlayerTrunkVehicle', 'UPDATE vrp_user_vehicles SET trunk = @trunk WHERE plate = @plate')

vAZ.server = {}
vAZ.server.dropped = {}
vAZ.server.vehicles = {}

vAZ.user = {}
vAZ.user.vehicles = {}
vAZ.user.cooldown = {}

vAZ.temp = {}
vAZ.temp.list = {}
vAZ.temp.vehicles = {}

async(function()
    vRP.execute("vAZ/SetServerResetState", {})
    for id,vehicle in pairs(vRP.query("vAZ/GetServerVehicles", {})) do
        table.insert(vAZ.server.vehicles, {
            model = vehicle.model,
            hash = parseInt(vehicle.hash),
            type = vehicle.type,
            name = vehicle.name,
            class = vehicle.class,
            description = vehicle.description,
            trunk = vehicle.trunk,
            stock = vehicle.stock,
            price = vehicle.price,
            vip = vehicle.vip,
            exclusive = vehicle.exclusive,
            banned = vehicle.banned,            
            image = vehicle.image
        })
    end
end)

vAZ.hasPermission = function(permission)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, permission)
end

vAZ.homePermission = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    local home = vRP.query("homes/get_homepermissions", { home = name })
    if #home > 0 then
        for id,data in pairs(home) do
            if data.owner == 1 then
                return true
            end
        end
    end
    return false
end

vAZ.getServerVehicle = function(key, entry)
    for id,vehicle in pairs(vAZ.server.vehicles) do
        if key == 'hash' and vehicle.hash == entry or key == 'model' and vehicle.model == entry then
            return vehicle
        end
    end
    print('[az-garages] vehicle not found: ['..key..'] '..entry)
    return nil
end

vAZ.getServerVehicles = function()
    return vAZ.server.vehicles
end

vAZ.addServerStockVehicle = function(model, amount)
    if amount == nil or type(amount) ~= "number" then
        amount = 1
    end
    for id,vehicle in pairs(vAZ.server.vehicles) do
        if vehicle.model == model then
            vAZ.server.vehicles[id].stock = vehicle.stock + amount
            vRP.execute("vAZ/AddServerStockVehicle", {model = vehicle.model, amount = amount})
            break
        end
    end
end

vAZ.removeServerStockVehicle = function(model, amount)
    if amount == nil or type(amount) ~= "number" then
        amount = 1
    end
    for id,vehicle in pairs(vAZ.server.vehicles) do
        if vehicle.model == model then
            vAZ.server.vehicles[id].stock = vehicle.stock - amount
            vRP.execute("vAZ/RemoveServerStockVehicle", {model = vehicle.model, amount = amount})
            break
        end
    end
end

vAZ.getUserGarageVehicles = function(type, id, availables)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local registration = identity.registration:gsub("% ", "")

    vAZ.temp.list[user_id], vAZ.temp.vehicles[user_id] = {}, {}

    if type == 'service' or type == 'rental' or type == 'private' then
        local garage = vAZ.getServerGarage(type, id)
        if garage ~= nil then
            if garage.permission ~= nil and not vRP.hasPermission(user_id, garage.permission) then
                TriggerClientEvent('Notify', source, 'sucesso', "Você não tem permissão para acessar essa garagem.")
                return false
            end
            if garage.vehicles ~= nil then
                for id,model in pairs(garage.vehicles) do  
                    local vehicle = vAZ.getServerVehicle('model', model)
                    if vehicle ~= nil then
                        table.insert(vAZ.temp.list[user_id], vehicle)
                    end
                end
                for id,vehicle in pairs(vAZ.temp.list[user_id]) do
                    if vehicle.class == nil or vehicle.class == '' then vehicle.class = 'Unknown' end
                    if vehicle.image == nil or vehicle.image == ''  then vehicle.image = 'Unknown' end
                    vehicle.time = 0
                    vehicle.state = 0
                    vehicle.plate = registration
                    vehicle.fuel = 100
                    vehicle.body = 1000
                    vehicle.engine = 1000
                end
            else
                vAZ.temp.list[user_id] = vRP.query("vAZ/GetPlayerVehicles", {user_id = user_id})
                for id,vehicle in pairs(vAZ.temp.list[user_id]) do
                    local data = vAZ.getServerVehicle('model', vehicle.model)
                    if data ~= nil then
                        vehicle.name = data.name
                        vehicle.image = data.image
                        vehicle.class = data.class
                        vehicle.type = data.type
                        vehicle.tax = parseInt(vehicle.time)
                        vehicle.description = data.description
                        vehicle.time = parseInt(os.time())

                        if vehicle.state == 2 then
                            vehicle.fare = parseInt(data.price * vAZ.config.seized)
                        elseif vehicle.state == 3 then
                            vehicle.fare = parseInt(data.price * vAZ.config.stolen)
                        end
                    end
                end
            end
        end
    elseif type == 'personal' or type == 'home' then
        vAZ.temp.list[user_id] = vRP.query("vAZ/GetPlayerVehicles", {user_id = user_id})
        for id,vehicle in pairs(vAZ.temp.list[user_id]) do
            local data = vAZ.getServerVehicle('model', vehicle.model)
            if data ~= nil then
                vehicle.name = data.name
                vehicle.image = data.image
                vehicle.class = data.class
                vehicle.type = data.type
                vehicle.tax = parseInt(vehicle.time)
                vehicle.description = data.description
                vehicle.time = parseInt(os.time())

                if vehicle.state == 2 then
                    vehicle.fare = parseInt(data.price * vAZ.config.seized)
                elseif vehicle.state == 3 then
                    vehicle.fare = parseInt(data.price * vAZ.config.stolen)
                end
            end
        end
    end

    for id,vehicle in pairs(vAZ.temp.list[user_id]) do
        if registration == vehicle.plate and vAZ.getUserVehicle(user_id, vehicle.model) or vAZ.getUserVehicle(user_id, vehicle.plate) and vAZ.getUserVehicle(user_id, vehicle.model) then
            vehicle.state = 1
        end
        if availables == nil then
            table.insert(vAZ.temp.vehicles[user_id], vehicle)
        else
            for aid,available in pairs(availables) do
                if available == vehicle.type then
                    table.insert(vAZ.temp.vehicles[user_id], vehicle)
                    break
                end
            end
        end
    end

    return vAZ.temp.vehicles[user_id]
end

vAZ.getUserVehicle = function(user_id, value)
    for user,vehicles in pairs(vAZ.user.vehicles) do       
        if user == user_id then
            for id,vehicle in pairs(vehicles) do
                if vehicle.model == value or vehicle.plate == value or vehicle.id == value or vehicle.net == value then
                    return true, vehicle
                end
            end
        end
    end
    return false, nil
end

vAZ.getVehicle = function(value)
    for user,vehicles in pairs(vAZ.user.vehicles) do       
        for id,vehicle in pairs(vehicles) do
            if vehicle.plate == value or vehicle.id == value or vehicle.net == value then
                return true, vehicle
            end
        end
    end
    return false, nil
end

vAZ.getServerVehicleByPlate = function(plate)
    local vehicle = vRP.query("vAZ/GetPlayerVehiclePlate", {plate = plate})    
	if #vehicle > 0 then
		return vehicle[1]
    end
    return nil
end

vAZ.spawnUserVehicle = function(model, plate, garage)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.user.vehicles[user_id] == nil then
        vAZ.user.vehicles[user_id] = {}
    end
    if vAZ.user.cooldown[user_id] == nil then
        vAZ.user.cooldown[user_id] = 0
    end
    local identity = vRP.getUserIdentity(user_id)
    local registration = identity.registration:gsub("% ", "")
    if vAZ.user.cooldown[user_id] > 0 then
        TriggerClientEvent('Notify', source, 'negado', 'Aguarde '..vAZ.user.cooldown[user_id]..' segundos.')
        return false
    end
    local server_garage = vAZ.getServerGarage(garage.type, garage.id)
    if server_garage ~= nil then
        vAZ.user.cooldown[user_id] = 3
        if vAZ.config.fines then
            if (parseInt(json.decode(vRP.getUData(user_id, "vRP:multas"))) or 0) > 0 then
                TriggerClientEvent('Notify', source, 'negado', 'Você tem multas pendentes.')
                return
            end
        end
        local street,id,net = vAZclient.checkVehicleAlreadyOnStreet(source, model, plate)
        if not street then
            if registration == plate and not vAZ.getUserVehicle(user_id, model) or not vAZ.getUserVehicle(user_id, plate) and not vAZ.getUserVehicle(user_id, model) then
                if server_garage.permission ~= nil and not vRP.hasPermission(user_id, server_garage.permission) then
                    return
                end
                if server_garage.price ~= nil and server_garage.price > vRP.getMoney(user_id) and server_garage.price > vRP.getBankMoney(user_id) then
                    TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro.')
                    return
                end
                local identity = vRP.getUserIdentity(user_id)
                if registration == plate then
                    if server_garage.price ~= nil and not vRP.tryFullPayment(user_id, server_garage.price) then
                        TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro.')
                        return false
                    end
                    local created,id,net = vAZclient.spawnGarageVehicle(source, model, plate, 1000, 1000, 100, {})
                    if created then
                        table.insert(vAZ.user.vehicles[user_id], {owner = user_id, id = id, net = net, model = model, plate = registration, type = garage.type})
                        TriggerClientEvent('Notify', source, 'sucesso', 'Veículo retirado com sucesso!')
                        return true
                    end
                else
                    for id,vehicle in pairs(vAZ.temp.vehicles[user_id]) do
                        if vehicle.model == model and vehicle.plate == plate then
                            if vehicle.state == 2 then
                                TriggerClientEvent('Notify', source, 'sucesso', 'Veículo na detenção!', 10000)
                                return false
                            elseif vehicle.state == 3 then
                                TriggerClientEvent('Notify', source, 'sucesso', 'Veículo na retenção!', 10000)
                                return false
                            end
                            if not vRP.hasPermission(user_id, 'platina.permissao') then
                                if parseInt(os.time()) > parseInt(vehicle.ipva + 24 * 15 * 60 * 60) then
                                    TriggerClientEvent("Notify", source, "negado", "O IPVA do seu veículo está atrasado.", 10000)
                                    return false
                                end
                            end
                            if server_garage.price ~= nil and not vRP.tryFullPayment(user_id, server_garage.price) then
                                TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro.')
                                return false
                            end
                            local created,id,net = vAZclient.spawnGarageVehicle(source, model, plate, parseInt(vehicle.engine), parseInt(vehicle.body), parseInt(vehicle.fuel), json.decode(vehicle.tuning))
                            if created then
                                table.insert(vAZ.user.vehicles[user_id], {owner = user_id, id = id, net = net, model = model, plate = plate, type = garage.type})
                                if garage.type == 'personal' or garage.type == 'home' then
                                    vRP.execute("vAZ/SetPlayerStateVehicle", {user_id = user_id, model = model, state = 1})
                                end
                                return true
                            end
                        end
                    end
                end
            else
                local id,net,model = vAZclient.getVehicleAlreadyOnStreet(source, model, plate)
                if id ~= nil then
                    table.insert(vAZ.user.vehicles[user_id], {owner = user_id, id = id, net = net, model = model, plate = plate, type = garage.type})
                    TriggerClientEvent('Notify', source, 'negado', 'Veículo realocado, feche e tente novamente.')
                end
                TriggerClientEvent('Notify', source, 'negado', 'Seu veículo já se encontra na rua.')
                print('[az-garages] you already have a vehicle of this model is with this sign out of the garage.') 
            end
        else
            local id,net,model = vAZclient.getVehicleAlreadyOnStreet(source, model, plate)
            if id ~= nil then
                table.insert(vAZ.user.vehicles[user_id], {owner = user_id, id = id, net = net, model = model, plate = plate, type = garage.type})
                TriggerClientEvent('Notify', source, 'negado', 'Veículo realocado, feche e tente novamente.')
            end
            TriggerClientEvent('Notify', source, 'negado', 'Seu veículo já se encontra na rua.')
            print('[az-garages] vehicle in street', user_id, model, plate)
        end
    else
        TriggerClientEvent('Notify', source, 'negado', 'Garagem não encontrada.')
        print('[az-garages] failed to get garage', json.encode(garage), model, plate)
    end
    return false
end

vAZ.despawnUserVehicle = function(model, plate)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.user.cooldown[user_id] > 0 then
        TriggerClientEvent('Notify', source, 'negado', 'Aguarde '..vAZ.user.cooldown[user_id]..' segundos.')
        return false
    end
    local spawned, vehicle = vAZ.getUserVehicle(user_id, model)
    if spawned then
        vAZ.user.cooldown[user_id] = 3
        if vAZclient.vehicleInAreaCabin(source, vehicle.net, 25) then
            local occupants = vAZclient.getVehicleOccupants(source, true, vehicle.net) or {}
            if #occupants <= 0 then
                local street = vAZclient.checkVehicleAlreadyOnStreet(source, model, plate)
                if street then
                    if vehicle.type == 'personal' or vehicle.type == 'home' then
                        local status,engine,body,fuel = vAZclient.getVehicleEngine(source, vehicle.net)
                        if status then
                            vRP.execute("vAZ/SetPlayerStateVehicle", { user_id = user_id, model = model, state = 0 })
                            vRP.execute("vAZ/SetPlayerSpecificVehicle", { user_id = user_id, model = model, engine = engine, body = body, fuel = fuel })
                        end
                    end
                    TriggerClientEvent('az-garages:deletevehicle', source, vehicle.id)
                end
                for id,vehicle in pairs(vAZ.user.vehicles[user_id]) do
                    if vehicle.model == model and vehicle.plate == plate then
                        table.remove(vAZ.user.vehicles[user_id], id)
                    end
                end
                TriggerEvent('az-inventory:deleteTempTrunk', plate)
                TriggerClientEvent('Notify', source, 'sucesso', 'Veículo guardado com sucesso!')
                return true
            else
                TriggerClientEvent('Notify', source, 'aviso', 'Ainda tem alguem no véiculo!')   
            end
        else
            TriggerClientEvent('Notify', source, 'aviso', 'Veiculo fora de alcance!')
        end
    end
    return false
end

vAZ.forceDespawnUserVehicle = function(source, entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local garage = false
    for user,vehicles in pairs(vAZ.user.vehicles) do
        for id,vehicle in pairs(vehicles) do
            if parseInt(vehicle.id) == parseInt(entity) then
                garage = true
                if vAZclient.checkVehicleAlreadyOnStreet(source, vehicle.model, vehicle.plate) then
                    if vehicle.type == 'personal' or vehicle.type == 'home' then
                        local status,engine,body,fuel = vAZclient.getVehicleEngine(source, vehicle.net)
                        if status then
                            vRP.execute("vAZ/SetPlayerStateVehicle", { user_id = vehicle.owner, model = vehicle.model, state = 0 })
                            vRP.execute("vAZ/SetPlayerSpecificVehicle", { user_id = vehicle.owner, model = vehicle.model, engine = engine, body = body, fuel = fuel })
                        end
                    end
                    TriggerEvent('az-inventory:deleteTempTrunk', vehicle.plate)
                    TriggerClientEvent('az-garages:deletevehicle', source, vehicle.id)
                end
                table.remove(vAZ.user.vehicles[user], id)
            end
        end
    end
    if not garage then
        TriggerClientEvent('az-garages:deletevehicle', source, entity)
    end
end

vAZ.fareUserVehicle = function(model, plate)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.user.cooldown[user_id] > 0 then
        TriggerClientEvent('Notify', source, 'negado', 'Aguarde '..vAZ.user.cooldown[user_id]..' segundos.')
        return false
    end
    local data = vAZ.getServerVehicle('model', model)
    if data ~= nil then
        vAZ.user.cooldown[user_id] = 3
        local vehicle = vAZ.getServerVehicleByPlate(plate)
        if vehicle ~= nil then
            if vehicle.ipva == 0 or parseInt(os.time()) > parseInt(vehicle.ipva + 24 * 15 * 60 * 60) then
                local price = parseInt(data.price * vAZ.config.ipva)
                local ok = vRP.request(source, "Pagar o IPVA do veículo "..data.name.." <b>R$"..vRP.format(price).."</b> ?", 60)
                if ok then
                    if vRP.tryFullPayment(vehicle.user_id, price) then
                        vRP.execute("vAZ/SetPlayerIpvaVehicle", { model = model, ipva = os.time(), plate = plate })
                        TriggerClientEvent('Notify', source, 'sucesso', "IPVA pago com sucesso.")
                        return true
                    else
                        TriggerClientEvent('Notify', source, 'aviso', "Você não tem $"..vRP.format(price))
                    end
                end
            else
                if vehicle.state == 2 then
                    local price = parseInt(data.price * vAZ.config.seized)
                    local ok = vRP.request(source, "Veículo na detenção, deseja liberar pagando <b>$"..vRP.format(price).."</b> ?", 60)
                    if ok then
                        if vRP.tryFullPayment(vehicle.user_id, price) then
                            vRP.execute("vAZ/SetPlayerFareVehicle", { user_id = vehicle.user_id, plate = vehicle.plate, state = 0, time = 0 })
                            TriggerClientEvent('Notify', source, 'sucesso', "Veículo retirado da detenção.")
                            return true
                        else
                            TriggerClientEvent('Notify', source, 'aviso', "Você não tem $"..vRP.format(price))
                        end
                    end                
                elseif vehicle.state == 3 then
                    if parseInt(os.time()) >= parseInt(vehicle.time + 24 * 60 * 60) then
                        local price = parseInt(data.price * vAZ.config.stolen)
                        local ok = vRP.request(source, "Veículo na retenção, deseja acionar o seguro pagando <b>$"..vRP.format(price).."</b> ?", 60)
                        if ok then
                            if vRP.tryFullPayment(vehicle.user_id, price) then
                                vRP.execute("vAZ/SetPlayerFareVehicle", { user_id = vehicle.user_id, plate = vehicle.plate, state = 0, time = 0 })
                                TriggerClientEvent('Notify', source, 'sucesso', "Seguro coberto, o veículo já está liberado.")
                                return true
                            else
                                TriggerClientEvent('Notify', source, 'aviso', "Você não tem $"..vRP.format(price))
                            end
                        end
                    else
                        TriggerClientEvent('Notify', source, 'importante', "A papelada do seguro está em processo, previsão: <b>"..os.date("%d/%m/%Y %I:%M %p", (vehicle.time + 24 * 60 * 60)).."<b>.")
                    end
                end
            end            
        end
    end
    return false
end

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if first_spawn then
        if vAZ.user.vehicles[user_id] == nil then
            vAZ.user.vehicles[user_id] = {}
        end
        if vAZ.user.cooldown[user_id] == nil then
            vAZ.user.cooldown[user_id] = 0
        end
        if vAZ.server.dropped[user_id] ~= nil then
            for id,vehicle in pairs(vAZ.user.vehicles[user_id]) do
                local street = vAZclient.checkVehicleAlreadyOnStreet(source, vehicle.model, vehicle.plate)
                if street then
                    local occupants = vAZclient.getVehicleOccupants(source, true, vehicle.net)
                    if #occupants <= 0 then
                        if vehicle.type == 'personal' or vehicle.type == 'home' then
                            local status,engine,body,fuel = vAZclient.getVehicleEngine(source, vehicle.net)
                            if status then
                                vRP.execute("vAZ/SetPlayerStateVehicle", { user_id = vehicle.owner, model = vehicle.model, state = 0 })
                                vRP.execute("vAZ/SetPlayerSpecificVehicle", { user_id = vehicle.owner, model = vehicle.model, engine = engine, body = body, fuel = fuel })
                            end
                        end
                        vAZclient.despawnVehicle(-1, vehicle.net)
                        table.remove(vAZ.user.vehicles[user_id], id)
                    end
                else
                    if vehicle.type == 'personal' or vehicle.type == 'home' then
                        vRP.execute("vAZ/SetPlayerStateVehicle", { user_id = vehicle.owner, model = vehicle.model, state = 0 })
                    end
                    table.remove(vAZ.user.vehicles[user_id], id)
                end
            end
            vAZ.server.dropped[user_id] = nil
        end
	end
end)

AddEventHandler('playerDropped', function (reason)
    if string.match(reason, "crash") then
        local source = source
        local user_id = vRP.getUserId(source)
        if vAZ.user.vehicles[user_id] then
            vAZ.server.dropped[user_id] = true
        end
        print('Player ' .. GetPlayerName(source) .. ' dropped (Reason: ' .. reason .. ')')
    end
end)

Citizen.CreateThread(function()
    while true do
        for user_id,time in pairs(vAZ.user.cooldown) do
            if time < 0 then
                vAZ.user.cooldown[user_id] = 0
            end
            if time > 0 then
                vAZ.user.cooldown[user_id] = time - 1
            end
        end
        Citizen.Wait(1000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOQUE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("vAZ/PurchaseVehicle", "INSERT IGNORE INTO vrp_user_vehicles(user_id,model,plate,ipva) VALUES(@user_id,@model,@plate,@ipva)")
vRP._prepare("vAZ/RemoveVehicle", "DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND model = @model")

RegisterCommand('estoque', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "owner.permissao") then
        if args[1] and args[2] then
            vAZ.addServerStockVehicle(args[1], parseInt(args[2]))
            TriggerClientEvent("Notify", source, "sucesso","Voce colocou mais <b>"..args[2].."</b> no estoque, para o carro <b>"..args[1].."</b>.") 
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcar',function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "owner.permissao") then		
		if args[1] and args[2] then
            local target_id = parseInt(args[2])
            local vehicle = vAZ.getServerVehicle('model', args[1])
            if vehicle ~= nil then
                local vehicle = vRP.query('vAZ/GetPlayerVehicleModel', {user_id = target_id, model = args[1]})
                if #vehicle <= 0 then
                    vRP.execute("vAZ/PurchaseVehicle", { user_id = target_id, model = args[1], plate = vAZ.generatePlate(), ipva = os.time() })
                    TriggerClientEvent("Notify", source, "sucesso", "Voce adicionou o veículo <b>"..args[1].."</b> para o passaporte: <b>"..target_id.."</b>.")
                else
                    TriggerClientEvent("Notify", source, "negado", "O passaporte "..target_id.." já tem esse veiculo na garagem.")
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Veiculo não encontrado na db (<b>"..args[1].."</b>).")
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REM CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcar',function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)    
    if vRP.hasPermission(user_id, "owner.permissao") then
        if args[1] and args[2] then
            local target_id = parseInt(args[2])
            local vehicle = vRP.query('vAZ/GetPlayerVehicleModel', {user_id = target_id, model = args[1]})
            if vehicle[1] then
                vRP.execute("vAZ/RemoveVehicle", { user_id = user_id, model = args[1] })
                TriggerClientEvent("Notify", source, "sucesso", "Voce removeu o veículo <b>"..args[1].."</b> do Passaporte: <b>"..target_id.."</b>.")
            else
                TriggerClientEvent("Notify", source, "negado", "O passaporte "..target_id.." não tem esse veiculo na garagem.")
            end
        end
    end
end)