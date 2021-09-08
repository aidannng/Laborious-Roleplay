if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
	end
end

local countingJobs = {
    ['police'] = true,
    ['fbi'] = true
};

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterNetEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'police' then
		print(('esx_policejob: %s attempted to confiscate!'):format(sourceXPlayer.identifier))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				sourceXPlayer.showNotification(_U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				targetXPlayer.showNotification(_U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			else
				sourceXPlayer.showNotification(_U('quantity_invalid'))
			end
		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		local targetAccount = targetXPlayer.getAccount(itemName)

		-- does the target player have enough money?
		if targetAccount.money >= amount then
			targetXPlayer.removeAccountMoney(itemName, amount)
			sourceXPlayer.addAccountMoney   (itemName, amount)

			sourceXPlayer.showNotification(_U('you_confiscated_account', amount, itemName, targetXPlayer.name))
			targetXPlayer.showNotification(_U('got_confiscated_account', amount, itemName, sourceXPlayer.name))
		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end

		-- does the target player have weapon?
		if targetXPlayer.hasWeapon(itemName) then
			targetXPlayer.removeWeapon(itemName, amount)
			sourceXPlayer.addWeapon   (itemName, amount)

			sourceXPlayer.showNotification(_U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
			targetXPlayer.showNotification(_U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end
	end
end)



RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if countingJobs[xPlayer.job.name] then
		TriggerClientEvent('esx_policejob:handcuff', target)
	else
		print(('esx_policejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:softcufff')
AddEventHandler('esx_policejob:softcufff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if countingJobs[xPlayer.job.name] then
		TriggerClientEvent('esx_policejob:softcuff', target)
	else
		print(('esx_policejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if countingJobs[xPlayer.job.name] then
		TriggerClientEvent('esx_policejob:drag', target, source)
	else
		print(('esx_policejob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)



AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'police')) do
			TriggerClientEvent('esx_policejob:updateBlip', xPlayer.source)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

RegisterNetEvent('removespike')
AddEventHandler('removespike', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('spikestrips', 1)
end)

RegisterNetEvent('pickupspike')
AddEventHandler('pickupspike', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('spikestrips', 1)
end)


RegisterNetEvent('qrp_police:cuffPlayer')
AddEventHandler('qrp_police:cuffPlayer', function(targetNetID)
    local _source = source
    TriggerClientEvent('qrp_police:getCuffed',targetNetID,_source)
    TriggerClientEvent('qrp_police:cuffPed',_source)
end)

RegisterNetEvent('qrp_police:uncuffPlayer')
AddEventHandler('qrp_police:uncuffPlayer', function(targetNetID)
    local _source = source
    TriggerClientEvent('qrp_police:getUncuffed',targetNetID)
    TriggerClientEvent('qrp_police:uncuffPed',_source)
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_policejob:putInVehicle', target)
end)

RegisterServerEvent('labrp_police:drag')
AddEventHandler('labrp_police:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('labrp_police:drag', target, source)
end)

RegisterServerEvent('labrp_police:requestputinbed')
AddEventHandler('labrp_police:requestputinbed', function(target, bed)
	TriggerClientEvent('labrp_police:getinbed', target, bed)
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	TriggerClientEvent('esx_policejob:OutVehicle', target)
end)

ESX.RegisterServerCallback('labrp_police:getpdblip', function(source, cb, LEOCoords)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetExtendedPlayers()
    local generated = {}

    if xPlayer then
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'fbi'then

            for _, xPlayer in pairs(xPlayers) do
                if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'fbi'then
                    generated[_] = {netId = GetEntityCoords(GetPlayerPed(xPlayer.source)), name = xPlayer.name, job = xPlayer.job.name}
                end
            end
            cb(generated)
        end
    end
end)

ESX.RegisterServerCallback('labrp_police:impoundvehicle', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE `owned_vehicles` SET `stored` = @stored, `garage` = @garage WHERE `plate` = @plate', {
        ['@stored'] = 1,
        ['@plate'] = plate,
        ['@garage'] = "Impound"
    }, function(rowsChanged)
    end)
end)