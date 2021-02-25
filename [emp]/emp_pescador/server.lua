local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_pescador",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local peixes = {
	[1] = { x = "dourado" },
	[2] = { x = "salmao" },
	[3] = { x = "pacu" },
	[4] = { x = "pintado" },
	[5] = { x = "pirarucu" },
	[6] = { x = "tilapia" },
	[7] = { x = "tucunare" }
}

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dourado") <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,"isca",1) then
				if math.random(100) >= 98 then
					vRP.giveInventoryItem(user_id,"lambari",1)
				else
					vRP.giveInventoryItem(user_id,peixes[math.random(7)].x,1)
				end
				return true
			end
		end
	end
end