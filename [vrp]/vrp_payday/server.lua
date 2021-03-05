local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_payday")

salarii = {
  -- PMERJ
  {"CmdGeral.permissao", 3000},
  {"Recruta.permissao", 1500},
  {"Soldado.permissao", 1700},
  {"Cabo.permissao", 1800},
  {"3Sargento.permissao", 2000},
  {"2Sargento.permissao", 2000},
  {"1Sargento.permissao", 2000},
  {"SubTenente.permissao", 2200},
  {"2Tenente.permissao", 2200},
  {"1Tenente.permissao", 2200},
  {"Capitao.permissao", 2500},
  {"Major.permissao", 2500},
  {"TenenteCoronel.permissao", 2700},
  {"Coronel.permissao", 3000},
  -- PRF
  {"prf.permissao", 1000},
  -- SAMU
  {"ChefeSAMU.permissao", 3500},
  {"CoordenadorSAMU.permissao", 3000},
  {"MedicoSAMU.permissao", 2500},
  {"EnfermeiroSAMU.permissao", 2000},
  {"TecSAMU.permissao", 1500},
  {"SocorristaSAMU.permissao", 1000},
  -- JORNAL
  {"Jornalista.permissao", 2000},
  {"Reporter.permissao", 1500},
  {"DiretorJornal.permissao", 3000},
    -- Advocacia
  {"Juiz.permissao", 3000},
  {"PromotorDaJustica.permissao", 2500},
  {"PresidenteDaOAB.permissao", 2000},
  {"desempregado.permissao", 250},
  -- MECANICO
  {"srdono.permissao", 700},
  {"srgerente.permissao", 700},
  {"srmecanico.permissao", 600},
  {"srauxmecanico.permissao", 500},
}

RegisterServerEvent('crj:lot')
AddEventHandler('crj:lot', function(lot)
	local user_id = vRP.getUserId(source)
	for i,v in pairs(salarii) do
		permisiune = v[1]
		if vRP.hasPermission(user_id, permisiune)then
			lot = v[2]
			vRP.giveBankMoney(user_id,lot)
			TriggerClientEvent('chatMessage',source,"GOVERNO",{255,70,50},"Seu salário de ^1$"..lot.." ^0 foi depositado em sua conta bancária.")
		end
	end
end)
