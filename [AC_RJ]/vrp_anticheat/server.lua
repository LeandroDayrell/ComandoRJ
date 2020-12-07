local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
---------------------------------GST V3.0------------------------------------------------------------
RegisterServerEvent("ComandoRJ_AntiCheat:Weapon")
AddEventHandler("ComandoRJ_AntiCheat:Weapon", function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
	TriggerClientEvent('chatMessage', -1, '^3[AntiCheat]', {255, 0, 0}, "^1" ..name.. "^3[ID:" ..user_id.. "]^1 KICK RECEBIDO ^3(razão: ARMA BLACKLIST)!" )
	PerformHttpRequest("https://discordapp.com/api/webhooks/706527822662860860/K9QDP7KWh_du-IBncN68_FRo8Qc_cKppBLWl3ohMEZwTdOThSdjqykoD1z3HK2sSPsjk", function(err, text, headers) end, 'POST', json.encode({content =  "**Armas** ```" .. "ID: " .. user_id .. " Nome: " .. name .. "\nServidor: " .. GetConvar('sv_name', 'ND') .. "\nData: " .. os.date("%H:%M:%S %d/%m/%Y") .. "```"}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('explosionEvent', function(source, ev)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
	local idExplosao = ev.explosionType	
	local ownerId = ev.ownerNetId
	if (idExplosao == 29 and ownerId ~= 0) then
	PerformHttpRequest("https://discordapp.com/api/webhooks/709069957048303639/FdbrcEzseykHaePgkjrcFlv3_XlrYd5tr-iCPj3q-Gp07KQNK54V8cDlaPA2fTISKt55", function(err, text, headers) end, 'POST', json.encode({content =  "**Explosões** ```" .. "ID: " .. user_id .. " Nome: " .. name .. "\nServidor: " .. GetConvar('sv_name', 'ND') .. "\nData: " .. os.date("%H:%M:%S %d/%m/%Y") .. "```"}), { ['Content-Type'] = 'application/json' })
	DropPlayer(source, "[AntiCheat] Venda discord.gg/VUmdPh5.")
	end
  CancelEvent(explosionEvent)
end)

AddEventHandler('comando:playerLoaded', function(source)
 TriggerEvent('comando:getPlayerFromId', source, function(user)
 local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    user:setMoney((user.money))
	PerformHttpRequest("https://discordapp.com/api/webhooks/709061932887310369/IQv3bUKU5FW7zldElhNx0nMB0BAdJlOlZCNOTKMNjIo7ASL0ZAwgnVgQE2Ye7Uvm0J_b", function(err, text, headers) end, 'POST', json.encode({content =  "**Dinheiro** ```" .. "ID: " .. user_id .. " Nome: " .. name .. "\nServidor: " .. GetConvar('sv_name', 'ND') .. "\nData: " .. os.date("%H:%M:%S %d/%m/%Y") .. "```"}), { ['Content-Type'] = 'application/json' })
    DropPlayer(source, "[AntiCheat]  discord.gg/VUmdPh5.")
  end)
end)

RegisterServerEvent("ComandoRJ_AntiCheat:Cars")
AddEventHandler("ComandoRJ_AntiCheat:Cars", function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
	PerformHttpRequest("https://discordapp.com/api/webhooks/708394684355051601/eqBCDDb9oGK5co9_ifCLTAS8nsr7EN1ZauAlPhlPkSEY_2zmVM8kxINJJZDHOOGnSjrG", function(err, text, headers) end, 'POST', json.encode({content =  "**Carro** ```" .. "ID: " .. user_id .. " Nome: " .. name .. "\nServidor: " .. GetConvar('sv_name', 'ND') .. "\nData: " .. os.date("%H:%M:%S %d/%m/%Y") .. "```"}), { ['Content-Type'] = 'application/json' })
	DropPlayer(source, "[AntiCheat] discord.gg/VUmdPh5.")
end)

RegisterServerEvent("ComandoRJ_AntiCheat:playerPed")
AddEventHandler("ComandoRJ_AntiCheat:playerPed", function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
	PerformHttpRequest("https://discordapp.com/api/webhooks/709061932887310369/IQv3bUKU5FW7zldElhNx0nMB0BAdJlOlZCNOTKMNjIo7ASL0ZAwgnVgQE2Ye7Uvm0J_b", function(err, text, headers) end, 'POST', json.encode({content =  "**Npc** ```" .. "ID: " .. user_id .. " Nome: " .. name .. "\nServidor: " .. GetConvar('sv_name', 'ND') .. "\nData: " .. os.date("%H:%M:%S %d/%m/%Y") .. "```"}), { ['Content-Type'] = 'application/json' })
	DropPlayer(source, "[AntiCheat] discord.gg/VUmdPh5.")
end)

RegisterServerEvent("ComandoRJ_AntiCheat:Jump")
AddEventHandler("ComandoRJ_AntiCheat:Jump", function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    PerformHttpRequest("https://discordapp.com/api/webhooks/709061932887310369/IQv3bUKU5FW7zldElhNx0nMB0BAdJlOlZCNOTKMNjIo7ASL0ZAwgnVgQE2Ye7Uvm0J_b", function(err, text, headers) end, 'POST', json.encode({content =  "**Jump** ```" .. "ID: " .. user_id .. " Nome: " .. name .. "\nServidor: " .. GetConvar('sv_name', 'ND') .. "\nData: " .. os.date("%H:%M:%S %d/%m/%Y") .. "```"}), { ['Content-Type'] = 'application/json' })
	DropPlayer(source, "[AntiCheat] discord.gg/VUmdPh5.")
end)










