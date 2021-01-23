--[[ az-inventory:vault ]]--

vAZ.temp.vaults = {}

vAZ.getVaultInventory = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.config.vaults[name] then
        if vAZ.temp.vaults[name] == nil then
            local vault = json.decode(vRP.getSData("chest:"..name)) or {}
            if vault then
                vAZ.temp.vaults[name] = {permission = vAZ.config.vaults[name].permission, maxweight = vAZ.config.vaults[name].weight, players = {}, inventory = vault}
            end
        end
        if vAZ.temp.vaults[name] ~= nil then
            local inventory = {}
            for item,details in pairs(vAZ.temp.vaults[name].inventory) do
                local data = vAZ.items[item]
                if data ~= nil then
                    table.insert(inventory, {
                        item = item,
                        label = data.label,
                        sendable = data.sendable or false,
                        usable = data.usable or false,
                        dropable = data.dropable or false,
                        weight = data.weight,
                        photo = data.photo,
                        amount = parseInt(details.amount),
                        description = data.description
                    })
                end
            end
            if vAZ.config.debug then
                print('[az-inventory][vault]['..name..'] vault request by user_id: '..user_id)
            end
            vAZ.addPlayerInVault(source, name)
            return {vault = name, weight = vAZ.getChestWeight(vAZ.temp.vaults[name].inventory), maxweight = vAZ.temp.vaults[name].maxweight, items = inventory}
        end
    end
    return {}
end

vAZ.sendPlayerItemToVault = function(item, amount, name)
    if amount == nil or amount <= 0 or name == nil then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vaults[name] ~= nil then
        if vAZ.temp.vaults[name].inventory ~= nil then
            if vRP.hasPermission(user_id, vAZ.temp.vaults[name].permission) then
                if not vAZ.itemNotAllowed(item) then
                    if vAZ.getChestWeight(vAZ.temp.vaults[name].inventory) + vAZ.items[item].weight * amount <= vAZ.temp.vaults[name].maxweight then
                        if item == 'money' and vRP.tryPayment(user_id, amount) or vRP.tryGetInventoryItem(user_id, item, amount, false) then
                            if vAZ.temp.vaults[name].inventory[item] then
                                vAZ.temp.vaults[name].inventory[item] = {amount = (vAZ.temp.vaults[name].inventory[item].amount + amount)}
                            else
                                vAZ.temp.vaults[name].inventory[item] = {amount = amount}
                            end
                        end
                        if vAZ.config.debug then
                            print('[az-inventory][vault]['..name..'] send item ('..amount..'x '..item..') to vault: '..name..' by user_id: '..user_id)
                        end
                        if vAZ.config.logs and vAZ.config.vaults[name].webhook then
                            PerformHttpRequest(vAZ.config.vaults[name].webhook, function(Error, Content, Head) end, 'POST', json.encode({
                                username = name,
                                avatar_url = vAZ.config.webhooks.avatar,
                                content = "```user_id: "..user_id..", colocou ("..amount.."x "..item..") no baú: "..name.."```"
                            }), {['Content-Type'] = 'application/json'})
                        end
                        for id,user in pairs(vAZ.getPlayersInVault(name)) do
                            local target = vRP.getUserSource(user)
                            if target then
                                vAZclient.updateInventory(target, 'vault', name, vAZ.getVaultInventory(name))
                            else
                                vAZ.removePlayerInVault(target, name)
                            end
                        end
                        vAZclient.updateInventory(source, 'player', source, vAZ.getPlayerInventory(source)) 
                    else
                        TriggerClientEvent('Notify', source, 'aviso', 'Espaço no baú insulficiente')
                    end
                end
            end                     
        end
    end
end

vAZ.sendVaultItemToPlayer = function(item, amount, name)
    if amount == nil or amount <= 0 or name == nil then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vaults[name] ~= nil then
         if vAZ.temp.vaults[name].inventory ~= nil then
            if vRP.hasPermission(user_id, vAZ.temp.vaults[name].permission) then
                if vAZ.temp.vaults[name].inventory[item] then
                    if vAZ.temp.vaults[name].inventory[item].amount >= amount then
                        if not vAZ.itemNotAllowed(item) then
                            if vRP.getInventoryWeight(user_id) + vAZ.items[item].weight * amount <= vRP.getInventoryMaxWeight(user_id) then
                                if (vAZ.temp.vaults[name].inventory[item].amount - amount) <= 0 then
                                    vAZ.temp.vaults[name].inventory[item] = nil
                                else
                                    vAZ.temp.vaults[name].inventory[item] = {amount = (vAZ.temp.vaults[name].inventory[item].amount - amount)}
                                end
                                if item == 'money' then
                                    vRP.giveMoney(user_id, parseInt(amount))
                                else
                                    vRP.giveInventoryItem(user_id, item, amount, false)
                                end
                                if vAZ.config.debug then
                                    print('[az-inventory][vault]['..name..'] send item ('..amount..'x '..item..') to player user_id: '..user_id)
                                end
                                if vAZ.config.logs and vAZ.config.vaults[name].webhook then
                                    PerformHttpRequest(vAZ.config.vaults[name].webhook, function(Error, Content, Head) end, 'POST', json.encode({
                                        username = name,
                                        avatar_url = vAZ.config.webhooks.avatar,
                                        content = "```user_id: "..user_id..", retirou ("..amount.."x "..item..") do baú: "..name.."```"
                                    }), {['Content-Type'] = 'application/json'})
                                end
                                for id,user in pairs(vAZ.getPlayersInVault(name)) do
                                    local target = vRP.getUserSource(user)
                                    if target then
                                        vAZclient.updateInventory(target, 'vault', name, vAZ.getVaultInventory(name))
                                    else
                                        vAZ.removePlayerInVault(target, name)
                                    end
                                end
                                vAZclient.updateInventory(source, 'player', source, vAZ.getPlayerInventory(source)) 
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Espaço na mochila insulficiente')
                            end
                        end
                    end
                end
            end
        end
    end
end

vAZ.getPlayersInVault = function(name)
    if vAZ.temp.vaults[name] then
        return vAZ.temp.vaults[name].players
    end
    return {}
end
  
vAZ.addPlayerInVault = function(source, name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vaults[name] then
        if vAZ.temp.vaults[name].players == nil then
            vAZ.temp.vaults[name].players = {}
        end
        local found = false
        for id,user in pairs(vAZ.temp.vaults[name].players) do
            if user == user_id then
                found = true
            end
        end
        if not found then
            if vAZ.config.debug then
                print('[az-inventory][vault]['..name..'] player '..user_id..' added to vault')
            end
            table.insert(vAZ.temp.vaults[name].players, user_id)
            return true
        end
    end
    return false
end
  
vAZ.removePlayerInVault = function(source, name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.temp.vaults[name] then
        if vAZ.temp.vaults[name].players ~= nil then
            for id,user in pairs(vAZ.temp.vaults[name].players) do
                if user == user_id then
                    if vAZ.config.debug then
                        print('[az-inventory][vault]['..name..'] player '..user_id..' removed to vault')
                    end
                    table.remove(vAZ.temp.vaults[name].players, id)
                end
            end 
            if #vAZ.temp.vaults[name].players <= 0 then
                if vAZ.config.debug then
                    print('[az-inventory][vault]['..name..'] vault saved')
                end
                vRP.setSData("chest:"..name, json.encode(vAZ.temp.vaults[name].inventory))
                vAZ.temp.vaults[name] = nil
            end
        end
    end
end

vAZ.vaultHasPermission = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.config.vaults[name] and vRP.hasPermission(user_id, vAZ.config.vaults[name].permission) then
        return true
    end
    return false
end

AddEventHandler("vRP:playerLeave", function(user_id, source)
    for name,vault in pairs(vAZ.temp.vaults) do
        for id,user in pairs(vault.players) do
            if user_id == user then
                table.remove(vAZ.temp.vaults[name].players, id)
                if #vAZ.temp.vaults[name].players <= 0 then
                    if vAZ.config.debug then
                        print('[az-inventory][vault]['..name..'] vault saved')
                    end
                    vRP.setSData("chest:"..name, json.encode(vault.inventory))     
                    vAZ.temp.vaults[name] = nil
                end                
            end
        end
    end
end)

Citizen.CreateThread(function()
    while vAZ.config.debug do            
        for name,vault in pairs(vAZ.temp.vaults) do
            print('[az-inventory][vault]['..name..'] players: '..json.encode(vault.players)..' - count: '..#vault.players)
        end       
        Citizen.Wait(3000)
    end
end)