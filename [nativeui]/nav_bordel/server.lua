local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_bordel",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "energetico", quantidade = 1, compra = 30, venda = 1 },
	{ item = "caipirinha", quantidade = 1, compra = 30, venda = 1 },
	{ item = "tequila", quantidade = 1, compra = 50, venda = 25 },
	{ item = "gin", quantidade = 1, compra = 30, venda = 1 },
	{ item = "refrigerante", quantidade = 1, compra = 20, venda = 1 },
	{ item = "agua", quantidade = 1, compra = 15, venda = 1 },
	{ item = "blackvelvet", quantidade = 1, compra = 50, venda = 25 },
	{ item = "maconha", quantidade = 1, compra = 1000, venda = 500 },
	{ item = "crack", quantidade = 1, compra = 1000, venda = 25 },
	{ item = "pendrive", quantidade = 1, compra = 10000, venda = 25 },
	{ item = "kitcostura", quantidade = 1, compra = 7000, venda = 25 },
	{ item = "cocaina", quantidade = 1, compra = 1000, venda = 25 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("bordel-comprar")
AddEventHandler("bordel-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if item == "colete" then
			if vRP.tryPayment(user_id,4000) then
				vRPclient.setArmour(source,100)
				TriggerClientEvent("Notify",source,"sucesso","Comprou <b>1x Colete</b> por <b>$4.000 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		else
			for k,v in pairs(valores) do
				if item == v.item then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.hasPermission(user_id,"bordelnav.permissao") then
						if vRP.tryPayment(user_id,parseInt(v.compra)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Voce nao tem permissao.")
					end
					
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-vender")
AddEventHandler("armamentos-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveMoney(user_id,parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." dólares</b>.")
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
	return vRP.hasPermission(user_id,"bordelnav.permissao")
end