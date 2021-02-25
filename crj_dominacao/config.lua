-- Credits By Fume
-- My Comunity Discord ESX: discord.me/sagresroleplayesxpt
-- My Comunity Discord VRP: discord.me/sagresroleplaypt
-- My Discord: Fume#0581

Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,
	x = 1.0, y = 1.0, z = 1.5,
	DrawDistance = 15.0, Type = 1
}

Config.GangNumberRequired = 1
Config.TimerBeforeNewDominacao = 1800

Config.MaxDistance    = 20
Config.GiveBlackMoney = true

Bairros = {
	["paleto_twentyfourseven"] = {
		position = { x = 1736.32, y = 6419.47, z = 35.03 },
		reward = math.random(5000, 35000),
		nameOfBairro = "24/7. (Paleto Bay)",
		secondsRemaining = 350,
		lastDominada = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(3000, 20000),
		nameOfBairro = "24/7. (Sandy Shores)",
		secondsRemaining = 200,
		lastDominada = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { x = -709.17, y = -904.21, z = 19.21 },
		reward = math.random(3000, 20000),
		nameOfBairro = "24/7. (Little Seoul)",
		secondsRemaining = 200,
		lastDominada = 0
	},
}
