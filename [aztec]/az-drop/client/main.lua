local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vAZserver = Tunnel.getInterface('az-drop')
vAZ = {}
Tunnel.bindInterface('az-drop', vAZ)

local drops = {}

local cooldown = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for id,drop in pairs(drops) do
			local ply = PlayerPedId()
			local plyCoords = GetEntityCoords(ply)
			local distance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, drop.x, drop.y, drop.z, true)
			if distance < 5 then
				vAZ.DrawText3D(drop.x, drop.y, drop.z-0.5, "~g~[E]~w~  PEGAR~g~ "..drop.amount.."x ~w~"..string.upper(drop.name))
				if distance < 1.5 then
					if IsControlJustPressed(1, 38) and not cooldown then
						cooldown = true
						TriggerServerEvent('az-drop:takeItem', drop.id)
						SetTimeout(3000, function()
							cooldown = false
						end)
					end
				end
			end
		end
	end
end)

vAZ.createDrop = function(prop, item)
	if drops[tostring(prop)] == nil then
		drops[tostring(prop)] = item
	end
end

vAZ.removeDrop = function(prop)
	if drops[tostring(prop)] ~= nil then
		drops[tostring(prop)] = nil
	end
end

vAZ.UpdateListDrops = function(data)
	drops = data
end

vAZ.DrawText3D = function(x,y,z, text)
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