local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("weazel.permissao",func) 
vRPclient = Tunnel.getInterface("vRP")
-- PERMISSÃO
RegisterServerEvent('weazel.permissao:permissao')
AddEventHandler('weazel.permissao:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"Jornalista") then
	    TriggerClientEvent('weazel.permissao:permissao', player)
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
		if vRP.tryGetInventoryItem(user_id,"jornal",quantidade[source]) then
			vRP.giveMoney(user_id,math.random(25,30)*quantidade[source])
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..quantidade[source].."x Jornais</b>.")
		end
	end
end