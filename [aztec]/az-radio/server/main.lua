local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-radio')
vAZ = {}
Tunnel.bindInterface('az-radio', vAZ)

local TokoVoipConfig = {
    [1] = {"policiaradio.permissao"},
    [2] = {"policiaradio2.permissao"},
    [3] = {"policiaradio.permissao"},
    [4] = {"samuradio.permissao"},
	[5] = {"pcerjradio.permissao"},
	[6] = {"prf.permissao"},
	[7] = {"operacao.permissao"}
};

vAZ.getRadios = function()
    return TokoVoipConfig
end

vAZ.itemAmount = function()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.getInventoryItemAmount(user_id, 'walkietalkie') >= 1
end

vAZ.hasPermission = function()
    local source = source
    local user_id = vRP.getUserId(source)
    for channel, permission in pairs(TokoVoipConfig) do
        if vRP.hasPermission(user_id, permission[1]) then
            return true
        end
    end
    return false
end

RegisterServerEvent("azt_radio:deleteObj")
AddEventHandler("azt_radio:deleteObj", function(entity)
    if entity ~= nil then
        TriggerClientEvent("azt_radio:deleteObj", -1, entity)
    end
end)