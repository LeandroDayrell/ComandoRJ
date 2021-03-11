local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local userlogin = {}
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		local data = vRP.getUData(user_id,"vRP:spawnController")
		local sdata = json.decode(data) or 0
		if sdata then
			Citizen.Wait(1000)
			processSpawnController(source,sdata,user_id)
		end
	end
end)

function processSpawnController(source,statusSent,user_id)
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,false)
		else
			doSpawnPlayer(source,user_id,true)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		TriggerClientEvent("creative-character:characterCreate",source)
	end
end

RegisterServerEvent("creative-character:finishedCharacter")
AddEventHandler("creative-character:finishedCharacter",function(characterNome,characterSobrenome,characterAge,currentCharacterMode)
	
	if(string.find(characterNome, "onload") or string.find(characterSobrenome,"onload"))then        
		local user_id = vRP.getUserId(source)    
		vRP.setBanned(user_id, true)        
		DropPlayer(source, "PORRA, TU E BURRO EM IRMAO! KKKKKKKKKKKKK")
		local webhook = "https://discord.com/api/webhooks/819022533885165568/f5KUP9sznUoWYY0QupDFlmBjLImYeulirJ-obReAwobsgjY42BE7481DCxhGNPOlV1X6"
		local message = "BUGANDO NUI: "..user_id
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		return
	  end
	
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode",json.encode(currentCharacterMode))
		vRP.setUData(user_id,"vRP:spawnController",json.encode(2))
		--vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = characterSobrenome, name = characterNome, age = characterAge })
		doSpawnPlayer(source,user_id,true)
		forceUpdateName(user_id,characterNome,characterSobrenome,characterAge)
	end
end)

function forceUpdateName(user_id,characterNome,characterSobrenome,characterAge)
	local user_id = user_id
	local characterNome = characterNome
	local characterSobrenome = characterSobrenome
	local characterAge = characterAge

	vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = characterSobrenome, name = characterNome, age = characterAge })
	if characterNome == "Individuo" then
		return
	end
	
	SetTimeout(10000,function()
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if identity.name == "Individuo" then
				forceUpdateName(user_id,characterNome,characterSobrenome,characterAge)
			end
		else
			forceUpdateName(user_id,characterNome,characterSobrenome,characterAge)
		end
	end)
end
function doSpawnPlayer(source,user_id,firstspawn)
	TriggerClientEvent("creative-character:normalSpawn",source,firstspawn)
	TriggerEvent("creative-barbershop:init",user_id)
	SetTimeout(120000,function()
        TriggerClientEvent("checkcam",source,true)
    end)
end