ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_dmvschool:canYouPay', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Prices[type] then
		xPlayer.removeMoney(Config.Prices[type])
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have payed $500 to the DMV School', })
		cb(true)
	else
		cb(false)
	end
end)
  
AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)

RegisterNetEvent('Aidan_isCool:giveKeys')
AddEventHandler('Aidan_isCool:giveKeys', function(plate, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
    xPlayer.triggerEvent("vehiclekeys:client:SetOwner", plate, vehicle) 
	TriggerClientEvent('vehiclekeys:client:ToggleEngine', source)
end)
