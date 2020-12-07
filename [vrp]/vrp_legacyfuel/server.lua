local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vrp_legacyfuel:pagamentopejout")
AddEventHandler("vrp_legacyfuel:pagamentopejout",function(price,galao)
	local user_id = vRP.getUserId(source)
	if user_id and price > 0 then
		if vRP.tryPayment(user_id,price) then
			if galao then
				TriggerClientEvent('vrp_legacyfuel:galaopejout',source)
				TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..vRP.format(price).." dólares</b> pelo <b>Galão</b>.")
			else
				TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..vRP.format(price).." dólares</b> em combustível.")
			end
		else
			TriggerClientEvent('vrp_legacyfuel:insuficientepejout',source)
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
		end
	end
end)