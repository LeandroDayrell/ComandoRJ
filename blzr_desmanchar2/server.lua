--[[
    PROPOSTA:



]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")


vRP._prepare("vAZ/SetStateVehicleDESMANCHE", "UPDATE vrp_user_vehicles SET state = @state, time = @time WHERE user_id = @user_id AND plate = @plate")
vRP._prepare('vAZ/GetServerVehicles', 'SELECT * FROM vrp_vehicles')

emP = {}
blzr = {}
Tunnel.bindInterface("blzr_desmanchar2", blzr)

vCLIENT = Tunnel.getInterface("blzr_desmanchar2")

local desmanche = "https://discordapp.com/api/webhooks/747572069881086093/DXsPSndJqmHHHKZAa74SPA7Rbb070CYhsKrUa1M16zWh-oRXj9MjkfIYBwwCtxESATdo"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

------------------------------------------------------
-- CONFIG 
------------------------------------------------------
local RestritoParaDesmanche = true -- É restrito para quem tiver só a permissão do desmanche? (TRUE/FALSE)
local PermissaoDesmanche = 'motoclub.permissao' or 'pca.permissao' -- Se RestritoParaDesmanche for TRUE, aqui deverá ter a permissão que será verifiada.

local PrecisaDeItem = false -- Precisa de item para iniciar o desmanche? (TRUE/FALSE)
local ItemNecessario = 'detonador' -- Qual item precisa para iniciar o desmanche?
local QtdNecessaria = 0 -- Quantos itens precisará para iniciar o desmanche?


local CarrosDesmanches = {

-------------------------------------------------------------------------|
----- CONCESSIONÁRIA ----------------------------------------------------|
-------------------------------------------------------------------------| 
    
    ['150'] = 8500,
   -- ['blista'] = 8500,
    ['amarok'] = 380000,
    ['biz25'] = 5000,
    ['bros60'] = 15000,
    ['civic2016'] = 70000,
    ['dm1200'] = 10000,
    ['ds4'] = 30000,
    ['eletran17'] = 40000,
    ['evoq'] = 145000,
    ['fiat'] = 10000,
    ['fiatstilo'] = 75000, 
    ['fiattoro'] = 180000, 
    ['fiatuno'] = 13000, 
    ['fordka'] = 10000, 
    ['fusion'] = 75000,
    ['golg7'] = 20000, 
    ['hornet'] = 70000, 
    ['jetta2017'] = 50000, 
    ['l200civil'] = 90000, 
    ['monza'] = 15000, 
    ['p207'] = 18000, 
    ['palio'] = 18000, 
    ['punto'] = 48000,
    ['santafe'] = 60000, 
    ['saveiro'] = 35000, 
    ['sonata18'] = 75000, 
    ['upzinho'] = 23000, 
    ['veloster'] = 50000, 
    ['voyage'] = 20000,
    ['vwgolf'] = 45000, 
    ['vwpolo'] = 30000, 
    ['xj'] = 65000, 
    ['xt66'] = 45000, 
    ['z1000'] = 100000, 
    ['dune'] = 450000,
    ['audirs6'] = 600500, 
    ['audirs7'] = 600500, 
    ['bmwm3f80'] = 600000, 
    ['bmwm4gts'] = 400000,
    ['dodgechargersrt'] = 800000,
    ['focusrs'] = 400000,
    ['fordmustang'] = 600000,
    ['hondafk8'] = 750000,
    ['lancerevolution9'] = 600500,
    ['lancerevolutionx'] = 600500, --
    ['f150'] = 70000,
    ['evoque'] = 350000,
    ['mazdarx7'] = 420000,
    ['mercedesa45'] = 420000,
    ['mustangmach1'] = 380000,
    ['nissan370z'] = 380000,
    ['nissangtr'] = 380000,
    ['nissangtrnismo'] = 380000,
    ['nissanskyliner34'] = 380000,
    ['porsche930'] = 420000,
    ['raptor2017'] = 380000,
    ['teslaprior'] = 600500,
    ['toyotasupra'] = 380000,
    ['ruiner'] = 80000,
    ['verlierer2'] = 15000,
    ['sentinel'] = 5000,
    ['intruder'] = 15000,
    ['asea'] = 18000,
    ['sultanrs'] = 210000,
    ['casco'] = 9000,
    ['zentorno'] = 250000,
    ['voltic'] = 250000,
    ['sanchez'] = 6000,
    ['manchez'] = 17820,
    ['santafe'] = 45000,
    
----------------------------------------------------------------------|
----- CARROS VIPS ----------------------------------------------------|
----------------------------------------------------------------------| 

    ['r1'] = 90000,
    ['zx10r'] = 90000,
    ['tiger'] = 130000,
    ['i8'] = 780000,
    ['ferrariitalia'] = 800000,
    ['lamborghinihuracan'] = 650000,
    ['t20'] = 650000,
    ['laferrari15'] = 800000,
    ['tyrant'] = 5000,
    ['r1250'] = 350000,
    ['divo'] = 800000,

    




}

------------------------------------------------------
------------------------------------------------------
------------------------------------------------------


-- RETORNA VEICULOS PERMITIDOS
function blzr.GetVehs()
    return CarrosDesmanches
end


-- FUNÇÃO VERIFICAR PERMISSÃO DO DESMANCHE
function blzr.CheckPerm()
    local source = source
    local user_id = vRP.getUserId(source)
    if RestritoParaDesmanche then
        if vRP.hasPermission(user_id, PermissaoDesmanche) then
            return true
        end
        return false
    end
    return true
end

-- FUNÇÃO PRA VERIFICAR SE POSSUI O ITEM
function blzr.CheckItem()
    local source = source
    local user_id = vRP.getUserId(source)
    if PrecisaDeItem then
        if vRP.tryGetInventoryItem(user_id,ItemNecessario,QtdNecessaria) then
            return true
        end
        return false
    end
    return true
end

--[[
-- NOME BONITO = NOME DO VEICULO
-- FUNÇÃO PARA GERAR O PAGAMENTO E OS ITENS
function blzr.GerarPagamento(placa, nomeFeio, nomeBonito)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    for k, v in pairs(CarrosDesmanches) do
        if string.upper(k) == string.upper(nomeFeio) then
            local pagamento = v
            -- vRP.giveMoney(user_id,pagamento) -- DINHEIRO LIMPO
            vRP.giveInventoryItem(user_id,'dinheirosujo',pagamento) -- DINHEIRO SUJO

            local puser_id = vRP.getUserByRegistration(placa) ---- << BUSCA PLACA DO CIDADA
            if puser_id then
                local value = vRP.getUData(puser_id,'vRP:multas')
                local multas = json.decode(value) or 0
                multas = multas + pagamento
                vRP.setUData(puser_id,'vRP:multas',json.encode(parseInt(multas)))
                local nsource = vRP.getUserSource(puser_id)
                if nsource then
                    TriggerClientEvent('Notify', nsource, 'aviso', 'AVISO SEGURADORA', 'Você foi multado em <b>R$' .. vRP.format(pagamento) .. '</b> referente ao seguro do veículo <b>' .. nomeBonito .. ' (' .. nomeFeio .. ')</b>.')
                end
            end
            TriggerClientEvent("vrp_sound:source",source,'coins',0.3)
            TriggerClientEvent('Notify', source, 'sucesso', 'Vendedor Desmanche', 'Você recebeu <b>R$'..vRP.format(pagamento)..'</b> pelo desmanche de um <b>'..nomeBonito..' ('.. nomeFeio..' - PLACA [' .. placa .. '])</b>.' )
            SendWebhookMessage(desmanche,"```prolog\n[PASSAPORTE]: "..user_id.." \n[NOME]: "..identity.name.." "..identity.firstname.." \n[DESMANCHOU]: "..nomeBonito.."  \n[PLACA]: ".. placa .." \n[E RECEBEU]: ".. vRP.format(pagamento) .." "..os.date("\n[Data]: %d/%m/%y \n[Hora]: %H/%M/%S").." \r```")
        end
    end
end
]]






-- FUNÇÃO PARA GERAR O PAGAMENTO E OS ITENS
function blzr.GerarPagamento(plate, nomeFeio, nomeBonito)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
        for k, v in pairs(CarrosDesmanches) do
            if string.upper(k) == string.upper(nomeFeio) then
                local pagamento = value
                vRP.giveInventoryItem(user_id,'dinheirosujo',pagamento) -- DINHEIRO SUJO
                if #owner > 0 then
                    vRP.execute("vAZ/SetStateVehicleDESMANCHE", { user_id = owner[1].user_id, plate = owner[1].plate, state = 3, time = parseInt(os.time()) })
                    TriggerClientEvent('Notify', source, 'sucesso', 'Vendedor Desmanche', 'Você recebeu <b>R$'..vRP.format(pagamento)..'</b> pelo desmanche de um <b>'..nomeBonito..' ('.. nomeFeio..' - PLACA [' .. plate .. '])</b>.' )
                end
            end
        end
end



function emP.checkVehicle()
	local source = source
	local user_id = vRP.getUserId(source)
		local plate = vRPclient.getPlateVehicle(source, vehicle)  
		local owner = vRP.query("vAZ/GetPlayerVehiclePlate", {plate = plate})
		if #owner <= 0 then
			TriggerClientEvent("Notify",source,"aviso","Veículo não encontrado na lista do proprietário.")
			return false
		elseif #owner > 0 then			
			if user_id ~= owner[1].user_id then
				if parseInt(owner[1].state) == 4 then
					TriggerClientEvent("Notify",source,"aviso","Veículo encontra-se apreendido na seguradora.")
					return false
				end
				local model = vRP.query('vAZ/GetPlayerVehicleModel', {model = owner[1].model})    
				if #model > 0 then
					if model[1].banned then
						TriggerClientEvent("Notify",source,"aviso","Veículos de serviço ou alugados não podem ser desmanchados.")
						return false
					end
				end
				return true
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Modelo do veículo não encontrado.")
			return false
		end
end






