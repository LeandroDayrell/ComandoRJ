local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_payday")

salarii = {
   -- Administração
  {"Administrador.permissao", 20000},
  {"Moderador.permissao", 15000}, 
  {"Suporte.permissao", 10000},
  {"AprovadorWL.permissao", 5000},
  --{"vip.permissao", 8000},
  --{"vipppppp.permissao", 25000},
  -- Player/Jogadores
  {"Player.permissao", 500},
  -- UBER
  {"uber.permissao", 1500},
  -- PMERJ
  {"CmdGeral.permissao", 25000},
  {"Recruta.permissao", 4500},
  {"Soldado.permissao", 5000},
  {"Cabo.permissao", 6000},
  {"3Sargento.permissao", 7000},
  {"2Sargento.permissao", 8000},
  {"1Sargento.permissao", 9000},
  {"SubTenente.permissao", 10000},
  {"2Tenente.permissao", 11000},
  {"1Tenente.permissao", 12000},
  {"Capitao.permissao", 13000},
  {"Major.permissao", 14000},
  {"TenenteCoronel.permissao", 16000},
  {"Coronel.permissao", 23000},
  -- Recom PMERJ
  {"Recom.permissao", 15000},
  -- Choque PMERJ
  {"Choque.permissao", 15000},
  -- BOPE PMERJ
  {"CoronelBOPE.permissao", 20000},
  {"TenenteCoronelBOPE.permissao", 15000},
  {"MajorBOPE.permissao", 13000},
  {"CapitaoBOPE.permissao", 12000},
  {"TenenteBOPE.permissao", 11000},
  {"AspiranteBOPE.permissao", 10000},
  -- Policia Civil
  {"DelegadoGeralPC.permissao", 20000},
  {"DelegadoPC.permissao", 15000},
  {"DelegadoAdjuntoPC.permissao", 13000},
  {"InvestigadorPC.permissao", 10000},
  {"PeritoCriminalPC.permissao", 8000},
  {"EscrivaoPC.permissao", 10000},
  {"prf.permissao", 15000},
  -- SAMU
  {"ChefeSAMU.permissao", 20000},
  {"CoordenadorSAMU.permissao", 16000},
  {"MedicoSAMU.permissao", 14000},
  {"EnfermeiroSAMU.permissao", 10000},
  {"TecSAMU.permissao", 8000},
  {"SocorristaSAMU.permissao", 5000},
  -- Jornalista
   --{"vipp.permissao", 9000},
  ----
  {"Jornalista.permissao", 10000},
  {"Reporter.permissao", 11000},
  {"DiretorJornal.permissao", 12000},
  ----
    --{"vippp.permissao", 10000},
  
  -- Advocacia
  {"Juiz.permissao", 10000},
  {"PromotorDaJustica.permissao", 8000},
  {"PresidenteDaJustica.permissao", 9000},
  {"Advogado.permissao", 7500},
  -- Desempregado
 -- {"vipppp.permissao", 15000},
  
  ----
  --{"vippppppp.permissao", 30000},
  {"desempregado.permissao", 2000},
  -- VIPS
  --{"vippppp.permissao", 20000},
  -- MECANICO
  {"mecanicopay.permissao", 5000},
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
