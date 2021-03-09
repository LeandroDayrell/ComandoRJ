local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emp = {}
Tunnel.bindInterface("entrega_unica",emp)
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('crj_coca:permissao')
AddEventHandler('crj_coca:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"[VERMELHO] - Lider") then 
		if vRP.hasGroup(user_id,"[VERMELHO] - Gerente") then
			if vRP.hasGroup(user_id,"[VERMELHO] - Membro") then
				TriggerClientEvent('crj_coca:permissao', player)
			end
		end
	end
end)

RegisterServerEvent('entrega_crack:permissao')
AddEventHandler('entrega_crack:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"[AZUL] - Lider") then
		if vRP.hasGroup(user_id,"[AZUL] - Gerente") then
		    if vRP.hasGroup(user_id,"[AZUL] - Membro") then
				TriggerClientEvent('entrega_crack:permissao', player)
		    end
		end
	end
end)

RegisterServerEvent('crj_maconha:permissao')
AddEventHandler('crj_maconha:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"[LARANJA] - Lider") then 
		if vRP.hasGroup(user_id,"[LARANJA] - Gerente") then
			if vRP.hasGroup(user_id,"[LARANJA] - Membro") then	
				TriggerClientEvent('crj_maconha:permissao', player)
			end
		end
	end
end)

RegisterServerEvent('entrega_opio:permissao')
AddEventHandler('entrega_opio:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"[T.C.A] - Lider") then 
		if vRP.hasGroup(user_id,"[T.C.A] - Gerente") then
				if vRP.hasGroup(user_id,"[T.C.A] - Membro") then
				TriggerClientEvent('crj_metafetamina:permissao', player)
			end
		end
	end
end)

RegisterServerEvent('crj_metafetamina:permissao')
AddEventHandler('crj_metafetamina:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"[VERDE] - Lider") then
		if vRP.hasGroup(user_id,"[VERDE] - Gerente") then
			if vRP.hasGroup(user_id,"[VERDE] - Membro") then
				TriggerClientEvent('crj_metafetamina:permissao', player)
			end
		end
	end
end)

RegisterServerEvent('entrega_pecas:permissao')
AddEventHandler('entrega_pecas:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"[LR] - Lider") then 
		if vRP.hasGroup(user_id,"[LR] - Gerente") then
				if vRP.hasGroup(user_id,"[LR] - Membro") then
				TriggerClientEvent('entrega_pecas:permissao', player)
			end
		end
	end
end)

RegisterServerEvent('entrega_pendrive:permissao')
AddEventHandler('entrega_pendrive:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"[UNKTEC] - Lider") then 
		if vRP.hasGroup(user_id,"[UNKTEC] - Gerente") then
				if vRP.hasGroup(user_id,"[UNKTEC] - Membro") then
				TriggerClientEvent('entrega_pendrive:permissao', player)
			end
		end
	end
end)


RegisterServerEvent('entrega_lsd:permissao')
AddEventHandler('entrega_lsd:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"Amarelos") then
	    TriggerClientEvent('entrega_lsd:permissao', player)
	end
end)

RegisterServerEvent('entrega_morfina:permissao')
AddEventHandler('entrega_morfina:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"Amarelos") then
	    TriggerClientEvent('entrega_morfina:permissao', player)
	end
end)

RegisterServerEvent('entrega_extase:permissao')
AddEventHandler('entrega_extase:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"Amarelos") then
	    TriggerClientEvent('entrega_extase:permissao', player)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

-- MACONHA CV
RegisterServerEvent('crj_coca:itensReceber')
AddEventHandler('crj_coca:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(115,120)  
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"maconha",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)

-- CRACK
RegisterServerEvent('entrega_crack:itensReceber')
AddEventHandler('entrega_crack:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(115,120)
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"pedradecrack",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)

-- COCAINA ADA
RegisterServerEvent('crj_maconha:itensReceber')
AddEventHandler('crj_maconha:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(115,120)
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"cocaina",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)

-- OPIO
RegisterServerEvent('entrega_opio:itensReceber')
AddEventHandler('entrega_opio:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(115,120)  
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"opio",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)

-- METANFETAMINA
RegisterServerEvent('crj_metafetamina:itensReceber')
AddEventHandler('crj_metafetamina:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(115,120)
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"metanfetamina",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)

-- PEÇAS
RegisterServerEvent('entrega_pecas:itensReceber')
AddEventHandler('entrega_pecas:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(90,100)  
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"pecasroubada",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)


-- pen drive
RegisterServerEvent('entrega_pendrive:itensReceber')
AddEventHandler('entrega_pendrive:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(105,115)
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"pendriveh",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)

-- LSD
RegisterServerEvent('entrega_lsd:itensReceber')
AddEventHandler('entrega_lsd:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(45,60)
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"lsd",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)

-- MORFINA
RegisterServerEvent('entrega_morfina:itensReceber')
AddEventHandler('entrega_morfina:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(45,60)
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"morfina",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)

-- EXTASE
RegisterServerEvent('entrega_extase:itensReceber')
AddEventHandler('entrega_extase:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(45,60)
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"ecstasy",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)