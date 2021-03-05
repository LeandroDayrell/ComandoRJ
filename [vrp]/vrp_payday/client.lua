local minute = 30

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000) 
		minute = minute - 1
		if minute == 0  then
			minute = 30
			TriggerServerEvent('crj:lot')
		end
	end
end)