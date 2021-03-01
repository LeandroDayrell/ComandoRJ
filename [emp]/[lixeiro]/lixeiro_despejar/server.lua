local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("lixeiro_despejar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"sacodelixo",math.random(1,3)) then
			vRP.giveMoney(user_id,math.random(15,20))
			return true
		end
	end
end