local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_concessionaria", func)

vRP._prepare("vRP/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id, model, plate, trunk, tuning) VALUES(@user_id, @model, @plate, '[]', '[]')")
--vRP._prepare("vRP/add_vehicle", "INSERT IGNORE INTO vrp_user_vehicles(user_id,model) VALUES(@user_id,@model)")
vRP._prepare("vRP/remove_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND model = @model") --
vRP._prepare("vRP/remove_vrp_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP._prepare("vRP/get_vehicles","SELECT model FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/get_vehicle", "SELECT model FROM vrp_user_vehicles WHERE user_id = @user_id AND model = @model")
vRP._prepare("vRP/count_vehicle","SELECT COUNT(*) as qtd FROM vrp_user_vehicles WHERE model = @model")
vRP._prepare("vRP/get_maxcars","SELECT COUNT(model) as quantidade FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/get_total_carros_tipo","SELECT model, count(1) total FROM vrp.vrp_user_vehicles GROUP BY model")
vRP._prepare("vRP/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @tuser_id WHERE user_id = @user_id AND model = @model")

--------- ADICIONADO DO AZTEC

vRP._prepare('vAZ/GetPlayerVehicles', 'SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id')
vRP._prepare('vAZ/GetPlayerVehiclePlate', 'SELECT * FROM vrp_user_vehicles WHERE plate = @plate')
vRP._prepare('vAZ/GetPlayerVehicleModel', 'SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND model = @model')


-- function func.init() 
--     vRPclient._addMarker(source,23,-31.81,-1113.83,25.45,2,2,0.5,0,95,140,80,100)
-- end

vAZgarage = Proxy.getInterface('az-garages')

function func.getTotalVeiculorTipo()
    return vRP.query("vRP/get_total_carros_tipo")
end

function func.abertoTodos() 
    local totalConcessionaria = vRP.getUsersByPermission("concessionaria.permissao")
    if #totalConcessionaria == 0 then
        return true
    end
    return Config.AbertoAll
end

function func.getPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, "concessionariavip.permissao")
end

function func.getVeiculos()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.query("vAZ/GetPlayerVehicles", {user_id = user_id})
end

function func.comprarVeiculo(categoria, modelo)
    local source = source
    local user_id = vRP.getUserId(source)
    local isVendedor = func.getPermissao()
    if func.abertoTodos() or (Config.AbertoAll == false and isVendedor) then

        categoria = categoria + 1
        modelo = modelo + 1

        local veiculo = Config.Veiculos[categoria].veiculos[modelo]

        if veiculo then
            local getVeiculo = vRP.query("vRP/get_vehicle", {
                user_id = user_id,
                model = veiculo.model
            })

            if #getVeiculo == 0 then
                local rows = vRP.query("vRP/count_vehicle",
                                       {model = veiculo.model})
                if parseInt(rows[1].qtd) >= veiculo.estoque then
                    TriggerClientEvent("vrp_concessionaria:notify", source,"Ops!", "Estoque indisponivel.", "error")
                    return
                else
                    local totalv = vRP.query("vRP/get_maxcars",
                                             {user_id = user_id})
                    local totalGaragens = Config.TotalGaragem

                    if vRP.hasPermission(user_id, "prata.permissao") then
                        totalGaragens = totalGaragens+1 -- Se for dono da concessionária ganha uma vaga a mais
                    end

                    if vRP.hasPermission(user_id, "bronze.permissao") then
                        totalGaragens = Config.TotalGaragem + 5
                    elseif vRP.hasPermission(user_id, "prata.permissao") then
                        totalGaragens = Config.TotalGaragem + 6
                    elseif vRP.hasPermission(user_id, "mafioso.permissao") then
                        totalGaragens = Config.TotalGaragem + 10
                    elseif vRP.hasPermission(user_id, "magnata.permissao") then
                        totalGaragens = Config.TotalGaragem + 12
                    end

                    if parseInt(totalv[1].quantidade) >= totalGaragens then
                        TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!","Atingiu o número máximo de veículos em sua garagem.", "error")
                        return
                    end

                    local valor = veiculo.preco
                    if isVendedor then valor = valor * 0.8 end

                    if vRP.tryFullPayment(user_id, valor) then
                        vRP.execute("vRP/add_vehicle", {
                            user_id = user_id,
                            model = veiculo.model,
                            plate = vAZgarage.generatePlate(),
                            ipva = os.time()
                        })
                        TriggerClientEvent("vrp_concessionaria:notify", source, "Oba!", "Pagou <b>$" ..vRP.format(parseInt(valor)) .." dólares</b>.", "success")
                        return true
                    else
                        TriggerClientEvent("vrp_concessionaria:notify", source,"Ops!", "Dinheiro insuficiente.","error")
                        return
                    end
                end
            else
                TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Você já possui este veículo!", "error")
                return
            end
        else
            TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!","Veículo inválido!", "error")
            return
        end
    else
        TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!","Somente o dono da concessionária pode executar está ação!","error")
        return
    end

end

function func.venderVeiculo(categoria, modelo)
    local source = source
    local user_id = vRP.getUserId(source)

    -- if Config.AbertoAll or (Config.AbertoAll == false and vRP.hasPermission(user_id, "concessionaria.permissao")) then
    categoria = parseInt(categoria + 1)
    modelo = parseInt(modelo + 1)

    local veiculo = Config.Veiculos[categoria].veiculos[modelo]

    if veiculo then
        local price = math.ceil(veiculo.preco * 0.8)
        
        -- if Config.AbertoAll == false then
        --     price = math.ceil(veiculo.preco*0.7)
        -- end
        local rows = vRP.query("vRP/get_vehicle",{user_id = user_id, model = veiculo.model})
        if #rows <= 0 then
            TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Não encontrado", "error")
            return false
        end
        if parseInt(rows[1].detido) >= 1 then
            TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!","Acione a seguradora antes de vender.", "error")

            return false
        end
        
        vRP.execute("vRP/remove_vehicle",{user_id = user_id, model = veiculo.model})
                    
        vRP.execute("vRP/remove_vrp_srv_data", {dkey = "custom:u" .. user_id .. "veh_" .. veiculo.model})
        vRP.setSData("custom:u" .. user_id .. "veh_" .. veiculo.model,json.encode())

        vRP.giveMoney(user_id, parseInt(price))
        if parseInt(price) > 0 then
            TriggerClientEvent("vrp_concessionaria:notify", source, "Oba!","Recebeu <b>$" .. vRP.format(parseInt(price)) .." dólares</b>.", "success")
        end
        vRP.closeMenu(source)

        return true
    else
        TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!","Veículo inválido!", "error")

        return false
    end
    -- else
    --     TriggerClientEvent("Notify",source,"negado","Somente o dono da concessionária pode executar está ação!")
    -- end
end

function func.getNomeVeiculo() return
    vRP.prompt(source, "Nome do veículo:", "") end
