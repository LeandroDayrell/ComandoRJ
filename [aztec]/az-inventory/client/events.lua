--[[ az-inventory:others ]]--

RegisterNetEvent("az-inventory:trunk")
AddEventHandler("az-inventory:trunk", function(vnet)
	if NetworkDoesNetworkIdExist(vnet) then
		local netv = NetToVeh(vnet)		
		if DoesEntityExist(netv) then
			if IsEntityAVehicle(netv) then
				if GetVehicleDoorAngleRatio(netv, 5) == 0 then
					SetVehicleDoorOpen(netv, 5, 0, 0)
				else
					SetVehicleDoorShut(netv, 5, 0)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while vAZ.config.armor do
        local ply = PlayerPedId()
        local plyArmor = GetPedArmour(ply)
        if plyArmor <= 1 then
            SetPedComponentVariation(ply, 9, 0, 0, 0)
            Citizen.Wait(2000)
        elseif plyArmor > 1 then
            if GetEntityModel(ply) == GetHashKey("mp_m_freemode_01") then
                SetPedComponentVariation(ply, 9, 16, 2, 2)
            elseif GetEntityModel(ply) == GetHashKey("mp_f_freemode_01") then
                SetPedComponentVariation(ply, 9, 18, 2, 2)
            end
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent('az-inventory:firework:place_firework')
AddEventHandler('az-inventory:firework:place_firework', function()
    local model = GetHashKey('ind_prop_firework_01')
    local dict = vAZ.loadDict('anim@mp_fireworks')
    TaskPlayAnim(PlayerPedId(), dict, 'place_firework_1_rocket', 8.0, -8.0, -1, 0, 0, false, false, false)
    while not IsEntityPlayingAnim(PlayerPedId(), dict, 'place_firework_1_rocket', 3) do Wait(0) end
    Wait(500)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    local firework = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false)
    AttachEntityToEntity(firework, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
    local timer = GetGameTimer() + 2250
    while timer >= GetGameTimer() do Wait(0) end
    DetachEntity(firework)
    FreezeEntityPosition(firework, true)
    Wait(7500)
    timer = GetGameTimer() + 1500
    vAZ.loadPtfx('scr_indep_fireworks')
    StartNetworkedParticleFxNonLoopedAtCoord('scr_indep_firework_starburst', GetEntityCoords(PlayerPedId()), 0.0, 180.0, 0.0, 100.0, false, false, false, false)
    while timer >= GetGameTimer() do Wait(0) SetEntityCoords(firework, GetOffsetFromEntityInWorldCoords(firework, 0.0, 0.0, 0.25)) end
    local coords = GetEntityCoords(firework)
    DeleteEntity(firework)
    TriggerServerEvent('az-inventory:firework', coords.x, coords.y, coords.z+500)
end)

RegisterNetEvent('az-inventory:firework:startExplosion')
AddEventHandler('az-inventory:firework:startExplosion', function(x, y, z)
    vAZ.loadPtfx('scr_indep_fireworks')
    StartNetworkedParticleFxNonLoopedAtCoord('scr_indep_firework_trailburst_spawn', x, y, z, 0.0, 180.0, 0.0, 100.0, false, false, false, false)
    vAZ.loadPtfx('proj_xmas_firework')
    StartNetworkedParticleFxNonLoopedAtCoord('scr_firework_xmas_repeat_burst_rgw', x, y, z, 0.0, 180.0, 0.0, 100.0, false, false, false, false)
    Citizen.Wait(1200)
    vAZ.loadPtfx('scr_indep_fireworks')
    StartNetworkedParticleFxNonLoopedAtCoord('scr_indep_firework_trailburst_spawn', x, y, z, 0.0, 180.0, 0.0, 100.0, false, false, false, false)
    vAZ.loadPtfx('proj_xmas_firework')
    StartNetworkedParticleFxNonLoopedAtCoord('scr_firework_xmas_repeat_burst_rgw', x, y, z, 0.0, 180.0, 0.0, 100.0, false, false, false, false)
end)


RegisterNetEvent('reparar')
AddEventHandler('reparar',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryreparar",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v, 0.0)
				SetVehicleUndriveable(v, false)
				Citizen.InvokeNative(0xAD738C3085FE7E11, v, true, true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v, fuel)
			end
		end
	end
end)

RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trymotor", VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v, 1000.0)
			end
		end
	end
end)