--[[ az-inventory:utils ]]--

vAZ.match = function(string, type, weapon)
    if string:match('^('..type..')(.)('..weapon..')') then
       return true
    end
    return false
end

vAZ.money = function(value)
    while true do  
        value, k = string.gsub(value, '^(-?%d+)(%d%d%d)', '%1,%2')
        if k == 0 then
            break
        end
    end
    return value
end

vAZ.getChestWeight = function(chest)
    local weight = 0
    if type(chest) == 'table' then
        for name,item in pairs(chest) do
            if vAZ.items[name] then
                weight = weight + vAZ.items[name].weight * item.amount
            end
        end
    end
    return weight
end

vAZ.itemNotAllowed = function(item)
    for id,ignore in pairs(vAZ.config.notAllowed) do
        if ignore == item then
            return true
        end
    end
    return false
end

vAZ.cooldown = {
    users = {},
    get = function(user_id, item)
        if vAZ.cooldown.users[user_id] then
            if vAZ.cooldown.users[user_id][item] then
                return vAZ.cooldown.users[user_id][item]
            end
        end
        return 0
    end,
    push = function(user_id, item, time)
        if vAZ.cooldown.users[user_id] == nil then
            vAZ.cooldown.users[user_id] = {}
        end
        if vAZ.cooldown.users[user_id][item] then
            vAZ.cooldown.users[user_id][item] = vAZ.cooldown.users[user_id][item] + time
            return true
        else
            vAZ.cooldown.users[user_id][item] = time
            return true
        end
        return false
    end,
    remove = function(user_id, item)
        if vAZ.cooldown.users[user_id] then
            if vAZ.cooldown.users[user_id][item] then
                vAZ.cooldown.users[user_id][item] = nil
            end
            return true
        end
        return false
    end
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
        for user,items in pairs(vAZ.cooldown.users) do
            for item,time in pairs(items) do
                if time <= 0 then
                    vAZ.cooldown.users[user][item] = nil
                    break
                elseif time > 0 then
                    vAZ.cooldown.users[user][item] = time - 1
                    break
                end
            end
		end
	end
end)

vAZ.webhook = function(type, message)
    if vAZ.config.webhooks.links[type] ~= nil then
		PerformHttpRequest(vAZ.config.webhooks.links[type].url, function(Error, Content, Head) end, 'POST', json.encode({
            username = vAZ.config.webhooks.links[type].name,
            avatar_url = vAZ.config.webhooks.avatar,
            content = "```"..message.."```"
        }), {['Content-Type'] = 'application/json'})
	end
end