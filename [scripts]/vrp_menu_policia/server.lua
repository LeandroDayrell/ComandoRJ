local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_menu_policia")

local cfg = module("vrp_menu_policia", "config")


vRP._prepare("vRP/vrp_menu_policia_getname", "SELECT * FROM vrp_user_identities WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_insert","INSERT IGNORE INTO vrp_menu_policia(user_id) VALUES(@user_id)")
vRP._prepare("vRP/vrp_menu_policia_checkinsert","SELECT * FROM vrp_menu_policia WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_procurarnomes_firstname", "SELECT * FROM vrp_user_identities WHERE firstname = @firstname")
vRP._prepare("vRP/vrp_menu_policia_procurarnomes_lastname", "SELECT * FROM vrp_user_identities WHERE name = @name")
vRP._prepare("vRP/vrp_menu_policia_procurarnomes_allname", "SELECT * FROM vrp_user_identities WHERE firstname = @firstname AND name = @name")
vRP._prepare("vRP/vrp_menu_policia_procurarmatricula", "SELECT * FROM vrp_user_identities WHERE registration = @registration")
vRP._prepare("vRP/vrp_menu_policia_procurarname", "SELECT * FROM vrp_user_identities")
vRP._prepare("vRP/vrp_menu_policia_procurarveiculos", "SELECT * FROM vrp_menu_policia")
vRP._prepare("vRP/vrp_menu_policia_procurarveiculos_owned", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_removerprocurado", "UPDATE vrp_menu_policia SET matriculawanted = false WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_avisos", "UPDATE vrp_menu_policia SET avisos = @avisos WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_multas", "UPDATE vrp_menu_policia SET multas = @multas WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_arrests", "UPDATE vrp_menu_policia SET arrests = @arrests WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_mandato", "UPDATE vrp_menu_policia SET mandato = @mandato WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_imagem", "UPDATE vrp_menu_policia SET image = @image WHERE user_id = @user_id")
vRP._prepare("vRP/vrp_menu_policia_adicionarprocurado", "UPDATE vrp_menu_policia SET matriculawanted = true WHERE user_id = @user_id")

-- PORTE DE ARMA
vRP.prepare("vRP/vrp_menu_policia_porte","UPDATE vrp_menu_policia SET porte = @porte WHERE user_id = @user_id")



local webhooklinkportedearma = "https://discord.com/api/webhooks/822657169555324979/bXN0S5cZKdrG3LB5pKmb3W3XQj9f2wswjXdm9vq5Si1AGcgvoxpSlEe0841eMTkapB3z"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterCommand('addporte',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
		SendWebhookMessage(webhooklinkportedearma,  "```" ..user_id.." deu porte para "..parseInt(args[1]).. "```")
		if args[1] then
			vRP.setPortedearma(parseInt(args[1]),true)
		end
	end
end)

RegisterCommand('removeporte',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
		SendWebhookMessage(webhooklinkportedearma,  "```" ..user_id.." removeu porte de "..parseInt(args[1]).. "```")
		if args[1] then
			vRP.setPortedearma(parseInt(args[1]),false)
		end
	end
end)

function vRP.setPortedearma(user_id,porte)
	vRP.execute("vRP/vrp_menu_policia_porte",{ user_id = user_id, porte = porte })
end




RegisterServerEvent('vrp_menu_policia:open_s')--
AddEventHandler('vrp_menu_policia:open_s', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
		local rows = vRP.query("vRP/vrp_menu_policia_getname", {user_id = user_id})
			
		if #rows > math.floor(0) then
			local playername = rows[math.floor(1)].firstname .. " " .. rows[math.floor(1)].name
			TriggerClientEvent("vrp_menu_policia:open_c",player,playername)
		end
	end
end)
RegisterServerEvent('vrp_menu_policia:mostrarnome_s')
AddEventHandler('vrp_menu_policia:mostrarnome_s', function(id)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local rows = vRP.query("vRP/vrp_menu_policia_getname", {user_id = id})
	if #rows > math.floor(0) then
		local name = rows[math.floor(1)].firstname
		local apelido = rows[math.floor(1)].name
		local idade = rows[math.floor(1)].age
		local registro = rows[math.floor(1)].registration
		local telefone = rows[math.floor(1)].phone
		local result = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = id})
		
		if #result > math.floor(0) then
			local arrests = {}
			local avisos = {}
			local multas = {}
			local mandato = {}
			local imagem = nil
			if result[math.floor(1)].arrests ~= "[]" then 
				arrests = json.decode(result[math.floor(1)].arrests) 
			end
			if result[math.floor(1)].avisos ~= "[]" then 
				avisos = json.decode(result[math.floor(1)].avisos) 
			end
			if result[math.floor(1)].multas ~= "[]" then 
				multas = json.decode(result[math.floor(1)].multas) 
			end
			if result[math.floor(1)].mandato ~= "[]" then 
				mandato = json.decode(result[math.floor(1)].mandato) 
			end
			if result[math.floor(1)].image ~= "none" then
				imagem = result[math.floor(1)].image
			end
			TriggerClientEvent("vrp_menu_policia:mostrarnome_c",player,name,apelido,idade,registro,telefone,result[math.floor(1)].porte,arrests,avisos,multas,mandato,imagem)					
		end
	end
end)
RegisterServerEvent('vrp_menu_policia:procurarnome_s')
AddEventHandler('vrp_menu_policia:procurarnome_s', function(primeironome,ultimonome)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local names = {}
	if primeironome ~= nil and ultimonome ~= nil then
		local rows = vRP.query("vRP/vrp_menu_policia_procurarnomes_allname", {firstname = primeironome,name = ultimonome})
		
		if #rows > math.floor(0) then
			for k,v in pairs(rows) do
				table.insert(names,{
					user_id = v.user_id,
					name = v.firstname .. " "..v.name
				})
			end
			TriggerClientEvent("vrp_menu_policia:procurarnome_c",player,names)
			 do return end
		end
	end
	if primeironome ~= nil and ultimonome == "" then
		local rows = vRP.query("vRP/vrp_menu_policia_procurarnomes_firstname", {firstname = primeironome})
		
		if #rows > math.floor(0) then
			for k,v in pairs(rows) do
				table.insert(names,{
					user_id = v.user_id,
					name = v.firstname .. " "..v.name
				})
			end
			TriggerClientEvent("vrp_menu_policia:procurarnome_c",player,names)
			do return end
		end
	end
	if ultimonome ~= nil and primeironome == "" then
		local rows = vRP.query("vRP/vrp_menu_policia_procurarnomes_lastname", {name = ultimonome})
		
		if #rows > math.floor(0) then
			for k,v in pairs(rows) do
				table.insert(names,{
					user_id = v.user_id,
					name = v.firstname .. " "..v.name
				})
			end
			TriggerClientEvent("vrp_menu_policia:procurarnome_c",player,names)
			do return end
		end
	end
end)
RegisterServerEvent('vrp_menu_policia:procurarmatricula_s')
AddEventHandler('vrp_menu_policia:procurarmatricula_s', function(matricula)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local rows = vRP.query("vRP/vrp_menu_policia_procurarmatricula", {registration = matricula})
		if #rows > math.floor(0) then
			local id = rows[math.floor(1)].user_id
			local name = rows[math.floor(1)].firstname
			local apelido = rows[math.floor(1)].name
			local idade = rows[math.floor(1)].age
			local registro = rows[math.floor(1)].registration
			local telefone = rows[math.floor(1)].phone
			local result = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = id})
				if #result > math.floor(0) then
					local arrests = {}
					local avisos = {}
					local multas = {}
					local mandato = {}
					local imagem = nil
					if result[math.floor(1)].arrests ~= "[]" then 
						arrests = json.decode(result[math.floor(1)].arrests) 
					end
					if result[math.floor(1)].avisos ~= "[]" then 
						avisos = json.decode(result[math.floor(1)].avisos) 
					end
					if result[math.floor(1)].multas ~= "[]" then 
						multas = json.decode(result[math.floor(1)].multas) 
					end
					if result[math.floor(1)].mandato ~= "[]" then 
						mandato = json.decode(result[math.floor(1)].mandato) 
					end
					if result[math.floor(1)].image ~= "none" then
						imagem = result[math.floor(1)].image
					end
					TriggerClientEvent("vrp_menu_policia:mostrarnome_c",player,name,apelido,idade,registro,telefone,result[math.floor(1)].porte,arrests,avisos,multas,mandato,imagem,id)					
				end
		end
end)
RegisterServerEvent('vrp_menu_policia:procurados_s')
AddEventHandler('vrp_menu_policia:procurados_s', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local ids = {}
	local data = {}
	local rows = vRP.query("vRP/vrp_menu_policia_procurarveiculos", {})
		if #rows > math.floor(0) then
			for k,v in pairs(rows) do
				if v.mandato ~= "[]" then
					table.insert(ids,v.user_id)
				end
			end
			local result = vRP.query("vRP/vrp_menu_policia_procurarname", {})
				if #result > math.floor(0) then
					for k,v in pairs(result) do
						for _k,_v in pairs(ids) do
							if _v == v.user_id then
								table.insert(data,{
									user_id = v.user_id,
									name = v.firstname .. " " .. v.name,
								})
							end
						end
					end
					TriggerClientEvent("vrp_menu_policia:procurados_c",player,data)
				end
		end
end)
RegisterServerEvent('vrp_menu_policia:veiculosprocurados_s')
AddEventHandler('vrp_menu_policia:veiculosprocurados_s', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local ids = {}
	local data = {}
	local image = nil
	local rows = vRP.query("vRP/vrp_menu_policia_procurarveiculos", {})
		if #rows > math.floor(0) then
			for k,v in pairs(rows) do
				if v.matriculawanted == true then
					table.insert(ids,v.user_id)
				end
			end
			local result = vRP.query("vRP/vrp_menu_policia_procurarname", {})
				if #result > math.floor(0) then
					for k,v in pairs(result) do
						for _k,_v in pairs(ids) do
							if _v == v.user_id then
								table.insert(data,{
									user_id = v.user_id,
									matricula = "P ".. v.registration,
								})
							end
						end
					end
					TriggerClientEvent("vrp_menu_policia:veiculosprocurados_c",player,data)
				end

		end

end)
RegisterServerEvent('vrp_menu_policia:mostrarveiculo_veiculos_s')
AddEventHandler('vrp_menu_policia:mostrarveiculo_veiculos_s', function(id)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local carros = {}
	local rows = vRP.query("vRP/vrp_menu_policia_getname", {user_id = id})
		if #rows > math.floor(0) then
			local name = rows[math.floor(1)].firstname
			local apelido = rows[math.floor(1)].name
			local idade = rows[math.floor(1)].age
			local registro = rows[math.floor(1)].registration
			local telefone = rows[math.floor(1)].phone
			local result = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = id})
				if #result > math.floor(0) then
					local imagem = nil
					if result[math.floor(1)].image ~= "none" then
						imagem = result[math.floor(1)].image
					end
					local result2 = vRP.query("vRP/vrp_menu_policia_procurarveiculos_owned", {user_id = id})
						if #result2 > math.floor(0) then
							for k,v in pairs(result2) do
								table.insert(carros,{
									modelo = v.vehicle
								})
							end
							TriggerClientEvent("vrp_menu_policia:mostrarveiculo_veiculos_c",player,name,apelido,idade,registro,telefone,result[math.floor(1)].porte,carros,imagem)	
						else
							TriggerClientEvent("vrp_menu_policia:mostrarveiculo_veiculos_c",player,name,apelido,idade,registro,telefone,result[math.floor(1)].porte,nil,imagem)	
						end
	
				end

		end

end)
RegisterServerEvent('vrp_menu_policia:eliminarmatriculaprocurada_s')
AddEventHandler('vrp_menu_policia:eliminarmatriculaprocurada_s', function(id)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
		vRP.query("vRP/vrp_menu_policia_removerprocurado", {user_id = id})
		TriggerClientEvent("Notify",source,"sucesso","Você removeu com sucesso!")
	else 
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!")
	end
end)
RegisterServerEvent('vrp_menu_policia:eliminaraviso_s')
AddEventHandler('vrp_menu_policia:eliminaraviso_s', function(id)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
	vRP.query("vRP/vrp_menu_policia_avisos", {user_id = id,avisos = "[]"})
		TriggerEvent('vrp_menu_policia:atualizar_s',source,id)
		TriggerClientEvent("Notify",source,"sucesso","Você removeu com sucesso!")
	else 
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!")
	end
end)
RegisterServerEvent('vrp_menu_policia:eliminarmultas_s')
AddEventHandler('vrp_menu_policia:eliminarmultas_s', function(id)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
	vRP.query("vRP/vrp_menu_policia_multas", {user_id = id,multas = "[]"})
	TriggerEvent('vrp_menu_policia:atualizar_s',source,id)
	TriggerClientEvent("Notify",source,"sucesso","Você removeu com sucesso!")
	else 
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!")
	end
end)
RegisterServerEvent('vrp_menu_policia:eliminardetencoes_s')
AddEventHandler('vrp_menu_policia:eliminardetencoes_s', function(id)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
	vRP.query("vRP/vrp_menu_policia_arrests", {user_id = id,arrests = "[]"})
	TriggerEvent('vrp_menu_policia:atualizar_s',source,id)
	TriggerClientEvent("Notify",source,"sucesso","Você removeu com sucesso!")
else 
	TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!")
end
end)
RegisterServerEvent('vrp_menu_policia:eliminarmandato_s')
AddEventHandler('vrp_menu_policia:eliminarmandato_s', function(id)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
	vRP.query("vRP/vrp_menu_policia_mandato", {user_id = id,mandato = "[]"})
	TriggerEvent('vrp_menu_policia:atualizar_s',source,id)
	TriggerClientEvent("Notify",source,"sucesso","Você removeu com sucesso!")
else 
	TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!")
end
end)
RegisterServerEvent('vrp_menu_policia:avisos_s')
AddEventHandler('vrp_menu_policia:avisos_s', function(avisos,id)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
	addavisos(avisos,id)
	TriggerEvent('vrp_menu_policia:atualizar_s',source,id)
	TriggerClientEvent("Notify",source,"sucesso","Você removeu com sucesso!")
else 
	TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!")
end
end)
RegisterServerEvent('vrp_menu_policia:detencao_s')
AddEventHandler('vrp_menu_policia:detencao_s', function(data,id)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"pmerj.permissao") then
	adddetencao(data,id)
	TriggerEvent('vrp_menu_policia:atualizar_s',source,id)
	TriggerClientEvent("Notify",source,"sucesso","Você removeu com sucesso!")
else 
	TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!")
end

end)
RegisterServerEvent('vrp_menu_policia:mandato_s')
AddEventHandler('vrp_menu_policia:mandato_s', function(data,id)
	addmandato(data,id)
	TriggerEvent('vrp_menu_policia:atualizar_s',source,id)
end)
RegisterServerEvent('vrp_menu_policia:multar_s')
AddEventHandler('vrp_menu_policia:multar_s', function(data,id,date)
	local user_id = vRP.getUserId(source)
	local multamoney = cfg.codigopenal.multas[tonumber(data)].price
	if vRP.tryFullPayment(tonumber(id),tonumber(multamoney)) then end

	addmulta(data,id,date)
	TriggerEvent('vrp_menu_policia:atualizar_s',source,id)
end)
function addavisos(avisos,id) 
	local result = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = id})
		if #result > math.floor(0) then
			local avisostable = json.decode(result[math.floor(1)].avisos)
			table.insert(avisostable,avisos)
			vRP.query("vRP/vrp_menu_policia_avisos", {user_id = id,avisos = json.encode(avisostable)})
		end
end
function adddetencao(data,id)
	local result = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = id})
		if #result > math.floor(0) then
			local datatable = json.decode(result[math.floor(1)].arrests)
			table.insert(datatable,data)
			vRP.query("vRP/vrp_menu_policia_arrests", {user_id = id,arrests = json.encode(datatable)})
		end

end
function addmandato(data,id)
	local result = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = id})
		if #result > math.floor(0) then
			local datatable = json.decode(result[math.floor(1)].mandato)
			table.insert(datatable,data)
			vRP.query("vRP/vrp_menu_policia_mandato", {user_id = id,mandato = json.encode(datatable)})
		end
end
function addmulta(data,id,date)
	local result = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = id})
		if #result > math.floor(0) then
			local datatable = json.decode(result[math.floor(1)].multas)
			local string = "["..date.."] "..cfg.codigopenal.multas[tonumber(data)].name
			table.insert(datatable,string)
			vRP.query("vRP/vrp_menu_policia_multas", {user_id = id,multas = json.encode(datatable)})
		end

end
RegisterServerEvent('vrp_menu_policia:atualizar_s')
AddEventHandler('vrp_menu_policia:atualizar_s', function(player,id)
	local rows = vRP.query("vRP/vrp_menu_policia_getname", {user_id = id})
		if #rows > math.floor(0) then
			local name = rows[math.floor(1)].firstname
			local apelido = rows[math.floor(1)].name
			local idade = rows[math.floor(1)].age
			local registro = rows[math.floor(1)].registration
			local telefone = rows[math.floor(1)].phone
			local result = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = id})
				if #result > math.floor(0) then
					local arrests = {}
					local avisos = {}
					local multas = {}
					local mandato = {}
					local imagem = nil
					if result[math.floor(1)].arrests ~= "[]" then 
						arrests = json.decode(result[math.floor(1)].arrests) 
					end
					if result[math.floor(1)].avisos ~= "[]" then 
						avisos = json.decode(result[math.floor(1)].avisos) 
					end
					if result[math.floor(1)].multas ~= "[]" then 
						multas = json.decode(result[math.floor(1)].multas) 
					end
					if result[math.floor(1)].mandato ~= "[]" then 
						mandato = json.decode(result[math.floor(1)].mandato) 
					end
					if result[math.floor(1)].image ~= "none" then
						imagem = result[math.floor(1)].image
					end
					TriggerClientEvent("vrp_menu_policia:mostrarnome_c",player,name,apelido,idade,registro,telefone,result[math.floor(1)].porte,arrests,avisos,multas,mandato,imagem)					
				end
		end
end)
RegisterServerEvent('vrp_menu_policia:imagem_s')
AddEventHandler('vrp_menu_policia:imagem_s', function(data,id)
	vRP.query("vRP/vrp_menu_policia_imagem", {user_id = id,image = data})
end)
RegisterServerEvent('vrp_menu_policia:adicionarmatricula_s')
AddEventHandler('vrp_menu_policia:adicionarmatricula_s', function(data)
	local player = source
	local rows = vRP.query("vRP/vrp_menu_policia_procurarmatricula", {registration = data})
		if #rows > math.floor(0) then
			local id = rows[math.floor(1)].user_id
			vRP.query("vRP/vrp_menu_policia_adicionarprocurado", {user_id = id})
			TriggerEvent("vrp_menu_policia:atualizar_veiculos_procurados",player)
		end
end)
RegisterServerEvent('vrp_menu_policia:atualizar_veiculos_procurados')
AddEventHandler('vrp_menu_policia:atualizar_veiculos_procurados', function(player)
	local ids = {}
	local data = {}
	local image = nil
	local rows = vRP.query("vRP/vrp_menu_policia_procurarveiculos", {})
		if #rows > math.floor(0) then
			for k,v in pairs(rows) do
				if v.matriculawanted == true then
					table.insert(ids,v.user_id)
				end
			end
			local result = vRP.query("vRP/vrp_menu_policia_procurarname", {})
				if #result > math.floor(0) then
					for k,v in pairs(result) do
						for _k,_v in pairs(ids) do
							if _v == v.user_id then
								table.insert(data,{
									user_id = v.user_id,
									matricula = "P ".. v.registration,
								})
							end
						end
					end
					TriggerClientEvent("vrp_menu_policia:veiculosprocurados_c",player,data)
				end
		end
end)
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	TriggerClientEvent("vrp_menu_policia:updatelist",source,cfg.codigopenal)
	local rows = vRP.query("vRP/vrp_menu_policia_checkinsert", {user_id = user_id})
		if #rows == math.floor(0) then
			vRP.query("vRP/vrp_menu_policia_insert", {user_id = user_id})
		end
end)