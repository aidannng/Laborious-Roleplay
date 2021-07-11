Config = {}

Config.Locale = 'en'

Config.serverLogo = ''

Config.font = {
	name 	= 'Ubuntu',
	url 	= 'https://fonts.googleapis.com/css?family=Ubuntu:300,400,700,900&display=swap'
}

Config.date = {
	format	 	= 'default',
	AmPm		= false
}

Config.voice = {

	levels = {
		default = 5.0,
		shout = 12.0,
		whisper = 1.0,
		current = 0
	},
	
	keys = {
		distance 	= 'Z',
	}
}


Config.vehicle = {
	speedUnit = 'MPH',
	maxSpeed = 240,

	keys = {
		seatbelt 	= 'B',
		cruiser		= 'M',
		signalLeft    = '',
        signalRight    = '',
        signalBoth    = '',
	}
}

Config.ui = {
	showServerLogo		= false,

	showJob		 		= false,

	showWalletMoney 	= false,
	showBankMoney 		= false,
	showBlackMoney 		= false,
	showSocietyMoney	= false,

	showDate 			= false,
	showLocation 		= true,
	showVoice	 		= true,

	showHealth			= false,
	showArmor	 		= false,
	showStamina	 		= false,
	showHunger 			= false,
	showThirst	 		= false,

	showMinimap			= false,

	showWeapons			= true,	
}