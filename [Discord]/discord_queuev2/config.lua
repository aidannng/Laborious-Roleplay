Config = {
	Default_Prio = 500000, -- This is the default priority value if a discord isn't found
	ServerSlots = 64,
	Default_Role_Name = "LABRP  |",
	HostDisplayQueue = true,
	GracePriority = true, -- Should grace priority be a thing?
	GracePriorityLastingTime = 180, -- How long does grace priority last before it is removed for a player? (seconds)
	GracePriorityName = 'Grace Priority | ',
	GracePriorityPrio = 0.01,
	Requirements = { -- A player must have the identifier to be allowed into the server
		Discord = true,
		Steam = true
	},
	WhitelistRequired = false, -- If this option is set to true, a player must have a role in Config.Rankings to be allowed into the server
	Debug = true,
	Webhook = 'https://discord.com/api/webhooks/852441232164257793/MZdstxUFZe6OpYlOJHswNaJjahTiW7laRnJ4lLKv43b0mVyh-xRwFUAsPfjn1s6SRwh2',
	Displays = {
		Prefix = '[LABRP | Queue] ',
		Messages = {
			MSG_CONNECTING = 'You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]: ', -- Default message if they have no discord roles 
			MSG_CONNECTED = 'You are up! You are being connected now :)',
			MSG_DISCORD_REQUIRED = 'Your Discord was not detected... You are required to have Discord to play on this server...',
			MSG_STEAM_REQUIRED = 'Your Steam was not detected... You are required to have Steam to play on this server...',
			MSG_NOT_WHITELISTED = 'You do not have a Discord role whitelisted for this server... You are not whitelisted.',
		},
	},
}

-- COLORS: Red, Blue, Black, Yellow, White, Green, Gray
Config.Card = {
	TitleColor = 'Blue',
	Header_Images = {
		'https://www.trackyserver.com/user_data/server_banners/fd8a8d410fd1c358213cc6b5334a8089.webp',
		'https://www.trackyserver.com/user_data/server_banners/b482af26450a383100658da78b943615.webp',
		'https://www.trackyserver.com/user_data/server_banners/363e1f03ed9bfa4e1ba9116d3e5483fa.webp',
	},
	Heading2 = {
		'Waiting to get into the server...',
		'Waiting is fun, right?',
		'You should read the rules on our Discord :)',
		'You can buy priority on our website! store.labrp.net',
	},
	Heading2Color = 'White',
	QueueListEnabled = true, 
	QueueListSlots = 5, -- How many players should we show in the queue list?
	QueueListTitleColor = 'Black',
	QueueListColor = 'Black',
	MessageColor = 'White',
	Heading4 = 'Check out our Discord and Website below',
	Heading4Color = 'White',
	Discord_Link = 'https://discord.labrp.net/',
	Website_Link = 'https://labrp.net',
}

Config.Rankings = {
	-- LOWER NUMBER === HIGHER PRIORITY 
	-- ['roleID'] = {rolePriority, connectQueueMessage},
	['Member'] = {16, "You are being connected (Discord Member Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Discord Member |'}, -- Discord User
	['Bronze_Donator'] = {15, "You are being connected (Bronze Donator) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Bronze Donator |'}, -- Bronze Donator
	['Silver_Donator'] = {14, "You are being connected (Silver Donator) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Silver Donator |'}, -- Silver Donator  
	['Gold_Donator'] = {13, "You are being connected (Gold Donator) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Gold Donator |'}, -- Gold Donator 
	['Developer'] = {12, "You are being connected (Developer Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Developer |'}, -- Developer 
	['Platinum_Donator'] = {11, "You are being connected (Platinum Donator) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Platinum Donator |'}, -- Platinum Donator 
	['Community_Helper'] = {10, "You are being connected (Community Helper Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Community Helper |'}, -- Community Helper 
	['Diamond_Donator'] = {9, "You are being connected (Diamond Donator) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Diamond Donator |'}, -- Diamond Donator 
	['Junior_Moderator'] = {8, "You are being connected (Junior Moderator Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Junior Mod |'}, -- Junior Moderator 
	['General_Moderator'] = {7, "You are being connected (General Moderator Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'General Mod |'}, -- General Moderator
	['Junior_Admin'] = {6, "You are being connected (Junior Admin Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Junior Admin |'}, -- Junior Admin
	['General_Admin'] = {5, "You are being connected (General Admin Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'General Admin |'}, -- General Admin
	['Senior_Admin'] = {4, "You are being connected (Senior Admin Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Senior Admin |'}, -- Senior Admin
	['Head_Admin'] = {3, "You are being connected (Head Admin Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Head Admin |'}, -- Head Admin
	['Management'] = {2, "You are being connected (Management Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Management |'}, -- Management
	['Owner'] = {1, "You are being connected (Server Owner Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Server Owners |'}, -- Server Owner
}