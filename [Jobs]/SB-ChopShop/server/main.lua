ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local p = 'plastic'
local s = 'Scrap'
local e = 'electronics'
local payment = {}

RegisterServerEvent('givechoppaper')
AddEventHandler('givechoppaper', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	car = Config.ChopCars[math.random(1, #Config.ChopCars)]
	xPlayer.addInventoryItem('papers', 1, {type='Find and Steal this car:', description=car})
	TriggerClientEvent('CarPapers', source, car)
end) --choppayout

RegisterServerEvent('choppayout')
AddEventHandler('choppayout', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local payout = math.random(2, 10)

	xPlayer.addInventoryItem('scrapmetal', payout)
	xPlayer.addInventoryItem('black_money', math.random(300, 700))
	TriggerClientEvent('resetchop', source)
end)

RegisterServerEvent('removepapers')
AddEventHandler('removepapers', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('papers', 1)
end)

