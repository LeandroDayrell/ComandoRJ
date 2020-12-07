local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-garages')
vAZ = {}
Tunnel.bindInterface('az-garages', vAZ)

--[[
    car
    motorcycle
    truck
    helicopter
    boat
    jetsky
    plane
]]

vRP._prepare("vAZ/GetAllVehicless", "SELECT * FROM vrp_user_vehicles")
vRP._prepare("vAZ/GetAllVehicles", "SELECT * FROM vrp_vehicles")
vRP._prepare("vAZ/GetVehicles", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vAZ/GetVehicleModel", "SELECT * FROM vrp_vehicles WHERE model = @model")
vRP._prepare("vAZ/SetStateVehicle", "UPDATE vrp_user_vehicles SET state = @state WHERE user_id = @user_id AND model = @model")
vRP._prepare("vAZ/SetSpecificVehicle", "UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND model = @model")
vRP._prepare("vAZ/GetVehiclesByPlate", "SELECT * FROM vrp_user_vehicles WHERE plate = @plate")
vRP._prepare("vAZ/GetVehiclesByHash", "SELECT * FROM vrp_vehicles WHERE hash = @hash")
vRP._prepare("vAZ/SetStateVehicles", "UPDATE vrp_user_vehicles SET state = 0 WHERE state <= 2")
vRP._prepare("vAZ/SetModsVehicle", "UPDATE vrp_user_vehicles SET mods = @mods WHERE user_id = @user_id AND plate = @plate AND model = @model")
vRP._prepare("vAZ/GetVehicleByPlateModel", "SELECT * FROM vrp_user_vehicles WHERE plate = @plate AND model = @model")
vRP._prepare('vAZ/UpdateTunningVehicle', 'UPDATE vrp_user_vehicles SET tuning = @tuning WHERE plate = @plate')

vAZ.vehicles = {}

async(function()
    vRP.execute("vAZ/SetStateVehicles", {})
    local vehicles = vRP.query("vAZ/GetAllVehicles", {})
    if #vehicles > 0 then
        for id,vehicle in pairs(vehicles) do
            table.insert(vAZ.vehicles, { hash = parseInt(vehicle.hash), name = vehicle.model, label = vehicle.name, price = parseInt(vehicle.price), banido = vehicle.banned, type = vehicle.type, image = vehicle.image })
        end
    end
end)

vAZ.getAllVehicles = function()
    return vAZ.vehicles
end

vAZ.getDataVehicle = function(entry)
    for id,vehicle in pairs(vAZ.vehicles) do
        if vehicle.name == entry or vehicle.hash == entry then
            return vehicle
        end
    end
    return nil
end

 RegisterCommand('addcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
	if vRP.hasPermission(user_id,"blips.permissao") then
		if args[1] and args[2] then
			local nuser_id = vRP.getUserId(nplayer)
			local identity = vRP.getUserIdentity(user_id)
			local identitynu = vRP.getUserIdentity(nuser_id)
			vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], plate = vAZgarageClient.GeneratePlate(src) })
			--TriggerClientEvent("Notify",source,"sucesso","Voce adicionou o veículo <b>"..args[1].."</b> para o Passaporte: <b>"..parseInt(args[2]).."</b>.") 
		end
	end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if first_spawn then
        TriggerClientEvent('vrp:setVehicleList', source, vAZ.vehicles)
    end
end)

local vehicles = {}
local usersGarage = {}
local usersVehicles = {}

local vehiclesPolice = {
    { model = 'policiavictoria', name = 'Victoria', type = 'car', image = 'https://i.imgur.com/cTOjEks.png', engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
    { model = 'policiataurus', name = 'Taurus', type = 'car', image = 'https://i.imgur.com/wGqSDm7.png', engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
    { model = 'policiatahoe', name = 'Tahoe', type = 'car', image = 'https://i.imgur.com/sRS8slM.png', engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
    { model = 'policiasilverado', name = 'Silverado', type = 'car', image = 'https://i.imgur.com/qkojpBH.png', engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
    { model = 'policiaheli', name = 'Helicóptero', type = 'helicopter', image = 'https://i.imgur.com/HjZoFsf.png', engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
    { model = 'policiacharger2018', name = 'Charger 2018', type = 'car', image = 'https://i.imgur.com/2RoRIET.png', engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
    { model = 'pbus', name = 'PBus', type = 'bus', image = 'https://media.discordapp.net/attachments/700393043735609356/709639829398487050/unknown.png', engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
}
local vehiclesHospital = {
    { model = "paramedicoambu", name = "Ambulancia", type = "car", image = "https://i.imgur.com/8R2VIYP.png", engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
    { model = "policiabmwr1200", name = "BMW 1200", type = "motorcycle", image = "https://i.imgur.com/35DNGRb.png", engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
    { model = "paramedicoheli", name = "Helicóptero", type = "helicopter", image = "https://i.imgur.com/NNnF33c.png", engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },
}
local vehiclesMechanic = {
    { model = "flatbed", name = "Flatbed MTL", type = "truck", image = "https://i.pinimg.com/originals/f2/16/6b/f2166b09e35ad3b7f7f7d1c8b2912b11.png", engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },    
}
local vehiclesTrucker = {
    { model = "hauler", name = "Hauler", type = "truck", image = "https://wiki.gtanet.work/images/8/83/Hauler.png", engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },    
    { model = "phantom", name = "Phantom", type = "truck", image = "https://wiki.gtanet.work/images/e/ec/Phantom.png", engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },    
    { model = "phantom3", name = "Phantom3", type = "truck", image = "https://vignette.wikia.nocookie.net/gtawiki/images/7/70/PhantomCustom-GTAO-front.png/revision/latest?cb=20170621151532", engine = 1000, body = 1000, fuel = 100, plate = 'CDRJ', state = 0 },    
}

vAZ.hasPermission = function(permission)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, permission)
end

vAZ.VehicleService = function(model)
    for id,vehicle in pairs(vehiclesPolice) do
        if vehicle.model == model then
            return true
        end
    end
    for id,vehicle in pairs(vehiclesHospital) do
        if vehicle.model == model then
            return true
        end
    end
    for id,vehicle in pairs(vehiclesMechanic) do
        if vehicle.model == model then
            return true
        end
    end
    for id,vehicle in pairs(vehiclesTrucker) do
        if vehicle.model == model then
            return true
        end
    end
    return false
end

vAZ.getVehicles = function(data)
    local source = source
    local user_id = vRP.getUserId(source)

    usersGarage[tostring(user_id)] = {}
    usersVehicles[tostring(user_id)] = {}

    if data.type == 'service' then
        if vRP.hasPermission(user_id, "pmcar.permissao") then
            usersGarage[tostring(user_id)] = vehiclesPolice
        elseif vRP.hasPermission(user_id, "hqmc.permissao") then
            usersGarage[tostring(user_id)] = vehiclesHospital
        elseif vRP.hasPermission(user_id, "str.permissao") or vRP.hasPermission(user_id, "bennys.permissao") or vRP.hasPermission(user_id, "lsc.permissao") then    
            usersGarage[tostring(user_id)] = vehiclesMechanic
        end
    elseif data.type == 'personal' then
        usersGarage[tostring(user_id)] = vRP.query("vAZ/GetVehicles", {user_id = user_id})
        if #usersGarage[tostring(user_id)] > 0 then
            for id,vehicle in pairs(usersGarage[tostring(user_id)]) do
                local model = vAZ.getDataVehicle(vehicle.model)
                if model ~= nil then
                    vehicle.name = model.label
                    vehicle.type = model.type
                    vehicle.image = model.image
                    vehicle.price = model.price
                end
            end
        end
    end

    if #usersGarage[tostring(user_id)] > 0 then
        for id,vehicle in pairs(usersGarage[tostring(user_id)]) do
            if data.type == 'service' then
                vehicle.plate = vRP.getUserIdentity(user_id).registration:gsub("% ", "")
            end
            if vehicle.state < 3 then
                vehicle.state = 0
            end
            if vehicle.state == 3 then
                if vehicle.type == 'carsvip' or vehicle.type == 'motorcyclevip' then
                    vehicle.fare = parseInt(1500000 * 0.01)
                else
                    vehicle.fare = parseInt(vehicle.price * 0.02)
                end
            elseif vehicle.state == 4 then
                if vehicle.type == 'carsvip' or vehicle.type == 'motorcyclevip' then
                    vehicle.fare = parseInt(vehicle.price * 0.35)
                else
                    vehicle.fare = parseInt(vehicle.price * 0.20)
                end
            else
                vehicle.fare = 0
            end
            if vehicles[tostring(user_id)] ~= nil then
                for id,veh in pairs(vehicles[tostring(user_id)]) do
                    if veh.model == vehicle.model then
                        vehicle.state = 1
                    end
                end
            end
            if vehicle.type == 'carsvip' then
                vehicle.type = 'car'
            elseif vehicle.type == 'motorcyclevip' then
                vehicle.type = 'motorcycle'
            end
            if data.select == 'all' then
                for aid,available in pairs(data.availables) do
                    if available == vehicle.type then
                        table.insert(usersVehicles[tostring(user_id)], vehicle)
                        break
                    end
                end
            elseif data.select == 'motorcycle' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)
            elseif data.select == 'car' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)
            elseif data.select == 'helicopter' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)
            elseif data.select == 'boat' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)
            elseif data.select == 'jetsky' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)            
            end
        end
    end
    return usersVehicles[tostring(user_id)]
end

vAZ.vehicleService = function(model)
    return false
end

vAZ.spawnVehicle = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if vehicles[tostring(user_id)] == nil then
        vehicles[tostring(user_id)] = {}
    end
    local value = vRP.getUData(user_id, "vRP:multas")
    local multas = json.decode(value) or 0
    if multas >= 10000 then
        TriggerClientEvent('Notify', source, 'negado', "Você tem multas pendentes.")
        return
    end
    local street,id,net,model = vAZclient.CheckInStreet(source, data.model, data.plate)
    if not street then
        if not vAZ.VehicleInVehicles(user_id, data.model) then
            if data.plate == vRP.getUserIdentity(user_id).registration:gsub("% ", "") then
                local created,id,net,model,vhash = vAZclient.SpawnGarageVehicle(source, data.model, data.plate, data.engine, data.body, data.fuel, {})
                if created then
                    table.insert(vehicles[tostring(user_id)], {id = id, net = net, model = model, plate = vRP.getUserIdentity(user_id).registration:gsub("% ", "")})
                    TriggerClientEvent('Notify', source, 'sucesso', 'Veículo retirado com sucesso!')
                end
            else
                local fareSpawn = 100
                if #vehicles[tostring(user_id)] > 0 and #vehicles[tostring(user_id)] < 2 then
                    fareSpawn = 370
                elseif #vehicles[tostring(user_id)] > 2 and #vehicles[tostring(user_id)] < 5 then
                    fareSpawn = 770
                elseif #vehicles[tostring(user_id)] > 5 then
                    fareSpawn = 1500
                end
                if vRP.tryPayment(user_id, fareSpawn) then
                    local vehicle = vRP.query("vAZ/GetVehiclesByPlate", {plate = data.plate})
                    if #vehicle > 0 then
                        local mods = json.decode(vehicle[1].tuning) or {}
                        if type(mods) ~= 'table' then mods = {} end
                        local created,id,net,model,vhash = vAZclient.SpawnGarageVehicle(source, data.model, data.plate, data.engine, data.body, data.fuel, mods)
                        if created then
                            table.insert(vehicles[tostring(user_id)], {id = id, net = net, model = model, plate = data.plate})
                            if not vAZ.vehicleService(data.model) then
                                vRP.execute("vAZ/SetStateVehicle", {user_id = user_id, model = data.model, state = 1})
                            end
                            TriggerClientEvent('Notify', source, 'sucesso', 'Veículo retirado com sucesso, Tarifa: R$ <b>'..fareSpawn..'</b>!')                            
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro.')
                end
            end
        else
            table.insert(vehicles[tostring(user_id)], {id = id, net = net, model = model, plate = data.plate})
            TriggerClientEvent('Notify', source, 'Parking', "Você já tem um veículo deste modelo fora da garagem")
        end
    else
        vRP.execute("vAZ/SetStateVehicle", {user_id = user_id, model = model, state = 1})
        table.insert(vehicles[tostring(user_id)], {id = id, net = net, model = model, plate = data.plate})
        TriggerClientEvent('Notify', source, 'importante', "Seu veículo já está fora da garagem")
    end
end

vAZ.despawnVehicle = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if vehicles[tostring(user_id)] == nil then
        vehicles[tostring(user_id)] = {}
    end
    local spawned, vehicle = vAZ.VehicleInVehicles(user_id, data.model)
    if spawned then
        --local occupants = vAZclient.GetVehicleOccupants(source, true, vehicle.net) or {}
        --if #occupants <= 0 then
            local street,id,net,model = vAZclient.CheckInStreet(source, data.model, data.plate)
            if street then
                if not vAZ.vehicleService(data.model) then
                    local engine,body,fuel = vAZclient.GetVehicleEngine(source, vehicle.net)
                    vRP.execute("vAZ/SetStateVehicle", { user_id = user_id, model = data.model, state = 0})
                    vRP.execute("vAZ/SetSpecificVehicle", { user_id = user_id, model = data.model, engine = engine, body = body, fuel = fuel })
                end
            end
            if vehicles[tostring(user_id)] ~= nil then
                for id,vehicle in pairs(vehicles[tostring(user_id)]) do
                    if vehicle.model == data.model then
                        table.remove(vehicles[tostring(user_id)], id)
                    end
                end
            end
            vAZclient.despawnVehicle(-1, vehicle.net)
            TriggerClientEvent('Notify', source, 'sucesso', 'Veículo guardado com sucesso!')
        --else
        --    TriggerClientEvent('Notify', source, 'aviso', 'Ainda tem alguem no véiculo!')            
        --end
    else
        local street,id,net,model = vAZclient.CheckInStreet(source, data.model, data.plate)
        if street then
            table.insert(vehicles[tostring(user_id)], {id = id, net = net, model = model, plate = data.plate})
            TriggerClientEvent('Notify', source, 'importante', 'Seu véiculo já foi retirado, qualquer coisa acione o seguro!')
        else
            if not vAZ.vehicleService(data.model) then
                vRP.execute("vAZ/SetStateVehicle", { user_id = user_id, model = data.model, state = 0})
            end
        end
    end
end

vAZ.fareVehicle = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    local owner = vRP.query("vAZ/GetVehiclesByPlate", {plate = data.plate})
    if #owner > 0 then
        local model = vAZ.getDataVehicle(owner[1].model)
        if model ~= nil then
            if owner[1].state == 3 then
                local ok = vRP.request(source, "Veículo na detenção, deseja liberar pagando <b>R$"..vRP.format(parseInt(model.price * 0.1)).."</b> ?", 60)
                if ok then
                    if vRP.tryPayment(user_id, parseInt(model.price * 0.1)) then
                        vRP.execute("vAZ/SetStateVehiclePM", { user_id = owner[1].user_id, plate = owner[1].plate, state = 0, time = 0 })
                        TriggerClientEvent('Notify', source, 'sucesso', "Veículo retirado da detenção.")
                        return true
                    else
                        TriggerClientEvent('Notify', source, 'aviso', "Você não tem R$"..vRP.format(parseInt(model.price * 0.1)))
                    end
                end                
            elseif owner[1].state == 4 then
                if parseInt(os.time()) >= parseInt(owner[1].time + 2 * 60 * 60) then
                    local ok = vRP.request(source, "Veículo na retenção, deseja acionar o seguro pagando <b>R$"..vRP.format(parseInt(model.price * 0.2)).."</b> ?", 60)
                    if ok then
                        if vRP.tryPayment(owner[1].user_id, parseInt(model.price * 0.2)) then
                            vRP.execute("vAZ/SetStateVehiclePM", { user_id = owner[1].user_id, plate = owner[1].plate, state = 0, time = 0 })
                            TriggerClientEvent('Notify', source, 'sucesso', "Seguro coberto, o veículo já está liberado.")
                            return trues
                        else
                            TriggerClientEvent('Notify', source, 'aviso', "Você não tem R$"..vRP.format(parseInt(model.price * 0.2)))
                        end
                    end                    
                else
                    TriggerClientEvent('Notify', source, 'importante', "A papelada do seguro está em processo, Previsão: <b>"..os.date("%d/%m/%Y %I:%M %p", (owner[1].time+2*60*60)).."<b>.")
                end
            end
        end
    end
    return false
end

vAZ.getInVehiclesByPlate = function(plate)
    local source = source
    local user_id = vRP.getUserId(source)
    if vehicles[tostring(user_id)] ~= nil then
        for id,vehicle in pairs(vehicles[tostring(user_id)]) do
            if vehicle.plate == plate then
                return vehicle
            end
        end
    end
    return nil
end

vAZ.GetMyVehicles = function(data, garage)
    local source = source
    local user_id = vRP.getUserId(source)
    usersGarage[tostring(user_id)] = {}
    usersVehicles[tostring(user_id)] = {}
    if data.type == 'service' then
        if garage.name == "Caminhões de Carga" then
            usersGarage[tostring(user_id)] = vehiclesTrucker
        else
            if vRP.hasPermission(user_id, "pm.permissao") then
                usersGarage[tostring(user_id)] = vehiclesPolice
            elseif vRP.hasPermission(user_id, "fbi.permissao") then
                usersGarage[tostring(user_id)] = vehiclesFBI
            elseif vRP.hasPermission(user_id, "samu.permissao") then
                usersGarage[tostring(user_id)] = vehiclesHospital
            elseif vRP.hasPermission(user_id, "str.permissao") or vRP.hasPermission(user_id, "bennys.permissao") or vRP.hasPermission(user_id, "lsc.permissao") then    
                usersGarage[tostring(user_id)] = vehiclesMechanic
            end
        end
    elseif data.type == 'personal' then
        usersGarage[tostring(user_id)] = vRP.query("vAZ/GetVehicles", {user_id = user_id})        
        if #usersGarage[tostring(user_id)] > 0 then
            for id,vehicle in pairs(usersGarage[tostring(user_id)]) do
                local model = vRP.query("vAZ/GetVehicleModel", {model = vehicle.model})
                if #model > 0 then
                    vehicle.name = model[1].name
                    vehicle.type = model[1].type
                    vehicle.photos = model[1].photos
                    vehicle.price = model[1].price
                end
            end
        end
    end
    if #usersGarage[tostring(user_id)] > 0 then
        for id,vehicle in pairs(usersGarage[tostring(user_id)]) do
            if data.type == 'service' then
                vehicle.plate = vRP.getUserIdentity(user_id).registration:gsub("% ", "")                
            end
            if vehicle.state < 3 then
                vehicle.state = 0
            end
            if vehicle.state == 3 then
                if vehicle.type == 'carsvip' or vehicle.type == 'motorcyclevip' then
                    vehicle.fare = parseInt(1500000 * 0.01)
                else
                    vehicle.fare = parseInt(vehicle.price * 0.02)
                end
            elseif vehicle.state == 4 then
                if vehicle.type == 'carsvip' or vehicle.type == 'motorcyclevip' then
                    vehicle.fare = parseInt(vehicle.price * 0.35)
                else
                    vehicle.fare = parseInt(vehicle.price * 0.20)
                end
            else
                vehicle.fare = 0
            end
            if vehicles[tostring(user_id)] ~= nil then
                for id,veh in pairs(vehicles[tostring(user_id)]) do
                    if veh.model == vehicle.model then
                        vehicle.state = 1
                    end
                end
            end
            if vehicle.type == 'carsvip' then
                vehicle.type = 'car'
            elseif vehicle.type == 'motorcyclevip' then
                vehicle.type = 'motorcycle'
            end
            if data.select == 'all' then                
                for aid,available in pairs(data.availables) do                    
                    if available == vehicle.type then
                        table.insert(usersVehicles[tostring(user_id)], vehicle)
                        break
                    end
                end
            elseif data.select == 'motorcycle' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)
            elseif data.select == 'car' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)
            elseif data.select == 'boat' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)
            elseif data.select == 'jetsky' and data.select == vehicle.type then
                table.insert(usersVehicles[tostring(user_id)], vehicle)            
            end
        end
    end
    return usersVehicles[tostring(user_id)]
end

vAZ.VehicleInVehicles = function(user_id, model)
    for user,items in pairs(vehicles) do       
        if parseInt(user) == user_id then
            for _,vehicle in pairs(items) do
                if vehicle.model == model then
                    return true, vehicle
                end
            end
        end
    end
    return false, nil
end

vAZ.CheckPlate = function(plate)
    if plate == nil then 		
		return false,nil
	end
	local source = source
	local user_id = vRP.getUserId(source)
    local vehicle = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})    
	if #vehicle > 0 then
		return true, vehicle[1]
    else
        return false, nil
    end
end

vAZ.ToggleVehicleLock = function(client, hash, plate)    
    local source = source
    local user_id = vRP.getUserId(source)    
    if vRP.getUserIdentity(user_id).registration == plate:gsub("% ", "") then
        vAZclient.ToggleVehicleLock(source, client)
        TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
    else
        local vehicle = vAZ.GetVehicleBy(hash, 'hash')
        if vehicle ~= nil then
            local status,details = vAZ.CheckPlate(plate)
            if status and details.model == vehicle.model then
                if details.user_id == user_id then
                    vAZclient.ToggleVehicleLock(source, client)
                    TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
                end
            end
        end
    end    
end

vAZ.ToggleLock = function(vehicle)
    vAZclient.ToggleLock(-1, vehicle)
end

vAZ.GetVehicleBy = function(data, column)
    if column == 'hash' then
        local vehicle = vRP.query("vAZ/GetVehiclesByHash", {hash = data})    
        if #vehicle > 0 then
            return vehicle[1]
        else
            return {}
        end
    elseif column == 'model' then
        local vehicle = vRP.query("vAZ/GetVehicleByModel", {model = data})    
        if #vehicle > 0 then
            return vehicle[1]
        else
            return {}
        end
    end
end

RegisterServerEvent("az-garages:deleteVehicle")
AddEventHandler("az-garages:deleteVehicle", function(source, veh)
    local netveh = vAZclient.GetVehicleNet(source, veh)
    if netveh ~= nil then
        for user_id,user_vehicles in pairs(vehicles) do
            for id,vehicle in pairs(user_vehicles) do
                if vehicle.net == netveh then
                    local engine,body,fuel = vAZclient.GetVehicleEngine(source, vehicle.net)
                    vRP.execute("vAZ/SetStateVehicle", { user_id = user_id, model = vehicle.model, state = 0})
                    vRP.execute("vAZ/SetSpecificVehicle", { user_id = user_id, model = vehicle.model, engine = engine, body = body, fuel = fuel })
                    table.remove(vehicles[user_id], id)
                end
            end
        end
        vAZclient.despawnVehicle(-1, netveh)
    end
end)

RegisterServerEvent("az-garages:deleteVehicleArr")
AddEventHandler("az-garages:deleteVehicleArr", function(despawn)
    for user,vehs in pairs(vehicles) do
        for id,vehicle in pairs(vehs) do
            if parseInt(vehicle.net) == parseInt(despawn) then
                table.remove(vehicles[tostring(user)], id)
            end
        end
    end
end)

--[[
RegisterCommand('gtunning', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local vehicles = vRP.query("vAZ/GetAllVehicless", {})
    print('starting...')
    if #vehicles > 0 then
        for id,vehicle in pairs(vehicles) do
            local custom = vRP.getSData("custom:u"..vehicle.user_id.."veh_"..vehicle.model)            
            if custom ~= '' and custom ~= nil then
                vRP.execute('vAZ/UpdateTunningVehicle', {plate = vehicle.plate, tuning = custom})
                print('ID: ' .. vehicle.user_id .. ' - Vehicle: ' .. vehicle.model .. ' - Plate: ' .. vehicle.plate)
            end
        end
    end
    print('the end')
end)
]]--