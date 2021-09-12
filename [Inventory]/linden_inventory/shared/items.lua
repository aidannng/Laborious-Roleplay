Items = {

	['bandage'] = {
		label = 'Bandage',
		weight = 225,
		stack = true,
		close = true,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = 'prop_ld_health_pack', pos = { x = -0.13999999999998, y = -0.13999999999998, y = -0.080000000000012}, rot = { x = -50.0, y = -50.0, y = 0.0} },
			disable = { move = false, car = true, combat = true },
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

	['papers'] = {
		label = 'Chop List',
		weight = 200,
		stack = false,
		close = true,
	},

	['burger'] = {
		label = 'Burger',
		weight = 350,
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
		weight = 350,
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
			prop = { model = 'prop_amb_donut', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
			event = true,
		}
	},

	['sandwich'] = {
		label = 'Sandwich',
		weight = 300,
		stack = true,
		close = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_sandwich_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
			event = true,
		}
	},

	['cookie'] = {
		label = 'Cookie',
		weight = 300,
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
		weight = 400,
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
		weight = 650,
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
		weight = 300,
		stack = true,
		close = true,
	},

	['workpermit'] = {
		label = 'Work Permit',
		weight = 3500,
		stack = false,
		close = true,
	},

	['lcard'] = {
		label = 'Laundry Card',
		weight = 2500,
		stack = false,
		close = true,
	},

	['paperbag'] = {
		label = 'Pouch',
		weight = 2500,
		stack = false,
		close = false,
	},

	['identification'] = {
		label = 'ID Card',
		weight = 0,
		stack = true,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'show:identification'
		}
	},

	['copium'] = {
		label = 'Copium',
		weight = 3500,
		stack = false,
		close = true,
		client = {
			consume = 1,
			usetime = 0,
			event = 'use:copium'
		}
	},

	['zippo'] = {
		label = 'Zippo',
		weight = 500,
		stack = true,
		close = true,
	},

	['panties'] = {
		label = 'Knickers',
		weight = 150,
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
		weight = 150,
		stack = true,
		close = true,
		client = {
			status = { stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_sh_cigar_01', pos = { x = 0.03, y = 0.0, z = 0.02 }, rot = { x = 0.0, y = -13.5, z = -1.5 } },
			usetime = 2500,
			consume = 0
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 950,
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
		weight = 750,
		stack = false,
		close = true,
		client = {
			disable = { move = false, car = false, combat = true },
			consume = 0,
			usetime = 0,
			event = 'labrp-phone:open'
		}
	},

	['rollingtray'] = {
		label = 'Rolling Tray',
		weight = 750,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'dispensary:rollingtray'
		}
	},

	['kkjoint'] = {
		label = 'Kronic Kush Joint',
		weight = 1,
		stack = true,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'use:kkjoint'
		}
	},

	['wpjoint'] = {
		label = 'Wedding Pie Joint',
		weight = 1,
		stack = true,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'use:wpjoint'
		}
	},

	['zpjoint'] = {
		label = 'Zurple Punch Joint',
		weight = 1,
		stack = true,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'use:zpjoint'
		}
	},

	['kkgummies'] = {
		label = 'Kronic Kush Gummies',
		weight = 100,
		stack = true,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'use:kkgummies'
		}
	},

	['kkbrownie'] = {
		label = 'Kronic Kush Brownie',
		weight = 100,
		stack = true,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'use:kkbrownie'
		}
	},

	['kkcookie'] = {
		label = 'Kronic Kush Cookie',
		weight = 100,
		stack = true,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'use:kkcookie'
		}
	},

	['spikestrips'] = {
		label = 'Spike Strips',
		weight = 2500,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'placespikes'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 650,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'radio:use'
		}
	},

-- Fishing Job

	['fishingrod'] = {
		label = 'Fishing Rod',
		weight = 1500,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'labrp_fish:start'
		}
	},

	['fishbait'] = {
		label = 'Fish Bait',
		weight = 50,
		stack = true,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'labrp_fish:usebait'
		}
	},

	['Fish'] = {
		label = 'Fish',
		weight = 600,
		stack = true,
		close = false,
	},

	['Turtle'] = {
		label = 'Sea Turtle',
		weight = 1500,
		stack = true,
		close = false,
	},

	['Shark'] = {
		label = 'Shark',
		weight = 3500,
		stack = true,
		close = false,
	},

	['stevecard'] = {
		label = "Steve's Card",
		weight = 0,
		stack = true,
		close = true,
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
		weight = 400,
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
		weight = 7500,
		client = {
			consume = 0,
			usetime = 0,
			event = 'policegoggles:toggleNight'
		}
	},
	--policegoggles:toggleThermal

	['thermal_goggles'] = {
		label = 'Thermal Goggles',
		weight = 7500,
		client = {
			consume = 0,
			usetime = 0,
			event = 'policegoggles:toggleThermnl'
		}
	},

	['cocaine'] = {
		label = 'Cocaine',
		weight = 850,
		close = true,
		stack = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'kypo-drug-effect:onCoke'
		}
	},

	['joint'] = {
		label = 'Weed Joint',
		weight = 100,
		close = true,
		stack = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'kypo-drug-effect:onWeed'
		}
	},

	['packagedweed'] = {
		label = 'Packaged Weed',
		weight = 200,
		close = true,
		stack = true,
	},

	['baggy'] = {
		label = 'Baggy',
		weight = 50,
		close = true,
		stack = true,
	},

	['advancedlockpick'] = {
		label = 'Advanced Lockpick',
		weight = 1000,
		close = true,
		stack = true,
		client = {
			consume = 0,
			usetime = 0,
			event = ''
		}
	},

	['greenlaptop'] = {
		label = 'Green Laptop',
		weight = 1500,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'labrp_bank:startRob'
		}
	},

	['pdarmour'] = {
		label = 'PD Body Armour',
		weight = 5500,
		close = true,
		stack = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'linden_inventory:armour'
		}
	},

	['armour'] = {
		label = 'Body Armour',
		weight = 5500,
		close = true,
		stack = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'linden_inventory:armour'
		}
	},

	['ifak'] = {
		label = 'I.F.A.K',
		weight = 1500,
		close = true,
		stack = true,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = 'prop_ld_health_pack', pos = { x = -0.13999999999998, y = -0.13999999999998, y = -0.080000000000012}, rot = { x = -50.0, y = -50.0, y = 0.0} },
			disable = { move = false, car = true, combat = true },
			consume = 0,
			usetime = 0,
			event = 'linden_inventory:ifak'
		}
	},

	['gps'] = {
		label = 'GPS',
		weight = 100,
		close = true,
		stack = true,
	},

	['redlaptop'] = {
		label = 'Red Laptop',
		weight = 3000,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'PowerStation:attempt'
		}
	},

	['boombox'] = {
		label = 'Boombox',
		weight = 300,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'dildothrow'
		}
	},

	['membership'] = {
		label = 'Membership',
		weight = 0,
		stack = true,
		close = true,
	},

	['clippers'] = {
		label = 'Clippers',
		weight = 2500,
		stack = false,
		close = true,
	},

	['trimmers'] = {
		label = 'Trimmers',
		weight = 2500,
		stack = false,
		close = true,
	},

	['suspackage'] = {
		label = 'Suspicious Package',
		weight = 1500,
		stack = false,
		close = true,
	},

	['pay_welding'] = {
		label = 'Welding Pay Slip',
		weight = 5,
		stack = true,
		close = true,
	},


	['g6card'] = {
		label = 'Gruppe 6 Card',
		weight = 2500,
		stack = false,
		close = true,
	},

	['greenusb'] = {
		label = 'Green Laptop USB',
		weight = 2500,
		stack = false,
		close = true,
	},

	['binoculars'] = {
		label = 'Binoculars',
		weight = 300,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'binoculars:Activate'
		}
	},

	-- Galaxy Nightclub

	['viproom'] = {
		label = 'VIP Room Access',
		weight = 0,
		stack = false,
		close = true,
	},


	['ice'] = {
		label = 'Ice',
		weight = 10,
		stack = true,
		close = true,
	},

	['orangemixer'] = {
		label = 'Sweet Mango Mixer',
		weight = 50,
		stack = true,
		close = true,
	},

	['redmixer'] = {
		label = 'Strawberry Daquiri Mixer',
		weight = 50,
		stack = true,
		close = true,
	},

	['bluemixer'] = {
		label = 'Blueberry Daquiri Mixer',
		weight = 50,
		stack = true,
		close = true,
	},

	['shaker'] = {
		label = 'Shaker',
		weight = 300,
		stack = true,
		close = true,
	},

	['beef'] = {
		label = 'Ground Beef',
		weight = 400,
		stack = true,
		close = true,
	},

	['cheese'] = {
		label = 'Cheese',
		weight = 100,
		stack = true,
		close = true,
	},

	['bun'] = {
		label = 'Burger Bun',
		weight = 100,
		stack = true,
		close = true,
	},

	['potato'] = {
		label = 'Potato',
		weight = 100,
		stack = true,
		close = true,
	},

	['wings'] = {
		label = 'Frozen Wings',
		weight = 500,
		stack = true,
		close = true,
	},

	['galaxyburger'] = {
		label = 'Galaxy Burger',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { hunger = 500000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
			usetime = 2500,
			event = false,
		}
	},

	['solarfries'] = {
		label = 'Solar Fries',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			usetime = 3000,
			event = false,
		}
	},

	['universalwings'] = {
		label = 'Universal Wings',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			usetime = 3000,
			event = false,
		}
	},

	['cosmicsoda'] = {
		label = 'Cosmic Soda',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ecola_can', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 3500,
			event = false,
		}
	},

	['worldlybeer'] = {
		label = 'Worldly Beer',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_amb_beer_bottle', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 3500,
			event = false,
		}
	},

	['starwine'] = {
		label = 'Star Wine',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_sh_wine_glass', pos = { x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002}, rot = { x = 5.0, y = 5.0, y = -180.5} },
			usetime = 3500,
			event = false,
		}
	},

	['sourblast'] = {
		label = 'Sweet Blast Cocktail',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 3500,
			event = false,
		}
	},

	['bluesensation'] = {
		label = 'Blue Sensation Cocktail',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 3500,
			event = false,
		}
	},

	['eliptical'] = {
		label = 'The Eliptical Cocktail',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 3500,
			event = false,
		}
	},

	['multiversalwhiskey'] = {
		label = 'Multiversal Whiskey',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 3500,
			event = false,
		}
	},

	['spacevodka'] = {
		label = 'Space Vodka',
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 3500,
			event = false,
		}
	},

	['crowbar'] = {
		label = 'Crowbar',
		weight = 5000,
		stack = false,
		close = true,
	},

	['gunbody'] = {
		label = 'Weapon Body',
		weight = 1000,
		stack = true,
		close = true,
	},

	['gunhandle'] = {
		label = 'Weapon Handle',
		weight = 500,
		stack = true,
		close = true,
	},

	['gunstock'] = {
		label = 'Weapon Stock',
		weight = 800,
		stack = true,
		close = true,
	},

	['gunbarrel'] = {
		label = 'Weapon Barrel',
		weight = 1000,
		stack = true,
		close = true,
	},

	['gunmag'] = {
		label = 'Weapon Magazine',
		weight = 400,
		stack = true,
		close = true,
	},

	['tacomeat'] = {
		label = 'Taco Meat',
		weight = 800,
		stack = true,
		close = false,
	},

	['taco'] = {
		label = 'Taco',
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

	['tacos'] = {
		label = 'Taco Packaged',
		weight = 3000,
		stack = false,
		close = false,
	},

	['plate'] = {
		label = 'Vehicle License Plate',
		weight = 500,
		stack = false,
		close = true,
	},
	
	['fakeplate'] = {
		label = 'Fake License Plate',
		weight = 500,
		stack = false,
		close = true,
	},

	['campchair'] = {
		label = 'Camping Chair',
		weight = 500,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'labrp-chairs:UseChair1'
		}
	},

	['campchair2'] = {
		label = 'Camping Chair',
		weight = 500,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'labrp-chairs:UseChair2'
		}
	},

	['rifle_ammobox'] = {
		label = 'Rifle Ammo Box',
		weight = 2500,
		stack = true,
		close = false,
		client = {
			consume = 0,
			usetime = 0,
			event = 'ammobox:rifle'
		}
	},

	['9mm_ammobox'] = {
		label = '9mm Ammo Box',
		weight = 2500,
		stack = true,
		close = false,
		client = {
			consume = 0,
			usetime = 0,
			event = 'ammobox:9mm'
		}
	},

	['45_ammobox'] = {
		label = '.45 ACP Ammo Box',
		weight = 2500,
		stack = true,
		close = false,
		client = {
			consume = 0,
			usetime = 0,
			event = 'ammobox:45'
		}
	},

	['stopsign'] = {
		label = 'Stop Sign',
		weight = 1500,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'use:stopsign'
		}
	},

	['cocaleaves'] = {
		label = 'Cocaine Leaf',
		weight = 500,
		stack = true,
		close = true,
	},

	['packedcocaine'] = {
		label = 'Packaged Cocaine',
		weight = 900,
		stack = true,
		close = true,
	},

	['soakedcocaleaves'] = {
		label = 'Soaked Coca Leaves',
		weight = 625,
		stack = true,
		close = true,
	},

	['unpackedcocaine'] = {
		label = 'Unpackaged Cocaine',
		weight = 500,
		stack = true,
		close = true,
	},

	['handcuffs'] = {
		label = 'Handcuffs',
		weight = 150,
		stack = true,
		close = true,
	},

	['tv'] = {
		label = 'TV',
		weight = 2500,
		stack = false,
		close = true,
	},

	['money_bag'] = {
		label = 'Inked Money Bag',
		weight = 2500,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'labrp_bank:useInkedBag'
		}
	},

	['car_clean'] = {
		label = 'Car Cleaner',
		weight = 200,
		stack = false,
		close = true,
	},

	
}
-- 


local onNight = false
local onThermal = false
local clearcommand = "goggles"

RegisterNetEvent("policegoggles:toggleNight")
AddEventHandler("policegoggles:toggleNight", function()
    local ped = PlayerPedId()

    if onNight then
        TriggerEvent("mythic_progbar:client:progress", {
            name = "unique_action_name",
            duration = 2000,
            label = "Removing NightVision Goggles",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false,
            },
        }, function(status)
            if not status then
                -- Do Something If Event Wasn't Cancelled
            end
        end)
        RequestAnimDict("missheist_agency2ahelmet")
        while not HasAnimDictLoaded("missheist_agency2ahelmet") do
            Citizen.Wait(1)
        end
        
        onNight = false
        onThermal = false
        SetSeethrough(false)
        SetNightvision(false)
        TaskPlayAnim(ped, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        if GetPedPropIndex(ped, 0) == 116 then
            Citizen.Wait(1200)
            ClearPedProp(ped, 0)
        end
    elseif not onNight then
        TriggerEvent("mythic_progbar:client:progress", {
            name = "unique_action_name",
            duration = 2000,
            label = "Using NightVision Goggles",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false,
            },
        }, function(status)
            if not status then
                -- Do Something If Event Wasn't Cancelled
            end
        end)
        RequestAnimDict("missheistdockssetup1hardhat@")
        while not HasAnimDictLoaded("missheistdockssetup1hardhat@") do
            Citizen.Wait(1)
        end
        onNight = true
        onThermal = false
        SetSeethrough(false)
        SetNightvision(true)
        TaskPlayAnim(ped, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        Citizen.Wait(1500)
        SetPedPropIndex(ped, 0, 116, 0, true)
    end
end)

RegisterNetEvent("policegoggles:toggleThermal")
AddEventHandler("policegoggles:toggleThermal", function()
    local ped = PlayerPedId()

    if onThermal then
        TriggerEvent("mythic_progbar:client:progress", {
            name = "unique_action_name",
            duration = 2000,
            label = "Removing Thermal Goggles",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false,
            },
        }, function(status)
            if not status then
                -- Do Something If Event Wasn't Cancelled
            end
        end)
        RequestAnimDict("missheist_agency2ahelmet")
        while not HasAnimDictLoaded("missheist_agency2ahelmet") do
            Citizen.Wait(1)
        end
        SetFollowPedCamViewMode(1)
        onThermal = false
        onNight = false
        SetNightvision(false)
        SetSeethrough(false)
        TaskPlayAnim(ped, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        if GetPedPropIndex(ped, 0) == 118 then
            Citizen.Wait(1200)
            ClearPedProp(ped, 0)
        end
    elseif not onThermal then
        TriggerEvent("mythic_progbar:client:progress", {
            name = "unique_action_name",
            duration = 2000,
            label = "Using Thermal Goggles",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false,
            },
        }, function(status)
            if not status then
                -- Do Something If Event Wasn't Cancelled
            end
        end)
        onThermal = true
        SetFollowPedCamViewMode(4)
        if onThermal == true then
            DisableControlAction(0, 0)
        end
        onNight = false
        SetNightvision(false)
        SetSeethrough(true)
        TaskPlayAnim(ped, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        Citizen.Wait(1500)
        SetPedPropIndex(ped, 0, 118, 0, true)
    end
end)

RegisterCommand(clearcommand, function()
    local ped = PlayerPedId()

    if GetPedPropIndex(ped, 0) == 118 or GetPedPropIndex(ped, 0) == 116 then
        RequestAnimDict("missheist_agency2ahelmet")
        while not HasAnimDictLoaded("missheist_agency2ahelmet") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        Citizen.Wait(1500)
        ClearPedProp(ped, 0)
        onNight = false
        onThermal = false
        SetSeethrough(false)
        SetNightvision(false)
    end
end)