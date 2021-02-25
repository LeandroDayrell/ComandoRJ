local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","crj_dominacao")

src = {}
Tunnel.bindInterface("crj_dominacao",src)
vSERVER = Tunnel.getInterface("crj_dominacao")

-- Credits By Fume
-- My Comunity Discord ESX: discord.me/sagresroleplayesxpt
-- My Comunity Discord VRP: discord.me/sagresroleplaypt
-- My Discord: Fume#0581

local dominacaoUp = false
local bairro = ""
local blipDominacao = nil
ESX = nil

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject551', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_dominacao:currentlyRobbing551')
AddEventHandler('esx_dominacao:currentlyRobbing551', function(currentBairro)
	dominacaoUp, bairro = true, currentBairro
end)

RegisterNetEvent('esx_dominacao:killBlip551')
AddEventHandler('esx_dominacao:killBlip551', function()
	RemoveBlip(blipDominacao)
end)

RegisterNetEvent('esx_dominacao:setBlip551')
AddEventHandler('esx_dominacao:setBlip551', function(position)
	blipDominacao = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipDominacao, 161)
	SetBlipScale(blipDominacao, 2.0)
	SetBlipColour(blipDominacao, 1)

	PulseBlip(blipDominacao)
end)

RegisterNetEvent('esx_dominacao:tooFar551')
AddEventHandler('esx_dominacao:tooFar551', function()
	dominacaoUp, bairro = false, ''
	ESX.ShowNotification(_U('dominacao_cancelada'))
end)

RegisterNetEvent('esx_dominacao:dominacaoComplete551')
AddEventHandler('esx_dominacao:dominacaoComplete551', function(award)
	dominacaoUp, bairro = false, ''
	vRP.ShowNotification(_U('dominacao_completa', award))
end)

RegisterNetEvent('esx_dominacao:startTimer551')
AddEventHandler('esx_dominacao:startTimer551', function()
	local timer = Bairros[bairro].secondsRemaining

	Citizen.CreateThread(function()
		while timer > 0 and dominacaoUp do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while dominacaoUp do
			Citizen.Wait(0)
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, _U('tempo_para_a_dominacao_acabar', timer), 255, 255, 255, 255)
		end
	end)
end)

Citizen.CreateThread(function()
	for k,v in pairs(Bairros) do
		local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
		SetBlipSprite(blip, 437)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('dominacao_de_bairros'))
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

		for k,v in pairs(Bairros) do
			local bairroPos = v.position
			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, bairroPos.x, bairroPos.y, bairroPos.z)

			if distance < Config.Marker.DrawDistance then
				if not dominacaoUp then
					DrawMarker(Config.Marker.Type, bairroPos.x, bairroPos.y, bairroPos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, false, false, false, false)

					if distance < 0.5 then
						ESX.ShowHelpNotification(_U('pressiona_para_dominar', v.nameOfBairro))

						if IsControlJustReleased(0, Keys['E']) then
							if IsPedArmed(PlayerPedId(), 4) then
								TriggerServerEvent('esx_dominacao:dominacaoStarted551', k)
							else
								vRP.ShowNotification(_U('nao_es_uma_ameaca'))
							end
						end
					end
				end
			end
		end

		if dominacaoUp then
			local bairroPos = Bairros[bairro].position
			if Vdist(playerPos.x, playerPos.y, playerPos.z, bairroPos.x, bairroPos.y, bairroPos.z) > Config.MaxDistance then
				TriggerServerEvent('esx_dominacao:tooFar551', bairro)
			end
		end
	end
end)
