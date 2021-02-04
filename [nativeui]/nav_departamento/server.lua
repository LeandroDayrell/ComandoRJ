local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "isca", quantidade = 10, compra = 300, venda = 150 },
	{ item = "garrafavazia", quantidade = 5, compra = 15, venda = 7 },
	{ item = "pneu", quantidade = 1, compra = 1000, venda = 200 },
	{ item = "repairkit", quantidade = 1, compra = 8000, venda = 500 },
	{ item = "ferramenta", quantidade = 2, compra = 20, venda = 10 },
	{ item = "sandwich", quantidade = 1, compra = 10, venda = 1 },
	{ item = "serra", quantidade = 1, compra = 2500, venda = 5000 },
	{ item = "limonada", quantidade = 1, compra = 12, venda = 1 },
	{ item = "walkietalkie", quantidade = 1, compra = 1000, venda = 500 },

	{ item = "agua", quantidade = 1, compra = 8, venda = 1 },
	{ item = "refri", quantidade = 1, compra = 10, venda = 50 },
	{ item = "hamburguer", quantidade = 1, compra = 20, venda = 25 },
	{ item = "militec", quantidade = 1, compra = 5000, venda = 50 },

	{ item = "mochila", quantidade = 1, compra = 15000, venda = 5000 },
	{ item = "roupas", quantidade = 1, compra = 5000, venda = 500 },
	{ item = "alianca", quantidade = 1, compra = 500, venda = 150 },
	{ item = "celular", quantidade = 1, compra = 3000, venda = 1000 },

	{ item = "gin", quantidade = 1, compra = 50, venda = 9 },
	{ item = "tequila", quantidade = 3, compra = 30, venda = 15 },
	{ item = "donut", quantidade = 1, compra = 15, venda = 1 },
	{ item = "caipirinha", quantidade = 3, compra = 60, venda = 30 },
	{ item = "kebab", quantidade = 3, compra = 72, venda = 36 },
	{ item = "energetico", quantidade = 1, compra = 30, venda = 5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("departamento-comprar")
AddEventHandler("departamento-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryFullPayment(user_id,parseInt(v.compra),true) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"bom","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." reais</b>.")
					else
						TriggerClientEvent("Notify",source,"aviso","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"aviso","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("departamento-vender")
AddEventHandler("departamento-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveMoney(user_id,parseInt(v.venda))
					TriggerClientEvent("Notify",source,"bom","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." reais</b>.")
				else
					TriggerClientEvent("Notify",source,"aviso","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)