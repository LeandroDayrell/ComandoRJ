---------------------------------------------------------------------
---       OTIMIZADO E CORRIGIDO POR SkipS#0001
---  MAIS SCRIPTS NO MEU DISCORD: discord.gg/nEjFW2m
---------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local ac_webhook = "https://discord.com/api/webhooks/813572068427825152/JoXFkkfUQc4QwSXtotKaAYFNgM6vOUHXYwvmzUdIZfG6wakr-6YiZRxr39sJaU8o-twS"

------------------------------------------------------------
--  CARREGAR NO OMBRO
----------------------------------------------------------------
RegisterServerEvent('cmg2_animations:syncSCRIPTFODIDO')
AddEventHandler('cmg2_animations:syncSCRIPTFODIDO', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	vRP.antiflood(source,"cmg2_animations:syncSCRIPTFODIDO",3)
	function getDistance(coords, ncoords) return #(vector3(coords.x, coords.y, coords.z) - vector3(ncoords.x, ncoords.y, ncoords.z))end

	local ped = GetPlayerPed(source) 
	local loc = GetEntityCoords(ped) 
	local nped = GetPlayerPed(targetSrc) 
	local nloc = GetEntityCoords(nped)
	
	if(getDistance(nloc,loc)<8)then	
		TriggerClientEvent('cmg2_animations:syncTargetSCRIPTFODIDO', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
		TriggerClientEvent('cmg2_animations:syncMeSCRIPTFODIDO', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
	else
		local user_id = vRP.getUserId(source)
		source = vRP.getUserSource(user_id)
		if source ~= nil then
			local reason = "ANTI HACK: 	localização:	"..loc.x..","..loc.y..","..loc.z
			vRP.setBanned(user_id,true)					
			local temp = os.date("%x  %X")
			local msg = "Puxando todos players!"
			PerformHttpRequest(ac_webhook, function(err, text, headers) end, 'POST', json.encode({content = "ANTI HACK	[ID]: "..user_id.."		"..temp.."[BAN]		[MOTIVO:"..msg.."]	"..reason}), { ['Content-Type'] = 'application/json' }) 		
			TriggerClientEvent("vrp_sound:source",source,"ban",1.0)
			Citizen.Wait(4000)
			source = vRP.getUserSource(user_id)
			vRP.kick(source,"Tentativa de bug!")						
		end
	end
end)


RegisterServerEvent('cmg2_animations:stopSCRIPTFODIDO')
AddEventHandler('cmg2_animations:stopSCRIPTFODIDO', function(targetSrc)
	TriggerClientEvent('cmg2_animations:cl_stopSCRIPTFODIDO', targetSrc)
end)

------------------------------------------------------------
-- PEGAR DE REFEM
----------------------------------------------------------------

RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)

------------------------------------------------------------
-- CAVALINHO
----------------------------------------------------------------
RegisterServerEvent('cmg2_animations:syncSCRIPTFODIDO_2')
AddEventHandler('cmg2_animations:syncSCRIPTFODIDO_2', function(target, animationLib, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)	
	vRP.antiflood(source,"cmg2_animations:syncSCRIPTFODIDO",3)
	function getDistance(coords, ncoords) return #(vector3(coords.x, coords.y, coords.z) - vector3(ncoords.x, ncoords.y, ncoords.z))end

	local ped = GetPlayerPed(source) 
	local loc = GetEntityCoords(ped) 
	local nped = GetPlayerPed(targetSrc) 
	local nloc = GetEntityCoords(nped)
	
	if(getDistance(nloc,loc)<8)then	
		TriggerClientEvent('cmg2_animations:syncTargetSCRIPTFODIDO', targetSrc, source, animationLib, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
		TriggerClientEvent('cmg2_animations:syncMeSCRIPTFODIDO', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
	else
		local user_id = vRP.getUserId(source)
		source = vRP.getUserSource(user_id)
		if source ~= nil then
			local reason = "ANTI HACK: 	localização:	"..loc.x..","..loc.y..","..loc.z
			vRP.setBanned(user_id,true)					
			local temp = os.date("%x  %X")
			local msg = "Puxando todos players!"
			PerformHttpRequest(ac_webhook, function(err, text, headers) end, 'POST', json.encode({content = "ANTI HACK	[ID]: "..user_id.."		"..temp.."[BAN]		[MOTIVO:"..msg.."]	"..reason}), { ['Content-Type'] = 'application/json' }) 		
			TriggerClientEvent("vrp_sound:source",source,"ban",1.0)
			Citizen.Wait(4000)
			source = vRP.getUserSource(user_id)
			vRP.kick(source,"Tentativa de bug!")						
		end
	end	
end)

RegisterServerEvent('cmg2_animations:stopSCRIPTFODIDO')
AddEventHandler('cmg2_animations:stopSCRIPTFODIDO', function(targetSrc)
	TriggerClientEvent('cmg2_animations:cl_stopSCRIPTFODIDO', targetSrc)
end)
