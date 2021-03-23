local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  }
  
  RMenu.Add('peste', 'mainmenu', RageUI.CreateMenu("", "Pescar",60,100,"peste","peste"))


local Locations = {
    ["Blips"] = {
        ["FishingLocation"] = {
            ["title"] = "Loc pescuit!",
            ["sprite"] = 68,
            ["x"] = -1741.82, ["y"] = -1129.24, ["z"] = 12.17
        },

        ["SellFish"] = {
            ["title"] = "Loc vanzare pesti!",
            ["sprite"] = 356,
            ["x"] =  -1847.1296386719, ["y"] = -1191.1413574219, ["z"] = 14.322598457336
        },


    },

    ["Markers"] = {
        ["FishingLocation1"] = { ["x"] = -1741.82, ["y"] = -1129.24, ["z"] = 12.17, ["Info"] = "[E] ~g~Fiska" },
        ["FishingLocation2"] = { ["x"] = -1743.83, ["y"] = -1131.65, ["z"] = 12.17, ["Info"] = "[E] ~g~Fiska" },
        ["FishingLocation3"] = { ["x"] = -1739.94, ["y"] = -1126.98, ["z"] = 12.17, ["Info"] = "[E] ~g~Fiska" },
        ["SellFish"] = { ["x"] = -1845.28, ["y"] = -1195.79, ["z"] = 18.33, ["Info"] = "[E] ~g~Sälj Fiskar" },
    }
}

ingame = false
succes = false


function round(exact, quantum)
    local quant,frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end


RegisterNUICallback("exit", function(data)
    terminat = true
    SetDisplay(false)
   
end)
RegisterNUICallback("succes", function(data)

    succes = true
 
end)

function SetDisplay(bool, masina1,pret1,prettt)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })

end




sese = 0
Citizen.CreateThread(function()

    while true do
        Wait(0)
        EnableAllControlActions(0)
        if succes then
            TriggerServerEvent("pestiuc")
            SetDisplay(false)
            
             Wait(800)
            succes = false
        end
        local coords = GetEntityCoords(PlayerPedId())
        local dstCheck = GetDistanceBetweenCoords(coords, -1847.0278320312,-1191.0375976562,14.322659492493, true)
        if dstCheck <= 13.0  then
        DrawM("Apasa E pentru a deschide meniul!", 27, -1847.0278320312,-1191.0375976562,13.322659492493)
        end
        if dstCheck <= 3.0  then
            DrawSpecialText("Apasa [~g~E~s~] pentru a deschide meniul!")

        end
        if dstCheck <= 3.0  and IsControlJustPressed(0,38) then

            RageUI.Visible(RMenu:Get('peste', 'mainmenu'), not RageUI.Visible(RMenu:Get('peste', 'mainmenu')))
        end
        RageUI.IsVisible(RMenu:Get('peste', 'mainmenu'), true, true, true, function()
        
            RageUI.Button("Adauga inca un peste!", "Pesti selectati pentru vanzare "..sese, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    sese = sese + 1
                end
            end)
            RageUI.Button("Scoate un peste!", "Pesti selectati pentru vanzare "..sese, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    if sese > 0 then
                    sese = sese - 1
                    end
                end
            end)
            RageUI.Button("Vinde "..sese.." pesti!", "Apasa ENTER pentru a vinde "..sese.." pesti!", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    if sese > 0 then
                        TriggerServerEvent("vpestiuc",sese)
                    sese = 0
                    end
                end
            end)
    end)
    end
end)

function round(exact, quantum)
    local quant,frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end




function GetFishingItems()




    hasRod = true

    hasBait = true


return hasRod, hasBait

end

function StartFishing()
    Fishing = true
    local FishOnBait = false



        Citizen.CreateThread(function()
        
            local coords = GetEntityCoords(PlayerPedId())
            local randomTime = math.random(5000, 10000)
            
            while Fishing do
            
                Citizen.Wait(0)

                if not IsPedActiveInScenario(PlayerPedId()) then
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, false)
                    SetEntityHeading(PlayerPedId(), 232.46)


                end


                    if succes then
                        ClearPedTasksImmediately(PlayerPedId())

                        local fishingRod = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_fishing_rod_01"), false, false, false)

                        if fishingRod ~= 0 and fishingRod ~= nil then
                            TriggerServerEvent('loffe-fishing:giveFish')
                            Fishing = false

                            Citizen.Wait(0)
                            SetEntityAsMissionEntity(fishingRod, true, true)
                            DeleteEntity(fishingRod)
                        end
                    end
                    if terminat then
                        ClearPedTasksImmediately(PlayerPedId())
                        local fishingRod = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_fishing_rod_01"), false, false, false)

                        if fishingRod ~= 0 and fishingRod ~= nil then

                            Fishing = false

                            Citizen.Wait(0)
                            SetEntityAsMissionEntity(fishingRod, true, true)
                            DeleteEntity(fishingRod)
                            terminat = false
                        end
                    end
            end
        end)
end









function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end
Citizen.CreateThread(function()

    local Blips = Locations["Blips"]

    for spot, val in pairs(Blips) do
        local BlipInformation = val
        
        local Blip = AddBlipForCoord(BlipInformation["x"], BlipInformation["y"], BlipInformation["z"])
        SetBlipSprite(Blip, BlipInformation["sprite"])
        SetBlipDisplay(Blip, 4)
        SetBlipScale(Blip, 0.8)
        SetBlipColour(Blip, 0)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(BlipInformation["title"])
        EndTextCommandSetBlipName(Blip)
    end
    SetDisplay(true)
    Citizen.Wait(500)
    SetDisplay(false)
    while true do
      
        local sleep = 500
        
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if not Fishing then

            for place, v in pairs(Locations["Markers"]) do

                local dstCheck = GetDistanceBetweenCoords(coords, v["x"], v["y"], v["z"], true)

                if dstCheck <= 5.0 then
                    sleep = 5
                    DrawM(v["Info"], 27, v["x"], v["y"], v["z"])
                    if dstCheck <= 1.5 then
                        DrawSpecialText("Apasa [~g~E~s~] pentru a incepe sa pescuiesti!")
                        if IsControlJustPressed(0, Keys["E"]) then
                            SetDisplay(true)
                            StartFishing()
                            ingame = true
                        end
                    end
                end
            end

        end

        Citizen.Wait(sleep)


    end
end) 

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0*scale, 0.35*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150) 
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function DrawM(hint, type, x, y, z)
  DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end






































































local isVehiclesLoaded = false

local vehicles = {
    "corvette",
"lx2018",
"gs350",
"isf",
"rx450h",
"eldorado59",
"ctsv",
"audia4",
"a615",
"r8ppi",
"c5rs6",
"r820",
"audis8om",
"tts",
"a8lfsi",
"audis32",
"as7",
"audirs6tk",
"sq72016",
"s4a",
"lbr8",
"rs318",
"rs3",
"rs6sedan",
"m4",
"bmc2",
"x6m",
"e36drift",
"2019M5",
"16m5",
"acs8",
"b12lang",
"m6coupe",
"m8gte",
"e34",
"235if22",
"bm8c",
"750il",
"z4alchemist",
"m3f80",
"x5e53",
"e32i",
"320ig5",
"E92",
"BMWe90",
"bmwrace",
"bmwhommage",
"bs17",
"bmwe65",
"sandero08",
"sanderos2",
"sandero",
"SANDEROS",
"1310s",
"daduster",
"f8t",
"mig",
"berlinetta",
"2013LP560",
"sian",
"lp700",
"ddehuracan1",
"lambose",
"terzo",
"rmodlp770",
"CLS53",
"gtrc",
"XPERIA38",
"benz190e",
"amggtsmansory",
"cls63s",
"GLE63S",
"e500c",
"gl63",
"mercxclass",
"500w124",
"mlbrabus",
"g65",
"w222s500",
"cla45sb",
"gle450",
"mb300sl",
"722sslr",
"e63b",
"s600w220",
"g770",
"mr2sw20",
"cam8tun",
"prius",
"gt86",
"avalon",
"rav4",
"fj40",
"mr2zzw30",
"2000gt",
"cayenneturbo",
"pgt3",
"techart17",
"pm19",
"str20",
"raptor150",
"fastback",
"mustang19",
"focusrs",
"FGT",
"wraith",
"silver67",
"dawn",
"rculi",
"bexp",
"bentaygast",
"mulsanneom",
"contss18",
"C7",
"camaross",
"vip8",
"hellcat",
"co",
"rt70",
"chargerf8",
"chargersb",
"goldwing",
"cb500x",
"hcbr17",
"nsx4",
"crf450r",
"civic7th",
"rr12",
"velar",
"crafter17",
"scijo",
"polo",
"jetta",
"16cc",
"R50",
"mk7",
"mk4",
"vwgolf",
"63lb"
}

Citizen.CreateThread(function()
  while true do
		Citizen.Wait(0)
			if not isVehiclesLoaded then
			for i, name in ipairs(vehicles) do
				targetVehicle = name

				if not IsModelInCdimage(targetVehicle) or not IsModelAVehicle(targetVehicle) then
					Citizen.Trace(targetVehicle .. " could not be found as a vehicle.")
					return
				end

				RequestModel(targetVehicle)
				

				while not HasModelLoaded(targetVehicle) do
                    Citizen.Trace("[VehicleLoader] Loading vehicle " ..targetVehicle)
					Citizen.Wait(5) 
				end

                if HasModelLoaded(targetVehicle) then
 
                end
				SetModelAsNoLongerNeeded(targetVehicle)
			end
			isVehiclesLoaded = true
		end

  end
end)