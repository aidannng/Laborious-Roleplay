ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('vehicleGetInterior', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT props FROM bbvehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
		if result[1] then
			local props = json.decode(result[1].props)
			cb(props)
		else
			cb(nil)
		end
	end)
end)


RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plate = vehicleProps.plate

	MySQL.Async.fetchAll('SELECT model FROM bbvehicles WHERE plate like \'%'..plate..'%\'', {}, function(result)
		if result[1] then
			local hash = GetHashKey(result[1].model)
			if vehicleProps.model == hash then
				MySQL.Async.execute('UPDATE bbvehicles SET props = @props WHERE plate like \'%'..plate..'%\'', {
					['@props'] = json.encode(vehicleProps)
				})
			else
				print(('esx_lscustom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)