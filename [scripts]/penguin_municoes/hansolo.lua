--#----------------------------------------------------------------------------------------------------------------------------#--
--#--------------------------------------------------[ DEVELOPED BY PENGUIN ]--------------------------------------------------#--
--#-------------------------------------------------[ CONTATO: Penguinn#0001 ]-------------------------------------------------#--
--#---------------------------------------------[ START SHOP: discord.gg/p8cEuep ]---------------------------------------------#--
--#----------------------------------------------------------------------------------------------------------------------------#--
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("penguin_municoes")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 107.39, ['y'] = -1306.17, ['z'] = 28.76 }, -- COORDENADA NÚMERO 1 VANILLA
	{ ['x'] = 1388.33, ['y'] = 3612.79, ['z'] = 38.94 }, -- COORDENADA NÚMERO 2 YAKUZA
	{ ['x'] = 606.92, ['y'] = -3095.50, ['z'] = 6.06 }, -- COORDENADA NÚMERO 3 MAFIA
	{ ['x'] = 1118.33, ['y'] = -1997.97, ['z'] = 35.43 }, -- COORDENADA NÚMERO 4 MILICIA
	{ ['x'] = 2435.58, ['y'] = 4965.10, ['z'] = 42.35 } -- COORDENADA NÚMERO 5 MC
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false
local produzindo = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "produzir-capsula" then
		TriggerServerEvent("produzir-municao","capsulas")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)
		
	elseif data == "produzir-kitcostura" then
		TriggerServerEvent("produzir-municao","kitcostura")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

		elseif data == "produzir-polvora" then
		TriggerServerEvent("produzir-municao","polvora")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-m-ak103" then
		TriggerServerEvent("produzir-municao","m-ak103")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)
		
	elseif data == "produzir-m-mtar" then
		TriggerServerEvent("produzir-municao","m-mtar")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)
		
	elseif data == "produzir-m-uzi" then
		TriggerServerEvent("produzir-municao","m-imbel")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-m-zig" then
		TriggerServerEvent("produzir-municao","m-zig")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)
		
	elseif data == "produzir-m-smg" then
		TriggerServerEvent("produzir-municao","m-smg")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-m-microuzi" then
		TriggerServerEvent("produzir-municao","m-microuzi")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)
		
	elseif data == "produzir-m-shotgun" then
		TriggerServerEvent("produzir-municao","m-shotgun")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-m-fiveseven" then
		TriggerServerEvent("produzir-municao","m-fiveseven")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-m-snspistol" then
		TriggerServerEvent("produzir-municao","m-snspistol")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-m-pistol" then
		TriggerServerEvent("produzir-municao","m-pistol")
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("fechar-nui-municao")
AddEventHandler("fechar-nui-municao", function()
	ToggleActionMenu()
	onmenu = false
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500

		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) <= 1 and not onmenu and not produzindo then
			crjSleep = 1
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] Para acessar a ~r~PRODUÇÃO DE MUNIÇÕES~w~.")
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao() and not produzindo then
						ToggleActionMenu()
						onmenu = true
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end