ESX = nil
local Vehicles

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)

	if Config.IsMecanoJobOnly then

		local societyAccount = nil
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			societyAccount = account
		end)
		if price < societyAccount.money then
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('purchased'), style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

			societyAccount.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)		
			TriggerClientEvent("mythic_notify:client:SendAlert", _source, { type = 'error', text = _U('not_enough_money') })

		end

	else

		if price < xPlayer.getMoney() then
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('purchased'), style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
			xPlayer.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
			TriggerClientEvent("mythic_notify:client:SendAlert", _source, { type = 'error', text = _U('not_enough_money') })

		end

	end
end)

--[[ RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM bbvehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE bbvehicles SET props = @props WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@props'] = json.encode(vehicleProps)
				})
			else
				print(('esx_lscustom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end) ]]

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].bennys
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

ESX.RegisterServerCallback('esx_lscustom:getprops', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT props FROM bbvehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
		if(result and #result>0) then
			cb(result[1].props)
		end
	end)
end)

ESX.RegisterServerCallback('lsc:getcash', function(source, cb, player)
	local xPlayer = ESX.GetPlayerFromId(source)
	local cash = xPlayer.getMoney()
	cb(cash)
end)

RegisterServerEvent("lsc:chargerepair")
AddEventHandler("lsc:chargerepair", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	--local cash = xPlayer.removeMoney(250)
end)