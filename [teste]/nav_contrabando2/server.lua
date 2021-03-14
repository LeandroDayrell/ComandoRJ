local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_contrabando2",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "algemas", quantidade = 1, compra = 1300, venda = 500 },
	{ item = "capuz", quantidade = 1, compra = 2600, venda = 500 },
	{ item = "lockpick", quantidade = 1, compra = 4500, venda = 1000 },
	{ item = "bombaadesiva", quantidade = 1, compra = 13000, venda = 2000 },
	{ item = "masterpick", quantidade = 1, compra = 65000, venda = 25000 },
	{ item = "pendrive", quantidade = 1, compra = 25000, venda = 17500 },
	{ item = "rebite", quantidade = 1, compra = 2500, venda = 125 },
	{ item = "colete", quantidade = 1, compra = 50000, venda = 2500 },
	--{ item = "placa", quantidade = 1, compra = 9999, venda = 2500 },
	{ item = "walkietalkie", quantidade = 1, compra = 6500, venda = 2500 },
	--
	{ item = "ak103pack", quantidade = 1, compra = 143000, venda = 10000 },
	---
	{ item = "municaomusketpack", quantidade = 1, compra = 28600, venda = 10000 },
	{ item = "municaoparafalpack", quantidade = 1, compra = 28600, venda = 10000 },
	
	{ item = "musketpack", quantidade = 1, compra = 286000, venda = 10000 },
	{ item = "parafalpack", quantidade = 1, compra = 286000, venda = 10000 },
	---
	{ item = "mtarpack", quantidade = 1, compra = 92300, venda = 10000 },
	{ item = "sigpack", quantidade = 1, compra = 92300, venda = 10000 },
	{ item = "pumpshotgunpack", quantidade = 1, compra = 75400, venda = 10000 },
	{ item = "uzipack", quantidade = 1, compra = 92300, venda = 10000 },
	{ item = "fivesevenpack", quantidade = 1, compra = 50000, venda = 10000 },
	{ item = "coletepack", quantidade = 1, compra = 15600, venda = 10000 },
	{ item = "snspack", quantidade = 1, compra = 29250, venda = 1000 },
	{ item = "municaofamaspack", quantidade = 1, compra = 7540, venda = 10000 },
	{ item = "municaosigpack", quantidade = 1, compra = 9230, venda = 1000 },
	{ item = "municaopumppack", quantidade = 1, compra = 9230, venda = 1000 },
	{ item = "municaoakpack", quantidade = 1, compra = 23000, venda = 1000 },
	{ item = "municaouzipack", quantidade = 1, compra = 9230, venda = 1000 },
	{ item = "municaopistolpack", quantidade = 1, compra = 5100, venda = 1000 },
	{ item = "municaosnspack", quantidade = 1, compra = 3000, venda = 1000 },
	--
	--[[{ item = "cano_parts", quantidade = 1, compra = 90000},
	{ item = "carregador_parts", quantidade = 1, compra = 20000},
	{ item = "ferrolho_parts", quantidade = 1, compra = 30000},
	{ item = "canoestendido_parts", quantidade = 1, compra = 150000},
	{ item = "polvora", quantidade = 1, compra = 2000},
	{ item = "capsula", quantidade = 1, compra = 2000},
	{ item = "kevlar", quantidade = 1, compra = 8000},
	{ item = "kitcostura", quantidade = 1, compra = 8000},]]
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("crj-comprar2")
AddEventHandler("crj-comprar2",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"dinheirosujo",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares sujos</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro sujo insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR 2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("contrabandoarmas-comprar2")
AddEventHandler("contrabandoarmas-comprar2",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"dinheirosujo",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares sujos</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro sujo insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR 3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("contrabandomuni-comprar2")
AddEventHandler("contrabandomuni-comprar2",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"dinheirosujo",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares sujos</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro sujo insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("contrabando-vender2")
AddEventHandler("contrabando-vender2",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." dólares sujos</b>.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mercadonegro.permissao")
end