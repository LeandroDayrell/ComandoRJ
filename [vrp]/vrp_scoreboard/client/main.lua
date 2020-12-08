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

local idVisable = true

Citizen.CreateThread(function()

	Citizen.Wait(2000)
	RegisterNetEvent('vrp_scoreboard:getConnectedPlayers')
	AddEventHandler('vrp_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)



Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',

		maxPlayers = GetConvarInt('sv_maxclients', 1024),
		uptime = 'unknown',
		playTime = '00h 00m'
	})
end)

RegisterNetEvent('vrp_scoreboard:updateConnectedPlayers')
AddEventHandler('vrp_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('vrp_scoreboard:updatePing')
AddEventHandler('vrp_scoreboard:updatePing', function(connectedPlayers)
	SendNUIMessage({
		action  = 'updatePing',
		players = connectedPlayers
	})
end)

RegisterNetEvent('vrp_scoreboard:toggleID')
AddEventHandler('vrp_scoreboard:toggleID', function(state)
	if state then
		idVisable = state
	else
		idVisable = not idVisable
	end

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end)

RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = uptime
	})
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local bopee, police, ems, mechanic, pcc, cv, tcp, ada, yakuza, motoclub, milicia, cosanostra, tca, dk, players = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	for k,v in pairs(connectedPlayers) do

		if num == 1 then
			table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 2
		elseif num == 2 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td></tr>'):format(v.name, v.id, v.ping))
			num = 1
		elseif num == 3 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td></tr>'):format(v.name, v.id, v.ping))
			num = 1
		end

		players = players + 1

        if (v.job == '[PRF] - Policial Rodoviario') then
			bopee = bopee + 1
		elseif (v.job == 'Policia' or v.job == '[PMRJ] - Recruta' or v.job == '[PMRJ] - Soldado' or v.job == '[PMRJ] - Cabo' or v.job == '[PMRJ] - 1º Sargento' or v.job == '[PMRJ] - 2º Sargento' or v.job == '[PMRJ] - 3º Sargento' or v.job == '[PMRJ] - Subtenente' or v.job == '[PMRJ] - 2º Tenente' or v.job == '[PMRJ] - 1º Tenente' or v.job == '[PMRJ] - Capitão' or v.job == '[PMRJ] - Major' or v.job == '[PMRJ] - Tenente Coronel' or v.job == '[PMRJ] - Coronel') then
			police = police + 1
		elseif (v.job == '[CHEFE] - SAMU' or v.job == '[COORDENADOR] - SAMU' or v.job == '[MÉDICO(A)] - SAMU' or v.job == '[ENFERMEIRO] - SAMU' or v.job == '[TÉCNICO DE ENFERMAGEM] - SAMU' or v.job == '[SOCORRISTA] - SAMU') then
			ems = ems + 1
		elseif (v.job == 'Bennys') then
			mechanic = mechanic + 1
		elseif (v.job == '[P.C.C] - Líder' or v.job == '[P.C.C] - Gerente' or v.job == '[P.C.C] - Membro' ) then
			pcc = pcc + 1
		elseif (v.job == '[C.V] - Lider' or v.job == '[C.V] - Gerente' or v.job == '[C.V] - Membro' or v.job == 'VAPOR-CV') then
			cv = cv + 1
		elseif (v.job == '[T.C.P] - Lider' or v.job == '[T.C.P] - Gerente' or v.job == '[T.C.P] - Membro' ) then
			tcp = tcp + 1
		elseif (v.job == '[A.D.A] - Lider' or v.job == '[A.D.A] - Gerente' or v.job == '[A.D.A] - Membro') then
			ada = ada + 1
		elseif (v.job == '[YAKUZA] - Lider' or v.job == '[YAKUZA] - Gerente' or v.job == '[YAKUZA] - Membro') then
			yakuza = yakuza + 1
		elseif (v.job == '[MOTOCLUB] - Lider' or v.job == '[MOTOCLUB] - Gerente' or v.job == '[MOTOCLUB] - Membro' ) then
			motoclub = motoclub + 1
		elseif (v.job == '[Milicia] - Lider' or v.job == '[Milicia] - Gerente' or v.job == '[Milicia] - Membro' ) then
			milicia = milicia + 1
		elseif (v.job == '[MAFIA] - Lider' or v.job == '[MAFIA] - Gerente' or v.job == '[MAFIA] - Membro') then
			cosanostra = cosanostra + 1
		elseif (v.job == '[T.C.A] - Lider' or v.job == '[T.C.A] - Gerente' or v.job == '[T.C.A] - Membro') then
			tca = tca + 1
		elseif (v.job == '[D.K] - Lider' or v.job == '[D.K] - Gerente' or v.job == '[D.K] - Membro') then
			dk = dk + 1
		end
	end

	if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	end

	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {bopee = bopee, police = police, ems = ems, mechanic = mechanic, pcc = pcc, cv = cv, tcp = tcp, ada = ada, yakuza = yakuza, motoclub = motoclub, milicia = milicia, cosanostra = cosanostra, tca = tca, dk = dk, player_count = players}
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['DELETE']) and IsInputDisabled(0) then
			TriggerServerEvent("vrp_scoreboard:requestOpenScoreboard")
			Citizen.Wait(200)

		-- D-pad up on controllers works, too!
		elseif IsControlJustReleased(0, 178) and not IsInputDisabled(0) then
			TriggerServerEvent("vrp_scoreboard:requestOpenScoreboard")
			Citizen.Wait(200)
		end
	end
end)

RegisterNetEvent('vrp_scoreboard:doRequestScoreboard')
AddEventHandler('vrp_scoreboard:doRequestScoreboard', function(validate)
	if validate then
		ToggleScoreBoard()
	end
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end

Citizen.CreateThread(function()
	local playMinute, playHour = 0, 0

	while true do
		Citizen.Wait(1000 * 60) -- every minute
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end

		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = string.format("%02dh %02dm", playHour, playMinute)
		})
	end
end)
