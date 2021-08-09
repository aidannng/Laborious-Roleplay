ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('getVehicleProps', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
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

	MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @props WHERE plate like \'%'..plate..'%\'', {
		['@props'] = json.encode(vehicleProps)
	})
end)