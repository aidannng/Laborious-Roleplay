Config = {}

Config.language = 'en'

Config.debugMode = false -- disable it if you are not debuging, or it could spam your server/clients and use additional performance

Config.EnableKeyToOpen = true   -- should key to open even be enabled ?
Config.keyToOpen = 38 -- 38 = E  -- key to open spectate menu -- https://docs.fivem.net/docs/game-references/controls/

Config.EnableCommand = true
Config.SpectateCommand = 'spectate' -- you can use it as /spectate to open the menu, or /spectate ID to instantly spectate given ID

Config.KeyWhileSpectating = 47 -- 47 = G | this is the key to open spectate menu while you are spectating (can not be disabled , will only work when you are actively spectating somebody)

Config.notificationType = {
	-- what type of notification should we use ?
	GTA  	= true,
	chat 	= false,
}

Config.discordLog = {
    -- discord webhook ( required )
    webhook = "https://discord.com/api/webhooks/869728729264447548/sons-BPmax0E69cp0yyW1qD8ptIGpDj82sEnBXHDDhcbIAyGtVS2mAJcNqzRdvRZNRW8",
    -- discord bot profile ( optional )
    botProfilePicture = ""
}

Config.zOffset = -10.0		-- how much lower or higher should spectator be teleport so player dont notice the spectator (DONT CHANGE IF YOU DONT KNOW WHAT THIS DO)

Config.sendUpdatesInterval = 2	-- interval in seconds
Config.onlyUpdatePermissions = false -- this will make sure to only send updates to players with permissions to spectate (not recommended , will cause higher resource time on serverside)

-- remove or comment the one you dont want
Config.AvailableWeatherTypes = {
    EXTRASUNNY = -1750463879, 
    CLEAR = 916995460, 
    NEUTRAL = -1530260698, 
    SMOG = 282916021,
    FOGGY = -1368164796, 
    OVERCAST = -114861331, 
    CLOUDS = 821931868, 
    CLEARING = 1840358669, 
    RAIN = 1420204096, 
    THUNDER = -1233681761, 
    SNOW = -273223690, 
    BLIZZARD = 669657108, 
    SNOWLIGHT = 603685163, 
    XMAS = -1429616491, 
    HALLOWEEN = -921030142,
}

--[[
    All Avaiable permissions : 

    onlinePlayers         -- access to All online players menu
    searchPlayers         -- access to search menu
    changeWeather         -- this is only for spectator, nobody else weather will change
    changeTime            -- this is only for spectator, nobody else time will change
    playerInfo            -- player information
    hideSensitiveInfo     -- if this is enabled , spectator will not see any sensitive information Like player IP address
    logToDiscord          -- can this spectator send player info to discord log ?
]]
-- Permissions priority from lowest to highest : ['ALL'] < ESX < Normal
-- for ex. if you have ESX permission , and also have normal permission, normal permission will replace the ESX one !

Config.permissions = {

    ['steam:100000000000000'] = {
        onlinePlayers = true,
        searchPlayers = true,
        changeWeather = true,
        changeTime = true,
        playerInfo = true,
        hideSensitiveInfo = true,
        logToDiscord = true
    },

    ['license:1500000000000000000'] = {
        onlinePlayers = true,
        searchPlayers = true,
        changeWeather = true,
        changeTime = true,
        playerInfo = true,
        hideSensitiveInfo = true,
        logToDiscord = true
    },

    --[[
        -- uncomment this to give spectate access to everybody
        -- this will be override by any other permission that player have above (if there is any, of course)
    ['ALL'] = {
        onlinePlayers = true,
        searchPlayers = true,
        changeWeather = true,
        changeTime = true,
        playerInfo = true,
        hideSensitiveInfo = true,
        logToDiscord = true
    }
    --]]

}

-- if your server use ESX, you can use ESX group function for permissions
Config.ESX_permissions = {

    ['management'] = {
        onlinePlayers = true,
        searchPlayers = false,
        changeWeather = false,
        changeTime = false,
        playerInfo = true,
        hideSensitiveInfo = false,
        logToDiscord = true
    },

    ['headadmin'] = {
        onlinePlayers = true,
        searchPlayers = false,
        changeWeather = false,
        changeTime = false,
        playerInfo = true,
        hideSensitiveInfo = false,
        logToDiscord = true
    },

    ['senioradmin'] = {
        onlinePlayers = true,
        searchPlayers = false,
        changeWeather = false,
        changeTime = false,
        playerInfo = true,
        hideSensitiveInfo = false,
        logToDiscord = true
    },
    ['generaladmin'] = {
        onlinePlayers = true,
        searchPlayers = false,
        changeWeather = false,
        changeTime = false,
        playerInfo = true,
        hideSensitiveInfo = false,
        logToDiscord = true
    },
    ['junioradmin'] = {
        onlinePlayers = true,
        searchPlayers = false,
        changeWeather = false,
        changeTime = false,
        playerInfo = true,
        hideSensitiveInfo = false,
        logToDiscord = true
    },
}
