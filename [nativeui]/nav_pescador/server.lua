local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "dourado", venda = 70 },
	--{ item = "corvina", venda = 160 },
	{ item = "salmao", venda = 60 },
	{ item = "pacu", venda = 50 },
	{ item = "pirarucu", venda = 65 },
	{ item = "tilapia", venda = 50 },
	{ item = "tucunare", venda = 40 },
	{ item = "lambari", venda = 60 },
	{ item = "graos", venda = 20 },
	{ item = "mouro", venda = 20 },
	{ item = "mferro", venda = 10 },
	{ item = "mbronze", venda = 10 },
	{ item = "mrubi", venda = 20 },
	{ item = "mesmeralda", venda = 30 },
	{ item = "diamante", venda = 45 },
	{ item = "sacodelixo", venda = 33 },
	{ item = "perolatratada", venda = 900 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("pescador-vender")
AddEventHandler("pescador-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local quantidade = 0
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
						vRP.giveMoney(user_id,parseInt(v.venda*quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..quantidade.."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda*quantidade)).." reais</b>.")
					end
				else
					TriggerClientEvent("Notify",source,"aviso","Não possui <b>"..vRP.getItemName(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)