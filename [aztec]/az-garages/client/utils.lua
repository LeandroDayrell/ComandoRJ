vAZ.Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["INSERT"] = 121, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



vehicle = nil
vAZ.spawnServerVehicle = function(model)
--print("teste")
--print(model)
--TriggerEvent("spawnarveiculo",model)
    local model = (type(model) == 'string') and GetHashKey(model) or model
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
    local location = vAZ.getSpawnLocation()
    if location ~= nil then
        --local vehicle = CreateVehicle(model, location.x, location.y, location.z, location.h, true, true)
        TriggerEvent("nkjhkjhgkjgk",model,location)
        
        while not DoesEntityExist(vehicle) do
            Wait(100)
        end
        --print("teste4.1")
        local networkId = NetworkGetNetworkIdFromEntity(vehicle)
        local vehicleId = vAZ.getVehicleFromNetworkId(networkId)
        if vehicleId ~= nil then
            --print("teste6")
            return networkId, vehicleId
        end
    end
    --print("teste5")
    return nil, nil
end



AddEventHandler("nkjhkjhgkjgk",function(model,location)
    vehicle = CreateVehicle(model, location.x, location.y, location.z, location.h, true, true)    
    SetVehicleNumberPlateText(vehicle,"PLCXAD78")
end)













vAZ.drawReactText = function(x, y, z, text, background)
	local camCoords = GetGameplayCamCoord()
    local dist = #(vector3(x, y, z) - camCoords)
	local scale = 200 / (GetGameplayCamFov() * dist)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    if background then
        DrawRect(_x,_y+0.0125, 0.015 + ((string.len(text)) / 370), 0.03, 41, 11, 41, 68)
    end
end

vAZ.closestVehicleArea = function(x, y, z, radius)
	for id,flag in pairs({0,2,4,6,7,23,127,260,2146,2175,12294,16384,16386,20503,32768,67590,67711,98309,100359}) do
		local vehicle = GetClosestVehicle(x, y, z, radius, false, flag)		
		if vehicle ~= 0 and vehicle ~= nil then
			return vehicle
		end
	end
	return 0
end

vAZ.getSpaceNoVehicle = function(spaces)
	for id,spawn in pairs(spaces) do
		if vAZ.closestVehicleArea(spawn.x, spawn.y, spawn.z, 5.0) == 0 then
			return spawn
		end
		Citizen.Wait(5)
	end
	return 0
end

vAZ.getSpawnLocation = function()
	local plyPed = vAZ.player.ped()
	local plyCoords = GetEntityCoords(plyPed)
	for type,garages in pairs(vAZ.config.garages) do
		for id,garage in pairs(garages) do
			for key,value in pairs(garage.point) do
				if  #(plyCoords - vector3(value.x, value.y, value.z)) <= 1 then
					local spawnLocation = vAZ.getSpaceNoVehicle(garage.spaces)
					if spawnLocation ~= 0 then
						return spawnLocation
					end
				end
			end
		end
	end
	return nil
end

vAZ.getVehicleFromNetworkId = function(vehicle)
	if NetworkDoesNetworkIdExist(vehicle) then
		return NetworkGetEntityFromNetworkId(vehicle)
	end
	return nil
end

vAZ.setAttributesVehicle = function(networkId, plate, engine, body, fuel, custom)
	if NetworkDoesNetworkIdExist(networkId) then
		local vehicleId = NetworkGetEntityFromNetworkId(networkId)

		SetVehicleNumberPlateText(vehicleId, plate)
		SetVehicleEngineHealth(vehicleId, (engine + 0.00))
		SetVehicleBodyHealth(vehicleId, (body + 0.00))
		SetVehicleFuelLevel(vehicleId, (fuel + 0.00))

		if not vAZ.whitelistClassVehicle(vAZ.config.class, vehicleId) then
			SetVehicleDoorsLocked(vehicleId, 2)
		end

		if custom then
			TriggerEvent("nation:applymods", vehicleId, false)
		end
	end
end

vAZ.spawnGarageVehicle = function(model, plate, engine, body, fuel, custom)
	local plyPed = vAZ.player.ped()
	local plyCoords = GetEntityCoords(plyPed)
	local vehicleHash = GetHashKey(model)
	while not HasModelLoaded(vehicleHash) do
		RequestModel(vehicleHash)
		Citizen.Wait(10)
	end
	if HasModelLoaded(vehicleHash) then
		for type,garages in pairs(vAZ.config.garages) do
			for id,garage in pairs(garages) do
				for key,value in pairs(garage.point) do
					local distance = #(plyCoords - vector3(value.x, value.y, value.z))                        
					if distance <= 1 then
						local spawnLocation = vAZ.getSpaceNoVehicle(garage.spaces)
						if spawnLocation ~= 0 then
							local vehicle = CreateVehicle(vehicleHash, spawnLocation.x, spawnLocation.y, spawnLocation.z, spawnLocation.h,true,false)
							local vehicleNet = VehToNet(vehicle)
			
							Citizen.Wait(50)
							local i = 0
							FreezeEntityPosition(vehicle, true)
							while (i < 5) do
								i = i + 1
								Citizen.Wait(5)
							end
							FreezeEntityPosition(vehicle, false)
							
							SetEntityAsMissionEntity(vehicle, true, true)
							SetEntityAsNoLongerNeeded(vehicle)

							NetworkRegisterEntityAsNetworked(vehicle)
							while not NetworkGetEntityIsNetworked(vehicle) do
								Citizen.Wait(10)
							end
			
							vehicleNet = VehToNet(vehicle)

							SetNetworkIdExistsOnAllMachines(vehicleNet, true)
							NetworkSetNetworkIdDynamic(vehicleNet, true)
							SetNetworkIdCanMigrate(vehicleNet, false)

							for _,i in ipairs(GetActivePlayers()) do
								SetNetworkIdSyncToPlayer(vehicleNet, i, true)
							end
			
							NetworkFadeInEntity(vehicle, true)
							SetVehicleIsStolen(vehicle, false)
							SetVehicleNeedsToBeHotwired(vehicle, false)
							SetEntityInvincible(vehicle, false)
							SetVehicleNumberPlateText(vehicle, plate)
							SetVehicleHasBeenOwnedByPlayer(vehicle, true)
			
							SetVehRadioStation(vehicle, "OFF")
							
							SetVehicleEngineHealth(vehicle, (engine + 0.00))
							SetVehicleBodyHealth(vehicle, (body + 0.00))
							SetVehicleFuelLevel(vehicle, (fuel + 0.00))
			
							SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle))
							SetModelAsNoLongerNeeded(vehicleHash)
							
							if not vAZ.whitelistClassVehicle(vAZ.config.class, vehicle) then
								SetVehicleDoorsLocked(vehicle, 2)
							end

							if custom then
								-- vAZ.setVehicleMods(custom, nveh)
								TriggerEvent("nation:applymods", vehicle, false)
							end
			
							return true, vehicle, vehicleNet
						else
							TriggerEvent('Notify', 'importante', 'Todas as vagas estão ocupadas no momento')
						end
					end
				end
			end
		end			
	end
	return false, nil, nil, nil
end

vAZ.despawnVehicle = function(vnet)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(vnet) then
			SetVehicleAsNoLongerNeeded(vnet)
			SetEntityAsMissionEntity(vnet, true, true)
			local veh = NetToVeh(vnet)
			if DoesEntityExist(veh) then
				SetVehicleHasBeenOwnedByPlayer(veh, false)
				PlaceObjectOnGroundProperly(veh)
				--SetEntityAsNoLongerNeeded(veh)
				SetEntityAsMissionEntity(veh, true, true)
				DeleteVehicle(veh)				
			end
		end
	end)	
end

vAZ.whitelistClassVehicle = function(table, vehicle)
	for id,class in pairs(table) do
		if class == GetVehicleClass(vehicle) then
			return true
		end
	end
	return false
end

vAZ.vehicleInAreaCabin = function(vehicle, distance)
	local plyPed = vAZ.player.ped()
	local plyCoords = GetEntityCoords(plyPed)
	local vehicle = NetToVeh(vehicle)
	if DoesEntityExist(vehicle) then
		for type,garages in pairs(vAZ.config.garages) do
			for id,garage in pairs(garages) do
				for key,value in pairs(garage.point) do
					if #(plyCoords - vector3(value.x, value.y, value.z)) <= distance then
						return true	
					end
				end
			end
		end
	end
	return false
end

vAZ.getVehicleOccupants = function(driver, vehicle)
	local seats = {0, 2, 3, 4}
    local occupants = {}
    if NetworkDoesNetworkIdExist(vehicle) then
		local vehicle = NetToVeh(vehicle)
		if DoesEntityExist(vehicle) then
            if driver then
                table.insert(seats, -1)
            end
			for id,seat in pairs(seats) do
				local vehicleSeat = GetPedInVehicleSeat(vehicle, seat)
				if vehicleSeat ~= 0 then
					table.insert(occupants, vehicleSeat)
				end
			end
		end
	end
	return occupants
end

vAZ.getVehicleEngine = function(vehicle)	
	if NetworkDoesNetworkIdExist(vehicle) then
		local vehicle = NetToVeh(vehicle)
		if DoesEntityExist(vehicle) then
			return true, GetVehicleEngineHealth(vehicle), GetVehicleBodyHealth(vehicle), GetVehicleFuelLevel(vehicle)	
		end
	end
    return false, nil, nil, nil
end

vAZ.getVehicleNet = function(vehicle)
    return VehToNet(vehicle)
end

vAZ.getVehiclePlate = function(vehicle)
    return GetVehicleNumberPlateText(vehicle)
end

vAZ.checkVehicleAlreadyOnStreet = function(model, plate)
	for vehicle in EnumerateVehicles() do
		if GetVehicleNumberPlateText(vehicle) == plate then
			local data = vAZserver.getServerVehicle('hash', GetEntityModel(vehicle))
			if data ~= nil and data.model == model then
				return true, vehicle, VehToNet(vehicle)
			end
		end
    end
	return false
end

vAZ.getVehicleNearest = function(radius)
	local vehicle = vRP.getNearestVehicle(radius)
	if IsEntityAVehicle(vehicle) then
		local vehicleDB = vAZserver.getServerVehicle('hash', GetEntityModel(vehicle))
		if vehicleDB ~= nil then
			local locked = GetVehicleDoorLockStatus(vehicle) >= 2
			local x,y,z = table.unpack(GetEntityCoords(vehicle))
			return GetVehicleNumberPlateText(vehicle), vehicleDB.model, VehToNet(vehicle), parseInt(vehicleDB.price), vehicleDB.banned, locked, GetDisplayNameFromVehicleModel(vehicleDB.model), GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
		end
	end
	return nil, nil, nil, nil, nil, nil, nil, nil
end

vAZ.getVehicleAlreadyOnStreet = function(model, plate)
	for vehicle in EnumerateVehicles() do
		if IsEntityAVehicle(vehicle) then
			if GetVehicleNumberPlateText(vehicle) == plate then
				local data = vAZserver.getServerVehicle('hash', GetEntityModel(vehicle))
				if data ~= nil and data.model == model then
					return vehicle, VehToNet(vehicle), data.model, GetVehicleNumberPlateText(vehicle)
				end
			end
		end
	end
	return nil, nil, nil, nil
end

vAZ.setVehicleMods = function(custom,veh)
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

RegisterNetEvent('az-garages:deletevehicle')
AddEventHandler('az-garages:deletevehicle', function(networkId)
	if NetworkDoesNetworkIdExist(networkId) then
		local vehicleId = NetworkGetEntityFromNetworkId(networkId)

		NetworkRequestControlOfEntity(vehicleId)

		local timeout = 2000
		while timeout > 0 and not NetworkHasControlOfEntity(vehicleId) do
			Wait(100)
			timeout = timeout - 100
		end
		SetEntityAsMissionEntity(vehicleId, true, true)    
		local timeout = 2000
		while timeout > 0 and not IsEntityAMissionEntity(vehicleId) do
			Wait(100)
			timeout = timeout - 100
		end
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicleId))    
		if DoesEntityExist(vehicleId) then 
			DeleteEntity(vehicleId)
		end 
	end
end)