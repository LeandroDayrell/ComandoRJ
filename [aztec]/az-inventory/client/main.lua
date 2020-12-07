local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vAZserver = Tunnel.getInterface("az-inventory")
vAZ = {}
Tunnel.bindInterface("az-inventory", vAZ)

vAZ.nui = false
vAZ.data = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, vAZ.config.keys.player) and not vAZ.nui then
            if not vRP.isInComa() and not vRP.isHandcuffed() then                
                local source = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
                SendNUIMessage({action = "update", type = 'player', entity = source, inventory = vAZserver.getPlayerInventory(source)})                
                SetTimecycleModifier('hud_def_blur')
                SetNuiFocus(true, true)
                SendNUIMessage({action = "open"})
                vAZ.nui = true
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
        if IsControlJustReleased(0, vAZ.config.keys.vehicle) and not vAZ.nui then
            if not vRP.isInComa() and not vRP.isHandcuffed() then
                local ply = PlayerPedId()
                local plyCoords = GetEntityCoords(ply)
                local vehicle = vRP.getNearestVehicle(5)
                local source = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ply))
                if IsEntityAVehicle(vehicle) and GetVehicleDoorLockStatus(vehicle) <= 1 then
                    local vehicleClass = GetVehicleClass(vehicle)
                    local boot = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'boot'))
                    local bootDistance = #(plyCoords - boot)
                    local exhaust = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'exhaust'))
                    local exhaustDistance = #(plyCoords - exhaust)
                    if vehicleClass == 19 or vehicleClass == 20 or bootDistance <= 1.5 or bootDistance <= 1 and exhaustDistance <= 2 or bootDistance > 1000 and exhaustDistance <= 1 or exhaustDistance <= 1 then
                        vAZ.nui = true
                        SendNUIMessage({action = "update", type = 'player', entity = source, inventory = vAZserver.getPlayerInventory(source)})
                        SendNUIMessage({action = "update", type = 'vehicle', entity = vehicle, inventory = vAZserver.getVehicleInventory(GetVehicleNumberPlateText(vehicle), GetEntityModel(vehicle))})                        
                        SetTimecycleModifier('hud_def_blur')
                        SetNuiFocus(vAZ.nui, vAZ.nui)
                        SendNUIMessage({action = "open"})
                        vAZ.data = {type = 'vehicle', entity = vehicle}
                        TriggerServerEvent("az-inventory:trunk", VehToNet(vehicle))
                    end
                end
            end
		end
    end
end)

Citizen.CreateThread(function()
    while vAZ.config.debug do
        Citizen.Wait(0)
        local vehicle = vRP.getNearestVehicle(10)
        if vehicle ~= nil then
            local ply = PlayerPedId()
            local plyCoords = GetEntityCoords(ply)
            for id,part in pairs({'boot', 'exhaust'}) do
                local trunkCoords = GetWorldPositionOfEntityBone(tonumber(vehicle), GetEntityBoneIndexByName(vehicle, part))
                local distance = #(plyCoords - trunkCoords)                
                vAZ.DrawText3D(trunkCoords.x, trunkCoords.y, trunkCoords.z, '~r~Entity: ~w~'..vehicle..'~w~ - ~r~Class: ~w~'..GetVehicleClass(vehicle)..'~w~ - ~r~Part: ~w~'..part..'~w~ - ~r~Distance: ~w~'..math.ceil(distance))
            end            
        end
    end
end)

RegisterNetEvent('az-inventory:home')
AddEventHandler('az-inventory:home', function(owner_id, name)
    if not vAZ.nui then
        local source = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
        if not vRP.isInComa() and not vRP.isHandcuffed() then
            vAZ.nui = true
            SendNUIMessage({action = "update", type = 'player', entity = source, inventory = vAZserver.getPlayerInventory(source)})
            SendNUIMessage({action = "update", type = 'home', entity = name..':'..owner_id, inventory = vAZserver.getHomeInventory(owner_id, name)})            
            SetTimecycleModifier('hud_def_blur')
            SetNuiFocus(vAZ.nui, vAZ.nui)
            SendNUIMessage({action = "open"})
            vAZ.data = {type = 'home', entity = name..':'..owner_id}
        end
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
        if IsControlJustReleased(0, vAZ.config.keys.inspect) and not vAZ.nui then
            if not vRP.isInComa() and not vRP.isHandcuffed() then
                local player = vRP.getNearestPlayer(1.5)
                local source = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
                if vAZserver.playerIsInComa(player) or vAZserver.playerHasPermission(source, player) or vAZserver.playerInspect(player) then
                    vAZ.nui = true
                    SendNUIMessage({action = "update", type = 'player', entity = source, inventory = vAZserver.getPlayerInventory(source)})
                    SendNUIMessage({action = "update", type = 'inspect', entity = player, inventory = vAZserver.getPlayerInventory(player, true)})               
                    SetTimecycleModifier('hud_def_blur')
                    SetNuiFocus(vAZ.nui, vAZ.nui)
                    SendNUIMessage({action = "open"})
                    vAZ.data = {type = 'inspect', entity = player}
                end
            end
		end
    end
end)

RegisterNUICallback('sendItem', function(data, cb)
    if data.source.type == 'player' and data.target.type == 'vehicle' then
        vAZserver.sendPlayerItemToVehicle(data.item.name, parseInt(data.item.amount), GetVehicleNumberPlateText(parseInt(data.target.entity)), data.target.entity)
    elseif data.source.type == 'vehicle' and data.target.type == 'player' then
        vAZserver.sendVehicleItemToPlayer(data.item.name, parseInt(data.item.amount), GetVehicleNumberPlateText(parseInt(data.source.entity)), data.source.entity)
    elseif data.source.type == 'player' and data.target.type == 'home' then
        vAZserver.sendPlayerItemToHome(data.item.name, parseInt(data.item.amount), data.target.entity)
    elseif data.source.type == 'home' and data.target.type == 'player' then
        vAZserver.sendHomeItemToPlayer(data.item.name, parseInt(data.item.amount), data.source.entity)
    elseif data.source.type == 'player' and data.target.type == 'inspect' then
        vAZserver.sendPlayerItemToInspect(data.item.name, parseInt(data.item.amount), parseInt(data.source.entity), parseInt(data.target.entity))
    elseif data.source.type == 'inspect' and data.target.type == 'player' then
        vAZserver.sendInspectItemToPlayer(data.item.name, parseInt(data.item.amount), parseInt(data.source.entity), parseInt(data.target.entity))
    end
end)

RegisterNUICallback('giveItem', function(data, cb)
    vAZserver.givePlayerItem(data.item, parseInt(data.amount))
end)

RegisterNUICallback('dropItem', function(data, cb)
    vAZserver.dropPlayerItem(data.item, parseInt(data.amount), GetEntityCoords(PlayerPedId()))
end)

RegisterNUICallback('useItem', function(data, cb)
    vAZserver.usablePlayerItem(data.item, parseInt(data.amount))
end)

RegisterNUICallback('close', function(data, cb)
    vAZ.closeInventory()
    local source = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
    if data.type == 'vehicle' then
        vAZserver.removePlayerInVehicleTrunk(source, GetVehicleNumberPlateText(parseInt(data.entity)))
        TriggerServerEvent("az-inventory:trunk", VehToNet(parseInt(data.entity)))
    elseif data.type == 'home' then
        vAZserver.removePlayerInHomeChest(source, data.entity)
    end
    vAZ.data = {}
end)

vAZ.closeInventory = function()
    vAZ.nui = false
    SetTimecycleModifier('default')
    SetNuiFocus(vAZ.nui, vAZ.nui)
    SendNUIMessage({display = false, action = "close"})
end

vAZ.updateInventory = function(type, entity, inventory)
    SendNUIMessage({action = "update", type = type, entity = entity, inventory = inventory})
end