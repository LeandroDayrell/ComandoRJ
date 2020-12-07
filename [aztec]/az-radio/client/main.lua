local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vAZserver = Tunnel.getInterface('az-radio')
vAZ = {}
Tunnel.bindInterface('az-radio', vAZ)

local webhooklinkradinho = "https://discordapp.com/api/webhooks/735681719914463307/eytrL3GvxDNfL_XJCk20vpIe-0Fxp6gPhZgWS34F1rBaVTzw2GL88YBshQ85pL1GJDDu"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local radio = false
local radioProp = nil
local radioStatus = "out"
local radioMHz = nil
local lastDict, lastAnim = nil, nil

local anims = {
	['cellphone@'] = {
		['out'] = { ['text'] = 'cellphone_text_in' },
		['text'] = { ['out'] = 'cellphone_text_out', ['text'] = 'cellphone_text_in' }
	},
	['anim@cellphone@in_car@ps'] = {
		['out'] = { ['text'] = 'cellphone_text_in' },
		['text'] = { ['out'] = 'cellphone_text_out', ['text'] = 'cellphone_text_in' }
	}
}

RegisterCommand('radio', function(source, args)
	if vAZserver.itemAmount() then
		if #args > 0 then
			if args[1] == "off" then
				local radioMHz = exports.tokovoip_script:getPlayerData(GetPlayerName(PlayerId()), "radio:channel")
				if radioMHz == "nil" or radioMHz == nil then
					TriggerEvent('Notify', 'importante', 'Você não está nenhuma frequência')
				else
					exports.tokovoip_script:removePlayerFromRadio(radioMHz)
					exports.tokovoip_script:setPlayerData(GetPlayerName(PlayerId()), "radio:channel", "nil", true)
					TriggerEvent('Notify', 'importante', 'Você deixou a frequência: <b>' .. radioMHz .. '.00 MHz </b>')         
				end
			end
		else
			if radioStatus == 'out' then TriggerEvent('azt_radio:createProp', 'text') end
			TriggerEvent("azt_radio:enableRadio", true)
		end
    end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("azt_radio:createProp")
AddEventHandler("azt_radio:createProp", function(status)
	local ped = PlayerPedId()
	if status ~= 'out' and radioStatus == 'out' then TriggerEvent('azt_radio:deleteProp') end	
	if IsPedInAnyVehicle(ped, false) then dict = "anim@cellphone@in_car@ps" else dict = "cellphone@" end

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Citizen.Wait(10) end

	local anim = anims[dict][radioStatus][status]
	if radioStatus ~= 'out' then StopAnimTask(ped, lastDict, lastAnim, 1.0)	end

	TaskPlayAnim(ped, dict, anim, 3.0, -1, -1, 50, 0, false, false, false)

	if status ~= 'out' and radioStatus == 'out' then
		Citizen.Wait(380)
		TriggerEvent('azt_radio:deleteProp')
		RequestModel("prop_cs_hand_radio")
		while not HasModelLoaded("prop_cs_hand_radio") do Citizen.Wait(10) end
		local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -5.0)
		radioProp = CreateObject(GetHashKey("prop_cs_hand_radio"), coords.x, coords.y, coords.z, true, true, true)
		SetEntityCollision(radioProp, false, false)
		AttachEntityToEntity(radioProp, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		SetEntityAsMissionEntity(radioProp, true, true)
    	SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)		
	end

	lastDict, lastAnim, radioStatus = dict, anim, status

	if status == 'out' then
		StopAnimTask(ped, lastDict, lastAnim, 1.0)
		ClearPedTasks(PlayerPedId())
		Citizen.Wait(180)
		TriggerEvent('azt_radio:deleteProp')
	end
end)

RegisterNetEvent("azt_radio:deleteProp")
AddEventHandler("azt_radio:deleteProp", function()
	if DoesEntityExist(radioProp) then    
		DetachEntity(radioProp, false, false)
		TriggerServerEvent("azt_radio:deleteObj", ObjToNet(radioProp))
		radioProp = nil
	end
end)

RegisterNetEvent("azt_radio:enableRadio")
AddEventHandler("azt_radio:enableRadio", function(enable)
	radio = enable
	SetNuiFocus(enable, enable)	
	SendNUIMessage({type = "enableRadio", enable = enable})
end)

RegisterNetEvent("azt_radio:deleteObj")
AddEventHandler("azt_radio:deleteObj", function(entity)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(entity) and entity then
			SetEntityAsMissionEntity(entity, true, true)
			SetObjectAsNoLongerNeeded(entity)
			if DoesEntityExist(NetToObj(entity)) then
				DetachEntity(NetToObj(entity), false, false)
				PlaceObjectOnGroundProperly(NetToObj(entity))
				SetEntityAsNoLongerNeeded(NetToObj(entity))
				SetEntityAsMissionEntity(NetToObj(entity), true, true)
				DeleteObject(NetToObj(entity))				
			end
		end
	end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('joinRadio', function(data, cb)
	local radios = vAZserver.getRadios()
	local item = 'walkietalkie'
	local idRadio = false
	local messageRadio = nil
	local radioMHz = exports.tokovoip_script:getPlayerData(GetPlayerName(PlayerId()), "radio:channel")
	if tonumber(data.channel) > 0 and tonumber(data.channel) <= #radios then
		for i,k in pairs(radios) do
			if i == tonumber(data.channel) then						
				if vAZserver.hasPermission(k[1]) then
					if i >= 1 and i <= 3 then
						messageRadio = 'Você se juntou ao rádio da <b>Policia</b>'
					elseif i >= 4 and i <= 5 then
						messageRadio = 'Você se juntou ao rádio dos <b>Paramedicos</b>'
					elseif  i >= 6 and i <= 7 then
						messageRadio = 'Você se juntou ao rádio da <b>Policia</b>'
					end
					item = k[2]
				else
					idRadio = true
				end
			end
		end
	end	
	if idRadio then
		TriggerEvent('Notify', 'importante', 'Você não pode participar de canais criptografados!')
		return
	end
	
	if vAZserver.itemAmount() then
		if tonumber(data.channel) ~= tonumber(radioMHz) then    
			if tonumber(data.channel) then
				exports.tokovoip_script:removePlayerFromRadio(radioMHz)
				exports.tokovoip_script:setPlayerData(GetPlayerName(PlayerId()), "radio:channel", tonumber(data.channel), true);
				exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
				if messageRadio ~= nil then
					TriggerEvent('Notify', 'importante', messageRadio)
				else
					TriggerEvent('Notify', 'importante', 'Você se juntou a frequência: <b>' .. data.channel .. '.00 MHz </b>')
					SendWebhookMessage(webhooklinkradinho,  "```" ..PlayerId.." BANIU " .. data.channel .. "```")
				end
			else
				TriggerEvent('Notify', 'importante', 'Frequencia invalida!')
			end
		else
			TriggerEvent('Notify', 'negado', 'Você já está na frequência: <b>' .. data.channel .. '.00 MHz </b>')
		end
	end
end)

RegisterNUICallback('leaveRadio', function(data, cb)
	TriggerEvent("vrp_sound:stop")
	local radioMHz = exports.tokovoip_script:getPlayerData(GetPlayerName(PlayerId()), "radio:channel")
	if radioMHz == "nil" or radioMHz == nil then
    	TriggerEvent('Notify', 'importante', 'Você não está nenhuma frequência')
  	else
		exports.tokovoip_script:removePlayerFromRadio(radioMHz)
		exports.tokovoip_script:setPlayerData(GetPlayerName(PlayerId()), "radio:channel", "nil", true)
		TriggerEvent('Notify', 'importante', 'Você deixou a frequência: <b>' .. radioMHz .. '.00 MHz </b>')         
	end
	cb(true)
end)

RegisterNUICallback('escapeRadio', function(data, cb)
	TriggerEvent("azt_radio:enableRadio", false)	
	TriggerEvent('azt_radio:createProp', 'out')
	TriggerEvent("vrp_sound:stop")
	cb(true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false, false)
	while true do
		Citizen.Wait(0)
    	if radio then
			DisableAllControlActions(0)
		end
	end	
end)