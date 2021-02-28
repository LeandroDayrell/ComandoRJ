local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("entrega_remedio",func) 
vRPclient = Tunnel.getInterface("vRP")
-- PERMISSÃO
RegisterServerEvent('entrega_remedio:permissao')
AddEventHandler('entrega_remedio:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"[CHEFE] - SAMU") then 
		if vRP.hasGroup(user_id,"[COORDENADOR] - SAMU") then
				if vRP.hasGroup(user_id,"[MÉDICO(A)] - SAMU") then	
					if vRP.hasGroup(user_id,"[ENFERMEIRO] - SAMU") then	
						if vRP.hasGroup(user_id,"[TÉCNICO DE ENFERMAGEM] - SAMU") then	
							if vRP.hasGroup(user_id,"[SOCORRISTA] - SAMU") then	
								TriggerClientEvent('entrega_remedio:permissao', player)
							end
						end
					end
				end
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function func.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(1,2)
	end
end

function func.checkPayment()
	func.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"remediosamu",quantidade[source]) then
			vRP.giveMoney(user_id,math.random(5,10)*quantidade[source])
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..quantidade[source].."x Remedios</b>.")
		end
	end
end