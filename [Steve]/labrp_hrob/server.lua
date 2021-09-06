ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Send Alerts for Police
RegisterServerEvent('labrp-robbery:alertPolice')
AddEventHandler('labrp-robbery:alertPolice', function(playerCoords,currentStreetName)
TriggerClientEvent('labrp-robbery:notifyPolice', -1, playerCoords,currentStreetName)
end)


RegisterServerEvent('labrp-robbery:addItem')
AddEventHandler('labrp-robbery:addItem',function(item)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item,1)

end)

RegisterServerEvent('labrp-robbery:removeItem')
AddEventHandler('labrp-robbery:removeItem',function(item)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item,1)

end)



-- FOR SELLING, a little messy, sorry.

RegisterServerEvent('labrp-robbery:sellItems')
AddEventHandler('labrp-robbery:sellItems', function()
local xPlayer = ESX.GetPlayerFromId(source)
local Item1 = xPlayer.getInventoryItem(Config.Item1).count
local Item2 = xPlayer.getInventoryItem(Config.Item2).count
local Item3 = xPlayer.getInventoryItem(Config.Item3).count
local Item4 = xPlayer.getInventoryItem(Config.Item4).count
local Item5 = xPlayer.getInventoryItem(Config.Item5).count
local Item6 = xPlayer.getInventoryItem(Config.Item6).count
local Item7 = xPlayer.getInventoryItem(Config.Item7).count
local Item8 = xPlayer.getInventoryItem(Config.Item8).count
local Item9 = xPlayer.getInventoryItem(Config.Item9).count

if Item1 > 0 then
xPlayer.addMoney(Config.Item1Price * Item1)
xPlayer.removeInventoryItem(Config.Item1,Item1)
end

Wait(400)

if Item2 > 0 then
xPlayer.addMoney(Config.Item2Price * Item2)
xPlayer.removeInventoryItem(Config.Item2,Item2)
end

Wait(400)

if Item3 > 0 then
xPlayer.addMoney(Config.Item3Price * Item3)
xPlayer.removeInventoryItem(Config.Item3,Item3)
end

Wait(400)

if Item4 > 0 then
xPlayer.addMoney(Config.Item4Price * Item4)
xPlayer.removeInventoryItem(Config.Item4,Item4)
end

Wait(400)

if Item5 > 0 then
xPlayer.addMoney(Config.Item5Price * Item5)
xPlayer.removeInventoryItem(Config.Item5,Item5)
end

Wait(400)

if Item6 > 0 then
xPlayer.addMoney(Config.Item6Price  * Item6)
xPlayer.removeInventoryItem(Config.Item6,Item6)
end

Wait(400)

if Item7 > 0 then
xPlayer.addMoney(Config.Item7Price  * Item7)
xPlayer.removeInventoryItem(Config.Item7,Item7)
end

Wait(400)

if Item8 > 0 then
xPlayer.addMoney(Config.Item8Price  * Item8)
xPlayer.removeInventoryItem(Config.Item8,Item8)
end

Wait(400)

if Item9 > 0 then
xPlayer.addMoney(Config.Item9Price  * Item9)
xPlayer.removeInventoryItem(Config.Item9,Item9)
end

Wait(400)

end)

ESX.RegisterUsableItem('lockpick', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('labrp-robbery:pickDoor', source)
end)


ESX.RegisterServerCallback('labrp_hrob:checkpolice', function(source, callback)
    local xPlayers = ESX.GetExtendedPlayers()
	local cops = 0
	for _, xPlayer in pairs(xPlayers) do
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end

	if cops >= 1 then
		callback(true)
	end
end)