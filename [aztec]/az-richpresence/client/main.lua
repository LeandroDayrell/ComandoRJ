local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vAZserver = Tunnel.getInterface("az-richpresence")
vAZ = {}
Tunnel.bindInterface("az-richpresence", vAZ)
--[[
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
]]


Citizen.CreateThread(function()
    while true do
        SetDiscordAppId(697128175225798658)
        SetDiscordRichPresenceAsset('logo')
        SetRichPresence("discord.gg/VUmdPh5")


        SetDiscordRichPresenceAssetText('discord.gg/VUmdPh5')
        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/VUmdPh5" )
        SetDiscordRichPresenceAction(1, "Instagram", "https://www.instagram.com/comandorj/" )
        SetDiscordRichPresenceAction(1, "Site", "https://comandorj.com.br/" )
        Citizen.Wait(10000)
    end
end)