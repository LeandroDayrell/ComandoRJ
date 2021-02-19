local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
--ALTER TABLE `vrp_user_vehicles` ADD `preso` int(1) unsigned NOT NULL DEFAULT 0;

local webhooklinkdetido = "https://discordapp.com/api/webhooks/742449664925630496/eB13Id-cXLMQzlAK5YXSuxSp8XjspFgJ3q54BKS685cAcJhdAvWb0fpa8Eja4DoiGjAT"
local webhooklinkcomandopm = "https://discordapp.com/api/webhooks/720004988050341990/nFg4TmXMw0Av_2SQuYJgimmlV2WylpT9MXYDek75auC856ZVfPYt9icQJSexAcr7u6EB"
local webhooklinktooglesamu = "https://discordapp.com/api/webhooks/731907617634385962/R5yItObEcT1hKFUN6cCSYCm2sdAwiI7_6eYyaZJ1J07jUwXHRAGNI3qZlk7Q9aHu7Hs7"
local webhooklinkresamu = "https://discordapp.com/api/webhooks/731907617634385962/R5yItObEcT1hKFUN6cCSYCm2sdAwiI7_6eYyaZJ1J07jUwXHRAGNI3qZlk7Q9aHu7Hs7"
local webhooklinktooglepmrj = "https://discordapp.com/api/webhooks/734176997474828288/7S3pGgTM0toYlKUvzSXBzQQobMesSDWF3pUN2TRpkfB7ZyYAjBLPNkr0X4eY93QidxHf"
local webhooklinktoogleprf = "https://discordapp.com/api/webhooks/750590195211960390/5cIKATNczxh8Cg33tcHA6EZA9xV5pbYlhIGg_VyFmdO676G7k-cFcWdtLke1-Fk5twOD"
local webhooklinkplacadk = "https://discordapp.com/api/webhooks/750067417283035166/1ZRF18dL3TWC2TAyqU7kO-S8sWqC-HEZL77wAn0mA_-L-LFxAeZDrZoNmgKIAwACol40"
local webhooklinkhackereulen = "https://discord.com/api/webhooks/812350352069492777/7vJrMTs5Pb07Uq9V005J9lssusZ9aYxGZgjfLn-B_I6z0EUXhm_c0XgD_GbGgBYd8VAM"


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('arsenal',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent('arsenal',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('placa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		if args[1] then
			local vehicle = vRP.query("vAZ/GetVehiclesByPlate", {plate = args[1]})    
			if #vehicle > 0 then
				local identity = vRP.getUserIdentity(vehicle[1].user_id)
				if identity then
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent('chatMessage',source,"190",{65,130,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..vehicle[1].plate.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
			end
		else
			local vehicle = vRPclient.getNearestVehicle(source, 7)
			if vehicle then
				local plate = vRPclient.getPlateVehicle(source, vehicle)
				if plate ~= nil then
					local vehicle = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})    
					if #vehicle > 0 then
						local identity = vRP.getUserIdentity(vehicle[1].user_id)
						if identity then
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							TriggerClientEvent('chatMessage',source,"190",{65,130,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..vehicle[1].plate.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
						end
					else
						TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
					end
				end
			end
		end
	end
end)

RegisterCommand('placadk',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"driftking.permissao") then
		if args[1] then
			local vehicle = vRP.query("vAZ/GetVehiclesByPlate", {plate = args[1]})    
			if #vehicle > 0 then
				local identity = vRP.getUserIdentity(vehicle[1].user_id)
				if identity then
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent('chatMessage',source,"190",{65,130,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..vehicle[1].plate.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
					SendWebhookMessage(webhooklinkplacadk,  "``` PLACA DK " ..user_id.. " local "..x..","..y..","..z..  " ```")
				end
			else
			SendWebhookMessage(webhooklinkplacadk,  "``` PLACA DK " ..user_id.. " local "..x..","..y..","..z..  " ```")
				TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
			end
		else
			local vehicle = vRPclient.getNearestVehicle(source, 7)
			if vehicle then
				local plate = vRPclient.getPlateVehicle(source, vehicle)
				if plate ~= nil then
					local vehicle = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})    
					if #vehicle > 0 then
						local identity = vRP.getUserIdentity(vehicle[1].user_id)
						if identity then
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							TriggerClientEvent('chatMessage',source,"190",{65,130,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..vehicle[1].plate.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
							SendWebhookMessage(webhooklinkplacadk,  "``` PLACA DK " ..user_id.. " local "..x..","..y..","..z..  " ```")
						end
					else
						TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
					end
				end
			end
		end
	end
end)

RegisterCommand('ptr',function(source,args,rawCommand)
    local policia = vRP.getUsersByPermission("policiapatrulhamento.permissao")
    if parseInt(#policia) >= 1 then
        TriggerClientEvent('chatMessage',source,"Alerta",{255,0,0},"Policiais Militares em serviço: "..#policia)        
    else
        TriggerClientEvent('chatMessage',source,"Alerta",{255,0,0},"Nenhum policial em serviço")
    end
end)

RegisterCommand('ptrid',function(source,args,rawCommand)
    local policia = vRP.getUsersByPermission("policiapatrulhamento.permissao")
	local users_id = ""
	for k,v in pairs(policia) do
		users_id = users_id..v..", "
	end
	TriggerClientEvent('chatMessage',source,"Alerta",{255,0,0},users_id)
end)

RegisterCommand('prf',function(source,args,rawCommand)
    local policia = vRP.getUsersByPermission("policiapatrulhamentoprf.permissao")
    if parseInt(#policia) >= 1 then
        TriggerClientEvent('chatMessage',source,"Alerta",{255,0,0},"Policiais da Rodoviarios em serviço: "..#policia)        
    else
        TriggerClientEvent('chatMessage',source,"Alerta",{255,0,0},"Nenhum policial em serviço")
    end
end)

RegisterCommand('prfid',function(source,args,rawCommand)
    local policia = vRP.getUsersByPermission("policiapatrulhamentoprf.permissao")
	local users_id = ""
	for k,v in pairs(policia) do
		users_id = users_id..v..", "
	end
	TriggerClientEvent('chatMessage',source,"Alerta",{255,0,0},users_id)
end)

RegisterCommand('samuid',function(source,args,rawCommand)
    local policia = vRP.getUsersByPermission("emergency.service")
	local users_id = ""
	for k,v in pairs(policia) do
		users_id = users_id..v..", "
	end
	TriggerClientEvent('chatMessage',source,"Alerta",{255,0,0},users_id)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('paytow',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				vRP.giveMoney(nuser_id,500)
				vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
				TriggerClientEvent("Notify",source,"sucesso","Efetuou o pagamento pelo serviço do mecânico.")
				TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$500 dólares</b> pelo serviço de mecânico.")
				vRP.logs("savedata/paytow.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [FUNÇÃO]: Paytow")
			end
		end
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- MULTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('multar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local id = vRP.prompt(source,"Passaporte:","")
		local valor = vRP.prompt(source,"Valor:","")
		if id == "" or valor == "" then
			return
		end
		local value = vRP.getUData(parseInt(id),"vRP:multas")
		local multas = json.decode(value) or 0
		vRP.setUData(parseInt(id),"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
		SendWebhookMessage(webhooklinkcomandopm,  "```" ..user_id.." multou "..id.." em R$" ..valor.. "```")
		TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.")
		vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
	end
end)
--- TOOGLE ADMIN
RegisterCommand('toogleadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"AdminFRP")
	elseif vRP.hasPermission(user_id,"paisanafrp.permissao") then
		TriggerEvent('eblips:add',{ name = "ADMIN", src = source, color = 38 })
		vRP.addUserGroup(user_id,"FundadorCMDRJ")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"recom.permissao") then
		vRP.addUserGroup(user_id,"PaisanaRECOM")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanapoliciarecom.permissao") then
		vRP.addUserGroup(user_id,"RECOM")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")

----------------------------- PM RJ
--
--
--

	elseif vRP.hasPermission(user_id,"pmerj.permissaoRecruta") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJRecruta")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjRecruta.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - Recruta")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissaoSoldado") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJSoldado")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjSoldado.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - Soldado")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
	
	elseif vRP.hasPermission(user_id,"pmerj.permissaoCabo") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJCabo")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjCabo.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - Cabo")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
	
	elseif vRP.hasPermission(user_id,"pmerj.permissao3Sargento") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJ3Sargento")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerj3Sargento.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - 3° Sargento")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissao2Sargento") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJ2Sargento")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerj2Sargento.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - 2° Sargento")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissao1Sargento") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJ1Sargento")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerj1Sargento.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - 1° Sargento")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissaoSubTenente") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJSubTenente")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjSubTenente.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - Subtenente")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissao2Tenente") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJ2Tenente")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerj2Tenente.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - 2° Tenente")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissao1Tenente") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJ1Tenente")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerj1Tenente.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - 1° Tenente")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissaoCapitao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJCapitao")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjCapitao.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - Capitão")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissaoMajor") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJMajor")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjMajor.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - Major")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissaoTenenteCoronel") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJTenenteCoronel")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjTenenteCoronel.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - Tenente Coronel")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissaoCoronel") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJCoronel")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjCoronel.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"[PMRJ] - Coronel")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"pmerj.permissaoComandante") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPMERJComandante")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanapoliciapmerjComandante.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"CMD PMERJ")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglepmrj,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")

--
--
--

	elseif vRP.hasPermission(user_id,"cmdgeral.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaCMD")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanacmdgeral.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 38 })
		vRP.addUserGroup(user_id,"COMANDANTE")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
--	PRF

	elseif vRP.hasPermission(user_id,"prftoogle.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPRF")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktoogleprf,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanaprf.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial Rodoviario", src = source, color = 40 })
		vRP.addUserGroup(user_id,"[PRF] - Policial Rodoviario")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktoogleprf,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")

-- 	PC

	elseif vRP.hasPermission(user_id,"pctoogle.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPCDelegado")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanapc.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial Civil", src = source, color = 39 })
		vRP.addUserGroup(user_id,"[PCRJ] - Delegado Geral")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		
	elseif vRP.hasPermission(user_id,"pcagentetoogle.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaPCAgente")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanapcagente.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial Civil", src = source, color = 39 })
		vRP.addUserGroup(user_id,"[PCRJ] - Agente")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")


-- SAMU

	elseif vRP.hasPermission(user_id,"chefesamutoogle.permissao") then 
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaSAMUChefe")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanachefesamu.permissao") then
		TriggerEvent('eblips:add',{ name = "Samu", src = source, color = 6 })
		vRP.addUserGroup(user_id,"[CHEFE] - SAMU")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
	
	elseif vRP.hasPermission(user_id,"coordenadorsamutoogle.permissao") then 
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaSAMUCoordenador")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanacoordenadorsamu.permissao") then
		TriggerEvent('eblips:add',{ name = "Samu", src = source, color = 6 })
		vRP.addUserGroup(user_id,"[COORDENADOR] - SAMU")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"medicosamutoogle.permissao") then 
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaSAMUMedico")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanamedicosamu.permissao") then
		TriggerEvent('eblips:add',{ name = "Samu", src = source, color = 6 })
		vRP.addUserGroup(user_id,"[MÉDICO(A)] - SAMU")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"enfermeirosamutoogle.permissao") then 
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaSAMUEnfermeiro")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanaenfermeirosamu.permissao") then
		TriggerEvent('eblips:add',{ name = "Samu", src = source, color = 6 })
		vRP.addUserGroup(user_id,"[ENFERMEIRO] - SAMU")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
	
	elseif vRP.hasPermission(user_id,"enfermagemsamutoogle.permissao") then 
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaSAMUEnfermagem")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanaenfermagemsamu.permissao") then
		TriggerEvent('eblips:add',{ name = "Samu", src = source, color = 6 })
		vRP.addUserGroup(user_id,"[TÉCNICO DE ENFERMAGEM] - SAMU")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")
		
	elseif vRP.hasPermission(user_id,"socorristasamutoogle.permissao") then 
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaSAMUSocorrista")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." SAIU DO EXPEDIENTE ```")
	elseif vRP.hasPermission(user_id,"paisanasocorristasamu.permissao") then
		TriggerEvent('eblips:add',{ name = "Samu", src = source, color = 6 })
		vRP.addUserGroup(user_id,"[SOCORRISTA] - SAMU")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." INICIOU O EXPEDIENTE ```")

-- MECANICO

	elseif vRP.hasPermission(user_id,"bennystoogle.permissao") then 
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaBennys")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanabennys.permissao") then
		TriggerEvent('eblips:add',{ name = "Mecanico", src = source, color = 56 })
		vRP.addUserGroup(user_id,"Bennys")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		
	elseif vRP.hasPermission(user_id,"bennystoogledono.permissao") then 
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaBennys Dono")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanabennysdono.permissao") then
		TriggerEvent('eblips:add',{ name = "Mecanico", src = source, color = 56 })
		vRP.addUserGroup(user_id,"Bennys Dono")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")

	elseif vRP.hasPermission(user_id,"taxista.permissao") then
		vRP.addUserGroup(user_id,"PaisanaTaxista")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
	elseif vRP.hasPermission(user_id,"paisanataxista.permissao") then
		vRP.addUserGroup(user_id,"Taxista")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REANIMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reanimar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"reviver.permissao") then
		TriggerClientEvent('reanimar',source)
	end
end)

RegisterServerEvent("crj:pagamento")
AddEventHandler("crj:pagamento",function()
	local user_id = vRP.getUserId(source)
	if user_id then
		pagamento = math.random(1000,1000)
		vRP.giveMoney(user_id,pagamento)
		SendWebhookMessage(webhooklinkhackereulen,  "```" ..user_id.." esta gerando dinheiro R$" ..pagamento.. "```")
		------------------------- hacker lixo
		TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..pagamento.." dólares</b> de gorjeta do americano.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETIDO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("vAZ/SetStateVehiclePM", "UPDATE vrp_user_vehicles SET state = @state, time = @time WHERE user_id = @user_id AND plate = @plate")

RegisterCommand('detido',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source, 5)
		if vehicle then
			local plate = vRPclient.getPlateVehicle(source, vehicle)
			local owner = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})
			if #owner > 0 then
				if owner[1].state == 3 then				
					TriggerClientEvent('Notify', source, 'importante', "Este veículo já se encontra detido<br><b>Detido em:</b> "..os.date('%d/%b/%Y %H:%M:%S', owner[1].time)..".")					
					local ok = vRP.request(source, 'Deseja tirar da detenção ?', 30)
					if ok then
						vRP.execute("vAZ/SetStateVehiclePM", { user_id = owner[1].user_id, plate = owner[1].plate, state = 0, time = 0 })
						TriggerClientEvent('Notify', source, 'sucesso', "Veículo retirado da detenção.")
						SendWebhookMessage(webhooklinkdetido,  "``` VEICULO " ..user_id.." retirou da detenção o veiculo "..vname.." ID: " ..placa_user.. "```") --testando
					end
				else
					vRP.execute("vAZ/SetStateVehiclePM", { user_id = owner[1].user_id, plate = owner[1].plate, state = 3, time = parseInt(os.time()) })
					TriggerClientEvent('Notify', source, 'sucesso', "Veículo detido com sucesso.")
					SendWebhookMessage(webhooklinkdetido,  "``` VEICULO " ..user_id.." prendeu veiculo "..vname.." ID: " ..placa_user.. "```") --testando
				end
			else
				TriggerClientEvent('Notify', source, 'aviso', 'Placa inválida ou veículo de americano.')
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local player = vRP.getUserSource(parseInt(args[1]))
		vRP.setUData(parseInt(args[1]),"vRP:prisao",json.encode(parseInt(args[2])))
		vRPclient.setHandcuffed(player,false)
		TriggerClientEvent('prisioneiro',player,true)
		vRPclient.teleport(player,1680.1,2513.0,45.5)
		SendWebhookMessage(webhooklinkcomandopm,  "``` JOGADOR " ..user_id.. " " ..rawCommand.. "```")
		prison_lock(parseInt(args[1]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer == nil then
				TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..vRP.format(args[1]).."</b> indisponível no momento.")
				return
			end
			nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local banco = vRP.getBankMoney(nuser_id)
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #99cc00; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		else
			local nplayer = vRPclient.getNearestPlayer(source,2)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local banco = vRP.getBankMoney(nuser_id)
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #99cc00; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:algemar")
AddEventHandler("vrp_policia:algemar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRP.getInventoryItemAmount(user_id,"algemas") >= 1 then
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient.toggleHandcuff(nplayer)
				TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
				TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
			else
				TriggerClientEvent('cancelando',source,true)
				TriggerClientEvent('cancelando',nplayer,true)
				TriggerClientEvent('carregar',nplayer,source)
				vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
				vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
				SetTimeout(3500,function()
					vRPclient._stopAnim(source,false)
					vRPclient.toggleHandcuff(nplayer)
					TriggerClientEvent('carregar',nplayer,source)
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('cancelando',nplayer,false)
					TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
					TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
				end)
			end
		else
			if vRP.hasPermission(user_id,"policia.permissao") then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient.toggleHandcuff(nplayer)
					TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
					TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
				else
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('cancelando',nplayer,true)
					TriggerClientEvent('carregar',nplayer,source)
					vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
					vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
					SetTimeout(3500,function()
						vRPclient._stopAnim(source,false)
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent('carregar',nplayer,source)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('cancelando',nplayer,false)
						TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:carregar")
AddEventHandler("vrp_policia:carregar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polparcarregar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			TriggerClientEvent('carregar',nplayer,source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rmascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rmascara',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rchapeu',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuz',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	--if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isCapuz(nplayer) then
				vRPclient.setCapuz(nplayer)
				vRP.giveInventoryItem(user_id, 'capuz', 1, false)
				TriggerClientEvent("Notify",source,"sucesso","Capuz colocado com sucesso.")
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa não está com o capuz na cabeça.")
			end
		end
	--end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('re',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"reviver.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isInComa(nplayer) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
				TriggerClientEvent("progress",source,30000,"reanimando")
				SetTimeout(30000,function()
					vRPclient.killGod(nplayer)
					vRPclient._stopAnim(source,false)
					vRPclient.setHealth(nplayer,150)
					SendWebhookMessage(webhooklinktooglesamu,  "```" ..user_id.." reviveu " ..nplayer.. "```")
					vRP.giveMoney(user_id,300)
					TriggerClientEvent('cancelando',source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		end
	end
end)


RegisterCommand('curar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
		if vRP.hasPermission(user_id,"reviver.permissao") then
			local nplayer = vRPclient.getNearestPlayer(source,2)
			if nplayer then
				vRPclient.setHealth(nplayer,230)
			end
		else
			TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar1.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.putInNearestVehicleAsPassenger(nplayer,7)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar1.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"dinheirosujo",
	"algemas",
	"capuz",
	"lockpick",
	"ferrolho_parts",
	"docedeecstasy",
	"pastadecocaina",
	"pinodecoca",
	"pedradecrack",
	"hidrazida",
	"eter",
	"lsd",
	"pecacacaniquel",
	"placamae",
	"maquinacacaniquel",
	"metil",
	"cafeina",
	"ecstasy",
	"leitedepapoula",
	"alcaloide",
	"morfina",
	"adubo",
	"cannabis",
	"mouro",
	"mbronze",
	"mferro",
	"mrubi",
	"mesmeralda",
	"diamante",
	"pseudoefedrina",
	"anfetamina",
	"ritalina",
	"metasuja",
	"metanfetamina",
	"acetofenetidina",
	"cocaina",
	"benzoilecgonina",
	"cloridratoecgonina",
	"cloridratococa",
	"pastadecoca",
	"ak103pack",
	"coletepack",
	"snspack",
	"fivesevenpack",
	"pecadearma",
	"polvora",
	"capsula",
	"mtarpack",
	"pumpshotgunpack",
	"thompsonpack",
	"uzipack",
	"municaoakpack",
	"municaofamaspack",
	"municaopistolpack",
	"municaopumppack",
	"municaothompsonpack",
	"municaouzipack",
	"masterpick",
	"maconha",
	"placa",
	"rebite",
	"orgao",
	"etiqueta",
	"pendrive",
	"relogioroubado",
	"pulseiraroubada",
	"anelroubado",
	"colarroubado",
	"brincoroubado",
	"carteiraroubada",
	"carregadorroubado",
	"tabletroubado",
	"sapatosroubado",
	"vibradorroubado",
	"walkietalkie",
	"perfumeroubado",
	"maquiagemroubada",
	"colete",
	"wbody|WEAPON_DAGGER",
	"wbody|WEAPON_BAT",
	"wbody|WEAPON_BOTTLE",
	"wbody|WEAPON_CROWBAR",
	"wbody|WEAPON_FLASHLIGHT",
	"wbody|WEAPON_GOLFCLUB",
	"wbody|WEAPON_HAMMER",
	"wbody|WEAPON_HATCHET",
	"wbody|WEAPON_KNUCKLE",
	"wbody|WEAPON_KNIFE",
	"wbody|WEAPON_MACHETE",
	"wbody|WEAPON_SWITCHBLADE",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_WRENCH",
	"wbody|WEAPON_BATTLEAXE",
	"wbody|WEAPON_POOLCUE",
	"wbody|WEAPON_STONE_HATCHET",
	"wbody|WEAPON_PISTOL",
	"wbody|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_APPISTOL",
	"wbody|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_SNIPERRIFLE",
	"wbody|WEAPON_COMBATMG",
	"wbody|WEAPON_SMG",
	"wbody|WEAPON_PUMPSHOTGUN_MK2",
	"wbody|WEAPON_STUNGUN",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_SNSPISTOL",
	"wbody|WEAPON_MICROSMG",
	"wbody|WEAPON_ASSAULTRIFLE",
	"wammo|WEAPON_SPECIALCARBINE",
	"wbody|WEAPON_SPECIALCARBINE",
	"wbody|WEAPON_FIREEXTINGUISHER",
	"wbody|WEAPON_FLARE",
	"wbody|WEAPON_REVOLVER",
	"wbody|WEAPON_PISTOL_MK2",
	"wbody|WEAPON_VINTAGEPISTOL",
	"wbody|WEAPON_MUSKET",
	"wbody|WEAPON_GUSENBERG",
	"wbody|WEAPON_ASSAULTSMG",
	"wbody|WEAPON_COMBATPDW",
	"wammo|WEAPON_DAGGER",
	"wammo|WEAPON_SNIPERRIFLE",
	"wammo|WEAPON_COMBATMG",
	"wammo|WEAPON_BAT",
	"wammo|WEAPON_BOTTLE",
	"wammo|WEAPON_CROWBAR",
	"wammo|WEAPON_FLASHLIGHT",
	"wammo|WEAPON_GOLFCLUB",
	"wammo|WEAPON_HAMMER",
	"wammo|WEAPON_HATCHET",
	"wammo|WEAPON_KNUCKLE",
	"wammo|WEAPON_KNIFE",
	"wammo|WEAPON_MACHETE",
	"wammo|WEAPON_SWITCHBLADE",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_WRENCH",
	"wammo|WEAPON_BATTLEAXE",
	"wammo|WEAPON_POOLCUE",
	"wammo|WEAPON_STONE_HATCHET",
	"wammo|WEAPON_PISTOL",
	"wammo|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_APPISTOL",
	"wammo|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_SMG",
	"wammo|WEAPON_PUMPSHOTGUN_MK2",
	"wammo|WEAPON_STUNGUN",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_SNSPISTOL",
	"wammo|WEAPON_MICROSMG",
	"wammo|WEAPON_ASSAULTRIFLE",
	"wammo|WEAPON_FIREEXTINGUISHER",
	"wammo|WEAPON_FLARE",
	"wammo|WEAPON_REVOLVER",
	"wammo|WEAPON_PISTOL_MK2",
	"wammo|WEAPON_VINTAGEPISTOL",
	"wammo|WEAPON_MUSKET",
	"wammo|WEAPON_GUSENBERG",
	"wammo|WEAPON_ASSAULTSMG",
	"wammo|WEAPON_COMBATPDW"
}

RegisterCommand('apreender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local weapons = vRPclient.replaceWeapons(nplayer,{})
				for k,v in pairs(weapons) do
					vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
					if v.ammo > 0 then
						vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
					end
				end

				local inv = vRP.getInventory(nuser_id)
				for k,v in pairs(itemlist) do
					local sub_items = { v }
					if string.sub(v,1,1) == "*" then
						local idname = string.sub(v,2)
						sub_items = {}
						for fidname,_ in pairs(inv) do
							if splitString(fidname,"|")[1] == idname then
								table.insert(sub_items,fidname)
							end
						end
					end

					for _,idname in pairs(sub_items) do
						local amount = vRP.getInventoryItemAmount(nuser_id,idname)
						if amount > 0 then
							local item_name,item_weight = vRP.getItemDefinition(idname)
							if item_name then
								if vRP.tryGetInventoryItem(nuser_id,idname,amount,true) then
									vRP.giveInventoryItem(user_id,idname,amount)
								end
							end
						end
					end
				end
				TriggerClientEvent("Notify",nplayer,"importante","Todos os seus pertences foram apreendidos.")
				TriggerClientEvent("Notify",source,"importante","Apreendeu todos os pertences da pessoa.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('extras',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		if vRPclient.isInVehicle(source) then
			TriggerClientEvent('extras',source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryextras")
AddEventHandler("tryextras",function(index,extra)
	TriggerClientEvent("syncextras",-1,index,parseInt(extra))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cone',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		TriggerClientEvent('cone',source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('barreira',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		TriggerClientEvent('barreira',source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('spike',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent('spike',source,args[1])
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('atirando')
AddEventHandler('atirando',function(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"policia.permissao") then
			local policiais = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(policiais) do
				local player = vRP.getUserSource(w)
				if player then
					TriggerClientEvent('notificacao',player,x,y,z,user_id)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('anuncio',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local identity = vRP.getUserIdentity(user_id)
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(0,128,192,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 7%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: "..identity.name.." "..identity.firstname)
		SetTimeout(30000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(30000,function()
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			local tempo = json.decode(value) or 0

			if tempo == -1 then
				return
			end

			if tempo > 0 then
				TriggerClientEvent('prisioneiro',player,true)
				vRPclient.teleport(player,1680.1,2513.0,46.5)
				prison_lock(parseInt(user_id))
			end
		end)
	end
end)

function prison_lock(target_id)
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent("Notify",player,"importante","Ainda vai passar <b>"..parseInt(tempo).." meses</b> preso.")
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(parseInt(tempo)-1))
				prison_lock(parseInt(target_id))
			elseif parseInt(tempo) == 0 then
				TriggerClientEvent('prisioneiro',player,false)
				vRPclient.teleport(player,1850.5,2604.0,45.5)
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(-1))
				TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente.")
			end
			vRPclient.killGod(player)
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUIR PENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("diminuirpenacrj")
AddEventHandler("diminuirpenacrj",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0
	if tempo >= 5 then
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo)-2))
		TriggerClientEvent("Notify",source,"importante","Sua pena foi reduzida em <b>2 meses</b>, continue o trabalho.")
	else
		TriggerClientEvent("Notify",source,"importante","Atingiu o limite da redução de pena, não precisa mais trabalhar.")
	end
end)