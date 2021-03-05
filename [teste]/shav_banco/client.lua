client = {}
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
server = Tunnel.getInterface("shav_banco")

local cfg = module("shav_banco","config")


Citizen.CreateThread(function()
    SetNuiFocus(false, false)

    while true do
    local crjSleep = 300
    local ped = PlayerPedId()
    local cds = GetEntityCoords(ped)
    for bancos = 1,#cfg.cds do 
        local dist = #(cds - cfg.cds[bancos])
        if dist < 3.0 then 
            crjSleep = 5
            DrawMarker(29, cfg.cds[bancos][1],cfg.cds[bancos][2],cfg.cds[bancos][3] - 0.5, 0, 0, 0, 0.0, 0, 0, 0.9, 0.9, 0.9, 137, 104, 205, 150, 0, 0, 0, 1)
            if dist <= 1.5 then 
                if IsControlJustPressed(0, 38) then 
                    client.clOpenNui()
                end
            end
        end
    end
    Citizen.Wait(crjSleep)
    end
end)

client.close = function()
    SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ acao = "close" })
    TransitionFromBlurred(500)
end

RegisterNUICallback("close",function(data)
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ acao = "close" })
    TransitionFromBlurred(500)
end)

client.clOpenNui = function()
    local carteira, banco, nome, telefone, multas = server.info()
    local logs = "."
    SendNUIMessage({
        acao = "open",
        carteira = carteira,
        banco = banco,
        nome = nome,
        phone = telefone,
        logs = logs,
        multas = multas
    })
    SetNuiFocus(true, true)
    TransitionToBlurred(1000)
end

client.updateBank = function()
    local carteira, banco, nome, telefone, multas = server.info()
    local logs = "."
    SendNUIMessage({
        acao = "update",
        carteira = carteira,
        banco = banco,
        nome = nome,
        phone = telefone,
        logs = logs,
        multas = multas
    })
end

----------------------------------------------------------------
-- NUI CALLBACK
----------------------------------------------------------------

RegisterNUICallback("transferencia",function(data)
    server.transferencia(data.nid,data.amount)
end)
RegisterNUICallback("saque",function(data)
    server.saque(data.amount)
end)
RegisterNUICallback("deposito",function(data)
    server.depositar(data.amount)
end)
RegisterNUICallback("multas",function(data)
    server.multas(data.amount)
end)