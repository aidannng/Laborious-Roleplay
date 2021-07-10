local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('labrp_identification:open')
AddEventHandler('labrp_identification:open', function(ID, targetID, metadata, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local array 	 = {} 
	TriggerClientEvent('labrp_identification:open', _source, array, metadata, type)
end)

RegisterServerEvent('labrp_issueID')
AddEventHandler('labrp_issueID', function(src,url)
	local xPlayer = ESX.GetPlayerFromId(source)
	local metadata = {}
	metadata.type = xPlayer.getName()
	metadata.citizenid = 'XXX-XXX' 
	metadata.firstName = xPlayer.get('firstName')
	metadata.lastName = xPlayer.get('lastName')
	metadata.dateofbirth = xPlayer.get('dateofbirth')
	metadata.sex = xPlayer.get('sex')
	metadata.height = xPlayer.get('height')
	metadata.mugshoturl = url
	exports['linden_inventory']:addInventoryItem(xPlayer, 'identification', 1, metadata)
end)
