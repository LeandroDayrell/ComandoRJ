local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("vrp_trafico",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,perm)
end

local src = {
	-- FACÇÃO DROGAS
		-- CV
	[1] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "adubo", ['itemqtd'] = 1 },
	[2] = { ['re'] = "adubo", ['reqtd'] = 1, ['item'] = "cannabis", ['itemqtd'] = 2 },
	[3] = { ['re'] = "cannabis", ['reqtd'] = 2, ['item'] = "maconha", ['itemqtd'] = 3 },
		--TCP
	[4] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "anfetamina", ['itemqtd'] = 1 },
	[5] = { ['re'] = "anfetamina", ['reqtd'] = 1, ['item'] = "metasuja", ['itemqtd'] = 2 },
	[6] = { ['re'] = "metasuja", ['reqtd'] = 2, ['item'] = "metanfetamina", ['itemqtd'] = 3 },
		--ADA
	[7] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "acetofenetidina", ['itemqtd'] = 1 },
	[8] = { ['re'] = "acetofenetidina", ['reqtd'] = 1, ['item'] = "pastadecoca", ['itemqtd'] = 2 },
	[9] = { ['re'] = "pastadecoca", ['reqtd'] = 2, ['item'] = "cocaina", ['itemqtd'] = 3 },
		--PCC
	[10] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "adubo", ['itemqtd'] = 1 },
	[11] = { ['re'] = "adubo", ['reqtd'] = 1, ['item'] = "pastadecrack", ['itemqtd'] = 2 },
	[12] = { ['re'] = "pastadecrack", ['reqtd'] = 2, ['item'] = "pedradecrack", ['itemqtd'] = 3 },
		--TCA
	[13] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "papoula", ['itemqtd'] = 1 },
	[14] = { ['re'] = "papoula", ['reqtd'] = 1, ['item'] = "leitedepapoula", ['itemqtd'] = 2 },
	[15] = { ['re'] = "leitedepapoula", ['reqtd'] = 2, ['item'] = "opio", ['itemqtd'] = 3 },
	------ORGANIZAÇÕES
		-- LOWRIDER 
	[16] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "radiador", ['itemqtd'] = 1 },
	[17] = { ['re'] = "radiador", ['reqtd'] = 1, ['item'] = "motor", ['itemqtd'] = 2 },
	[18] = { ['re'] = "motor", ['reqtd'] = 2, ['item'] = "pecasroubada", ['itemqtd'] = 3 },
	
		--JORNAL
	[19] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "jornal", ['itemqtd'] = 3 },
		--VANILLA
	--[20] = { ['re'] = "snspack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_SNSPISTOL", ['itemqtd'] = 1 },
	--[21] = { ['re'] = "municaosnspack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_SNSPISTOL", ['itemqtd'] = 50 },
		-- YAKUZA
	--[22] = { ['re'] = "pumpshotgunpack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_PUMPSHOTGUN_MK2", ['itemqtd'] = 1 },
	--[23] = { ['re'] = "uzipack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_MICROSMG", ['itemqtd'] = 1 },
	--[24] = { ['re'] = "coletepack", ['reqtd'] = 1, ['item'] = "colete", ['itemqtd'] = 1 },
	--[25] = { ['re'] = "municaopistolpack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_PISTOL_MK2", ['itemqtd'] = 50 },
	--[26] = { ['re'] = "municaoakpack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_ASSAULTRIFLE", ['itemqtd'] = 50 },
	--[27] = { ['re'] = "municaosigpack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_COMBATPDW", ['itemqtd'] = 50 },
		-- MAFIA
	--[28] = { ['re'] = "ak103pack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_ASSAULTRIFLE", ['itemqtd'] = 1 },
	--[29] = { ['re'] = "fivesevenpack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_PISTOL_MK2", ['itemqtd'] = 1 },
	--[30] = { ['re'] = "sigpack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_COMBATPDW", ['itemqtd'] = 1 },
	--[31] = { ['re'] = "municaouzipack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_MICROSMG", ['itemqtd'] = 50 }, --
	--[32] = { ['re'] = "municaopumppack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_PUMPSHOTGUN_MK2", ['itemqtd'] = 50 }, --
	--[33] = { ['re'] = "municaofamaspack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_ASSAULTSMG", ['itemqtd'] = 50 }, --
		-- MILICIA
	--[34] = { ['re'] = "uzipack", "polvora", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_MICROSMG", ['itemqtd'] = 1 },
	--[35] = { ['re'] = "sigpack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_COMBATPDW", ['itemqtd'] = 1 },
	--[36] = { ['re'] = "ak103pack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_ASSAULTRIFLE", ['itemqtd'] = 1 },
	--[37] = { ['re'] = "municaofamaspack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_ASSAULTSMG", ['itemqtd'] = 50 },--
	--[38] = { ['re'] = "municaopistolpack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_PISTOL_MK2", ['itemqtd'] = 50 },--
	--[39] = { ['re'] = "municaopumppack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_PUMPSHOTGUN_MK2", ['itemqtd'] = 50 },--
		-- VANILLA
	[40] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "pendriveh", ['itemqtd'] = 3 },
	[41] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "tecidoekitcostura", ['itemqtd'] = 1 },
	[42] = { ['re'] = "tecidoekitcostura", ['reqtd'] = 10, ['item'] = "mochila", ['itemqtd'] = 1 },
		--MC
	--[43] = { ['re'] = "municaoakpack",['reqtd'] = 1, ['item'] = "wammo|WEAPON_ASSAULTRIFLE", ['itemqtd'] = 50 },
	--[44] = { ['re'] = "municaosigpack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_COMBATPDW", ['itemqtd'] = 50 },
	--[45] = { ['re'] = "municaouzipack", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_MICROSMG", ['itemqtd'] = 50 },
	--[46] = { ['re'] = "coletepack", ['reqtd'] = 1, ['item'] = "colete", ['itemqtd'] = 1 },
	--[47] = { ['re'] = "mtarpack", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_ASSAULTSMG", ['itemqtd'] = 1 },
	
}

function func.checkPayment(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if src[id].re ~= nil then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				if vRP.tryGetInventoryItem(user_id,src[id].re,src[id].reqtd,false) then
					vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
					return true
				end
			end
		else
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
				return true
			end
		end
	end
end