local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("contrato_entregas",func) 
vRPclient = Tunnel.getInterface("vRP")
-- PERMISSÃO
RegisterServerEvent('contrato_entregas:permissao')
AddEventHandler('contrato_entregas:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"Advogado") then
	    TriggerClientEvent('contrato_entregas:permissao', player)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function func.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(4,5)
	end
end

function func.checkPayment()
	func.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"contrato",quantidade[source]) then
			vRP.giveMoney(user_id,math.random(500,600)*quantidade[source])
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..quantidade[source].."x Contratos</b>.")
		end
	end
end