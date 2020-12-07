local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()


function vRP.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end

-- ORGANIZAÇÕES

-- MILICIA  CONTRATAR
RegisterCommand('contratarmiliciagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.milicia") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				vRP.addUserGroup(parseInt(args[1]),"[Milicia] - Gerente")
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('contratarmiliciamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.milicia") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro?, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[Milicia] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro.")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- MILICIA DEMITIR
RegisterCommand('demitirmiliciagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.milicia") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[Milicia] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitirmiliciamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.milicia") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[Milicia] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

-- SAMU CONTRATAR
RegisterCommand('contratarsamusocorrista',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samu") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Socorrista da Samu, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				vRP.addUserGroup(parseInt(args[1]),"[SOCORRISTA] - SAMU")
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Socorrista da Samu")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('contratarsamutecefm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samu") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Tecnico de Enfermagem da Samu, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				vRP.addUserGroup(parseInt(args[1]),"[TÉCNICO DE ENFERMAGEM] - SAMU")
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Tecnico de Enfermagem da Samu")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('contratarsamuefm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samu") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Enfermeiro da Samu, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				vRP.addUserGroup(parseInt(args[1]),"[ENFERMEIRO] - SAMU")
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Enfermeiro da Samu")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('contratarsamumed',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samu") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Medico da Samu, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				vRP.addUserGroup(parseInt(args[1]),"[MÉDICO(A)] - SAMU")
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Medico da Samu")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('contratarsamucoord',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samucoord") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Coordenador da Samu, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				vRP.addUserGroup(parseInt(args[1]),"[COORDENADOR] - SAMU")
				TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Coordenador da Samu")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

-- DEMITIR SAMU
RegisterCommand('demitirsamusocorrista',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samu") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[SOCORRISTA] - SAMU")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('demitirsamutecefm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samu") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[TÉCNICO DE ENFERMAGEM] - SAMU")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('demitirsamuefm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samu") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[ENFERMEIRO] - SAMU")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('demitirsamumed',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samu") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[MÉDICO(A)] - SAMU")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

RegisterCommand('demitirsamucoord',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.samucoord") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[COORDENADOR] - SAMU")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end	
end)

-------------------------------------------------

-- MAFIA  CONTRATAR
RegisterCommand('contratarmafiagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.mafia") then
		if args[1] then
		TriggerClientEvent("Notify",source,"sucesso","Passaporte: "..parseInt(args[1]).." Como Gerente,")
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[MAFIA] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou o Passaporte: "..parseInt(args[1]).." como Gerente da Mafia!")
			TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50},"Você adicionou o Passaporte:  "..parseInt(args[1]).." como Gerente da Mafia!")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contratarmafiamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.mafia") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[MAFIA] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- MAFIA DEMITIR
RegisterCommand('demitirmafiagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.mafia") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[MAFIA] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitirmafiamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.mafia") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[MAFIA] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)
---------------------------------------

-- YAKUZA  CONTRATAR
RegisterCommand('contrataryakuzagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"yakuzaliderentrada.permissao") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[YAKUZA] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contrataryakuzamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"yakuzaliderentrada.permissao") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[YAKUZA] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro.")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- YAKUZA DEMITIR
RegisterCommand('demitiryakuzagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"yakuzaliderentrada.permissao") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[YAKUZA] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitiryakuzamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"yakuzaliderentrada.permissao") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[YAKUZA] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- MOTOCLUB  CONTRATAR
RegisterCommand('contratarmcgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.mc") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[MOTOCLUB] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contratarmcmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.mc") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[MOTOCLUB] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- MOTOCLUB DEMITIR
RegisterCommand('demitirmcgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.mc") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[MOTOCLUB] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitirmcmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.mc") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[MOTOCLUB] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)




-- DK  CONTRATAR
RegisterCommand('contratardkgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.dk") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[D.K] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contratardkmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.dk") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[D.K] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- DK DEMITIR
RegisterCommand('demitirdkgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.dk") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[D.K] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitirdkmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.dk") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[D.K] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)


-- BORDEL  CONTRATAR
RegisterCommand('contratarvanillagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.bordel") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[Vanilla] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contratarvanillamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.bordel") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[Vanilla] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- BORDEL DEMITIR
RegisterCommand('demitirvanillagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.bordel") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[Vanilla] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitirvanillamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.bordel") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[Vanilla] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-------- FACÇÕES

-- COMANDO VERMELHO  CONTRATAR
RegisterCommand('contratarcvgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.cv") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[C.V] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contratarcvmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.cv") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[C.V] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- COMANDO VERMELHO DEMITIR
RegisterCommand('demitircvgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.cv") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[C.V] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitircvmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.cv") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[C.V] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- PCC  CONTRATAR
RegisterCommand('contratarpccgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.pcc") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[P.C.C] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contratarpccmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.pcc") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[P.C.C] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- PCC DEMITIR
RegisterCommand('demitirpccgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.pcc") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[P.C.C] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitirpccmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.pcc") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[P.C.C] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)




-- TCP  CONTRATAR
RegisterCommand('contratartcpgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.tcp") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[T.C.P] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contratartcpmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.tcp") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[T.C.P] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- TCP DEMITIR
RegisterCommand('demitirtcpgerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.tcp") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[T.C.P] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitirtcpmembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.tcp") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[T.C.P] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- ADA  CONTRATAR
RegisterCommand('contrataradagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.ada") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente Da ADA? Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[A.D.A] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contrataradamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.ada") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro Da ADA? Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[A.D.A] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- ADA DEMITIR
RegisterCommand('demitiradagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.ada") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[A.D.A] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitiradamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.ada") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[A.D.A] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)






-- TCA  CONTRATAR
RegisterCommand('contratartcagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.tca") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente Da TCA? Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[T.C.A] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('contratartcamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.tca") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro Da TCA? Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"[T.C.A] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um Gerente")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

-- TCA DEMITIR
RegisterCommand('demitirtcagerente',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.tca") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[T.C.A] - Gerente")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)

RegisterCommand('demitirtcamembro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"contratar.tca") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"[T.C.A] - Membro")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)




-- BENNYS
RegisterCommand('contratarbennys',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"bennystoogledono.permissao") then
		if args[1] then
		local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como ? Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			vRP.addUserGroup(parseInt(args[1]),"Bennys")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou um funcionario na bennys")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)


-- BENNYS DEMITIR
RegisterCommand('demitirbennys',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"bennystoogledono.permissao") then
		if args[1] then
		vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." removeu "..rawCommand.." .")
			vRP.removeUserGroup(parseInt(args[1]),"Bennys")
			TriggerClientEvent("Notify",source,"sucesso","Você demitiu ["..rawCommand"]")
		end
	else 
	TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	end
	
end)
