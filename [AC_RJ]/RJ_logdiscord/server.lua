--  CONFIGURAÇÃO --

local timezone = -4

-------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","RJ_logdiscord")

local Time = {}
local webhooklinkserver = "https://discordapp.com/api/webhooks/704785160436187188/TMVdsEev-i-0xcjpoO0QYJNeONm4zv7ah7pK-CnyjO7jT9aPiWth-YIUbwdVt06B5gK5"
local webhooklinkchat = "https://discordapp.com/api/webhooks/704785160436187188/TMVdsEev-i-0xcjpoO0QYJNeONm4zv7ah7pK-CnyjO7jT9aPiWth-YIUbwdVt06B5gK5"
local webhooklinkdeath = "https://discordapp.com/api/webhooks/704785160436187188/TMVdsEev-i-0xcjpoO0QYJNeONm4zv7ah7pK-CnyjO7jT9aPiWth-YIUbwdVt06B5gK5"
local webhooklinkmoney = "https://discordapp.com/api/webhooks/704785160436187188/TMVdsEev-i-0xcjpoO0QYJNeONm4zv7ah7pK-CnyjO7jT9aPiWth-YIUbwdVt06B5gK5"
local webhooklinkinout = "https://discordapp.com/api/webhooks/704020007327236297/xwkqaw_fm975koM-FkXaQTjgzTgE4aJHm99M4bng1j9Iqw4DktAJqFpWv1b9p74GGGX3"
local webhooklinkcriminal = "https://discordapp.com/api/webhooks/704785160436187188/TMVdsEev-i-0xcjpoO0QYJNeONm4zv7ah7pK-CnyjO7jT9aPiWth-YIUbwdVt06B5gK5"
local webhooklinkchest = "https://discordapp.com/api/webhooks/704785160436187188/TMVdsEev-i-0xcjpoO0QYJNeONm4zv7ah7pK-CnyjO7jT9aPiWth-YIUbwdVt06B5gK5"
local webhooklinkthief = "https://discordapp.com/api/webhooks/704785160436187188/TMVdsEev-i-0xcjpoO0QYJNeONm4zv7ah7pK-CnyjO7jT9aPiWth-YIUbwdVt06B5gK5"
local webhooklinkexplosao = "https://discordapp.com/api/webhooks/704001586585665576/j-Hbkwg0lUB2yG9uPx3Mu845ATN3LlxGcCl9Wn-CTZes5VJ1j55CYT7c1hkSv_5mkE8V"

local webhooklinkgarmas = "https://discordapp.com/api/webhooks/720086869391704064/Dn80gMsnIxuSbypLFX6w-7zO1VIjNvV4ThkxFMKl_1Yti-AJD-N5oTXNqNnKlfH3Lsgg"

function attHora()
	Time.hora = tonumber(os.date("%H", os.time() + timezone * 60 * 60))
	if Time.hora >= 0 and Time.hora <= 9 then
		Time.hora = "0"..Time.hora
	end

	Time.min = tonumber(os.date("%M"))
	if Time.min >= 0 and Time.min <= 9 then
		Time.min = "0"..Time.min
	end

	Time.seg = tonumber(os.date("%S"))
	if Time.seg >= 0 and Time.seg <= 9 then
		Time.seg = "0"..Time.seg
	end

	Time.ano = tonumber(os.date("%Y"))
	Time.mes = tonumber(os.date("%m"))
	Time.dia = tonumber(os.date("%d"))
end

function log(file,info)
  file = io.open(file, "a")
  if file then
    file:write(""..info.."\n")
  end
  file:close()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        attHora()
    end
end)

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
local user_id = vRP.getUserId(source)
local ip = GetPlayerEndpoint(source)
	SendWebhookMessage(webhooklinkinout, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. name .." [user_id ".. user_id .."] conectou/entrou. IP:" ..ip.. "```")
end)

AddEventHandler("vRP:playerRejoin",function(user_id,source,name)
	local user_id = vRP.getUserId(source)
	SendWebhookMessage(webhooklinkinout, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. name .." [user_id ".. user_id .."] reconectou/reentrou.```")
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	local user_id = vRP.getUserId(source)
	SendWebhookMessage(webhooklinkinout, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(source) .." [user_id ".. user_id .."] saiu.```")
	SendWebhookMessage(webhooklinkgarmas, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(source) .." [user_id ".. user_id .."] saiu.```")

end)

 AddEventHandler('chatMessage', function(source, name, msg)
    local user_id = vRP.getUserId(source)
	SendWebhookMessage(webhooklinkchat, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. name.." [user_id ".. user_id .."]: "..tostring(msg)..".```")
end)

RegisterServerEvent('logplayerDied')
AddEventHandler('logplayerDied',function(killer,reason,weapon)
	local user_id = vRP.getUserId(source)

	if killer == "**Invalid**" or killer == source then
		SendWebhookMessage(webhooklinkdeath, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(source).." [user_id ".. user_id .."] se matou.```")
	elseif killer == nil then
		SendWebhookMessage(webhooklinkdeath, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(source).." [user_id ".. user_id .."] se matou.```")
	elseif killer == nil and reason == 3 and weapon == nil then
		SendWebhookMessage(webhooklinkdeath, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(source).." [user_id ".. user_id .."] está em coma.```")
	elseif killer ~= nil then
		if reason == 1 then
			local killer_id = vRP.getUserId({killer})
			if killer_id then
				SendWebhookMessage(webhooklinkdeath, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(killer).." [killer_id "..killer_id.."] matou ".. GetPlayerName(source) .."[user_id "..user_id.."] com "..weapon..".```")
			else
				SendWebhookMessage(webhooklinkdeath, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. killer .." [killer_id (missing value)] matou ".. GetPlayerName(source) .."[user_id "..user_id.."] com "..weapon..".```")
			end
		else
			SendWebhookMessage(webhooklinkdeath, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. killer .." [killer_id (missing value)] matou ".. GetPlayerName(source) .."[user_id "..user_id.."] com "..weapon..".```")
		end
	else
		SendWebhookMessage(webhooklinkdeath, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(source).." [user_id ".. user_id .."] morreu de forma desconhecida.```")
	end
end)

RegisterServerEvent('DMN:regLogChest')
AddEventHandler('DMN:regLogChest',function(msg)
	SendWebhookMessage(webhooklinkchest, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. msg .."```")
end)

RegisterServerEvent('DMN:regLog')
AddEventHandler('DMN:regLog',function(msg)
	SendWebhookMessage(webhooklinkserver, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. msg .."```")
end)

RegisterServerEvent('DMN:regLogThief')
AddEventHandler('DMN:regLogThief',function(msg)
	SendWebhookMessage(webhooklinkthief, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. msg .."```")
end)

RegisterServerEvent('DMN:regLogCriminal')
AddEventHandler('DMN:regLogCriminal',function(msg)
	SendWebhookMessage(webhooklinkcriminal, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. msg .."```")
end)

RegisterServerEvent('DMN:moneyLog')
AddEventHandler('DMN:moneyLog',function()
	local user_id = vRP.getUserId(source)
	local money = vRP.getMoney(user_id)
	local bmoney = vRP.getBankMoney(user_id)
	SendWebhookMessage(webhooklinkmoney, "```["..Time.hora..":"..Time.min..":"..Time.seg.."] ".. GetPlayerName(source).." [user_id ".. user_id .." | CARTEIRA: $ ".. money .." | BANCO: $ ".. bmoney .."```")
end)

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


AddEventHandler('explosionEvent', function(source, ev)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
	local idExplosao = ev.explosionType	
	local ownerId = ev.ownerNetId
	if user_id ~= nil then
	if (idExplosao == 29 and ownerId ~= 0) then
	SendWebhookMessage(webhooklinkexplosao, "**Explosões** ```" .. "ID: " .. user_id .. " Nome: " .. name .. "\nServidor: " .. GetConvar('sv_name', 'ND') .. "\nData: " .. os.date("%H:%M:%S %d/%m/%Y") .. "```")
	end
  CancelEvent(explosionEvent)
  end
end)

