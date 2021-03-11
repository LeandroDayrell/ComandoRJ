--[[ az-inventory:events ]]--

RegisterServerEvent("az-inventory:trunk")
AddEventHandler("az-inventory:trunk",function(nveh)
	TriggerClientEvent("az-inventory:trunk", -1, nveh)
end)

RegisterServerEvent("az-inventory:deleteTempTrunk")
AddEventHandler("az-inventory:deleteTempTrunk", function(plate)
    if vAZ.temp.vehicles[plate] then
        for id,user in pairs(vAZ.temp.vehicles[plate].players) do
            local player = vRP.getUserSource(parseInt(user))  
            if player ~= nil then
                vAZclient.closeInventory(player)
            end
        end
        if vAZ.temp.vehicles[plate].owner ~= 'temporary' then
            if vAZ.config.debug then
                print('[az-inventory][vehicle]['..plate..'] trunk saved')
            end
            vRP.execute('vAZ/updateChestVehicle', {plate = plate, trunk = json.encode(vAZ.temp.vehicles[plate].inventory)})    
        end               
        vAZ.temp.vehicles[plate] = nil
    end
end)

RegisterServerEvent('az-inventory:firework')
AddEventHandler('az-inventory:firework', function(x, y, z)
    TriggerClientEvent('az-inventory:firework:startExplosion', -1, x, y, z)
end)

RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar", -1, nveh)
end)

RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor", -1, nveh)
end)