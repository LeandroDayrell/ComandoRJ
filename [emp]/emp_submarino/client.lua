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
	[1] = { ['x'] = -936.563, ['y'] = 6598.95, ['z'] = -29.56 },
 	[2] = { ['x'] = 769.15539550781, ['y'] = 7392.3120117188, ['z'] = -113.18376159668 },
	[3] = { ['x'] = -1899.4420166016, ['y'] = 5409.39453125, ['z'] = -11.88440990448 },
	[4] = { ['x'] = -2645.0754394531, ['y'] = 4197.5874023438, ['z'] = -9.6415357589722 },
	[5] = { ['x'] = -2835.2966308594, ['y'] = -466.23245239258, ['z'] = -11.084729194641 },
	[6] = { ['x'] = -3490.9067382813, ['y'] = 695.48785400391, ['z'] = -46.756790161133 },
	[7] = { ['x'] = -2525.7568359375, ['y'] = 4572.1357421875, ['z'] = -10.710486412048 },
	[8] = { ['x'] = -1762.6986083984, ['y'] = 5308.7094726563, ['z'] = -7.5681986808777 },
}
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
			if distance <= 80 then
				crjSleep = 1
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA DE PEROLAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)
			if distance <= 40.0 then
				crjSleep= 1
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,128,1,210,50,1,0,0,1)
				if distance <= 3.0 then
					if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("avisa")) then
						SetEntityMaxSpeed(veh,0.45*10-0.45)
						RemoveBlip(blips)
						if selecionado == 8 then
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
		Citizen.Wait(crjSleep)
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
	{ ['id'] = 1 , ['x'] = -643.31, ['y'] = -227.53, ['z'] = 37.74 }, 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if not processo then
			for _,v in pairs(locais) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance2 = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				local vehicle = GetPlayersLastVehicle()
				if distance2 <= 20 then
					crjSleep = 1
					DrawMarker(21,-643.44213867188,-228.04858398438,37.756340026855-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,128,1,210,50,0,0,0,1)
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
			crjSleep = 1
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR O TRATAMENTO",4,0.5,0.93,0.50,255,255,255,180)
		end
		Citizen.Wait(crjSleep)
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