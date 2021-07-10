local playerCount = 0
local maxPlayers = 64

RegisterNetEvent('discord_rich:returnPlayerCount')
AddEventHandler('discord_rich:returnPlayerCount', function(totalPlayers, totalMaxPlayers)
	playerCount = totalPlayers
	maxPlayers = totalMaxPlayers
end)

Citizen.CreateThread(function()
	SetDiscordAppId(834830768760815676)
	SetDiscordRichPresenceAsset('labrplogo')
	SetDiscordRichPresenceAssetText('Laborious Roleplay')
    SetDiscordRichPresenceAction(0, "Join Now", "fivem://connect/play.labrp.net")
    SetDiscordRichPresenceAction(1, "Discord", "https://discord.labrp.net")
	while true do
		TriggerServerEvent('discord_rich:getPlayerCount')
		SetRichPresence(GetPlayerName(PlayerId()) .. ' - ' .. playerCount .. '/' .. maxPlayers .. ' Players')
		Citizen.Wait(60000)
	end
end)