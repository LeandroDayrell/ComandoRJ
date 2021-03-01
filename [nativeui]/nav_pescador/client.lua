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
	if data == "dourado" then
		TriggerServerEvent("pescador-vender","dourado")
	elseif data == "corvina" then
		TriggerServerEvent("pescador-vender","corvina")
	elseif data == "salmao" then
		TriggerServerEvent("pescador-vender","salmao")
	elseif data == "pacu" then
		TriggerServerEvent("pescador-vender","pacu")
	elseif data == "pintado" then
		TriggerServerEvent("pescador-vender","pintado")
	elseif data == "pirarucu" then
		TriggerServerEvent("pescador-vender","pirarucu")
	elseif data == "tilapia" then
		TriggerServerEvent("pescador-vender","tilapia")
	elseif data == "tucunare" then
		TriggerServerEvent("pescador-vender","tucunare")
	elseif data == "lambari" then
		TriggerServerEvent("pescador-vender","lambari")
	elseif data == "graos" then
		TriggerServerEvent("pescador-vender","graos")
	elseif data == "mouro" then
		TriggerServerEvent("pescador-vender","mouro")	
	elseif data == "mferro" then
		TriggerServerEvent("pescador-vender","mferro")	
	elseif data == "mbronze" then
		TriggerServerEvent("pescador-vender","mbronze")	
	elseif data == "mrubi" then
		TriggerServerEvent("pescador-vender","mrubi")	
	elseif data == "mesmeralda" then
		TriggerServerEvent("pescador-vender","mesmeralda")	
	elseif data == "diamante" then
		TriggerServerEvent("pescador-vender","diamante")
	elseif data == "perolatratada" then
		TriggerServerEvent("pescador-vender","perolatratada")

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
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1603.638671875,-831.18737792969,10.067133903503,true)
		if distance <= 3 then
			DrawMarker(21,-1603.638671875,-831.18737792969,10.067133903503-0.97,0,0,0,0,0,0,1.0,1.0,0.5,128,1,210,20,0,0,0,0)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)