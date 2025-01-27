local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")



-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMACAO DA BOCA AO FALAR
------------------------------------- ----------------------------------------------------------------------------------------------------
function GetPlayers()
	local players = {}
	  for _, player in ipairs(GetActivePlayers()) do 
			players[#players + 1] = _
		end	
	return players
  end
 --[[
RegisterNetEvent('chatME')
AddEventHandler('chatME',function(id,name,message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)),GetEntityCoords(GetPlayerPed(pid))) < 3.999 then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	end
end)
 ]]
  Citizen.CreateThread(function()
	RequestAnimDict("facials@gen_male@variations@normal")
	RequestAnimDict("mp_facial")
  
	local talkingPlayers = {}
	while true do
		Citizen.Wait(300)
  
		for k,v in pairs(GetPlayers()) do
			local boolTalking = NetworkIsPlayerTalking(v)
			if v ~= PlayerId() then
				if boolTalking and not talkingPlayers[v] then
					PlayFacialAnim(GetPlayerPed(v), "mic_chatter", "mp_facial")
					talkingPlayers[v] = true
				elseif not boolTalking and talkingPlayers[v] then
					PlayFacialAnim(GetPlayerPed(v), "mood_normal_1", "facials@gen_male@variations@normal")
					talkingPlayers[v] = nil
				end
			end
		end
	end
  end)





-------------------REMOVER ARMA ABAIXO DE 0MPH DENTRO DO CARRO----------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local speed = GetEntitySpeed(vehicle)*2.236936
                if speed >= 40 then
                    SetPlayerCanDoDriveBy(PlayerId(),false)
                else
                    SetPlayerCanDoDriveBy(PlayerId(),true)
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        if x == px and y == py then
            if tempo > 0 then
                tempo = tempo - 1
                if tempo == 60 then
                    TriggerEvent("Notify","importante","Você vai ser desconectado em <b>60 segundos</b>.",2000)
                end
            else
                TriggerServerEvent("kickAFK")
            end
        else
            tempo = 2000
        end
        px = x
        py = y
    end
end)

RegisterNetEvent('changeWeaponColor')
AddEventHandler('changeWeaponColor', function(cor) 
    local tinta = tonumber(cor)
    local ped = PlayerPedId()
    local arma = GetSelectedPedWeapon(ped)
    if tinta >= 0 then
        SetPedWeaponTintIndex(ped,arma,tinta)
    end
 
end)

--bong
RegisterCommand("bong",function(source, args)
    local player = PlayerPedId()
        Citizen.CreateThread(function() 
            while 'bong' do
                Citizen.Wait(0)
                if IsEntityPlayingAnim( player, "anim@safehouse@bong", "bong_stage1", 3) then
                    DisableControlAction(0,48,true) 
                    DisableControlAction(0,37,true) 
                    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                end
            end
        end) 

    local ad = "anim@safehouse@bong"
    local prop_name = prop_name or 'prop_bong_01'
    local secondaryprop_name = secondaryprop_name or 'p_cs_lighter_01'              
        if src.checkbong() then
            if ( DoesEntityExist( player ) and not IsEntityDead( player )) and not IsPauseMenuActive() and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedShooting(PlayerPedId()) and not IsPedDiving(PlayerPedId()) and not IsPedFalling(PlayerPedId()) then 
                loadAnimDict( ad )            
                local x,y,z = table.unpack(GetEntityCoords(player))
                prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
                secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
                AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.10, -0.25, 0.0, 95.0, 190.0, 180.0, true, true, false, true, 1, true)
                AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.08, -0.05, -0.01, -50.0, 0.0, -50.0, true, true, false, true, 1, true)
                TaskPlayAnim( player, ad, "bong_stage1", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                Wait(2000)
                TriggerEvent("vrp_sound:source", 'bong', 0.2)
                Wait(7000)
                DetachEntity(prop, 1, 1)
                DeleteObject(prop)
                DetachEntity(secondaryprop, 1, 1)
                DeleteObject(secondaryprop)
                Wait(1000)
                TriggerEvent("vrp_sound:distance", source, 0.8, 'love', 0.2)
                ClearPedSecondaryTask(PlayerPedId())
                StartScreenEffect("DMT_flight",50000,false)
                LoadAnimSet("MOVE_M@DRUNK@VERYDRUNK")   
                SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.4)
                Wait(24000)
                TriggerEvent("vrp_sound:source", 'love2', 0.2)                
                Wait(25000)
                StopAllScreenEffects()
                ResetPedMovementClipset(PlayerPedId())
            end
        end    
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUIR DANO X NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if (GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,0) == ped) and GetVehicleClass(vehicle) == 8 then
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"),0.02)
			end
		else
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"),0.8)
		end
	end
end)
]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
			if GetVehicleDoorLockStatus(veh) >= 2 or GetPedInVehicleSeat(veh,-1) then
				TriggerServerEvent("TryDoorsEveryone",veh,2,GetVehicleNumberPlateText(veh))
			end
		end
	end
end)

RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler("SyncDoorsEveryone",function(veh,doors)
	SetVehicleDoorsLocked(veh,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QTH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustReleased(1,  118) then
            TriggerServerEvent("offred:qthPolicepacorabane")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NO JUMP
-----------------------------------------------------------------------------------------------------------------------------------------
local ragdoll_chance = 0.32 -- edit this decimal value for chance of falling (e.g. 80% = 0.8    75% = 0.75    32% = 0.32)

-- code, not recommended to edit below this point
print('chance of falling set to: ' .. ragdoll_chance)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100) -- check every 100 ticks, performance matters
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			print('lose grip result: ' .. chance_result)
			if chance_result < ragdoll_chance then 
				Citizen.Wait(600) -- roughly when the ped loses grip
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
				SetPedToRagdoll(ped, 5000, 1, 2)
				print('falling!')
			else
				Citizen.Wait(2000) -- cooldown before continuing
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
local agachar = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local ped = PlayerPedId()
		DisableControlAction(0,36,true)
		if not IsPedInAnyVehicle(ped) then
			RequestAnimSet("move_ped_crouched")
			RequestAnimSet("move_ped_crouched_strafing")
			if IsDisabledControlJustPressed(0,36) then
				if agachar then
					ResetPedMovementClipset(ped,0.25)
					ResetPedStrafeClipset(ped)
					agachar = false
				else
					SetPedMovementClipset(ped,"move_ped_crouched",0.25)
					SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
					agachar = true
				end
			end
		end
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE DANO
-----------------------------------------------------------------------------------------------------------------------------------------
--[[
Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local pedId = PlayerId()
    while true do
        Citizen.Wait(1)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNOWBALL"), 0.00)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMOKEGRENADE"), 0.01)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RAYPISTOL"), 0.01)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.01)
        N_0x4757f00bc6323cfe(GetHashKey("weapon_knuckle"), 0.01)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.01)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.40)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MOLOTOV"), 0.01)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BZGAS"), 0.20)
    end
end)
]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_APPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEBIDAS ENERGETICAS
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos',function(status)
	energetico = status
	if energetico then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if energetico then
			RestorePlayerStamina(PlayerId(),1.0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------

--Citizen.CreateThread(function()
  --  while true do
    --    Citizen.Wait(0)
      --  if IsControlJustReleased(0, 289) then
        --    TriggerServerEvent("aztec:inventory")
        --end
    --end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates',function()
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if IsEntityAVehicle(vehicle) then
    	SetVehicleNumberPlateText(vehicle,"CLONADOS")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
--- CONSEGUE OTIMIZAR USANDO FUNCTIONS APOS PRESSIONAR F6 EXECUTAR ESSAS FUNCOES ?
local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
	cancelando = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if cancelando then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		if x == px and y == py then
			if tempo > 0 then
				tempo = tempo - 1
			else
				TriggerServerEvent("kickAFK")
			end
		else
			tempo = 1200
		end
		px = x
		py = y
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTA-MALAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("trunk",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRE E FECHA OS VIDROS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterCommand("wins",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if vidros then
					vidros = false
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				else
					vidros = true
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("doors",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mascara")
AddEventHandler("mascara",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		vRP.playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps",1}},false)
		Wait(700)
		ClearPedTasks(ped)
		SetPedComponentVariation(ped,1,0,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP.playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps",1}},false)
		Wait(1500)
		ClearPedTasks(ped)
		SetPedComponentVariation(ped,1,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blusa")
AddEventHandler("blusa",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		SetPedComponentVariation(ped,8,15,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,8,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,8,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jaqueta")
AddEventHandler("jaqueta",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		SetPedComponentVariation(ped,11,15,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,11,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,11,parseInt(index),parseInt(color),2)
	end
end)

-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("coletes")
AddEventHandler("coletes",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		SetPedComponentVariation(ped,9,15,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,9,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,9,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("calca")
AddEventHandler("calca",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,4,18,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,4,15,0,2)
		end
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,4,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,4,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("maos")
AddEventHandler("maos",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		SetPedComponentVariation(ped,3,15,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,3,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,3,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acess
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("acessorios")
AddEventHandler("acessorios",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		SetPedComponentVariation(ped,7,0,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,7,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,7,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acess
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("sapatos")
AddEventHandler("sapatos",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,6,34,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,6,35,0,2)
		end
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,6,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,6,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chapeu")
AddEventHandler("chapeu",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","take_off_helmet_stand",1}},false)
		Wait(700)
		ClearPedProp(ped,0)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet",1}},false)
		Wait(1700)
		SetPedPropIndex(ped,0,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet",1}},false)
		Wait(1700)
		SetPedPropIndex(ped,0,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("oculos")
AddEventHandler("oculos",function(index,color)
	local ped = PlayerPedId()
	if index == nil then
		vRP.playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps",1}},false)
		Wait(400)
		ClearPedTasks(ped)
		ClearPedProp(ped,1)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP.playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps",1}},false)
		Wait(800)
		ClearPedTasks(ped)
		SetPedPropIndex(ped,1,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP.playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps",1}},false)
		Wait(800)
		ClearPedTasks(ped)
		SetPedPropIndex(ped,1,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('chatME')
AddEventHandler('chatME',function(id,name,message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	elseif pid ~= -1 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid))) < 3.999 then
			TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOW
-----------------------------------------------------------------------------------------------------------------------------------------
local reboque = nil
local rebocado = nil
RegisterCommand("tow",function(source,args)
	local vehicle = GetPlayersLastVehicle()
	local vehicletow = IsVehicleModel(vehicle,GetHashKey("flatbed"))

	if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
		rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
		if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
			TriggerServerEvent("trytow",VehToNet(vehicle),VehToNet(rebocado))
		end
	end
end)

RegisterNetEvent('synctow')
AddEventHandler('synctow',function(vehid,rebid)
	if NetworkDoesNetworkIdExist(vehid) and NetworkDoesNetworkIdExist(rebid) then
		local vehicle = NetToVeh(vehid)
		local rebocado = NetToVeh(rebid)
		if DoesEntityExist(vehicle) and DoesEntityExist(rebocado) then
			if reboque == nil then
				if vehicle ~= rebocado then
					local min,max = GetModelDimensions(GetEntityModel(rebocado))
					AttachEntityToEntity(rebocado,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
					reboque = rebocado
				end
			else
				AttachEntityToEntity(reboque,vehicle,20,-0.5,-15.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
				DetachEntity(reboque,false,false)
				PlaceObjectOnGroundProperly(reboque)
				reboque = nil
				rebocado = nil
			end
		end
	end
end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reparar')
AddEventHandler('reparar',function(vehicle)
	TriggerServerEvent("tryreparar",VehToNet(vehicle))
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				SetEntityAsMissionEntity(v,true,true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function(vehicle)
	TriggerServerEvent("trymotor",VehToNet(vehicle))
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterNetEvent('bandagem')
AddEventHandler('bandagem',function()
	local bandagem = 0
	repeat
		bandagem = bandagem + 1
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(600)
	until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100 or bandagem == 100
		TriggerEvent("Notify","sucesso","Tratamento concluido.")
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tratamento',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			TriggerClientEvent('tratamento',nplayer)
			TriggerClientEvent("Notify",nplayer,"sucesso","Tratamento iniciado, aguarde a liberação do paramédico.")
			TriggerClientEvent("Notify",source,"sucesso","Tratamento no paciente iniciado com sucesso.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tratamento')
AddEventHandler('tratamento',function()
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(600)
	until GetEntityHealth(PlayerPedId()) >= 230 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify","sucesso","Tratamento concluido.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
local carregado = false
RegisterCommand("carregar4",function(source,args)
	local ped = PlayerPedId()
	local randomico,npcs = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npcs),true)
		if not IsPedAPlayer(npcs) and distancia <= 3 and not IsPedInAnyVehicle(ped) and not IsPedInAnyVehicle(npcs) then
			if carregado then
				ClearPedTasksImmediately(carregado)
				DetachEntity(carregado,true,true)
				TaskWanderStandard(carregado,10.0,10)
				SetEntityAsMissionEntity(carregado,false,true)
				carregado = false
			else
				SetEntityAsMissionEntity(npcs,true,true)
				AttachEntityToEntity(npcs,ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,true,false,2,true)
				carregado = npcs
				sucess = true
			end
		end
	sucess,npcs = FindNextPed(randomico)
	until not sucess
	EndFindPed(randomico)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sequestro2
-----------------------------------------------------------------------------------------------------------------------------------------
local sequestrado = nil
RegisterCommand("sequestro2",function(source,args)
	local ped = PlayerPedId()
	local random,npc = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
		if not IsPedAPlayer(npc) and distancia <= 3 and not IsPedInAnyVehicle(npc) then
			vehicle = vRP.getNearestVehicle(7)
			if IsEntityAVehicle(vehicle) then
				if vRP.getCarroClass(vehicle) then
					if sequestrado then
						AttachEntityToEntity(sequestrado,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-1.2,-0.6,60.0,-90.0,180.0,false,false,false,true,2,true)
						DetachEntity(sequestrado,true,true)
						SetEntityVisible(sequestrado,true)
						SetEntityInvincible(sequestrado,false)
						SetEntityAsMissionEntity(sequestrado,false,true)
						ClearPedTasksImmediately(sequestrado)
						sequestrado = nil
					elseif not sequestrado then
						SetEntityAsMissionEntity(npc,true,true)
						AttachEntityToEntity(npc,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-0.4,-0.1,60.0,-90.0,180.0,false,false,false,true,2,true)
						SetEntityVisible(npc,false)
						--SetEntityInvincible(npc,true)
						sequestrado = npc
						complet = true
					end
					TriggerServerEvent("trymala",VehToNet(vehicle))
				end
			end
		end
		complet,npc = FindNextPed(random)
	until not complet
	EndFindPed(random)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
		if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(500)
		if Vehicle.Vehicle ~= nil then
			local ped = PlayerPedId()
			if IsControlPressed(0,244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				RequestAnimDict('missfinale_c2ig_11')
				TaskPlayAnim(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0,-8.0,-1,35,0,0,0,0)
				NetworkRequestControlOfEntity(Vehicle.Vehicle)

				if Vehicle.IsInFront then
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
				else
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
				end

				while true do
					Citizen.Wait(5)
					if IsDisabledControlPressed(0,34) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
					end

					if IsDisabledControlPressed(0,9) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
					end

					if Vehicle.IsInFront then
						SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
					else
						SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
					end

					if not IsDisabledControlPressed(0,244) then
						DetachEntity(ped,false,false)
						StopAnimTask(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0)
						break
					end
				end
			end
		end
	end
end)

--[[
local locksound = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if GetEntityHealth(ped) <= 100 then
			alreadyDead = true
			StartScreenEffect("DeathFailOut", 0, 0)
			--StartScreenEffect("ud_def_blur", 0, 0)
			if not locksound then
				locksound = true
			end
			ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
			
			local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(5) -- TODO 0
			end

			if HasScaleformMovieLoaded(scaleform) then
				Citizen.Wait(5) -- TODO 0

				Citizen.Wait(1000)

				PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
				while GetEntityHealth(PlayerPedId()) <= 100 do
					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					Citizen.Wait(5) -- TODO 0
				end

				StopScreenEffect("DeathFailOut")
				--StopScreenEffect("ud_def_blur")
				locksound = false
			end
		end
	end
end) ]]

RegisterCommand('livery', function(source, args, rawCommand)
    local Veh = GetVehiclePedIsIn(PlayerPedId())
  local livery = tonumber(args[1])

  SetVehicleLivery(Veh, livery) --CHANGE livery(id)
  drawNotification("Vehicle Livery ~r~"..livery.."~s~ loaded!")
end)

function drawNotification(Notification)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(Notification)
    DrawNotification(false, false)
end



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

--[[
---------- PERDER ITEM 

local perdedinheiroacada = 300
local perdedinheiroatual = 0


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
       if IsPedSwimming(PlayerPedId()) then
         perdedinheiroatual = perdedinheiroatual + 1
         TriggerServerEvent('perdeitem:nadando', perdedinheiroatual)
       else
         perdedinheiroatual = 0
       end

       if(perdedinheiroatual >= perdedinheiroacada) then
          perdedinheiroatual = 0
       end
  end
end)
]]


imageUrl = "https://cdn.discordapp.com/attachments/683792195530260608/764909905827463168/mercosul.png" -- 

local textureDic = CreateRuntimeTxd('duiTxd')
local object = CreateDui(imageUrl, 540, 300)
local handle = GetDuiHandle(object)
CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex", handle)
AddReplaceTexture('vehshare', 'plate01', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate02', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate03', 'duiTxd', 'duiTex') 
AddReplaceTexture('vehshare', 'plate04', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate05', 'duiTxd', 'duiTex') 

local object = CreateDui('https://i.imgur.com/Q3uw6V7.png', 540, 300) 
local handle = GetDuiHandle(object)
CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex2", handle) 
AddReplaceTexture('vehshare', 'plate01_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate02_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate03_n', 'duiTxd', 'duiTex2') 
AddReplaceTexture('vehshare', 'plate04_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate05_n', 'duiTxd', 'duiTex2') 


----- MINI MAPA DA NOVA ILHA 

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
      SetRadarAsExteriorThisFrame()
      SetRadarAsInteriorThisFrame("h4_fake_islandx",vec(4700.0,-5145.0),0,0)
  end
end)

---- RASTREADOR DE VEICULO

RegisterNetEvent('rastrear')
AddEventHandler('rastrear',function() 
	local player = PlayerPedId()
	if (IsPedSittingInAnyVehicle(player)) then 
		saveVehicle = GetVehiclePedIsIn(player,true)
		local vehicle = saveVehicle
		targetBlip = AddBlipForEntity(vehicle)
		SetBlipSprite(targetBlip,225)
		if not i then i = 0 end
		SetBlipColour(targetBlip,i)
		i=i+1
		ShowNotification("~g~Instalando rastreador.")
	else ShowNotification("~r~Você deve instalar um rastreador em um veículo.") end
end)

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end


RegisterCommand("chuveiro",function()
    local ped = PlayerPedId()
    ClearPedBloodDamage(ped)
    --print("limpado")
end)

RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
        TriggerEvent("Notify","sucesso","Sucesso","Boost de fps ligado!")
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
        TriggerEvent("Notify","sucesso","Sucesso","Boost de fps desligado!")
    end
end)


-------- TESTE DE SCRIP

-- ATIRAR DE DENTRO DO CARRO, FAZ COM QUE A MIRA FICA MEXENDO

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
	   local shot = IsPedShooting(ped)
		if shot == 1 and IsPedInAnyVehicle(ped) then
			ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06) -- só alterar o valor --
		end
	end
end)

-- DESABILITAR CAPACETE NA MOTO

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(5)  
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        if veh ~= 0 then 
            SetPedConfigFlag(PlayerPedId(),35,false) 
        end
    end
end)