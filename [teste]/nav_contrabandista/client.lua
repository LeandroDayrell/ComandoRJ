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
	if data == "utilidades-comprar-algemas" then
		TriggerServerEvent("contrabandista-comprar","algemas")
	elseif data == "utilidades-comprar-capuz" then
		TriggerServerEvent("contrabandista-comprar","capuz")
	elseif data == "utilidades-comprar-lockpick" then
		TriggerServerEvent("contrabandista-comprar","lockpick")
	elseif data == "utilidades-comprar-masterpick" then
		TriggerServerEvent("contrabandista-comprar","masterpick")
	elseif data == "utilidades-comprar-pendrive" then
		TriggerServerEvent("contrabandista-comprar","pendrive")
	elseif data == "utilidades-comprar-rebite" then
		TriggerServerEvent("contrabandista-comprar","rebite")
	elseif data == "utilidades-comprar-bombaadesiva" then
		TriggerServerEvent("contrabandista-comprar","bombaadesiva")
	elseif data == "utilidades-comprar-walkietalkie" then
		TriggerServerEvent("contrabandista-comprar","walkietalkie")
		-- packs
	elseif data == "packarmas-comprar-ak103pack" then
			TriggerServerEvent("contrabandista-comprar","ak103pack")	
	elseif data == "packarmas-comprar-musketpack" then
			TriggerServerEvent("contrabandista-comprar","musketpack")
	elseif data == "packarmas-comprar-parafalpack" then
			TriggerServerEvent("contrabandista-comprar","parafalpack")
	elseif data == "packarmas-comprar-mtarpack" then
			TriggerServerEvent("contrabandista-comprar","mtarpack")
	elseif data == "packarmas-comprar-sigpack" then
			TriggerServerEvent("contrabandista-comprar","sigpack")
	elseif data == "packarmas-comprar-repairkit" then
			TriggerServerEvent("contrabandista-comprar","repairkit")
	elseif data == "packarmas-comprar-pumpshotgunpack" then
			TriggerServerEvent("contrabandista-comprar","pumpshotgunpack")
	elseif data == "packarmas-comprar-fivesevenpack" then
			TriggerServerEvent("contrabandista-comprar","fivesevenpack")
	elseif data == "packarmas-comprar-coletepack" then
		TriggerServerEvent("contrabandista-comprar","coletepack")
	elseif data == "packarmas-comprar-uzipack" then
		TriggerServerEvent("contrabandista-comprar","uzipack")	
	elseif data == "packarmas-comprar-snspack" then
		TriggerServerEvent("contrabandista-comprar","snspack")
		--municao
	elseif data == "municao-comprar-municaosnspack" then
		TriggerServerEvent("contrabandista-comprar","municaosnspack")
	elseif data == "municao-comprar-municaoakpack" then
		TriggerServerEvent("contrabandista-comprar","municaoakpack")
	elseif data == "municao-comprar-municaofamaspack" then
		TriggerServerEvent("contrabandista-comprar","municaofamaspack")
	elseif data == "municao-comprar-municaosigpack" then
		TriggerServerEvent("contrabandista-comprar","municaosigpack")
	elseif data == "municao-comprar-municaopumppack" then
		TriggerServerEvent("contrabandista-comprar","municaopumppack")
	elseif data == "municao-comprar-municaouzipack" then
		TriggerServerEvent("contrabandista-comprar","municaouzipack")
	elseif data == "municao-comprar-municaopistolpack" then
		TriggerServerEvent("contrabandista-comprar","municaopistolpack")
	elseif data == "municao-comprar-municaomusketpack" then
		TriggerServerEvent("contrabandista-comprar","municaomusketpack")
	elseif data == "municao-comprar-municaoparafalpack" then
		TriggerServerEvent("contrabandista-comprar","municaoparafalpack")
	elseif data == "municao-comprar-municaoparafalpack" then
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ -2169.01,5221.40,20.01 },
	
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local crjSleep = 500
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 2.0 then
				crjSleep = 1
				DrawText3Ds(x,y,z+0.20,"~r~[E] ~w~Para Acessar a Loja")
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
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