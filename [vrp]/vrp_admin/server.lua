local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


function vRP.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end



	
local webhooklinkchat = "https://discordapp.com/api/webhooks/718956300964200478/AqO_hpEwFTrc1d3Kt6pHBNqWsIDWAzRiIExvxAwub53S-GwoDbDBQ0K9-IM_oj_ZGcPu"
local webhooklinkadm = "https://discordapp.com/api/webhooks/722647370520854608/-WUXCvL1kKQct-5Z2N_S4XIE-AF0_LwYUacjz5d4swH-x8Z8KHapEftSwXXtgV5-k44x"
local webhooklinkban = "https://discordapp.com/api/webhooks/728053519860367412/47ka_6FL9-lmrSvM27oOccNG8n8MIPw3nLPvcbNdCKpijVEsA7-Drrxbe5ozovjwyILV"
local webhooklinktpadm = "https://discordapp.com/api/webhooks/740417634402828400/GS8Wxr0Jwh5hL2tnocWRrkV_wRIxq62q7TlZP1itx0f7LxCmfaf8d6fUUHcR_eXXetpq"
local webhooklinkreset = "https://discord.com/api/webhooks/778026967500324874/veAyoRTMJzCZf7z1Jea8GgblLdyrd8w8FI1EEK_wmH1tY84brBGu6JCPtoRzub2o2Wyl"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterCommand('reset',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"reset.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                local id = vRP.getUserId(nplayer)
                if id then
                    vRP.kick(id,"Transplante Iniciado.")
                    vRP.setUData(id,"vRP:spawnController",json.encode(1))
                    vRP.setUData(id,"currentCharacterMode",json.encode(1))
                    vRP.setUData(id,"vRP:tattoos",json.encode(1))
					SendWebhookMessage(webhooklinkreset,  "```" ..user_id.." usou RESET em " ..parseInt(args[1]).. "```")
					SendWebhookMessage(webhooklinkreset,  "```" ..user_id.." usou RESET em " ..rawCommand.. "```")
                end
            end
        end
    end
end)

RegisterCommand('Congelar', function(source, args,rawCommand) ----muda o comando aqui se quiser
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent('Congelar', source)
            end
        end    
    end
end)

--[ /BVIDA ]-----------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bvida',function(source,rawCommand)
        local user_id = vRP.getUserId(source)
            vRPclient._setCustomization(source,vRPclient.getCustomization(source))
            vRP.removeCloak(source)
    end)

RegisterCommand('dados',function(source,args,rawCommand)
    local ip = GetPlayerEndpoint(source)
    local steamhex = GetPlayerIdentifier(source)
    local ping = GetPlayerPing(source)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"owner.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                local ip2 = GetPlayerEndpoint(nplayer)
                local steamhex2 = GetPlayerIdentifier(nplayer)
                local ping2 = GetPlayerPing(nplayer)
               TriggerClientEvent("Notify",source,"aviso","IP do player:"  ..ip2.."")
               TriggerClientEvent("Notify",source,"aviso","Player Hex:" ..steamhex2.."")
               TriggerClientEvent("Notify",source,"aviso","Ping do player:" ..ping2.."")
            end
        else
            TriggerClientEvent("Notify",source,"aviso","Seu IP:"  ..ip.."")
            TriggerClientEvent("Notify",source,"aviso","Sua hex:"  ..steamhex.."")
            TriggerClientEvent("Notify",source,"aviso","Seu ping:"  ..ping.."")
        end
    end
end)

RegisterCommand('fogo', function(source)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        TriggerClientEvent('FOGO', source)
    end
end)

RegisterCommand('trocasexo',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu",nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)

------
-----------------------------------------------------------------------------------------------------------------------------------
-- RESET PLAYER    / >>> IREI TESTAR ANTES
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('resetplayer',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if user_id then
            if args[1] then
                local identity = vRP.getUserIdentity(parseInt(args[1]))
                if vRP.request(source,"Deseja resetar o Passaporte: <b>"..args[1].." "..identity.name.." "..identity.firstname.."</b> ?",30) then
                    local id = vRP.getUserSource(parseInt(args[1]))
                    if id then  
                        vRP.kick(id,"Você foi expulso da cidade.")
                    end
                    local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(args[1]) })
                    if parseInt(#myHomes) >= 1 then
                        for k,v in pairs(myHomes) do
                            local ownerHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(args[1]), home = tostring(v.home) })
                            if ownerHomes[1] then
                                for k,i in pairs(ownerHomes) do
                                    vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(i.home) })
                                    vRP.execute("creative/rem_srv_data",{ dkey = "outfit:"..tostring(i.home) })
                                    vRP.execute("homes/rem_allpermissions",{ home = tostring(i.home) })
                                end
                                vRP.execute("homes/rem_permissions",{ home = tostring(v.home), user_id = parseInt(args[1]) })
                                vRP.execute("vRP/rem_allhouses",{ user_id = parseInt(args[1]) })
                            end
                        end
                    end
                    local myCars = vRP.query("vRP/get_allvehicles",{ user_id = parseInt(args[1]) })
                    if parseInt(#myCars) >= 1 then
                        for k,v in pairs(myCars) do
                            vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(args[1]).."veh_"..tostring(v.vehicle) })
                            vRP.execute("creative/rem_srv_data",{ dkey = "custom:u"..parseInt(args[1]).."veh_"..tostring(v.vehicle) })
                            vRP.execute("vRP/rem_allcars",{ user_id = parseInt(args[1]) })
                        end
                    end
                    vRP.setUData(parseInt(args[1]),"vRP:datatable",json.encode(vRP.getUserDataTable(parseInt(args[1]))))
                    vRP.setUData(parseInt(args[1]),"vRP:multas",parseInt(0))
                    vRP.setUData(parseInt(args[1]),"vRP:paypal",parseInt(0))
                    vRP.setUData(parseInt(args[1]),"vRP:prisao",parseInt(-1))
                    vRP.setUData(parseInt(args[1]),"vRP:spawnController",parseInt(0))
                    vRP.setUData(parseInt(args[1]),"vRP:tattoos",json.encode(vRP.getUserDataTable(parseInt(args[1]))))
                    vRP.execute("vRP/set_money",{ user_id = parseInt(args[1]), wallet = 1000, bank = 2000 })
                    TriggerClientEvent("Notify",source,"sucesso","Você resetou o Passaporte: <b>"..parseInt(args[1]).." "..identity.name.." "..identity.firstname.."</b>.")
                end          
            end
        end
    end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLIPS ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
        blips[source] = { source }
       TriggerClientEvent("blips:updateBlips",-1,blips)
        if vRP.hasPermission(user_id,"blips.permissao") then
            TriggerClientEvent("blips:adminStart",source)
        end
     end
 end)

AddEventHandler("playerDropped",function()
	if blips[source] then
		blips[source] = nil
		TriggerClientEvent("blips:updateBlips",-1,blips)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- APAGAO -- COLOCAR NO SERVER.LUA DO VRP_ADMIN
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('apagao',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"admin.permissao") and args[1] ~= nil then
            local cond = tonumber(args[1])
            --TriggerEvent("cloud:setApagao",cond)
            TriggerClientEvent("cloud:setApagao",-1,cond)                    
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then --vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"diretor.permissao") or vRP.hasPermission(user_id,"playerzin.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			local plate = vRPclient.getPlateVehicle(source, vehicle) 
			if plate ~= nil then
				TriggerEvent('az-inventory:deleteTempTrunk', plate)
			end
			TriggerClientEvent('deletarveiculo',source,vehicle)
			TriggerEvent('az-garages:deleteVehicle',source,vehicle)
			SendWebhookMessage(webhooklinkchat,  "```" ..user_id.." Usou o comando " ..rawCommand.. "```")
        end
    end
end)
RegisterNetEvent('deletarveiculo')
AddEventHandler('deletarveiculo',function(vehicle)
    TriggerServerEvent("vrp_garages:admDelete",VehToNet(vehicle))
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tiraralgema',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("admcuff",source)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- APAGAO
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('apagao',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"admin.permissao") and args[1] ~= nil then
            local cond = tonumber(args[1])
            --TriggerEvent("cloud:setApagao",cond)
            TriggerClientEvent("cloud:setApagao",-1,cond)                    
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK ALL TERREMOTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('terremoto',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                vRP.kick(id,"Você foi vitima do terremoto.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players..", "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,160,0},quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,160,0},players)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPARBOLSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparbolsa',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao")  then
		local tuser_id = tonumber(args[1])
		local tplayer = vRP.getUserSource(tonumber(tuser_id))
		local tplayerID = vRP.getUserId (tonumber(tplayer))
			if tplayerID ~= nil then
			local identity = vRP.getUserIdentity(user_id)
			vRP.clearInventory(user_id)
				TriggerClientEvent("Notify",source,"sucesso","Limpou inventario do <id>"..args[1].."</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","O usuário não foi encontrado ou está offline.")
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('idp',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		TriggerClientEvent("Notify",source,"importante","Jogador próximo: <b>ID:"..nuser_id.."</b>.")
	else
		TriggerClientEvent('chatMessage', source, "ERROR", {50, 205, 50},"Nenhum Jogador Próximo")
		TriggerClientEvent("Notify",source,"aviso","<b>Nenhum Jogador Próximo</b>")
	end
end)
-- KILL
RegisterCommand('kill',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Administrador.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setHealth(nplayer,50)
			end
		else
			vRPclient.setHealth(source,50)
			vRPclient.setArmour(source,0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteveh")
AddEventHandler("trydeleteveh",function(index)
	TriggerClientEvent("syncdeleteveh",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped",function(index)
	TriggerClientEvent("syncdeleteped",-1,index)
end)
-- LIMPAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpainv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"god.permissao") then
        vRP.clearInventory(user_id)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVER TODOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revivetodos', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            vRPclient.setHealth(rsource, 230)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUXAR TODOS
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('tpall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            if rsource ~= source then
                vRPclient.teleport(rsource,x,y,z)
            end
        end
    end
end)]]--
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
	TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"fix.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('reparar',source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent("syncarea",-1,x,y,z)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"god.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,230)
			end
		else
			vRPclient.killGod(source)
			vRPclient.setHealth(source,230)
			vRPclient.setArmour(source,100)
		end
		SendWebhookMessage(webhooklinkadm,  "```" ..user_id.." Usou GOD " ..rawCommand.. "```")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"god.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,200)
			end
		else
			vRPclient.killGod(source)
			vRPclient.setHealth(source,200)
		end
		SendWebhookMessage(webhooklinkadm,  "```" ..user_id.." Usou GOD " ..rawCommand.. "```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS ON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('players',function(source,args,rawCommand)
    local onlinePlayers = GetNumPlayerIndices()
    TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50},"Jogadores online: "..onlinePlayers)
end)  
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS ON2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jogadores',function(source,args,rawCommand)
    local onlinePlayers = GetNumPlayerIndices()
    TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50},"Jogadores online: "..onlinePlayers)
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEU ID
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('meuid',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    TriggerClientEvent('chatMessage',source,"Seu ID É:",{255,70,50}," "..user_id)
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- Dinheiro
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dinheiro',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local cash = vRP.getMoney(user_id)
	local banco = vRP.getBankMoney(user_id)
    TriggerClientEvent('chatMessage',source,"Seu Saldo Na Mão É:",{82,195,65}," "..cash)
	TriggerClientEvent('chatMessage',source,"Seu Saldo No Banco É:",{82,195,65}," "..banco)
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- Emprego
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('emprego',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local cargo = vRP.getUserGroupByType(user_id,"cargo")
	local cargos = vRP.getUserGroupByType(user_id,"cargos")
	if cargo == nil or cargo == "" then
	if cargos == nil or cargos == "" then
	cargo  = TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50}," Você Não Possui um Emprego Primario!")
	cargos  = TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50}," Você Não Possui um Emprego Secundario!")
	end
end
	if cargo == nil or cargo == vRP.getUserGroupByType(user_id,"cargo") then
	if cargos == nil or cargos == vRP.getUserGroupByType(user_id,"cargos") then
    TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50}," Seu Emprego Primario é:"..cargo)
	if cargos == nil or cargos == "" then
	TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50}," Seu Emprego Secundario é:"..cargos)
	TriggerClientEvent('chatMessage',source,"OBS:",{19,161,28}," Caso você não tenha um emprego secundario, poderá aparecer apenas a mensagem sem  ao menos detalhar seu emprego secundario.")
	end
	end
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vip',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local vip = vRP.getUserGroupByType(user_id,"vip")
	if vip == nil or vip == "" then
	vip  = TriggerClientEvent('chatMessage',source,"ALERTA:",{255,70,50}," Você Não Possui Nenhum VIP Ativo!")
    end
	if vip == nil or vip == vRP.getUserGroupByType(user_id,"vip") then
    TriggerClientEvent('chatMessage',source,"Seu VIP É:",{255,70,50}," " ..vip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('vehash',source,vehicle)
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('vehtuning',source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"wl.permissao") then
	vRP.logInfoToFile("logRJ/wl.txt",user_id.." setou na wl "..rawCommand.." .")
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),true)
		end
	end
end)

--------- comando mandar pro aeroporto
RegisterCommand('aeroporto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,5)

	if vRP.hasPermission(user_id,"wl.permissao") then
		if vRPclient.isInComa(nplayer,source) then 
			TriggerClientEvent("Notify",source,"sucesso"," Você enviou o player para o aeroporto ")
			vRPclient.teleport(nplayer,-1037.431640625,-2737.6997070313,13.786103248596)
			vRPclient.killGod(nplayer)
			vRPclient.setHealth(nplayer,230)
			vRP.giveInventoryItem(user_id,"wbody|"..k,1)
			vRP.giveInventoryItem(nplayer,"wammo|"..k,v.ammo)
			vRP.setMoney(nplayer, 0)
			vRP.clearInventory(nplayer)
		else
			TriggerClientEvent("Notify",source,"negado","O cidadao nao esta em coma.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"wl.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('expulsar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"kick.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi expulso da cidade.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('banir',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ban.permissao") then
        if args[1] then
            local id = vRP.getUserSource(parseInt(args[1]))
            vRP.setBanned(parseInt(args[1]),true)
            vRP.kick(id,"Você foi expulso da cidade.")
			SendWebhookMessage(webhooklinkban,  "```" ..user_id.." BANIU " ..rawCommand.. "```")
            vRP.setWhitelisted(parseInt(args[1]),false)
			
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('desban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"unban.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"money.permissao") then
	vRP.logInfoToFile("logRJ/dinheirospawn.txt",user_id.." spawnou "..rawCommand.." .")
	SendWebhookMessage(webhooklinkadm,  "``` MONEY " ..user_id.." SPAWNOU " ..parseInt(args[1]).. "```")
		if args[1] then
			vRP.giveMoney(user_id,parseInt(args[1]))
		end
	end
end)

-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('removemoney',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"money.permissao") then
	vRP.logInfoToFile("logRJ/dinheirospawn.txt",user_id.." spawnou "..rawCommand.." .")
	SendWebhookMessage(webhooklinkadm,  "``` MONEY " ..user_id.." SPAWNOU " ..parseInt(args[1]).. "```")
		if args[1] then
			vRP.tryPayment(user_id,parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"noclip.permissao") then
		vRPclient.toggleNoclip(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:",x..","..y..","..z)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('group',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local group = vRP.prompt(source, "Nome do Grupo:", "")
			if group then
				vRP.addUserGroup(parseInt(args[1]), group)
				TriggerClientEvent("Notify",source,"sucesso","Você setou "..args[1].." no grupo " ..group.. " ")
				vRP.logInfoToFile("logRJ/grupo.txt", user_id.." deu "..rawCommand.. " " ..group.. ".")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rgroup',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
		local group = vRP.prompt(source, "Nome do Grupo:", "")
			if group then
				vRP.removeUserGroup(parseInt(args[1]), group)
				TriggerClientEvent("Notify",source,"sucesso","Você removeu "..args[1].." no grupo " ..group.. " ")
				vRP.logInfoToFile("logRJ/grupo.txt", user_id.." removeu "..rawCommand.. " " ..group.. ".")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
				SendWebhookMessage(webhooklinktpadm,  "```" ..user_id.." puxou " ..rawCommand.. "```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
				SendWebhookMessage(webhooklinktpadm,  "```" ..user_id.." teleportou para " ..rawCommand.. "```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	xb,yb,zb = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		TriggerClientEvent('tptoway',source)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPB voltar ao ponto inicial
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpb',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        vRPclient.teleport(source,xb,yb,zb)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"spawncar.permissao") then
	vRP.logInfoToFile("logRJ/spawncarro.txt",user_id.." spawnou "..rawCommand.." .")
		if args[1] then
			TriggerClientEvent('spawnarveiculo',source,args[1])
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- blip
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('blip',function(source,args,rawCommand)
	local user_id = vRP.getUserId(player)
	if vRP.hasPermission(user_id,"money.permissao") then
  TriggerClientEvent("showBlips", player)
  end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('delnpcs',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"msg.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 10%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: Administrador")
		SetTimeout(60000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)