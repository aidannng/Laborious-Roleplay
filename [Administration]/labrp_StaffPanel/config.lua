---------------------------------
---     MADE BY KARMA#3333    ---
---------------------------------
--[[
		--READ THIS--
	1. You NEED Badger_Discord_API (https://github.com/JaredScar/Badger_Discord_API)
	2. This version does not use ace perms, instead it uses discord roles.
	3. Time in the /ban command is in hours. E.g 5 is 5 hours
	4. This script is ip locked and obfuscated. If you have any issues. Contact support at discord.gg/3DDWp6w

	Usage:
	-	/warn [ID] [REASON]
	-	/kick [ID] [REASON]
	-	/ban [ID] [TIME] [REASON]
	-	/commend [ID] [REASON]
	-	/trustscore [ID]

	Thank you for buying Hamz Panel
]]--

Config = {} -- DO NOT REMOVE

Config.panelLicense = 'KgakGNVusH' -- ENTER PANEL LICENSE.

Config.panelLink = 'https://staff.labrp.net' -- ENTER YOUR PANEL LINK E.G. HTTPS://YOURPANEL.COM/panel

Config.secretKey = '3HdMzZRGwU6v6JzU' -- ENTER YOUR PAMEL SECRET KEY

Config.debug = false -- TRUE, ENABLES LOGGING TO CONSOLE

Config.discordLink = 'https://discord.labrp.net' -- REPLACE  WITH YOUR DISCORD LINK (USED WHEN SHOWING ERROR MESSAGES TO PLAYERS)

Config.allowedToWarn = {	-- DISCORD ROLE ID'S ALLOWED TO USE THE /WARN COMMMAND
	'779031015263436871', -- Management Team
	'794714980644683786', -- Senior Staff team
	'779031716114202644', -- Administration Team
	'779032218181566515'  -- General Moderator
}
Config.allowedToKick = {	-- DISCORD ROLE ID'S ALLOWED TO USE THE /KICK COMMAND
	'779031015263436871', -- Management Team
	'794714980644683786', -- Senior Staff team
	'779031716114202644', -- Administration Team
	'779032218181566515'  -- General Moderator
}
Config.allowedToBan = {		-- DISCORD ROLE ID'S ALLOWED TO USE THE /BAN COMMAND
	'779031015263436871', -- Management Team
	'794714980644683786', -- Senior Staff team
	'779031716114202644' -- Administration Team
}
Config.allowedToCommend = {		-- DISCORD ROLE ID'S ALLOWED TO USE THE /COMMEND COMMAND
	'779031015263436871', -- Management Team
	'794714980644683786', -- Senior Staff team
	'779031716114202644' -- Administration Team
}
Config.trustscoreEveryone = false	-- IF SET TO TRUE, /TRUSTSCORE CAN BE USED BY EVERYONE
Config.trustscoreShowToEveryone = false -- IF SET TO TRUE, CHAT RESPONSE WILL BE SHOWN TO EVERYONE

Config.allowedToViewTrustscore = {	-- DISCORD ROLE ID'S ALLOWED TO USE THE /TRUSTSCORE COMMAND *IF* Config.trustscoreEveryone IS SET TO FALSE
	'779028948586856470', -- Server Owner
	'779028948586856470'  -- Server Owner
}