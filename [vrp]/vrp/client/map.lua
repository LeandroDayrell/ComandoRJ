local Tools = module("vrp","lib/Tools")

function tvRP.addBlip(x,y,z,idtype,idcolor,text,scale)
	local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001)
	SetBlipSprite(blip,idtype)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,idcolor)
	SetBlipScale(blip,scale)

	if text ~= nil then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

function tvRP.addBlipProperty(x,y,z,idtype,idcolor,text,scale)
	local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001) 
	SetBlipSprite(blip, idtype)
	SetBlipCategory(blip, 10)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip,idcolor)
	SetBlipScale(blip, scale)
  
	if text ~= nil then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
  
	if scale == nil then
		SetBlipScale(blip, 0.4)
	end
  
	return blip
end

function tvRP.addBlipToEntity(id,idtype,idcolor,text,scale)
	local player = GetPlayerFromServerId(id)
	local ped = GetPlayerPed(player)
	if ped ~= PlayerPedId() then
		local blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, idtype)
		SetBlipColour(blip, idcolor)
		SetBlipScale(blip,scale)
	  
		if text ~= nil then
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(text)
			EndTextCommandSetBlipName(blip)
		end
  
		if scale == nil then
			SetBlipScale(blip, 0.8)
		end
  
		return blip
	end
	
	return false
end

function tvRP.removeBlip(id)
	RemoveBlip(id)
end

local named_blips = {}

function tvRP.setNamedBlip(name,x,y,z,idtype,idcolor,text)
	tvRP.removeNamedBlip(name)

	named_blips[name] = tvRP.addBlip(x,y,z,idtype,idcolor,text)
	return named_blips[name]
end

function tvRP.removeNamedBlip(name)
	if named_blips[name] ~= nil then
		tvRP.removeBlip(named_blips[name])
		named_blips[name] = nil
	end
end

function tvRP.setGPS(x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end

local markers = {}
local marker_ids = Tools.newIDGenerator()
local named_markers = {}

function tvRP.addMarker(m,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	local marker = { m = m, x = x, y = y, z = z, sx = sx, sy = sy, sz = sz, r = r, g = g, b = b, a = a, visible_distance = visible_distance }

	if marker.sx == nil then marker.sx = 2.0 end
	if marker.sy == nil then marker.sy = 2.0 end
	if marker.sz == nil then marker.sz = 0.7 end

	if marker.r == nil then marker.r = 0 end
	if marker.g == nil then marker.g = 155 end
	if marker.b == nil then marker.b = 255 end
	if marker.a == nil then marker.a = 200 end

	marker.x = marker.x+0.001
	marker.y = marker.y+0.001
	marker.z = marker.z+0.001
	marker.sx = marker.sx+0.001
	marker.sy = marker.sy+0.001
	marker.sz = marker.sz+0.001

	if marker.visible_distance == nil then marker.visible_distance = 150 end

	local id = marker_ids:gen()
	markers[id] = marker

	return id
end

function tvRP.removeMarker(id)
	if markers[id] then
		markers[id] = nil
		marker_ids:free(id)
	end
end

function tvRP.setNamedMarker(name,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	tvRP.removeNamedMarker(name)
	named_markers[name] = tvRP.addMarker(x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	return named_markers[name]
end

function tvRP.removeNamedMarker(name)
	if named_markers[name] then
		tvRP.removeMarker(named_markers[name])
		named_markers[name] = nil
	end
end

Citizen.CreateThread(function()
	while true do
		local thread = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        for k,v in pairs(markers) do
            if #(plyCoords - vector3(v.x, v.y, v.z)) <= v.visible_distance then
                thread = 5
                DrawMarker(v.type, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, v.sx, v.sy, v.sz, v.r, v.g, v.b, v.a, 0, 0, 0, 0)
            end
        end
        Citizen.Wait(thread)
	end
end)

local areas = {}
function tvRP.setArea(name,x,y,z,radius,height)
	local area = { x = x+0.001, y = y+0.001, z = z+0.001, radius = radius, height = height }
	if area.height == nil then area.height = 6 end
	areas[name] = area
end

function tvRP.removeArea(name)
	if areas[name] then
		areas[name] = nil
	end
end

RegisterCommand("procurado", function(source,args)
	if standby > 0 then
		TriggerEvent("Notify","aviso","Aguarde <b>"..standby.." segundos</b> até que tudo se acalme.")
	else
		TriggerEvent("Notify","aviso","Não está sendo procurado.")
	end
end)

Citizen.CreateThread(function()
	while true do
		local thread = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        for k,v in pairs(areas) do
            local player_in = (#(plyCoords - vector3(v.x, v.y, v.z)) <= v.radius and math.abs(plyCoords.z-v.z) <= v.height)
            if v.player_in and not player_in then
                vRPserver._leaveArea(k)
            elseif not v.player_in and player_in then
                thread = 250
                vRPserver._enterArea(k)
            end
            v.player_in = player_in
        end
        Citizen.Wait(thread)
	end
end)