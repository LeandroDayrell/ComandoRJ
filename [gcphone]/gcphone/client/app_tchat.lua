RegisterNetEvent("gcPhone:tchat_receive1333")
AddEventHandler("gcPhone:tchat_receive1333",function(message)
	SendNUIMessage({ event = 'tchat_receive', message = message })
end)

RegisterNetEvent("gcPhone:tchat_channel1333")
AddEventHandler("gcPhone:tchat_channel1333",function(channel,messages)
	SendNUIMessage({ event = 'tchat_channel', messages = messages })
end)

RegisterNUICallback('tchat_addMessage',function(data,cb)
	TriggerServerEvent('gcPhone:tchat_addMessage1333',data.channel,data.message)
end)

RegisterNUICallback('tchat_getChannel',function(data,cb)
	TriggerServerEvent('gcPhone:tchat_channel1333',data.channel)
end)