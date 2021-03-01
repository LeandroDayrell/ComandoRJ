local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_submarino")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = -1601.27
local CoordenadaY = 5205.01
local CoordenadaZ = 4.31

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1744.36, ['y'] = -1391.06, ['z'] = -39.84 },
	[2] = { ['x'] = -1587.4720458984, ['y'] = 5301.5112304688, ['z'] = -2.523402929306 },
	[3] = { ['x'] = -1832.9227294922, ['y'] = 5276.7084960938, ['z'] = -10.480470657349 },
	[4] = { ['x'] = -1899.4420166016, ['y'] = 5409.39453125, ['z'] = -11.88440990448 },
	[5] = { ['x'] = -2645.0754394531, ['y'] = 4197.5874023438, ['z'] = -9.6415357589722 },
	[6] = { ['x'] = -3055.4370117188, ['y'] = 4068.7727050781, ['z'] = -29.193674087524 },
	[7] = { ['x'] = -1494.4041748047, ['y'] = 5570.4584960938, ['z'] = -19.731328964233 },
	[8] = { ['x'] = -1288.7254638672, ['y'] = 5978.9057617188, ['z'] = -26.273593902588 },
	[9] = { ['x'] = -1587.4720458984, ['y'] = 5301.5112304688, ['z'] = -2.523402929306 },
	[10] = { ['x'] = 3097.3168945313, ['y'] = 2178.1525878906, ['z'] = -4.7281718254089 },
	[11] = { ['x'] = 769.15539550781, ['y'] = 7392.3120117188, ['z'] = -113.18376159668 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)
			if distance <= 80 then
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = math.random(11)
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)

			if distance <= 45.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,128,1,210,50,1,0,0,1)
				if distance <= 2.5 then
					if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("avisa")) then
						SetEntityMaxSpeed(veh,0.45*10-0.45)
						RemoveBlip(blips)
						if selecionado == 11 then
							selecionado = 1
						else
							selecionado = selecionado + 1
						end
						emP.checkPayment()
						CriandoBlip(locs,selecionado)
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
		Citizen.Wait(5)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------
-- SEPARAR GRAOS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1 , ['x'] = 2581.24, ['y'] = 462.22, ['z'] = 108.60 }, 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not processo then
			for _,v in pairs(locais) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance2 = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				local vehicle = GetPlayersLastVehicle()
				if distance2 <= 20 then
					DrawMarker(21,2581.2438964844,462.22067260742,108.60349273682-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
					if distance2 <= 2 and not andamento then
						drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR O TRATAMENTO DAS PEROLAS",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and emP.checkGraos() and not IsPedInAnyVehicle(ped) and GetEntityModel(vehicle) == -1207771834 then
							processo = true
							segundos = 5
							vRP._playAnim(true,{{"pickup_object","pickup_low"}},false)
							SetTimeout(4000,function()
							emP.separarGraos()
							end)
						end
					end
				end
			end
		end
		if processo then
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR O TRATAMENTO",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
				ClearPedTasks(PlayerPedId())
				vRP._DeletarObjeto()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Colheita")
	EndTextCommandSetBlipName(blips)
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