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

vAZ.DrawReactText = function(x, y, z, text, background)
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

vAZ.ClosestVehicleArea = function(x, y, z, radius)
	for id,flag in pairs({0,2,4,6,7,23,127,260,2146,2175,12294,16384,16386,20503,32768,67590,67711,98309,100359}) do
		local vehicle = GetClosestVehicle(x, y, z, radius, false, flag)		
		if vehicle ~= 0 and vehicle ~= nil then
			return vehicle
		end
	end
	return 0
end

vAZ.GetSpaceNoVehicle = function(spaces)
	for id,spawn in pairs(spaces) do
		if vAZ.ClosestVehicleArea(spawn.x, spawn.y, spawn.z, 5.0) == 0 then
			return spawn
		end
		Citizen.Wait(5)
	end
	return 0
end

local spawnLocation = nil

vAZ.SpawnGarageVehicle = function(model, plate, engine, body, fuel, custom)
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end
	if HasModelLoaded(mhash) then
		spawnLocation = vAZ.GetSpaceNoVehicle(config.garages[vAZ.currentGarage].spaces)
		if spawnLocation ~= 0 then
            if vAZ.currentGarage == #config.garages then
                spawnLocation.x = spawnLocation.x + 2
            end
			nveh = CreateVehicle(mhash, spawnLocation.x, spawnLocation.y, spawnLocation.z, spawnLocation.h,true,false)
			netveh = VehToNet(nveh)

			Citizen.Wait(50)
			local i = 0
			FreezeEntityPosition(nveh, true)
			while (i < 5) do
				i = i + 1
				Citizen.Wait(5)
			end
			FreezeEntityPosition(nveh, false)

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

			NetworkFadeInEntity(NetToEnt(netveh), true)
			SetVehicleIsStolen(NetToVeh(netveh), false)
			SetVehicleNeedsToBeHotwired(NetToVeh(netveh), false)
			SetEntityInvincible(NetToVeh(netveh), false)
			SetVehicleNumberPlateText(NetToVeh(netveh), plate)
			SetEntityAsMissionEntity(NetToVeh(netveh),true, true)
			SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh), true)

			SetVehRadioStation(NetToVeh(netveh), "OFF")
			
			SetVehicleEngineHealth(NetToVeh(netveh), parseInt(engine) + 0.0)
			SetVehicleBodyHealth(NetToVeh(netveh), parseInt(body) + 0.0)
			SetVehicleFuelLevel(NetToVeh(netveh), parseInt(fuel) + 0.0)

			SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(nveh))
			SetModelAsNoLongerNeeded(mhash)
			
			--if not vAZ.WhitelistClassVehicle({14, 15, 16}, NetToVeh(netveh)) then
				SetVehicleDoorsLocked(NetToVeh(netveh), 2)
			--end

			if custom then
				vAZ.setVehicleMods(custom, nveh)
			end

			vAZ.currentGarage = nil
			
			return true,nveh,VehToNet(nveh),model,mhash
		else
			TriggerEvent('Notify', 'importante', 'Todas as vagas estão ocupadas no momento')			
		end
	end
	return false,nil,nil,nil
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

vAZ.WhitelistClassVehicle = function(table, vehicle)
	for id,class in pairs(table) do
		if class == GetVehicleClass(vehicle) then
			return true
		end
	end
	return false
end

vAZ.VehicleInAreaCabin = function(vehicle, cabins, distance)
	local vehicle = NetToVeh(vehicle)
	if DoesEntityExist(vehicle) then
		for id,cabin in pairs(cabins) do
			if GetDistanceBetweenCoords(GetEntityCoords(vehicle), cabin.x, cabin.y, cabin.z, true) <= distance then
				return true				
			end
		end
	end
	return false
end

vAZ.GetVehicleOccupants = function(driver, vehicle)
	local seats = {0,2,3,4}
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

vAZ.GetVehicleEngine = function(vnet)
	if NetworkDoesNetworkIdExist(vnet) then
		local vehicle = NetToVeh(vnet)
		if DoesEntityExist(vehicle) then
			return GetVehicleEngineHealth(vehicle), GetVehicleBodyHealth(vehicle), GetVehicleFuelLevel(vehicle)
		end
	end
	return 1000, 1000, 100
end

vAZ.GetVehicleNet = function(vehicle)
    return VehToNet(vehicle) or nil
end

vAZ.CheckInStreet = function(model, plate)
	for vehicle in EnumerateVehicles() do
		if GetVehicleNumberPlateText(vehicle) == plate then
			local hmodel = vAZserver.GetVehicleBy(GetEntityModel(vehicle), 'hash').model
			if hmodel == model then
				return true, vehicle, VehToNet(vehicle), hmodel, GetEntityModel(vehicle)
			end
		end
    end
	return false
end

vAZ.ModelName = function(radius)
	local vehicle = vRP.getNearestVehicle(radius)
	if IsEntityAVehicle(vehicle) then		
		local hash = GetEntityModel(vehicle)
		local vehicleDB = vAZserver.GetVehicleBy(hash, 'hash')
		if vehicleDB ~= nil then
			local locked = GetVehicleDoorLockStatus(vehicle) >= 2
			local x,y,z = table.unpack(GetEntityCoords(vehicle))
			return GetVehicleNumberPlateText(vehicle), vehicleDB.model, VehToNet(vehicle), parseInt(vehicleDB.price), vehicleDB.banned, locked, GetDisplayNameFromVehicleModel(vehicleDB.model), GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
		end
	end
	return nil, nil, nil, nil, nil, nil, nil, nil
end