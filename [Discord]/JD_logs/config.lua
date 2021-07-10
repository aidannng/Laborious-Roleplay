Config = {}

Config.AllLogs = false											-- Enable/Disable All Logs Channel
Config.postal = false  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "Laborious Roleplay Logging" 							-- Bot Username
Config.avatar = ""				-- Bot Avatar
Config.communtiyName = ""					-- Icon top of the embed
Config.communtiyLogo = ""		-- Icon top of the embed
Config.FooterText = ""						-- Footer text for the embed
Config.FooterIcon = ""			-- Footer icon for the embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.InlineFields = true			-- set to false if you don't want the player details next to each other

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = false				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = false				-- set to false to disable license in the logs
Config.IP = false					-- set to false to disable IP in the logs

-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.BaseColors ={		-- For more info have a look at the docs: https://docs.prefech.com
	chat = "#A1A1A1",				-- Chat Message
	joins = "#3AF241",				-- Player Connecting
	leaving = "#F23A3A",			-- Player Disconnected
	deaths = "#000000",				-- Shooting a weapon
	shooting = "#2E66F2",			-- Player Died
	resources = "#EBEE3F",			-- Resource Stopped/Started	
}


Config.webhooks = {		-- For more info have a look at the docs: https://docs.prefech.com
	deaths = "https://discord.com/api/webhooks/854438056365916170/CJJXOy_oOiSEK5zhEI-ySiYLrnwU-p07kfUJc2yuvbLWOFoeQ34H6yGunDR3DKlYdvMX",		
	chat = "",
	joins = "",
	leaving = "",
	staff = ""

}

	--twitter = "https://discord.com/api/webhooks/833456217976078376/26F1T5u3N5_sdpnXOHFEDMXCQHnUt6l48g0KZX5DFJEYLtWdlXgDmVaYYAeg7wiH-F3_"


Config.TitleIcon = {		-- For more info have a look at the docs: https://docs.prefech.com
	chat = "💬",				-- Chat Message
	joins = "📥",				-- Player Connecting
	leaving = "📤",			-- Player Disconnected
	deaths = "💀",				-- Shooting a weapon
	shooting = "🔫",			-- Player Died
	resources = "🔧",			-- Resource Stopped/Started	
}

Config.Plugins = {
	--["PluginName"] = {color = "#FFFFFF", icon = "🔗", webhook = "DISCORD_WEBHOOK"},
	["NameChange"] = {color = "#03fc98", icon = "🔗", webhook = "DISCORD_WEBHOOK"},
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.3.0"
