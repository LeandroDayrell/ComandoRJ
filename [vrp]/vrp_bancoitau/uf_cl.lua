UFclient = {}
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
UFserver = Tunnel.getInterface("vrp_bancoitau")

local cfg = module("vrp_bancoitau","uf_cfg")


Citizen.CreateThread(function()
    SetNuiFocus(false, false)

    while true do
    local likizao = 300
    local ped = PlayerPedId()
    local cds = GetEntityCoords(ped)
    for bancos = 1,#cfg.cds do 
        local dist = #(cds - cfg.cds[bancos])
        if dist < 10.0 then 
            likizao = 5
            DrawMarker(20, cfg.cds[bancos][1],cfg.cds[bancos][2],cfg.cds[bancos][3] - 0.95, 0, 0, 0, 0.0, 0, 0, 0.9, 0.9, 0.9, 138, 43, 226, 150, 0, 0, 0, 1)
            if dist <= 3.0 then 
                if IsControlJustPressed(0, 38) then 
                    UFclient.clOpenNui()
                end
            end
        end
    end
    Citizen.Wait(likizao)
    end
end)

UFclient.close = function()
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

UFclient.clOpenNui = function()
    local carteira, banco, nome, telefone, multas = UFserver.info()
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

UFclient.updateBank = function()
    local carteira, banco, nome, telefone, multas = UFserver.info()
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
-- CB'S ACOES
----------------------------------------------------------------

RegisterNUICallback("transferencia",function(data)
    UFserver.transferencia(data.nid,data.amount)
end)
RegisterNUICallback("saque",function(data)
    UFserver.saque(data.amount)
end)
RegisterNUICallback("deposito",function(data)
    UFserver.depositar(data.amount)
end)
RegisterNUICallback("multas",function(data)
    UFserver.multas(data.amount)
end)