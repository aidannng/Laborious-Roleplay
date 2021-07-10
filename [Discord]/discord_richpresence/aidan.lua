RegisterNetEvent('discord_rich:getPlayerCount')
AddEventHandler('discord_rich:getPlayerCount', function()
	TriggerClientEvent('discord_rich:returnPlayerCount', -1, #GetPlayers(), GetConvarInt('sv_maxclients', 32))
end)