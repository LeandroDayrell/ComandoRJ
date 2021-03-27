local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
emP = {}
job = {}
Tunnel.bindInterface("emp_encanador",emP)
Tunnel.bindInterface("emp_encanador",job)
----------------------------------------------------------------------------------
------- PEGAR tapafuroS 
----------------------------------------------------------------------------------
function emP.givetapafuro()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tapafuro") <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"tapafuro",3)
			return true
		else
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.") 
			return false
		end
	end
end
----------------------------------------------------------------------------------
------- COLOCAR ROUPA
----------------------------------------------------------------------------------
RegisterServerEvent('emp_encanador:roupa')
AddEventHandler('emp_encanador:roupa', function()
	local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
		vRP.removeCloak(source)
	end
end)

function job.SaveIdleCustom(old_custom)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.save_idle_custom(source,old_custom)
end
----------------------------------------------------------------------------------
------- PAGAMENTO E CHECK 
----------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
	   quantidade[source] = math.random(2,3)	
	end
	   TriggerClientEvent("quantidade-tapafuro",source,parseInt(quantidade[source]))
end

local tapafuro = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k,v in pairs(tapafuro) do
            if v > 0 then
                tapafuro[k] = v - 1
            end
        end
    end
end)

function emP.checkPayment()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if tapafuro[user_id] == 0 or not tapafuro[user_id] then
			if vRP.tryGetInventoryItem(user_id,"tapafuro",quantidade[source]) then
				randmoney = (math.random(60,80)*quantidade[source])
		        vRP.giveMoney(user_id,parseInt(randmoney))
		        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
				quantidade[source] = nil
				emP.Quantidade()
				tapafuro[user_id] = 15
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..quantidade[source].."x tapafuros</b>.")
			end
		end
	end
	return false
end