local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_vendadeveiculo",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooklinkvendadeveiculo = "https://discordapp.com/api/webhooks/750764311453892690/giHQfuhvC6QzCTSYgUR2a8Y1AZ5gfufWbmnA54PBvEJKmLadDo3rTFsDXo_U3JlbF6lt"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"Player.permissao")
end


function emP.certeza()
local source = source
local user_id = vRP.getUserId(source)
local plate = vRPclient.getPlateVehicle(source, vehicle)  
local owner = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})
	if #owner > 0 then
		local model = vRP.query('vAZ/getVehicleByModel', {model = owner[1].model})    
		if #model > 0 then
				local plate, nome, precoCarro, proibido, vnet, veiculo = vRP.ModelName2()
				local ok = vRP.request(source,"Você deseja vender este carro por R$" ..parseInt(model[1].price) * 0.4 .. " reais ?",30) 
				if ok then
				return ok
				else 
			end
			--TriggerClientEvent("Notify",source,"aviso","Você negou a venda.")
		end
	end
end

function emP.checkVehicle()
	local source = source
	local user_id = vRP.getUserId(source)
	local vehicle = vRPclient.getNearestVehicle(source, 5)
	if vehicle then
		local plate = vRPclient.getPlateVehicle(source, vehicle)  
		local owner = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})
		if user_id ~= owner[1].user_id then
			TriggerClientEvent("Notify",source,"aviso","Esse veículo não é seu!.")
			return false
		end
		if #owner <= 0 then
			TriggerClientEvent("Notify",source,"aviso","Veículo não encontrado na lista do proprietário.")
			return false
		elseif #owner > 0 then			
			if user_id == owner[1].user_id then
				if parseInt(owner[1].state) == 4 then
					TriggerClientEvent("Notify",source,"aviso","Veículo encontra-se apreendido na seguradora.")
					return false
				end
				local model = vRP.query('vAZ/getVehicleByModel', {model = owner[1].model})    
				if #model > 0 then
					if model[1].banned then
						TriggerClientEvent("Notify",source,"aviso","Veículos de serviço ou alugados não podem ser desmanchados.")
						return false
					end
				end
				return true
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Modelo do veículo não encontrado.")
			return false
		end
	end
	return false
end

function emP.removeVehicles(plate, vnet)
	local source = source
	local user_id = vRP.getUserId(source)
	local owner = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})
	if #owner > 0 then
		local model = vRP.query('vAZ/getVehicleByModel', {model = owner[1].model})    
		if #model > 0 then
			--vRP.execute("vRP/set_detido", { user_id = owner[1].user_id, model = owner[1].model, detido = 4, time = parseInt(os.time()) })
			TriggerClientEvent("Notify",source,"sucesso","Você vendeu seu veículo por " ..parseInt(model[1].price) * 0.4 .. "R$" )
			vRP.execute("vRP/remove_vehicle",{ user_id = owner[1].user_id, model = owner[1].model })
			--vRP.giveInventoryItem(user_id, "dinheirosujo", parseInt(model[1].price) * 0.5)
			vRP.giveMoney(user_id,parseInt(model[1].price) * 0.4)
			SendWebhookMessage(webhooklinkvendadeveiculo,  "``` vendadeveiculo [" ..user_id.."] Placa; " ..plate.. " por " .. parseInt(model[1].price) * 0.4 .."```")
			TriggerClientEvent('syncdeleteveh', -1, vnet)
			TriggerEvent('az-garages:deleteVehicleArr', vnet)
		end			
	end
end