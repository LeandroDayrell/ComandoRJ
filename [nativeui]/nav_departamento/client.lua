-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "utilidades-comprar-isca" then
		TriggerServerEvent("departamento-comprar","isca")
	elseif data == "utilidades-comprar-celular" then
		TriggerServerEvent("departamento-comprar","celular")
	elseif data == "utilidades-comprar-garrafa" then
		TriggerServerEvent("departamento-comprar","garrafavazia")
	elseif data == "utilidades-comprar-militec" then
		TriggerServerEvent("departamento-comprar","militec")
	elseif data == "utilidades-comprar-pneu" then
		TriggerServerEvent("departamento-comprar","pneu")
	elseif data == "utilidades-comprar-ferramentas" then
		TriggerServerEvent("departamento-comprar","ferramenta")
	elseif data == "alimentos-comprar-sandwich" then
		TriggerServerEvent("departamento-comprar","sandwich")
	elseif data == "utilidades-comprar-serra" then
		TriggerServerEvent("departamento-comprar","serra")
	elseif data == "utilidades-comprar-limonada" then
		TriggerServerEvent("departamento-comprar","limonada")	
	elseif data == "utilidades-comprar-walkietalkie" then
		TriggerServerEvent("departamento-comprar","walkietalkie")
	elseif data == "utilidades-vender-isca" then
		TriggerServerEvent("departamento-vender","isca")
	elseif data == "utilidades-vender-garrafa" then
		TriggerServerEvent("departamento-vender","garrafavazia")
	elseif data == "utilidades-vender-militec" then
		TriggerServerEvent("departamento-vender","militec")
	elseif data == "utilidades-comprar-repairkit" then
		TriggerServerEvent("departamento-comprar","repairkit")
	elseif data == "utilidades-vender-ferramentas" then
		TriggerServerEvent("departamento-vender","ferramenta")
	elseif data == "utilidades-vender-serra" then
		TriggerServerEvent("departamento-vender","serra")
	elseif data == "vestuario-comprar-mochila" then
		TriggerServerEvent("departamento-comprar","mochila")
	elseif data == "vestuario-comprar-roupas" then
		TriggerServerEvent("departamento-comprar","roupas")	
	elseif data == "vestuario-comprar-alianca" then
		TriggerServerEvent("departamento-comprar","alianca")
	elseif data == "vestuario-vender-mochila" then
		TriggerServerEvent("departamento-vender","mochila")
	elseif data == "vestuario-vender-alianca" then
		TriggerServerEvent("departamento-vender","alianca")
	elseif data == "bebidas-comprar-gin" then
		TriggerServerEvent("departamento-comprar","gin")
	elseif data == "bebidas-comprar-tequila" then
		TriggerServerEvent("departamento-comprar","tequila")
	elseif data == "alimentos-comprar-donut" then
		TriggerServerEvent("departamento-comprar","donut")
	elseif data == "alimentos-comprar-bread" then
		TriggerServerEvent("departamento-comprar","bread")
	elseif data == "alimentos-comprar-tacos" then
		TriggerServerEvent("departamento-comprar","tacos")
	elseif data == "bebidas-comprar-caipirinha" then
		TriggerServerEvent("departamento-comprar","caipirinha")
	elseif data == "alimentos-comprar-kebab" then
		TriggerServerEvent("departamento-comprar","kebab")
	elseif data == "bebidas-comprar-tacos" then
		TriggerServerEvent("departamento-comprar","tacos")
	elseif data == "bebidas-comprar-energetico" then
		TriggerServerEvent("departamento-comprar","energetico")
	elseif data == "bebidas-comprar-agua" then
		TriggerServerEvent("departamento-comprar","agua")
	elseif data == "bebidas-comprar-refri" then
		TriggerServerEvent("departamento-comprar","refri")
	elseif data == "bebidas-comprar-coffee" then
		TriggerServerEvent("departamento-comprar","coffee")
	elseif data == "alimentos-comprar-hamburguer" then
		TriggerServerEvent("departamento-comprar","hamburguer")
	elseif data == "bebidas-comprar-limonada" then
		TriggerServerEvent("departamento-comprar","limonada")
	elseif data == "bebidas-vender-cerveja" then
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
	{ -1222.78,-907.22,12.32 },
	{ -1074.1,-2735.98,0.82 }, -- aeroporto
	{ -1089.11,-834.63,23.04 }, -- DP
	{ 343.37,-597.72,43.13 } -- HP
	
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(5)
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 2.0 then
				DrawText3Ds(x,y,z+0.20,"~r~[E] ~w~Para Acessar a Loja")
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
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

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end