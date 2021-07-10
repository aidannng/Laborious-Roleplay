Config = {
	--[[
	List in order of least priority to highest with 
	highest priority overtaking role before it if 
	they have that discord role.
	]]--
	roleList = {
		{779034217237577759, "^0^*Civilian | "}, -- Civilian
		{795659499285250110, "^6^*Beta Tester | "}, -- Beta Tester
		{694161197871792230, "^9^*Nitro Booster | "}, -- Nitro Booster
		{852446752431013919, "^3^*Bronze Donator | "}, -- Bonze Donator
		{852446149087985665, "^0^*Silver Donator | "}, -- Silver Donator
		{852446452713259039, "^3^*Aurum Donator | "}, -- Aurum Donator
		{852446149923176479, "^5^*Diamond Donator | "}, -- Diamond Donator
		{853773601130807316, "^2^*Emerald Donator | "}, -- Emerald Donator
		{779031018446651392, "^6^*Developer | "}, -- Developer
		{779032222359486514, "^3^*Community Helper | "}, -- Community Helper
		{828287159798464583, "^2^*Junior Moderator | "}, -- Junior Moderator
		{779032218181566515, "^2^*General Moderator | "}, -- General Moderator
		{779031713803927564, "^1^*Junior Admin | "}, -- Junior Admin
		{779031713669447680, "^1^*General Admin | "}, -- General Admin
		{794715123096354828, "^1^*Senior Admin | "}, -- Senior Admin
		{779031020283625524, "^1^*Head Admin | "}, -- Head Admin
		{827526150547832832, "^4^*Server Manager | "}, -- Server Manager
		{791702585152765953, "^6^*Community Manager | "}, -- Community Manager
		{804284569129058314, "^*^4Staff Manager | "}, -- Staff Manager
		{779028948586856470, " ^4^*Server Owner | "}, -- Server Owner
	},
	allowedColors = {2, 3},
	allowedRed = {4, 5, 6, 7, 8},
	allowedEmoji = {3, 7, 8},
	sendBlockMessages = true,
	ColorPatterns = {
		['DiscordChatRoles.Access.Donator'] = {
			['Christmas2'] = {'^1', '^2'},
		},
		['DiscordChatRoles.Access.Elite'] = {
			['RainbowYGB'] = {'^3', '^2', '^4'},
			['RainbowFull'] = {'^3', '^4', '^1', '^5', '^6', '^7', '^9'},
		},
		['DiscordChatRoles.Access.Staff'] = {}
	},
	emojis = {
		  [":triumph:"] = '😤',
	},
}