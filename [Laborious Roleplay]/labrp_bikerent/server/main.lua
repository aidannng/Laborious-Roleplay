ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- plasma

-- Beach Rentals
RegisterServerEvent('chargeseashark')
AddEventHandler('chargeseashark', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 500 then
		xPlayer.removeMoney(500)
		refundvalue = math.random(350, 500)
		TriggerClientEvent('spawnseashark', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

RegisterServerEvent('chargedinghy')
AddEventHandler('chargedinghy', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 1000 then
		xPlayer.removeMoney(1000)
		refundvalue = math.random(750, 1000)
		TriggerClientEvent('spawndinghy', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

RegisterServerEvent('chargesqualo')
AddEventHandler('chargesqualo', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 1500 then
		xPlayer.removeMoney(1500)
		refundvalue = math.random(1000, 1500)
		TriggerClientEvent('spawnsqualo', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

RegisterServerEvent('chargespeeder')
AddEventHandler('chargespeeder', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 2500 then
		xPlayer.removeMoney(2500)
		refundvalue = math.random(1850, 2500)
		TriggerClientEvent('spawnspeeder', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

RegisterServerEvent('chargedune')
AddEventHandler('chargedune', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 4500 then
	xPlayer.removeMoney(4500)
	refundvalue = math.random(3000, 4000)
	TriggerClientEvent('spawndune', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

-- Dirt Rentals
RegisterServerEvent('chargesanchez')
AddEventHandler('chargesanchez', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 1000 then
		xPlayer.removeMoney(1000)
		refundvalue = math.random(500, 1000)
		TriggerClientEvent('spawnsanchez', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

RegisterServerEvent('chargeblazer')
AddEventHandler('chargeblazer', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 1250 then
		xPlayer.removeMoney(1250)
		refundvalue = math.random(750, 1250)
		TriggerClientEvent('spawnblazer', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

RegisterServerEvent('chargeblazer4')
AddEventHandler('chargeblazer4', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 1750 then
		xPlayer.removeMoney(1750)
		refundvalue = math.random(1250, 1750)
		TriggerClientEvent('spawnblazer4', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

-- BIKE RENTALS --

RegisterServerEvent('chargebmx')
AddEventHandler('chargebmx', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 25 then
		xPlayer.removeMoney(25)
		refundvalue = math.random(10, 25)
		TriggerClientEvent('spawnbmx', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

RegisterServerEvent('chargecruiser')
AddEventHandler('chargecruiser', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count--spawncruiser
	if moneycount >= 30 then
		xPlayer.removeMoney(30)
		refundvalue = math.random(20, 30)
		TriggerClientEvent('spawncruiser', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)	

RegisterServerEvent('chargetri')
AddEventHandler('chargetri', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 40 then
		xPlayer.removeMoney(40)
		refundvalue = math.random(30, 40)
		TriggerClientEvent('spawntri', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)	

RegisterServerEvent('chargetri2')
AddEventHandler('chargetri2', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 50 then
		xPlayer.removeMoney(50)
		refundvalue = math.random(40, 50)
		TriggerClientEvent('spawntri2', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)

RegisterServerEvent('chargetowtruck')
AddEventHandler('chargetowtruck', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local moneycount = xPlayer.getInventoryItem('money').count
	if moneycount >= 500 then
		xPlayer.removeMoney(500)
		refundvalue = math.random(470, 500)
		TriggerClientEvent('spawntowtruck', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You need cash!', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)


RegisterServerEvent('refundbike')
AddEventHandler('refundbike', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	xPlayer.addMoney(refundvalue)
end)

RegisterServerEvent('refundbeach')
AddEventHandler('refundbeach', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	xPlayer.addMoney(refundvalue)
end)

local refundvalue = 0
 --refundtowtruck

 RegisterServerEvent('refundtowtruck')
AddEventHandler('refundtowtruck', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local refund = 500 - math.random(10, 20)

	xPlayer.addInventoryItem('refund', 500)
end)--impoundedVehiclePog

RegisterServerEvent('impoundedVehiclePog')
AddEventHandler('impoundedVehiclePog', function()
	local xPlayer = ESX.GetPlayerFromId(source) ---- you can use this if you want to charge for the rent!!
	local impoundVehicleMoney = math.random(50,100)
	xPlayer.addMoney(impoundVehicleMoney)
end)



RegisterServerEvent('notfiytowimpound')
AddEventHandler('notfiytowimpound', function(location)
	local xPlayers = ESX.GetExtendedPlayers()
	local callcoords = location
	for _, xPlayer in pairs(xPlayers) do
    	if xPlayer.job.name == 'tow' then
        	TriggerClientEvent('impoundcall', xPlayer.source, callcoords)
    	end
	end
end)
