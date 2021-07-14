Items = {

	['bandage'] = {
		label = 'Bandage',
		weight = 225,
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
			prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
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
			prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
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

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 75,
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
			prop = { model = 'prop_cs_panties_02', pos = { x = 0.03, y = 0.0, z = 0.02 }, rot = { x = 0.0, y = -13.5, z = -1.5 } },
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
			consume = 0,
			usetime = 0,
			event = 'd-phone:client:openphone'
		}
	},

	['warrant'] = {
		label = 'Police Warrant',
		weight = 750,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'show:warrant'
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

	['fishingrod'] = {
		label = 'Fishing Rod',
		weight = 1500,
		stack = false,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'fishing:fishstart'
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
		weight = 950,
		close = true,
		stack = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'kypo-drug-effect:onWeed'
		}
	},

	['advancedlockpick'] = {
		label = 'Advanced Lockpick',
		weight = 1000,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'houseRobberies:attempt'--anim:cuff
		}
	}, --houseRobberies:attempt

	['greenlaptop'] = {
		label = 'Green Laptop',
		weight = 3000,
		close = true,
		client = {
			consume = 0,
			usetime = 0,
			event = 'FleecaRobberies:attempt'
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
			consume = 0,
			usetime = 0,
			event = 'linden_inventory:ifak'
		}
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