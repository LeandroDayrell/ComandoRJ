local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_paydayvip")

salariio = {
	{"vip.permissao", 3000},
	{"vipp.permissao", 4000},
	{"vippp.permissao", 5000},
	{"vipppp.permissao", 6000},
	{"vippppp.permissao", 7000},
	{"vipppppp.permissao", 8000},
	{"vippppppp.permissao", 90000},
}

RegisterServerEvent('crj:dpt')
AddEventHandler('crj:dpt', function(dpt)
	local user_id = vRP.getUserId(source)
	for i,v in pairs(salariio) do
		permisiune = v[1]
		if vRP.hasPermission(user_id, permisiune)then
			dpt = v[2]
			vRP.giveBankMoney(user_id,dpt)
			TriggerClientEvent('chatMessage',source,"GOVERNO",{255,70,50},"Seu salário de ^1$"..dpt.." ^0 foi depositado em sua conta bancária.")
		end
	end
end)
