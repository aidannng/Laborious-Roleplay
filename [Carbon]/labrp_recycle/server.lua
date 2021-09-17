ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('labrp-recycle:addItem')
AddEventHandler('labrp-recycle:addItem',function(item)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item,1)

end)

RegisterServerEvent('labrp-recycle:removeItem')
AddEventHandler('labrp-recycle:removeItem',function(item)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item,1)

end)

-- FOR EXCHANGING

RegisterServerEvent('labrp-recycle:exhangeItems')
AddEventHandler('labrp-recycle:exhangeItems', function()
local xPlayer = ESX.GetPlayerFromId(source)
local Item1 = xPlayer.getInventoryItem(Config.Item1).count
local Item2 = xPlayer.getInventoryItem(Config.Item2).count
local Item3 = xPlayer.getInventoryItem(Config.Item3).count
local Item4 = xPlayer.getInventoryItem(Config.Item4).count
local Item5 = xPlayer.getInventoryItem(Config.Item5).count
local Item6 = xPlayer.getInventoryItem(Config.Item6).count

if Item1 > 0 then
	xPlayer.addInventoryItem(Config.Item1Exchange, Item1)
	xPlayer.removeInventoryItem(Config.Item1,Item1)
elseif Item2 > 0 then
	xPlayer.addInventoryItem(Config.Item2Exchange, Item2)
	xPlayer.removeInventoryItem(Config.Item2,Item2)
elseif Item3 > 0 then
	xPlayer.addInventoryItem(Config.Item3Exchange, Item3)
	xPlayer.removeInventoryItem(Config.Item3,Item3)
elseif Item4 > 0 then
	xPlayer.addInventoryItem(Config.Item4Exchange, Item4)
	xPlayer.removeInventoryItem(Config.Item4,Item4)
elseif Item5 > 0 then
	xPlayer.addInventoryItem(Config.Item5Exchange, Item5)
	xPlayer.addInventoryItem(Config.Item5Exchange2, Item5)
	xPlayer.removeInventoryItem(Config.Item5,Item5)
elseif Item6 > 0 then
	xPlayer.addInventoryItem(Config.Item6Exchange, Item6)
	xPlayer.removeInventoryItem(Config.Item6,Item6)
else
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You don\'t have any items i\'m instrested in!', })
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Find me these items : Crushed Bottles, Old Cans, Beer Bottles, Gameboys, and Sunglasses!', })
end
end)
