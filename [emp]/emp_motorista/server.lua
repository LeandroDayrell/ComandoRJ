local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Trap = {}
emP = {}
Tunnel.bindInterface("emp_motorista",Trap)
Tunnel.bindInterface("eventoperson",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	ac_webhook_anthack = "https://discordapp.com/api/webhooks/720475566347649066/-giS9Hox0XI_YdncklX_WLKrn4nd1qWew_X53s2d1cDpGP1Gddh2wzBfCNAQAtJMiDYW"

	function SendWebhookMessage(webhook,message)
		if webhook ~= "none" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
end)

function emP.checkPayment(bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveMoney(user_id,math.random(60,65)+bonus)
	end
end


function Trap.checkPayment(bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	id = user_id	
	local x,y,z = vRPclient.getPosition(source)
	local reason = "ANTI HACK: SPAMANDO DINHEIRO	(DINHEIRO MONSTER)-	localização:	"..x..","..y..","..z
	vRP.setBanned(id,true)					
	local temp = os.date("%x  %X")
	--vRP.logs("savedata/BANIMENTOS.txt","ANTI HACK	[ID]: "..id.."		"..temp.."[BAN]		[MOTIVO:]	"..reason)
	SendWebhookMessage(ac_webhook_anthack, "ANTI HACK	[ID]: "..id.."		"..temp.."[BAN]		[MOTIVO:]	"..reason)
	local source = vRP.getUserSource(id)
	if source ~= nil then
		--vRP.ban(source,reason)
		vRP.kick(source,"SPAMANDO DINHEIRO VAGABUNDO!")						
	end
end

