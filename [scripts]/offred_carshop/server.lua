local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP._prepare("vRP/get_vehiclesList","SELECT * FROM concessionaria WHERE id = @id")
vRP._prepare("vRP/remove_stock","UPDATE concessionaria SET estoquecarro = estoquecarro - 1 WHERE id = @id")

vAZgarageClient = Tunnel.getInterface("az-garages")

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
	{id = 1,   nome = "ds4", 			precocarro = 60000,		pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642487446700040/unknown.png"},
	{id = 2,   nome = "punto", 		precocarro = 60000,	 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642582078455818/unknown.png"},
	{id = 3,   nome = "f150", 		precocarro = 130000,		pesocarro = 85, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642611656818718/unknown.png"},
	{id = 4,  nome = "fusion", 			precocarro = 330000,  	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642631185367042/unknown.png"},	
    {id = 5, nome = "fordka",          precocarro = 60000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639689524032831488/unknown.png"},
    {id = 6,  nome = "vwgolf", 		precocarro = 300000,  	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642690375385098/unknown.png"},
    {id = 7, nome = "civic", precocarro = 60000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642713662423050/unknown.png"},
    {id = 8, nome = "eletran17", precocarro = 600000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642737913757726/unknown.png"},
    {id = 9, nome = "sonata18", precocarro = 550000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642760785166336/unknown.png"},
    {id = 10,   nome = "veloster", 			precocarro = 350000,		pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642794289397771/unknown.png"},
    {id = 11,  nome = "monza", 		precocarro = 25000,		pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642814744887297/unknown.png"},
    {id = 12, nome = "p207", precocarro = 50000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642846181457920/unknown.png"},
	{id = 13, nome = "vwpolo", precocarro = 320000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642872626282506/unknown.png"},
	{id = 14,  nome = "evoq", 		precocarro = 500000,  	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642895187443712/unknown.png"},
	{id = 15,  nome = "santafe", 		precocarro = 500000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642915043278848/unknown.png"},
	{id = 16,  nome = "celta", 		precocarro = 50000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607841493352448/unknown.png"},
	{id = 17,  nome = "amarok", 		precocarro = 600000, 	pesocarro = 80, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687536201170944/unknown.png"},
	{id = 18,  nome = "youga2", 			precocarro = 100000, 	pesocarro = 100, imagemcarro = "https://wiki.gtanet.work/images/e/e6/Youga2.png"},
	{id = 19,  nome = "fiat", 		precocarro = 10000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687614311563264/unknown.png"},
	{id = 20,  nome = "jetta2017", 		precocarro = 400000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687693953138688/unknown.png"},
	{id = 21,  nome = "l200civil", 		precocarro = 1000000, 	pesocarro = 80, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687731831898112/unknown.png"},
	{id = 22,  nome = "saveiro", 		precocarro = 320000, 	pesocarro = 60, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687759828615198/unknown.png"},
	{id = 23,  nome = "upzinho", 		precocarro = 80000, 	pesocarro = 30, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687980017254400/unknown.png"},
	{id = 24,  nome = "voyage", 		precocarro = 250000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639688756382793728/unknown.png"},
	{id = 25,  nome = "golg7", 		precocarro = 250000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607867506425857/unknown.png"},
	{id = 26,  nome = "gburrito2", 		precocarro = 500000, 	pesocarro = 150, imagemcarro = "https://wiki.gtanet.work/images/f/ff/GBurrito2.png"},
	{id = 27,  nome = "palio", 		precocarro = 120000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607791216230400/unknown.png"},
	{id = 28,  nome = "fiatuno", 		precocarro = 15000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607896090345474/unknown.png"},
	{id = 29,  nome = "fiatstilo", 		precocarro = 80000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639688910695301140/unknown.png"},
    {id = 30,   nome = "surfer", 		precocarro = 50000,	 	pesocarro = 80, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/a/ac/Surfer-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160409182213"},
    {id = 32,   nome = "blista", 		precocarro = 60000,		pesocarro = 40, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/c/c0/Blista-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160409171328"},
    {id = 33,  nome = "sultan", 		precocarro = 150000,	pesocarro = 50, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/b/bb/Sultan-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20180331183641"},
    {id = 34,  nome = "bison", 			precocarro = 200000, 	pesocarro = 70, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/6/69/Bison-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160406172803"},
	{id = 35,  nome = "rhapsody", 		precocarro = 7000,   	pesocarro = 30, imagemcarro = "https://wiki.rage.mp/images/e/e2/Rhapsody.png"},
	{id = 36,  nome = "prairie", 		precocarro = 10000,  	pesocarro = 25, imagemcarro = "https://wiki.rage.mp/images/thumb/3/3d/Prairie.png/800px-Prairie.png"},
	{id = 37,  nome = "felon", 			precocarro = 70000,  	pesocarro = 50, imagemcarro = "https://wiki.rage.mp/images/thumb/0/04/Felon.png/800px-Felon.png"},
	{id = 38,  nome = "jackal", 		precocarro = 60000,  	pesocarro = 30, imagemcarro = "https://wiki.rage.mp/images/thumb/7/70/Jackal.png/800px-Jackal.png"},
	{id = 39,  nome = "oracle", 		precocarro = 60000,  	pesocarro = 50, imagemcarro = "https://wiki.rage.mp/images/thumb/1/17/Oracle.png/800px-Oracle.png"},
	{id = 40, nome = "brioso", 			precocarro = 30000, 	pesocarro = 30, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/8/80/BriosoRA-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20160712123349"},
	{id = 41,   nome = "savestra", 			precocarro = 200000,		pesocarro = 50, imagemcarro = "https://i.imgur.com/yPWYVWk.png"},
	{id = 42,   nome = "peyote", 			precocarro = 400000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/2/21/Peyote.png"},
	{id = 43,   nome = "manana", 			precocarro = 400000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/5/50/Manana.png"},
	{id = 44,   nome = "primo2", 			precocarro = 350000,		pesocarro = 50, imagemcarro = "https://wiki.rage.mp/images/thumb/3/30/Primo2.png/800px-Primo2.png"},
	{id = 45,   nome = "sultanrs", 			precocarro = 1000000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/1/11/SultanRS.png"},
	{id = 46,   nome = "tampa", 			precocarro = 1000000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/3/30/Tampa.png"},
	{id = 47,   nome = "tampa2", 			precocarro = 2000000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/a/af/Tampa2.png"},
	{id = 48,   nome = "kuruma", 			precocarro = 2000000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/8/8f/Kuruma.png"},
	{id = 49,   nome = "elegy2", 			precocarro = 800000,		pesocarro = 50, imagemcarro = "https://wiki.rage.mp/images/thumb/3/33/Elegy2.png/800px-Elegy2.png"},
	{id = 50,   nome = "flashgt", 			precocarro = 600000,		pesocarro = 50, imagemcarro = "https://i.imgur.com/0IaelqF.png"},
	{id = 51,   nome = "guardian", 			precocarro = 1000000,		pesocarro = 200, imagemcarro = "https://wiki.gtanet.work/images/f/fd/Guardian.png"},
	{id = 52,   nome = "slamvan3", 			precocarro = 1000000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/5/58/SlamVan3.png"},
	{id = 53,   nome = "sandking", 			precocarro = 1000000,		pesocarro = 200, imagemcarro = "https://wiki.gtanet.work/images/6/64/Sandking.png"},
	{id = 54,   nome = "patriot", 			precocarro = 1000000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/1/12/Patriot.png"},
	{id = 55,   nome = "buccaneer", 			precocarro = 800000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/d/de/Buccaneer.png"},
	{id = 56,   nome = "yosemite", 			precocarro = 1000000,		pesocarro = 50, imagemcarro = "https://i.imgur.com/6ZcVcRe.png"},
	{id = 57,   nome = "brawler", 			precocarro = 1000000,		pesocarro = 50, imagemcarro = "https://wiki.gtanet.work/images/f/fa/Brawler.png"},
	{id = 58, nome = "608", 			precocarro = 800000, 	pesocarro = 200, imagemcarro = "https://cdn.discordapp.com/attachments/545754127615918110/553798023877230623/unknown.png"},
	{id = 59, nome = "atroncar",		precocarro = 2500000, 	pesocarro = 500, imagemcarro = "https://cdn.discordapp.com/attachments/545754127615918110/553806434098348032/unknown.png"},
	{id = 60, nome = "mule6", 			precocarro = 800000, 	pesocarro = 200, imagemcarro = "https://cdn.discordapp.com/attachments/545754127615918110/553806858041688074/unknown.png"},
	{id = 61, nome = "mule", 			precocarro = 850000, 	pesocarro = 200, imagemcarro = "https://wiki.rage.mp/images/e/e7/Mule.png"},
	{id = 62, nome = "benson", 			precocarro = 1500000, 	pesocarro = 350, imagemcarro = "https://wiki.rage.mp/images/b/bd/Benson.png"},
	{id = 63, nome = "pounder", 		precocarro = 2000000, 	pesocarro = 500, imagemcarro = "https://wiki.rage.mp/images/a/a6/Pounder.png"},
	-- MOTOS
	{id = 500, nome = "biz25", 			precocarro = 10000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697375211814912/unknown.png"},
	{id = 501, nome = "150", 			precocarro = 13000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697428303446026/unknown.png"},
	{id = 502, nome = "bros60", 		precocarro = 60000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697447962017793/unknown.png"},
	{id = 503, nome = "xt66", 			precocarro = 60000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697476005265408/unknown.png"},
	{id = 504, nome = "450crf", 		precocarro = 100000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697501645176862/unknown.png"},
	{id = 505, nome = "xj", 			precocarro = 120000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697542388383764/unknown.png"},
	{id = 506, nome = "hornet", 		precocarro = 90000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/537966884268802080/646587608402493450/unknown.png"},
	{id = 507, nome = "dm1200", 		precocarro = 170000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697653411872778/unknown.png"},
	{id = 508, nome = "z1000", 			precocarro = 300000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697723825848320/unknown.png"},
	{id = 509, nome = "lectro", 		precocarro = 600000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/nVpfObu.png"},
    {id = 510, nome = "blazer4", 		precocarro = 1000000, 		pesocarro = 15, imagemcarro = "https://i.imgur.com/Rk81kO3.png"},
	{id = 511, nome = "bati2", 			precocarro = 1000000, 	pesocarro = 15, imagemcarro = "https://i.imgur.com/kkMjDuM.png"},
	{id = 512, nome = "hakuchou",		precocarro = 310000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/a/ab/Hakuchou-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160302173513"},
	{id = 513, nome = "vindicator",		precocarro = 800000, 	pesocarro = 15, imagemcarro = "https://i.imgur.com/K0BOmFD.png"},
	{id = 514, nome = "sanchez2",		precocarro = 150000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/9/93/Sanchez2-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160222221404"},
	{id = 515, nome = "double", 		precocarro = 300000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/8/8c/DoubleT-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160126212153"},
	{id = 516, nome = "diablous2", 		precocarro = 380000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/1/11/DiabolusCustom-GTAO-front.png/revision/latest/scale-to-width-down/350?cb=20161213202213"},
	{id = 517, nome = "zombiea", 		precocarro = 230000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/a/af/ZombieBobber-GTAO-front.png/revision/latest/scale-to-width-down/350?cb=20161004181721"},
	{id = 518, nome = "akuma", 			precocarro = 420000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/9/9a/Akuma-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160127214020"},
	{id = 519, nome = "bf400", 			precocarro = 500000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/0/00/BF400-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014164436"},
	{id = 520, nome = "carbonrs", 		precocarro = 300000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/2/2d/CarbonRS-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160130214329"},
	{id = 521, nome = "daemon2", 		precocarro = 200000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/6/6b/Daemon2-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014164637"},
	{id = 522, nome = "hexer", 			precocarro = 180000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/6/64/Hexer-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160211212015"},
	{id = 523, nome = "nightblade", 	precocarro = 340000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/6/6b/Nightblade-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014165516"},
	{id = 524, nome = "sanchez", 		precocarro = 150000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/9/93/Sanchez2-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160222221404"},
	{id = 525, nome = "vader", 			precocarro = 280000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/9/9b/Vader-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160130222000"},
	{id = 526, nome = "vortex", 		precocarro = 300000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/7/71/Vortex-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161004181943"},
	{id = 527, nome = "wolfsbane", 		precocarro = 230000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/f/ff/Wolfsbane-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014165611"},
	{id = 528, nome = "zombieb", 		precocarro = 235000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/7/70/ZombieChopper-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161004181804"},
	{id = 539, nome = "blazer", 		precocarro = 200000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/3/35/Blazer-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20161018175627"},
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
					local compra = vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = v.nome, plate = vAZgarageClient.GeneratePlate(src) })
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
