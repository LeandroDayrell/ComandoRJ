--#----------------------------------------------------------------------------------------------------------------------------#--
--#--------------------------------------------------[ DEVELOPED BY PENGUIN ]--------------------------------------------------#--
--#-------------------------------------------------[ CONTATO: Penguinn#0001 ]-------------------------------------------------#--
--#---------------------------------------------[ START SHOP: discord.gg/p8cEuep ]---------------------------------------------#--
--#----------------------------------------------------------------------------------------------------------------------------#--
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("penguin_pecaarma")
-------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false
local blips = false
local servicofacil = false
local servicomediano = false
local servicodificil = false
local selecionado = 0
local processo = false
local segundos = 0
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local PegarRota = {
	{ ['x'] = -643.35, ['y'] = -1227.86, ['z'] = 11.55 } -- -645.14,-1224.15,11.24
}

local locs = {
	[1] = { ['x'] = 256.45819091797, ['y'] = 3106.9914550781, ['z'] = 42.487155914307},
	[1] = { ['x'] = -432.66369628906, ['y'] = 1589.5456542969, ['z'] = 357.10824584961},
	[2] = { ['x'] = 1126.87, ['y'] = -1302.52, ['z'] = 34.73 },
	[3] = { ['x'] = -569.02294921875, ['y'] = 5253.2524414063, ['z'] = 70.487228393555},
	[4] = { ['x'] = -60.444828033447, ['y'] = -1433.5377197266, ['z'] = 32.163711547852},
	[5] = { ['x'] = -2612.7600097656, ['y'] = 2949.5141601563, ['z'] = 9.6540851593018},
	[6] = { ['x'] = -128.01301574707, ['y'] = -1648.1463623047, ['z'] = 36.51416015625},
	[7] = { ['x'] = -280.666381835938, ['y'] = 6634.96728515625, ['z'] = 7.54050254821777},
	[8] = { ['x'] = 713.653137207031, ['y'] = 4093.04272460938, ['z'] = 34.7278327941895},
	[9] = { ['x'] = -581.21893310547, ['y'] = 5349.830078125, ['z'] = 70.215911865234},
	[10] = { ['x'] = 108.14408111572, ['y'] = -1901.9796142578, ['z'] = 21.07221031189},
	[11] = { ['x'] = 3867.22045898438, ['y'] = 4463.80859375, ['z'] = 2.72471237182617},
	[12] = { ['x'] = 2505.42, ['y'] = -333.5, ['z'] = 93.0 }, 
	[13] = { ['x'] = 225.57939147949, ['y'] = -1983.1656494141, ['z'] = 19.731414794922},
	[14] = { ['x'] = 1469.2137451172, ['y'] = 6552.0747070313, ['z'] = 14.680894851685},
	[15] = { ['x'] = 1544.4713134766, ['y'] = 6333.2104492188, ['z'] = 24.078121185303},
	[16] = { ['x'] = 29.664302825928, ['y'] = -1832.6430664063, ['z'] = 24.600751876831 },
	[17] = { ['x'] = 1443.3505859375, ['y'] = 6333.283203125, ['z'] = 23.889169692993},
	[18] = { ['x'] = 1112.2280273438, ['y'] = -647.57446289063, ['z'] = 56.816093444824},
	[19] = { ['x'] = -738.97186279297, ['y'] = 5594.9428710938, ['z'] = 41.654579162598},
	[20] = { ['x'] = 152.11538696289, ['y'] = -1190.0473632813, ['z'] = 29.564273834229},
	[21] = { ['x'] = -3068.87, ['y'] = 3328.0, ['z'] = 8.8 }, 
	[22] = { ['x'] = -64.126136779785, ['y'] = -1227.6512451172, ['z'] = 28.832738876343},
	[23] = { ['x'] = 439.38, ['y'] = 3561.53, ['z'] = 33.24 }, 
	[24] = { ['x'] = -15.026290893555, ['y'] = -1214.6519775391, ['z'] = 30.531620025635},
	[25] = { ['x'] = -216.64218139648, ['y'] = -1648.7886962891, ['z'] = 37.63692855835},
	[26] = { ['x'] = 813.67443847656, ['y'] = -2355.1821289063, ['z'] = 35.319396972656},
	[27] = { ['x'] = 1310.24, ['y'] = 4386.92, ['z'] = 41.23 }, 
	[28] = { ['x'] = 1943.85, ['y'] = 4647.04, ['z'] = 40.63 }, 
	[29] = { ['x'] = 364.54849243164, ['y'] = -2031.2387695313, ['z'] = 22.169549942017},
	[30] = { ['x'] = 1736.61, ['y'] = 6423.25, ['z'] = 34.39 }, 
	[31] = { ['x'] = -758.16, ['y'] = 5600.44, ['z'] = 33.83 }, 
	[32] = { ['x'] = 264.26, ['y'] = 3096.01, ['z'] = 42.79 }, 
	[33] = { ['x'] = 2867.29, ['y'] = 1506.66, ['z'] = 24.57 }, 
	[34] = { ['x'] = 2544.2, ['y'] = 377.0, ['z'] = 108.62 }, 
	[35] = { ['x'] = -218.00387573242, ['y'] = -1617.7208251953, ['z'] = 38.054496765137},
	[36] = { ['x'] = 342.00051879883, ['y'] = -2037.5241699219, ['z'] = 21.659980773926},
	[37] = { ['x'] = 442.39694213867, ['y'] = 6457.46484375, ['z'] = 35.864910125732},
	[38] = { ['x'] = -126.31898498535, ['y'] = -1593.6011962891, ['z'] = 37.40775680542},
	[39] = { ['x'] = 1597.8010253906, ['y'] = 3581.2397460938, ['z'] = 38.770069122314},
	[40] = { ['x'] = 1601.67, ['y'] = 3562.69, ['z'] = 35.37 }, 
	[41] = { ['x'] = 268.45394897461, ['y'] = 2865.9401855469, ['z'] = 74.174751281738}
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
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
	if data == "rota-facil" then
		TriggerServerEvent("rotas-pecas","facil")
		servicofacil = true
		selecionado = 1
		CriandoBlip(locs,selecionado)

	elseif data == "rota-mediana" then
		TriggerServerEvent("rotas-pecas","mediana")
		servicomediano = true
		selecionado = 1
		CriandoBlip(locs,selecionado)

	elseif data == "rota-dificil" then
		TriggerServerEvent("rotas-pecas","dificil")
		servicodificil = true
		selecionado = 1
		CriandoBlip(locs,selecionado)

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("fechar-nui-farm")
AddEventHandler("fechar-nui-farm", function()
	ToggleActionMenu()
	onmenu = false
end)

RegisterCommand('fecharnui1',function()
	ToggleActionMenu()
	onmenu = false
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500

		for k,v in pairs(PegarRota) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local PegarRota = PegarRota[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), PegarRota.x, PegarRota.y, PegarRota.z, true ) <= 1 and not onmenu and not servicodificil and not servicomediano and not servicofacil then
				crjSleep = 1
				DrawText3D(PegarRota.x, PegarRota.y, PegarRota.z, "[~r~E~w~] Para acessar as ~r~ROTAS DE PEÇAS DE ARMA~w~.")
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
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
--[ COLETAR PEÇAS ]------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

--[ ROTA FÁCIL ]------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if servicofacil then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			
			if distance <= 3 then
				idle = 5
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					DrawText3D(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z, "[~r~E~w~] para coletar as ~r~PEÇAS DE ARMA~w~.")
					if IsControlJustPressed(0,38) and oC.checkPermissao() and not IsPedInAnyVehicle(ped) then
						--if oC.checkPaymentfacil() then
							local random = math.random(100)
							if random >= 98 then
								oC.MarcarOcorrencia()
							end
							TriggerEvent('cancelando',true)
							armas = CreateObject(GetHashKey("gr_prop_gr_crates_weapon_mix_01a"),locs[selecionado].x-1.0,locs[selecionado].y,locs[selecionado].z-1.1,true,true,true)
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							segundos = 10
							local player = PlayerPedId()
							local coords = GetEntityCoords(player)
							local cash_hash = GetHashKey("w_ar_assaultrifle")
							--loadModel(cash_hash)
							RequestAnimDict('anim@heists@ornate_bank@grab_cash')
							vRP._playAnim(false,{{'anim@heists@ornate_bank@grab_cash','intro'}},true)
							local bagHash2 = GetHashKey('p_ld_heist_bag_s_pro_o')
							--loadModel(bagHash2)
							local bagProp2 = CreateObject(bagHash2, coords, true, false)
							local bagIndex2 = GetPedBoneIndex(PlayerPedId(), 57005)
							local arma = CreateObject(cash_hash, coords, true, false)
							local armamao = GetPedBoneIndex(PlayerPedId(), 18905)
							SetEntityAsMissionEntity(bagProp2, true, true)
							SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
							AttachEntityToEntity(bagProp2, PlayerPedId(), bagIndex2, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
							AttachEntityToEntity(arma, PlayerPedId(), armamao, 0.125, 0.0, 0.05, 5.0, 150.0, 300.0, true, true, false, true, 1, true)
						
							SetTimeout(2000,function()
								vRP._stopAnim(false)
							end)
							SetTimeout(2000,function()
								vRP._playAnim(false,{{'anim@heists@ornate_bank@grab_cash','grab'}},true)
							end)

							SetTimeout(10000,function()
								oC.checkPaymentfacil()
								ClearPedTasks(PlayerPedId())
								DeleteObject(armas)
								DeleteEntity(cashPile2)
								DeleteEntity(bagProp2)
								DeleteEntity(arma)
								DeleteObject(bagIndex2)
								SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
								ClearPedTasks(player)
								vRP._stopAnim(false)
							end)

							while true do
								if backentrega == selecionado then
									selecionado = selecionado + 1
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						--end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ ROTA MEDIANA ]------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1500
		if servicomediano then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			
			if distance <= 3 then
				idle = 5
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					DrawText3D(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z, "[~r~E~w~] para coletar as ~r~PEÇAS DE ARMA~w~.")
					if IsControlJustPressed(0,38) and oC.checkPermissao() and not IsPedInAnyVehicle(ped) then
						--if oC.checkPaymentmediano() then
							local random = math.random(100)
							if random >= 95 then
								oC.MarcarOcorrencia()
							end
							TriggerEvent('cancelando',true)
							armas = CreateObject(GetHashKey("gr_prop_gr_crates_weapon_mix_01a"),locs[selecionado].x-1.0,locs[selecionado].y,locs[selecionado].z-1.1,true,true,true)
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							segundos = 15
							local player = PlayerPedId()
							local coords = GetEntityCoords(player)
							local cash_hash = GetHashKey("w_ar_assaultrifle")
							--loadModel(cash_hash)
							RequestAnimDict('anim@heists@ornate_bank@grab_cash')
							vRP._playAnim(false,{{'anim@heists@ornate_bank@grab_cash','intro'}},true)
							local bagHash2 = GetHashKey('p_ld_heist_bag_s_pro_o')
							--loadModel(bagHash2)
							local bagProp2 = CreateObject(bagHash2, coords, true, false)
							local bagIndex2 = GetPedBoneIndex(PlayerPedId(), 57005)
							local arma = CreateObject(cash_hash, coords, true, false)
							local armamao = GetPedBoneIndex(PlayerPedId(), 18905)
							SetEntityAsMissionEntity(bagProp2, true, true)
							SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
							AttachEntityToEntity(bagProp2, PlayerPedId(), bagIndex2, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
							AttachEntityToEntity(arma, PlayerPedId(), armamao, 0.125, 0.0, 0.05, 5.0, 150.0, 300.0, true, true, false, true, 1, true)
						
							SetTimeout(2000,function()
								vRP._stopAnim(false)
							end)
							SetTimeout(2000,function()
								vRP._playAnim(false,{{'anim@heists@ornate_bank@grab_cash','grab'}},true)
							end)

							SetTimeout(15000,function()
								oC.checkPaymentmediano()
								ClearPedTasks(PlayerPedId())
								DeleteObject(armas)
								DeleteEntity(cashPile2)
								DeleteEntity(bagProp2)
								DeleteEntity(arma)
								DeleteObject(bagIndex2)
								SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
								ClearPedTasks(player)
								vRP._stopAnim(false)
							end)

							while true do
								if backentrega == selecionado then
									selecionado = selecionado + 1
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						--end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ ROTA DIFÍCIL ]------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 2000
		if servicodificil then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			
			if distance <= 3 then
				idle = 5
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					DrawText3D(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z, "[~r~E~w~] para coletar as ~r~PEÇAS DE ARMA~w~.")
					if IsControlJustPressed(0,38) and oC.checkPermissao() and not IsPedInAnyVehicle(ped) then
						--if oC.checkPaymentdificil() then
							local random = math.random(100)
							if random >= 70 then
								oC.MarcarOcorrencia()
							end
							TriggerEvent('cancelando',true)
							armas = CreateObject(GetHashKey("gr_prop_gr_crates_weapon_mix_01a"),locs[selecionado].x-1.0,locs[selecionado].y,locs[selecionado].z-1.1,true,true,true)
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							segundos = 20
							local player = PlayerPedId()
							local coords = GetEntityCoords(player)
							local cash_hash = GetHashKey("w_ar_assaultrifle")
							--loadModel(cash_hash)
							RequestAnimDict('anim@heists@ornate_bank@grab_cash')
							vRP._playAnim(false,{{'anim@heists@ornate_bank@grab_cash','intro'}},true)
							local bagHash2 = GetHashKey('p_ld_heist_bag_s_pro_o')
							--loadModel(bagHash2)
							local bagProp2 = CreateObject(bagHash2, coords, true, false)
							local bagIndex2 = GetPedBoneIndex(PlayerPedId(), 57005)
							local arma = CreateObject(cash_hash, coords, true, false)
							local armamao = GetPedBoneIndex(PlayerPedId(), 18905)
							SetEntityAsMissionEntity(bagProp2, true, true)
							SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
							AttachEntityToEntity(bagProp2, PlayerPedId(), bagIndex2, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
							AttachEntityToEntity(arma, PlayerPedId(), armamao, 0.125, 0.0, 0.05, 5.0, 150.0, 300.0, true, true, false, true, 1, true)
						
							SetTimeout(2000,function()
								vRP._stopAnim(false)
							end)
							SetTimeout(2000,function()
								vRP._playAnim(false,{{'anim@heists@ornate_bank@grab_cash','grab'}},true)
							end)

							SetTimeout(20000,function()
								oC.checkPaymentdificil()
								ClearPedTasks(PlayerPedId())
								DeleteObject(armas)
								DeleteEntity(cashPile2)
								DeleteEntity(bagProp2)
								DeleteEntity(arma)
								DeleteObject(bagIndex2)
								SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
								ClearPedTasks(player)
								vRP._stopAnim(false)
							end)

							while true do
								if backentrega == selecionado then
									selecionado = selecionado + 1
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						--end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-------------------------------------------------------------------------------------------------
--[ SAIR DE SERVIÇO ]----------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servicofacil or servicomediano or servicodificil then
			if IsControlJustPressed(0,168) then
				local ped = PlayerPedId()
				servicofacil = false
				servicomediano = false
				servicodificil = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
				SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
			end
		end
	end
end)
-------------------------------------------------------------------------------------------------
--[ TIMER ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
			end
		end
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]------------------------------------------------------------------------------------
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
    --DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar Peças de Armas")
	EndTextCommandSetBlipName(blips)
end