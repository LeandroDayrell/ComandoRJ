local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vAZserver = Tunnel.getInterface("az-richpresence")
vAZ = {}
Tunnel.bindInterface("az-richpresence", vAZ)

Citizen.CreateThread(function()
    while true do
        SetDiscordAppId(697128175225798658)
        SetDiscordRichPresenceAsset('logo')
        SetDiscordRichPresenceAssetText('discord.gg/VUmdPh5')
        SetDiscordRichPresenceAssetSmall('hqrp512')
		SetDiscordRichPresenceAssetSmallText('discord.gg/VUmdPh5')
		SetRichPresence("Jogadores Na Cidade: ".. vAZserver.PlayerCount())
        Citizen.Wait(10000)
    end
end)