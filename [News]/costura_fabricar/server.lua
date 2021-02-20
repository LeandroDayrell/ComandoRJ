local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
func = {}
Tunnel.bindInterface("costura_fabricar",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"motoclub.permissao")
end

RegisterServerEvent("costura-comprar")
AddEventHandler("costura-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(Config.valores) do
			if item == v.item then

				local tempo = 0
				local isArma = false
				if v.componentes then
					for k2,v2 in pairs(v.componentes) do -- VERIFICA SE TEM TODOS OS ITTENS
						if vRP.getInventoryItemAmount(user_id, v2.componente) >= v2.qtd then
							tempo = tempo+v2.qtd
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui os itens necessarios!")
							return false
						end
					end
					for k2,v2 in pairs(v.componentes) do -- SE TEM TODOS OS ITENS, TIRA ELES DO INVENTARIO
						vRP.tryGetInventoryItem(user_id, v2.componente, v2.qtd)
					end
					isArma = true
				else
					tempo = 10
					isArma = false
				end

				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.qtd <= vRP.getInventoryMaxWeight(user_id) then

						TriggerClientEvent("costura_fabricar:fecharMenu", source)
						TriggerClientEvent("progress",source,tempo*10,"COSTURANDO")
						TriggerClientEvent("costura_fabricar:animacao",source, true)
						Citizen.Wait(tempo*10)
						TriggerClientEvent("costura_fabricar:animacao",source, false)


						if not isArma then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.qtd))
								TriggerClientEvent("Notify",source,"sucesso","Produção efetuada com sucesso!.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.qtd))
							TriggerClientEvent("Notify",source,"sucesso","Você recebeu o item!")
						end

				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
