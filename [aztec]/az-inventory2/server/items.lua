--[[ az-inventory:items ]]--

vAZ.items = module('cfg/items').items

async(function()
    for item,details in pairs(vAZ.items) do
        vRP.defInventoryItem(item, details.label, details.description, details.increase, details.weight, details.prop)
    end
end)

local webhooklinklockpick = "https://discordapp.com/api/webhooks/737759163408449596/A7TITWZArcoK7n5O7_MOvCuKXWGiXMb9dvBANJh1iNGxi05OuM7850Yq2cKhLwhwwo8B"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

vRP._prepare('vAZ/getVehicleByModel', 'SELECT * FROM vrp_vehicles WHERE model = @model')



vAZ.handlers = {
    ['colete'] = function(source, user_id, item, amount, cb)
        if vRPclient.getArmour(source) > 0 then
            TriggerClientEvent('Notify', source, 'aviso', 'Você já está usando colete.')
        else
            if vRP.tryGetInventoryItem(user_id, item, 1, false) then
                vRPclient._playAnim(source, true, {{"switch@franklin@getting_ready", "002334_02_fras_v2_11_getting_dressed_exit"}}, false)
                vRPclient.setArmour(source, 100)
                cb(true)
            end
        end
        cb(false)
    end,
    ['mochila'] = function(source, user_id, item, amount, cb)        
        local bag = vRP.getExp(user_id, "physical", "strength")
        if bag < 520 then
            if vRP.tryGetInventoryItem(user_id, item, 1, false) then
                vRP.varyExp(user_id, "physical", "strength", 520)
                cb(true)
			end
		elseif bag >= 520 and bag < 1320 then
			if vRP.tryGetInventoryItem(user_id, item, 1, false) then
                vRP.varyExp(user_id, "physical", "strength", 800)
                cb(true)
			end
		elseif bag >= 1320 and bag < 3300 then
			if vRP.tryGetInventoryItem(user_id, item, 1, false) then
                vRP.varyExp(user_id, "physical", "strength", 1980)
                cb(true)
			end
        end
        cb(false)
    end,
    ['rojao'] = function(source, user_id, item, amount, cb)
        if vRP.tryGetInventoryItem(user_id, item, 1, false) then
          local x,y,z = vRPclient.getPosition(source)
          TriggerClientEvent("progress", source, 4800, "preparando rojão")          
          TriggerClientEvent('az-inventory:firework:place_firework', source)
          cb(true)
        end
        cb(false)
    end,
    ['maconha'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "maconha", 1, false) then
            TriggerClientEvent("Notify", source, "aviso", "Fumando Maconha.")
            vRPclient._playAnim(source, true, {task="WORLD_HUMAN_SMOKING_POT"}, false)
            SetTimeout(10000,function()
                vRPclient._stopAnim(source, true)
                vRPclient._stopAnim(source, false) 
                vRPclient.playMovement(source, "MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
                vRPclient.playScreenEffect(source, "DMT_flight", 220) 
            end)
            SetTimeout(220000,function()
                vRPclient.resetMovement(source, false) 
            end)
            cb(true)
        end
        cb(false)
    end,
    ['cocaina'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "cocaina", 1, false) then
            TriggerClientEvent("Notify",source,"aviso","Cheirando Cocaina.")
            vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},false)
            SetTimeout(10000, function()
                vRPclient.playMovement(source,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
                vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 220) 
            end)
            SetTimeout(220000, function()
                vRPclient.resetMovement(source, false)
            end)
            cb(true)
        end
        cb(false)
    end,
	['cocainapesada'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "cocainapesada", 1, false) then
            TriggerClientEvent("Notify",source,"aviso","Cheirando Cocaina.")
            vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},false)
            SetTimeout(10000, function()
                vRPclient.playMovement(source,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
                vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 920) 
            end)
            SetTimeout(920000, function()
                vRPclient.resetMovement(source, false)
            end)
            cb(true)
        end
        cb(false)
    end,
    ['metanfetamina'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "metanfetamina", 1, false) then
            TriggerClientEvent("Notify", source, "aviso", "Injetando Metanfetamina.")
            SetTimeout(10000, function()
                vRPclient.playMovement(source, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true, true, false, false)
                vRPclient.playScreenEffect(source, "DMT_flight", 120) 
            end)
            SetTimeout(120000, function()
                vRPclient.resetMovement(source, false)
            end)
            cb(true)
        end
        cb(false)
    end,
	['lsd'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "lsd", 1, false) then
            TriggerClientEvent("Notify", source, "aviso", "Usando LSD PRA FICAR DOIDAO.")
            SetTimeout(10000, function()
                vRPclient.playMovement(source, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true, true, false, false)
                vRPclient.playScreenEffect(source, "DMT_flight", 120) 
            end)
            SetTimeout(120000, function()
                vRPclient.resetMovement(source, false)
            end)
            cb(true)
        end
        cb(false)
    end,
	['tequila'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "tequila", 1, false) then
            TriggerClientEvent("Notify", source, "aviso", "Bebendo Tequila.")
            SetTimeout(10000, function()
                vRPclient.playMovement(source, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true, true, false, false)
                vRPclient.playScreenEffect(source, "DMT_flight", 120) 
            end)
            SetTimeout(120000, function()
                vRPclient.resetMovement(source, false)
            end)
            cb(true)
        end
        cb(false)
    end,
	
    ['energetico'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "energetico", 1, false) then
            TriggerClientEvent('cancelando', source, true)
            vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", vAZ.items[item].prop, 49, 28422)
            TriggerClientEvent("progress", source, 10000, "bebendo")
            SetTimeout(10000, function()
                TriggerClientEvent('energeticos', source, true)
                TriggerClientEvent('cancelando', source, false)
                vRPclient._DeletarObjeto(source)
                TriggerClientEvent("Notify", source, "sucesso", "Energético utilizado com sucesso.")
            end)
            SetTimeout(60000, function()
                TriggerClientEvent('energeticos', source, false)
                TriggerClientEvent("Notify", source, "aviso", "O efeito do energético passou e o coração voltou a bater normalmente.")
            end)
            cb(true)
        end
        cb(false)
    end,
    ['capuz'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "capuz", 1, false) then            
            local nplayer = vRPclient.getNearestPlayer(source, 2)
            if nplayer then
                vRPclient.setCapuz(nplayer)
                vRP.closeMenu(nplayer)
                TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.")
                cb(true)
            else
                TriggerClientEvent("Notify",source,"negado","Vitima não encotrada.")
            end
        end
        cb(false)
    end,
    ['lockpick'] = function(source, user_id, item, amount, cb)
        local vehicle = vRPclient.getNearestVehicle(source, 5)
		if vehicle then
            local plate = vRPclient.getPlateVehicle(source, vehicle)   
            local vnet = vRPclient.getNetVehicle(source, vehicle)
            if vRP.hasPermission(user_id, "policia.permissao") then
                TriggerClientEvent("syncLock", -1, vnet)
                TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
				return
            end
            if vRP.tryGetInventoryItem(user_id, item, 1, false) then            
                TriggerClientEvent('cancelando', source, true)
                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                TriggerClientEvent("progress", source, 30000, "roubando")
                SetTimeout(30000, function()
                    TriggerClientEvent('cancelando', source, false)
                    vRPclient._stopAnim(source, false)
                    local owner = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})
					local x,y,z = vRPclient.getPosition(source)
                    if #owner > 0 then 
                        if math.random(100) >= 1 then
                            TriggerClientEvent("syncLock", -1, vnet)
                            TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
							SendWebhookMessage(webhooklinklockpick,  "``` LockPick [" ..user_id.."]  Placa; " ..plate.. " local "..x..","..y..","..z..  "```")
							TriggerClientEvent("Notify", source, "sucesso", "Corre noia, você roubou um carro.")
                        else
                            TriggerClientEvent("Notify", source, "negado", "Noia, você não conseguiu roubar esse veiculo, CORRE!.")
                            for k,v in pairs(vRP.getUsersByPermission("policia.permissao")) do
                                local player = vRP.getUserSource(parseInt(v))
                                if player then
                                    async(function()
                                        local id = vAZ.id:gen()
                                        TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.." ")
                                        pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
                                        SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) vAZ.id:free(id) end)
										
                                    end)
                                end
                            end
                        end
                    else
                        TriggerClientEvent("syncLock", -1, vnet)
                        TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)                   
                    end
                end)
                cb(true)
            end
        end
        cb(false)
    end,
    --[[['masterpick'] = function(source, user_id, item, amount, cb)
        local vehicle = vRPclient.getNearestVehicle(source, 5)
		if vehicle then
            local plate = vRPclient.getPlateVehicle(source, vehicle)   
            local vnet = vRPclient.getNetVehicle(source, vehicle)
            if vRP.hasPermission(user_id, "policia.permissao") then
                TriggerClientEvent("syncLock", -1, vnet)
                TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
				return
            end
            if vRP.tryGetInventoryItem(user_id, item, 1, false) then            
                TriggerClientEvent('cancelando', source, true)
                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                TriggerClientEvent("progress", source, 60000, "roubando")
                SetTimeout(60000, function()
                    TriggerClientEvent('cancelando', source, false)
                    vRPclient._stopAnim(source, false)
                    local owner = vRP.query("vAZ/GetVehiclesByPlate", {plate = plate})
                    if #owner > 0 then
                        TriggerClientEvent("syncLock", -1, vnet)
                        TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
                        for k,v in pairs(vRP.getUsersByPermission("policia.permissao")) do
                            local player = vRP.getUserSource(parseInt(v))
                            if player then
                                async(function()
                                    local id = vAZ.id:gen()
                                    TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
                                    pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
                                    SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) vAZ.id:free(id) end)
                                end)
                            end
                        end
                    else
                        TriggerClientEvent("syncLock", -1, vnet)
                        TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
                    end
                end)
                cb(true)
            end
        end
        cb(false)
    end,]]
    ['repairkit'] = function(source, user_id, item, amount, cb)
        if not vRPclient.isInVehicle(source) then
            local vehicle = vRPclient.getNearestVehicle(source, 7)		
            if vehicle then
                if vRP.tryGetInventoryItem(user_id, item, 1, false) then
                    vRPclient._playAnim(source, false, {{'mini@repair', 'fixing_a_player'}}, true)
                    TriggerClientEvent("progress", source, 30000, "reparando")
                    SetTimeout(30000, function()
                        TriggerClientEvent('cancelando', source, false)
                        TriggerClientEvent('reparar', source, vehicle)
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent('Notify', source, 'sucesso', 'Veículo reparado com sucesso.')            
                    end)
                    cb(true)
                end
            end
        else
            TriggerClientEvent('Notify', source, 'aviso', 'Precisa estar fora do veículo para efetuar os reparos.')
        end
        cb(false)
    end,
    ['militec'] = function(source, user_id, item, amount, cb)
        if not vRPclient.isInVehicle(source) then
            local vehicle = vRPclient.getNearestVehicle(source, 7)
            if vehicle then
                if vRP.tryGetInventoryItem(user_id, item, 1, false) then
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._playAnim(source, false, {{"mini@repair", "fixing_a_player"}}, true)
                    TriggerClientEvent("progress", source, 30000, "reparando")
                    SetTimeout(30000,function()
                        TriggerClientEvent('cancelando', source, false)
                        TriggerClientEvent('repararmotor', source, vehicle)
                        vRPclient._stopAnim(source, false)
                    end)
                    cb(true)
                end
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Precisa fora do veículo para efetuar os reparos.")      
        end
        cb(false)
    end
}