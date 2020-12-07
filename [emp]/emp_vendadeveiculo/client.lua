local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_vendadeveiculo")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local segundos = 0
local vendendo = false
local CoordenadaX = -10.84463596344
local CoordenadaY = -1083.6033935547
local CoordenadaZ = 26.672071456909
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function(source)
	while true do
		local nyoSleep = 500
		if not vendendo then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),CoordenadaX,CoordenadaY,CoordenadaZ,true)
			if distance <= 10 then
				nyoSleep = 1
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.96,0,0,0,0,0,0,5.0,5.0,0.5,211,176,72,20,0,0,0,0)
				DrawText3D(CoordenadaX, CoordenadaY, CoordenadaZ + 0.7, "PRESSIONE  ~b~E~w~  PARA VENDER O VEÍCULO")
				if distance <= 3.1 and IsControlJustPressed(0,38) and GetPedInVehicleSeat(vehicle,-1) == ped and emP.checkPermission() and emP.certeza() then
				local plate, nome, precoCarro, proibido, vnet, veiculo = vRP.ModelName2()
						if emP.checkVehicle() then
							vendendo = true
							segundos = 10
							FreezeEntityPosition(vehicle,true)
							repeat
								Citizen.Wait(10)
							until segundos == 0

							emP.removeVehicles(GetVehicleNumberPlateText(vehicle), VehToNet(vehicle))
							
							vendendo = false
						end -- if check veiculo
				end -- distancia 				
			end -- distancia
		end
		Citizen.Wait(nyoSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if vendendo then
			if segundos > 0 then
				DisableControlAction(0,75)
				drawTxt("AGUARDE ~y~"..segundos.." SEGUNDOS~w~,  ESTAMOS OLHANDO SE EXISTE ALGUM DEFEITO",4,0.5,0.85,0.50,255,255,255,180)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if vendendo then
			if segundos > 0 then
				segundos = segundos - 1
			end
		end
	end
end)

--- FORMARTAR NUMERO 

function formatarNumero(valor)
	local formatado = valor
	while true do
		-- O "." entre "%1" e "%2" é o separador
		formatado, n = string.gsub(formatado, "^(-?%d+)(%d%d%d)", "%1.%2")
		if (n == 0) then
			break
		end
	end
	return formatado
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a) --
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end


DrawText3D = function(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local scale = 0.45
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
		local factor = (string.len(text)) / 370
		DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.030, 66, 66, 66, 150)
	end
end ---