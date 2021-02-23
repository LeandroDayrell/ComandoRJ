vRP = Proxy.getInterface("vRP")

codigopenal = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)	
		if IsControlJustPressed(math.floor(1), math.floor(56)) then
			TriggerServerEvent("vrp_menu_policia:open_s")
		end
	end
end)
--EVENTS
RegisterNetEvent("vrp_menu_policia:updatelist")
AddEventHandler("vrp_menu_policia:updatelist", function(list)
	codigopenal = list
end)
RegisterNetEvent("vrp_menu_policia:open_c")
AddEventHandler("vrp_menu_policia:open_c", function(playername)
	SetDisplay(true,playername)
end)
RegisterNetEvent("vrp_menu_policia:procurarnome_c")
AddEventHandler("vrp_menu_policia:procurarnome_c", function(list)
	SetDisplay(true,nil,list)
end)
RegisterNetEvent("vrp_menu_policia:mostrarnome_c")
AddEventHandler("vrp_menu_policia:mostrarnome_c", function(name,apelido,idade,registro,telemovel,porte,arrests,avisos,multas,mandato,imagem,id)
	playerdata = {name = name,apelido = apelido,idade = idade,registro=registro,telemovel=telemovel,porte=porte,arrests=arrests,avisos=avisos,multas=multas,mandato=mandato,imagem=imagem,id=id}
	SetDisplay(true,nil,nil,playerdata)
end)
RegisterNetEvent("vrp_menu_policia:mostrarveiculo_veiculos_c")
AddEventHandler("vrp_menu_policia:mostrarveiculo_veiculos_c", function(name,apelido,idade,registro,telemovel,porte,veiculos,imagem)
	veiculosplayerdata = {name = name,apelido = apelido,idade = idade,registro=registro,telemovel=telemovel,porte=porte,veiculos=veiculos,imagem=imagem}
	SetDisplay(true,nil,nil,nil,nil,nil,veiculosplayerdata)
end)
RegisterNetEvent("vrp_menu_policia:procurados_c")
AddEventHandler("vrp_menu_policia:procurados_c", function(data)
	if json.encode(data) ~= "[]" then
		SetDisplay(true,nil,nil,nil,data)
	end
end)
RegisterNetEvent("vrp_menu_policia:veiculosprocurados_c")
AddEventHandler("vrp_menu_policia:veiculosprocurados_c", function(data)
	if json.encode(data) ~= "[]" then
		SetDisplay(true,nil,nil,nil,nil,data)
	end
end)
--NUI
RegisterNUICallback("close",function(data)
	SetDisplay(false)
end)
RegisterNUICallback("imagem",function(data)
	TriggerServerEvent("vrp_menu_policia:imagem_s",data.data,data.user_id)
end)
RegisterNUICallback("adicionarmatricula",function(data)
	local fullmatricula = data.data
	if string.match(fullmatricula,"P ") then
		local matricula = split(fullmatricula,"P ")
		TriggerServerEvent("vrp_menu_policia:adicionarmatricula_s",matricula[math.floor(1)])
	end
end)
RegisterNUICallback("multas",function(data)
	SetDisplay(true,nil,nil,nil,nil,nil,nil,nil,codigopenal.multas)
end)
RegisterNUICallback("multar",function(data)
	TriggerServerEvent("vrp_menu_policia:multar_s",data.multa_id,data.user_id,data.date)
end)
RegisterNUICallback("avisos",function(data)
	TriggerServerEvent("vrp_menu_policia:avisos_s",data.avisos,data.user_id)
end)
RegisterNUICallback("mandato",function(data)
	TriggerServerEvent("vrp_menu_policia:mandato_s",data.data,data.user_id)
end)
RegisterNUICallback("detencao",function(data)
	print(data.data)
	TriggerServerEvent("vrp_menu_policia:detencao_s",data.data,data.user_id)
end)
RegisterNUICallback("eliminarmatriculaprocurada",function(data)
	local id = data.user_id
	TriggerServerEvent("vrp_menu_policia:eliminarmatriculaprocurada_s",id)
end)
RegisterNUICallback("eliminaraviso",function(data)
	local id = data.user_id
	TriggerServerEvent("vrp_menu_policia:eliminaraviso_s",id)
end)
RegisterNUICallback("eliminarmultas",function(data)
	local id = data.user_id
	TriggerServerEvent("vrp_menu_policia:eliminarmultas_s",id)
end)
RegisterNUICallback("eliminardetencoes",function(data)
	local id = data.user_id
	TriggerServerEvent("vrp_menu_policia:eliminardetencoes_s",id)
end)
RegisterNUICallback("eliminarmandato",function(data)
	local id = data.user_id
	TriggerServerEvent("vrp_menu_policia:eliminarmandato_s",id)
end)
RegisterNUICallback("codigopenal",function(data)
	SetDisplay(true,nil,nil,nil,nil,nil,nil,codigopenal)
end)
RegisterNUICallback("mostrarveiculo",function(data)
	local id = data.user_id
	TriggerServerEvent("vrp_menu_policia:mostrarveiculo_veiculos_s",id)
end)
RegisterNUICallback("veiculosprocurados",function(data)
	TriggerServerEvent("vrp_menu_policia:veiculosprocurados_s")
end)
RegisterNUICallback("procurados",function(data)
	TriggerServerEvent("vrp_menu_policia:procurados_s")
end)
RegisterNUICallback("procurarnome",function(data)
	local firstname = data.primeironome
	local lastname = data.ultimonome
	TriggerServerEvent("vrp_menu_policia:procurarnome_s",firstname,lastname)
end)
RegisterNUICallback("mostrarnome",function(data)
	local user_id = data.user_id
	TriggerServerEvent("vrp_menu_policia:mostrarnome_s",user_id)
end)
RegisterNUICallback("procurarmatricula",function(data)
	local fullmatricula = data.matricula
	if string.match(fullmatricula,"P ") then
		local matricula = split(fullmatricula,"P ")
		TriggerServerEvent("vrp_menu_policia:procurarmatricula_s",matricula[math.floor(1)])
	end
end)
function split(str, sep)
    local array = {}
    local reg = string.format("([^%s]+)", sep)
    for mem in string.gmatch(str, reg) do
        table.insert(array, mem)
    end
    return array
end
function SetDisplay(bool,playername,namelist,playerdata,procuradosdata,veiculosdata,veiculosplayerdata,codigopenal,multas)
	SetNuiFocus(bool,bool)
	SendNUIMessage({
		status = bool,
		playername = playername,
		namelist = namelist,
		playerdata = playerdata,
		procuradosdata = procuradosdata,
		veiculosdata = veiculosdata,
		veiculosplayerdata = veiculosplayerdata,
		codigopenal = codigopenal,
		multas = multas,
	})
end