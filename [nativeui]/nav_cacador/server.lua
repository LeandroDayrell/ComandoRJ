local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Citizen.CreateThread(function()
	ac_webhook_anthack = "https://discordapp.com/api/webhooks/720475566347649066/-giS9Hox0XI_YdncklX_WLKrn4nd1qWew_X53s2d1cDpGP1Gddh2wzBfCNAQAtJMiDYW"
	function SendWebhookMessage(webhook,message)
		if webhook ~= "none" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "carnedecormorao", venda = 450 },
	{ item = "carnedecorvo", venda = 450 },
	{ item = "carnedeaguia", venda = 450 },
	{ item = "carnedecervo", venda = 380 },
	{ item = "carnedecoelho", venda = 350 },
	{ item = "carnedecoyote", venda = 500 },
	{ item = "carnedelobo", venda = 500 },
	{ item = "carnedepuma", venda = 400 },
	{ item = "carnedejavali", venda = 450 },
	{ item = "etiqueta", venda = 350 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
local ultima_venda = {}
local qtd_venda = {}
RegisterServerEvent("cacador-vender")
AddEventHandler("cacador-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local quantidade = 0
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		for k,v in pairs(valores) do
			if item == v.item then
				for i,o in pairs(data.inventory) do
					if i == item then
						quantidade = o.amount
					end
				end
				if parseInt(quantidade) > 0 then
					if vRP.tryGetInventoryItem(user_id,v.item,quantidade) then
						vRP.giveMoney(user_id,parseInt(v.venda*quantidade),"[nav_caçador]")
						TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..quantidade.."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda*quantidade)).." reais</b>.")
						if(ultima_venda[user_id]==nil)then
							ultima_venda[user_id] = os.time()
							qtd_venda[user_id] = 1
						else
							local intervalo = os.time() - ultima_venda[user_id]
							if(intervalo > 5)then
								qtd_venda[user_id] = 1				
							else
								qtd_venda[user_id] = qtd_venda[user_id] + 1		
								if(qtd_venda[user_id]>15)then					
									id = user_id	
									local x,y,z = vRPclient.getPosition(source)
									local reason = "ANTI HACK: SPAMANDO DINHEIRO	(1)-	localização:	"..x..","..y..","..z
									vRP.setBanned(id,true)					
									local temp = os.date("%x  %X")
									vRP.logs("savedata/BANIMENTOS.txt","ANTI HACK	[ID]: "..id.."		"..temp.."[BAN]		[MOTIVO:]	"..reason)
									if(ac_webhook_anthack ~=nil)then
										SendWebhookMessage(ac_webhook_anthack, "ANTI HACK	[ID]: "..id.."		"..temp.."[BAN]		[MOTIVO:]	"..reason)
									end
									local source = vRP.getUserSource(id)
									if source ~= nil then
										vRP.kick(source,"SPAMANDO DINHEIRO VAGABUNDO!")						
									end
								end
							end			
							ultima_venda[user_id] = os.time()
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..vRP.getItemName(v.item).."s</b> em sua mochila.")
				end
			end
		end
	end
end)