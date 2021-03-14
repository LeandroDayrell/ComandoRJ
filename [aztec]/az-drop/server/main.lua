local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-drop')
vAZ = {}
Tunnel.bindInterface('az-drop', vAZ)

local IDGenerator = Tools.newIDGenerator()
local drops = {}

local webhooklinkdrop = "https://discordapp.com/api/webhooks/721731913072508948/FyEy_dQc7ja6whR-dbgA28IDEWbhN2YE2IPto8Zi_uktZ0nMiXLTSIbr-aAvpFIPipt4"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterServerEvent('az-drop:createDrop')
AddEventHandler('az-drop:createDrop', function(source, item, amount, x, y, z)
	local drop = IDGenerator:gen()
	if drop ~= nil then
		vRPclient._playAnim(source, true, {{"pickup_object","pickup_low", 1}}, false)
		Citizen.Wait(50)
		drops[tostring(drop)] = {id = drop, item = item, amount = amount, x = x, y = y, z = z, name = vRP.getItemName(item), time = 300}
		vAZclient.createDrop(-1, drop, drops[tostring(drop)])
	end
end)

RegisterServerEvent('az-drop:takeItem')
AddEventHandler('az-drop:takeItem', function(drop)
	local source = source
	local user_id = vRP.getUserId(source)
	if drops[tostring(drop)] ~= nil then
		local item, amount, coords = drops[tostring(drop)].item, parseInt(drops[tostring(drop)].amount), {x = drops[tostring(drop)].x, y = drops[tostring(drop)].y, z = drops[tostring(drop)].z}
		if item == 'money' then
			drops[tostring(drop)] = nil
			IDGenerator:free(parseInt(drop))
			vAZclient.removeDrop(-1, drop)
			vRP.giveMoney(user_id, amount)
			vRPclient.playSound(source, "HUD_FRONTEND_DEFAULT_SOUNDSET", "PICK_UP")
			vRPclient.playAnim(source, true, {{"pickup_object", "pickup_low", 1}}, false)
			SendWebhookMessage(webhooklinkdrop,  "```" ..user_id.." Pegou R$" ..amount.. "```")
			--SendWebhookMessage(webhooklinkdrop, 'user_id ' ..user_id.. ', Pegou R$' ..amount.. ' nas cordenadas: '..coords.x..', '..coords.y..', '..coords.z)
			--vAZ.webhook('items', 'user_id: '..user_id..', dropou ('..amount..'x '..item..') nas cordenadas: '..coords.x..', '..coords.y..', '..coords.z)
---
		else
			if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item) * amount <= vRP.getInventoryMaxWeight(user_id) then
				drops[tostring(drop)] = nil
				IDGenerator:free(parseInt(drop))
				vAZclient.removeDrop(-1, drop)
				vRP.giveInventoryItem(user_id, item, amount)
				vRPclient.playSound(source, "HUD_FRONTEND_DEFAULT_SOUNDSET", "PICK_UP")
				vRPclient.playAnim(source, true, {{"pickup_object", "pickup_low", 1}}, false)
				--SendWebhookMessage(webhooklinkdrop,  "```" ..user_id.." Pegou- Item:" ..item.. " Qnt:"..amount.. "```")
				SendWebhookMessage(webhooklinkdrop, 'user_id ' ..user_id.. ', Pegou Item:' ..item.. ' Qnt:'..amount.. ' nas cordenadas: '..coords.x..', '..coords.y..', '..coords.z)
			else
				TriggerClientEvent('Notify', source, 'negado', "Inventário cheio")
			end
		end
	else
		TriggerClientEvent('Notify', source, 'aviso', "Parece que alguem já pegou esse item!")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for drop,item in pairs(drops) do
			if drops[tostring(drop)].time > 0 then
				drops[tostring(drop)].time = drops[tostring(drop)].time - 1
				if drops[tostring(drop)].time <= 0 then
					drops[tostring(drop)] = nil
					vAZclient.removeDrop(-1, drop)
				end
			end
		end
	end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if first_spawn then
		vAZclient.UpdateListDrops(source, drops)
	end
end)