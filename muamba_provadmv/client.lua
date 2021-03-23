local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

mB = Tunnel.getInterface("muamba_provadmv")

local etapa = 1
local veiculo = nil
local checkVelocidade = true
local limiteSpeed = 80 
local finishTest = false
local pontos = 0
local type

local pedlist = {
	{ ['x'] = 215.36, ['y'] = -1400.77, ['z'] = 30.78-0.1, ['h'] = 323.07, ['hash'] = 0x31430342, ['hash2'] = "a_f_y_business_02" },
}

local rotas = {
	[1] = {['x'] = 217.6, ['y'] = -1411.57, ['z'] = 29.3},
	[2] = {['x'] = 218.84, ['y'] = -1153.92, ['z'] = 29.33},
	[3] = {['x'] = 353.96, ['y'] = -684.14, ['z'] = 29.34},
	[4] = {['x'] = -38.44, ['y'] = -544.02, ['z'] = 40.06},
	[5] = {['x'] = 31.88, ['y'] = -303.72, ['z'] = 47.29},
	[6] = {['x'] = 279.21, ['y'] = -383.1, ['z'] = 45.02},
	[7] = {['x'] = 276.34, ['y'] = -474.31, ['z'] = 43.19},
	[8] = {['x'] = -164.66, ['y'] = -485.01, ['z'] = 28.33},
	[9] = {['x'] = -419.75, ['y'] = -972.82, ['z'] = 37.04},
	[10] = {['x'] = -90.46, ['y'] = -1254.19, ['z'] = 37.1},
	[11] = {['x'] = 77.47, ['y'] = -1339.03, ['z'] = 29.3},
	[12] = {['x'] = 118.28, ['y'] = -1428.0, ['z'] = 29.35},
	[13] = {['x'] = 77.94, ['y'] = -1492.25, ['z'] = 29.34},
	[14] = {['x'] = 150.54, ['y'] = -1581.74, ['z'] = 29.31},
	[15] = {['x'] = 203.19, ['y'] = -1612.9, ['z'] = 29.22},
	[16] = {['x'] = 343.39, ['y'] = -1728.37, ['z'] = 29.39},
	[17] = {['x'] = 452.77, ['y'] = -1662.54, ['z'] = 29.31},
	[18] = {['x'] = 461.25, ['y'] = -1624.36, ['z'] = 29.32},
	[19] = {['x'] = 348.01, ['y'] = -1530.46, ['z'] = 29.34},
	[20] = {['x'] = 262.35, ['y'] = -1452.51, ['z'] = 29.3}, 
	[21] = {['x'] = 279.0, ['y'] = -1351.74, ['z'] = 31.94}
}

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

RegisterNetEvent("prova_pratica:A")
AddEventHandler("prova_pratica:A",function()
	local ped = PlayerPedId()
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	spawVehicle(218.51,-1384.57,30.58,282.33,"faggio")
	SetPedIntoVehicle(ped,nveh,-1)
	DoScreenFadeIn(1500)
	checkVelocidade = true
	startProva()
	checkSpeed()
	DrawInfra()
	veiculo = "faggio"
	type = "a"
	CriandoBlip(rotas,etapa)
end)

RegisterNetEvent("prova_pratica:B")
AddEventHandler("prova_pratica:B",function()

	RequestModel(GetHashKey("ig_mp_agent14"))
	while not HasModelLoaded(GetHashKey("ig_mp_agent14")) do
		Citizen.Wait(10)
	end
	npc = CreatePed(4,0xFBF98469,219.37,-1386.31,30.59,0.0,false,true)
	SetEntityInvincible(npc,true)
	SetBlockingOfNonTemporaryEvents(npc,true)

	local ped = PlayerPedId()
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	spawVehicle(218.51,-1384.57,30.58,282.33,"asterope")
	SetPedIntoVehicle(ped,nveh,-1)
	SetPedIntoVehicle(npc,nveh,0)
	checkVelocidade = true
	DoScreenFadeIn(1500)
	startProva()
	checkSpeed()
	DrawInfra()
	type = "b"
	veiculo = "asterope"
	CriandoBlip(rotas,etapa)
end)

Citizen.CreateThread(function()
	while true do
		local idle = 500
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		local distance = GetDistanceBetweenCoords(216.16,-1399.8,30.59,x,y,z,true)
		if distance <= 5 then
			idle = 5
			DrawMarker(3,216.16,-1399.8,30.59-0.6,0,0,0,0.0,0,0,0.3,0.3,0.3,5, 161, 242,100,0,0,0,1)
			if distance <= 1.1 then
				drawTxt("PROVA ~b~TEÓRICA~w~ PARA RETIRAR SUA CNH. ~g~[R$5.000]~w~",4,0.5,0.87,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and mB.pagamentoProva() then
					vRP._CarregarObjeto("amb@medic@standing@timeofdeath@base","base","prop_notepad_01",15,60309)
					ToggleActionMenu()
				end 
			end
		end 
	Citizen.Wait(idle)
	end 
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		local distance = GetDistanceBetweenCoords(214.7,-1385.96,30.59,x,y,z,true)
		if distance <= 5 then
			idle = 5
			DrawMarker(36,214.7,-1385.96,30.59-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,5, 161, 242,100,0,0,0,1)
			if distance <= 1.1 then
				drawTxt("TESTE ~b~PRÁTICO.",4,0.5,0.87,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and mB.checkProva() then
					--TriggerEvent('cancelando',true)
					TriggerServerEvent("selecionar:prova")
					TriggerEvent('Notify',"aviso","Você utilizou seu teste, escolha qual habilitação deseja tirar!!")
				end
			end 
		end 
	Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(10)
		end

		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- FUNÇÕES
-- -----------------------------------------------------------------------------------------------------------------------------------------

function startProva()
	Citizen.CreateThread(function()
		while true do
			local idle = 100
			local finalizado = false
			if not finalizado then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
				local distance = GetDistanceBetweenCoords(rotas[etapa].x,rotas[etapa].y,rotas[etapa].z,x,y,z,true)
				if distance <= 30 then
					idle = 5
					DrawMarker(1,rotas[etapa].x,rotas[etapa].y,rotas[etapa].z-0.6,0,0,0,0.0,0,0,5.0,5.0,2.0,5, 161, 242 ,100,0,0,0,1)
					if distance <= 3 then
						RemoveBlip(blip)
						etapa = etapa + 1
						CriandoBlip(rotas,etapa)
						if etapa == 8 then
							TriggerEvent('Notify',"aviso","Você está entrando em uma rodovia, limite de velocidade alterado!")
							limiteSpeed = 100
						end
						if etapa == 11 then
							TriggerEvent('Notify',"aviso","Você está retornando a uma zona urbana, limite de velocidade será alterado em breve!")
						end
						if etapa == 11 then
							limiteSpeed = 80
						end
						if etapa == 21 then
							finalizarProva()
							
							finalizado = true
							break
						end 
					end
				end
				if not IsPedInAnyVehicle(ped,false) then
					if not finalizado then
						falhaProva()
					end
					break
				end 
			end
		Citizen.Wait(idle)
		end
	end) 
end

-- Deletar veiuculo
function finalizarProva()
	Citizen.CreateThread(function()
		while true do
			local finalizado = false
	        Citizen.Wait(5)
	        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),rotas[21].x,rotas[21].y,rotas[21].z,true)
	        if distance <= 10 then
	            if not finalizado then
	                DrawMarker(23,rotas[21].x,rotas[21].y,rotas[21].z-0.97,0,0,0,0,0,0,4.0,4.0,0.5,240,200,80,150,0,0,0,0)
	                if distance <= 3  and IsControlJustPressed(0,38) then                 
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey(veiculo)) then
							RemoveBlip(blip)
							local lataria = GetVehicleBodyHealth(veiculo)
							local motor = GetVehicleEngineHealth(veiculo)
							if lataria > 999 or motor > 999 then
								TriggerEvent('Notify',"sucesso","Você passou no exame prático")
								TriggerServerEvent('dar:habilitacao',type)
								type = nil							
							else
								TriggerEvent('Notify',"negado","Você reprovou no exame prático")
							end 

							DoScreenFadeOut(1000)
							Citizen.Wait(1000)
	                        local veiculo = GetVehiclePedIsUsing(PlayerPedId())
							deleteVehicle(veiculo)
							finalizado = true
							SetEntityCoords(PlayerPedId(),213.54,-1390.33,30.6)
							SetEntityHeading(PlayerPedId(),138.25)
							vRP._playAnim(false,{{"timetable@ron@ig_3_couch","base"}},true)
							Citizen.Wait(2000)
							DoScreenFadeIn(2000)
							Citizen.Wait(2000)
							vRP._stopAnim(false)
							checkVelocidade = false
							DeletePed(npc)
							etapa = 1

	                    end
	                end
				else
					break
				end
	        end
	    end
	end)
end

function checkSpeed()
	Citizen.CreateThread(function()
		while true do
			local idle = 1000
			if checkVelocidade then
				idle = 5
				local speed = GetEntitySpeed(PlayerPedId())
				local convSpeed = speed * 3.6
				if convSpeed > limiteSpeed then
					pontos = pontos + 1
					Citizen.Wait(3000)
				end
				if pontos == 3 then
					checkVelocidade = false
					falhaProva()
				end 
			end
			if not checkVelocidade then
				break
			end
		Citizen.Wait(idle)
		end 
	end)
end

function DrawInfra()
	Citizen.CreateThread(function()
		while true do
			if checkVelocidade then
				drawTxt("Infrações ~b~"..pontos.."/3",4,0.047,0.76,0.40,255,255,255,180)
				drawTxt("Velocidade máxima permitida ~b~"..limiteSpeed.."KM/H",4,0.089,0.78,0.40,255,255,255,180)
			else
				pontos = 0 
				break
			end
		Citizen.Wait(5)
		end 
	end)
end

function falhaProva()
	--local veiculo = GetVehiclePedIsUsing(PlayerPedId())
	TriggerEvent('Notify','aviso','Você foi reprovado devido as Infrações, mais atenção da proxima vez!')
	deleteVehicle(nveh)
	RemoveBlip(blip)
	checkVelocidade = false
	etapa = 1
	DoScreenFadeOut(500)
	DeletePed(npc)
	Citizen.Wait(3000)
	SetEntityCoords(PlayerPedId(),214.71,-1397.94,30.59)
	DoScreenFadeIn(3000)


	
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

function spawVehicle(x,y,z,h,model)
    local vhash = GetHashKey(model)

	while not HasModelLoaded(vhash) do
		RequestModel(vhash)
		Citizen.Wait(10)
    end
    
	if HasModelLoaded(vhash) then
        nveh = CreateVehicle(vhash,x,y,z,h,true,false)
        local netveh = VehToNet(nveh)
        local id = NetworkGetNetworkIdFromEntity(nveh)

        NetworkRegisterEntityAsNetworked(nveh)
        while not NetworkGetEntityIsNetworked(nveh) do
            NetworkRegisterEntityAsNetworked(nveh)
            Citizen.Wait(1)
        end

        if NetworkDoesNetworkIdExist(netveh) then
            SetEntitySomething(nveh,true)
            if NetworkGetEntityIsNetworked(nveh) then
                SetNetworkIdExistsOnAllMachines(netveh,true)
            end
        end
        SetNetworkIdCanMigrate(id,true)
		SetVehicleNumberPlateText(NetToVeh(netveh),vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
		SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
		SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
		SetModelAsNoLongerNeeded(nveh)
        SetVehRadioStation(NetToVeh(netveh),"OFF")
    end
end

function deleteVehicle(vehicle)
	SetVehicleHasBeenOwnedByPlayer(vehicle,false)
	Citizen.InvokeNative(0xAD738C3085FE7E11,vehicle,true,true)
	SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle))
    DeleteVehicle(vehicle)
end

function CriandoBlip(rotas,etapa)
	blip = AddBlipForCoord(rotas[etapa].x,rotas[etapa].y,rotas[etapa].z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("CheckPoint")
	EndTextCommandSetBlipName(blip)
end

function setInstrutor()

end 


-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- EVENTOS
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	--TriggerEvent('cancelando',false)
	ClearPedTasksImmediately(PlayerPedId())
	if data == "fechar" then
		vRP._DeletarObjeto()
 		ToggleActionMenu()
 	end
end)

RegisterNUICallback("finalizando",function(data)
	--TriggerEvent('cancelando',false)
	ClearPedTasksImmediately(PlayerPedId())
	vRP._DeletarObjeto()
	TriggerServerEvent('aprovado:teste',data.aprovado)
end)


