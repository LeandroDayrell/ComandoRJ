local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-dynasty8')
vAZ = {}
Tunnel.bindInterface('az-dynasty8', vAZ)

vRP._prepare("vPH/GetAllHomes", "SELECT * FROM vrp_imobiliaria")
vRP._prepare("vPH/GetHomesForSales", "SELECT * FROM vrp_imobiliaria WHERE a_venda = true")
vRP._prepare("vPH/GetUserHomeByName", "SELECT * FROM vrp_user_homes WHERE home = @home")
vRP._prepare("vPH/GetHomeByName", "SELECT * FROM vrp_imobiliaria WHERE nome = @home")
vRP._prepare("vPH/UpdateHomeAvailable", "UPDATE vrp_imobiliaria SET a_venda = @available WHERE nome = @home")

local cfg = module("cfg/homes").casas
local usersVisit = {}
local dispatch = {}

vAZ.CheckPermission = function(permission)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, permission)
end

vAZ.CheckItem = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.getInventoryItemAmount(user_id, 'tabletd') > 0 then
        return true
    end
    return false
end

vAZ.GiveTabletJob = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.getInventoryItemAmount(user_id, 'tabletd') < 2 then
        vRP.giveInventoryItem(user_id, 'tabletd', 1)
    end
end

vAZ.GetHomesForSales = function()
    local homes = {}
    local homesDB = vRP.query("vPH/GetHomesForSales", {})
    if #homesDB > 0 then        
        for id,home in pairs(homesDB) do
            if cfg[home.nome] then
                home.entry = cfg[home.nome].entrada
                home.exit = cfg[home.nome].saida
                home.chest = cfg[home.nome].bau.limite
                table.insert(homes, home)
            end            
        end
    end
    return homes
end

vAZ.GetHomeTypes = function()
    local types = {}
    local homes = vRP.query("vPH/GetHomesForSales", {})
    if #homes > 0 then
        for id,home in pairs(homes) do            
            if not vAZ.SearchHomeType(types, home.categoria) then
                table.insert(types, home.categoria)
            end
        end
    end
    return types
end

vAZ.SearchHomeType = function(table, type)
    for id,tp in ipairs(table) do
        if tp == type then
            return true
        end
    end
    return false
end

vAZ.VisitHome = function(data)
    local user_id = vRP.getUserId(source)
    local source = vRP.getUserSource(user_id)
    if cfg[data.name] and cfg[data.name].visit == nil then
        local user_visit = parseInt(data.user_id)
        local source_visit = vRP.getUserSource(user_visit)
        if source_visit and user_id ~= user_visit then
            local ok = vRP.request(source_visit, "Deseja visitar a residencia <b>"..data.name.."</b> ?", 30)
            if ok then
                cfg[data.name].visit = true
                table.insert(dispatch, {salesman = source, source = source_visit, user_id = user_visit, cooldown = 5, name = data.name, time = parseInt(data.time)})                
                TriggerClientEvent('az-notify:default', source_visit, 'Dynasty8', 'Sua visita começara em breve, aguade um momento!')
                TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Visita agendada, Procurando a chave no bolso!')
            else
                TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'O cliente não aceitou o pedido de visita.')
            end
        else
            TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'O cidadão precisa estar na cidade!')
        end
    elseif cfg[data.name].visit then
        TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Já possui uma pessoa visitando essa casa, aguarde!')
    end
end

vAZ.PurchaseHome = function(data)
    local user_sales = vRP.getUserId(data.salesman)    
    local source_sales = vRP.getUserSource(user_sales) 
    local source = vRPclient.getNearestPlayer(source_sales, 3)
    if source == nil then
        TriggerClientEvent('az-notify:default', source_sales, 'Dynasty8', 'O cliente precisa estar perto de você!')        
        return
    end
    local user_id = vRP.getUserId(source)
    if cfg[data.name] and source and source_sales then
        local available = vRP.query("vPH/GetUserHomeByName", {home = data.name})
        if #available == 0 then
            local home = vRP.query("vPH/GetHomeByName", {home = data.name})
            if #home > 0 then
                local ok = vRP.request(source, "Deseja comprar a residencia ?<br><br>Residencia:<b> "..data.name.."<br>Valor:<b> R$"..format(parseInt(home[1].preco)).."</b> ?", 30)
                if ok then
                    if vRP.tryFullPayment(user_id, parseInt(home[1].preco)) then
                        vRP.execute("vPH/UpdateHomeAvailable", {home = data.name, available = false})                                
                        TriggerEvent('Homes:comprarCasa', user_id, data.name)
                        vAZclient.RemoveHomes(source_sales, data.name)
                        if source_sales then
                            local commission = parseFloat(home[1].preco*(20/100))
                            vRP.giveMoney(user_sales, parseInt(commission))
                            TriggerClientEvent('az-notify:default', source_sales, 'Dynasty8', 'Venda efetuada, Comissão de venda: <b>R$'..format(parseInt(commission))..'</b>!')                            
                        end
                        TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Parabéns pela conquista, você comprou sua casa!')
                    else
                        TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Você não possui dinheiro suficiente!')
                        TriggerClientEvent('az-notify:default', source_sales, 'Dynasty8', 'O cliente não tem dinheiro suficiente!')
                    end
                else
                    TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Você recusou a compra!')
                    TriggerClientEvent('az-notify:default', source_sales, 'Dynasty8', 'O cliente recusou o pedido!')
                end 
            else
                TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Residencia não encontrada!')
            end                       
        else
            vRP.execute("vPH/UpdateHomeAvailable", {home = data.name, available = false})
            TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Essa residencia não esta mais disponivel!')
            TriggerClientEvent('az-notify:default', source_sales, 'Dynasty8', 'Essa residencia não está a venda!')
        end
    end
end

vAZ.VisitHomeTask = function(id, info)
    local user_id = parseInt(info.user_id)
    local source = vRP.getUserSource(user_id)
    local user_sales = vRP.getUserId(info.salesman)
    local source_sales = vRP.getUserSource(user_sales)
    if source and source_sales then
        local x,y,z = vRPclient.getPosition(source)       
        usersVisit[user_id] = {name = info.name, x = x, y = y, z = z}
        vAZclient.ScreenFadeTeleport(source, 500, 600, 1000, cfg[info.name].saida.x, cfg[info.name].saida.y, cfg[info.name].saida.z)
        local x2,y2,z2 = vRPclient.getPosition(source_sales)
        usersVisit[user_sales] = {name = info.name, x = x2, y = y2, z = z2}        
        vAZclient.ScreenFadeTeleport(source_sales, 500, 600, 1000, cfg[info.name].saida.x, cfg[info.name].saida.y, cfg[info.name].saida.z)
        if info.time == nil or info.time <= 0 then info.time = 60 end
        TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Você tem apenas <b>'..info.time..' segundos</b> de visita.')
        SetTimeout(info.time*1000, function()
            if usersVisit[user_id] then
                TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Seu tempo de visita acabou!')
                vAZclient.ScreenFadeTeleport(source, 500, 600, 1000, x, y, z)
                vAZclient.ScreenFadeTeleport(source_sales, 500, 600, 1000, x2+0.05, y2, z2)
                cfg[info.name].visit, usersVisit[user_id], usersVisit[user_sales] = nil, nil, nil
                local home = vRP.query("vPH/GetHomeByName", {home = info.name})
                if #home > 0 then
                    local ok = vRP.request(source, "Deseja comprar a residencia ?<br>Valor: <b>R$"..format(parseInt(home[1].preco)).."</b> ?", 30)
                    if ok then
                        local available = vRP.query("vPH/GetUserHomeByName", {home = info.name})
                        if #available == 0 then
                            if vRP.tryFullPayment(user_id, parseInt(home[1].preco)) then
                                vRP.execute("vPH/UpdateHomeAvailable", {home = info.name, available = false})                                
                                TriggerEvent('Homes:comprarCasa', user_id, info.name)
                                vAZclient.RemoveHomes(source_sales, info.name)
                                if source_sales then
                                    local commission = parseFloat(home[1].preco*(20/100))
                                    vRP.giveMoney(user_sales, parseInt(commission))
                                    TriggerClientEvent('az-notify:default', source_sales, 'Dynasty8', 'Venda efetuada, Comissão de venda: R$'..format(parseInt(commission))..'!')
                                end
                                TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Parabéns pela conquista, você comprou sua casa!')
                            else
                                TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Você não possui dinheiro suficiente!')
                                TriggerClientEvent('az-notify:default', source_sales, 'Dynasty8', 'O cliente não tem dinheiro suficiente!')
                            end
                        else
                            vRP.execute("vPH/UpdateHomeAvailable", {home = info.name, available = false})
                            TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Essa residencia não esta mais disponivel!')
                            TriggerClientEvent('az-notify:default', source_sales, 'Dynasty8', 'Essa residencia não está a venda!')
                        end
                    end
                else
                    TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Residencia não encontrada!')
                end
            end
        end)
    else
        cfg[info.name].visit,usersVisit[user_id],usersVisit[user_sales] = nil,nil,nil
    end
end

vAZ.GPSHome = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if cfg[data.name] then
        TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Residencia: <b>'..data.name..'</b><br>Rota marcada em seu GPS!')
        vRPclient._setGPS(source, cfg[data.name].entrada.x, cfg[data.name].entrada.y)
    end
end

vRP._prepare("vPH/SetPriceHome", "UPDATE vrp_imobiliaria SET preco = @price WHERE nome = @home")
vAZ.PriceHome = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if cfg[data.name] then
        local home = vRP.query("vPH/GetHomeByName", {home = data.name })
        if #home > 0 then
            vRP.execute("vPH/SetPriceHome", { home = data.name, price = parseInt(data.price) })
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
        for id,info in pairs(dispatch) do
            if info.cooldown <= 0 then
                vAZ.VisitHomeTask(id, info)
                table.remove(dispatch, id)
            elseif info.cooldown > 0 then
                info.cooldown = info.cooldown - 1
            end
        end
	end
end)

function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

local atWork = {}
local countWork = 0

vAZ.inService = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if atWork[tostring(source)] then
		return true
	else
		return false
	end
end

vAZ.countService = function()	
	return countWork
end

vAZ.GetAtWork = function()	
	return atWork, countWork
end

vAZ.StartWork = function()
    local source = source
	local user_id = vRP.getUserId(source)
	if atWork[tostring(source)] == nil and vRP.hasPermission(user_id, 'dyn.permissao') then
		countWork = countWork + 1
		atWork[tostring(source)] = {user = user_id, work = 0, time = 0, paid = 0, bonus = 0}
		TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Ponto batido, bom trabalho!')
	end	
end

vAZ.StopWork = function()
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
	if atWork[tostring(source)] and vRP.hasPermission(user_id, 'dyn.permissao') then
		if atWork[tostring(source)].work >= 1 then			
			countWork = countWork - 1
			atWork[tostring(source)] = nil
		else
			TriggerClientEvent('az-notify:default', source, 'Dynasty8', 'Você não cumpriu o horario, salario travado!')
			countWork = countWork - 1
			atWork[tostring(source)] = nil
		end
	end
end

local pay = {
	["[Dynasty8] Gerente"] = {amount = 7000},
	["[Dynasty8] Agente Imobiliário"] = {amount = 3000}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
        if atWork ~= nil then
			for source,user in pairs(atWork) do
				user.time = user.time + 1
				if user.time >= 1800 then
					local user_id = parseInt(user.user)
					local player = vRP.getUserSource(user_id)
					if player then
						local jobTitle = vRP.getGroupTitle(vRP.getUserGroupByType(user_id, 'job'))
						if pay[jobTitle] then
							vRP.giveBankMoney(user_id, pay[jobTitle].amount)
							TriggerEvent('ph-nubank:salary', player, pay[jobTitle].amount)
							TriggerEvent('ph-nubank:statement', player, 'Salário depositado <strong>R$'..addComma(pay[jobTitle].amount)..'</strong>, e seu saldo ficou em <strong>R$' ..  addComma(vRP.getBankMoney(user_id)+pay[jobTitle].amount) .. '</strong> comprovante <strong>NL' .. math.random(10000, 99999) .. '</strong>')
                            TriggerClientEvent('az-notify:default', player, 'Nubank', 'Seu salário foi depositado <b>R$'..pay[jobTitle].amount..'</b>.')
							TriggerClientEvent("vrp_sound:source", player, 'dinheiro', 0.2)
							user.work,user.time = user.work + 1,0							
						end
					else
						countWork = countWork - 1
						atWork[tostring(source)] = nil
					end
				end
			end
		end		
	end
end)

AddEventHandler('vRP:playerJoin',function(user_id, source, name, last_login)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'dyn.permissao') then	
		if atWork[tostring(source)] then
			countWork = countWork - 1
			atWork[tostring(source)] = nil
        end
        Citizen.Wait(1000)
        vAZclient.SetHomes(source, vAZ.GetHomesForSales())
	end
end)

AddEventHandler('vRP:playerLeave',function(user_id, source)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'dyn.permissao') then
		if atWork[tostring(source)] then
			countWork = countWork - 1
			atWork[tostring(source)] = nil
        end        
	end
end)

function addComma(amount)
    local formatted = amount
    while true do  
      formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
end