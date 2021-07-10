ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local p = 'plastic'
local s = 'Scrap'
local e = 'electronics'
local payment = {}

RegisterCommand('ChopList', function(source, args)
	TriggerClientEvent('SB-GetList', source)
end)

RegisterServerEvent('SB-ChopLow')
AddEventHandler('SB-ChopLow', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == xPlayer then
		xPlayer.addInventoryItem(p, math.random(2, 6))
		xPlayer.addInventoryItem(s, math.random(3, 8))
		xPlayer.addInventoryItem(e, math.random(1, 3))
		payment = math.random(100, 300) 
		xPlayer.addMoney(payment)
	end
end)

RegisterServerEvent('SB-ChopMed')
AddEventHandler('SB-ChopMed', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == xPlayer then
		xPlayer.addInventoryItem(p, math.random(3, 8))
		xPlayer.addInventoryItem(s, math.random(4, 10))
		xPlayer.addInventoryItem(e, math.random(2, 5))
		payment = math.random(200, 400) 
		xPlayer.addMoney(payment)
	end
end)

RegisterServerEvent('SB-ChopHigh')
AddEventHandler('SB-ChopHigh', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == xPlayer then
		xPlayer.addInventoryItem(p, math.random(4, 10))
		xPlayer.addInventoryItem(s, math.random(5, 12))
		xPlayer.addInventoryItem(e, math.random(3, 7))
		payment = math.random(300, 500) 
		xPlayer.addMoney(payment)
	end
end)

RegisterServerEvent('SB-ChopExtreme')
AddEventHandler('SB-ChopExtreme', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == xPlayer then
		xPlayer.addInventoryItem(p, math.random(6, 15))
		xPlayer.addInventoryItem(s, math.random(7, 17))
		xPlayer.addInventoryItem(e, math.random(5, 13))
		payment = math.random(400, 600) 
		xPlayer.addMoney(payment)
	end
end)

