--#----------------------------------------------------------------------------------------------------------------------------#--
--#--------------------------------------------------[ DEVELOPED BY PENGUIN ]--------------------------------------------------#--
--#-------------------------------------------------[ CONTATO: Penguinn#0001 ]-------------------------------------------------#--
--#---------------------------------------------[ START SHOP: discord.gg/p8cEuep ]---------------------------------------------#--
--#----------------------------------------------------------------------------------------------------------------------------#--
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("penguin_armas")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 605.52, ['y'] = -3091.69, ['z'] = 6.06 }, -- COORDENADA NÚMERO 1   MAFIA
	{ ['x'] = 1391.693, ['y'] = 3602.77, ['z'] = 38.94 }, -- COORDENADA NÚMERO 2 yakuza
	{ ['x'] = 1098.67, ['y'] = -2015.23, ['z'] = 30.89 }, -- COORDENADA NÚMERO 3  milicia
	{ ['x'] = 105.08, ['y'] = -1303.88, ['z'] = 28.76 }, -- COORDENADA NÚMERO 4 unktec
	{ ['x'] = 2333.03, ['y'] = 3054.77, ['z'] = 48.15 }, -- COORDENADA NÚMERO 5  LR
	{ ['x'] = 2433.59, ['y'] = 4968.92, ['z'] = 42.34 } -- COORDENADA NÚMERO 6 MC
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
	if data == "produzir-ak103" then
		TriggerServerEvent("produzir-arma","ak103") -- AK103
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-imbel" then
		TriggerServerEvent("produzir-arma","imbel") -- IMBEL
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-mtar" then
		TriggerServerEvent("produzir-arma","mtar") -- mtar
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-sigsauer" then
		TriggerServerEvent("produzir-arma","sigsauer") -- SIG SAUER
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-smg" then
		TriggerServerEvent("produzir-arma","smg") -- SMG
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-microuzi" then
		TriggerServerEvent("produzir-arma","microuzi") -- MICRO UZI
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-remington" then
		TriggerServerEvent("produzir-arma","remington") -- REMINGTON
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-pistolsns" then
		TriggerServerEvent("produzir-arma","pistolsns") -- PISTOLA SNS
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-fiveseven" then
		TriggerServerEvent("produzir-arma","fiveseven") -- GLOCK-18
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "produzir-m1911" then
		TriggerServerEvent("produzir-arma","m1911") -- M1911
		produzindo = true
		SetTimeout(20000,function()
			produzindo = false
		end)

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("fechar-nui-armas")
AddEventHandler("fechar-nui-armas", function()
	ToggleActionMenu()
	onmenu = false
end)
-------------------------------------------------------------------------------------------------
--[ ANTI-BUG ]-----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if produzindo then
			DisableControlAction(0,167,true)
		end
	end
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
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] Para acessar a ~r~PRODUÇÃO DE ARMAMENTOS~w~.")
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