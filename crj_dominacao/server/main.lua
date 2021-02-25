local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- Credits By Fume
-- My Comunity Discord ESX: discord.me/sagresroleplayesxpt
-- My Comunity Discord VRP: discord.me/sagresroleplaypt
-- My Discord: Fume#0581

local dominacao = false
local dominacoes = {}
ESX = nil

TriggerEvent('esx:getSharedObject551', function(obj) ESX = obj end)

RegisterServerEvent('esx_dominacao:tooFar')
AddEventHandler('esx_dominacao:tooFar', function(currentBairro)
	local _source = source
	local xPlayers = vRP.getUserId(source)
	dominacao = false

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'unicorn' or xPlayer.job.name == "mafia" or xPlayer.job.name == "motoclub" or xPlayer.job.name == "gang" or xPlayer.job.name == "ammunation" or xPlayer.job.name == "cartel" then
			TriggerClientEvent('esx:showNotification551', xPlayers[i], _U('dominacao_cancelada_em', Bairros[currentBairro].nameOfBairro))
			TriggerClientEvent('esx_dominacao:killBlip551', xPlayers[i])
		end
	end

	if dominacoes[_source] then
		TriggerClientEvent('esx_dominacao:tooFar551', _source)
		dominacoes[_source] = nil
		TriggerClientEvent('esx:showNotification551', _source, _U('dominacao_cancelada_em', Bairros[currentBairro].nameOfBairro))
	end
end)

RegisterServerEvent('esx_dominacao:dominacao1Started551')
AddEventHandler('esx_dominacao:dominacao1Started551', function(currentBairro)
	local _source  = source
	local xPlayer  = vRP.GetPlayerFromId(_source)
	local xPlayers = vRP.GetPlayers()

	if Bairros[currentBairro] then
		local bairro = Bairros[currentBairro]

		if (os.time() - bairro.lastDominada) < Config.TimerBeforeNewDominacao and bairro.lastDominada ~= 0 then
			TriggerClientEvent('esx:showNotification', _source, _U('recentemente_dominada', Config.TimerBeforeNewDominacao - (os.time() - bairro.lastRobbed)))
			return
		end

		local cops = 0
		for i=1, #xPlayers, 1 do
			local xPlayer = vRP.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'unicorn' or xPlayer.job.name == "mafia" or xPlayer.job.name == "motoclub" or xPlayer.job.name == "gang" or xPlayer.job.name == "ammunation" or xPlayer.job.name == "cartel" then
				cops = cops + 1
			end
		end

		if not dominacao then
			if cops >= Config.GangNumberRequired then
				dominacao = true

				for i=1, #xPlayers, 1 do
					local xPlayer = vRP.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'unicorn' or xPlayer.job.name == "mafia" or xPlayer.job.name == "motoclub" or xPlayer.job.name == "gang" or xPlayer.job.name == "ammunation" or xPlayer.job.name == "cartel" then
						TriggerClientEvent('esx:showNotification551', xPlayers[i], _U('dominacao_em_progresso_em', bairro.nameOfBairro))
						TriggerClientEvent('esx_dominacao:setBlip551', xPlayers[i], Bairros[currentBairro].position)
					end
				end

				TriggerClientEvent('esx:showNotification551', _source, _U('comecaste_a_dominar', bairro.nameOfBairro))
				TriggerClientEvent('esx:showNotification551', _source, _U('alarme_foi_disparado'))
				
				TriggerClientEvent('esx_dominacao:currentlyDominando551', _source, currentBairro)
				TriggerClientEvent('esx_dominacao:startTimer551', _source)
				
				Bairros[currentBairro].lastDominada = os.time()
				dominacoes[_source] = currentBairro

				SetTimeout(bairro.secondsRemaining * 1000, function()
					if dominacoes[_source] then
						dominacao = false
						if xPlayer then
							TriggerClientEvent('esx_dominacao:dominacao1Complete551', _source, bairro.reward)

							if Config.GiveBlackMoney then
								xPlayer.addAccountMoney('black_money', bairro.reward)
							else
								xPlayer.addMoney(bairro.reward)
							end
							
							local xPlayers, xPlayer = ESX.GetPlayers(), nil
							for i=1, #xPlayers, 1 do
								xPlayer = ESX.GetPlayerFromId(xPlayers[i])

								if xPlayer.job.name == 'unicorn' or xPlayer.job.name == "mafia" or xPlayer.job.name == "motoclub" or xPlayer.job.name == "gang" or xPlayer.job.name == "ammunation" or xPlayer.job.name == "cartel" then
									TriggerClientEvent('esx:showNotification551', xPlayers[i], _U('dominacao_bem_sucedida_em', bairro.nameOfBairro))
									TriggerClientEvent('esx_dominacao:killBlip551', xPlayers[i])
								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('esx:showNotification551', _source, _U('minimo_de_gang', Config.GangNumberRequired))
			end
		else
			TriggerClientEvent('esx:showNotification551', _source, _U('dominacao_a_bairro_em_processo'))
		end
	end
end)
