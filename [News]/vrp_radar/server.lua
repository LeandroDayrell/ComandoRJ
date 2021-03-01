local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
siS = {}
Tunnel.bindInterface("vrp_radar",siS)

local contador = 1
local logradar = ""

vRP._prepare("vRP/get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_vehicle", "SELECT model FROM vrp_user_vehicles WHERE user_id = @user_id AND model = @model")

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function siS.Permissao()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,tPermissao) or vRP.hasPermission(user_id,tPermissao2) then
		return true
	else
		return false
	end
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function siS.enviarmensagem(vname,vel,title)
	local policia = vRP.getUsersByPermission(tPermissao)
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				if mensagem then
				TriggerClientEvent('chatMessage',player,"[RADAR]",{255,70,50},"O veiculo "..vname.." passou há "..tD(vel).." no radar "..title)
				PerformHttpRequest(logradar, function(err, text, headers) end, 'POST', json.encode({
										embeds = {
											{ 
												title = "REGISTRO DE RADAR",
												thumbnail = {
												url = "https://i.imgur.com/8xzisss.png"
												}, 
												fields = {
													{ 
														name = "**O VEICULO:**", 
														value = "` ["..vname.."] `"
													},
													{ 
														name = "**PASSOU HÁ:**", 
														value = "` ["..tD(vel).."] KM/h `"
													},
													{ 
														name = "**KM/h no radar:**", 
														value = "` "..title.."] `"
													}
												}, 
												footer = { 
													text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
													icon_url = "https://i.imgur.com/8xzisss.png" 
												},
												color = 15914080 
											}
										}
									}), { ['Content-Type'] = 'application/json' })
				end
				if notify then
					TriggerClientEvent("Notify",player,"aviso","O veiculo "..vname.. " passou há "..tD(vel).."KM/h no radar ")
				end
				Citizen.Wait(2000)
				contador = 1

			end)
		end
	end
end

function siS.enviarmensagem2(vname,vel,title)
	local policia = vRP.getUsersByPermission(tPermissao)
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				if mensagem then
				TriggerClientEvent('chatMessage',player,"[RADAR]",{255,70,50},"O veiculo "..vname.. " está com os documentos presos e passou há "..tD(vel).."KM/h no radar "..title)
				PerformHttpRequest(logradar, function(err, text, headers) end, 'POST', json.encode({
										embeds = {
											{ 
												title = "REGISTRO DE RADAR",
												thumbnail = {
												url = "https://i.imgur.com/8xzisss.png"
												}, 
												fields = {
													{ 
														name = "**O VEICULO:**", 
														value = "` ["..vname.."] `"
													},
													{ 
														name = "**ESTA COM OS DOCUMENTOS PRESOS E PASSOU HÁ:**", 
														value = "` ["..tD(vel).."] KM/h `"
													},
													{ 
														name = "**KM/h no radar:**", 
														value = "` "..title.."] `"
													}
												}, 
												footer = { 
													text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
													icon_url = "https://i.imgur.com/8xzisss.png" 
												},
												color = 15914080 
											}
										}
									}), { ['Content-Type'] = 'application/json' })
				end
				if notify then
					TriggerClientEvent("Notify",player,"aviso","O veiculo "..vname.. " está com os documentos presos e passou há "..tD(vel).."KM/h no radar ")
				end
				Citizen.Wait(2000)
				contador = 1
			end)
		end
	end
end

function siS.checkvehicle(vel,title)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local model,vnetid,plate,vname,lock,banned,work = vRPclient.vehList(source,7)
		if vname ~= nil then
			if model and plate then
				local puser_id = vRP.getUserByRegistration(plate)
				if puser_id then
					if contador == 1 then
						local model2 = vRP.query("vRP/get_vehicles",{ user_id = puser_id, model = vname })
						if model2[1] ~= nil then
							if model2[1].detido == 1 then
								siS.enviarmensagem2(vname,vel,title)
								contador = 2
								return
							elseif model2[1].detido == 0 then
								siS.enviarmensagem(vname,vel,title)
								contador = 2
							end
						end
					end
				end
			end
		end
	end
end
-- [[!-!]] VENDE NÃO SERGIN, MACACO BURRO [[!-!]] --