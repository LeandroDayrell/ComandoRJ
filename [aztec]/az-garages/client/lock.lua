Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0, vAZ.Keys['L']) then
			local vehicle = vRP.getNearestVehicle(5)
			if IsEntityAVehicle(vehicle) then
				if not vAZ.whitelistClassVehicle(vAZ.config.class, vehicle) then
					vAZserver.ToggleVehicleLock(vehicle, GetEntityModel(vehicle), GetVehicleNumberPlateText(vehicle))
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
		local ply = PlayerPedId()
		if IsPedInAnyVehicle(ply, false) then
			sleep = 5
			local vehicle = GetVehiclePedIsIn(ply, false)
			if vAZ.whitelistClassVehicle(vAZ.config.class, vehicle) then
				SetVehicleDoorsLocked(vehicle, 1)
			end
			if GetVehicleDoorLockStatus(vehicle) == 2 then
				DisableControlAction(0, 75)
			elseif GetVehicleDoorLockStatus(vehicle) == 1 then
				EnableControlAction(0, 75)
			end			
		end
		Citizen.Wait(sleep)
	end
end)

vAZ.ToggleVehicleLock = function(vehicle)
	if IsEntityAVehicle(vehicle) then
		if GetVehicleDoorLockStatus(vehicle) >= 2 then
			vAZserver.ToggleLock(VehToNet(vehicle))
			TriggerEvent('Notify', 'importante', 'Veículo destrancado.')
		else
			vAZserver.ToggleLock(VehToNet(vehicle))
			TriggerEvent('Notify', 'importante', 'Veículo trancado.')
		end
		if not IsPedInAnyVehicle(PlayerPedId()) then
			vRP._playAnim(true, {{"anim@mp_player_intmenu@key_fob@","fob_click"}}, false)
		end
	end
end

vAZ.ToggleLock = function(index)
	if NetworkDoesNetworkIdExist(index) then
		local vehicle = NetToVeh(index)
		if DoesEntityExist(vehicle) then			
			if IsEntityAVehicle(vehicle) then
				if GetVehicleClass(vehicle) == 8 and GetVehicleClass(vehicle) == 13 and GetVehicleClass(vehicle) == 14 and GetVehicleClass(vehicle) == 15 and GetVehicleClass(vehicle) == 16 then
					return
				end
				if GetVehicleDoorLockStatus(vehicle) == 1 then
					SetVehicleDoorsLocked(vehicle, 2)
				else
					SetVehicleDoorsLocked(vehicle, 1)
				end
				SetVehicleLights(vehicle, 2)
				Wait(200)
				SetVehicleLights(vehicle, 0)
				Wait(200)
				SetVehicleLights(vehicle, 2)
				Wait(200)
				SetVehicleLights(vehicle, 0)
			end
		end
	end
end