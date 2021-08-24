ESX = nil
local playersInJail = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	MySQL.Async.fetchAll('SELECT jail_time FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1] and result[1].jail_time > 0 then
			TriggerEvent('labrp_jail:sendToJail', xPlayer.source, result[1].jail_time, true)
		end
	end)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	playersInJail[playerId] = nil
end)

RegisterCommand("jail", function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" then
		local tarPlayer = ESX.GetPlayerFromId(args[1])
		local playerId = tonumber(args[1])
		local time = tonumber(args[2])
		if tarPlayer then
			TriggerEvent('labrp_jail:sendToJail', playerId, time * 60)
			TriggerClientEvent('radial:Jail', playerId)
			MySQL.Async.execute('UPDATE `users` SET `drugrep` = @reputation WHERE `identifier` = @identifier', {
				['@reputation'] = 0,
				['@identifier'] = tarPlayer.identifier,
			}, function()
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Invalid Target' })
		end
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

RegisterNetEvent('labrp_jail:sendToJail')
AddEventHandler('labrp_jail:sendToJail', function(playerId, jailTime)
	local origin = ESX.GetPlayerFromId(source)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if jailTime == 0 or jailTime == nil then
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Invalid Jail Time' })
	else
		TriggerClientEvent('jailintro', playerId)
		Citizen.Wait(27000)
		TriggerEvent('linden_inventory:confiscatePlayerInventory', playerId)
		if xPlayer then
			if not playersInJail[playerId] then
				MySQL.Async.execute('UPDATE users SET jail_time = @jail_time WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@jail_time'] = jailTime
				}, function(rowsChanged)
					playersInJail[playerId] = {timeRemaining = jailTime, identifier = xPlayer.getIdentifier()}
					realtime = jailTime//60
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "You have been jailed for "..realtime.." months, Check you're F1 for Prison Jobs to reduce your time" })
				end)
			end
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
			TriggerClientEvent('labrp_jail:unjail', playerId)
			TriggerClientEvent('radial:UnJail', playerId)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = "You've been released from jail" })
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'This Person is not in jail' })
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		for playerId,data in pairs(playersInJail) do
			playersInJail[playerId].timeRemaining = data.timeRemaining - 1
			local xPlayer = ESX.GetPlayerFromId(playerId)

			MySQL.Async.execute('UPDATE users SET jail_time = @jailtime WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@jailtime'] = data.timeRemaining,
			})

			if data.timeRemaining < 1 then
				unjailPlayer(playerId, false)
			end
		end
	end
end)


ESX.RegisterServerCallback('labrp_jail:checktime', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)

	for playerId,data in pairs(playersInJail) do
		callback(playersInJail[playerId].timeRemaining//60)
	end
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


RegisterServerEvent('show:fingerprint')
AddEventHandler('show:fingerprint', function(TargetID)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(TargetID)
	local name = xTarget.getName()
	local identifier = xTarget.identifier

    MySQL.Async.fetchAll('SELECT `dateofbirth` FROM `users` WHERE `identifier` = @identifier', {
        ['@identifier'] = xTarget.identifier,
    }, function(result)
        if result then
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0}</div>',
				args = { "^*^4Name^0 : "..name.." | ^4DOB^0 : "..result[1].dateofbirth }
			});	
        end
    end)
end)