local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

--Conc = Tunnel.getInterface("vrp_concessionaria")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("vrp_concessionaria")
emP = Tunnel.getInterface("vrp_concessionaria")

local open = false
local categoriaSelecionada = nil
local carroSelecionado = nil

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Wait(5)
        local crjSleep = 500
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-32.530567169189,-1112.0616455078,26.422328948975 - 0.97, true)
        if distance <= 3 then
            crjSleep = 1
            DrawMarker(23, -32.530567169189,-1112.0616455078,26.422328948975 - 0.97, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.5, 124, 0, 250, 80, 0, 0, 0, 0)
            if distance <= 2 then
                crjSleep = 1
                if not open then
                    if IsControlJustPressed(1, 38) and func.getPermissao() then
                        open = true
                        SetNuiFocus(true, true)
                        SendNUIMessage({type = 'openGeneral'})
                    end
                end
            end
        end
       Citizen.Wait(crjSleep)
    end
end)
--[[
-- TIRAR CARRO
carros = {}
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Wait(5)
        local ped = PlayerPedId()
        local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), -33.118488311768,-1090.1767578125,26.422292709351 - 0.97, true)

        if distance <= 100 then

            DrawMarker(23, -33.118488311768,-1090.1767578125,26.422292709351 - 0.97, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.5,
                       0, 95, 140, 80, 0, 0, 0, 0)

            if distance <= 2 then
                if not open then
                    if IsControlJustPressed(1, 38) then
                        local name = func.getNomeVeiculo()
                        if name ~= "" then
                            if not carros[name] or carros[name] == nil then
                                local mhash = GetHashKey(name)

                                TriggerEvent("Notify", "aviso",
                                             "Buscando veículo!")

                                local tentativas = 0
                                while tentativas < 350 and
                                    not HasModelLoaded(mhash) do
                                    RequestModel(mhash)
                                    Citizen.Wait(10)
                                    tentativas = tentativas + 1
                                end
                                if not HasModelLoaded(mhash) then
                                    TriggerEvent("Notify", "negado",
                                                 "Veículo inválido!")

                                else
                                    local nveh =
                                        CreateVehicle(mhash,
                                                      GetEntityCoords(ped),
                                                      GetEntityHeading(ped),
                                                      true, false)

                                    local placa = vRP.getRegistrationNumber()
                                    SetVehicleOnGroundProperly(nveh)
                                    SetVehicleNumberPlateText(nveh, placa)
                                    SetEntityAsMissionEntity(nveh, true, false) -- Torna a entidade especificada (ped, veículo ou objeto) persistente. Entidades persistentes não serão removidas automaticamente pelo mecanismo.
                                    TaskWarpPedIntoVehicle(ped, nveh, -1)

                                    SetModelAsNoLongerNeeded(mhash)
                                    carros[name] = placa
                                end

                            else
                                TriggerEvent("Notify", "negado",
                                             "Veículo já foi retirado!")
                            end
                        end
                    end
                end
            end
        end

    end
end)
]]
RegisterNUICallback("CarregarDados", function(data, cb)
    SendNUIMessage({
        type = 'loadData',
        veiculos = json.encode(Config.Veiculos),
        meusVeiculos = func.getVeiculos(),
        totalTipo = func.getTotalVeiculorTipo(),
        aberto = func.abertoTodos(),
        isVendedor = func.getPermissao()
    })
end)

RegisterNUICallback("ButtonClick", function(data, cb)
    if data.action == "close" then
        open = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = 'closeAll'})
    end

    if data.action == "confirmarCompra" then
        if func.comprarVeiculo(data.categoria, data.model) then
            SendNUIMessage({
                type = 'openGeneral',
                veiculos = json.encode(Config.Veiculos),
                meusVeiculos = func.getVeiculos(),
                totalTipo = func.getTotalVeiculorTipo(),
                aberto = Config.AbertoAll,
                isVendedor = func.getPermissao()
            })
        end
    end

    if data.action == "confirmarVenda" then
        if func.venderVeiculo(data.categoria, data.model) then
            SendNUIMessage({
                type = 'openGeneral',
                veiculos = json.encode(Config.Veiculos),
                meusVeiculos = func.getVeiculos(),
                totalTipo = func.getTotalVeiculorTipo(),
                aberto = Config.AbertoAll,
                isVendedor = func.getPermissao()
            })
        end
    end
end)

RegisterNetEvent('vrp_concessionaria:closeAll')
AddEventHandler('vrp_concessionaria:closeAll', function()
    open = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)

RegisterNetEvent("vrp_concessionaria:deletarveiculo")
AddEventHandler('vrp_concessionaria:deletarveiculo', function(distance)
    local vehicle = vRP.getNearestVehicle(distance)
    if IsEntityAVehicle(vehicle) then
        -- local veh = VehToNet(vehicle)

        local vehicleLabel = GetDisplayNameFromVehicleModel(
                                 GetEntityModel(vehicle))
        local placa = GetVehicleNumberPlateText(vehicle)
        if carros[string.lower(vehicleLabel)] == placa then
            carros[string.lower(vehicleLabel)] = nil
        end
        TriggerServerEvent("vrp_adv_garages_id", veh,
                           GetVehicleEngineHealth(vehicle),
                           GetVehicleBodyHealth(vehicle),
                           GetVehicleFuelLevel(vehicle))
        TriggerServerEvent("trydeleteentity", VehToNet(vehicle))
    end
end)

RegisterNetEvent("vrp_concessionaria:notify")
AddEventHandler('vrp_concessionaria:notify', function(title, msg, type)
    SendNUIMessage({type = 'alert', title = title, msg = msg, typeMsg = type})
end)
