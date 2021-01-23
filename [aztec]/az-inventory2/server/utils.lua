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

vAZ.itemAllowed = function(item)
    for id,ignore in pairs(vAZ.config.notAllowed) do
        if ignore == item then
            return false
        end
    end
    return true
end

vAZ.webhook = function(type, message)
    if vAZ.config.webhooks.links[type] ~= nil then
		PerformHttpRequest(vAZ.config.webhooks.links[type].url, function(Error, Content, Head) end, 'POST', json.encode({
            username = vAZ.config.webhooks.links[type].name,
            avatar_url = vAZ.config.webhooks.avatar,
            content = "```"..message.."```"
        }), {['Content-Type'] = 'application/json'})
	end
end