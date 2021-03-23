local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","speedo1")

RegisterServerEvent('pestiuc')
AddEventHandler('pestiuc', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    print("datitem")
    vRP.giveInventoryItem({user_id,"isca", 1,true})
    vRPclient.notify(player, {'~p~Ai prins un peste!'})
end)

RegisterServerEvent('vpestiuc')
AddEventHandler('vpestiuc', function(cate)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.tryGetInventoryItem({user_id,"isca", cate,true}) then
        vRP.giveMoney({user_id, cate*220})
    end
end)
