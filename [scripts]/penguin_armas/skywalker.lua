--#----------------------------------------------------------------------------------------------------------------------------#--
--#--------------------------------------------------[ DEVELOPED BY PENGUIN ]--------------------------------------------------#--
--#-------------------------------------------------[ CONTATO: Penguinn#0001 ]-------------------------------------------------#--
--#---------------------------------------------[ START SHOP: discord.gg/p8cEuep ]---------------------------------------------#--
--#----------------------------------------------------------------------------------------------------------------------------#--
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("penguin_armas",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local municoes = {
    { item = "ak103" },
    { item = "imbel" },
	{ item = "mtar" },
	{ item = "sigsauer" },
	{ item = "smg" },
    { item = "microuzi" },
    { item = "remington" },
    { item = "pistolsns" },
    { item = "fiveseven" },
    { item = "m1911" },
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-arma")
AddEventHandler("produzir-arma",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(municoes) do
            if item == v.item then
                if item == "ak103" then
                    if vRP.hasPermission(user_id,"aak103.permissao") then -- Permissão para produzir AK-103
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 250 then
								if vRP.getInventoryItemAmount(user_id,"ak103pack") >= 1 then
									if vRP.tryGetInventoryItem(user_id,"pecadearma",250) and vRP.tryGetInventoryItem(user_id,"ak103pack",1) then
										TriggerClientEvent("fechar-nui-armas",source)
										local descricao = vRP.prompt(source,"Deseja fabricar? (Sim/Nao)","")
										if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
										TriggerClientEvent("progress",source,20000,"PRODUZINDO AK-103")
										vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

										SetTimeout(20000,function()
											vRPclient._stopAnim(source,false)
											vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE",1)
											TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x AK-103</b>.")
										end)
									end
								else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>1x pack</b> para produzir uma <b>AK-103</b>.")
								end
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>250x peças</b> para produzir uma <b>AK-103</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "imbel" then
                    if vRP.hasPermission(user_id,"PERMISSÃO") then -- Permissão para produzir IMBEL
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_CARBINERIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 250 then
                                if vRP.tryGetInventoryItem(user_id,"pecadearma",250) then
                                    TriggerClientEvent("fechar-nui-armas",source)
                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO IMBEL")
                                    vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)
										local descricao = vRP.prompt(source,"Deseja fabricar? (Sim/Nao)","")
										if descricao == "" then return end if descricao == "nao" then return end if descricao == "NAO" then return end if descricao == "NÃO" then return end if descricao == "Nao" then return end if descricao == "não" then return end if descricao == "Não" then return end
										
                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wbody|WEAPON_CARBINERIFLE",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x IMBEL</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>250x peças</b> para produzir uma <b>IMBEL</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "mtar" then
                    if vRP.hasPermission(user_id,"amtar.permissao") then -- Permissão para produzir MTAR
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTSMG") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 200 then
								if vRP.getInventoryItemAmount(user_id,"mtarpack") >= 1 then
									if vRP.tryGetInventoryItem(user_id,"pecadearma",200) and vRP.tryGetInventoryItem(user_id,"mtarpack",1) then
										TriggerClientEvent("fechar-nui-armas",source)
										TriggerClientEvent("progress",source,20000,"PRODUZINDO MTAR")
										vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

										SetTimeout(20000,function()
											vRPclient._stopAnim(source,false)
											vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTSMG",1)
											TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x MTAR</b>.")
										end)
									end
								end	
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>175x peças</b> para produzir uma <b>MTAR</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "sigsauer" then
                    if vRP.hasPermission(user_id,"asig.permissao") then -- Permissão para produzir SIG SAUER
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_COMBATPDW") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 175 then
								if vRP.getInventoryItemAmount(user_id,"sigpack") >= 1 then
									if vRP.tryGetInventoryItem(user_id,"pecadearma",175) and vRP.tryGetInventoryItem(user_id,"sigpack",1) then
										TriggerClientEvent("fechar-nui-armas",source)
										TriggerClientEvent("progress",source,20000,"PRODUZINDO SIG SAUER")
										vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

										SetTimeout(20000,function()
											vRPclient._stopAnim(source,false)
											vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMBATPDW",1)
											TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x SIG SAUER</b>.")
										end)
									end
								else
								TriggerClientEvent("fechar-nui-armas",source)
								TriggerClientEvent("Notify",source,"negado","Você necessita de <b>1x pack</b> para produzir uma<b>SIG SAUER</b>.")	
								end
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>125x peças</b> para produzir uma <b>SIG SAUER</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "smg" then
                    if vRP.hasPermission(user_id,"PERMISSÃO") then -- Permissão para produzir SMG
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SMG") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 125 then
                                if vRP.tryGetInventoryItem(user_id,"pecadearma",125) then
                                    TriggerClientEvent("fechar-nui-armas",source)
                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO SMG")
                                    vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wbody|WEAPON_SMG",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x SMG</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>125x peças</b> para produzir uma <b>SMG</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "microuzi" then
                    if vRP.hasPermission(user_id,"auzi.permissao") then -- Permissão para produzir MICRO UZI
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 125 then
								if vRP.getInventoryItemAmount(user_id,"uzipack") >= 1 then
									if vRP.tryGetInventoryItem(user_id,"pecadearma",125) and vRP.tryGetInventoryItem(user_id,"uzipack",1) then
										TriggerClientEvent("fechar-nui-armas",source)
										TriggerClientEvent("progress",source,20000,"PRODUZINDO MICRO UZI")
										vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

										SetTimeout(20000,function()
											vRPclient._stopAnim(source,false)
											vRP.giveInventoryItem(user_id,"wbody|WEAPON_MICROSMG",1)
											TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x MICRO UZI</b>.")
										end)
									end
								else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>1x pack</b> para produzir uma <b>MICRO UZI</b>.")
								end
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>125x peças</b> para produzir uma <b>MICRO UZI</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "remington" then
                    if vRP.hasPermission(user_id,"apump.permissao") then -- Permissão para produzir SHOTGUN
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PUMPSHOTGUN_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 125 then
								if vRP.getInventoryItemAmount(user_id,"pumpshotgunpack") >= 1 then
									if vRP.tryGetInventoryItem(user_id,"pecadearma",125) and vRP.tryGetInventoryItem(user_id,"pumpshotgunpack",1) then
										TriggerClientEvent("fechar-nui-armas",source)
										TriggerClientEvent("progress",source,20000,"PRODUZINDO REMINGTON")
										vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

										SetTimeout(20000,function()
											vRPclient._stopAnim(source,false)
											vRP.giveInventoryItem(user_id,"wbody|WEAPON_PUMPSHOTGUN_MK2",1)
											TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x REMINGTON</b>.")
										end)
									end
								else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>1x pack</b> para produzir uma <b>REMINGTON</b>.")
								end
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>150x peças</b> para produzir uma <b>REMINGTON</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "pistolsns" then
                    if vRP.hasPermission(user_id,"bordel.permissao") then -- Permissão para produzir SNS
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SNSPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 100 then
								if vRP.getInventoryItemAmount(user_id,"snspack") >= 1 then
									if vRP.tryGetInventoryItem(user_id,"pecadearma",100) and vRP.tryGetInventoryItem(user_id,"snspack",1) then
										TriggerClientEvent("fechar-nui-armas",source)
										TriggerClientEvent("progress",source,20000,"PRODUZINDO PISTOLA SNS")
										vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

										SetTimeout(20000,function()
											vRPclient._stopAnim(source,false)
											vRP.giveInventoryItem(user_id,"wbody|WEAPON_SNSPISTOL",1)
											TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x PISTOLA SNS</b>.")
										end)
									end
								else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>1x pack</b> para produzir uma <b>PISTOLA SNS</b>.")
								end	
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>100x peças</b> para produzir uma <b>PISTOLA SNS</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "fiveseven" then
                    if vRP.hasPermission(user_id,"afiveseven.permissao") then -- Permissão para produzir five-seven
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 75 then
								if vRP.getInventoryItemAmount(user_id,"fivesevenpack") >= 1 then
									if vRP.tryGetInventoryItem(user_id,"pecadearma",75) and vRP.tryGetInventoryItem(user_id,"fivesevenpack",1) then
										TriggerClientEvent("fechar-nui-armas",source)
										TriggerClientEvent("progress",source,20000,"PRODUZINDO PISTOLA FIVE-SEVEN")
										vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

										SetTimeout(20000,function()
											vRPclient._stopAnim(source,false)
											vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",1)
											TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x PISTOLA FIVE-SEVEN</b>.")
										end)
									end
								else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>1x pack</b> para produzir uma <b>PISTOLA FIVE-SEVEN</b>.")
								end
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você necessita de <b>75x peças</b> para produzir uma <b>PISTOLA FIVE-SEVEN</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
                elseif item == "m1911" then
                    if vRP.hasPermission(user_id,"PERMISSÃO") then -- Permissão para produzir M1911
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 50 then
                                if vRP.tryGetInventoryItem(user_id,"pecadearma",50) then
                                    TriggerClientEvent("fechar-nui-armas",source)
                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO PISTOLA M1911")
                                    vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)

                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você fabricou <b>1x PISTOLA M1911</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("fechar-nui-armas",source)
                                TriggerClientEvent("Notify",source,"negado","Você de <b>50x peças</b> para produzir uma <b>PISTOLA M1911</b>.")
                            end
                        else
                            TriggerClientEvent("fechar-nui-armas",source)
                            TriggerClientEvent("Notify",source,"negado","Você está sem espaço na <b>mochila</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta arma.")
                    end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mercadonegro.permissao") then -- AQUI VOCÊ COLOCA TODAS AS PERMISSÕES
        return true
    end
end