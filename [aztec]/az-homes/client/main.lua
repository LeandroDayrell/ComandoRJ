local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vAZserver = Tunnel.getInterface('az-homes')
vAZ = {}
Tunnel.bindInterface('az-homes', vAZ)

vAZ.homes = {}
vAZ.slots = {}
vAZ.inside = false
vAZ.await = false
vAZ.cooldown = 0

vAZ.player = {
    ped = function()
        return PlayerPedId()
    end,
    coords = function(player)
        return GetEntityCoords(player)
    end
}

Citizen.CreateThread(function()
    while true do
        local thread = 1000
        local ply = vAZ.player.ped()
        local plyCoords = vAZ.player.coords(ply)
        if not vAZ.inside and not vAZ.await then
            for id,slot in pairs(vAZ.homes) do
                if #(plyCoords - vector3(slot.entry.x, slot.entry.y, slot.entry.z)) < 10 then
                    vAZ.AddUserAreaSlot(slot.name, slot)
                end
            end
            for id,slot in pairs(vAZ.slots) do
                if #(plyCoords - vector3(slot.entry.x, slot.entry.y, slot.entry.z)) > 10 then
                    vAZ.RemoveUserAreaSlot(slot.name)
                end
            end
        end
        Citizen.Wait(thread)
    end
end)

vAZ.AddUserAreaSlot = function(name, slot)
    if vAZ.slots[name] == nil then
        if vAZserver.AddUserAreaSlot(name) then
            vAZ.slots[name] = slot
            --print('[az-homes] AddUserAreaSlot: '..name)
        end
    end
end

vAZ.RemoveUserAreaSlot = function(name)
    if vAZ.slots[name] ~= nil then
        if vAZserver.RemoveUserAreaSlot(name) then
            vAZ.slots[name] = nil        
            --print('[az-homes] RemoveUserAreaSlot: '..name)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local thread = 1000
        local ply = vAZ.player.ped()
        local plyCoords = vAZ.player.coords(ply)
        for id,slot in pairs(vAZ.slots) do
            if not vAZ.inside then
                local distanceEntry = vAZ.Distance2D(plyCoords, vector3(slot.entry.x, slot.entry.y, slot.entry.z))
                if distanceEntry < 1.5 then
                    thread = 200
                    if distanceEntry < 0.5 then
                        thread = 5
                        if not slot.locked then
                            vAZ.DrawText3D(slot.entry.x, slot.entry.y, slot.entry.z, "~g~[E]~w~ Entrar")
                            if IsControlJustPressed(0, 38) and vAZ.cooldown == 0 then
                                vAZ.await = true
                                if vAZserver.EnterHomeSlot(slot.name) then
                                    vAZ.inside = true
                                    vAZ.cooldown = 5
                                end
                            end
                            if IsControlJustPressed(0, 74) and vAZ.cooldown == 0 then
                                vAZserver.ChangeHomeStatus(slot.name)
                                vAZ.cooldown = 5
                            end
                        else
                            vAZ.DrawText3D(slot.entry.x, slot.entry.y, slot.entry.z, "Porta: ~r~Trancada")
                            if IsControlJustPressed(0, 74) and vAZ.cooldown == 0 then
                                vAZserver.ChangeHomeStatus(slot.name)
                                vAZ.cooldown = 5
                            end
                        end
                    end
                end                        
            elseif vAZ.inside then
                local distanceExit = vAZ.Distance2D(plyCoords, vector3(slot.exit.x, slot.exit.y, slot.exit.z))
                if distanceExit < 5 then
                    thread = 200
                    if distanceExit < 0.5 then
                        thread = 5
                        if not slot.locked then
                            vAZ.DrawText3D(slot.exit.x, slot.exit.y, slot.exit.z, "~g~[E]~w~ Sair")
                            if IsControlJustPressed(0, 38) and vAZ.cooldown == 0 then
                                if vAZserver.ExitHomeSlot(slot.name) then
                                    vAZ.inside = false
                                    vAZ.await = false
                                    vAZ.cooldown = 5
                                end
                            end
                            if IsControlJustPressed(0, 74) and vAZ.cooldown == 0 then
                                vAZserver.ChangeHomeStatus(slot.name)
                                vAZ.cooldown = 5
                            end
                        else
                            vAZ.DrawText3D(slot.exit.x, slot.exit.y, slot.exit.z, "Porta: ~r~Trancada")
                            if IsControlJustPressed(0, 74) and vAZ.cooldown == 0 then
                                vAZserver.ChangeHomeStatus(slot.name)
                                vAZ.cooldown = 5
                            end
                        end
                    end
                end
                local distanceWardrobe = vAZ.Distance2D(plyCoords, vector3(slot.wardrobe.x, slot.wardrobe.y, slot.wardrobe.z))
                if distanceWardrobe <= 2 then
                    thread = 5
                    vAZ.DrawText3D(slot.wardrobe.x, slot.wardrobe.y, slot.wardrobe.z, "~b~[Guarda Roupa]~w~\nPressione ~g~[E]")
                    if distanceWardrobe < 1.5 then
                        if IsControlJustPressed(0, 38) and vAZ.cooldown == 0 then
                            SetNuiFocus(true, true)
                            SendNUIMessage({ action = 'open', home = slot.name })
                            vAZ.cooldown = 5
                        end
                    end
                end
                local distanceChest = vAZ.Distance2D(plyCoords, vector3(slot.chest.x, slot.chest.y, slot.chest.z))
                if distanceChest <= 2 then
                    thread = 5
                    vAZ.DrawText3D(slot.chest.x, slot.chest.y, slot.chest.z, "~b~[BAU]~w~\nPressione ~g~[E]")
                    if distanceChest < 1.5 then
                        if IsControlJustPressed(0, 38) and vAZ.cooldown == 0 then
                            TriggerServerEvent('az-homes:chest', slot.name)
                            vAZ.cooldown = 5
                        end
                    end
                end
            end
        end
        Citizen.Wait(thread)
    end
end)

Citizen.CreateThread(function()
    while true do
        local thread = 2000
        if vAZ.cooldown < 0 then
            vAZ.cooldown = 0
        end
        if vAZ.cooldown > 0 then
            thread = 1000
            --vAZ.cooldown = vAZ.cooldown - 1
            vAZ.cooldown = 0
        end
        Citizen.Wait(thread)
    end
end)

vAZ.UpdateHomeStatus = function(name, locked)
    for id,slot in pairs(vAZ.homes) do
        if slot.name == name then
            slot.locked = locked
            break
        end
    end
    for id,slot in pairs(vAZ.slots) do
        if slot.name == name then
            slot.locked = locked
            break
        end
    end
end

vAZ.SetHomes = function(homes)
    vAZ.homes = homes
end

vAZ.UpdateWardrobeClothes = function()
    SendNUIMessage({ action = 'update' })
end

vAZ.DrawText3D = function(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    DrawRect(_x, _y + 0.0125, 0.015 + ((string.len(text)) / 370), 0.03, 41, 11, 41, 68)
end

vAZ.DistanceSlot = function()
    local ply = vAZ.player.ped()
    local plyCoords = vAZ.player.coords(ply)
    for id,slot in pairs(vAZ.slots) do
        print(vAZ.Distance2D(plyCoords, vector3(slot.entry.x, slot.entry.y, slot.entry.z)))
    end
end

vAZ.Distance2D = function(vector1, vector2)
    return math.sqrt(math.pow(vector1.x - vector2.x, 2) + math.pow(vector1.y - vector2.y, 2));
end

RegisterNUICallback('get', function(data, cb)
    cb(vAZserver.GetWardrobeClothes(data.name))
end)

RegisterNUICallback('save', function(data, cb)
    vAZserver.SaveWearWardrobeClothes(data.name, data.set)
end)

RegisterNUICallback('wear', function(data, cb)
    vAZserver.WearWardrobeClothes(data.name, data.set)
end)

RegisterNUICallback('delete', function(data, cb)
    vAZserver.DeleteWardrobeClothes(data.name, data.set)
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

--[[
    -- show duplicate coord
    Citizen.CreateThread(function()
        for id,slot in pairs(vAZ.homes) do
            local temp = vAZ.homes
            temp[id] = nil
            for id2,slot2 in pairs(temp) do
                if #(vector3(slot.entry.x, slot.entry.y, slot.entry.z) - vector3(slot2.entry.x, slot2.entry.y, slot2.entry.z)) <= 0.5 then
                    print(slot.name, slot2.name)
                end
            end
        end
    end)
]]--