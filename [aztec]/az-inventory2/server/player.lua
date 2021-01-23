--[[ az-inventory:player ]]--

vAZ.temp.players = {}


local webhooklinkinventario = "https://discordapp.com/api/webhooks/738869325863190548/P19H81mAVlSflGm-NTu86I7wb672Lg-KaQyJxd910enr53m403EGA8I0uQ6Hk_d72GA-"
local webhooklinkpagedown = "https://discordapp.com/api/webhooks/732314240010027048/zEnXIBKh3txDKB0z0nWDLNuEksQSRc47iQ8RJcqIlLPDZDI8b3uE_w_H-veid9jya1EA"
local webhooklinkenviarmoney = "https://discordapp.com/api/webhooks/732772522667540570/WQNXlTCncD7XElLfyaiq5y4U9PEmgpMbgJeo3P1rfCuWZ5CKfFiEqsKIrLM1QpgfJGsp"
local webhooklinkdropou = "https://discordapp.com/api/webhooks/721731913072508948/FyEy_dQc7ja6whR-dbgA28IDEWbhN2YE2IPto8Zi_uktZ0nMiXLTSIbr-aAvpFIPipt4"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


vAZ.getPlayerInventory = function(target, weapons)
    local inventory = {}
    local user_id = vRP.getUserId(target)
    local source = vRP.getUserSource(user_id)
    local money = vRP.getMoney(user_id)
    local identity = vRP.getUserIdentity(user_id)
    if money > 0 then
        local data = vAZ.items['money']
        if data ~= nil then
            table.insert(inventory, {item = 'money', label = data.label, usable = data.usable, dropable = data.dropable, weight = data.weight, photo = data.photo, amount = money, description = data.description})
        end
    end
    if identity ~= nil then
        local data = vAZ.items['wcard']
        if data ~= nil then
            table.insert(inventory, {item = 'wcard', label = data.label, usable = data.usable, dropable = data.dropable, weight = data.weight, photo = data.photo, amount = 1, 
                description = 'PASSAPORTE: '..user_id..' | RG: '..identity.registration..' | Nome: '..identity.name..' '..identity.firstname..' | Sexo: N/A | Idade: '..identity.age
            })
        end
    end
    if weapons then
        for k,v in pairs(vRPclient.replaceWeapons(source, {})) do
            vRP.giveInventoryItem(user_id, "wbody|"..k, 1, false)
            if v.ammo > 0 then
                vRP.giveInventoryItem(user_id, "wammo|"..k, v.ammo, false)
            end
        end
    end
    for item,details in pairs(vRP.getInventory(user_id)) do
        local data = vAZ.items[item]
        if data ~= nil then
            table.insert(inventory, {
                item = item,
                label = data.label,
                usable = data.usable,                
                dropable = data.dropable,
                weight = data.weight,
                photo = data.photo,
                amount = parseInt(details.amount),
                description = data.description
            })
        end
    end
    return {user = user_id, weight = vRP.getInventoryWeight(user_id), maxweight = vRP.getInventoryMaxWeight(user_id), items = inventory}
end

vAZ.sendPlayerItemToInspect = function(item, amount, player, target)
    if item == nil or item == '' or amount == nil or amount == '' or amount <= 0 then return end
    local player_id = vRP.getUserId(player)    
    local player_source = vRP.getUserSource(player_id)
    local target_id = vRP.getUserId(target)
    local target_source = vRP.getUserSource(target_id)
    if player_source and target_source then
        if vAZ.itemAllowed(item) then
            if item == 'money' then
                if vRP.tryPayment(player_id, amount) then
                    if vAZ.config.logs then
                        vAZ.webhook('inspect', 'user_id: '..target_id..', enviou ('..amount..'x '..item..') pro user_id: '..player_id)
                    end
                    vRP.giveMoney(target_id, amount)
					SendWebhookMessage(webhooklinkinventario,  "``` [" ..player_id.."] Enviou ["..target_id.."] R$:"..amount.. "```")
                end
            else
                if vRP.getInventoryWeight(target_id) + vAZ.items[item].weight * amount <= vRP.getInventoryMaxWeight(target_id) then
                    if vRP.tryGetInventoryItem(player_id, item, amount, false) then
                        vRP.giveInventoryItem(target_id, item, amount, false)
						SendWebhookMessage(webhooklinkinventario,  "``` [" ..player_id.."] Enviou ["..target_id.."] Item: " ..item .. " Qnt: "..amount.. "```")
                    end
                else
                    TriggerClientEvent('Notify', player_source, 'negado', 'Espaço na mochila da vitima insulficiente')
                end
            end
            vAZclient.updateInventory(player_source, 'player', player_source, vAZ.getPlayerInventory(player_source))
            vAZclient.updateInventory(player_source, 'inspect', target_source, vAZ.getPlayerInventory(target_source, true))
        end
    end
end

vAZ.sendInspectItemToPlayer = function(item, amount, player, target)
    if item == nil or item == '' or amount == nil or amount == '' or amount <= 0 then return end
    local player_id = vRP.getUserId(player)    
    local player_source = vRP.getUserSource(player_id)
    local target_id = vRP.getUserId(target)
    local target_source = vRP.getUserSource(target_id)
    if player_source and target_source then
        if vAZ.itemAllowed(item) then
            if item == 'money' then
                if vRP.tryPayment(player_id, amount) then
                    if vAZ.config.logs then
                        vAZ.webhook('inspect', 'user_id: '..target_id..', pegou ('..amount..'x '..item..') do user_id: '..player_id)
                    end
                    vRP.giveMoney(target_id, amount)
					SendWebhookMessage(webhooklinkpagedown,  "``` UserID: [" ..target_id..', pegou ('..amount..'x '..item..') do UserID: '..player_id.. "```")
                end
            else
                if vRP.getInventoryWeight(target_id) + vAZ.items[item].weight * amount <= vRP.getInventoryMaxWeight(target_id) then
                    if vRP.tryGetInventoryItem(player_id, item, amount, false) then
                        if vAZ.config.logs then
                            vAZ.webhook('inspect', 'user_id: '..target_id..', pegou ('..amount..'x '..item..') do user_id: '..player_id)
                        end
                        vRP.giveInventoryItem(target_id, item, amount, false)
						SendWebhookMessage(webhooklinkpagedown,  "``` UserID:[" ..target_id.."] pegou UserID: ["..player_id.."] Item: " ..item .. " Qnt: "..amount.. "```")
                    end
                else
                    TriggerClientEvent('Notify', target_source, 'negado', 'Espaço na mochila insulficiente')
                end
            end
            vAZclient.updateInventory(target_source, 'player', target_source, vAZ.getPlayerInventory(target_source))
            vAZclient.updateInventory(target_source, 'inspect', player_source, vAZ.getPlayerInventory(player_source, true))
        end
    end
end

vAZ.dropPlayerItem = function(item, amount, coords)
    if item == nil or item == '' or amount == nil or amount == '' or amount <= 0 then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRPclient.isInComa(source) and not vRPclient.isHandcuffed(source) then
        if item == 'money' then
            if vRP.tryPayment(user_id, amount) then
                if vAZ.config.logs then
                    vAZ.webhook('items', 'user_id: '..user_id..', dropou ('..amount..'x '..item..') nas cordenadas: '..coords.x..', '..coords.y..', '..coords.z)
                end
                TriggerEvent('az-drop:createDrop', source, item, amount, coords.x, coords.y, coords.z)
				SendWebhookMessage(webhooklinkdropou,  "``` [" ..user_id.."] dropou Qnt:["..amount.."] Item:" ..item .. " nas coodenadas " ..coords.x..', '..coords.y..', '..coords.z.. "```")
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você não tem esse dinheiro todo!')
            end
        else
            if vRP.tryGetInventoryItem(user_id, item, amount, false) then
                if vAZ.config.logs then
                    vAZ.webhook('items', 'user_id: '..user_id..', dropou ('..amount..'x '..item..') nas cordenadas: '..coords.x..', '..coords.y..', '..coords.z)
                end
                TriggerEvent('az-drop:createDrop', source, item, amount, coords.x, coords.y, coords.z)
				SendWebhookMessage(webhooklinkdropou,  "``` [" ..user_id.."] dropou Qnt:["..amount.."] Item:" ..item .. " nas coodenadas " ..coords.x..', '..coords.y..', '..coords.z.. "```")
            end
        end
        vAZclient.updateInventory(source, 'player', source, vAZ.getPlayerInventory(source))
    end
end

vAZ.usablePlayerItem = function(item, amount)
    if item == nil or item == '' or amount == nil or amount == '' or amount <= 0 then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRPclient.isInComa(source) and not vRPclient.isHandcuffed(source) and vAZ.items[item] then
        if vAZ.handlers[item] then
            vAZ.handlers[item](source, user_id, item, amount, function(success)
                if success and vAZ.config.logs then
                    vAZ.webhook('items', 'user_id: '..user_id..', usou ('..amount..'x '..item..')')
                end
            end)
        else
            if vAZ.items[item].type == 'food' then
                if vRP.tryGetInventoryItem(user_id, item, amount, false) then
                    if vAZ.config.logs then
                        vAZ.webhook('items', 'user_id: '..user_id..', comeu ('..amount..'x '..item..')')
                    end
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._CarregarObjeto(source, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c', vAZ.items[item].prop, 49, 28422)                    
                    TriggerClientEvent("progress", source, 10000, "comendo")
                    SetTimeout(10000, function()
                        TriggerClientEvent('cancelando', source, false)
                        vRPclient._DeletarObjeto(source)
                        vRP.varyHunger(user_id, vAZ.items[item].increase.hunger * amount)
                    end)
                end
            elseif vAZ.items[item].type == 'drink' then
                if vRP.tryGetInventoryItem(user_id, item, amount, false) then
                    if vAZ.config.logs then
                        vAZ.webhook('items', 'user_id: '..user_id..', bebeu ('..amount..'x '..item..')')
                    end
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._CarregarObjeto(source, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', vAZ.items[item].prop, 49, 28422)                    
                    TriggerClientEvent("progress", source, 10000, "bebendo")
                    SetTimeout(10000, function()
                        TriggerClientEvent('cancelando', source, false)
                        vRPclient._DeletarObjeto(source)
                        vRP.varyThirst(user_id, vAZ.items[item].increase.thirst * amount)
                    end)
                end
            elseif vAZ.items[item].type == 'equipment' then
                
            else
                if vAZ.match(item, "wammo", string.gsub(item, "wammo|", "")) then
                    local wammo = splitString(item, '|')
                    if wammo[2] then
                        if amount == 1 then
                            amount = vRP.getInventoryItemAmount(user_id, item)
                            if amount > 250 then
                                amount = 250
                            end
                        end
                        local uweapons = vRPclient.getWeapons(source)
                        if uweapons[wammo[2]] then
                            if vRP.tryGetInventoryItem(user_id, item, amount, false) then
                                local weapons = {}
                                weapons[wammo[2]] = {ammo = amount}
                                vRPclient._giveWeapons(source, weapons, false)
                                if vAZ.config.logs then
                                    vAZ.webhook('items', 'user_id: '..user_id..', recarregou ('..amount..'x '..wammo[2]..')')
                                end
                            end
                        end
                    end
                elseif vAZ.match(item, "wbody", string.gsub(item, "wbody|", "")) then
                    local wbody = splitString(item, '|')
                    local uweapons = vRPclient.getWeapons(source)
                    if not uweapons[wbody[2]] then
                        if vRP.tryGetInventoryItem(user_id, item, amount, false) then
                            local weapons = {}
                            if wbody[2] == 'WEAPON_PETROLCAN' then
                                weapons[wbody[2]] = {ammo = 4500}
                            else
                                weapons[wbody[2]] = {ammo = 0}
                            end
                            vRPclient._giveWeapons(source, weapons)
                            if vAZ.config.logs then
                                vAZ.webhook('items', 'user_id: '..user_id..', equipou ('..amount..'x '..wbody[2]..')')
                            end
                        end
                    end
                end
            end
        end
        vAZclient.updateInventory(source, 'player', source, vAZ.getPlayerInventory(source))
    end
end

vAZ.givePlayerItem = function(item, amount)
    if item == nil or item == '' or amount == nil or amount == '' or amount <= 0 then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRPclient.isInComa(source) and not vRPclient.isHandcuffed(source) then
        local target_source = vRPclient.getNearestPlayer(source, 3)
        if target_source and not vRPclient.isInComa(target_source) and not vRPclient.isHandcuffed(target_source) then
            local target_id = vRP.getUserId(target_source)
            vRPclient._playAnim(source, true, {{'mp_common', 'givetake1_a'}}, false)
            vRPclient._playAnim(target_source, true, {{'mp_common', 'givetake1_a'}}, false)
            if item == 'money' then
                if vRP.tryPayment(user_id, amount) then
                    if vAZ.config.logs then
                        vAZ.webhook('items', 'user_id: '..user_id..', enviou ('..amount..'x '..item..') pro user_id: '..target_id)
                    end
                    vRP.giveMoney(target_id, amount)                    
                    TriggerClientEvent('Notify', source, 'sucesso', 'Dinheiro enviado R$'..vAZ.money(amount)..'.')
                    TriggerClientEvent('Notify', target_source, 'sucesso', 'Você recebeu R$'..vAZ.money(amount)..', do ID: '..user_id..'.')
					SendWebhookMessage(webhooklinkenviarmoney,  "``` [" ..user_id.."] Enviou ["..target_id.."] R$:"..amount.. "```")
                end
            else
                if vRP.getInventoryWeight(target_id) + vAZ.items[item].weight * amount <= vRP.getInventoryMaxWeight(target_id) then
                    if vRP.tryGetInventoryItem(user_id, item, amount, false) then
                        if vAZ.config.logs then
                            vAZ.webhook('items', 'user_id: '..user_id..', enviou ('..amount..'x '..item..') pro user_id: '..target_id)
                        end
                        vRP.giveInventoryItem(target_id, item, amount, false)
						SendWebhookMessage(webhooklinkinventario,  "``` [" ..user_id.."] Enviou ["..target_id.."] Item:" ..item .. " Qnt: "..amount.. "```")
                    end
                end
            end
            vAZclient.updateInventory(source, 'player', source, vAZ.getPlayerInventory(source))
            vAZclient.updateInventory(target_source, 'player', target_source, vAZ.getPlayerInventory(target_source))
        else
            TriggerClientEvent('Notify', source, 'aviso', 'Não tem ninguem perto de você.')
        end
    end
end

vAZ.playerIsInComa = function(player)
    if player == nil then return false end
    return vRPclient.isInComa(player)
end

vAZ.playerHasPermission = function(player, target)
    local user_id = vRP.getUserId(player)
    if vRP.hasPermission(user_id, 'policia.permissao') then
        TriggerClientEvent('Notify', target, 'importante', 'Você está sendo revistado!')
        return true
    end
    return false
end

vAZ.playerInspect = function(player)
    if player == nil then return false end
    local inspect = vRP.request(player, "Aceitar revista ?", 30)
    if inspect then
        TriggerClientEvent('Notify', player, 'importante', 'Você está sendo revistado!')
        return true
    else
        TriggerClientEvent('Notify', source, 'negado', 'Revista recusada!')
        return false
    end
end