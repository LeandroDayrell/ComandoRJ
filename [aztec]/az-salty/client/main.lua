local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vAZserver = Tunnel.getInterface('az-salty')
vAZ = {}
Tunnel.bindInterface('az-salty', vAZ)

--[[ az-salty:connect ]]--
vAZ.connect = false
vAZ.alive = false

Citizen.CreateThread(function()
    SendNUIMessage({event = 'salty', action = 'start', server = GetResourceMetadata('saltychat', 'ServerUniqueIdentifier', 0)})
end)

Citizen.CreateThread(function()
    while true do
        local thread = 200
        local playerPed = PlayerPedId()
        if exports['saltychat']:IsIngame() then
            vAZ.connect = true
            thread = 5000
        elseif not exports['saltychat']:IsConnected() or not exports['saltychat']:IsIngame() then
            vAZ.connect = false
        end
        SendNUIMessage({
            event = 'salty',
            action = 'update',
            connected = vAZ.connect,
            version = GetResourceMetadata('saltychat', 'MinimumPluginVersion', 0),
            branch = GetResourceMetadata('saltychat', 'RequiredUpdateBranch', 0),
            server = GetResourceMetadata('saltychat', 'ServerUniqueIdentifier', 0)
        })
        Citizen.Wait(thread)
    end
end)

Citizen.CreateThread(function()
	while true do
        local thread = 1000
        if not vAZ.connect then
            thread = 1
            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(2)
        end
        Citizen.Wait(thread)
	end
end)

Citizen.CreateThread(function()
    while true do
        local thread = 1500
        if vAZ.connect then           
            local playerPed = PlayerPedId()
            local playerHealth = GetEntityHealth(playerPed)
            if playerHealth <= 100 then
                vAZserver.SetPlayerAlive(false)
                local channelPrimary, channelsecondary = exports['saltychat']:GetRadioChannel(true), exports['saltychat']:GetRadioChannel(false)
                if channelPrimary ~= nil and channelPrimary ~= '' then
                    TriggerServerEvent('SaltyChat_RemovePlayerRadioChannel', channelPrimary, true) 
                end
                if channelsecondary ~= nil and channelsecondary ~= '' then
                    TriggerServerEvent('SaltyChat_RemovePlayerRadioChannel', channelsecondary, false)
                end
            elseif playerHealth > 100 then
                vAZserver.SetPlayerAlive(true)
            end
        end
        Citizen.Wait(thread)
    end
end)

exports('connect', vAZ.connect)

--[[ az-salty:radio ]]--
vAZ.radio = false

vAZ.OpenNUIRadio = function()
    if vAZ.connect then
        vAZ.radio = true
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            vRP._CarregarObjeto("anim@cellphone@in_car@ps", 'cellphone_text_in', 'prop_cs_hand_radio', 50, 28422)
        else
            vRP._CarregarObjeto("cellphone@", 'cellphone_text_in', 'prop_cs_hand_radio', 50, 28422)
        end
        SetNuiFocus(vAZ.radio, vAZ.radio)
        SendNUIMessage({event = 'radio', action = 'open', channel = exports['saltychat']:GetRadioChannel(true)})
    end
end

RegisterNUICallback('join', function(data, cb)
    if data.frequency > 0 and data.frequency <= 999 then
        local channel = exports['saltychat']:GetRadioChannel(true)
        if channel ~= data.frequency then
            if vAZserver.RadioPermission(data.frequency) then
                TriggerServerEvent('SaltyChat_SetPlayerRadioChannel', tostring(data.frequency), true)
            end
        end
    end
end)

RegisterNUICallback('leave', function(data, cb)
    if data.frequency == 'all' then
        local channelPrimary = exports['saltychat']:GetRadioChannel(true)
        if channelPrimary ~= nil and channelPrimary ~= '' then
            TriggerServerEvent('SaltyChat_RemovePlayerRadioChannel', channelPrimary, true) 
        end
        local channelsecondary = exports['saltychat']:GetRadioChannel(false)
        if channelsecondary ~= nil and channelsecondary ~= '' then
            TriggerServerEvent('SaltyChat_RemovePlayerRadioChannel', channelsecondary, false)
        end
    elseif data.frequency > 0 and data.frequency <= 999 then
        local channel = exports['saltychat']:GetRadioChannel(true)
        if parseInt(channel) == data.frequency then
            TriggerServerEvent('SaltyChat_RemovePlayerRadioChannel', channel, true) 
        end
    end
end)

RegisterNUICallback('close', function(data, cb)
    vAZ.radio = false
    vRP._DeletarObjeto()
    SetNuiFocus(vAZ.radio, vAZ.radio)
    SendNUIMessage({event = 'radio', action = 'close'})
end)