ESX = nil
local playersInJail = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[ AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	MySQL.Async.fetchAll('SELECT jail_time FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1] and result[1].jail_time > 0 then
			TriggerEvent('esx_jail:sendToJail', xPlayer.source, result[1].jail_time, true)
		end
	end)
end) ]]

AddEventHandler('esx:playerDropped', function(playerId, reason)
	playersInJail[playerId] = nil
end)


--[[ ESX.RegisterCommand('jail', 'police', function(xPlayer, args, showError)
	TriggerEvent('esx_jail:sendToJail', args.playerId, args.time * 60)
end, true, {help = 'Jail a player', validate = true, arguments = {
	{name = 'playerId', help = 'player id', type = 'playerId'},
	{name = 'time', help = 'jail time in minutes', type = 'number'}
}}) 

ESX.RegisterCommand('unjail', 'admin', function(xPlayer, args, showError)
	unjailPlayer(args.playerId)
end, true, {help = 'Unjail a player', validate = true, arguments = {
	{name = 'playerId', help = 'player id', type = 'playerId'}
}}) ]]

RegisterCommand("jail", function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" then
		local tarPlayer = ESX.GetPlayerFromId(args[1])
		local playerId = tonumber(args[1])
		local time = tonumber(args[2])
		TriggerEvent('esx_jail:sendToJail', playerId, time * 60)
		MySQL.Async.execute('UPDATE `users` SET `drugrep` = @reputation WHERE `identifier` = @identifier', {
			['@reputation'] = 0,
			['@identifier'] = tarPlayer.identifier,
		}, function()
		end)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You are not a cop!' })
	end
end)

RegisterCommand("unjail", function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" then
		local tarPlayer = ESX.GetPlayerFromId(args[1])
		local targetId = tonumber(args[1])
		unjailPlayer(targetId)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You are not a cop!' })
	end
end)

RegisterNetEvent('esx_jail:sendToJail')
AddEventHandler('esx_jail:sendToJail', function(playerId, jailTime, quiet)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	TriggerClientEvent('jailintro', playerId)
	Citizen.Wait(27000)
	TriggerEvent('linden_inventory:confiscatePlayerInventory', playerId)
	if xPlayer then
		if not playersInJail[playerId] then
			MySQL.Async.execute('UPDATE users SET jail_time = @jail_time WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@jail_time'] = jailTime
			}, function(rowsChanged)
				xPlayer.triggerEvent('esx_policejob:unrestrain')
				xPlayer.triggerEvent('esx_jail:jailPlayer', jailTime)
				playersInJail[playerId] = {timeRemaining = jailTime, identifier = xPlayer.getIdentifier()}

				if not quiet then
					local realTime = jailTime//60
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You have been jailed for '..realTime..' months' })
				end
			end)

		end
	end
end)

function unjailPlayer(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if playersInJail[playerId] then
			MySQL.Async.execute('UPDATE users SET jail_time = 0 WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(rowsChanged)
				playersInJail[playerId] = nil
				xPlayer.triggerEvent('esx_jail:unjailPlayer')
			end)
			TriggerEvent('linden_inventory:recoverPlayerInventory', playerId)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		for playerId,data in pairs(playersInJail) do
			playersInJail[playerId].timeRemaining = data.timeRemaining - 1

			if data.timeRemaining < 1 then
				unjailPlayer(playerId, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.JailTimeSyncInterval)
		local tasks = {}

		for playerId,data in pairs(playersInJail) do
			local task = function(cb)
				MySQL.Async.execute('UPDATE users SET jail_time = @time_remaining WHERE identifier = @identifier', {
					['@identifier'] = data.identifier,
					['@time_remaining'] = data.timeRemaining
				}, function(rowsChanged)
					cb(rowsChanged)
				end)
			end

			table.insert(tasks, task)
		end

		Async.parallelLimit(tasks, 4, function(results) end)
	end
end)

RegisterNetEvent('gettimeleft')
AddEventHandler('gettimeleft', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	--TriggerClientEvent('timeleft', source, jailTime)

	MySQL.Async.execute('UPDATE users SET jail_time = @jail_time WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@time_remaining'] = timeRemaining
	}, function(rowsChanged)
		print(timeRemaining)
		--TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have'..jailTime..' months left' })
	end)

end)


RegisterServerEvent('show:identification')
AddEventHandler('show:identification', function(TargetID)
	local xPlayer = ESX.GetPlayerFromId(source)
	local name = xPlayer.getName()
	local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT `dateofbirth` FROM `users` WHERE `identifier` = @identifier', {
        ['@identifier'] = xPlayer.identifier,
    }, function(result)
        if result then
			TriggerClientEvent('chat:addMessage', TargetID, {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0}</div>',
				args = { "^*^4Name^0 : "..name.." | ^4DOB^0 : "..result[1].dateofbirth }
			});	
        end
    end)
end)

ESX.RegisterServerCallback('labrp_jail:identification', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
	local identifier = xPlayer.identifier
    MySQL.Async.fetchAll('SELECT `dateofbirth` FROM `users` WHERE `identifier` = @identifier', {
        ['@identifier'] = xPlayer.identifier,
    }, function(result)
        if result then
            callback(name, result[1].dateofbirth)
        end
    end)
end)

ESX.RegisterServerCallback('labrp_pdvehicles:checkvin', function(source, callback, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT b.firstname, b.lastname FROM owned_vehicles a, users b WHERE a.plate = @plate AND a.owner = b.identifier', {
        ['@plate'] = plate,
    }, function(result)
        if result and #result>0 then
			local fullname = result[1].firstname..' '..result[1].lastname
            callback(fullname)
		else
			callback('unknown')
        end
    end)
end)