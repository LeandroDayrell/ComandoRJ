local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vAZserver = Tunnel.getInterface('az-garages')
vAZ = {}
Tunnel.bindInterface('az-garages', vAZ)

vAZ.currentGarage = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)
		local ply = PlayerPedId()
		local plyCoords = GetEntityCoords(ply)
		for garage,details in pairs(config.garages) do
			if details.permission ~= nil then
				for key,value in pairs(details.point) do
					if #(plyCoords - vector3(value.x, value.y, value.z)) <= 2 then
						if vAZserver.hasPermission(details.permission) then
							details.status = true
						else
							details.status = false
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local roll = GetEntityRoll(vehicle)
                if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
                      if IsVehicleTyreBurst(vehicle, wheel_rm1, 0) == false then
                    SetVehicleTyreBurst(vehicle, 0, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 1, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 2, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 3, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 4, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 5, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 45, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 47, 1)
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function()	
	while true do
		local nyoSleep = 500
		local ply = PlayerPedId()
		if not IsPedInAnyVehicle(ply, false) then
			local plyCoords = GetEntityCoords(ply)
			for garage,details in pairs(config.garages) do			
				for key,value in pairs(details.point) do
					local distance = #(plyCoords - vector3(value.x, value.y, value.z))
					if distance <= 5 then
					nyoSleep = 1
						if details.permission == nil or details.status then
							DrawMarker(details.marker,value.x,value.y,value.z-0.80,0,0,0,0,0,0,0.2,0.2,0.2,186,51,212,20,1,0,0,0)
							DrawMarker(23,value.x,value.y,value.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,186,51,212,20,0,0,0,0)
						end
					end
					if distance <= 1.3 then	
						nyoSleep = 1
						if IsControlJustPressed(0, 38) then
							vAZ.currentGarage = garage							
							if details.permission == nil or details.status then
								SendNUIMessage({action = 'update', garage = details.name, type = details.type, availables = details.availables})
								SetTimecycleModifier('hud_def_blur')
								SetNuiFocus(true, true)
								SendNUIMessage({action = "open"})
							end
						end
					end
				end
			end
		end
		Citizen.Wait(nyoSleep)
	end
end)

Citizen.CreateThread(function()
	for garage,details in pairs(config.garages) do
		if details.blip.id == nil then
			for key,value in pairs(details.point) do
				if details.permission ~= nil then
					if details.name ~= 'SportRace' and details.name ~= 'Los Santos Customs' and details.name ~= 'Benny\'s Motorworks' then
						if vAZserver.hasPermission(details.permission) then					
							details.blip.id = AddBlipForCoord(value.x, value.y, value.z)
							SetBlipSprite(details.blip.id, details.blip.type)
							SetBlipColour(details.blip.id, details.blip.color)
							SetBlipScale(details.blip.id, details.blip.scale)
							SetBlipAsShortRange(details.blip.id, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(details.name)
							EndTextCommandSetBlipName(details.blip.id)
						end
					end
				else
					if details.name ~= 'Elitás Travel [Helicóptero]' and details.name ~= 'Elitás Travel [Avião]' and details.name ~= 'DockTease Náutica' then
						details.blip.id = AddBlipForCoord(value.x, value.y, value.z)
						SetBlipSprite(details.blip.id, details.blip.type)
						SetBlipColour(details.blip.id, details.blip.color)
						SetBlipScale(details.blip.id, details.blip.scale)
						SetBlipAsShortRange(details.blip.id, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString('Garagem')
						EndTextCommandSetBlipName(details.blip.id)
					end
				end
			end
		end
	end
end)

RegisterNUICallback("vehicles", function(data, cb)
	cb(vAZserver.getVehicles(data))
end)

RegisterNUICallback('spawn', function(data, cb)
	vAZserver.spawnVehicle(data)	
end)

RegisterNUICallback('despawn', function(data, cb)
	vAZserver.despawnVehicle(data) --- COLOQUEI DE NOVO PRO PESSOAL PARAR DE CHORAR ATÉ RESOLVER
	--[[local ply = PlayerPedId()
	
	local vehicle = vAZserver.getInVehiclesByPlate(data.plate)
	if vehicle ~= nil then
		local ntoveh = NetToVeh(vehicle.net)
		if #(GetEntityCoords(ply) - GetEntityCoords(ntoveh)) <= 15 then
			vAZserver.despawnVehicle(data)
		else
			TriggerEvent('Notify', 'aviso', 'O veículo está muito longeeeeee!')
		end	
	end]]
	vAZserver.despawnVehicle(data) 
end)

RegisterNUICallback('fare', function(data, cb)
	if vAZserver.fareVehicle(data) then
		SendNUIMessage({action = 'update', garage = config.garages[vAZ.currentGarage].name, type = config.garages[vAZ.currentGarage].type, availables = config.garages[vAZ.currentGarage].availables})
	end
end)

RegisterNUICallback('NUIFocusOff', function()
	SetTimecycleModifier('default')
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'close'})
end)

vAZ.clearGarage = function()
	vAZ.currentGarage = nil
end

---------------------------------------------------------------------------------------------------------------------
-- PLATE
---------------------------------------------------------------------------------------------------------------------
local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

vAZ.GeneratePlate = function()
	local generatedPlate
	local doBreak = false
	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(3)..GetRandomNumber(5))
		local isPlateTaken = vAZserver.CheckPlate(generatedPlate)
		if not isPlateTaken then
			doBreak = true
		end
		if doBreak then
			break
		end
	end
	local letters = {}
	for letter in generatedPlate:gmatch'.[\128-\191]*' do
	   table.insert(letters, {letter = letter, rnd = math.random()})
	end
	table.sort(letters, function(a, b) return a.rnd < b.rnd end)
	for i, v in ipairs(letters) do letters[i] = v.letter end
	return table.concat(letters)
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end 

function vAZ.setVehicleMods(custom,veh)
	if not veh then
		veh = GetVehiclePedIsUsing(PlayerPedId())
	end
	if custom and veh then
		SetVehicleModKit(veh,0)
		if custom.colour then
			SetVehicleColours(veh,tonumber(custom.colour.primary),tonumber(custom.colour.secondary))
			SetVehicleExtraColours(veh,tonumber(custom.colour.pearlescent),tonumber(custom.colour.wheel))
			if custom.colour.neon then
				SetVehicleNeonLightsColour(veh,tonumber(custom.colour.neon[1]),tonumber(custom.colour.neon[2]),tonumber(custom.colour.neon[3]))
			end
			if custom.colour.smoke then
				SetVehicleTyreSmokeColor(veh,tonumber(custom.colour.smoke[1]),tonumber(custom.colour.smoke[2]),tonumber(custom.colour.smoke[3]))
			end
			if custom.colour.custom then
				if custom.colour.custom.primary then
					SetVehicleCustomPrimaryColour(veh,tonumber(custom.colour.custom.primary[1]),tonumber(custom.colour.custom.primary[2]),tonumber(custom.colour.custom.primary[3]))
				end
				if custom.colour.custom.secondary then
					SetVehicleCustomSecondaryColour(veh,tonumber(custom.colour.custom.secondary[1]),tonumber(custom.colour.custom.secondary[2]),tonumber(custom.colour.custom.secondary[3]))
				end
			end
		end

		if custom.plate then
			--SetVehicleNumberPlateTextIndex(veh,tonumber(custom.plate.index))
		end

		SetVehicleWindowTint(veh,tonumber(custom.janela))
		SetVehicleTyresCanBurst(veh,tonumber(custom.bulletproof))
		SetVehicleWheelType(veh,tonumber(custom.wheel))

		ToggleVehicleMod(veh,18,tonumber(custom.turbo))
		ToggleVehicleMod(veh,20,tonumber(custom.fumaca))
		ToggleVehicleMod(veh,22,tonumber(custom.farol))

		if custom.neon then
			SetVehicleNeonLightEnabled(veh,0,tonumber(custom.neon.left))
			SetVehicleNeonLightEnabled(veh,1,tonumber(custom.neon.right))
			SetVehicleNeonLightEnabled(veh,2,tonumber(custom.neon.front))
			SetVehicleNeonLightEnabled(veh,3,tonumber(custom.neon.back))
		end

		if custom.mods ~= nil then
			for i,mod in pairs(custom.mods) do
				if i ~= 18 and i ~= 20 and i ~= 22 and i ~= 46 then
					SetVehicleMod(veh,tonumber(i),tonumber(mod))
				end
			end
		end
		
		SetVehicleMod(veh,23,tonumber(custom.tyres),custom.tyresvariation)
		SetVehicleMod(veh,24,tonumber(custom.tyres),custom.tyresvariation)
	end
end