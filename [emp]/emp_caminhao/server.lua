local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_caminhao",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local gas = 1
local carros = 1
local show = 1
local madeira = 1
local diesel = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local paylist = {
	["diesel"] = {
		[1] = { pay = math.random(920,940) },
		[2] = { pay = math.random(720,740) },
		[3] = { pay = math.random(720,740) },
		[4] = { pay = math.random(860,880) },
		[5] = { pay = math.random(1200,1220) },
		[6] = { pay = math.random(600,620) }
	},
	["gas"] = {
		[1] = { pay = math.random(750,760) },
		[2] = { pay = math.random(550,570) },
		[3] = { pay = math.random(470,490) },
		[4] = { pay = math.random(265,285) },
		[5] = { pay = math.random(215,235) },
		[6] = { pay = math.random(345,365) },
		[7] = { pay = math.random(245,265) },
		[8] = { pay = math.random(265,275) },
		[9] = { pay = math.random(265,275) },
		[10] = { pay = math.random(720,740) },
		[11] = { pay = math.random(835,855) },
		[12] = { pay = math.random(600,620) }
	},
	["carros"] = {
		[1] = { pay = math.random(445,465) },
		[2] = { pay = math.random(260,280) },
		[3] = { pay = math.random(390,410) },
		[4] = { pay = math.random(602,622) },
		[5] = { pay = math.random(602,622) }
	},
	["madeira"] = {
		[1] = { pay = math.random(1083,1103)},
		[2] = { pay = math.random(840,860) },
		[3] = { pay = math.random(221,241) },
		[4] = { pay = math.random(521,541) }
	},
	["show"] = {
		[1] = { pay = math.random(552,572) },
		[2] = { pay = math.random(440,460) },
		[3] = { pay = math.random(471,491) },
		[4] = { pay = math.random(458,478) }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(id,mod)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveMoney(user_id,parseInt(paylist[mod][id].pay))
		if mod == "carros" then
			local value = vRP.getSData("meta:concessionaria")
			local metas = json.decode(value) or 0
			if metas then
				vRP.setSData("meta:concessionaria",json.encode(parseInt(metas+1)))
			end
		end
		if vRP.tryGetInventoryItem(user_id,"rebite",1) then
			vRP.giveInventoryItem(user_id,"dinheirosujo",math.random(100,150))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300000)
		diesel = math.random(#paylist["diesel"])
		gas = math.random(#paylist["gas"])
		carros = math.random(#paylist["carros"])
		madeira = math.random(#paylist["madeira"])
		show = math.random(#paylist["show"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETTRUCKPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.getTruckpoint(point)
	if point == "diesel" then
		return parseInt(diesel)
	elseif point == "gas" then
		return parseInt(gas)
	elseif point == "carros" then
		return parseInt(carros)
	elseif point == "madeira" then
		return parseInt(madeira)
	elseif point == "show" then
		return parseInt(show)
	end
end