local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vAZserver = Tunnel.getInterface('az-dynasty8')
vAZ = {}
Tunnel.bindInterface('az-dynasty8', vAZ)

local permission = false
local homes = {}

RegisterNUICallback('NUIFocusOff', function()	
	SetTimecycleModifier('default')
	SetNuiFocus(false, false)
	SendNUIMessage({action = "close"})
	Citizen.Wait(1000)
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)

RegisterNUICallback('GetHomesTypes', function(data, cb)
	cb(vAZserver.GetHomeTypes())
end)

RegisterNUICallback('GetHomesList', function(data, cb)
	local list = vAZserver.GetHomesForSales()
	for id,home in pairs(list) do
		home.street = GetStreetNameFromHashKey(GetStreetNameAtCoord(home.entry.x, home.entry.y, home.entry.z))
	end
	cb(list)
end)

RegisterNUICallback('VisitHome', function(data, cb)	
	vAZserver.VisitHome(data)
end)

RegisterNUICallback('BuyHome', function(data, cb)
	vAZserver.PurchaseHome(data)
end)

RegisterNUICallback('GPSHome', function(data, cb)
	vAZserver.GPSHome(data)
end)

RegisterNUICallback('PriceHome', function(data, cb)
	cb(vAZserver.PriceHome(data))
end)

vAZ.ScreenFadeTeleport = function(hide, wait, show, x, y, z)
	DoScreenFadeOut(hide)
	while not IsScreenFadedOut() do
		Citizen.Wait(10)
	end
	SetEntityCoords(PlayerPedId(), x+0.0001, y+0.0001, z+0.0001, 1,0,0,1)
	Citizen.Wait(wait)
	DoScreenFadeIn(show)
end

RegisterNetEvent('az-dynasty8:item')
AddEventHandler('az-dynasty8:item', function()
	local permission = vAZserver.CheckPermission('dyn.permissao')
	if permission and not vAZserver.inService() then
		TriggerEvent('az-notify:default', 'Dynasty8', 'Você precisa estar em serviço para acessar o sistema!')
		return
	end
	if vAZserver.CheckItem() then
		vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_b", "prop_cs_tablet", 49, 28422)
		Citizen.Wait(2000)
		SetTimecycleModifier('hud_def_blur')
		SetNuiFocus(true, true)
		SendNUIMessage({action = "open", salesman = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId())), permission = permission})
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(5)
		local ply = PlayerPedId()
		local plyCoords = GetEntityCoords(ply)
		local distance = GetDistanceBetweenCoords(plyCoords, -128.48, -642.02, 168.84, true)
		if distance < 5 then
			DrawMarker(23, -128.48, -642.02, 168.84-0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 105, 23, 199, 20, 0, 0, 0, 0)
			if distance <= 1.0 then
				if IsControlJustPressed(0, 38) then
					if vAZserver.inService() then
						vAZserver.StopWork()
					elseif not vAZserver.inService() then							
						vAZserver.StartWork()
					end
				end
			end
		end 
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(5)      
		local ply = PlayerPedId()  
		local plyCoords = GetEntityCoords(ply)
		local distance = GetDistanceBetweenCoords(plyCoords, -125.63, -638.89, 168.82, true)
		if distance < 5 then
			DrawMarker(23, -125.63, -638.89, 168.82-0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 105, 23, 199, 20, 0, 0, 0, 0)
			if distance <= 1.0 then
				if IsControlJustPressed(0, 38) then
					if vAZserver.CheckPermission('dyn.permissao') then
						vAZserver.GiveTabletJob()
					end
				end
			end
		end 
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(5)
		if permission then		
			local ply = PlayerPedId()  
			local plyCoords = GetEntityCoords(ply)
			if #homes > 0 then
				for id,home in pairs(homes) do
					local distance = GetDistanceBetweenCoords(plyCoords, home.entry.x, home.entry.y, home.entry.z, true)
					if distance < 30 then
						DrawMarker(28,home.entry.x,home.entry.y,home.entry.z-0.80,0,0,0,0,0,0,0.1,0.1,0.1,253,210,68,68,1,0,0,0)
						DrawMarker(23,home.entry.x,home.entry.y,home.entry.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,253,210,68,68,0,0,0,0)
						if distance < 2.0 then
							vAZ.DrawText3D(home.entry.x, home.entry.y, home.entry.z, home.nome)
						end
					end
				end
			end
		else
			Citizen.Wait(60000)
		end	
    end
end)

Citizen.CreateThread(function()
	while true do
		if not permission then
			permission = vAZserver.CheckPermission('dyn.permissao')
			Citizen.Wait(15000)
		else
			Citizen.Wait(60000)
		end		
    end
end)

vAZ.SetHomes = function(data) homes = data end

vAZ.RemoveHomes = function(hname)
	for name,home in pairs(homes) do
		if name == hname then
			table.remove(homes, name)
		end
	end
end

vAZ.DrawText3D = function(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end