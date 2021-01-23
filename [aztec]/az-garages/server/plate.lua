--[[ az-garages:plate ]]--

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

vAZ.generatePlate = function()
	local generatedPlate
	local doBreak = false
	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
        generatedPlate = string.upper(vAZ.getRandomLetter(3)..vAZ.getRandomNumber(5))
        local vehicle = vRP.query('vAZ/GetPlayerVehiclePlate', {plate = generatedPlate})
        if #vehicle <= 0 then
            doBreak = true
        end
		if doBreak then
			break
		end
	end
	local letters = {}
	for letter in generatedPlate:gmatch'.[\128-\191]*' do
	   table.insert(letters, {letter = letter, rnd = math.random()})
	end
	table.sort(letters, function(a, b) return a.rnd < b.rnd end)
	for i, v in ipairs(letters) do letters[i] = v.letter end
	return table.concat(letters)
end

vAZ.getRandomNumber = function(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return vAZ.getRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

vAZ.getRandomLetter = function(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return vAZ.getRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end