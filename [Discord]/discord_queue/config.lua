Config = {
	Default_Prio = 500000, -- This is the default priority value if a discord isn't found
	AllowedPerTick = 200, -- How many players should we allow to connect at a time?
	HostDisplayQueue = true,
	onlyActiveWhenFull = false,
	Requirements = { -- A player must have the identifier to be allowed into the server
		Discord = false,
		Steam = false
	},
	WhitelistRequired = true, -- If this option is set to true, a player must have a role in Config.Rankings to be allowed into the server
	Debug = false,
	Webhook = '',
	Displays = {
		Prefix = '[Laborious Roleplay]',
		ConnectingLoop = { 
			'🦡🌿🦡🌿🦡🌿',
			'🌿🦡🌿🦡🌿🦡',
			'🦡🌿🦡🌿🦡🥦',
			'🌿🦡🌿🦡🥦🦡',
			'🦡🌿🦡🥦🦡🥦',
			'🌿🦡🥦🦡🥦🦡',
			'🦡🥦🦡🥦🦡🥦',
			'🥦🦡🥦🦡🥦🦡',
			'🦡🥦🦡🥦🦡🌿',
			'🥦🦡🥦🦡🌿🦡',
			'🦡🥦🦡🌿🦡🌿',
			'🥦🦡🌿🦡🌿🦡',
		},
		Messages = {
			MSG_CONNECTING = 'You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]: ', -- Default message if they have no discord roles 
			MSG_CONNECTED = 'You are up! You are being connected now :)',
			MSG_DISCORD_REQUIRED = 'Your Discord was not detected... You are required to have Discord to play on this server...',
			MSG_STEAM_REQUIRED = 'Your Steam was not detected... You are required to have Steam to play on this server...',
			MSG_NOT_WHITELISTED = 'You either do not have Discord synced with FiveM or you are not in our Discord! Join our Discord to play or for support now @ discord.gg/labrp',
			--MSG_NOT_WHITELISTED = 'The LABRP Server is currently open to Beta Testers only. Public Release date is not known at this time! https://discord.labrp.net',
		},
	},
}

Config.Rankings = {
	-- LOWER NUMBER === HIGHER PRIORITY 
	-- ['roleID'] = {rolePriority, connectQueueMessage},
	['779028948586856470'] = {1, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Owner
	['779031015263436871'] = {2, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Management Team 
	['779031018446651392'] = {3, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Developer
	['794714980644683786'] = {4, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Senior Staff
	['779031716114202644'] = {5, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Administration Team
	['779032219322155008'] = {6, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Moderation Team
	['779032222954422342'] = {7, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Probationary Team
	--['795659499285250110'] = {10, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Beta Tester
	['779034217237577759'] = {50, "You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Civillian
}