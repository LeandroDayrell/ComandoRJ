local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-homes')
vAZ = {}
Proxy.addInterface('az-homes', vAZ)
Tunnel.bindInterface('az-homes', vAZ)

vRP._prepare("vRP/get_users_homes", "SELECT * FROM vrp_user_homes")
vRP._prepare("vRP/upt_home_lock", "UPDATE vrp_user_homes SET locked = @locked WHERE home = @home")
vRP._prepare("vRP/upt_home_wardrobe", "UPDATE vrp_user_homes SET guardaRoupa = @guardaRoupa WHERE home = @home")
vRP._prepare("vRP/get_home_wardrobe", "SELECT guardaRoupa FROM vrp_user_homes WHERE home = @home")
vRP._prepare("vRP/upt_user_position", "UPDATE vrp_user_data SET dvalue = JSON_SET(dvalue, CONCAT(\"$.\", \"position\"), JSON_OBJECT('x', @x, 'y', @Y, 'z', @z)) WHERE dkey = 'vRP:datatable' AND user_id = @user_id")

local items = module("cfg/items").items
local casa = module("cfg/homes").casas
local casa_slot = {}
local in_slot   = {}

vAZ.homes = {}
vAZ.slots = {}
vAZ.area = {}

-- Initializing
async(function()
    for id,home in pairs(casa) do
        vAZ.homes[id] = {
            name = id,
            owner = -1,
            locked = true,
            entry = home.entry,
            exit = home.exit,
            chest = home.bau.localizacao,
            wardrobe = home.guardaRoupa
        }
        vAZ.area[id] = {}
    end
    for id,home in pairs(vRP.query("vRP/get_users_homes")) do
        if vAZ.homes[home.home] then
            vAZ.homes[home.home].name = home.home
            vAZ.homes[home.home].owner = home.user_id
            vAZ.homes[home.home].locked = home.locked
        end
    end
end)

vAZ.getHomes = function()
    return vAZ.homes
end

-- Players on area slot
vAZ.GetUsersAreaSlot = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.area[name] ~= nil then
        return vAZ.area[name]
    end
    return {}
end

vAZ.AddUserAreaSlot = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.area[name] ~= nil then
        table.insert(vAZ.area[name], user_id)
        vAZclient.UpdateHomeStatus(source, name, vAZ.homes[name].locked)
        --print('[az-homes] AddUserAreaSlot: '..name.. ' - user_id: '..user_id)
        return true
    end
    return false
end

vAZ.RemoveUserAreaSlot = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.area[name] ~= nil then
        for id,user in pairs(vAZ.area[name]) do
            if user_id == user then
                table.remove(vAZ.area[name], id)
                --print('[az-homes] RemoveUserAreaSlot: '..name.. ' - user_id: '..user_id)
                return true
            end
        end
    end
    return false
end

vAZ.RemoveUserAreaSlotByName = function(user_id, name)
    if vAZ.area[name] ~= nil then
        for id,user in pairs(vAZ.area[name]) do
            if user_id == user then
                table.remove(vAZ.area[name], id)
            end
        end
    end
end

-- Home
vAZ.EnterHomeSlot = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.homes[name] and not vAZ.slots[user_id] and not vAZ.homes[name].locked then
        vAZ.slots[user_id] = vAZ.homes[name]
        vRPclient.teleport(source, vAZ.homes[name].exit.x, vAZ.homes[name].exit.y, vAZ.homes[name].exit.z)
        return true
    end
    return false
end

vAZ.ExitHomeSlot = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.homes[name] and vAZ.slots[user_id] and vAZ.slots[user_id].name == name and not vAZ.homes[name].locked then
        vAZ.slots[user_id] = nil
        vRPclient.teleport(source, vAZ.homes[name].entry.x, vAZ.homes[name].entry.y, vAZ.homes[name].entry.z)
        return true
    end
    return false
end

vAZ.ChangeHomeStatus = function(name, locked)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.homes[name] then
        if vAZ.homes[name].owner == user_id or vAZ.SearchUserPermission(json.decode(vRP.getSData('permission:'..name)) or {}, user_id) then
            if locked == nil then
                vAZ.homes[name].locked = not vAZ.homes[name].locked
            else
                vAZ.homes[name].locked = locked
            end
            vRP.execute("vRP/upt_home_lock", {home = name, locked = vAZ.homes[name].locked})
            for id,user in pairs(vAZ.GetUsersAreaSlot(name)) do
                local target = vRP.getUserSource(user)
                if target then
                    vAZclient.UpdateHomeStatus(target, name, vAZ.homes[name].locked)
                else
                    vAZ.RemoveUserAreaSlotByName(user, name)
                end
            end
            return true
        end
    end
    return false
end

-- Wardrobe
vAZ.GetWardrobeClothes = function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.slots[user_id] and vAZ.slots[user_id].name == name then
        local clothes = {}
        local wardrobe = vRP.query("vRP/get_home_wardrobe", {home = name})
        if #wardrobe > 0 then
            for key,value in pairs(json.decode(wardrobe[1].guardaRoupa) or {}) do
                clothes[key] = {['nomeSet'] = key}
            end
        end
        return clothes
    end
    return {}
end

vAZ.WearWardrobeClothes = function(name, set)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.slots[user_id] and vAZ.slots[user_id].name == name then
        local wardrobe = vRP.query("vRP/get_home_wardrobe", {home = name})
        if #wardrobe > 0 then
            wardrobe = json.decode(wardrobe[1].guardaRoupa) or {}
            if wardrobe[set] then
                vRPclient.setCustomization(source, wardrobe[set])
            end
        end
    end
end

vAZ.DeleteWardrobeClothes = function(name, set)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.slots[user_id] and vAZ.slots[user_id].name == name and vAZ.homes[name].owner == user_id or vAZ.SearchUserPermission(json.decode(vRP.getSData('permission:'..name)) or {}, user_id) then
        local wardrobe = vRP.query("vRP/get_home_wardrobe", {home = name})
        if #wardrobe > 0 then
            wardrobe = json.decode(wardrobe[1].guardaRoupa) or {}
            if wardrobe[set] then
                wardrobe[set] = nil
                vRP.execute("vRP/upt_home_wardrobe", {home = name, guardaRoupa = json.encode(wardrobe)})
                vAZclient.UpdateWardrobeClothes(source)
            end
        end
    end
end

vAZ.SaveWearWardrobeClothes = function(name, set)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.slots[user_id] and vAZ.slots[user_id].name == name and vAZ.homes[name].owner == user_id or vAZ.SearchUserPermission(json.decode(vRP.getSData('permission:'..name)) or {}, user_id) then
        local wardrobe = vRP.query("vRP/get_home_wardrobe", {home = name})
        if #wardrobe > 0 then
            wardrobe = json.decode(wardrobe[1].guardaRoupa) or {}
            if wardrobe[set] then
                local ok = vRP.request(source, "Ja existe um cabide com esse nome, deseja substituir ?", 30)
                if ok then
                    wardrobe[set] = vRPclient.getCustomization(source)
                    vRP.execute("vRP/upt_home_wardrobe", {home = name, guardaRoupa = json.encode(wardrobe)})
                end
            else
                wardrobe[set] = vRPclient.getCustomization(source)
                vRP.execute("vRP/upt_home_wardrobe", {home = name, guardaRoupa = json.encode(wardrobe)})
            end
            vAZclient.UpdateWardrobeClothes(source)
        end
    end
end

AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn) 
    if first_spawn then
        for id,home in pairs(vRP.getUserAddresses(user_id)) do
            if vAZ.homes[home.home] then
                vRPclient._addBlipProperty(source, vAZ.homes[home.home].entry.x, vAZ.homes[home.home].entry.y, vAZ.homes[home.home].entry.z, 40, 3, home.home, 0.6)
            end            
        end
        vAZclient.SetHomes(source, vAZ.homes)
    end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
    for user,slot in pairs(vAZ.slots) do
        if user_id == user then
            vAZ.RemoveUserAreaSlotByName(user_id, slot.name)
            SetTimeout(5000, function()
                vRP.execute("vRP/upt_user_position", {user_id = user_id, x = vAZ.homes[slot.name].entry.x, y = vAZ.homes[slot.name].entry.y, z = vAZ.homes[slot.name].entry.z})
                vAZ.slots[user_id] = nil
            end)
        end
    end
end)

--- Others
RegisterCommand("hchave", function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.slots[user_id] and #args == 1 then
        local home_user = vRP.query("vRP/get_home", {home = vAZ.slots[user_id].name})
        if #home_user > 0 then
            if home_user[1].user_id == user_id and args[1] then                
                local target_source = vRPclient.getNearestPlayer(source, 7)
                if target_source then
                    local target_id = vRP.getUserId(target_source)
                    local target_identity = vRP.getUserIdentity(target_id)
                    local home_key = vRP.getSData('permission:'..vAZ.slots[user_id].name)
                    if home_key == nil or home_key == "" then
                        home_key = {}
                        vRP.setSData('permission:'..vAZ.slots[user_id].name, json.encode(home_key))
                    else
                        home_key = json.decode(home_key)
                    end
                    if args[1] == 'dar' then
                        target_permission, target_key = vAZ.SearchUserPermission(home_key, target_id)
                        if not target_permission then
                            local ok = vRP.request(source, "["..vAZ.slots[user_id].name.."] Tem certeza que deseja <b>entregar</b> a chave para <b>"..target_identity.firstname.." "..target_identity.name.."</b> ?", 30)
                            if ok then
                                table.insert(home_key, target_id)
                                vRP.setSData('permission:'..vAZ.slots[user_id].name, json.encode(home_key))
                                TriggerClientEvent('Notify', source, 'sucesso', "Você entregou a chave da residencia!")
                                updateCasas(target_source)
                                TriggerClientEvent('Notify', target_source, 'importante', 'O proprietário te deu a chave da residencia!')                                
                            end                            
                        else
                            TriggerClientEvent('Notify', source, 'importante', "Essa pessoa já tem a chave dessa residencia!")
                        end
                    elseif args[1] == 'tirar' then
                        target_permission, target_key = vAZ.SearchUserPermission(home_key, target_id)
                        if target_permission then
                            local ok = vRP.request(source, "["..vAZ.slots[user_id].name.."] Tem certeza que deseja <b>pegar</b> a chave do(a) <b>"..target_identity.firstname.." "..target_identity.name.."</b> ?", 30)
                            if ok then
                                table.remove(home_key, target_key)
                                vRP.setSData('permission:'..vAZ.slots[user_id].name, json.encode(home_key))
                                TriggerClientEvent('Notify', source, 'importante', "Você pegou a chave da residencia!")
                                TriggerClientEvent('Notify', target_source, 'importante', 'O proprietário pegou a chave de você!')
                                updateCasas(target_source)
                            end                            
                        else
                            TriggerClientEvent('Notify', source, 'importante', "Essa pessoa não tem a chave dessa residencia!")
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, 'importante', "Não tem ninguem perto de você!")
                end
            else                
                TriggerClientEvent('Notify', source, 'importante', "Você não e dono dessa residencia!")
            end
        end
    end
end)

vAZ.SearchUserPermission = function(permissions, user_id)
    for id,key in pairs(permissions) do
        if key == user_id then
            return true, id
        end        
    end
    return false, nil
end

RegisterNetEvent('az-homes:purchase')
AddEventHandler('az-homes:purchase', function(user_id, name)
    local source = vRP.getUserSource(user_id)
    if source then
        if vAZ.homes[name] then
            vRP.setUserAddress(user_id, name, 1, true, casa[name].bau.limite)
            vAZ.homes[name].owner = user_id
            vRPclient._addBlipProperty(source, vAZ.homes[name].entry.x, vAZ.homes[name].entry.y, vAZ.homes[name].entry.z, 40, 3, name, 0.6)
            for id,user in pairs(vAZ.GetUsersAreaSlot(name)) do
                local target = vRP.getUserSource(user)
                if target then
                    vAZclient.UpdateHomeStatus(target, name, vAZ.homes[name].locked)
                else
                    vAZ.RemoveUserAreaSlotByName(user, name)
                end
            end
        else
            print('[az-homes] purchase: '..name.. ' - casa não encontrada')
        end
    end
end)

RegisterServerEvent('az-homes:chest')
AddEventHandler('az-homes:chest', function(casa)    
    local inventory = {}
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.slots[user_id] and vAZ.slots[user_id].name == casa then
        local rows = vRP.query("vRP/get_home", {home = casa})
        if #rows > 0 then
            TriggerClientEvent('az-inventory:home', source, rows[1].user_id, casa) 
        end
    end
end)

RegisterCommand("ggc", function(source,args,rawCommand)
    local source = source
    vAZclient.SetHomes(-1, vAZ.homes)
end)