--#----------------------------------------------------------------------------------------------------------------------------#--
--#--------------------------------------------------[ DEVELOPED BY PENGUIN ]--------------------------------------------------#--
--#-------------------------------------------------[ CONTATO: Penguinn#0001 ]-------------------------------------------------#--
--#---------------------------------------------[ START SHOP: discord.gg/p8cEuep ]---------------------------------------------#--
--#----------------------------------------------------------------------------------------------------------------------------#--
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("penguin_pecaarma",oC)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local municoes = {
    { item = "facil" },
    { item = "mediana" },
	{ item = "dificil" },
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("rotas-pecas")
AddEventHandler("rotas-pecas",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(municoes) do
            if item == v.item then
                if item == "facil" then
                    TriggerClientEvent("fechar-nui-farm",source) -- FECHAR NUI
                    TriggerClientEvent("Notify",source,"sucesso","Você iniciou a <b>Coleta fácil</b>.") -- NOTIFICAÇÃO
                elseif item == "mediana" then
					TriggerClientEvent("fechar-nui-farm",source) -- FECHAR NUI
                    TriggerClientEvent("Notify",source,"sucesso","Você iniciou a <b>Coleta mediana</b>.") -- NOTIFICAÇÃO
                elseif item == "dificil" then
					TriggerClientEvent("fechar-nui-farm",source) -- FECHAR NUI
                    TriggerClientEvent("Notify",source,"sucesso","Você iniciou a <b>Coleta difícil</b>.") -- NOTIFICAÇÃO
                end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mercadonegro.permissao") or vRP.hasPermission(user_id,"milicia.permissao") then
        return true
    end
end

function oC.checkinventario()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pecadearma") <= vRP.getInventoryMaxWeight(user_id) then
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE QUANTIDADE ]---------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local quantidadefacil = {}
function oC.Quantidadefacil()
	local source = source
	if quantidadefacil[source] == nil then
		quantidadefacil[source] = math.random(1,5)
	end
end

local quantidademediano = {}
function oC.Quantidademediano()
	local source = source
	if quantidademediano[source] == nil then
		quantidademediano[source] = math.random(5,10)
	end
end

local quantidadedificil = {}
function oC.Quantidadedificil()
	local source = source
	if quantidadedificil[source] == nil then
		quantidadedificil[source] = math.random(8,15)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PAGAMENTO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPaymentfacil()
	oC.Quantidadefacil()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pecadearma")*quantidadefacil[source] <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"pecadearma",quantidadefacil[source])
		TriggerClientEvent("Notify",source,"sucesso","<b>"..quantidadefacil[source].."x</b> peças coletadas com <b>sucesso</b>.") -- NOTIFICAÇÃO
		quantidadefacil[source] = nil
		return true
		end
	end
end

function oC.checkPaymentmediano()
	oC.Quantidademediano()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pecadearma")*quantidademediano[source] <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"pecadearma",quantidademediano[source])
		TriggerClientEvent("Notify",source,"sucesso","<b>"..quantidademediano[source].."x</b> peças coletadas com <b>sucesso</b>.") -- NOTIFICAÇÃO
		quantidademediano[source] = nil
		return true
		end
	end
end

function oC.checkPaymentdificil()
	oC.Quantidadedificil()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pecadearma")*quantidadedificil[source] <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"pecadearma",quantidadedificil[source])
		TriggerClientEvent("Notify",source,"sucesso","<b>"..quantidadedificil[source].."x</b> peças coletadas com <b>sucesso</b>.") -- NOTIFICAÇÃO
		quantidadedificil[source] = nil
		return true
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO CHAMAR POLICIA ]----------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
function oC.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission("policia.permissao") -- Permissão Polícia
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('Notify',player,"importante","Recebemos uma denuncia de <b>interceptação de carga roubada</b>, a localização já está em seu <b>GPS</b>.")
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end