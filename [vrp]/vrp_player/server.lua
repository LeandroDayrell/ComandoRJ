local discord_webhook = "https://discordapp.com/api/webhooks/709961700677255168/KD3dimhGt7icpJmqfmtJ7MuXMSUEq31DGDFMgHLTe5DYdyHHancOYf6zKPZenSHLlAJj"
local discord_webhook1 = "https://discordapp.com/api/webhooks/709961700677255168/KD3dimhGt7icpJmqfmtJ7MuXMSUEq31DGDFMgHLTe5DYdyHHancOYf6zKPZenSHLlAJj"
local discord_webhook2 = "https://discordapp.com/api/webhooks/709961700677255168/KD3dimhGt7icpJmqfmtJ7MuXMSUEq31DGDFMgHLTe5DYdyHHancOYf6zKPZenSHLlAJj"
local discord_webhook3 = "https://discordapp.com/api/webhooks/709961700677255168/KD3dimhGt7icpJmqfmtJ7MuXMSUEq31DGDFMgHLTe5DYdyHHancOYf6zKPZenSHLlAJj"
local discord_webhook4 = "https://discordapp.com/api/webhooks/709961700677255168/KD3dimhGt7icpJmqfmtJ7MuXMSUEq31DGDFMgHLTe5DYdyHHancOYf6zKPZenSHLlAJj"
local discord_webhook5 = "https://discordapp.com/api/webhooks/709961700677255168/KD3dimhGt7icpJmqfmtJ7MuXMSUEq31DGDFMgHLTe5DYdyHHancOYf6zKPZenSHLlAJj"
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()


function vRP.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end


local webhooklinkgarmas = "https://discordapp.com/api/webhooks/720086869391704064/Dn80gMsnIxuSbypLFX6w-7zO1VIjNvV4ThkxFMKl_1Yti-AJD-N5oTXNqNnKlfH3Lsgg"
local webhooklinkadm = "https://discordapp.com/api/webhooks/722647370520854608/-WUXCvL1kKQct-5Z2N_S4XIE-AF0_LwYUacjz5d4swH-x8Z8KHapEftSwXXtgV5-k44x"
local webhooklinkroubo = "https://discordapp.com/api/webhooks/709061932887310369/IQv3bUKU5FW7zldElhNx0nMB0BAdJlOlZCNOTKMNjIo7ASL0ZAwgnVgQE2Ye7Uvm0J_b"
local webhooklinksaquear = "https://discordapp.com/api/webhooks/709061932887310369/IQv3bUKU5FW7zldElhNx0nMB0BAdJlOlZCNOTKMNjIo7ASL0ZAwgnVgQE2Ye7Uvm0J_b"
local webhooklinkmasterpick = "https://discordapp.com/api/webhooks/722655877580062770/OlLisSLqmOmoSkL25aP3d8bKFrl0TYKLYR3ESUyxtRPkTFSt2mqUZMnx-Bx8YooIuQs0"
local webhooklinkenviarmoney = "https://discordapp.com/api/webhooks/732772522667540570/WQNXlTCncD7XElLfyaiq5y4U9PEmgpMbgJeo3P1rfCuWZ5CKfFiEqsKIrLM1QpgfJGsp"
local webhooklinkpaypal = "https://discordapp.com/api/webhooks/737770105433227294/OQNXqNTcdwjlpcJpk18osc-Wch6Ni4Z787FxSEDXeRtRBMLWu7eSGtkI-tHqW9O2NDKx"
local webho

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


--[[RegisterCommand('me',function(source,args,rawCommand)
local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"blips.permissao") then
		if args[1] then
			local user_id = vRP.getUserId(source)
			local identity = vRP.getUserIdentity(user_id)
			TriggerClientEvent('chatME',-1,source,identity.name,rawCommand:sub(3))
			vRP.logs("savedata/me.txt","[ID]: "..user_id.." / [MENSAGEM]: "..rawCommand:sub(3))
		end
	else 
	TriggerClientEvent("Notify",source,"negado","Você não tem permissão para usar.")
	end
end)]]


RegisterCommand('status',function(source,args,rawCommand)
    local onlinePlayers = GetNumPlayerIndices()
    local policia = vRP.getUsersByPermission("policia.permissao")
    local paramedico = vRP.getUsersByPermission("paramedico.permissao")
    local mec = vRP.getUsersByPermission("mecanico.permissao")
    local staff = vRP.getUsersByPermission("admin.permissao")
    local ilegal = vRP.getUsersByPermission("ilegal.permissao")
    local user_id = vRP.getUserId(source)
        TriggerClientEvent("Notify",source,"importante","<bold><b>Jogadores</b>: <b>"..onlinePlayers.."<br>Administração</b>: <b>"..#staff.."<br>Policiais</b>: <b>"..#policia.."<br>Ilegal</b>: <b>"..#ilegal.."<br>Paramédicos</b>: <b>"..#paramedico.."<br>Mecânicos</b> em serviço: <b>"..#mec.."</b></bold>.",9000)
    end)

RegisterCommand('cor', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "color.weapon") or vRP.hasPermission(user_id,"admin.permissao") then
        TriggerClientEvent('changeWeaponColor', source, args[1])
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------




local itemlist = {
	["sigpack"] = { index = "sigpack", nome = "sigpack" },
	["municaosigpack"] = { index = "municaosigpack", nome = "municaosigpack" },
	["oab"] = { index = "oab", nome = "OAB" },
	["contrato"] = { index = "contrato", nome = "Contrato" },
	["remediosamu"] = { index = "remediosamu", nome = "Remediosamu" },
	["cheque"] = { index = "cheque", nome = "Cheque" },
	["ferramenta"] = { index = "ferramenta", nome = "Ferramenta" },
	["walkietalkie"] = { index = "walkietalkie", nome = "Walkietalkie" },
	["convite"] = { index = "convite", nome = "Convite Festa" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de Lixo" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de Leite" },
	["roupas"] = { index = "roupas", nome = "Roupas" },
	["tora"] = { index = "tora", nome = "Tora de Madeira" },
	["alianca"] = { index = "alianca", nome = "Aliança" },
	["bandagem"] = { index = "bandagem", nome = "Bandagem" },
	["cerveja"] = { index = "cerveja", nome = "Cerveja" },
	["tequila"] = { index = "tequila", nome = "Tequila" },
	["vodka"] = { index = "vodka", nome = "Vodka" },
	["rpprotecao"] = { index = "coletemedico", nome = "Colete Médico" },
	["whisky"] = { index = "whisky", nome = "Whisky" },
	["colete"] = { index = "colete", nome = "Colete Balístico" },
	["conhaque"] = { index = "conhaque", nome = "Conhaque" },
	["nitro"] = { index = "nitro", nome = "nitro" },
	["absinto"] = { index = "absinto", nome = "Absinto" },
	["dinheirosujo"] = { index = "dinheirosujo", nome = "Dinheiro Sujo" },
	["rastreador"] = { index = "rastreador", nome = "Rastreador" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos" },
	["algemas"] = { index = "algemas", nome = "Algemas" },
	["capuz"] = { index = "capuz", nome = "Capuz" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick" },
	["masterpick"] = { index = "masterpick", nome = "Masterpick" },
	["militec"] = { index = "militec", nome = "Militec-1" },
	["carnedecormorao"] = { index = "carnedecormorao", nome = "Carne de Cormorão" },
	["carnedecorvo"] = { index = "carnedecorvo", nome = "Carne de Corvo" },
	["carnedeaguia"] = { index = "carnedeaguia", nome = "Carne de Águia" },
	["carnedecervo"] = { index = "carnedecervo", nome = "Carne de Cervo" },
	["carnedecoelho"] = { index = "carnedecoelho", nome = "Carne de Coelho" },
	["carnedecoyote"] = { index = "carnedecoyote", nome = "Carne de Coyote" },
	["carnedelobo"] = { index = "carnedelobo", nome = "Carne de Lobo" },
	["carnedepuma"] = { index = "carnedepuma", nome = "Carne de Puma" },
	["carnedejavali"] = { index = "carnedejavali", nome = "Carne de Javali" },
	["isca"] = { index = "isca", nome = "Isca" },
	["dourado"] = { index = "dourado", nome = "Dourado" },
	["corvina"] = { index = "corvina", nome = "Corvina" },
	["salmao"] = { index = "salmao", nome = "Salmão" },
	["pacu"] = { index = "pacu", nome = "Pacu" },
	["pintado"] = { index = "pintado", nome = "Pintado" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré" },
	["lambari"] = { index = "lambari", nome = "Lambari" },
	["energetico"] = { index = "energetico", nome = "Energético" },
	["mochila"] = { index = "mochila", nome = "Mochila" },
	------------------- mercado negro ----------------------
	["ferrolho_parts"] = { index = "ferrolho_parts", nome = "Ferrolho" },
	["cano_parts"] = { index = "cano_parts", nome = "Cano" },
	["canoestendido_parts"] = { index = "canoestendido_parts", nome = "Cano Estendido" },
	["carregador_parts"] = { index = "carregador_parts", nome = "Carregador" },
	["polvora"] = { index = "polvora", nome = "Polvora" },
	["capsula"] = { index = "capsula", nome = "Capsula" },
	["kevlar"] = { index = "kevlar", nome = "Kevlar" },
	["kitcostura"] = { index = "kitcostura", nome = "Kit Costura" },
	
	["ecstasy"] = { index = "ecstasy", nome = "ecstasy" },
	["docedeecstasy"] = { index = "docedeecstasy", nome = "docedeecstasy" },
	["pastadecocaina"] = { index = "pastadecocaina", nome = "pastadecocaina" },
	["pinodecoca"] = { index = "pinodecoca", nome = "pinodecoca" },
	["pedradecrack"] = { index = "pedradecrack", nome = "pedradecrack" },
	
	["hidrazida"] = { index = "hidrazida", nome = "hidrazida" },
	["eter"] = { index = "eter", nome = "eter" },
	["lsd"] = { index = "lsd", nome = "lsd" },
	
	["pecacacaniquel"] = { index = "pecacacaniquel", nome = "pecacacaniquel" },
	["placamae"] = { index = "placamae", nome = "placamae" },
	["maquinacacaniquel"] = { index = "maquinacacaniquel", nome = "maquinacacaniquel" },
	
	["metil"] = { index = "metil", nome = "metil" },
	["cafeina"] = { index = "cafeina", nome = "cafeina" },
	["ecstasy"] = { index = "ecstasy", nome = "ecstasy" },
	
	["leitedepapoula"] = { index = "leitedepapoula", nome = "leitedepapoula" },
	["alcaloide"] = { index = "alcaloide", nome = "alcaloide" },
	["morfina"] = { index = "morfina", nome = "morfina" },
	
	
	
	
	----------------------------------------------
	["adubo"] = { index = "adubo", nome = "Adubo" },
	["cannabis"] = { index = "cannabis", nome = "Cannabis" },
	["maconha"] = { index = "maconha", nome = "Maconha" },

	["mouro"] = { index = "ouro", nome = "Ouro" },
	["mbronze"] = { index = "bronze", nome = "Bronze" },
	["mferro"] = { index = "ferro", nome = "Ferro" },
	["mrubi"] = { index = "rubi", nome = "Rubi" },
	["mesmeralda"] = { index = "esmeralda", nome = "Esmeralda" },
	["diamante"] = { index = "diamante", nome = "Diamante" },

	["agua"] = { index = "agua", nome = "Água" },
	["limonada"] = { index = "limonada", nome = "Limonada" },
	["refrigerante"] = { index = "refrigerante", nome = "Refrigerante" },
	["cafe"] = { index = "cafe", nome = "Café" },
	["pao"] = { index = "pao", nome = "Pão" },
	["chocolate"] = { index = "chocolate", nome = "chocolate" },
	["salgadinho"] = { index = "salgadinho", nome = "salgadinho" },
	["rosquinha"] = { index = "rosquinha", nome = "rosquinha" },
	["sanduiche"] = { index = "sanduiche", nome = "sanduiche" },
	["pizza"] = { index = "pizza", nome = "pizza" },

	["pseudoefedrina"] = { index = "pseudoefedrina", nome = "Pseudoefedrina" },
	["anfetamina"] = { index = "anfetamina", nome = "Anfetamina" },
	["ritalina"] = { index = "ritalina", nome = "Ritalina" },
	["metasuja"] = { index = "metasuja", nome = "Metanfetamina Suja" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina" },
	
	["cocaina"] = { index = "cocaina", nome = "Cocaína" },
	["acetofenetidina"] = { index = "acetofenetidina", nome = "Acetofenetidina" },
	["benzoilecgonina"] = { index = "benzoilecgonina", nome = "Benzoilecgonina" },
	["cloridratoecgonina"] = { index = "cloridratoecgonina", nome = "Cloridratoecgonina" },
	["cloridratococa"] = { index = "cloridrato", nome = "Cloridratococa" },
	["pastadecoca"] = { index = "pastadecoca", nome = "Pasta de Cocaina" },
	
	----------------------------------CONFERIR
	["ak103pack"] = { index = "ak103pack", nome = "Ak 103 Pack" },
	["coletepack"] = { index = "coletepack", nome = "Colete Pack" },
	["fivesevenpack"] = { index = "fivesevenpack", nome = "Five-Seven Pack" },
	["mtarpack"] = { index = "mtarpack", nome = "Mtar Pack" },
	["pumpshotgunpack"] = { index = "pumpshotgunpack", nome = "Pump Shotgun Pack" },
	["thompsonpack"] = { index = "thompsonpack", nome = "Thompson Pack" },
	["uzipack"] = { index = "uzipack", nome = "Uzi Pack" },
	["municaoakpack"] = { index = "municaoakpack", nome = "Municao Ak Pack" },
	["municaofamaspack"] = { index = "municaofamaspack", nome = "Municao Mtar Pack" },
	["municaopistolpack"] = { index = "municaopistolpack", nome = "Municao Five-Seven Pack" },
	["municaopumppack"] = { index = "municaopumppack", nome = "Municao PumpShotgun Pack" },
	["municaothompsonpack"] = { index = "municaothompsonpack", nome = "Municao Thompson Pack" },
	["municaouzipack"] = { index = "municaouzipack", nome = "Municao Uzi Pack" },
	---------------------------------

	["placa"] = { index = "placa", nome = "Placa" },
	["rebite"] = { index = "rebite", nome = "Rebite" },
	["carbono"] = { index = "carbono", nome = "Carbono" },
	["ferro"] = { index = "ferro", nome = "Ferro" },
	["aco"] = { index = "aco", nome = "Aço" },
	["capsula"] = { index = "capsula", nome = "Cápsula" },
	["polvora"] = { index = "polvora", nome = "Pólvora" },
	["orgao"] = { index = "orgao", nome = "Órgão" },
	["Furadeira"] = { index = "Furadeira", nome = "Furadeira" },
	["bombaadesiva"] = { index = "bombaadesiva", nome = "Bomba Adesiva" },
	["etiqueta"] = { index = "etiqueta", nome = "Etiqueta" },
	["pendrive"] = { index = "pendrive", nome = "Pendrive" },
	["relogioroubado"] = { index = "relogioroubado", nome = "Relógio Roubado" },
	["pulseiraroubada"] = { index = "pulseiraroubada", nome = "Pulseira Roubada" },
	["anelroubado"] = { index = "anelroubado", nome = "Anel Roubado" },
	["colarroubado"] = { index = "colarroubado", nome = "Colar Roubado" },
	["brincoroubado"] = { index = "brincoroubado", nome = "Brinco Roubado" },
	["carteiraroubada"] = { index = "carteiraroubada", nome = "Carteira Roubada" },
	["carregadorroubado"] = { index = "carregadorroubado", nome = "Carregador Roubado" },
	["tabletroubado"] = { index = "tabletroubado", nome = "Tablet Roubado" },
	["sapatosroubado"] = { index = "sapatosroubado", nome = "Sapatos Roubado" },
	["vibradorroubado"] = { index = "vibradorroubado", nome = "Vibrador Roubado" },
	["perfumeroubado"] = { index = "perfumeroubado", nome = "Perfume Roubado" },
	["maquiagemroubada"] = { index = "maquiagemroubada", nome = "Maquiagem Roubada" },
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês" },
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete" },
	["wbody|WEAPON_SPECIALCARBINE"] = { index = "parafall", nome = "Parafall" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19" },
	["wbody|WEAPON_APPISTOL"] = { index = "vp9", nome = "Koch VP9" },
	["wbody|WEAPON_STUNGUN"] = { index = "tazer", nome = "Tazer" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44" },
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador" },
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi" },
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "Mini-AK", nome = "Mini-AK" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-Mini-AK", nome = "Munição De Mini-AK" },
	["wbody|WEAPON_COMBATPDW"] = { index = "sigsauer", nome = "Sig Sauer MPX" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870" },
	["wbody|WEAPON_SAWNOFFSHOTGUN"] = { index = "shotgun", nome = "Shotgun" },
	["wammo|WEAPON_SAWNOFFSHOTGUN"] = { index = "m-shotgun", nome = "Munição de Shotgun" },
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "Munição de Tec-9" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "imbel", nome = "Imbel IA2" },
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak103", nome = "AK-103" },
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "Munição de M1911" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "Munição de FN Five Seven" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "Munição de Glock 19" },
	["wammo|WEAPON_APPISTOL"] = { index = "m-vp9", nome = "Munição de Koch VP9" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-tazer", nome = "Munição de Tazer" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "Munição de HK P7M10" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "Munição de M1922" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-magnum44", nome = "Munição de Magnum 44" },
	["wammo|WEAPON_SPECIALCARBINE"] = { index = "m-parafall", nome = "Munição de Parafall" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "Munição de Winchester 22" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "Munição de Sinalizador" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "Munição de Paraquedas" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "Munição de Extintor" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "Munição de Imbel IA2" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "Munição de MP5" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-mtar21", nome = "Munição de MTAR-21" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sigsauer", nome = "Munição de Sig Sauer MPX" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "Munição de Remington 870" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-imbel", nome = "Munição de M4A1" },
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak103", nome = "Munição de AK-103" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "Munição de Thompson" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina" }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
			vRP.logInfoToFile("logRJ/item.txt",user_id.." spawnou "..rawCommand.." .")
			SendWebhookMessage(webhooklinkadm,  "``` ITEM " ..user_id.." pegou o item: "..args[1].." Quantidade: "..args[2].. "```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GUARDAR COLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcolete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local armour = vRPclient.getArmour(player)
	local descricao = vRP.prompt(source,"Deseja guarda o colete ?, Digite (Sim/Nao)","")
	if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
	if armour > 95 then
       vRPclient.setArmour(source,0)
       vRP.giveInventoryItem(user_id,"colete",1,true)
       TriggerClientEvent("tirandocolete",player)
       TriggerClientEvent("Notify",source,"sucesso","Você guardou o seu <b>Colete</b>.")
    else
       TriggerClientEvent("Notify",source,"negado","<b>Coletes</b> danificados não podem ser <b>Guardados</b>.")
    end
end)

-- GUARDAR COLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcoleteteste',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local armour = vRPclient.getArmour(player)
	local descricao = vRP.prompt(source,"Deseja guarda o colete ?, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
	
	if armour > 95 then
       vRPclient.setArmour(source,0)
       vRP.giveInventoryItem(user_id,"colete",1,true)
       TriggerClientEvent("tirandocolete",player)
       TriggerClientEvent("Notify",source,"sucesso","Você guardou o seu <b>Colete</b>.")
    else
       TriggerClientEvent("Notify",source,"negado","<b>Coletes</b> danificados não podem ser <b>Guardados</b>.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JOGAR FORA O COLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jcolete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local armour = vRPclient.getArmour(player)
	local descricao = vRP.prompt(source,"Deseja guarda o colete ?, Digite (Sim/Nao)","")
			if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
	if armour < 95 then
       vRPclient.setArmour(source,0)
       TriggerClientEvent("tirandocolete",player)
       TriggerClientEvent("Notify",source,"sucesso","Você jogou fora o seu <b>Colete</b>.")
       vRPclient._playAnim(player,true,{{"pickup_object","pickup_low",1}},false)
    else
       TriggerClientEvent("Notify",source,"negado","Seu <b>Colete</b> nao está <b>Danificado</b>.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUG CRIAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Instanced then
			for i=0, 255 do
				local otherPlayerPed = GetPlayerPed(i)
				
				if otherPlayerPed ~= PlayerPedId() then
					SetEntityLocallyInvisible(otherPlayerPed)
					SetEntityNoCollisionEntity(PlayerPedId(),  otherPlayerPed,  true)
				end
			end
		end
	end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- /EQUIPAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('equipar',function(source,args,rawCommand)
	for k,v in pairs(itemlist) do
		if args[1] == v.index and args[1] ~= "mochila" then
			local user_id = vRP.getUserId(source)
			if vRP.tryGetInventoryItem(user_id,k,1) then
				local weapons = {}
				weapons[string.gsub(k,"wbody|","")] = { ammo = 0 }
				vRPclient._giveWeapons(source,weapons)
				vRP.logs("savedata/armamento.txt","[ID]: "..user_id.." / [FUNÇÃO]: Equipar / [ARMA]: "..v.index)
			else
				TriggerClientEvent("Notify",source,"negado","Armamento não encontrado.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('mascara',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de máscara.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('blusa',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de blusa.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('jaqueta',source,args[1],args[2])
	else
	TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de jaqueta.")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- coletes
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('coletes',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('coletes',source,args[1],args[2])
	else
	TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de colete.")
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- CALCA
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('calca',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de calça.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('maos',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de mãos.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACESSORIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('acessorios',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de acessórios.")
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- SAPATO
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('sapatos',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de sapatos.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('chapeu',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de chapéu.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('oculos',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de óculos.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /RECARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('recarregar',function(source,args,rawCommand)
	for k,v in pairs(itemlist) do
		if args[1] == v.index and args[1] ~= "mochila" then
			local uweapons = vRPclient.getWeapons(source)
			local weaponuse = string.gsub(k,"wbody|","")
			if uweapons[weaponuse] then
				local user_id = vRP.getUserId(source)
				if vRP.tryGetInventoryItem(user_id,"wammo|"..weaponuse,parseInt(args[2])) then
					local weapons = {}
					weapons[weaponuse] = { ammo = parseInt(args[2]) }
					vRPclient._giveWeapons(source,weapons,false)
					vRP.logs("savedata/armamento.txt","[ID]: "..user_id.." / [FUNÇÃO]: Recarregar / [ARMA]: "..v.index)
				else
					TriggerClientEvent("Notify",source,"negado","Munição não encontrada.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","Equipe o armamento antes.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('moc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(user_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(user_id)).."kg^4  ]  - -")
			for k,v in pairs(data.inventory) do
				if k and v then
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."^2    |    "..itemlist[k].index)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /DROPAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dropar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		local px,py,pz = vRPclient.getPosition(source)
		for k,v in pairs(itemlist) do
			if args[1] == v.index then
				if args[2] and parseInt(args[2]) > 0 then
					if vRP.tryGetInventoryItem(user_id,k,parseInt(args[2])) then
						TriggerEvent("DropSystem:create",k,parseInt(args[2]),px,py,pz)
						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						vRP.logs("savedata/dropar.txt","[ID]: "..user_id.." / [ITEM]: "..k.." / [QTD]: "..parseInt(args[2]))
					end
				else
					local data = vRP.getUserDataTable(user_id)
					for i,o in pairs(data.inventory) do
						if itemlist[i].index == args[1] then
							if vRP.tryGetInventoryItem(user_id,k,parseInt(o.amount)) then
								TriggerEvent("DropSystem:create",k,parseInt(o.amount),px,py,pz)
								vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
								vRP.logs("savedata/dropar.txt","[ID]: "..user_id.." / [ITEM]: "..k.." / [QTD]: "..parseInt(o.amount))
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)
		TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
		if data and data.inventory then
			for k,v in pairs(data.inventory) do
				TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome)
			end
		end
		TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
		for k,v in pairs(weapons) do
			if v.ammo < 1 then
				TriggerClientEvent('chatMessage',source,"",{},"     1x "..itemlist["wbody|"..k].nome)
			else
				TriggerClientEvent('chatMessage',source,"",{},"     1x "..itemlist["wbody|"..k].nome.." | "..vRP.format(parseInt(v.ammo)).."x Munições")
			end
		end
		TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
veiculos["CLONADOS"] = true
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"admin.permissao") then
		DropPlayer(source,"Voce foi desconectado por ficar ausente.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALERTAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('alertas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"alertas.permissao") then
		vRP.removeUserGroup(user_id,"Alertas")
		TriggerClientEvent("Notify",source,"importante","Você removeu as notificações.")
	else
		vRP.addUserGroup(user_id,"Alertas")
		TriggerClientEvent("Notify",source,"sucesso","Você ativou as notificações.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('casas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if args[1] and vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer == nil then
			return
		end
		user_id = vRP.getUserId(nplayer)
	end
	if user_id then
		local address = vRP.getUserAddress(user_id)
		local casas = ""
		if args[1] then
			if #address > 0 then
				for k,v in pairs(address) do
					casas = casas..v.home.." - Nº"..v.number
					if k ~= #address then
						casas = casas..", "
					end
				end
				TriggerClientEvent("Notify",source,"importante","Residências possuidas pelo passaporte <b>"..vRP.format(parseInt(args[1])).."</b>: "..casas)
			else
				TriggerClientEvent("Notify",source,"negado","Passaporte <b>"..vRP.format(parseInt(args[1])).."</b> não possui residências.")
			end
		else
			if #address > 0 then
				for k,v in pairs(address) do
					casas = casas..v.home.." - Nº"..v.number
					if k ~= #address then
						casas = casas..", "
					end
				end
				TriggerClientEvent("Notify",source,"importante","Residências possuidas: "..casas)
			else
				TriggerClientEvent("Notify",source,"importante","Não possui residências em seu nome.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('motor',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if not vRPclient.isInVehicle(source) then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
			TriggerClientEvent("progress",source,30000,"reparando")
			SetTimeout(30000,function()
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent('repararmotor',source,vehicle)
				vRPclient._stopAnim(source,false)
			end)
		else
			if vRP.tryGetInventoryItem(user_id,"militec",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",source,30000,"reparando")
				SetTimeout(30000,function()
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('repararmotor',source,vehicle)
					vRPclient._stopAnim(source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Militec-1</b> para reparar o motor.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
	end
end)

RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reparar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if not vRPclient.isInVehicle(source) then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
			TriggerClientEvent("progress",source,30000,"reparando")
			SetTimeout(30000,function()
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent('reparar',source,vehicle)
				vRPclient._stopAnim(source,false)
			end)
		else
			if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",source,30000,"reparando")
				SetTimeout(30000,function()
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('reparar',source,vehicle)
					vRPclient._stopAnim(source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Kit de Reparos</b> para reparar o veículo.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
	end
end)

RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id and args[1] and parseInt(args[2]) > 0 then
		for k,v in pairs(itemlist) do
			if args[1] == v.index then
				if vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(k)*parseInt(args[2]) <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,k,parseInt(args[2])) then
						vRP.giveInventoryItem(nuser_id,k,parseInt(args[2]))
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..parseInt(args[2]).."x "..v.nome.."</b>.")
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..parseInt(args[2]).."x "..v.nome.."</b>.")
						vRP.logs("savedata/enviar.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [ITEM]: "..k)
					end
				end
			end
		end
	elseif nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.")
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.")
			vRP.logs("savedata/enviar.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [VALOR]: "..parseInt(args[1]))
			SendWebhookMessage(webhooklinkenviarmoney,  "``` [" ..user_id.."] Enviou ["..nuser_id.."] R$:"..args[1].. "```")
		else
		end
	end  -- ..args[1]..
end)

RegisterCommand("beijar2",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,2)
    if nplayer then
        local pedido = vRP.request(nplayer,"Deseja iniciar o beijo ?",10)
        if pedido then
            vRPclient.playAnim(source,true,{{"mp_ped_interaction","kisses_guy_a"}},false)    
            vRPclient.playAnim(nplayer,true,{{"mp_ped_interaction","kisses_guy_b"}},false)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('garmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local weapons = vRPclient.replaceWeapons(source,{})
		local tempog = math.random(5000,10000)
        Citizen.Wait(tempog)
		for k,v in pairs(weapons) do
			vRP.giveInventoryItem(user_id,"wbody|"..k,1)
			vRP.logInfoToFile("logRJ/guardaarmas.txt",user_id.." guardou wbody|"..k.." .") -- AINDA CORRIGIR
			SendWebhookMessage(webhooklinkgarmas,  "```" ..user_id.." guardou wbody|"..k.. "```")

			if v.ammo > 0 then
				vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
				SendWebhookMessage(webhooklinkgarmas,  "```" ..user_id.." guardou wammo|"..k.. " "  ..v.ammo.. "```")
			end
		end
		TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('testgarmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local weapons = vRPclient.replaceWeapons(source,{})
		for k,v in pairs(weapons) do
			vRP.giveInventoryItem(user_id,"wbody|"..k,1)
			vRP.logInfoToFile("logRJ/guardaarmas.txt",user_id.." guardou wbody|"..k.." .") -- AINDA CORRIGIR
			SendWebhookMessage(webhooklinkgarmas,  "```" ..user_id.." guardou wbody|"..k.. "```")

			if v.ammo > 0 then
				vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
				SendWebhookMessage(webhooklinkgarmas,  "```" ..user_id.." guardou wammo|"..k.. " "  ..v.ammo.. "```")
				vRP.logInfoToFile("logRJ/guardaarmas.txt",user_id.." guardou wammo|"..k.. " "  ..v.ammo.." .")
			end
		end
		TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLONEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cloneplate',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.isInVehicle(source) and vRP.tryGetInventoryItem(user_id,"placa",1) then
			TriggerClientEvent("cloneplates",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBAR
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 1 then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody"..k].nome.."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
						SendWebhookMessage(webhooklinkroubo,  "```" ..user_id.." roubou "..nuser_id.."  R$" ..nmoney.. " Arma ```")
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								SendWebhookMessage(webhooklinkroubo,  "```" ..user_id.." roubou "..nuser_id.."  R$" ..k.."```")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody|"..k].nome.."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					SendWebhookMessage(webhooklinkroubo,  "```" ..user_id.." roubou "..nuser_id.."  R$" ..nmoney.. "```")
				end
			else
				TriggerClientEvent("Notify",source,"aviso","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Número insuficiente de policiais no momento.")
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SAQUEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('saquear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 1 then
		if vRPclient.isInComa(nplayer) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody"..k].nome.."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
						SendWebhookMessage(webhooklinksaquear,  "```" ..user_id.." saqueou "..nuser_id.."  R$" ..nmoney.. "```")
						
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody|"..k].nome.."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					SendWebhookMessage(webhooklinksaquear,  "```" ..user_id.." saqueou "..nuser_id.."  R$" ..nmoney.. "```")
				end
			else
				TriggerClientEvent("Notify",source,"aviso","O jogador não está em coma.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Número insuficiente de policiais no momento.")
		end
	end
end)
]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('chamar',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	vida = vRPclient.getHealth(source)
	vRPclient._CarregarObjeto(source,"cellphone@","cellphone_call_to_text","prop_amb_phone",50,28422)
	if user_id then
		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			vRPclient._stopAnim(source,false)
			vRPclient._DeletarObjeto(source)
			return
		end

		local x,y,z = vRPclient.getPosition(source)
		local players = {}
		vRPclient._stopAnim(source,false)
		vRPclient._DeletarObjeto(source)
		local especialidade = false
		if args[1] == "190" then
			players = vRP.getUsersByPermission("policiachamado.permissao")
			especialidade = "<b>Policiais</b>"
		elseif args[1] == "policia" then
			players = vRP.getUsersByPermission("policiachamado.permissao")
			especialidade = "<b>Policiais</b>"
		elseif args[1] == "192" then
			players = vRP.getUsersByPermission("paramedico.permissao")
			especialidade = "Colaboradores do <b>SAMU</b>"
		elseif args[1] == "mecanico" then
			players = vRP.getUsersByPermission("mecanico.permissao")
			especialidade = "<b>Mecânicos</b>"
		elseif args[1] == "taxi" then
			players = vRP.getUsersByPermission("uber.permissao")
			especialidade = "<b>Uber</b>"
		elseif args[1] == "uber" then
			players = vRP.getUsersByPermission("uber.permissao")
			especialidade = "<b>Uber</b>"
		elseif args[1] == "civil" then
			players = vRP.getUsersByPermission("policiacivil.permissao")
			especialidade = "<b>PoliciaCivil</b>"
		elseif args[1] == "samu" then
			players = vRP.getUsersByPermission("paramedico.permissao")	
			especialidade = "Colaboradores do <b>SAMU</b>"
		elseif args[1] == "prf" then
			players = vRP.getUsersByPermission("policiaprf.permissao")	
			especialidade = "<b>PoliciaisPRF</b>"
		elseif args[1] == "advogado" then
			players = vRP.getUsersByPermission("advogado.permissao")	
			especialidade = "<b>Advogado</b>"
		--[[elseif args[1] == "adm" then
			players = vRP.getUsersByPermission("admin.permissao")	
			especialidade = "Administradores"
		elseif args[1] == "deus" then
			players = vRP.getUsersByPermission("admin.permissao")	
			especialidade = "Administradores"
		elseif args[1] == "god" then
			players = vRP.getUsersByPermission("admin.permissao")	
			especialidade = "Administradores"]]
		else
			TriggerClientEvent("Notify",source,"negado","Serviço <b>inexistente</b> na Cidade.")
			return
		end
		
		local adm = ""
		if especialidade == "Administradores" then
			adm = "[ADM]: "
		end
		
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		if #players == 0  and especialidade ~= "<b>Policiais</b>" and especialidade ~="<b>PoliciaCivil</b>" and especialidade ~="PoliciaisPRF" then
			TriggerClientEvent("Notify",source,"importante","Não há "..especialidade.." em serviço.")
		else
			local identitys = vRP.getUserIdentity(user_id)
			TriggerClientEvent("Notify",source,"sucesso","O Seu <b>Chamado</b> foi enviado com sucesso.")
			for l,w in pairs(players) do
				local player = vRP.getUserSource(parseInt(w))
				local nuser_id = vRP.getUserId(player)
				if player and player ~= uplayer then
					async(function()
						vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
						TriggerClientEvent('chatMessage',player,"Chamado ",{255,0,0},adm.." Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
						local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.. " ["..user_id.."]</b>?",30)
						if ok then
							if not answered then
								answered = true
								local identity = vRP.getUserIdentity(nuser_id)
								TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								vRPclient._setGPS(player,x,y)
							else
								TriggerClientEvent("Notify",player,"negado","Chamado ja foi atendido por outra <b>pessoa.</b>")
								vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
							end
						end
						local id = idgens:gen()
						blips[id] = vRPclient.addBlip(player,x,y,z,543,27,"Chamado",0.6,false)
						SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
RegisterCommand('p',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRPclient.getHealth(source) > 100 then
		if vRP.hasPermission(user_id,"policia.permissao") then
			local soldado = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player and player ~= uplayer then
					async(function()
						local id = idgens:gen()
						policia[id] = vRPclient.addBlip(player,x,y,z,153,84,"Localização de "..identity.name.." "..identity.firstname,0.5)
						TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Localização recebida de ^1"..identity.name.." "..identity.firstname.."^0.")
						TriggerClientEvent('InteractSound_CL:PlayOnOne',player,'beep',0.7)
						SetTimeout(60000,function() vRPclient.removeBlip(player,policia[id]) idgens:free(id) end)
					end)
				end
			end
		end
	end
end)
RegisterServerEvent('offred:qthPolicepacorabane')
AddEventHandler('offred:qthPolicepacorabane', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local typemessage = "info"
		local messagedesc = "Enviou sua localização para a central"
		vRPclient.setDiv(source, "local","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..messagedesc.."</p></div>")
		SetTimeout(5000,function()
			vRPclient.removeDiv(source,"local")
		end)
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player and player ~= uplayer then
				async(function()
					local id = idgens:gen()
					policia[id] = vRPclient.addBlip(player,x,y,z,637,1,"Localização de "..identity.name.." "..identity.firstname,0.5)
					TriggerClientEvent('criarblipp',player,x,y,z, "Localização de "..identity.name.." "..identity.firstname)
					local typemessage = "info"
					local messagedesc = "Localização recebida de "..identity.name.." "..identity.firstname..""
					TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Localização recebida de ^1"..identity.name.." "..identity.firstname.."^0.")
					SetTimeout(60000,function() vRPclient.removeBlip(player,policia[id]) idgens:free(id) end)
					vRPclient.setDiv(player, "local","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..messagedesc.."</p></div>")
					SetTimeout(5000,function()
						vRPclient.removeDiv(player,"local")
					end)
					TriggerClientEvent('InteractSound_CL:PlayOnOne',player,'beep',0.7)
					SetTimeout(30000,function() TriggerClientEvent('removerblipp',-1) end)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /INVENTÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
local itemSelected = nil

function match(string, type, weapon)
    local string = string:match('^('..type..')(.)('..weapon..')')
    if string then
       return true
    else
       return false
    end
end

function buildInventory(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data.inventory then			
			local close_count = 0

			local use = function(player, choice)
				if itemlist[itemSelected].index == "bandagem" then
					vida = vRPclient.getHealth(source)
					if vida > 100 and vida < 400 then
						if bandagem[user_id] == 0 or not bandagem[user_id] then
							if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
								TriggerClientEvent('cancelando',source,true)
								TriggerClientEvent("progress",source,10000,"bandagem")
								SetTimeout(10000,function()
									bandagem[user_id] = 60
									TriggerClientEvent('bandagem',source)
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent("Notify",source,"sucesso","Bandagem utilizada com sucesso.")
								end)
							else
								TriggerClientEvent("Notify",source,"negado","Bandagem não encontrada na mochila.")
							end
						else
							TriggerClientEvent("Notify",source,"importante","Você precisa aguardar <b>"..bandagem[user_id].." segundos</b> para utilizar outra Bandagem.")
						end
					else
						TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.")
					end
				elseif itemlist[itemSelected].index == "cerveja" or itemlist[itemSelected].index == "tequila" or itemlist[itemSelected].index == "vodka" or itemlist[itemSelected].index == "agua" or itemlist[itemSelected].index == "conhaque" or itemlist[itemSelected].index == "absinto" then
					if vRP.tryGetInventoryItem(user_id,itemlist[itemSelected].index,1) then
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
						TriggerClientEvent("progress",source,10000,"bebendo")
						SetTimeout(10000,function()
							vRPclient.playScreenEffect(source,"RaceTurbo",180)
							vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify", source, "sucesso", itemlist[itemSelected].nome.." utilizado com sucesso.")	
						end)
					else
						TriggerClientEvent("Notify", source, "negado", itemlist[itemSelected].nome.." utilizado com sucesso.")	
					end
				elseif itemlist[itemSelected].index == "whisky" then
					if vRP.tryGetInventoryItem(user_id,"whisky",1) then
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
						TriggerClientEvent("progress",source,10000,"bebendo")
						SetTimeout(10000,function()
							vRPclient.playScreenEffect(source,"RaceTurbo",180)
							vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify", source,"sucesso", itemlist[itemSelected].nome.." utilizado com sucesso.")	
						end)
					else
						TriggerClientEvent("Notify", source, "negado", itemlist[itemSelected].nome.." utilizado com sucesso.")	
					end
				elseif itemlist[itemSelected].index == "maconha" then
					if vRP.tryGetInventoryItem(user_id,"maconha",1) then
						vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
						TriggerClientEvent("progress",source,10000,"fumando")
						SetTimeout(10000,function()
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",180)
							vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
							TriggerClientEvent("Notify",source,"sucesso","Maconha utilizada com sucesso.")
						end)
					else
						TriggerClientEvent("Notify",source,"negado","Maconha não encontrada na mochila.")
					end
				elseif itemlist[itemSelected].index == "rebite" or itemlist[itemSelected].index == "energetico" then
					if vRP.tryGetInventoryItem(user_id,itemlist[itemSelected].index,1) then
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
						TriggerClientEvent("progress",source,10000,"bebendo")
						SetTimeout(10000,function()
							vRPclient.playScreenEffect(source,"RaceTurbo",180)
							vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
							TriggerClientEvent('energeticos',source,true)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso", itemlist[itemSelected].nome.." utilizado com sucesso.")
						end)
						SetTimeout(60000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito do "..itemlist[itemSelected].nome.." passou e o coração voltou a bater normalmente.")
						end)
					else
						TriggerClientEvent("Notify",source,"negado","Rebite não encontrado na mochila.")
					end
				elseif itemlist[itemSelected].index == "capuz" then
					if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
						local nplayer = vRPclient.getNearestPlayer(source,2)
						if nplayer then
							vRPclient.setCapuz(nplayer)
							vRP.closeMenu(nplayer)
							TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Capuz não encontrado na mochila.")
					end
				elseif itemlist[itemSelected].index == "lockpick" then
					local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
					local mPlacaUser = vRP.getUserByRegistration(mPlaca)
					if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and mName then
						if vRP.hasPermission(user_id,"policia.permissao") then
							TriggerClientEvent("syncLock",-1,mNet)
							return
						end
						TriggerClientEvent('cancelando',source,true)
						vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
						TriggerClientEvent("progress",source,30000,"roubando")
						SetTimeout(30000,function()
							TriggerClientEvent('cancelando',source,false)
							vRPclient._stopAnim(source,false)
							if not mPlacaUser then
								TriggerClientEvent("syncLock",-1,mNet)
								TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
							else
								if math.random(100) >= 80 then
									TriggerClientEvent("syncLock",-1,mNet)
									TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
								else
									TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.")
									local policia = vRP.getUsersByPermission("policia.permissao")
									for k,v in pairs(policia) do
										local player = vRP.getUserSource(parseInt(v))
										if player then
											async(function()
												local id = idgens:gen()
												TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
												pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
												SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
											end)
										end
									end
								end
							end
						end)
					else
						TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Lockpick</b> para iniciar o roubo do veículo.")
					end
				elseif itemlist[itemSelected].index == "masterpick" then
					local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
					local mPlacaUser = vRP.getUserByRegistration(mPlaca)
					if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and mName then			
						if vRP.hasPermission(user_id,"policia.permissao") then
							TriggerClientEvent("syncLock",-1,mNet)
							return
						end			
						TriggerClientEvent('cancelando',source,true)
						vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
						TriggerClientEvent("progress",source,60000,"roubando")			
						SetTimeout(60000,function()
							TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent("syncLock",-1,mNet)
							vRPclient._stopAnim(source,false)			
							local policia = vRP.getUsersByPermission("policia.permissao")
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								SendWebhookMessage(webhooklinkmasterpick,  "``` MASTERPICK" ..user_id.." roubou "..mName.. " Placa;" ..mPlaca.. " User test; " ..mPlacaUser.. " local; " ..x.. "," ..y.. "," ..z.. "```")
								if player then
									async(function()
										local id = idgens:gen()
										TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
										pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
										SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
									end)
								end
							end
						end)
					else
						TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Masterpick</b> para iniciar o roubo do veículo.")
					end
				end
			end
	
			local drop = function(player, choice)
				local user_id = vRP.getUserId(source)
				local px,py,pz = vRPclient.getPosition(source)
				local quantity = vRP.prompt(source, "Quantidade:","")
				if quantity == "" or tonumber(quantity) <= 0 then
					TriggerClientEvent("Notify", source, "aviso", "Quantidade invalida!")
					vRP.closeMenu(player, submenu)
				else
					if match(itemSelected, "wammo", string.gsub(itemSelected, "wammo|", "")) then
						if vRP.getInventoryItemAmount(user_id, "wammo|"..string.gsub(itemSelected,"wammo|","")) >= tonumber(quantity) then
							if vRP.tryGetInventoryItem(user_id, "wammo|"..string.gsub(itemSelected,"wammo|",""), tonumber(quantity)) then
								TriggerEvent("DropSystem:create", "wammo|"..string.gsub(itemSelected,"wammo|",""), tonumber(quantity), px, py, pz)
								vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
							end
						else
							TriggerClientEvent("Notify", source, "negado", "Você não tem essa quantidade do item "..itemlist[itemSelected].nome..".")
						end
					elseif match(itemSelected, "wbody", string.gsub(itemSelected, "wbody|", "")) then
						if vRP.getInventoryItemAmount(user_id, "wbody|"..string.gsub(itemSelected,"wbody|","")) >= tonumber(quantity) then
							if vRP.tryGetInventoryItem(user_id, "wbody|"..string.gsub(itemSelected,"wbody|",""), tonumber(quantity)) then
								TriggerEvent("DropSystem:create", "wbody|"..string.gsub(itemSelected,"wbody|",""), tonumber(quantity), px, py, pz)
								vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
							end
						else
							TriggerClientEvent("Notify", source, "negado", "Você não tem essa quantidade do item "..itemlist[itemSelected].nome..".")
						end
					else
						if vRP.getInventoryItemAmount(user_id, itemlist[itemSelected].index) >= tonumber(quantity) then
							if vRP.tryGetInventoryItem(user_id, itemlist[itemSelected].index, tonumber(quantity)) then
								TriggerEvent("DropSystem:create", itemlist[itemSelected].index, tonumber(quantity), px, py, pz)
								vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
							end
						else
							TriggerClientEvent("Notify", source, "negado", "Você não tem essa quantidade do item "..itemlist[itemSelected].nome..".")
						end
					end
					vRP.closeMenu(player, submenu)
				end
			end
			
			
			local equip = function(player, choice)				
				local weapon = string.gsub(itemSelected,"wbody|","") 
				local ammo = vRP.getInventoryItemAmount(user_id, "wammo|"..string.gsub(itemSelected,"wbody|",""))				
				if ammo >= 0 then
					local question = vRP.prompt(source, "Deseja equipar as munições também ? (Sim ou Não)","")
				else
					question = nil				
				end
				if question == "Sim" or question == "sim" then
					if ammo >= 1 then
						if vRP.tryGetInventoryItem(user_id,"wammo|"..string.gsub(itemSelected,"wbody|",""), ammo) then
							ammoset = ammo
							TriggerClientEvent("Notify", source, "sucesso", "Munições coletadas com sucesso.")
						end
					else
						TriggerClientEvent("Notify", source, "negado", "Você não possui munição!")
					end
				elseif question == "Não" or question == "Nao" or question == "nao" or question == "não" then
					ammoset = 0
				else
					ammoset = 0
				end
				local weapons = {}
				if vRP.tryGetInventoryItem(user_id,itemSelected,1) then
					weapons[string.gsub(itemSelected,"wbody|","")] = { ammo = ammoset }
					vRPclient._giveWeapons(player,weapons)
					vRP.logs("savedata/armamento.txt","[ID]: "..user_id.." / [FUNÇÃO]: Equipar / [ARMA]: "..itemlist[itemSelected].index)
					TriggerClientEvent("Notify", source, "sucesso", itemlist[itemSelected].nome.." equipado com sucesso.")	
				end				
				vRP.closeMenu(player, submenu)
			end
			
			local send = function(player, choice)
				local user_id = vRP.getUserId(source)
				local nplayer = vRPclient.getNearestPlayer(source, 2)
				local nuser_id = vRP.getUserId(nplayer)
				local quantity = vRP.prompt(source, "Quantidade:","")
				if nuser_id and itemlist[itemSelected].index and parseInt(quantity) > 0 then
					for k,v in pairs(itemlist) do
						if itemlist[itemSelected].index == v.index then
							if vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(k)*parseInt(quantity) <= vRP.getInventoryMaxWeight(nuser_id) then
								if vRP.tryGetInventoryItem(user_id,k,parseInt(quantity)) then
									vRP.giveInventoryItem(nuser_id,k,parseInt(quantity))
									vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
									TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..parseInt(quantity).."x "..v.nome.."</b>.")
									TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..parseInt(quantity).."x "..v.nome.."</b>.")
									vRP.logs("savedata/enviar.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [ITEM]: "..k)
								end
							end
						end
					end			
				end
			end

			local reload = function(player, choice)
				local uweapons = vRPclient.getWeapons(source)
				local weaponuse = string.gsub(itemSelected,"wammo|","")
				if uweapons[weaponuse] then
					local user_id = vRP.getUserId(source)
					local ammo = vRP.getInventoryItemAmount(user_id, itemSelected)
					local quantity = vRP.prompt(source, "Quantidade:","")
					if tonumber(quantity) == nil or quantity == "" then
						if vRP.tryGetInventoryItem(user_id, itemSelected, ammo) then
							local weapons = {}
							weapons[weaponuse] = {ammo = ammo}
							vRPclient._giveWeapons(source,weapons,false)
							vRP.logs("savedata/armamento.txt", "[ID]: "..user_id.." / [FUNÇÃO]: Recarregar / [ARMA]: "..itemSelected)
						else
							TriggerClientEvent("Notify",source,"negado","Munição não encontrada.")
						end
					elseif ammo < tonumber(quantity) or tonumber(quantity) <= 0 then
						TriggerClientEvent("Notify",source,"negado","Você tem apenas <b>"..ammo.."</b> balas.")
					else					
						if vRP.tryGetInventoryItem(user_id, itemSelected, parseInt(quantity)) then
							local weapons = {}
							weapons[weaponuse] = {ammo = parseInt(quantity)}
							vRPclient._giveWeapons(source,weapons, false)
							vRP.logs("savedata/armamento.txt", "[ID]: "..user_id.." / [FUNÇÃO]: Recarregar / [ARMA]: "..itemSelected)
						else
							TriggerClientEvent("Notify",source,"negado","Munição não encontrada.")
						end
					end
				else
					TriggerClientEvent("Notify",source,"importante","Equipe o armamento antes.")
				end
				vRP.closeMenu(player, submenu)
			end

			local bag = function(player, choice)
				if vRP.tryGetInventoryItem(user_id,"mochila",1) then
					vRP.varyExp(user_id,"physical","strength",650)
					TriggerClientEvent("Notify",source,"sucesso","Mochila utilizada com sucesso.")
				else
					TriggerClientEvent("Notify",source,"negado","Mochila não encontrada na mochila.")
				end
				vRP.closeMenu(player, submenu)
			end

			local item = function(player, choice)
				itemSelected = choice
				for key,value in pairs(itemlist) do
					if value.nome == choice then
						itemSelected = key
						label = value.nome
						local submenu = {}
						if match(key, "wbody", string.gsub(key, "wbody|", "")) then
							submenu = {name=value.nome}	
							submenu["Equipar"] = {equip, "<text01 style='width: 200px;'>Equipar item</text01>"}
						elseif match(key, "wammo", string.gsub(key,"wammo|","")) then
							submenu = {name="Munição"}		
							submenu["Recarregar"] = {reload, "<text01 style='width: 200px;'>Recarregar arma</text01>"}
						elseif value.index == "mochila" then
							submenu["Colocar"] = {bag, "<text01 style='width: 200px;'>Colocar mochila</text01>"}
						else
							submenu = {name=label.." ["..data.inventory[key].amount.."]"}
							submenu["Usar"] = {use, "<text01 style='width: 200px;'>Utilizar item</text01>"}
						end						
						submenu["Enviar"] = {send, "<text01 style='width: 200px;'>Enviar a um jogador proximo</text01>"}
						submenu["Dropar"] = {drop, "<text01 style='width: 200px;'>Jogar no chão</text01>"}
						submenu.onclose = function()
							vRP.closeMenu(player, submenu)
							buildInventory(player)
						end
						vRP.openMenu(player, submenu)
						break
					end
				end
			end
			
			local menu = {name="Inventário"}
			local count = 0
			for k,v in pairs(data.inventory) do count = count + 1
				if menu[k] then menu[k] = nil end	
				local weight = 0	
				local iweight = vRP.getItemWeight(k)
				weight = weight+iweight*data.inventory[k].amount
				menu[itemlist[k].nome] = { item, "<text01>Quantidade:</text01> <text02> "..data.inventory[k].amount.."</text02><text01>Peso:</text01> <text02>"..weight.."</text02><text01 style='color:gray;background:#000;width:174px;'><center>"..string.format("%.2f",vRP.getInventoryWeight(user_id)).."KG / "..string.format("%.2f",vRP.getInventoryMaxWeight(user_id)).."KG</center></text01>" }
			end
			menu.onclose = function()
				if close_count == 0 then
					if cb_close then
						cb_close()
					end
				end
			end
			if count <= 0 then
				TriggerClientEvent("Notify", source, "negado", "Seu <b>inventário</b> está vazio.")
				return
			end
			vRP.openMenu(source, menu)
		end
	end
end

function inventoryPlayer(id, source)
	local identity = vRP.getUserIdentity(id)
	local data = vRP.getUserDataTable(id)
	if data.inventory then
		local item = function(player, choice)
		end	
		local menu = {name="Inventário"}
		local count = 0
		for k,v in pairs(data.inventory) do count = count + 1
			if menu[k] then menu[k] = nil end	
			local weight = 0	
			local iweight = vRP.getItemWeight(k)
			weight = weight+iweight*data.inventory[k].amount
			menu[itemlist[k].nome] = { item, "<text01>Quantidade:</text01> <text02> "..data.inventory[k].amount.."</text02><text01>Peso:</text01> <text02>"..weight.."</text02><text01 style='color:white;background:#000;width:174px;'><center>Cidadão: "..identity.name.." "..identity.firstname.."</center></text01><text01 style='color:gray;background:#000;width:174px;'><center>"..string.format("%.2f",vRP.getInventoryWeight(id)).."KG / "..string.format("%.2f",vRP.getInventoryMaxWeight(id)).."KG</center></text01>" }
		end
		menu.onclose = function()
			vRP.closeMenu(source, menu)
		end
		if count <= 0 then
			TriggerClientEvent("Notify", source, "negado", "O <b>inventário</b> dele está vazio.")
			return
		end
		vRP.openMenu(source, menu)
	end
end

RegisterCommand('moc', function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if args[1] then
			local player = vRP.getUserSource(parseInt(args[1]))
			inventoryPlayer(parseInt(args[1]), source)			
		else
			buildInventory(source)
		end		
	end
end)

RegisterServerEvent("aztec:inventory")
AddEventHandler("aztec:inventory", function()
	buildInventory(source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{65,130,255},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{255,70,135},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "policia.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "paramedico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
--[[
local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)
]]

RegisterCommand('use',function(source,args,rawCommand)
	if args[1] == nil then
		return
	end
	local user_id = vRP.getUserId(source)
	if args[1] == "bandagem" then
		vida = vRPclient.getHealth(source)
		if vida > 100 and vida < 400 then
			if bandagem[user_id] == 0 or not bandagem[user_id] then
				if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent("progress",source,10000,"bandagem")
					SetTimeout(10000,function()
						bandagem[user_id] = 60
						TriggerClientEvent('bandagem',source)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"sucesso","Bandagem utilizada com sucesso.")
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Bandagem não encontrada na mochila.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","Você precisa aguardar <b>"..bandagem[user_id].." segundos</b> para utilizar outra Bandagem.")
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.")
		end
	elseif args[1] == "mochila" then
		if vRP.tryGetInventoryItem(user_id,"mochila",1) then
			vRP.varyExp(user_id,"physical","strength",650)
			TriggerClientEvent("Notify",source,"sucesso","Mochila utilizada com sucesso.")
		else
			TriggerClientEvent("Notify",source,"negado","Mochila não encontrada na mochila.")
		end
	elseif args[1] == "cerveja" then
		if vRP.tryGetInventoryItem(user_id,"cerveja",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				vRPclient.playScreenEffect(source,"RaceTurbo",180)
				vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Cerveja utilizada com sucesso.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Cerveja não encontrada na mochila.")
		end
	elseif args[1] == "tequila" then
		if vRP.tryGetInventoryItem(user_id,"tequila",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				vRPclient.playScreenEffect(source,"RaceTurbo",180)
				vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Tequila utilizada com sucesso.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Tequila não encontrada na mochila.")
		end
	elseif args[1] == "vodka" then
		if vRP.tryGetInventoryItem(user_id,"vodka",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				vRPclient.playScreenEffect(source,"RaceTurbo",180)
				vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Vodka utilizada com sucesso.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Vodka não encontrada na mochila.")
		end
			elseif args[1] == "agua" then
		if vRP.tryGetInventoryItem(user_id,"agua",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Água utilizada com sucesso.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Água não encontrada na mochila.")
		end
	elseif args[1] == "whisky" then
		if vRP.tryGetInventoryItem(user_id,"whisky",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				vRPclient.playScreenEffect(source,"RaceTurbo",180)
				vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Whisky utilizado com sucesso.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Whisky não encontrado na mochila.")
		end
	elseif args[1] == "conhaque" then
		if vRP.tryGetInventoryItem(user_id,"conhaque",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				vRPclient.playScreenEffect(source,"RaceTurbo",180)
				vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Conhaque utilizado com sucesso.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Conhaque não encontrado na mochila.")
		end
	elseif args[1] == "absinto" then
		if vRP.tryGetInventoryItem(user_id,"absinto",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				vRPclient.playScreenEffect(source,"RaceTurbo",180)
				vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Absinto utilizado com sucesso.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Absinto não encontrada na mochila.")
		end
	elseif args[1] == "maconha" then
		if vRP.tryGetInventoryItem(user_id,"maconha",1) then
			vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
			TriggerClientEvent("progress",source,10000,"fumando")
			SetTimeout(10000,function()
				vRPclient._stopAnim(source,false)
				vRPclient.playScreenEffect(source,"RaceTurbo",180)
				vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
				TriggerClientEvent("Notify",source,"sucesso","Maconha utilizada com sucesso.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Maconha não encontrada na mochila.")
		end
	elseif args[1] == "rebite" then
		if vRP.tryGetInventoryItem(user_id,"rebite",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				vRPclient.playScreenEffect(source,"RaceTurbo",180)
				vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
				TriggerClientEvent('energeticos',source,true)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Rebite utilizado com sucesso.")
			end)
			SetTimeout(60000,function()
				TriggerClientEvent('energeticos',source,false)
				TriggerClientEvent("Notify",source,"aviso","O efeito do rebite passou e o coração voltou a bater normalmente.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Rebite não encontrado na mochila.")
		end
	elseif args[1] == "capuz" then
		if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
			local nplayer = vRPclient.getNearestPlayer(source,2)
			if nplayer then
				vRPclient.setCapuz(nplayer)
				vRP.closeMenu(nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Capuz não encontrado na mochila.")
		end
	elseif args[1] == "energetico" then
		if vRP.tryGetInventoryItem(user_id,"energetico",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				TriggerClientEvent('energeticos',source,true)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Energético utilizado com sucesso.")
			end)
			SetTimeout(60000,function()
				TriggerClientEvent('energeticos',source,false)
				TriggerClientEvent("Notify",source,"aviso","O efeito do energético passou e o coração voltou a bater normalmente.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Energético não encontrado na mochila.")
		end
	elseif args[1] == "lockpick" then
		local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
		local mPlacaUser = vRP.getUserByRegistration(mPlaca)
		if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and mName then
			if vRP.hasPermission(user_id,"policia.permissao") then
				TriggerClientEvent("syncLock",-1,mNet)
				return
			end

			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
			TriggerClientEvent("progress",source,30000,"roubando")
			SetTimeout(30000,function()
				TriggerClientEvent('cancelando',source,false)
				vRPclient._stopAnim(source,false)

				if not mPlacaUser then
					TriggerClientEvent("syncLock",-1,mNet)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
				else
					if math.random(100) >= 80 then
						TriggerClientEvent("syncLock",-1,mNet)
						TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
					else
						TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.")
						local policia = vRP.getUsersByPermission("policia.permissao")
						for k,v in pairs(policia) do
							local player = vRP.getUserSource(parseInt(v))
							if player then
								async(function()
									local id = idgens:gen()
									TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
									pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
									SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
								end)
							end
						end
					end
				end
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Lockpick</b> para iniciar o roubo do veículo.")
		end
	elseif args[1] == "masterpick" then
		local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
		local mPlacaUser = vRP.getUserByRegistration(mPlaca)
		if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and mName then

			if vRP.hasPermission(user_id,"policia.permissao") then
				TriggerClientEvent("syncLock",-1,mNet)
				return
			end

			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
			TriggerClientEvent("progress",source,60000,"roubando")

			SetTimeout(60000,function()
				TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent("syncLock",-1,mNet)
				vRPclient._stopAnim(source,false)

				local policia = vRP.getUsersByPermission("policia.permissao")
				for k,v in pairs(policia) do
					local player = vRP.getUserSource(parseInt(v))
					if player then
						async(function()
							local id = idgens:gen()
							TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
							pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
							SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
						end)
					end
				end
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Masterpick</b> para iniciar o roubo do veículo.")
		end
	end
	TriggerEvent('logs:ToDiscord', discord_webhook5 , "USOU", "```Player "..user_id.." usou(por comando) o item: "..args[1].."```", "https://www.tumarcafacil.com/wp-content/uploads/2017/06/RegistroDeMarca-01-1.png", false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local roupas = {
	
	["coletepmrj"] = {
        [1885233650] = {
            [9] = { 10,0 },
        },
		[-1667301416] = {
			[9] = { 10,0 },
		}
	},
	
	["mergulhopmrj"] = {
        [1885233650] = {
            [1] = { 142,0 },
            [5] = { -1,0 },
            [7] = { -1,0 },
            [3] = { 31,0 },
            [4] = { 94,0 },
            [8] = { 123,0 },
            [6] = { 67,0 },
            [11] = { 243,0 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            ["p0"] = { -1,0 },
            ["p1"] = { 26,0 },
            ["p2"] = { -1,0 },
            ["p6"] = { -1,0 },
            ["p7"] = { -1,0 }
        },
		[-1667301416] = {
			[1] = { 55,0 },
			[2] = { 0,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 97,0 },
			[8] = { 153,0 },
			[6] = { 70,0 },
			[11] = { 251,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["mergulho2"] = {
        [1885233650] = {
            [1] = { 142,0 },
            [5] = { -1,0 },
            [7] = { -1,0 },
            [3] = { 31,0 },
            [4] = { 94,3 },
            [8] = { 123,0 },
            [6] = { 67,0 },
            [11] = { 243,3 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            ["p0"] = { -1,0 },
            ["p1"] = { 26,0 },
            ["p2"] = { -1,0 },
            ["p6"] = { -1,0 },
            ["p7"] = { -1,0 }
        },
		[-1667301416] = {
			[1] = { 55,0 },
			[5] = { -1,0 },
			[2] = { 0,0 },
			[7] = { -1,0 },
			[3] = { 18,3 },
			[4] = { 97,3 },
			[8] = { 153,0 },
			[6] = { 70,0 },
			[11] = { 251,3 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["mergulho3"] = {
        [1885233650] = {
            [1] = { 142,0 },
            [5] = { -1,0 },
            [7] = { -1,0 },
            [3] = { 31,0 },
            [4] = { 94,2 },
            [8] = { 123,0 },
            [6] = { 67,0 },
            [11] = { 243,2 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            ["p0"] = { -1,0 },
            ["p1"] = { 26,0 },
            ["p2"] = { -1,0 },
            ["p6"] = { -1,0 },
            ["p7"] = { -1,0 }
        },
		[-1667301416] = {
			[1] = { 55,0 },
			[5] = { -1,0 },
			[2] = { 0,0 },
			[7] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 97,2 },
			[8] = { 153,0 },
			[6] = { 70,0 },
			[11] = { 251,2 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["mergulho4"] = {
        [1885233650] = {
            [1] = { 142,0 },
            [5] = { -1,0 },
            [7] = { -1,0 },
            [3] = { 31,0 },
            [4] = { 94,9 },
            [8] = { 123,0 },
            [6] = { 67,0 },
            [11] = { 243,9 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            ["p0"] = { -1,0 },
            ["p1"] = { 26,0 },
            ["p2"] = { -1,0 },
            ["p6"] = { -1,0 },
            ["p7"] = { -1,0 }
        },
		[-1667301416] = {
			[1] = { 55,0 },
			[5] = { -1,0 },
			[2] = { 0,0 },
			[7] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 97,9 },
			[8] = { 153,0 },
			[6] = { 70,0 },
			[11] = { 251,9 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["mergulho5"] = {
        [1885233650] = {
            [1] = { 142,0 },
            [5] = { -1,0 },
            [7] = { -1,0 },
            [3] = { 31,0 },
            [4] = { 94,11 },
            [8] = { 123,0 },
            [6] = { 67,0 },
            [11] = { 243,11 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            ["p0"] = { -1,0 },
            ["p1"] = { 26,0 },
            ["p2"] = { -1,0 },
            ["p6"] = { -1,0 },
            ["p7"] = { -1,0 }
        },
		[-1667301416] = {
			[1] = { 55,0 },
			[5] = { -1,0 },
			[2] = { 0,0 },
			[7] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 97,11 },
			[8] = { 153,0 },
			[6] = { 70,0 },
			[11] = { 251,11 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["mergulho"] = {
        [1885233650] = {
            [1] = { 142,0 },
            [5] = { -1,0 },
            [7] = { -1,0 },
            [3] = { 31,0 },
            [4] = { 94,12 },
            [8] = { 123,0 },
            [6] = { 67,0 },
            [11] = { 243,12 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            ["p0"] = { -1,0 },
            ["p1"] = { 26,0 },
            ["p2"] = { -1,0 },
            ["p6"] = { -1,0 },
            ["p7"] = { -1,0 }
        },
		[-1667301416] = {
			[1] = { 55,0 },
			[5] = { -1,0 },
			[2] = { 0,0 },
			[7] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 97,12 },
			[8] = { 153,0 },
			[6] = { 70,0 },
			[11] = { 251,12 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["paciente"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 61,0 },
			[8] = { 15,0 },
			[6] = { 16,0 },
			[11] = { 104,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 28,1 },
			["p1"] = { 7,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 15,3 },
			[8] = { 7,0 },
			[6] = { 5,0 },
			[11] = { 5,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 29,1 },
			["p1"] = { 15,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	}
}


RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
--	if vRP.hasPermission(user_id,"polpar.permissao") then
		if args[1] then
			local custom = roupas[tostring(args[1])]
			if custom then
				local old_custom = vRPclient.getCustomization(source)
				local idle_copy = {}

				idle_copy = vRP.save_idle_custom(source,old_custom)
				idle_copy.modelhash = nil

				for l,w in pairs(custom[old_custom.modelhash]) do
					idle_copy[l] = w
				end
				vRPclient._setCustomization(source,idle_copy)
			end
		else
			vRP.removeCloak(source)
		end
		else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de roupa.")
	end
end)
--- paypal
RegisterCommand('paypal',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "sacar" and parseInt(args[2]) > 0 then
			local descricao = vRP.prompt(source,"Deseja enviar o dinheiro? Digite (Sim/Nao)","")
		if descricao == "" then
			return
		end
			local consulta = vRP.getUData(user_id,"vRP:paypal")
			local resultado = json.decode(consulta) or ""
			if resultado >= parseInt(args[2]) then
				vRP.giveBankMoney(user_id,parseInt(args[2]))
				vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado-args[2])))
				TriggerClientEvent("Notify",source,"sucesso","Efetuou o saque de <b>$"..vRP.format(parseInt(args[2])).." dólares</b> da sua conta paypal.")
				vRP.logs("savedata/paypal.txt","[ID]: "..user_id.." / [SACAR]: "..parseInt(args[2]))
				TriggerEvent('logs:ToDiscord', discord_webhook4 , "PAYPAL", "```ID "..user_id.." \nSacou R$"..args[2].."```", "https://www.tumarcafacil.com/wp-content/uploads/2017/06/RegistroDeMarca-01-1.png", false, false)
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente em sua conta paypal.")
			end	
		elseif args[1] == "trans" and parseInt(args[2]) > 0 and parseInt(args[3]) > 0 then
			local consulta = vRP.getUData(args[2],"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			local banco = vRP.getBankMoney(user_id)
			if banco >= parseInt(args[3]) then
				vRP.setBankMoney(user_id,parseInt(banco-args[3]))
				vRP.setUData(parseInt(args[2]),"vRP:paypal",json.encode(parseInt(resultado+args[3])))
				vRP.logs("savedata/paypal.txt","[ID]: "..user_id.." / [NID]: "..parseInt(args[2]).." / [TRANSFERENCIA]: "..parseInt(args[3]))
				TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[3])).." dólares</b> ao passaporte <b>"..vRP.format(parseInt(args[2])).."</b>.")
				SendWebhookMessage(webhooklinkpaypal,  "``` [" ..user_id.."] Enviou para ["..vRP.format(parseInt(args[2])).."] R$:"..vRP.format(parseInt(args[3])).. "```")

				local player = vRP.getUserSource(parseInt(args[2]))
				if player == nil then
					return
				else
					local identity = vRP.getUserIdentity(user_id)
					TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>$"..vRP.format(parseInt(args[3])).." dólares</b> para sua conta do paypal.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		end
	end
end)


RegisterCommand('jornal',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"event.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        vRPclient.setDiv(-1,"jornal"," @keyframes blinking {    0%{ background-color: #ff3d50; border: 2px solid #871924; opacity: 0.8; } 25%{ background-color: #d22d99; border: 2px solid #901f69; opacity: 0.8; } 50%{ background-color: #55d66b; border: 2px solid #126620; opacity: 0.8; } 75%{ background-color: #22e5e0; border: 2px solid #15928f; opacity: 0.8; } 100%{ background-color: #222291; border: 2px solid #6565f2; opacity: 0.8; }  } .div_festinha { font-size: 11px; font-family: arial; color: rgba(255, 255, 255,1); padding: 20px; bottom: 10%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; animation: blinking 1s infinite; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Festeiro(a): "..identity.name.." "..identity.firstname)
        SetTimeout(70000,function()
            vRPclient.removeDiv(-1,"jornal")
        end)
    end
end)



--[[
---------- PERDER ITEM

RegisterNetEvent('perdeitem:nadando')
AddEventHandler('perdeitem:nadando', function(qtddinheiro)
    local user_id = vRP.getUserId(source)
    vRP.clearInventory(user_id)
	vRP.varyExp(user_id, "physical", "strength", 520)
end)
]]

-- RASTREADOR DE VEICULOS , CARROS
AddEventHandler('chatMessage', function(s, n, m)
	local message = string.lower(m)
	local user_id = vRP.getUserId(s)
	local price = 5000
	if message == "/rastrear" then
		CancelEvent()
		--------------
		if vRP.tryGetInventoryItem(user_id,'rastreador',1) then 
			TriggerClientEvent('rastrear', s)
		else 
			vRPclient.notify(user_id, "Você não possui um rastreador")
		end
	end
end)


function vRP.logInfoToFile(file,info)
	file = io.open(file, "a")
	if file then
	  file:write(os.date("%c").." => "..info.."\n")
	end
	file:close()
  end
  
  -- ORGANIZAÇÕES
  
  -- MILICIA  CONTRATAR
  RegisterCommand('contratarmiliciagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.milicia") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				  vRP.addUserGroup(parseInt(args[1]),"[Milicia] - Gerente")
				  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('contratarmiliciamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.milicia") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro?, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[Milicia] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro.")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- MILICIA DEMITIR
  RegisterCommand('demitirmiliciagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.milicia") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[Milicia] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitirmiliciamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.milicia") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[Milicia] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  -- SAMU CONTRATAR
  RegisterCommand('contratarsamusocorrista',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samu") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Socorrista da Samu, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				  vRP.addUserGroup(parseInt(args[1]),"[SOCORRISTA] - SAMU")
				  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Socorrista da Samu")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('contratarsamutecefm',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samu") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Tecnico de Enfermagem da Samu, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				  vRP.addUserGroup(parseInt(args[1]),"[TÉCNICO DE ENFERMAGEM] - SAMU")
				  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Tecnico de Enfermagem da Samu")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('contratarsamuefm',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samu") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Enfermeiro da Samu, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				  vRP.addUserGroup(parseInt(args[1]),"[ENFERMEIRO] - SAMU")
				  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Enfermeiro da Samu")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('contratarsamumed',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samu") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Medico da Samu, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				  vRP.addUserGroup(parseInt(args[1]),"[MÉDICO(A)] - SAMU")
				  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Medico da Samu")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('contratarsamucoord',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samucoord") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Coordenador da Samu, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
				  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
				  vRP.addUserGroup(parseInt(args[1]),"[COORDENADOR] - SAMU")
				  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Coordenador da Samu")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  -- DEMITIR SAMU
  RegisterCommand('demitirsamusocorrista',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samu") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[SOCORRISTA] - SAMU")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('demitirsamutecefm',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samu") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[TÉCNICO DE ENFERMAGEM] - SAMU")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('demitirsamuefm',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samu") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[ENFERMEIRO] - SAMU")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('demitirsamumed',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samu") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[MÉDICO(A)] - SAMU")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  RegisterCommand('demitirsamucoord',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.samucoord") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[COORDENADOR] - SAMU")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end	
  end)
  
  -------------------------------------------------
  
  -- MAFIA  CONTRATAR
  RegisterCommand('contratarmafiagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.mafia") then
		  if args[1] then
		  TriggerClientEvent("Notify",source,"sucesso","Passaporte: "..parseInt(args[1]).." Como Gerente,")
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[MAFIA] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou o Passaporte: "..parseInt(args[1]).." como Gerente da Mafia!")
			  TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50},"Você adicionou o Passaporte:  "..parseInt(args[1]).." como Gerente da Mafia!")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contratarmafiamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.mafia") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[MAFIA] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- MAFIA DEMITIR
  RegisterCommand('demitirmafiagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.mafia") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[MAFIA] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitirmafiamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.mafia") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[MAFIA] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  ---------------------------------------
  
  -- YAKUZA  CONTRATAR
  RegisterCommand('contrataryakuzagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"yakuzaliderentrada.permissao") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[YAKUZA] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contrataryakuzamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"yakuzaliderentrada.permissao") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[YAKUZA] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro.")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- YAKUZA DEMITIR
  RegisterCommand('demitiryakuzagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"yakuzaliderentrada.permissao") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[YAKUZA] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitiryakuzamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"yakuzaliderentrada.permissao") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[YAKUZA] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- MOTOCLUB  CONTRATAR
  RegisterCommand('contratarmcgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.mc") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[MOTOCLUB] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contratarmcmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.mc") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[MOTOCLUB] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- MOTOCLUB DEMITIR
  RegisterCommand('demitirmcgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.mc") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[MOTOCLUB] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitirmcmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.mc") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[MOTOCLUB] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  
  
  
  -- DK  CONTRATAR
  RegisterCommand('contratardkgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.dk") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[D.K] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contratardkmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.dk") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[D.K] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- DK DEMITIR
  RegisterCommand('demitirdkgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.dk") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[D.K] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitirdkmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.dk") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[D.K] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  
  -- BORDEL  CONTRATAR
  RegisterCommand('contratarvanillagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.bordel") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[Vanilla] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contratarvanillamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.bordel") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[Vanilla] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- BORDEL DEMITIR
  RegisterCommand('demitirvanillagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.bordel") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[Vanilla] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitirvanillamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.bordel") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[Vanilla] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -------- FACÇÕES
  
  -- COMANDO VERMELHO  CONTRATAR
  RegisterCommand('contratarcvgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.cv") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[C.V] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contratarcvmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.cv") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[C.V] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- COMANDO VERMELHO DEMITIR
  RegisterCommand('demitircvgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.cv") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[C.V] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitircvmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.cv") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[C.V] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- PCC  CONTRATAR
  RegisterCommand('contratarpccgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.pcc") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[P.C.C] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contratarpccmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.pcc") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[P.C.C] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- PCC DEMITIR
  RegisterCommand('demitirpccgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.pcc") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[P.C.C] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitirpccmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.pcc") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[P.C.C] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  
  
  
  -- TCP  CONTRATAR
  RegisterCommand('contratartcpgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.tcp") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[T.C.P] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contratartcpmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.tcp") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro, Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[T.C.P] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- TCP DEMITIR
  RegisterCommand('demitirtcpgerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.tcp") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[T.C.P] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitirtcpmembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.tcp") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[T.C.P] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- ADA  CONTRATAR
  RegisterCommand('contrataradagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.ada") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente Da ADA? Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[A.D.A] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contrataradamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.ada") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro Da ADA? Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[A.D.A] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um membro como Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- ADA DEMITIR
  RegisterCommand('demitiradagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.ada") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[A.D.A] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitiradamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.ada") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[A.D.A] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  
  
  
  
  
  -- TCA  CONTRATAR
  RegisterCommand('contratartcagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.tca") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como Gerente Da TCA? Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[T.C.A] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('contratartcamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.tca") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como membro Da TCA? Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"[T.C.A] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um Gerente")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  -- TCA DEMITIR
  RegisterCommand('demitirtcagerente',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.tca") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[T.C.A] - Gerente")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  RegisterCommand('demitirtcamembro',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"contratar.tca") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"[T.C.A] - Membro")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu um cidadão")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  
  
  
  -- BENNYS
  RegisterCommand('contratarbennys',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"bennystoogledono.permissao") then
		  if args[1] then
		  local descricao = vRP.prompt(source,"Quer contratar o Passaporte: "..parseInt(args[1]).." Como ? Digite (Sim/Nao)","")
			  if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." deu grupo "..rawCommand.." .")
			  vRP.addUserGroup(parseInt(args[1]),"Bennys")
			  TriggerClientEvent("Notify",source,"sucesso","Você adicionou um funcionario na bennys")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)
  
  
  -- BENNYS DEMITIR
  RegisterCommand('demitirbennys',function(source,args,rawCommand)
	  local user_id = vRP.getUserId(source)
	  if vRP.hasPermission(user_id,"bennystoogledono.permissao") then
		  if args[1] then
		  vRP.logInfoToFile("logRJ/grupocontrato.txt",user_id.." removeu "..rawCommand.." .")
			  vRP.removeUserGroup(parseInt(args[1]),"Bennys")
			  TriggerClientEvent("Notify",source,"sucesso","Você demitiu ["..rawCommand"]")
		  end
	  else 
	  TriggerClientEvent("Notify",source,"importante","Você não tem permissão.")
	  end
	  
  end)