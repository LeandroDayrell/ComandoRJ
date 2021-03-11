--[[ az-inventory:items ]]--

vAZ.items = module('cfg/items').items

async(function()
    for item,details in pairs(vAZ.items) do
        vRP.defInventoryItem(item, details.label, details.description, details.increase, details.weight, details.prop)
    end
end)

vAZ.handlers = {
    ['tabletd'] = function(source, user_id, item, amount, cb)
        if vAZ.cooldown.get(user_id, item) <= 0 then
            vAZclient.closeInventory(source)
            TriggerClientEvent('az-dynasty8:item', source)
        else
            TriggerClientEvent("Notify", source, "importante", "Aguarde "..vRPclient.getTimeFunction(source, vAZ.cooldown.get(user_id, item))..".")
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
		elseif bag >= 1320 and bag < 3300 and vRP.hasPermission(user_id, 'mochila.permissao') then
			if vRP.tryGetInventoryItem(user_id, item, 1, false) then
                vRP.varyExp(user_id, "physical", "strength", 1980)
                cb(true)
			end
        end
        cb(false)
    end,
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
    ['pneu'] = function(source, user_id, item, amount, cb)
        if not vRPclient.inVehicle(source) then
            TriggerClientEvent("progress",source,20000)
                if vRP.tryGetInventoryItem(user_id,item,1, false) then 
                    TriggerClientEvent('arrumarpneu', source)
                else 
                    TriggerClientEvent("Notify", source,"negado", 'Voce nao tem pneu no seu inventario' )
                end
        else
            TriggerClientEvent("Notify", source,"negado", 'Voce precisar estar fora do veiculo') 
        end 

        cb(false)
    end,



    ['bandagem'] = function(source, user_id, item, amount, cb)  
        local user_health = vRPclient.getHealth(source)      
        if user_health > 101 and user_health < 229 then
            if vAZ.cooldown.get(user_id, item) <= 0 then
                if vRP.tryGetInventoryItem(user_id, item, 1) then
                    vAZ.cooldown.push(user_id, item, 120)
                    vRPclient._CarregarObjeto(source, "amb@world_human_clipboard@male@idle_a", "idle_c", "v_ret_ta_firstaid", 49, 60309)
                    TriggerClientEvent('cancelando', source, true)
                    TriggerClientEvent("progress", source, 20000, "bandagem")
                    TriggerClientEvent('bandagem', source)
                    SetTimeout(20000, function()
                        TriggerClientEvent('cancelando', source, false)
                        vRPclient._DeletarObjeto(source)
                        TriggerClientEvent('bandagem',user_id)
                        TriggerClientEvent("Notify", source, "sucesso", "Bandagem utilizada com sucesso.", 8000)
                    end)
                end
            else
                TriggerClientEvent("Notify",source,"importante","Aguarde "..vRPclient.getTimeFunction(source, vAZ.cooldown.get(user_id, item))..".",8000)
            end
        else
            TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.", 8000)
        end    
        cb(false)
    end,
    ['energetico'] = function(source, user_id, item, amount, cb)
        if vRP.tryGetInventoryItem(user_id, item, 1) then            
            TriggerClientEvent('cancelando', source, true)
            vRPclient._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", vAZ.items[item].prop, 49, 28422)
            TriggerClientEvent("progress", source, 20000, "bebendo")
            SetTimeout(20000, function()
                TriggerClientEvent('energeticos', source, true)
                TriggerClientEvent('cancelando', source, false)
                vRPclient._DeletarObjeto(source)
                TriggerClientEvent("Notify", source, "sucesso", "Energético utilizado com sucesso.", 8000)
            end)
            SetTimeout(60000, function()
                TriggerClientEvent('energeticos', source, false)
                TriggerClientEvent("Notify", source, "aviso", "O efeito do energético passou e o coração voltou a bater normalmente.", 8000)
            end)
            cb(true)
        end
        cb(false)
    end,
    ['placa'] = function(source, user_id, item, amount, cb)
        cb(false)
    end,
    ['morfina'] = function(source, user_id, item, amount, cb)
        if #vRP.getUsersByPermission("polpar.permissao") <= 0 then
            local nplayer = vRPclient.getNearestPlayer(source, 2)
            if nplayer then
                if vRPclient.isComa(nplayer) then
                    if vRP.tryGetInventoryItem(user_id,"morfina",1) then
                        TriggerClientEvent('cancelando',source,true)
                        vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
                        TriggerClientEvent("progress",source,30000,"reanimando")
                        SetTimeout(30000,function()
                            vRPclient.networkRessurection(nplayer)
                            vRPclient._stopAnim(source,false)
                            TriggerClientEvent('cancelando',source,false)
                        end)
                        cb(true)
                    end
                else
                    TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.",8000)
                end
            end
        end
        cb(false)
    end,
    ['cirurgia'] = function(source, user_id, item, amount, cb)
        if vRP.tryGetInventoryItem(user_id, "cirurgia", 1) then
            cb(true)
            vRP.setUData(user_id, "vRP:spawnController", parseInt(0))
            vRP.kick(source, "Aparencia resetada")
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
                vRPclient.playScreenEffect(source, "DMT_flight", 120) 
            end)
            SetTimeout(120000,function()
                vRPclient.resetMovement(source, false) 
            end)
            cb(true)
        end
        cb(false)
    end,
    ['crjhaze'] = function(source, user_id, item, amount, cb)    
        if vRP.tryGetInventoryItem(user_id, "crjhaze", 1, false) then
            TriggerClientEvent("Notify", source, "aviso", "Fumando CRJ Haze.")
            vRPclient._playAnim(source, true, {task="WORLD_HUMAN_SMOKING_POT"}, false)
            SetTimeout(10000,function()
                vRPclient._stopAnim(source, true)
                vRPclient._stopAnim(source, false) 
                vRPclient.playMovement(source, "MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
                vRPclient.playScreenEffect(source, "DMT_flight", 120) 
            end)
            SetTimeout(120000,function()
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
                vRPclient.playScreenEffect(source, "DrugsTrevorClownsFight", 120) 
            end)
            SetTimeout(120000, function()
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
        if #vRP.getUsersByPermission("policia.permissao") < 3 then
            TriggerClientEvent("Notify", source, "aviso", "Número insuficiente de policiais no momento para iniciar o roubo.")
            return true
        end
        local vehicle = vRPclient.getNearestVehicle(source, 5)
		if vehicle then
            local plate = vRPclient.getPlateVehicle(source, vehicle)
            if plate ~= nil then
                local spawned, vehicle = vAZgarage.getUserVehicle(user_id, plate)
                if spawned then
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                    TriggerClientEvent("progress", source, 30000, "roubando")
                    SetTimeout(30000, function()
                        TriggerClientEvent('cancelando', source, false)
                        vRPclient._stopAnim(source, false)
                        if math.random(100) >= 50 then
                            vAZgarage.ToggleLock(vehicle.net)
                            TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
                            if math.random(100) >= 70 then
                                vRP.tryGetInventoryItem(user_id, item, 1)
                            end
                            cb(true)
                        else
                            TriggerClientEvent("Notify", source, "negado", "Roubo do veículo falhou e as autoridades foram acionadas.")
                            local pick = {}
                            for k,v in pairs(vRP.getUsersByPermission("policia.permissao")) do
                                local player = vRP.getUserSource(parseInt(v))
                                if player then
                                    async(function()
                                        local id = vAZ.id:gen()
                                        vRPclient._playSound(player, "CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
                                        TriggerClientEvent('chatMessage', player, "911", {65,130,255}, "Roubo na ^1"..vRPclient.getStreetName(source).."^0 do veículo ^1"..vehicle.model.."^0 de placa ^1"..plate.."^0 verifique o ocorrido.")
                                        pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
                                        SetTimeout(60000, function()
                                            vRPclient.removeBlip(player, pick[id])
                                            vAZ.id:free(id)
                                        end)
                                    end)
                                end
                            end
                        end
                    end)
                else
                    if vRP.tryGetInventoryItem(user_id, item, 1) then
                        local vnet = vRPclient.getNetVehicle(source, vehicle)
                        vAZgarage.ToggleLock(vnet) 
                        TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1) 
                        cb(true)
                    end
                end
            end
        end
        cb(false)
    end,
    ['masterpick'] = function(source, user_id, item, amount, cb)
        if #vRP.getUsersByPermission("policia.permissao") < 4 then
            TriggerClientEvent("Notify", source, "aviso", "Número insuficiente de policiais no momento para iniciar o roubo.")
            return true
        end
        local vehicle = vRPclient.getNearestVehicle(source, 5)
		if vehicle then
            local plate = vRPclient.getPlateVehicle(source, vehicle)
            if plate ~= nil then
                local spawned, vehicle = vAZgarage.getUserVehicle(user_id, plate)
                if spawned then
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                    TriggerClientEvent("progress", source, 30000, "roubando")
                    SetTimeout(30000, function()
                        TriggerClientEvent('cancelando', source, false)
                        vRPclient._stopAnim(source, false)
                        vAZgarage.ToggleLock(vehicle.net)                        
                        TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1)
                        if math.random(100) >= 50 then
                            vRP.tryGetInventoryItem(user_id, item, 1)
                        end

                        TriggerClientEvent("Notify", source, "negado", "Roubo do veículo concluído e as autoridades foram acionadas.")
                        local pick = {}
                        for k,v in pairs(vRP.getUsersByPermission("policia.permissao")) do
                            local player = vRP.getUserSource(parseInt(v))
                            if player then
                                async(function()
                                    local id = vAZ.id:gen()
                                    vRPclient._playSound(player, "CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
                                    TriggerClientEvent('chatMessage', player, "911", {65,130,255}, "Roubo na ^1"..vRPclient.getStreetName(source).."^0 do veículo ^1"..vehicle.model.."^0 de placa ^1"..plate.."^0 verifique o ocorrido.")
                                    pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
                                    SetTimeout(60000, function()
                                        vRPclient.removeBlip(player, pick[id])
                                        vAZ.id:free(id)
                                    end)
                                end)
                            end
                        end
                    end)
                else
                    if vRP.tryGetInventoryItem(user_id, item, 1) then
                        local vnet = vRPclient.getNetVehicle(source, vehicle)
                        vAZgarage.ToggleLock(vnet)  
                        TriggerClientEvent("vrp_sound:source", source, 'lock', 0.1) 
                        cb(true)
                    end
                end
            end
        end
        cb(false)
    end,
    ['repairkit'] = function(source, user_id, item, amount, cb)
        if not vRPclient.isInVehicle(source) then
            local vehicle = vRPclient.getNearestVehicle(source, 7)		
            if vehicle then
                if vRP.tryGetInventoryItem(user_id, item, 1, false) then
                    TriggerClientEvent('cancelando', source, true)
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
                    SetTimeout(30000, function()
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