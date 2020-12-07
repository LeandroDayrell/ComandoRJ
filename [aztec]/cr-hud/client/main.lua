local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vAZserver = Tunnel.getInterface("cr-hud")
vAZ = {}
Tunnel.bindInterface("cr-hud", vAZ)

local health = 0
local armor = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
        local ped = PlayerPedId()
        health = math.ceil((100 * ((GetEntityHealth(ped) - 100) / (GetEntityMaxHealth(ped) - 100))))
		armor = GetPedArmour(ped)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SendNUIMessage({action = 'player', health = health, armor = armor})
    end
end)

Citizen.CreateThread(function()
	while true do
        SendNUIMessage({action = 'pause', status = IsPauseMenuActive()})
        Citizen.Wait(200)
    end
end)

RegisterNetEvent("comandorj-hud:channel")
AddEventHandler("comandorj-hud:channel", function(text)
    SendNUIMessage({action = "channel", text = text})
end)

RegisterNetEvent("comandorj-hud:talking")
AddEventHandler("comandorj-hud:talking", function(status)
    SendNUIMessage({action = "talking", status = status})
end)

RegisterNetEvent("comandorj-hud:proximity")
AddEventHandler("comandorj-hud:proximity", function(mode)
    SendNUIMessage({action = "mode", mode = mode})
end)

local hudp = false

RegisterCommand('hudp', function(source, args)
    hudp = not hudp
    SendNUIMessage({action = "basic", status = hudp})
end)