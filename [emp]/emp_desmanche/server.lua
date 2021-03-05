local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_desmanche",emP)


vRP._prepare("vAZ/SetStateVehicleDESMANCHE", "UPDATE vrp_user_vehicles SET state = @state, time = @time WHERE user_id = @user_id AND plate = @plate")
vRP._prepare('vAZ/GetServerVehicles', 'SELECT * FROM vrp_vehicles')

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooklinkdesmanche = "https://discordapp.com/api/webhooks/738917432646697071/wFP07iVyknLBqTLxOiWqldYygsUOkpOVCxjKn0O8KenoPQ95eLFB_4Bjkg9sXiKVLGVW"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end



function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"driftking.permissao")
end

function emP.checkVehicle()
	local source = source
	local user_id = vRP.getUserId(source)
	local vehicle = vRPclient.getNearestVehicle(source, 5)
	if vehicle then
		local plate = vRPclient.getPlateVehicle(source, vehicle)  
		local owner = vRP.query("vAZ/GetPlayerVehiclePlate", {plate = plate})
		if #owner <= 0 then
			TriggerClientEvent("Notify",source,"aviso","Veículo não encontrado na lista do proprietário.")
			return false
		elseif #owner > 0 then			
			if user_id ~= owner[1].user_id then
				if parseInt(owner[1].state) == 4 then
					TriggerClientEvent("Notify",source,"aviso","Veículo encontra-se apreendido na seguradora.")
					return false
				end
				local model = vRP.query('vAZ/GetPlayerVehicleModel', {model = owner[1].model})    
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
	local plate = vRPclient.getPlateVehicle(source, vehicle)
	local owner = vRP.query("vAZ/GetPlayerVehiclePlate", {plate = plate})
	if #owner > 0 then
		local model = vRP.query('vAZ/GetServerVehicles', {model = owner[1].model})   
		local price = price
		--TriggerClientEvent("Notify",source,"aviso","CHEGOU ATE AQUI.") 
		--if #model > 0 then
			vRP.execute("vAZ/SetStateVehicleDESMANCHE", { user_id = owner[1].user_id, plate = owner[1].plate, state = 3, time = parseInt(os.time()) })
			vRP.giveInventoryItem(user_id, "dinheirosujo", parseInt(model[1].price) * 0.06)
			TriggerClientEvent("Notify",source,"sucesso","DESMANCHOU COM SUCESSO.") 
			SendWebhookMessage(webhooklinkdesmanche,  "``` Desmanche [" ..user_id.."]  Placa; " ..plate.. " ```")
			TriggerClientEvent('syncdeleteveh', -1, vnet)
			TriggerEvent('az-garages:deleteVehicleArr', vnet)
		--end			
	end
end