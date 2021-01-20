local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP.prepare("vRP/police_mdt_table",[[
CREATE TABLE IF NOT EXISTS `vrp_tablet_users` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`user_id` int(11) NOT NULL,
	`notes` varchar(255) DEFAULT NULL,
	`photo` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `vrp_tablet_user_condenacoes` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`user_id` int(11) NOT NULL,
	`offense` varchar(255) DEFAULT NULL,
	`count` int(11) DEFAULT NULL,
	
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `vrp_tablet_ocorrencias` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`user_id` int(11) NOT NULL,
	`title` varchar(255) DEFAULT NULL,
	`desc` longtext DEFAULT NULL,
    `charges` longtext DEFAULT NULL,
    `author` varchar(255) DEFAULT NULL,
	`name` varchar(255) DEFAULT NULL,
    `date` varchar(255) DEFAULT NULL,
    `jailtime` int(11) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `vrp_tablet_mandados` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`user_id` int(11) NOT NULL,
	`name` varchar(255) DEFAULT NULL,
	`report_id` int(11) DEFAULT NULL,
	`report_title` varchar(255) DEFAULT NULL,
	`charges` longtext DEFAULT NULL,
	`date` varchar(255) DEFAULT NULL,
	`expire` varchar(255) DEFAULT NULL,
	`notes` varchar(255) DEFAULT NULL,
	`author` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`id`)
);
	
CREATE TABLE IF NOT EXISTS `vrp_tablet_multas` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`title` varchar(255) NOT NULL,
	`amount` int(11) NOT NULL,
	`jailtime` int(11) NOT NULL,
	
	PRIMARY KEY (`id`)
);
]])

async(function()
  vRP.execute("vRP/police_mdt_table")
end)

--[[TriggerEvent('es:addCommand', 'mdt', function(source, args, user)
	local usource = source
    -- local xPlayer = ESX.GetPlayerFromId(source)
    -- if xPlayer.job.name == 'police' then
    	MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `vrp_tablet_ocorrencias` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(reports)
    		for r = 1, #reports do
    			reports[r].charges = json.decode(reports[r].charges)
    		end
    		MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `vrp_tablet_mandados` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(warrants)
    			for w = 1, #warrants do
    				warrants[w].charges = json.decode(warrants[w].charges)
    			end


    			local officer = GetCharacterName(usource)
    			TriggerClientEvent('mdt:toggleVisibilty', usource, reports, warrants, officer)
    		end)
    	end)
    -- end
end)]]
RegisterServerEvent("mdt:insertFine")
AddEventHandler("mdt:insertFine", function(nome, multa, tempo)
	local usource = source
	local user_id = vRP.getUserId(usource)
	if vRP.hasPermission(user_id,"policia.permissao") then
		MySQL.Async.insert('INSERT INTO `vrp_tablet_multas` (`title`, `amount`, `jailtime`) VALUES (@title, @amount, @jailtime)', {
			['@title'] = nome,
			['@amount'] = multa,
			['@jailtime'] = tempo
		}, function()
			TriggerClientEvent("Notify", usource, "negado", "Multa ("..nome..") cadastrada.")
		end)
	else
		TriggerClientEvent("Notify", usource, "negado", "Não possui permissão para este comando")
	end
end)
RegisterServerEvent("mdt:hotKeyOpen")
AddEventHandler("mdt:hotKeyOpen", function()
	local usource = source
	local user_id = vRP.getUserId(usource)
	if vRP.hasPermission(user_id,"policia.permissao") then
    	MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `vrp_tablet_ocorrencias` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(reports)
    		for r = 1, #reports do
    			reports[r].charges = json.decode(reports[r].charges)
    		end
    		MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `vrp_tablet_mandados` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(warrants)
    			for w = 1, #warrants do
    				warrants[w].charges = json.decode(warrants[w].charges)
    			end


    			local officer = GetCharacterName(usource)
    			TriggerClientEvent('mdt:toggleVisibilty', usource, reports, warrants, officer)
    		end)
    	end)
    end
end)

RegisterServerEvent("mdt:getOffensesAndOfficer")
AddEventHandler("mdt:getOffensesAndOfficer", function()
	local usource = source
	local charges = {}
	MySQL.Async.fetchAll('SELECT * FROM vrp_tablet_multas', {
	}, function(fines)
		for j = 1, #fines do
			table.insert(charges, fines[j])
		end

		local officer = GetCharacterName(usource)

		TriggerClientEvent("mdt:returnOffensesAndOfficer", usource, charges, officer)
	end)
end)

RegisterServerEvent("mdt:performOffenderSearch")
AddEventHandler("mdt:performOffenderSearch", function(query)
	local usource = source
	local matches = {}
	MySQL.Async.fetchAll("SELECT * FROM `vrp_user_identities` WHERE LOWER(`firstname`) LIKE @query OR LOWER(`name`) LIKE @query OR CONCAT(LOWER(`name`), ' ', LOWER(`firstname`)) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt:returnOffenderSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("mdt:getOffenderDetails")
AddEventHandler("mdt:getOffenderDetails", function(offender)
	local usource = source
	MySQL.Async.fetchAll('SELECT * FROM `vrp_user_identities` WHERE `user_id` = @id', {
		['@id'] = offender.user_id
	}, function(result)
		-- GetLicenses(offender.user_id, function(licenses) offender.licenses = licenses end)
		offender.licenses = result[1].registration
		-- while offender.licenses == nil do Citizen.Wait(0) end
		MySQL.Async.fetchAll('SELECT * FROM `vrp_tablet_users` WHERE `user_id` = @id', {
			['@id'] = offender.user_id
		}, function(result)
			offender.notes = ""
			offender.photo = ""
			if result[1] then
				offender.notes = result[1].notes
				offender.photo = result[1].photo
			end
			MySQL.Async.fetchAll('SELECT * FROM `vrp_tablet_user_condenacoes` WHERE `user_id` = @id', {
				['@id'] = offender.user_id
			}, function(convictions)
				if convictions[1] then
					offender.convictions = {}
					for i = 1, #convictions do
						local conviction = convictions[i]
						offender.convictions[conviction.offense] = conviction.count
					end
				end

				MySQL.Async.fetchAll('SELECT * FROM `vrp_tablet_mandados` WHERE `user_id` = @id', {
					['@id'] = offender.user_id
				}, function(warrants)
					if warrants[1] then
						offender.haswarrant = true
					end

					TriggerClientEvent("mdt:returnOffenderDetails", usource, offender)
				end)
			end)
		end)
	end)
end)

RegisterServerEvent("mdt:getOffenderDetailsById")
AddEventHandler("mdt:getOffenderDetailsById", function(user_id)
	local usource = source
	MySQL.Async.fetchAll('SELECT * FROM `vrp_user_identities` WHERE `user_id` = @id', {
		['@id'] = user_id
	}, function(result)
		-- GetLicenses(offender.user_id, function(licenses) offender.licenses = licenses end)
		offender = result[1]
		offender.licenses = result[1].registration
		-- while offender.licenses == nil do Citizen.Wait(0) end
		MySQL.Async.fetchAll('SELECT * FROM `vrp_tablet_users` WHERE `user_id` = @id', {
			['@id'] = offender.user_id
		}, function(result)
			offender.notes = ""
			offender.photo = ""
			if result[1] then
				offender.notes = result[1].notes
				offender.photo = result[1].photo
			end
			MySQL.Async.fetchAll('SELECT * FROM `vrp_tablet_user_condenacoes` WHERE `user_id` = @id', {
				['@id'] = offender.user_id
			}, function(convictions)
				if convictions[1] then
					offender.convictions = {}
					for i = 1, #convictions do
						local conviction = convictions[i]
						offender.convictions[conviction.offense] = conviction.count
					end
				end

				MySQL.Async.fetchAll('SELECT * FROM `vrp_tablet_mandados` WHERE `user_id` = @id', {
					['@id'] = offender.user_id
				}, function(warrants)
					if warrants[1] then
						offender.haswarrant = true
					end

					TriggerClientEvent("mdt:returnOffenderDetails", usource, offender)
				end)
			end)
		end)
	end)
end)

RegisterServerEvent("mdt:saveOffenderChanges")
AddEventHandler("mdt:saveOffenderChanges", function(id, changes, identifier)
	MySQL.Async.fetchAll('SELECT * FROM `vrp_tablet_users` WHERE `user_id` = @id', {
		['@id']  = id
	}, function(result)
		if result[1] then
			MySQL.Async.execute('UPDATE `vrp_tablet_users` SET `notes` = @notes, `photo` = @photo WHERE `user_id` = @id', {
				['@id'] = id,
				['@notes'] = changes.notes,
				['@photo'] = changes.photo
			})
		else
			MySQL.Async.insert('INSERT INTO `vrp_tablet_users` (`user_id`, `notes`, `photo`) VALUES (@id, @notes, @photo)', {
				['@id'] = id,
				['@notes'] = changes.notes,
				['@photo'] = changes.photo
			})
		end
		for i = 1, #changes.licenses_removed do
			local license = changes.licenses_removed[i]
			MySQL.Async.execute('DELETE FROM `user_licenses` WHERE `type` = @type AND `owner` = @identifier', {
				['@type'] = license.type,
				['@identifier'] = identifier
			})
		end
		
		if changes.convictions then
			for conviction, amount in pairs(changes.convictions) do	
				MySQL.Async.execute('UPDATE `vrp_tablet_user_condenacoes` SET `count` = @count WHERE `user_id` = @id AND `offense` = @offense', {
					['@id'] = id,
					['@count'] = amount,
					['@offense'] = conviction
				})
			end
		end

		for i = 1, #changes.convictions_removed do
			MySQL.Async.execute('DELETE FROM `vrp_tablet_user_condenacoes` WHERE `user_id` = @id AND `offense` = @offense', {
				['@id'] = id,
				['offense'] = changes.convictions_removed[i]
			})
		end
	end)
end)

RegisterServerEvent("mdt:saveReportChanges")
AddEventHandler("mdt:saveReportChanges", function(data)
	MySQL.Async.execute('UPDATE `vrp_tablet_ocorrencias` SET `title` = @title, `desc` = @desc WHERE `id` = @id', {
		['@id'] = data.id,
		['@title'] = data.title,
		['@desc'] = data.desc
	})
end)

RegisterServerEvent("mdt:deleteReport")
AddEventHandler("mdt:deleteReport", function(id)
	MySQL.Async.execute('DELETE FROM `vrp_tablet_ocorrencias` WHERE `id` = @id', {
		['@id']  = id
	})
end)

RegisterServerEvent("mdt:submitNewReport")
AddEventHandler("mdt:submitNewReport", function(data)
	local usource = source
	local author = GetCharacterName(source)
	if tonumber(data.sentence) and tonumber(data.sentence) > 0 then
		data.sentence = tonumber(data.sentence)
	else 
		data.sentence = nil 
	end
	charges = json.encode(data.charges)
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	MySQL.Async.insert('INSERT INTO `vrp_tablet_ocorrencias` (`user_id`, `title`, `desc`, `charges`, `author`, `name`, `date`, `jailtime`) VALUES (@id, @title, @desc, @charges, @author, @name, @date, @sentence)', {
		['@id']  = data.user_id,
		['@title'] = data.title,
		['@desc'] = data.desc,
		['@charges'] = charges,
		['@author'] = author,
		['@name'] = data.name,
		['@date'] = data.date,
		['@sentence'] = data.sentence
	}, function(id)
		TriggerEvent("mdt:getReportDetailsById", id, usource)
	end)

	for offense, count in pairs(data.charges) do
		MySQL.Async.fetchAll('SELECT * FROM `vrp_tablet_user_condenacoes` WHERE `offense` = @offense AND `user_id` = @id', {
			['@offense'] = offense,
			['@id'] = data.user_id
		}, function(result)
			if result[1] then
				MySQL.Async.execute('UPDATE `vrp_tablet_user_condenacoes` SET `count` = @count WHERE `offense` = @offense AND `user_id` = @id', {
					['@id']  = data.user_id,
					['@offense'] = offense,
					['@count'] = count + 1
				})
			else
				MySQL.Async.insert('INSERT INTO `vrp_tablet_user_condenacoes` (`user_id`, `offense`, `count`) VALUES (@id, @offense, @count)', {
					['@id']  = data.user_id,
					['@offense'] = offense,
					['@count'] = count
				})
			end
		end)
	end
end)

RegisterServerEvent("mdt:sentencePlayer")
AddEventHandler("mdt:sentencePlayer", function(jailtime, charges, user_id, fine, players)
	local usource = source
	local jailmsg = ""
	for offense, amount in pairs(charges) do
		jailmsg = jailmsg .. " "..offense.." x"..amount.." |"
	end
	for _, src in pairs(players) do
		if src ~= 0 and GetPlayerName(src) then
			-- MySQL.Async.fetchAll('SELECT * FROM `characters` WHERE `identifier` = @identifier', {
				-- ['@identifier'] = GetPlayerIdentifiers(src)[1]
			-- }, function(result)
				-- if result[1].id == user_id then
					if jailtime and jailtime > 0 then
						jailtime = math.ceil(jailtime)
						
						TriggerEvent("vrp_policia:prender",user_id,jailtime,jailmsg)
					end
					if fine > 0 then
						vRP.tryFullPayment(user_id, fine)
						-- TriggerClientEvent("mdt:billPlayer", usource, src, 'society_police', 'Multado: '..jailmsg, fine)
					end
					return
				-- end
			-- end)
		end
	end
end)

RegisterServerEvent("mdt:performReportSearch")
AddEventHandler("mdt:performReportSearch", function(query)
	local usource = source
	local matches = {}
	MySQL.Async.fetchAll("SELECT * FROM `vrp_tablet_ocorrencias` WHERE `id` LIKE @query OR LOWER(`title`) LIKE @query OR LOWER(`name`) LIKE @query OR LOWER(`author`) LIKE @query or LOWER(`charges`) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			data.charges = json.decode(data.charges)
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt:returnReportSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("mdt:performVehicleSearch")
AddEventHandler("mdt:performVehicleSearch", function(query)
	local usource = source
	local matches = {}
	MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` WHERE LOWER(`plate`) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			local data_decoded = json.decode(data.vehicle)
			data.model = data_decoded.model
			if data_decoded.color1 then
				data.color = colors[tostring(data_decoded.color1)]
				if colors[tostring(data_decoded.color2)] then
					data.color = colors[tostring(data_decoded.color2)] .. " on " .. colors[tostring(data_decoded.color1)]
				end
			end
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt:returnVehicleSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("mdt:performVehicleSearchInFront")
AddEventHandler("mdt:performVehicleSearchInFront", function(query)
	local usource = source
	-- local xPlayer = ESX.GetPlayerFromId(usource)
    -- if xPlayer.job.name == 'police' then
		MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` WHERE `plate` = @query", {
			['@query'] = query
		}, function(result)
			TriggerClientEvent("mdt:toggleVisibilty", usource)
			TriggerClientEvent("mdt:returnVehicleSearchInFront", usource, result, query)
		end)
	-- end
end)

RegisterServerEvent("mdt:getVehicle")
AddEventHandler("mdt:getVehicle", function(vehicle)
	local usource = source
	MySQL.Async.fetchAll("SELECT * FROM `vrp_user_identities` WHERE `user_id` = @user_id", {
		['@user_id'] = vehicle.owner
	}, function(result)
		if result[1] then
			vehicle.owner = result[1].name .. ' ' .. result[1].firstname
			vehicle.owner_id = result[1].id
		end

		vehicle.type = types[vehicle.type]
		TriggerClientEvent("mdt:returnVehicleDetails", usource, vehicle)
	end)
end)

RegisterServerEvent("mdt:getWarrants")
AddEventHandler("mdt:getWarrants", function()
	local usource = source
	MySQL.Async.fetchAll("SELECT * FROM `vrp_tablet_mandados`", {}, function(warrants)
		for i = 1, #warrants do
			warrants[i].expire_time = ""
			warrants[i].charges = json.decode(warrants[i].charges)
		end
		TriggerClientEvent("mdt:returnWarrants", usource, warrants)
	end)
end)

RegisterServerEvent("mdt:submitNewWarrant")
AddEventHandler("mdt:submitNewWarrant", function(data)
	local usource = source
	data.charges = json.encode(data.charges)
	data.author = GetCharacterName(source)
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	MySQL.Async.insert('INSERT INTO `vrp_tablet_mandados` (`name`, `user_id`, `report_id`, `report_title`, `charges`, `date`, `expire`, `notes`, `author`) VALUES (@name, @user_id, @report_id, @report_title, @charges, @date, @expire, @notes, @author)', {
		['@name']  = data.name,
		['@user_id'] = data.user_id,
		['@report_id'] = data.report_id,
		['@report_title'] = data.report_title,
		['@charges'] = data.charges,
		['@date'] = data.date,
		['@expire'] = data.expire,
		['@notes'] = data.notes,
		['@author'] = data.author
	}, function()
		TriggerClientEvent("mdt:completedWarrantAction", usource)
	end)
end)

RegisterServerEvent("mdt:deleteWarrant")
AddEventHandler("mdt:deleteWarrant", function(id)
	local usource = source
	MySQL.Async.execute('DELETE FROM `vrp_tablet_mandados` WHERE `id` = @id', {
		['@id']  = id
	}, function()
		TriggerClientEvent("mdt:completedWarrantAction", usource)
	end)
end)

RegisterServerEvent("mdt:getReportDetailsById")
AddEventHandler("mdt:getReportDetailsById", function(query, _source)
	if _source then source = _source end
	local usource = source
	MySQL.Async.fetchAll("SELECT * FROM `vrp_tablet_ocorrencias` WHERE `id` = @query", {
		['@query'] = query
	}, function(result)
		if result and result[1] then
			result[1].charges = json.decode(result[1].charges)
			TriggerClientEvent("mdt:returnReportDetails", usource, result[1])
		end
	end)
end)

function GetLicenses(identifier, cb)
	cb({})
	--[[MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
		['@owner'] = identifier
	}, function(result)
		local licenses   = {}
		local asyncTasks = {}

		for i=1, #result, 1 do

			local scope = function(type)
				table.insert(asyncTasks, function(cb)
					MySQL.Async.fetchAll('SELECT * FROM licenses WHERE type = @type', {
						['@type'] = type
					}, function(result2)
						table.insert(licenses, {
							type  = type,
							title = result2[1].title
						})

						cb()
					end)
				end)
			end

			scope(result[i].type)

		end

		-- Async.parallel(asyncTasks, function(results)
			if #licenses == 0 then licenses = false end
			cb(licenses)
		-- end)

	end)]]
end

function GetCharacterName(source)
	local source = source
	local user_id = vRP.getUserId(source)
	local result = MySQL.Sync.fetchAll('SELECT name, firstname FROM vrp_user_identities WHERE user_id = @user_id', {
		['@user_id'] = user_id
	})

	if result[1] and result[1].name and result[1].firstname then
		return ('%s %s'):format(result[1].name, result[1].firstname)
	end
end
-- [[!-!]] sp6NlpaWlpaW0pGXkNzGxsnNg8zIz8nOxsjOys3LzsbPzc/HzQ== [[!-!]] --