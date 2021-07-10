ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('spectate', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
		if #args > 0 then
			-- /spectate 123 
			local id = tonumber(args[1])
			if GetPlayerIdentifiers(id)[2] ~= nil then 
				TriggerClientEvent('BT:Client:SpectateID', source, id)
				print(id)
				print(source)
			else 
				TriggerClientEvent('chatMessage', source, prefix .. '^1ERROR: ^1That player cannot be found...')
			end 
		else
			-- No args 
			TriggerClientEvent('BT:Client:Spectate', source)
		end
	end -- End PlayerAceAllowed 
end)