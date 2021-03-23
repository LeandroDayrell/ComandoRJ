local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "algemas", quantidade = 1, compra = 1000, venda = 500 },
	{ item = "c4", quantidade = 1, compra = 600, venda = 300 },
	{ item = "capuz", quantidade = 1, compra = 2000, venda = 500 },
	{ item = "lockpick", quantidade = 1, compra = 3500, venda = 1000 },
	{ item = "bombaadesiva", quantidade = 1, compra = 10000, venda = 2000 },
	{ item = "masterpick", quantidade = 1, compra = 50000, venda = 25000 },
	{ item = "pendrive", quantidade = 1, compra = 50000, venda = 17500 },
	{ item = "rebite", quantidade = 1, compra = 250, venda = 125 },
	{ item = "colete", quantidade = 1, compra = 50000, venda = 2500 },
	{ item = "walkietalkie", quantidade = 1, compra = 5000, venda = 2500 },
	--CONFERIR
	{ item = "ak103pack", quantidade = 1, compra = 110000, venda = 10000 },
	{ item = "municaomusketpack", quantidade = 1, compra = 22000, venda = 10000 },
	{ item = "municaoparafalpack", quantidade = 1, compra = 22000, venda = 10000 },
	{ item = "musketpack", quantidade = 1, compra = 220000, venda = 10000 },
	{ item = "parafalpack", quantidade = 1, compra = 220000, venda = 10000 },
	{ item = "mtarpack", quantidade = 1, compra = 71000, venda = 10000 },
	{ item = "sigpack", quantidade = 1, compra = 71000, venda = 10000 },
	{ item = "pumpshotgunpack", quantidade = 1, compra = 58000, venda = 10000 },
	{ item = "uzipack", quantidade = 1, compra = 71000, venda = 10000 },
	{ item = "fivesevenpack", quantidade = 1, compra = 38500, venda = 10000 },
	{ item = "coletepack", quantidade = 1, compra = 12000, venda = 10000 },
	{ item = "snspack", quantidade = 1, compra = 22500, venda = 1000 },
	{ item = "municaofamaspack", quantidade = 1, compra = 5800, venda = 1000 },
	{ item = "municaosigpack", quantidade = 1, compra = 7100, venda = 1000 },
	{ item = "municaopumppack", quantidade = 1, compra = 7100, venda = 1000 },
	{ item = "municaoakpack", quantidade = 1, compra = 18000, venda = 1000 },
	{ item = "municaouzipack", quantidade = 1, compra = 7100, venda = 1000 },
	{ item = "municaopistolpack", quantidade = 1, compra = 3850, venda = 1000 },
	{ item = "municaosnspack", quantidade = 1, compra = 2500, venda = 1000 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("contrabandista-comprar")
AddEventHandler("contrabandista-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryFullPayment(user_id,parseInt(v.compra),true) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." reais</b>.")
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
RegisterServerEvent("contrabandista-vender")
AddEventHandler("contrabandista-vender",function(item)
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