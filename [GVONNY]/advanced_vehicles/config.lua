--[[
==========================================================================================================================
	PAY ATTENTION WHEN CONFIGURING EVERYTHING, IF YOU BREAK SOMETHING DOWNLOAD THE ORIGINAL CONFIG BACK AND TRY AGAIN
==========================================================================================================================
	To change the placement of the HUD open style.css and change the values ​​in lines 322 and 448
]]

Config = {}

Config.webhook = "WEBHOOK"						-- Webhook to send logs to discord
Config.lang = "en"								-- Set the file language [en/br]

Config.ESX = {									-- ESX settings, if you are using vRP just ignore
	['ESXSHAREDOBJECT'] = "esx:getSharedObject",-- Change your getshared object event here, if you are using anti-cheat
}

Config.format = {
	['currency'] = 'USD',						-- This is the currency format, so that your currency symbol appears correctly [Examples: BRL, USD]
	['location'] = 'en-US'						-- This is the location of your country, to format the decimal places according to your standard [Examples: pt-BR, en-US]
}

Config.command = "status"						-- Command to open menu (Event to open menu if you want to trigger it from somewhere: TriggerEvent('advanced_vehicles:showStatusUI'))
Config.Jobs = {'mechanic'}						-- Job to do the actions on menu

Config.allVehicles = true						-- false: only cars will be available / true: every vehicle will be available
Config.itemToInspect = "toolbox"				-- Item to inspect the vehicles

Config.NitroAmount = 200						-- Amount of nitro for each charge
Config.NitroRechargeTime = 30					-- Time to recharge nitro
Config.NitroRechargeAmount = 5					-- Charges amount
-- You can configure 2 keys to nitro
Config.NitroKey1 = 131 	-- ALT
Config.NitroKey2 = 131 	-- CTRL

Config.inspectItem = "mechanic_tools"					-- Item you must have to inspect the vehicles (set as false to disable the item)
Config.oil = "oil"								-- Oil index configured in Config.maintenance
-- Config for car services
Config.maintenance = {
	['default'] = { -- Default means if you dont have a config for the specific vehicle, it will get the default one
		['oil'] = {								-- Index
			['lifespan'] = 1500,				-- Amount of KMs until the car requires service
			['damage'] = {
				['type'] = 'engine',			-- Type of damage: this will damage the vehicle engine
				['amount_per_km'] = 0.001,		-- This is the base amount (in percentage) the car will take damage for each km he run [Max health in engine is 1000 so, 0.0001 of 1000 is 0.1 | Max value for handling is get from vehicle handling.meta file]
				['km_threshold'] = 25,			-- This is the threshold to increase the multiplier, so the multiplier will be increased each time the player pass this km [Set this value as 99999 if you dont want the multiplier working]
				['multiplier'] = 7.5,			-- This is the damage multiplier, this value will make the car take even more damage after player use the car longer [This value can't be less than 1.0 | Set this value as 1.0 if you dont want the multiplier working]
				['min'] = 0,					-- This is the min value the part health can reach taking damage
				['destroy_engine'] = false		-- Will make the car stop working if engine reach the min value [Only applicable when type = engine]
			},
			['repair_item'] = {
				['name'] = 'oil',				-- Item to do the car service
				['amount'] = 2,					-- Amount of items
				['time'] = 1					-- Time to repair
			},
			['interface'] = {
				['name'] = 'Engine oil',					-- Interface name
				['icon_color'] = '#ffffff00',				-- Interface background color
				['icon'] = 'images/maintenance/oil.png',	-- Image
				['description'] = 'You always need to have a fresh, clean oil to keep your engine running',	-- Description text
				['index'] = 0								-- This index means the item orders in interface, 0 will be the first, the the 1 ...
			}
		},
		['tires'] = {
			['lifespan'] = 2500,
			['damage'] = {
				['type'] = 'CHandlingData',			-- This will damage the vehicle handling (handling.meta)
				['handId'] = 'fTractionCurveMax',	-- handling.meta entry
				['amount_per_km'] = 0.001,			-- Setting 0.0001 (on amount_per_km), 100 (on km_threshold) and 1.2 (on multiplier) the car will run approximatelly 1.300 km before reach the min value
				['km_threshold'] = 25,
				['multiplier'] = 12.6,
				['min'] = 0.5
			},
			['repair_item'] = {
				['name'] = 'rubber',
				['amount'] = 8,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Tires',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/tires.png',
				['description'] = 'Tires are used to keep your vehicle straight, worn tires will make your vehicle skidding easier',
				['index'] = 1
			}
		},
		['brake_pads'] = {
			['lifespan'] = 2000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 25,
				['multiplier'] = 10.5,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'brake_pad',
				['amount'] = 4,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Brake pads',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/brake_pads.png',
				['description'] = 'Brake pads are useful to make your car stop during deceleration',
				['index'] = 2
			}
		},
		['transmission_oil'] = {
			['lifespan'] = 3000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveMaxFlatVel',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 25,
				['multiplier'] = 16.2,
				['min'] = 100.0
			},
			['repair_item'] = {
				['name'] = 'transmission_oil',
				['amount'] = 2,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Trans fluid',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/transmission_oil.png',
				['description'] = 'You must keep your oil clean for your transmission to work',
				['index'] = 3
			}
		},
		['shock_absorber'] = {
			['lifespan'] = 3000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionForce',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 25,
				['multiplier'] = 12.6,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'strut',
				['amount'] = 4,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Shocks',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/shocks.png',
				['description'] = 'Your suspension depends on a good shock absorber',
				['index'] = 4
			}
		},
		['clutch'] = {
			['lifespan'] = 5000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fClutchChangeRateScaleUpShift',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 25,
				['multiplier'] = 25.5,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'clutch',
				['amount'] = 1,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Clutch',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/clutch.png',
				['description'] = 'Clutch speed in gear changes',
				['index'] = 5
			}
		},
		['air_filter'] = {
			['lifespan'] = 2500,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 25,
				['multiplier'] = 14.4,
				['min'] = 0,
				['destroy_engine'] = false
			},
			['repair_item'] = {
				['name'] = 'air_filter',
				['amount'] = 1,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Air filter',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/air_filter.png',
				['description'] = 'Your engine needs to breathe through a new air filter',
				['index'] = 6
			}
		},
		['fuel_filter'] = {
			['lifespan'] = 1500,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 25,
				['multiplier'] = 12.3,
				['min'] = 0,
				['destroy_engine'] = false
			},
			['repair_item'] = {
				['name'] = 'fuel_filter',
				['amount'] = 1,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Fuel filter',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/fuel_filter.png',
				['description'] = 'The name speaks volumes for the function: to prevent the passage of dirt from the vehicles tank to the engine',
				['index'] = 7
			}
		},
		['spark_plugs'] = {
			['lifespan'] = 3000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 25,
				['multiplier'] = 18.6,
				['min'] = 0
			},
			['repair_item'] = {
				['name'] = 'spark_plugs',
				['amount'] = 4,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Spark plugs',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/spark_plugs.png',
				['description'] = 'Spark plugs are needed to generate the energy needed for the engine to work properly.',
				['index'] = 8
			}
		},
		['serpentine_belt'] = {
			['lifespan'] = 3500,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 25,
				['multiplier'] = 16.5,
				['min'] = 0,
				['destroy_engine'] = true
			},
			['repair_item'] = {
				['name'] = 'serpentine_belt',
				['amount'] = 1,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Serpentine belt',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/serpentine_belt.png',
				['description'] = 'The timing belt coordinates the opening and closing of the engine valves, as well as the movement of the pistons in the cylinder and crankshaft',
				['index'] = 9
			}
		},
	},
	--[[['panto'] = {	-- If you enable this, the car panto will have those configs
		['example'] = {
			['lifespan'] = 999,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0
			},
			['repair_item'] = {
				['name'] = 'example',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Example',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/example.png',
				['description'] = 'Example',
				['index'] = 9
			}
		},
	}]]
}

-- Upgrades availables
Config.upgrades = {
	['default'] = {
		['lowering_springs'] = {	-- Index
			['improvements'] = {
				['type'] = 'CHandlingData',			-- CHandlingData: will affect the vehicle handling
				['handId'] = 'fSuspensionRaise',	-- The handling.meta entry 
				['value'] = -0.02,					-- Value to change
				['fixed_value'] = false				-- This means if the value will be relative or absolute(fixed)
			},
			['item'] = {
				['name'] = 'lowering_springs',					-- Item required to upgrade
				['amount'] = 1,						-- Amount of items
				['time'] = 10						-- Tim to upgrade
			},
			['interface'] = {
				['name'] = 'Lowering Springs',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/lowering_springs.png',
				['description'] = 'Exchange the suspension for an extremely reduced set. Suitable for pickup trucks and tall vehicles only',
				['index'] = 0
			},
			['class'] = 'suspension'
		},
		['stanced_coil_overs'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = -0.05,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'stanced_coil_overs',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Stanced Coil Overs',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/stanced_coil_overs.png',
				['description'] = 'Installs a set of short springs to lower the vehicle to the extreme. It can make your vehicle unstable. Not suitable for low vehicles',
				['index'] = 2
			},
			['class'] = 'suspension'
		},
		['coil_overs'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = -0.04,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'coil_overs',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Coil overs',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/coil_overs.png',
				['description'] = 'Install a sport spring to lower the vehicles height. Not suitable for vehicles that are already low',
				['index'] = 1
			},
			['class'] = 'suspension'
		},
		--[[ ['lifted_coil_overs'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = 0.2,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'lifted_coil_overs2',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = '6" Lift Kit',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/lifted_coil_overs.png',
				['description'] = 'Drastically increase suspension height for vehicles that want an offroad adventure',
				['index'] = 3
			},
			['class'] = 'suspension'
		}, ]]
		--[['lifted_coil_overs2'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = 0.4,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'lifted_coil_overs',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = '12" Lift Kit',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/lifted_coil_overs.png',
				['description'] = 'Drastically increase suspension height for vehicles that want an offroad adventure',
				['index'] = 4
			},
			['class'] = 'suspension'
		},]]
		['nitrous'] = {
			['improvements'] = {
				['type'] = 'nitrous'	-- Nitro type
			},
			['item'] = {
				['name'] = 'nitrous',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Nitrous',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/nitrous.png',
				['description'] = 'Nitro increases the amount of oxygen entering the engines cylinders. Its as if, for a few seconds, he expands the engine volume to generate power',
				['index'] = 6
			},
			['class'] = 'nitro'
		},
		['full_bolt_on'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.04,
				['sound'] = 'default',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'full_bolt_on_engine',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Full bolt on kit',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/full_bolt_on_engine.png',
				['description'] = 'Full bolt on kit',
				['index'] = 7
			},
			['class'] = 'engine'
		},
		['2jz'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.035,
				['sound'] = 'toysupmk4',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = '2jzengine',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = '2JZ',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/2jzengine.png',
				['description'] = 'Toyota 2JZ engine swap',
				['index'] = 8
			},
			['class'] = 'engine'
		},
		['k20a'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.025,
				['sound'] = 'k20a',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'k20a',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'K20',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/k20a.png',
				['description'] = 'Honda K20 engine swap',
				['index'] = 9
			},
			['class'] = 'engine'
		},
		['rb26'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.03,
				['sound'] = 'rb26dett',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'rb26',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'RB26',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/rb26.png',
				['description'] = 'Nissan RB26 engine swap',
				['index'] = 10
			},
			['class'] = 'engine'
		},
		['rotary7'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.02,
				['sound'] = 'rotary7',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'rotary7',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Rotary',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/rotary7.png',
				['description'] = 'Rotary engine swap',
				['index'] = 11
			},
			['class'] = 'engine'
		},
		['amgv8'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.03,
				['sound'] = 'brabus850',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'amgv8',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'AMG v8',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/amgv8.png',
				['description'] = 'AMG v8 engine swap',
				['index'] = 12
			},
			['class'] = 'engine'
		},
		['chevylt5'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.03,
				['sound'] = 'predatorv8',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'chevylt5',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Chevy v8',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/chevylt5.png',
				['description'] = 'Chevy v8 engine swap',
				['index'] = 13
			},
			['class'] = 'engine'
		},
		['musv8'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.04,
				['sound'] = 'musv8',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'musv8',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'LS V8',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/musv8.png',
				['description'] = 'LS V8 engine swap',
				['index'] = 14
			},
			['class'] = 'engine'
		},
		['ferrariv8'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.045,
				['sound'] = '488sound',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'ferrariv8',
				['amount'] = 1,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Ferrari V8',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/ferrariv8.png',
				['description'] = 'Ferrari V8',
				['index'] = 15
			},
			['class'] = 'engine'
		},
		['gt3flat6'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.045,
				['sound'] = 'gt3flat6',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'gt3flat6',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Porsche GT3 Flat 6',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/gt3flat6.png',
				['description'] = 'Porsche GT3 engine swap',
				['index'] = 17
			},
			['class'] = 'engine'
		},
		['lambov10'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.05,
				['sound'] = 'lambov10',
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'lambov10',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Lambo v10',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/lambov10.png',
				['description'] = 'Lambo v10 engine swap',
				['index'] = 18
			},
			['class'] = 'engine'
		},
		['single_turbo'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.01,
				['turbo'] = true,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'single_turbo',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Single Turbo',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/single_turbo.png',
				['description'] = 'Install a larger turbine to generate more pressure and admit more cold air into the engine intake, generating more power',
				['index'] = 19
			},
			['class'] = 'turbo'
		},
		['big_single_turbo'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.015,
				['turbo'] = true,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'big_single_turbo',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Big Single Turbo',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/big_single_turbo.png',
				['description'] = 'Install a larger turbine to generate more pressure and admit more cold air into the engine intake, generating more power',
				['index'] = 20
			},
			['class'] = 'turbo'
		},
		['twin_turbo'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.025,
				['turbo'] = true,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'twin_turbo',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Twin Turbos',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/twin_turbo.png',
				['description'] = 'Install a double turbines to generate more pressure and admit more cold air into the engine intake, generating more power',
				['index'] = 21
			},
			['class'] = 'turbo'
		},
		['brembo_brakes'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 1.0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'brembo_brakes',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Brembo Brakes',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/brembo_brakes.png',
				['description'] = 'Racing brakes have a much greater braking power and dont overheat like regular brakes',
				['index'] = 22
			},
			['class'] = 'brakes'
		},
		['wilwood_brakes'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 2.0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'wilwood_brakes',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Wilwood Brakes',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/wilwood_brakes.png',
				['description'] = 'Racing brakes have a much greater braking power and dont overheat like regular brakes',
				['index'] = 23
			},
			['class'] = 'brakes'
		},
		['michelin'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.2,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'michelin_tires',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Michelin Tires',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/michelin_tires.png',
				['description'] = '',
				['index'] = 24
			},
			['class'] = 'tires'
		},
		['pirelli'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.3,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'pirelli_tires',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Pirelli Tires',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/pirelli_tires.png',
				['description'] = '',
				['index'] = 25
			},
			['class'] = 'tires'
		},
		['falken'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.4,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'falken_tires',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Falken Tires',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/falken_tires.png',
				['description'] = '',
				['index'] = 26
			},
			['class'] = 'tires'
		},
		--[[ ['nitto'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['handId2'] = 'fLowSpeedTractionLossMult',
				['value'] = 1.0,
				['value2'] = 2.0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'nitto_tires',
				['amount'] = 1,
				['time'] = 1
			},
			['interface'] = {
				['name'] = 'Nitto Tires',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/nitto_tires.png',
				['description'] = '',
				['index'] = 21
			},
			['class'] = 'tires'
		}, ]]
	}
}

-- Repair config
Config.repair = {
	['engine'] = {			-- Part index (dont change)
		['items'] = {		-- Items required to repair the part
			['piston'] = 4,
			['oil'] = 3
		},
		['time'] = 10,		-- Time to repair
		['repair'] = {		-- The handling entries that will go back to default
			"engine",		-- engine: will fix the engine health
			"fInitialDriveForce",
		}
	},
	['transmission'] = {
		['items'] = {
			['transmission_gear'] = 5,
			['transmission_oil'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"fClutchChangeRateScaleUpShift"
		}
	},
	['chassis'] = {
		['items'] = {
			['iron'] = 10,
			['aluminum'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"body"		-- body: will fix the body health
		}
	},
	['brakes'] = {
		['items'] = {
			['rotor'] = 4,
			['brake_pad'] = 4,
		},
		['time'] = 10,
		['repair'] = {
			"fBrakeForce"
		}
	},
	['suspension'] = {
		['items'] = {
			['strut'] = 4,
			['spring'] = 4
		},
		['time'] = 10,
		['repair'] = {
			"fTractionCurveMax",
			"fSuspensionForce"
		}
	}
}

Config.infoTextsPage = {
	[1] = {
		['icon'] = "images/info.png",
		['title'] = "Basic information",
		['text'] = "This is the vehicle maintenance panel. You need to take care of your vehicle to keep it in good condition for use. There are several maintenance items to be done every X KM, for example, the engine oil needs to be changed every 1500 Kms or your engine will start to damage. The other revisions need to be made to a higher KM, take the vehicle to a mechanic so that he can inform you of the useful life of your vehicle parts."
	},
	[2] = {
		['icon'] = "images/services.png",
		['title'] = "How to do car services",
		['text'] = "You need to carry out preventive maintenance at the correct time, for this, just take the vehicle to a trusted mechanic. He will be able to scan the parts of your car and after passing the scanner he will have the updated information of each part that needs to be replaced."
	},
	[3] = {
		['icon'] = "images/repair.png",
		['title'] = "Repairs",
		['text'] = "The repair tab is used when any part of your vehicle is losing performance, this happens when maintenance is not performed on the expected date. Repairs are expensive and need to be done, as damaged parts seriously harm your vehicle's performance, so be sure to do any maintenance."
	},
	[4] = {
		['icon'] = "images/performance.png",
		['title'] = "Upgrades",
		['text'] = "If you want to spice up the experience with your vehicle you can install some performance parts on it, but <b>CAUTION!!</b> The performance parts are extremely powerful and directly affect the physics of your vehicle, so you must choose wisely which part to install or your vehicle may become unstable or even overturn. The mechanic is not responsible for inappropriate upgrades."
	}
}
Config.createTable = true