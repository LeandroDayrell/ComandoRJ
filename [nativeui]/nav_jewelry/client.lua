local Tunnel = module("vrp","lib/Tunnel")

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
	if data == "relogioroubado" then
		TriggerServerEvent("jewelry-vender","relogioroubado")
	elseif data == "pulseiraroubada" then
		TriggerServerEvent("jewelry-vender","pulseiraroubada")
	elseif data == "anelroubado" then
		TriggerServerEvent("jewelry-vender","anelroubado")
	elseif data == "colarroubado" then
		TriggerServerEvent("jewelry-vender","colarroubado")
	elseif data == "brincoroubado" then
		TriggerServerEvent("jewelry-vender","brincoroubado")
	elseif data == "carteiraroubada" then
		TriggerServerEvent("jewelry-vender","carteiraroubada")
	elseif data == "carregadorroubado" then
		TriggerServerEvent("jewelry-vender","carregadorroubado")
	elseif data == "tabletroubado" then
		TriggerServerEvent("jewelry-vender","tabletroubado")
	elseif data == "sapatosroubado" then
		TriggerServerEvent("jewelry-vender","sapatosroubado")
	elseif data == "vibradorroubado" then
		TriggerServerEvent("jewelry-vender","vibradorroubado")
	elseif data == "perfumeroubado" then
		TriggerServerEvent("jewelry-vender","perfumeroubado")
	elseif data == "maquiagemroubada" then
		TriggerServerEvent("jewelry-vender","maquiagemroubada")

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
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),707.31,-966.99,30.41,true)
		if distance <= 30 then
			DrawMarker(23,707.31,-966.99,30.41-0.97,0,0,0,0,0,0,1.0,1.0,0.5,128,1,210,20,0,0,0,0)
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