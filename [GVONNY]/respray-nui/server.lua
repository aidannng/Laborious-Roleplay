ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('vehicleGetInterior', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT props FROM bbvehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
		if result[1] then
			local props = json.decode(result[1].props)
			print("getting props from database")
			for key,value in pairs(props) do
				if(key == "modTrimA") then
					print(key, value)
				end
				if(key == "modBackWheels") then
					print(key, value)
				end
				if(key == "modLivery") then
					print(key, livery)
				end
				if(key == "modFrontWheels") then
					print(key, value)
				end
			end
			cb(props)
		else
			print("no plate found")
			cb(nil)
		end
	end)
end)


RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT model FROM bbvehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local hash = GetHashKey(result[1].model)
			if vehicleProps.model == hash then
				print("updating database")
				for key,value in pairs(vehicleProps) do
					if(key == "modTrimA") then
						print(key, value)
					end
					if(key == "modLivery") then
						print(key, value)
					end
					if(key == "modBackWheels") then
						print(key, value)
					end
					if(key == "modFrontWheels") then
						print(key, value)
					end
				end
				MySQL.Async.execute('UPDATE bbvehicles SET props = @props WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@props'] = json.encode(vehicleProps)
				})
			else
				print(('esx_lscustom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

RegisterServerEvent("getInteriorColor")
AddEventHandler("getInteriorColor", function(plate)
	MySQL.Async.fetchAll('SELECT props FROM bbvehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
		if result[1] then
			local props = json.decode(result[1].props)
			for key,value in pairs(props) do
				if(key == "modTrimA") then
					print(key, value)

				end
			end
		else
			print("no plate found")
		end
	end)
end)

