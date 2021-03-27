local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPClient =  Tunnel.getInterface("vRP")

mB = {}
Tunnel.bindInterface('muamba_provadmv',mB)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------

function mB.checkProva()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id,"laranja",1) then
            return true
        else
            TriggerClientEvent('Notify',source,"negado","Você precisa realizar a prova teórica.")
        end 
    end 
    return false
end

function mB.pagamentoProva()
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryPayment(user_id,500) then
            TriggerClientEvent('Notify',source,"sucesso","Você pagou R$500 para realizar o teste teórico de habilitação.")
            return true
        else
            TriggerClientEvent('Notify',source,"negado","Você não tem dinheiro em sua carteira!")
        end
    end 
    return false
end 

RegisterServerEvent('selecionar:prova')
AddEventHandler('selecionar:prova',function()
    local user_id = vRP.getUserId(source)
    if user_id then
        local menu = {name = "Prova Pratica"}
        menu["Habilitação A"] = {function(source,choice)
            if vRP.hasPermission(user_id,"carteiraA.permissao") or vRP.hasPermission(user_id,"carteiraAB.permissao") then
                TriggerClientEvent('Notify',source,"aviso","Você já possui está habilitação.")
            else
                TriggerClientEvent('prova_pratica:A',source)
            end
            vRP.closeMenu(source,menu)
        end}

        menu["Habilitação B"] = {function(source,choice)
            if vRP.hasPermission(user_id,"carteiraB.permissao") or vRP.hasPermission(user_id,"carteiraAB.permissao") then
                TriggerClientEvent('Notify',source,"aviso","Você já possui está habilitação.")
            else
                TriggerClientEvent('prova_pratica:B',source)
            end
            vRP.closeMenu(source,menu)
        end}

        vRP.openMenu(source,menu)
    end 
end)

RegisterServerEvent('dar:habilitacao')
AddEventHandler("dar:habilitacao",function(type)
    print(type)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"carteiraB.permissao") then
            if type == "a" then
                vRP.addUserGroup(user_id,"HabilitacaoAB")
            end
        elseif vRP.hasPermission(user_id,"carteiraA.permissao") then
            if type == "b" then
                vRP.addUserGroup(user_id,"HabilitacaoAB")
            end
        elseif not vRP.hasPermission(user_id,"carteiraA.permissao") and not vRP.hasPermission(user_id,"carteiraB.permissao") then
            if type == "b" then
                vRP.addUserGroup(user_id,"HabilitacaoB")
            elseif type == "a" then
                vRP.addUserGroup(user_id,"HabilitacaoA")
            end
        end
    end 
end)

RegisterServerEvent("aprovado:teste")
AddEventHandler("aprovado:teste",function(check)
    local user_id = vRP.getUserId(source)

    if user_id then
        if check then
            vRP.giveInventoryItem(user_id,"laranja",1)
            TriggerClientEvent('Notify',source,"sucesso","Parábens, você recebeu seu comprovante para realizar a prova prática!")
        else
            TriggerClientEvent('Notify',source,"negado","Tente novamente, você foi reprovado!")
        end
    end 
end)

RegisterCommand('rcnh',function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    local src_player = vRPClient.getNearestPlayer(source,3)
    local player = vRP.getUserId(src_player)
    if user_id then
        if vRP.hasPermission(user_id,"policia.permissao") then
            TriggerEvent('remover:cnh',player,src_player)
        end 
    end
end)

RegisterServerEvent('remover:cnh')
AddEventHandler('remover:cnh',function(player,src_player)
    local user_id = vRP.getUserId(source)
    if vRP.hasGroup(player,"HabilitacaoB") then
        vRP.removeUserGroup(player,"HabilitacaoB")
        TriggerClientEvent('Notify',src_player,"aviso","Sua habilitação foi removida pelo policial!")
    elseif vRP.hasGroup(player,"HabilitacaoA") then
        vRP.removeUserGroup(player,"HabilitacaoA")
        TriggerClientEvent('Notify',src_player,"aviso","Sua habilitação foi removida pelo policial!")
    elseif vRP.hasGroup(player,"HabilitacaoAB") then
        vRP.removeUserGroup(player,"HabilitacaoAB")
        TriggerClientEvent('Notify',src_player,"aviso","Sua habilitação foi removida pelo policial!")
    end
end)