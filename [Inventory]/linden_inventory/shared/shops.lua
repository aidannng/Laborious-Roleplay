Config.General = {
	name = 'Shop',
	blip = {
		id = 52,
		colour = 69,
		scale = 0.6
	}, inventory = {
		{ name = 'burger', price = 7 },
		{ name = 'sandwich', price = 6 },
		{ name = 'water', price = 4 },
		{ name = 'cola', price = 3 },
		{ name = 'bandage', price = 20 },
		{ name = 'zippo', price = 12 },
		{ name = 'donut', price = 10 },
		{ name = 'energydrink', price = 20 },
		{ name = 'wine', price = 15 },
		{ name = 'vodka', price = 25 },
		{ name = 'beer', price = 10 },
		{ name = 'whiskey', price = 40 },
		{ name = 'rolling_paper', price = 20 },
	}
}


Config.Vending = {
	name = 'Vending',
	blip = {
		id = 356,
		colour = 30,
		scale = 0.6
	}, inventory = {
		{ name = 'sandwich', price = 6},
		{ name = 'water', price = 4 },
		{ name = 'burger', price = 7 },
	}
}

Config.YouTool = {
	name = 'YouTool',
	blip = {
		id = 402,
		colour = 69,
		scale = 0.6
	}, inventory = {
		{ name = 'lockpick', price = 125 },
		{ name = 'radio', price = 200 },
		{ name = 'campchair', price = 120 },
		{ name = 'campchair2', price = 120 },
		{ name = 'stopsign', price = 200 },
		{ name = 'paperbag', price = 450 },
		{ name = 'fishbait', price = 75},
		{ name = 'fishingrod', price = 225 },
	}
}




Config.Ammunation = {
	name = 'Ammunation',
	blip = {
		id = 110,
		colour = 69,
		scale = 0.6
	}, inventory = {
		{ name = 'WEAPON_PISTOL', price = 1500, metadata = { registered = true }, license = 'weapon' },
		{ name = 'WEAPON_SNSPISTOL', price = 1250, metadata = { registered = true }, license = 'weapon' },
		{ name = 'ammo-9', price = 5, },
		{ name = 'WEAPON_BAT', price = 100 },
		{ name = 'WEAPON_KNIFE', price = 250 },
	}
}

Config.Tech = {
	name = 'DigitalDen',
	blip = {
		id = 521,
		colour = 27,
		scale = 0.8
	}, inventory = {
		{ name = 'phone', price = 650 },
	}
}

Config.Hunting = {
	name = 'Hunting',
	blip = {
		id = 141,
		colour = 25,
		scale = 0.6
	}, inventory = {
		{ name = 'WEAPON_SNIPERRIFLE', price = 6500, metadata = { registered = true }, license = 'weapon' },
		{ name = 'ammo-sniper', price = 25 },
		{ name = 'WEAPON_KNIFE', price = 250 },
		{ name = 'huntingbait', price = 100 },
		{ name = 'fishbait', price = 75},
		{ name = 'fishingrod', price = 225 },
	}
}

Config.PoliceArmoury = {
	name = 'Police Armoury',
	inventory = {
		{ name = 'WEAPON_COMBATPISTOL', price = 125, metadata = { registered = true, serial = 'POL', components = {'flashlight'} }, grade = 0},
		{ name = 'WEAPON_CARBINERIFLE', price = 750, metadata = { registered = true, serial = 'POL', components = {'flashlight','scope'} }, grade = 0},
		{ name = 'WEAPON_STUNGUN', price = 100, metadata = { registered = true, serial = 'POL'} },
		{ name = 'ammo-9', price = 1, },
		{ name = 'ammo-rifle', price = 10, },
		{ name = 'WEAPON_FLASHLIGHT', price = 50 },
		{ name = 'WEAPON_NIGHTSTICK', price = 50 },
		{ name = 'WEAPON_FIREEXTINGUISHER', price = 50 },
		{ name = 'pdarmour', price = 75, },
		{ name = 'ifak', price = 50, },
		{ name = 'radio', price = 50 },
		{ name = 'binoculars', price = 50 },
		{ name = 'spikestrips', price = 150 },
		{ name = 'paperbag', price = 125 },
		{ name = 'handcuffs', price = 50 },
	}
}

Config.FBIArmoury = {
	name = 'FBI Armoury',
	inventory = {
		{ name = 'WEAPON_COMBATPISTOL', price = 50, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
		{ name = 'WEAPON_CARBINERIFLE', price = 50, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
		{ name = 'WEAPON_HEAVYPISTOL', price = 15, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
		{ name = 'WEAPON_CARBINERIFLE_MK2', price = 50, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
		{ name = 'WEAPON_STUNGUN', price = 20, metadata = { registered = true, serial = 'POL'} },
		{ name = 'ammo-9', price = 1, },
		{ name = 'ammo-rifle', price = 10, },
		{ name = 'WEAPON_FLASHLIGHT', price = 50 },
		{ name = 'WEAPON_NIGHTSTICK', price = 50 },
		{ name = 'WEAPON_FLASHBANG', price = 75 },
		{ name = 'pdarmour', price = 75, },
		{ name = 'ifak', price = 50, },
		{ name = 'radio', price = 50 },
		{ name = 'spikestrips', price = 150 },
	}
}

Config.EMSStore = {
	name = 'EMS Store',
	inventory = {
		{ name = 'bandage', price = 250 },
		{ name = 'ifak', price = 250 },
		{ name = 'WEAPON_FLASHLIGHT', price = 50 },
	}
}


Config.Shops = {
	{ type = Config.Ammunation, coords = vector3(-662.180, -934.961, 21.829)--[[, currency = 'money']] }, -- can set currency like so
	{ type = Config.Ammunation, coords = vector3(810.25, -2157.60, 29.62)--[[, currency = 'burger']] },
	{ type = Config.Ammunation, coords = vector3(1693.44, 3760.16, 34.71) },
	{ type = Config.Ammunation, coords = vector3(-330.24, 6083.88, 31.45) },
	{ type = Config.Ammunation, coords = vector3(252.63, -50.00, 69.94) },
	{ type = Config.Ammunation, coords = vector3(22.33, -1106.78, 29.78) },
	{ type = Config.Ammunation, coords = vector3(2567.69, 294.38, 108.73) },
	{ type = Config.Ammunation, coords = vector3(-1117.58, 2698.61, 18.55) },
	{ type = Config.Ammunation, coords = vector3(842.44, -1033.42, 28.19) },


	{ type = Config.YouTool, coords = vector3(2748.97, 3472.31, 55.68) },
	{ type = Config.YouTool, coords = vector3(45.04, -1748.36, 29.55) },
	{ type = Config.YouTool, coords = vector3(-11.14, 6499.56, 30.50) }, --  -680.3,5838.8,16.31

	{ type = Config.Hunting, coords = vector3(-679.2, 5837.6, 17.3), name = 'Hunting Store' }, --  Prison  1777.411, 2564.967, 45.65784
	{ type = Config.Tech, coords = vector3(1134.105, -469.5956, 66.48425), name = 'Digital Den' },

	{ coords = vector3(2557.458,  382.282, 108.622), name = '24/7'},
	{ coords = vector3(-3038.939, 585.954, 7.908), name = '24/7'},
	{ coords = vector3(-3241.927, 1001.462, 12.830), name = '24/7'},
	{ coords = vector3(547.431, 2671.710, 42.156), name = '24/7'},
	{ coords = vector3(1961.464, 3740.672, 32.343), name = '24/7'},
	{ coords = vector3(2678.916, 3280.671, 55.241), name = '24/7'},
	{ coords = vector3(1729.216, 6414.131, 35.037), name = '24/7'},
	{ coords = vector3(-48.519, -1757.514, 29.421), name = '24/7'},
	{ coords = vector3(1163.373, -323.801, 69.205), name = '24/7'},
	{ coords = vector3(-707.501, -914.260, 19.215), name = '24/7'},
	{ coords = vector3(-1820.523, 792.518, 138.118), name = '24/7'},
	{ coords = vector3(1698.388, 4924.404, 42.063), name = '24/7'},
	{ coords = vector3(25.723, -1346.966, 29.497), name = '24/7'},
	{ coords = vector3(373.875, 325.896, 103.566), name = '24/7'},

	
	{ type = Config.PoliceArmoury, job = 'police', coords = vector3(481.5428, -995.6307, 30.67834) },
	{ type = Config.FBIArmoury, job = 'fbi', coords = vector3(123.9429, -733.0681, 242.1436) },

	{ type = Config.EMSStore, job = 'ambulance', coords = vector3(306.7516, -601.8066, 43.2821) },

}
