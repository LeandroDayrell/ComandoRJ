local minute = 45

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(45000) 
		minute = minute - 1
		if minute == 0  then
			minute = 45
			TriggerServerEvent('crj:lot')
		end
	end
end)