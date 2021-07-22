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

RegisterCommand('issueMembership', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local targetId = ESX.GetPlayerFromId(args[1])
	local metadata = {}
	local membershipType = args[2]

	if targetId ~= nil then
		if xPlayer.job.name == "galaxy" then
			if args[2] == "universal" then
				metadata.type = 'Galaxy Nightclub Membership | Universal Membership'
				metadata.description = '' .. targetId.getName() .. ' | Membership ID: ' .. GenerateLicense() .. ' '
				exports['linden_inventory']:addInventoryItem(xPlayer, 'membership', 1, metadata)
			elseif args[2] == "galaxy+" then
				metadata.type = 'Galaxy Nightclub Membership | Galaxy + Membership'
				metadata.description = '' .. targetId.getName() .. ' | Membership ID: ' .. GenerateLicense() .. ' '
				exports['linden_inventory']:addInventoryItem(xPlayer, 'membership', 1, metadata)
			elseif args[2] == "galaxy" then
				metadata.type = 'Galaxy Nightclub Membership | Galaxy Membership'
				metadata.description = '' .. targetId.getName() .. ' | Membership ID: ' .. GenerateLicense() .. ' '
				exports['linden_inventory']:addInventoryItem(xPlayer, 'membership', 1, metadata)
			else
				print("invalid membership type")
			end
		else
			print("not nightclub job")
		end
	else
		print("target not online")
	end
end)

function GenerateLicense()
    local numBase0 = math.random(100,999)
    local numBase1 = math.random(100,999)
    local num = string.format("%03d%03d", numBase0, numBase1)

	return num
end
