local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_payday")

salarii = {
   -- Administração
  {"Administrador.permissao", 1},
  {"Moderador.permissao", 1}, 
  {"Suporte.permissao", 1},
  {"AprovadorWL.permissao", 1},
  {"Player.permissao", 1},

  
  -- PMERJ
  {"CmdGeral.permissao", 6000},
  {"Recruta.permissao", 3000},
  {"Soldado.permissao", 3500},
  {"Cabo.permissao", 3500},
  {"3Sargento.permissao", 4000},
  {"2Sargento.permissao", 4000},
  {"1Sargento.permissao", 4000},
  {"SubTenente.permissao", 4500},
  {"2Tenente.permissao", 4500},
  {"1Tenente.permissao", 4500},
  {"Capitao.permissao", 5000},
  {"Major.permissao", 5000},
  {"TenenteCoronel.permissao", 5500},
  {"Coronel.permissao", 6000},

  -- PRF
  {"prf.permissao", 1000},
  -- SAMU
  {"ChefeSAMU.permissao", 7000},
  {"CoordenadorSAMU.permissao", 6000},
  {"MedicoSAMU.permissao", 5000},
  {"EnfermeiroSAMU.permissao", 4000},
  {"TecSAMU.permissao", 3000},
  {"SocorristaSAMU.permissao", 2000},

  -- JORNAL
  {"Jornalista.permissao", 4000},
  {"Reporter.permissao", 3000},
  {"DiretorJornal.permissao", 6000},
  
  -- Advocacia  - OBS
  {"Juiz.permissao", 6000},
  {"PromotorDaJustica.permissao", 5000},
  {"PresidenteDaOAB.permissao", 4000},

  {"desempregado.permissao", 250},

  -- MECANICO
  {"srdono.permissao", 100},
  {"srgerente.permissao", 2000},
  {"srmecanico.permissao", 1500},
  {"srauxmecanico.permissao", 1000},
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
