local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_logshack",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookhack = "https://discordapp.com/api/webhooks/711864267598462999/khc1tl_o0nY_RnpZmtmqmI1KwP53T1TQf4PiApdWTNAqEpm4phGO5iBa_1vryilagkou"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

--------------------------------------
-- WEB

function func.buttonInsert()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		SendWebhookMessage(webhookhack, "``` O ID: " ..user_id.. " PRESSIONOU [INSERT].```")
	end
end
function func.buttonfOnze()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		SendWebhookMessage(webhookhack, "``` O ID: " ..user_id.. " PRESSIONOU [F11].```")
	end
end

function func.buttonfNove()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		SendWebhookMessage(webhookhack, "``` O ID: " ..user_id.. " PRESSIONOU [F11].```")
	end
end
