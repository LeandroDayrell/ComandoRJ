function tvRP.getNearestVehicles(radius)
	local r = {}
	local px,py,pz = tvRP.getPosition()

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local x,y,z = table.unpack(GetEntityCoords(veh,true))
		local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end

function tvRP.getNearestVehicle(radius)
	local veh
	local vehs = tvRP.getNearestVehicles(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh 
end

function tvRP.getPlateVehicle(vehicle, radius)
	if radius == nil then radius = 2 end
	if vehicle == nil then vehicle = tvRP.getNearestVehicle(radius) end
	return GetVehicleNumberPlateText(vehicle)
end

function tvRP.getNetVehicle(vehicle, radius)
	if vehicle == nil then
		vehicle = tvRP.getNearestVehicle(radius)
		if radius == nil then radius = 2 end
	end
	return VehToNet(vehicle)
end
  
function tvRP.getStatusLockVehicle(vehicle, radius)
	if radius == nil then radius = 2 end
	if vehicle == nil then vehicle = tvRP.getNearestVehicle(radius) end
	return GetVehicleDoorLockStatus(vehicle)
end
  
function tvRP.getModelVehicle(vehicle, radius)
	  if radius == nil then radius = 2 end
	  if vehicle == nil then vehicle = tvRP.getNearestVehicle(radius) end
	  return string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
end
  
function tvRP.getHashVehicle(vehicle, radius)
	  if radius == nil then radius = 2 end
	  if vehicle == nil then vehicle = tvRP.getNearestVehicle(radius) end
	  return GetEntityModel(vehicle)
end
  
function tvRP.getVehicleAtPosition(x,y,z)
	x = x+0.0001
	y = y+0.0001
	z = z+0.0001
	local ray = CastRayPointToPoint(x,y,z,x,y,z+4,10,PlayerPedId(),0)
	local a, b, c, d, ent = GetRaycastResult(ray)
	return ent
end

function tvRP.ejectVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		local veh = GetVehiclePedIsIn(ped,false)
		TaskLeaveVehicle(ped,veh,4160)
	end
end

function tvRP.isInVehicle()
	return IsPedSittingInAnyVehicle(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELHASH
-----------------------------------------------------------------------------------------------------------------------------------------
local vehList = {}

RegisterNetEvent("vrp:setVehicleList")
AddEventHandler("vrp:setVehicleList", function(data)
	vehList = data
end)

function tvRP.ModelName(radius)
	local veh = tvRP.getNearestVehicle(radius)
	if IsEntityAVehicle(veh) then
		local lock = GetVehicleDoorLockStatus(veh) >= 2
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		for k,v in pairs(vehList) do
			if v.hash == GetEntityModel(veh) then				
				if v.name then
					return GetVehicleNumberPlateText(veh),v.name,VehToNet(veh),parseInt(v.price),v.banido,lock,GetDisplayNameFromVehicleModel(v.name),GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
				end
			end
		end
	end
end

function tvRP.ModelName2()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		for k,v in pairs(vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					return GetVehicleNumberPlateText(veh),v.name,parseInt(v.price),v.banido,VehToNet(veh),veh
				end
			end
		end
	end
end