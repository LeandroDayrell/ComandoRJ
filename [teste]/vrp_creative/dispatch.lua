-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped)
		if IsEntityAVehicle(vehicle) then
			local speed = GetEntitySpeed(vehicle)*2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				if speed >= 40 then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
	end
end)[[
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUT
-----------------------------------------------------------------------------------------------------------------------------------------
[[local isBlackout = false
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
			local currentSpeed = GetEntitySpeed(vehicle)*2.236936
			if currentSpeed ~= oldSpeed then
				if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
					blackout()
				end
				oldSpeed = currentSpeed
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end

		if isBlackout then
			DisableControlAction(0,71,true)
			DisableControlAction(0,72,true)
			DisableControlAction(0,63,true)
			DisableControlAction(0,64,true)
			DisableControlAction(0,75,true)
		end
	end
end)

function blackout()
	TriggerEvent("vrp_sound:source",'heartbeat',0.5)
	if not isBlackout then
		isBlackout = true
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-100)
		Citizen.CreateThread(function()
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do
				Citizen.Wait(10)
			end
			Citizen.Wait(5000)
			DoScreenFadeIn(5000)
			isBlackout = false
		end)
	end
end ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			crjSleep = 1
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			local speed = GetEntitySpeed(vehicle) * 2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				if speed <= 80.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAZERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tazertime = false
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		local ped = PlayerPedId()
		if IsPedBeingStunned(ped) then
			crjSleep = 1
			SetPedToRagdoll(ped,10000,10000,0,0,0,0)
		end
		
		if IsPedBeingStunned(ped) and not tazertime then
			crjSleep = 1
			tazertime = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tazertime then
			crjSleep = 1
			tazertime = false
			SetTimeout(5000,function()
				SetTimecycleModifier("hud_def_desat_Trevor")
				SetTimeout(10000,function()
					SetTimecycleModifier("")
					SetTransitionTimecycleModifier("")
					StopGameplayCamShaking()
				end)
			end)
		end
		Citizen.Wait(crjSleep)
	end
end)