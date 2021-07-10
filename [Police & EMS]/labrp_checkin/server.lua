-- ESX Stuff (DON'T TOUCH!!!)
ESX = nil 
 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

-- Main events
RegisterServerEvent('esx_checkin:keyPressed')
AddEventHandler('esx_checkin:keyPressed', function()
	TriggerClientEvent('esx_checkin:checkIn', source)
end)

RegisterServerEvent('esx_checkin:takeMoney')
AddEventHandler('esx_checkin:takeMoney', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney('bank', 500)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You\'ve been charged $500', })
end)


