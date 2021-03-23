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
Tunnel.bindInterface("penguin_municoes",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local municoes = {
    { item = "capsulas" },
    { item = "polvora" },
    { item = "kitcostura" },
	{ item = "m-ak103" },
	{ item = "m-mtar" },
	{ item = "m-imbel" },
    { item = "m-thompson" },
    { item = "m-zig" },
    { item = "m-smg" },
    { item = "m-microuzi" },
    { item = "m-shotgun" },
    { item = "m-fiveseven" },
    { item = "m-snspistol" },
    { item = "m-pistol" },
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-municao")
AddEventHandler("produzir-municao",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(municoes) do
            if item == v.item then
                if item == "capsulas" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capsulas") <= vRP.getInventoryMaxWeight(user_id) then
                            TriggerClientEvent("fechar-nui-municao",source)

                            TriggerClientEvent("progress",source,20000,"PRODUZINDO AS CAPSULAS")
                            TriggerClientEvent("bancada-municao:posicao2",source)
                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                        SetTimeout(20000,function()
                            vRPclient._stopAnim(source,false)
                            vRP.giveInventoryItem(user_id,"capsulas",20)
                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>20x Capsulas</b>.")
                        end)
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na <b>mochila</b>.")
                    end   
				elseif item == "kitcostura" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("kitcostura") <= vRP.getInventoryMaxWeight(user_id) then
                            TriggerClientEvent("fechar-nui-municao",source)

                            TriggerClientEvent("progress",source,20000,"PRODUZINDO o KIT COSTURA")
                            TriggerClientEvent("bancada-municao:posicao2",source)
                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                        SetTimeout(20000,function()
                            vRPclient._stopAnim(source,false)
                            vRP.giveInventoryItem(user_id,"kitcostura",1)
                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>1x KitCostura</b>.")
                        end)
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na <b>mochila</b>.")
                    end
                elseif item == "polvora" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("polvora") <= vRP.getInventoryMaxWeight(user_id) then
                            TriggerClientEvent("fechar-nui-municao",source)

                            TriggerClientEvent("progress",source,20000,"PENERANDO A POLVORA")
                            TriggerClientEvent("bancada-municao:posicao2",source)
                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                        SetTimeout(20000,function()
                            vRPclient._stopAnim(source,false)
                            vRP.giveInventoryItem(user_id,"polvora",20)
                            TriggerClientEvent("Notify",source,"sucesso","Você penerou <b>20x Polvoras</b>.")
                        end)
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na <b>mochila</b>.")
                    end
                elseif item == "m-ak103" then
                    if vRP.hasPermission(user_id,"ak.permissao") then -- Permissão para produzir munição de AK-103
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 125 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 200 then
									if vRP.getInventoryItemAmount(user_id,"municaoakpack") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"capsulas",125) and vRP.tryGetInventoryItem(user_id,"polvora",200) and vRP.tryGetInventoryItem(user_id,"municaoakpack",1) then
											TriggerClientEvent("fechar-nui-municao",source)

											TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE AK-103")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(20000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTRIFLE",100)
												TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de AK-103</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Pack</b>.")
									end		
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>125x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-mtar" then
                    if vRP.hasPermission(user_id,"mtar.permissao") then -- Permissão para produzir munição de MTAR
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTSMG") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 125 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 200 then
									if vRP.getInventoryItemAmount(user_id,"municaofamaspack") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"capsulas",125) and vRP.tryGetInventoryItem(user_id,"polvora",200) and vRP.tryGetInventoryItem(user_id,"municaofamaspack",1) then
											TriggerClientEvent("fechar-nui-municao",source)

											TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE MTAR")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(20000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTSMG",100)
												TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de MTAR</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Pack</b>.")
									end	
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>125x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-imbel" then
                    if vRP.hasPermission(user_id,"PERMISSÃO") then -- Permissão para produzir munição de IMBEL
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_CARBINERIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 125 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 200 then
                                    if vRP.tryGetInventoryItem(user_id,"capsulas",125) and vRP.tryGetInventoryItem(user_id,"polvora",200) then
                                        TriggerClientEvent("fechar-nui-municao",source)

                                        TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE IMBEL")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(20000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"wammo|WEAPON_CARBINERIFLE",100)
                                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de IMBEL</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>125x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-zig" then
                    if vRP.hasPermission(user_id,"sig.permissao") then -- Permissão para produzir munição de SIG SAUER
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_COMBATPDW") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 125 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 200 then
												if vRP.getInventoryItemAmount(user_id,"municaosigpack") >= 1 then
													if vRP.tryGetInventoryItem(user_id,"capsulas",125) and vRP.tryGetInventoryItem(user_id,"polvora",200) and vRP.tryGetInventoryItem(user_id,"municaosigpack",1) then
														TriggerClientEvent("fechar-nui-municao",source)

														TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE SIG SAUER")
														vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

														SetTimeout(20000,function()
															vRPclient._stopAnim(source,false)
															vRP.giveInventoryItem(user_id,"wammo|WEAPON_COMBATPDW",100)
															TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de SIG SAUER</b>.")
														end)
													end	
												else
												TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Pack</b>.")
												end	
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>125x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-smg" then
                    if vRP.hasPermission(user_id,"PERMISSÃO") then -- Permissão para produzir munição de SMG
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_SMG") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 20 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then
                                    if vRP.tryGetInventoryItem(user_id,"capsulas",20) or vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                        TriggerClientEvent("fechar-nui-municao",source)

                                        TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE SMG")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(20000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"wammo|WEAPON_SMG",20)
                                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de SMG</b>.")
                                        end)
                                    else
										TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Pack</b>.")
									end	
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-microuzi" then
                    if vRP.hasPermission(user_id,"uzi.permissao") then -- Permissão para produzir munição de MICRO UZI
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 125 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 200 then
									if vRP.getInventoryItemAmount(user_id,"municaouzipack") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"capsulas",125) and vRP.tryGetInventoryItem(user_id,"polvora",200)  and vRP.tryGetInventoryItem(user_id,"municaouzipack",1) then
											TriggerClientEvent("fechar-nui-municao",source)

											TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE MICRO UZI")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(20000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wammo|WEAPON_MICROSMG",100)
												TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de MICRO UZI</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Pack</b>.")
									end	
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>125x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-shotgun" then
                    if vRP.hasPermission(user_id,"shotgun.permissao") then -- Permissão para produzir munição de SHOTGUN
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_PUMPSHOTGUN_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 125 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 200 then
									if vRP.getInventoryItemAmount(user_id,"municaopumppack") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"capsulas",125) and vRP.tryGetInventoryItem(user_id,"polvora",200) and vRP.tryGetInventoryItem(user_id,"municaopumppack",1) then
											TriggerClientEvent("fechar-nui-municao",source)

											TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE SHOTGUN")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(20000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wammo|WEAPON_PUMPSHOTGUN_MK2",100)
												TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de SHOTGUN</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Pack</b>.")
									end	
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>125x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-fiveseven" then
                    if vRP.hasPermission(user_id,"fiveseven.permissao") then -- Permissão para produzir munição de FIVE-SEVEN
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 125 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 200 then
									if vRP.getInventoryItemAmount(user_id,"municaopistolpack") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"capsulas",125) and vRP.tryGetInventoryItem(user_id,"polvora",200) and vRP.tryGetInventoryItem(user_id,"municaopistolpack",1) then
											TriggerClientEvent("fechar-nui-municao",source)

											TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE FIVE-SEVEN")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(20000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wammo|WEAPON_PISTOL_MK2",125)
												TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de FIVE-SEVEN</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Pack</b>.")
									end	
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>125x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-snspistol" then
                    if vRP.hasPermission(user_id,"bordel.permissao") then -- Permissão para produzir munição de SNS PISTOL
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_SNSPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 125 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 200 then
									if vRP.getInventoryItemAmount(user_id,"municaosnspack") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"capsulas",125) and vRP.tryGetInventoryItem(user_id,"polvora",200) and vRP.tryGetInventoryItem(user_id,"municaosnspack",1) then
											TriggerClientEvent("fechar-nui-municao",source)

											TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÕES DE SNS PISTOL")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(20000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wammo|WEAPON_SNSPISTOL",125)
												TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Munições de SNS PISTOL</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Pack de SNS PISTOL</b>.")
									end	
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>200x Polvoras peneradas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>125x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
                    end
                elseif item == "m-pistol" then
                    if vRP.hasPermission(user_id,"2colete.permissao") then -- Permissão para produzir Colete
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"kitcostura") >= 5 then
                                if vRP.getInventoryItemAmount(user_id,"coletepack") >= 1 then
                                    if vRP.tryGetInventoryItem(user_id,"kitcostura",5) and vRP.tryGetInventoryItem(user_id,"coletepack",1) then
                                        TriggerClientEvent("fechar-nui-municao",source)

                                        TriggerClientEvent("progress",source,20000,"PRODUZINDO COLETE")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(20000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"colete",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Coletes</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x Kit Costura</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Colete Pack</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para <b>produzir</b> esta munição.")
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