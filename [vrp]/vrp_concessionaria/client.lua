local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vCNserver = Tunnel.getInterface("vrp_concessionaria")
vCN = {}
Tunnel.bindInterface("vrp_concessionaria", vCN)

local veiculos = {}

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1124.7474365234,-1706.4991455078,4.4483933448792, true )
		print(distance)
		if distance <= 15 then
			DrawMarker(36,-1124.7474365234,-1706.4991455078,4.4483933448792,0,0,0,0,0,0,1.0,1.0,1.0,199,0,0,50,1,30,30,30)
			DrawMarker(27,-1124.7474365234,-1706.4991455078,4.4483933448792-0.98,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,0,30,30,30)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1124.7474365234,-1706.4991455078,4.4483933448792, true ) < 1 then
		 	if (IsControlJustReleased(1, 51)) then
            	TriggerServerEvent('get:carros')
		 	end
		end
	end
end)

RegisterNetEvent('send:carros')
AddEventHandler('send:carros', function(veiculos, identidade)
    IsInShopMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({
        show = true,
		veiculos = veiculos,
		identidade = identidade
	})
end)

RegisterNUICallback('comprar', function(data, cb)
	IsInShopMenu = false
	SetNuiFocus(false, false)
	local veh = data.id + 1
	if veh ~= nil then
		TriggerServerEvent('comprar:carro', veh)	
	end
end)

RegisterNUICallback('fechar', function()
    IsInShopMenu = false
    SetNuiFocus(false, false)
end)