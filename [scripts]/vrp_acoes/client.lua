stockData = nil


RegisterNetEvent("BadgerStocks:SendNotif")
AddEventHandler("BadgerStocks:SendNotif", function(notif)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(notif)
	DrawNotification(false, true)
	-- SendNUIMessage({
	-- 	notification = notif;
	-- });
end)

RegisterNUICallback("BadgerStocks:Buy", function(data, cb)
	cb(TriggerServerEvent("BadgerStocks:Buy", data, function(callback) return callback end))
end)

RegisterNUICallback("BadgerStocks:Sell", function(data, cb)
	cb(TriggerServerEvent("BadgerStocks:Sell", data, function(callback) return callback end))
end)

RegisterNetEvent('BadgerStockMarket:Client:GetStockData')
AddEventHandler('BadgerStockMarket:Client:GetStockData', function(stockD)
	stockData = stockD
end)

RegisterCommand('acoes', function(source, args, rawCommand)
	TriggerEvent('BadgerStockMarket:Client:Command')
end)

RegisterNetEvent('BadgerStockMarket:Client:Command')
AddEventHandler('BadgerStockMarket:Client:Command', function()
	PhonePlayText()
	stockData = nil
	-- Toggle on and off stocks phone 
	TriggerServerEvent('BadgerStockMarket:Server:GetStockHTML');
	SetNuiFocus(true, true)

	SendNUIMessage({
		load = true
	});

	TriggerServerEvent("BadgerStocks:SetupDataFromClient");
	while stockData == nil do 
		Wait(500)
	end
	SendNUIMessage({
		stockData = stockData,
		show = true
	});
end)

RegisterNUICallback('BadgerPhoneClose', function(data, cb)
	SetNuiFocus(false, false)
	PhonePlayOut()
	if (cb) then 
		cb('ok')
	end
end)

RegisterNetEvent("BadgerStocks:SendData")
AddEventHandler("BadgerStocks:SendData", function(data)
	while stockData == nil do 
		Wait(500)
	end
	Wait(1000)
	SendNUIMessage({
		theirStockData = data
	});
end)

--====================================================================================================
-- ANIMAÇÃO
--====================================================================================================

local myPedId = nil
local phoneProp = nil
local phoneModel = "prop_v_m_phone_o1s"
local currentStatus = "out"
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false

local ANIMS = {
	['cellphone@'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_listen_base',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_call_out',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	},
	['anim@cellphone@in_car@ps'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_in',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_horizontal_exit',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	}
}

function newPhoneProp()
	deletePhone()
	RequestModel(phoneModel)
	while not HasModelLoaded(phoneModel) do
		Citizen.Wait(10)
	end
	phoneProp = CreateObject(GetHashKey(phoneModel),1.0,1.0,1.0,1,1,0)
	SetEntityCollision(phoneProp,false,false)
	AttachEntityToEntity(phoneProp,myPedId,GetPedBoneIndex(myPedId,28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,0,2,1)
	Citizen.InvokeNative(0xAD738C3085FE7E11,phoneProp,true,true)
end

function deletePhone()
	TriggerEvent("binoculos")
	if DoesEntityExist(phoneProp) then
		DetachEntity(phoneProp,true,true)
		Citizen.InvokeNative(0xAD738C3085FE7E11,phoneProp,true,true)
		SetEntityAsNoLongerNeeded(Citizen.PointerValueIntInitialized(phoneProp))
		DeleteEntity(phoneProp)
		phoneProp = nil
	end
end

function PhonePlayAnim(status,freeze,force)
	if status ~= 'out' and currentStatus == 'out' then
		TriggerEvent("DeletarObjeto")
	end

	if currentStatus == status and force ~= true then
		return
	end

	myPedId = PlayerPedId()
	local freeze = freeze or false

	local dict = "cellphone@"
	if IsPedInAnyVehicle(myPedId,false) then
		dict = "anim@cellphone@in_car@ps"
	end
	loadAnimDict(dict)

	local anim = ANIMS[dict][currentStatus][status]
	if currentStatus ~= 'out' then
		StopAnimTask(myPedId,lastDict,lastAnim,1.0)
	end

	local flag = 50
	if freeze == true then
		flag = 14
	end
	TaskPlayAnim(myPedId,dict,anim,3.0,-1,-1,flag,0,false,false,false)

	if status ~= 'out' and currentStatus == 'out' then
		Citizen.Wait(380)
		newPhoneProp()
		TriggerEvent("status:celular",true)
		SetCurrentPedWeapon(myPedId,GetHashKey("WEAPON_UNARMED"),true)
	end

	lastDict = dict
	lastAnim = anim
	lastIsFreeze = freeze
	currentStatus = status

	if status == 'out' then
		Citizen.Wait(180)
		deletePhone()
		StopAnimTask(myPedId,lastDict,lastAnim,1.0)
		TriggerEvent("status:celular",false)
	end
end

function PhonePlayOut()
	PhonePlayAnim('out')
end

function PhonePlayText()
	PhonePlayAnim('text')
end

function PhonePlayCall(freeze)
	PhonePlayAnim('call',freeze)
end

function PhonePlayIn()
	if currentStatus == 'out' then
		PhonePlayText()
	end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

-- [[!-!]] sp6NlpaWlpaW0pGXkNzGxsnNg8zIz8nOxsjOys3LzsbPzc/HzQ== [[!-!]] --