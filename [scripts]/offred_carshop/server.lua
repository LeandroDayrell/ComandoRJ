local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP._prepare("vRP/get_vehiclesList","SELECT * FROM concessionaria WHERE id = @id")
vRP._prepare("vRP/remove_stock","UPDATE concessionaria SET estoquecarro = estoquecarro - 1 WHERE id = @id")

vAZgarage = Proxy.getInterface('az-garages')

function vRP.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end

local webhooklinkcompracarro = "https://discordapp.com/api/webhooks/710221476044996750/hXJoWbANivB8TyT47GHnMxek95XQy0E6CoMayA4zTEmFlc48amNecF68ZM_4aXkoUI2C"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


local carros = {
	{id = 1,   nome = "blista2", 			precocarro = 15000,		pesocarro = 20, imagemcarro = "https://i.imgur.com/m0zrxrN.png"},
	{id = 2,   nome = "panto", 			precocarro = 17000,	 		pesocarro = 20, imagemcarro = "https://i.imgur.com/Hv2XOOF.png"},
	{id = 3,   nome = "brioso", 		precocarro = 22000,			pesocarro = 20, imagemcarro = "https://i.imgur.com/oilpd8K.png"},
	{id = 4,  nome = "regina", 			precocarro = 200000,  		pesocarro = 30, imagemcarro = "https://i.imgur.com/TjPAvuo.png"},	
    {id = 5, nome = "stratum",          precocarro = 25000, 		pesocarro = 30, imagemcarro = "https://i.imgur.com/btS24Nm.png"},
    {id = 6,  nome = "picador", 		precocarro = 29000,  		pesocarro = 30, imagemcarro = "https://i.imgur.com/0MvYZAO.png"},
    {id = 7, nome = "tailgater", 		precocarro = 25000, 		pesocarro = 25, imagemcarro = "https://i.imgur.com/BFabJer.png"},
    {id = 8, nome = "fugitive", 		precocarro = 31000, 		pesocarro = 25, imagemcarro = "https://i.imgur.com/i4x58Ns.png"},
    {id = 9, nome = "exemplar", 		precocarro = 35000, 		pesocarro = 25, imagemcarro = "https://i.imgur.com/J7xnMj5.png"},   
	{id = 10, nome = "ellie", 			precocarro = 40000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/7LgZh9U.png"},
    {id = 11, nome = "impaler", 		precocarro = 55000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/IxO3kWX.png"},
    {id = 12, nome = "vamos", 			precocarro = 65000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/xANZ7Z6.png"},
    {id = 13, nome = "serrano", 		precocarro = 65000,			pesocarro = 40, imagemcarro = "https://i.imgur.com/AQ7XHtP.png"},
    {id = 14,  nome = "gresley", 		precocarro = 67000,			pesocarro = 40, imagemcarro = "https://i.imgur.com/40b49wd.png"},
    {id = 15, nome = "dubstar", 		precocarro = 70000, 		pesocarro = 40, imagemcarro = "https://i.imgur.com/VpWrN0O.png"},
	{id = 16, nome = "baller3", 		precocarro = 77000, 		pesocarro = 40, imagemcarro = "https://i.imgur.com/y9iWB4J.png"},
	{id = 17,  nome = "minivan", 		precocarro = 80000,  		pesocarro = 60, imagemcarro = "https://i.imgur.com/v16RtPA.png"},
	{id = 18,  nome = "paradise", 		precocarro = 87000, 		pesocarro = 60, imagemcarro = "https://i.imgur.com/QcDOCy1.png"},
	{id = 19,  nome = "speedo", 		precocarro = 95000, 		pesocarro = 60, imagemcarro = "https://i.imgur.com/xGifzLp.png"},
	{id = 20,  nome = "contender", 		precocarro = 110000, 		pesocarro = 40, imagemcarro = "https://i.imgur.com/ge8fBwE.png"},
	{id = 21,  nome = "kamacho", 		precocarro = 150000, 		pesocarro = 40, imagemcarro = "https://i.imgur.com/lnjLFqn.png"},
	{id = 22,  nome = "guardian", 		precocarro = 180000, 		pesocarro = 40, imagemcarro = "https://i.imgur.com/GZjfHNy.png"},
	{id = 23,  nome = "surge", 			precocarro = 70000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/3k9IClx.png"},
	{id = 24,  nome = "voltic", 		precocarro = 75000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/p7K7AH7.png"},
	{id = 25,  nome = "raiden", 		precocarro = 250000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/1MEJ1JP.png"},
	{id = 26,  nome = "neon", 			precocarro = 260000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/TBbHsLW.png"},
	{id = 27,  nome = "cyclone", 		precocarro = 300000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/1Hl1VBC.png"},
	{id = 28,  nome = "felon2", 		precocarro = 34000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/EUtOwfw.png"},
	{id = 29,  nome = "zion2", 			precocarro = 36000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/Dbneili.png"},
	{id = 30,  nome = "windsor2", 		precocarro = 40000, 		pesocarro = 20, imagemcarro = "https://i.imgur.com/inlVQAe.png"},
	{id = 31,  nome = "carbonizzare", 	precocarro = 450000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/yM8d2g7.png"},
	{id = 32,  nome = "coquette", 		precocarro = 500000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/imVzgfY.png"},
    {id = 33,   nome = "adder", 		precocarro = 550000,	 	pesocarro = 15, imagemcarro = "https://i.imgur.com/NfHenQ8.png"},
    {id = 34,   nome = "turismor", 		precocarro = 600000,		pesocarro = 15, imagemcarro = "https://i.imgur.com/xq9Uc1T.png"},
    {id = 35,  nome = "reaper", 		precocarro = 650000,		pesocarro = 15, imagemcarro = "https://i.imgur.com/Pf2jsCm.png"},
    {id = 36,  nome = "xa21", 			precocarro = 750000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/PtxqeLm.png"},
	{id = 37,  nome = "t20", 			precocarro = 900000,   		pesocarro = 15, imagemcarro = "https://i.imgur.com/tqibTTE.png"},
	{id = 38,  nome = "osiris", 		precocarro = 1100000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/iBA6LzV.png"},
	{id = 39,  nome = "zentorno", 		precocarro = 1300000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/2Tdr3GP.png"},
	{id = 40,  nome = "italigto", 		precocarro = 1500000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/5fLFtJ4.png"},
	{id = 41,  nome = "weevil", 		precocarro = 22500,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/x3HiTPY.png"},
	{id = 42,  nome = "asbo", 			precocarro = 25000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/jTWfqBF.png"},
	-- BARCOS
	{id = 200,  nome = "dinghy", 		precocarro = 250000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/Mj4qUQk.png"},
	{id = 201,  nome = "jetmax", 		precocarro = 260000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/p8ocPuB.png"},
	{id = 202,  nome = "seashark3", 	precocarro = 170000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/T4h5wdz.png"},
	{id = 203,  nome = "speeder2", 		precocarro = 250000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/AuhR5A1.png"},
	{id = 204,  nome = "suntrap", 		precocarro = 230000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/le7enqJ.png"},
	{id = 205,  nome = "toro2", 		precocarro = 290000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/HsrzUjc.png"},
	{id = 206,  nome = "tropic", 		precocarro = 270000,  		pesocarro = 15, imagemcarro = "https://i.imgur.com/KabZLrT.png"},
	
	-- MOTOS
	{id = 500, nome = "akuma", 			precocarro = 50000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/JNilgDw.png"},
	{id = 501, nome = "diablous", 			precocarro = 55000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/DsT1dA2.png"},
	{id = 502, nome = "faggio", 		precocarro = 7000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/56MTJwX.png"},
	{id = 503, nome = "esskey", 			precocarro = 20000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/pbwJ9c7.png"},
	{id = 504, nome = "pcj", 		precocarro = 15000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/l0y2Bti.png"},
	{id = 505, nome = "ruffian", 			precocarro = 30000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/tvyyfTM.png"},
	{id = 506, nome = "bati", 		precocarro = 120000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/dpI9J8u.png"},
	{id = 507, nome = "carbonrs", 		precocarro = 120000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/qqzawtM.png"},
	{id = 508, nome = "hakuchou", 			precocarro = 150000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/pX74rwZ.png"},
	{id = 509, nome = "bf400", 		precocarro = 120000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/GTwPz3Z.png"},
    {id = 510, nome = "sanchez2", 		precocarro = 100000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/yuCO2bx.png"},
	{id = 511, nome = "nightblade", 			precocarro = 150000, 	pesocarro = 15, imagemcarro = "https://i.imgur.com/IF6qv4h.png"},
	{id = 512, nome = "wolfsbane",		precocarro = 90000, 	pesocarro = 15, imagemcarro = "https://i.imgur.com/qA9wjm4.png"},
	{id = 513, nome = "daemon",		precocarro = 130000, 	pesocarro = 15, imagemcarro = "https://i.imgur.com/RH7WFP3.png"},
	{id = 514, nome = "zombieb",		precocarro = 110000, 	pesocarro = 15, imagemcarro = "https://i.imgur.com/RkIoZgF.png"},
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('offred_carshop:abrirPainelpacorabane')
AddEventHandler('offred_carshop:abrirPainelpacorabane',function()
	local src = source
	local user_id = vRP.getUserId(src)
    for _,rb in pairs(carros) do
		local rows = vRP.query("vRP/get_vehiclesList", {id = rb.id})
		if #rows > 0 then
			if rows[1].id == rb.id then
				if rows[1].estoquecarro ~= 0 then
					TriggerClientEvent('offred_carshop:abrirPainelpacorabane', src, rb.id, rb.nome, rb.pesocarro, rows[1].estoquecarro, rb.precocarro, rb.imagemcarro)
				end
			end
		end
	end
end)



RegisterServerEvent('offred_carshop:comprarCarropacorabane')
AddEventHandler('offred_carshop:comprarCarropacorabane',function(value)
	local src = source
	local user_id = vRP.getUserId(src)
	--if user_id and vRP.hasPermission(user_id,"conssionaria.permissao") then
	for k,v in pairs(carros) do
		if v.id == tonumber(value) then
			local rows = vRP.query("vRP/get_vehiclesList", {id = tonumber(value)})
			if rows[1].estoquecarro ~= 0 then
				-- verifica quantidade de carros na aragem.
				local garagems = 5
				local totalv = vRP.query("vRP/get_maxcars",{ user_id = user_id })
				if vRP.hasPermission(user_id,"bronze.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 3 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(source, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(source, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"prata.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 6 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(source, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(source, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"ouro.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 10 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(source, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(source, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"platina.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 15 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"diamante.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 25 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"mafioso.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 35 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"supremo.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 50 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end	
					elseif vRP.hasPermission(user_id,"magnata.permissao") then
				
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 50 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end						
				else
				
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) then
					
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end
				end
				-- compra o veiculo
				if vRP.tryFullPayment(user_id,v.precocarro,false) then
					local compra = vRP.execute("vRP/add_vehicle",{ user_id = user_id, model = v.nome, plate = vAZgarage.generatePlate() })
					vRP.logInfoToFile("logRJ/comprarcarro.txt",user_id.." comprou "..v.nome.." pelo valor " ..v.precocarro.. ".")
					SendWebhookMessage(webhooklinkcompracarro,  "```" ..user_id.." comprou "..v.nome.." pelo valor " ..v.precocarro.. "```")

					if compra > 0 then
						local row = vRP.execute("vRP/remove_stock", {id = tonumber(value)})
						if row > 0 then
							-- removeu stock
							-- atualizar no NUI
						end
						local typemessage = "sucesso"
						local mensagem = "Você pagou <font color=\"green\">$"..v.precocarro.."</font> dolares"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
					else
						local typemessage = "error"
						local mensagem = "Você já possui este veículo em sua garagem."
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
					end
				end
			else
				-- envia pro client NUi ( sem estoque )
			end
		end
	end
--end
end)
