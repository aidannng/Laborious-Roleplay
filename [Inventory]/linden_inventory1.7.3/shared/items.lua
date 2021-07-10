Items = {

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		stack = true,
		close = true,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = 'prop_rolled_sock_02', pos = { x = -0.13999999999998, y = -0.13999999999998, y = -0.080000000000012}, rot = { x = -50.0, y = -50.0, y = 0.0} },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
			event = true,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
		weight = 0,
		stack = true,
		close = true,
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		stack = true,
		close = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
			event = true,
		}
	},

	['donut'] = {
		label = 'Donut',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
			event = true,
		}
	},

	['sandwich'] = {
		label = 'Sandwich',
		weight = 150,
		stack = true,
		close = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
			event = true,
		}
	},

	['cola'] = {
		label = 'Cola',
		weight = 350,
		stack = true,
		close = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ecola_can', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
			event = true,
		}
	},

	['energydrink'] = {
		label = 'Energy Drink',
		weight = 350,
		stack = true,
		close = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ecola_can', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 2500,
			event = true,
		}
	},

	['GADGET_PARACHUTE'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		close = false,
	},

	['garbage'] = {
		label = 'Garbage',
		weight = 50,
		stack = true,
		close = true,
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
	},

	['identification'] = {
		label = 'ID Card',
		weight = 0,
		stack = true,
		close = true,
	},

	['zippo'] = {
		label = 'Zippo',
		weight = 5,
		stack = true,
		close = true,
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		stack = true,
		close = true,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_cs_panties_02', pos = { x = 0.03, y = 0.0, z = 0.02 }, rot = { x = 0.0, y = -13.5, z = -1.5 } },
			usetime = 2500,
			consume = 0
		}
	},

	['cigarette'] = {
		label = 'Cigarette',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_cs_panties_02', pos = { x = 0.03, y = 0.0, z = 0.02 }, rot = { x = 0.0, y = -13.5, z = -1.5 } },
			usetime = 2500,
			consume = 0
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
		stack = true,
		close = true,
		client = {
			anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' },
			disable = { move = true, car = true, combat = true },
			consume = 0,
			usetime = 5000,
			event = true,
			cancel = true
		}
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'd-phone:client:openphone'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 190,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'labrp_radio:open'
		}
	},

	['money'] = {
		label = 'Money',
		weight = 0,
		stack = true,
		close = true,
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_food_mustard', pos = { x = 0.01, y = 0.0, z = -0.07 }, rot = { x = 1.0, y = -1.0, z = -1.5 } },
			usetime = 2500,
			event = true,
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		stack = true,
		close = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_flow_bottle', pos = { x = 0.030000000000002, y = 0.030000000000002, y = 0.020000000000004}, rot = { x = 0.0, y = 0.0, y = -1.5} },
			usetime = 2500,
			event = true,
		}
	},

	['wine'] = {
		label = 'Wine',
		weight = 300,
		stack = true,
		close = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_flow_bottle', pos = { x = 0.030000000000002, y = 0.030000000000002, y = 0.020000000000004}, rot = { x = 0.0, y = 0.0, y = -1.5} },
			usetime = 2500,
			event = true,
		}
	},

	['vodka'] = {
		label = 'Vodka',
		weight = 300,
		stack = true,
		close = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_flow_bottle', pos = { x = 0.030000000000002, y = 0.030000000000002, y = 0.020000000000004}, rot = { x = 0.0, y = 0.0, y = -1.5} },
			usetime = 2500,
			event = true,
		}
	},

	['beer'] = {
		label = 'Beer',
		weight = 150,
		stack = true,
		close = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_flow_bottle', pos = { x = 0.030000000000002, y = 0.030000000000002, y = 0.020000000000004}, rot = { x = 0.0, y = 0.0, y = -1.5} },
			usetime = 2500,
			event = true,
		}
	},

	['whiskey'] = {
		label = 'Whiskey',
		weight = 300,
		stack = true,
		close = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_flow_bottle', pos = { x = 0.030000000000002, y = 0.030000000000002, y = 0.020000000000004}, rot = { x = 0.0, y = 0.0, y = -1.5} },
			usetime = 2500,
			event = true,
		}
	},

	['icedtea'] = {
		label = 'Iced Tea',
		weight = 150,
		stack = true,
		close = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_flow_bottle', pos = { x = 0.030000000000002, y = 0.030000000000002, y = 0.020000000000004}, rot = { x = 0.0, y = 0.0, y = -1.5} },
			usetime = 2500,
			event = true,
		}
	},

	['nightvision_goggles'] = {
		label = 'NightVision Goggles',
		weight = 15000,
		client = {
			consume = 0,
			usetime = 0,
			event = 'policegoggles:toggleNight'
		}
	},
	--policegoggles:toggleThermal

	['thermal_goggles'] = {
		label = 'Thermal Goggles',
		weight = 15000,
		client = {
			consume = 0,
			usetime = 0,
			event = 'policegoggles:toggleThermal'
		}
	},

	['cocaine'] = {
		label = 'Cocaine',
		weight = 500,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'kypo-drug-effect:onCoke'
		}
	},

	['joint'] = {
		label = 'Weed Joint',
		weight = 500,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'kypo-drug-effect:onWeed'
		}
	},

	['advancedlockpick'] = {
		label = 'Advanced Lockpick',
		weight = 1,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'houseRobberies:attempt'--anim:cuff
		}
	}, --houseRobberies:attempt

	['greenlaptop'] = {
		label = 'Green Laptop',
		weight = 1,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'FleecaRobberies:attempt'
		}
	},

	['armour'] = {
		label = 'Armour',
		weight = 1,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'linden_inventory:armour'
		}
	},

	['pdbadge'] = {
		label = 'pdbadge',
		weight = 1,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'badge:openPD'
		}
	},

	['redlaptop'] = {
		label = 'Red Laptop',
		weight = 1,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'PowerStation:attempt'
		}
	},

	['weaponlicense'] = {
		label = 'PD Weapon License',
		weight = 1,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'pdweaponlicense'
		}
	},

	['dildo'] = {
		label = 'Dildo',
		weight = 1,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'dildothrow'
		}
	},
}
-- PowerStation:attempt
-- badge:open