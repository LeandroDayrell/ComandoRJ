local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vAZserver = Tunnel.getInterface('az-garages')
vAZ = {}
Tunnel.bindInterface('az-garages', vAZ)

vAZ.player = {
    ped = function()
        return PlayerPedId()
    end
}

Citizen.CreateThread(function()	
	while true do
		local thread = 1000
		local plyPed = vAZ.player.ped()
		if not IsPedInAnyVehicle(plyPed, false) then
			local plyCoords = GetEntityCoords(plyPed)
            for type,garages in pairs(vAZ.config.garages) do
                for id,garage in pairs(garages) do
                    for key,value in pairs(garage.point) do
                        local distance = #(plyCoords - vector3(value.x, value.y, value.z))
                        if distance < 6 then
                            thread = 1
                            if distance <= 5 then
                                DrawMarker(garage.marker, value.x, value.y, value.z - 0.80, 0,0, 0,0, 0,0, 0.2, 0.2, 0.2, vAZ.config.marker.r, vAZ.config.marker.g, vAZ.config.marker.b, 40, 1, 0, 0, 0)
                                DrawMarker(23, value.x, value.y, value.z - 0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, vAZ.config.marker.r, vAZ.config.marker.g, vAZ.config.marker.b, 35, 0, 0, 0, 0)
                            end
                            if distance <= 1 then
                                if IsControlJustPressed(0, 38) then
                                    if type == 'personal' then
                                        SetNuiFocus(true, true)
                                        SetTimecycleModifier('hud_def_blur')
                                        SendNUIMessage({action = "open", vehicles = vAZserver.getUserGarageVehicles(type, id, garage.availables), garage = json.encode({type = type, id = id})})
                                    elseif type == 'home' then
                                        if not vAZserver.homePermission(garage.name) then
                                            TriggerEvent('Notify', 'negado', "Você não tem permissão para acessar essa garagem.")
                                            break
                                        end
                                        SetNuiFocus(true, true)
                                        SetTimecycleModifier('hud_def_blur')
                                        SendNUIMessage({action = "open", vehicles = vAZserver.getUserGarageVehicles(type, id), garage = json.encode({type = type, id = id})})
                                    else
                                        local data = vAZserver.getServerGarage(type, id)
                                        if data ~= nil then
                                            if data.permission ~= nil and not vAZserver.hasPermission(data.permission) then
                                                TriggerEvent('Notify', 'negado', "Você não tem permissão para acessar essa garagem.")
                                                break
                                            end
                                            SetNuiFocus(true, true)
                                            SetTimecycleModifier('hud_def_blur')
                                            SendNUIMessage({action = "open", vehicles = vAZserver.getUserGarageVehicles(type, id), garage = json.encode({type = type, id = id})})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(thread)
	end
end)

Citizen.CreateThread(function()
	for garage,details in pairs(vAZ.config.garages.personal) do
		if details.blip.id == nil then
			for key,value in pairs(details.point) do
                details.blip.id = AddBlipForCoord(value.x, value.y, value.z)
                SetBlipSprite(details.blip.id, details.blip.type)
                SetBlipColour(details.blip.id, details.blip.color)
                SetBlipScale(details.blip.id, details.blip.scale)
                SetBlipAsShortRange(details.blip.id, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('Garagem')
                EndTextCommandSetBlipName(details.blip.id)
			end
		end
	end
end)

RegisterNUICallback('spawn', function(data, cb)
    cb(vAZserver.spawnUserVehicle(data.model, data.plate, data.garage))
end)

RegisterNUICallback('despawn', function(data, cb)
    cb(vAZserver.despawnUserVehicle(data.model, data.plate, data.garage))
end)

RegisterNUICallback('fare', function(data, cb)
    cb(vAZserver.fareUserVehicle(data.model, data.plate, data.garage))
end)

RegisterNUICallback('update', function(data, cb)
    --SendNUIMessage({action = "update", vehicles = {}})
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    SetTimecycleModifier('default')
    SendNUIMessage({action = 'close'})
end)