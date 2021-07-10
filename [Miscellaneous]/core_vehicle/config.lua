Config = {

    -------------------------------------------------------------
    -- IMPORTANT  
    -- All parts need to be added to inventory
    -- Custom vehicle sounds for engines (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
    -------------------------------------------------------------
    
    
    WearRate = 200000, -- The rate parts wear off (Higher the value less wear on the parts)
    UseMiles = true, -- If set to false it will use kilometers
    UseRelativeValues = true, -- If set to true cars performance wouldnt be affected with stock parts. Otherwise stock car parts will make the car slower
    UseT1gerMechanic = false, -- If set to true Vehicles will use the CarJack (toolbox) and Lift (mechanic_toolbox) from the t1ger_mechanic script. Look at the Readme for using this
    DetectDistance = 3.0, -- Distance where vehicles are being detected
    OnlyOwnedVehicles = false, -- Script excludes not owned cars
    
    --Times to repair/install certain parts in miliseconds
    EngineRepairTime = 10000, 
    EngineInstallTime = 15000,
    
    TurboRepairTime = 10000, 
    TurboInstallTime = 15000,
    
    NitroInstallTime = 10000,
    
    OilInstallTime = 5000,
    
    TransmissionInstallTime = 14000,
    TransmissionRepairTime = 10000,
    
    TireRepairTime = 3000,
    TireInstallTime = 3000,
    
    BreaksInstallTime = 4000,
    BreaksRepairTime = 4000,
    
    SuspensionInstallTime = 5000,
    SuspensionRepairTime = 5000,
    
    
    SparkPlugsInstallTime = 5000,
    SparkPlugsRepairTime = 5000,
    
    
    MechanicWorkshop = { -- Mechanic Workshops where mechanics can use MechanicWorkshopAccess
    
        {coords = vector3(-326.8615, -144.2505, 39.0022), radius = 20.0},
        {coords = vector3(-324.9231, -139.2, 39.0022), radius = 20.0},
        {coords = vector3(-322.9714, -134.0308, 39.0022), radius = 20.0},
        {coords = vector3(-321.1253, -128.822, 39.0022), radius = 20.0},
        {coords = vector3(-319.2791, -123.6, 39.0022), radius = 20.0},
        {coords = vector3(-317.3275, -118.4308, 39.0022), radius = 20.0},
        {coords = vector3(-315.4681, -113.1824, 39.0022), radius = 20.0},
        {coords = vector3(-313.5297, -108.0527, 39.0022), radius = 20.0},
        {coords = vector3(-311.7231, -102.8835, 39.0022), radius = 20.0},
    
        {coords = vector3(-349.5033, -131.3011, 39.01904), radius = 20.0},
        {coords = vector3(-347.1165, -124.6418, 39.01904), radius = 20.0},
        {coords = vector3(-343.1736, -113.789, 39.01904), radius = 20.0}
    
    },
    
    --Check engine, Low oil, Mileage location on screen
    InfoBottom = 1,
    InfoRight = 1,
    
    
    -- Parts of vehicle certain condicions can access! For example with mechanic tool box you will be able to access parts mentioned in MechanicTools
    -- PART LIST (engine, oil, brakes, suspension, turbo, nitro )
    
    BearHandsAccessCommand = 'inspect',
    BearHandsAccess = {
        ['oil'] = true
    },
    
    ToolBoxAccess = {
        ['oil'] = true,
        ['nitro'] = true,
        ['tires'] = true,
        ['sparkplugs'] = true
    },
    
    MechanicToolsAccess = {
        ['oil'] = true,
        ['nitro'] = true,
        ['tires'] = true,
        ['brakes'] = true,
        ['suspension'] = true,
        ['sparkplugs'] = true
    },
    
    MechanicWorkshopAccess = {
        ['oil'] = true,
        ['nitro'] = true,
        ['tires'] = true,
        ['brakes'] = true,
        ['suspension'] = true,
        ['engine'] = true,
        ['transmission'] = true,
        ['turbo'] = true,
        ['sparkplugs'] = true
    },
    
    
    -- Parts that your vehicle will be able to use to modify its performance on the road. These parts also need to be added to the item databse.
    -- usability - is to exclude some parts to be used on some vehicles exclusive is usually car spawn code
    -- power - depends if using relative values but it will increase vehicles power
    -- durability - (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
    -- repair - enter ingrediants to fix up the part. If part is at 0 percent you will need to replace.
    
    Turbos = { -- Turbos affect your car speed at higher rpm's. When turbos break you lose power
    
    ['single_turbo'] = {
        label = "Single Turbo", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 8.0,
        durability = 65.0,
        repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
    },
    
    ['big_single_turbo'] = {
        label = "Big Single Turbo", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 12.0,
        durability = 60.0,
        repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
    },
    
    ['twin_turbo'] = {
        label = "Twin Turbo", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 18.0,
        durability = 55.0,
        repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
    },
    
    ['race_twin_turbo'] = {
        label = "Race Twin Turbo", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 22.0,
        durability = 50.0,
        repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
    }
    
    },
    
    NitroKey = 'LEFTSHIFT', -- Key to use nitro when available
    
    Nitros = { -- Nitro affect vehicle power and increases vehicle wear during usage
    
    ['nos'] = {
        label = "NOS", 
        usability = {exclusive = {}, vehicletypes = {}},
        power = 10.0,
        durability = 10.0 -- Here enter seconds until nitro will run out
    }
    
    },
    
    Transmissions = {
    
    ['stock_transmission'] = {
        label = "OEM", 
        usability = {exclusive = {}, vehicletypes = {}},
        shiftingtime = 0.9,
        drivingwheels = 'DEFAULT',
        durability = 50.0,
        repair = {
            ['transmission_gear'] = {amount = 1, label = "Iron", reusable = false}
        }
    },
    
    ['race_transmission'] = {
        label = "Race RWD", 
        usability = {exclusive = {}, vehicletypes = {}},
        shiftingtime = 9.0,
        drivingwheels = 'RWD',
        durability = 35.0,
        repair = {
            ['transmission_gear'] = {amount = 1, label = "Iron", reusable = false}
        }
    },
    
    ['race_transmission_4wd'] = {
        label = "Race AWD", 
        usability = {exclusive = {}, vehicletypes = {}},
        shiftingtime = 9.0,
        drivingwheels = 'AWD', -- FWD RWD AWD
        durability = 35.0,
        repair = {
            ['transmission_gear'] = {amount = 1, label = "Iron", reusable = false}
        }
    },
    
    ['race_transmission_fwd'] = {
        label = "Race FWD", 
        usability = {exclusive = {}, vehicletypes = {}},
        shiftingtime = 9.0,
        drivingwheels = 'FWD', -- FWD RWD 4WD
        durability = 35.0,
        repair = {
            ['transmission_gear'] = {amount = 1, label = "Iron", reusable = false}
        }
    },
    
    ['street_transmission'] = {
        label = "Street RWD", 
        usability = {exclusive = {}, vehicletypes = {}},
        shiftingtime = 4.0,
        drivingwheels = 'RWD',
        durability = 45.0,
        repair = {
            ['transmission_gear'] = {amount = 1, label = "Iron", reusable = false}
        }
    },
    
    ['street_transmission_4wd'] = {
        label = "Street AWD", 
        usability = {exclusive = {}, vehicletypes = {}},
        shiftingtime = 4.0,
        drivingwheels = 'AWD', -- FWD RWD AWD
        durability = 45.0,
        repair = {
            ['transmission_gear'] = {amount = 1, label = "Iron", reusable = false}
        }
    },
    
    ['street_transmission_fwd'] = {
        label = "Street FWD", 
        usability = {exclusive = {}, vehicletypes = {}},
        shiftingtime = 4.0,
        drivingwheels = 'FWD', -- FWD RWD 4WD
        durability = 45.0,
        repair = {
            ['transmission_gear'] = {amount = 1, label = "Iron", reusable = false}
        }
    }
    
    },
    
    Suspensions = { -- Suspension will affect handling and will look super cool. Decrease power to lower the vehicle and give better handling.
    
    ['stock_suspension'] = {
        label = "OEM", 
        usability = {exclusive = {}, vehicletypes = {}},
        height = 0,
        traction = -0.8,
        durability = 30.0,
        repair = {
            ['spring'] = {amount = 4, label = "Springs", reusable = false},
            ['strut'] = {amount = 5, label = "Struts", reusable = false}
        }
    },
    
    ['lowering_springs'] = {
        label = "Lowering Springs", 
        usability = {exclusive = {}, vehicletypes = {}},
        height = -0.03,
        traction = -0.75,
        durability = 40.0,
        repair = {
            ['spring'] = {amount = 4, label = "Springs", reusable = false},
            ['strut'] = {amount = 4, label = "Struts", reusable = false}
        }
    },
    
    ['coil_overs'] = {
        label = "Coil Overs", 
        usability = {exclusive = {}, vehicletypes = {}},
        height = -0.06,
        traction = -0.75,
        durability = 45.0,
        repair = {
            ['spring'] = {amount = 4, label = "Springs", reusable = false},
            ['race_strut'] = {amount = 4, label = "Race Struts", reusable = false}
        }
    },
    
    ['race_coil_overs'] = {
        label = "Race Coils", 
        usability = {exclusive = {}, vehicletypes = {}},
        height = -0.08,
        traction = -0.75,
        durability = 50.0,
        repair = {
            ['Lowering_spring'] = {amount = 4, label = "Lowering Springs", reusable = false},
            ['race_strut'] = {amount = 4, label = "Race Struts", reusable = false}
        }
    },
    
    ['stanced_coil_overs'] = {
        label = "Stanced Coils", 
        usability = {exclusive = {}, vehicletypes = {}},
        height = -0.1,
        traction = -0.7,
        durability = 25.0,
        repair = {
            ['lowering_spring'] = {amount = 4, label = "Lowering Springs", reusable = false},
            ['race_strut'] = {amount = 4, label = "Race Struts", reusable = false}
        }
    },
    
    ['lifted_coil_overs'] = {
        label = "Lifted Coils", 
        usability = {exclusive = {}, vehicletypes = {}},
        height = 0.5,
        traction = -0.75,
        durability = 35.0,
        repair = {
            ['spring'] = {amount = 4, label = "Springs", reusable = false},
            ['race_strut'] = {amount = 4, label = "Race Struts", reusable = false}
        }
    }
    
    },
    
    Oils = { -- Oils keep your car cool and happy if oil runs out car parts will start to wear off fast.
    
    ['stock_oil'] = {
        label = "OEM", 
        usability = {exclusive = {}, vehicletypes = {}},
        durability = 25.0,
    },
    
    ['mobile1_oil'] = {
        label = "Mobile 1", 
        usability = {exclusive = {}, vehicletypes = {}},
        durability = 30.0,
    },
    
    ['amsoil_oil'] = {
        label = "Amsoil", 
        usability = {exclusive = {}, vehicletypes = {}},
        durability = 40.0,
    },
    
    ['royal_purple_oil'] = {
        label = "Royal Purple", 
        usability = {exclusive = {}, vehicletypes = {}},
        durability = 35.0,
    }
    
    },
    
    
    
    Engines = { -- Engines will make your car faster and will give it a different sound. Increase power to make car faster. 
    
    ['stock_engine'] = {
        label = "OEM", 
        power = 0.0,
        durability = 85.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "DEFAULT",
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    }, 

    ['k20a'] = {
        label = "Honda K20", 
        power = 3.0,
        durability = 90.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "k20a", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    },
    
    ['amgv8'] = {
        label = "AMG V8", 
        power = 6.0,
        durability = 80.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "brabus850", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    }, 
    
    ['2jzengine'] = {
        label = "Toyota 2JZ", 
        power = 5.0,
        durability = 85.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "toysupmk4", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    },

    ['rb26'] = {
        label = "Nissan RB 26", 
        power = 5.5,
        durability = 80.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "rb26dett", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    },
    
    ['chevylt5'] = {
        label = "Chevy LT5 S/C", 
        power = 6.5,
        durability = 90.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "predatorv8", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    },

    ['rotary7'] = {
        label = "Mazda 13b", 
        power = 4.0,
        durability = 70.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "rotary7", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    },

    ['full_bolt_on_engine'] = {
        label = "Full Bolt On", 
        power = 8.0,
        durability = 70.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "DEFAULT", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    },

    ['tuned_engine'] = {
        label = "Tuned OEM", 
        power = 5.0,
        durability = 80.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "DEFAULT", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    },

    ['lambov10'] = {
        label = "Lambo V10", 
        power = 12.0,
        durability = 75.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "lambov10", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
    }
    
    },
     
    Tires = { -- Tires affect your cars handling when launching and in corners. Increase traction for better grip or decrease for more drift. When they wear off you will drive without tires lol
    
    ['stock_tires'] = {
        label = "OEM", 
        usability = {exclusive = {}, vehicletypes = {}},
        traction = 0.0,
        width = 0.5,
        size = 0.2,
        lowspeedtraction = 0.0,
        durability = 30.0,
        repair = {
            ['rubber'] = {amount = 4, label = "Rubber", reusable = false}
        }
    },
    
    ['michelin_tires'] = {
        label = "Michelin", 
        usability = {exclusive = {}, vehicletypes = {}},
        traction = 0.8,
        width = 0.5,
        size = 0.2,
        lowspeedtraction = 0.0,
        durability = 35.0,
        repair = {
            ['rubber'] = {amount = 5, label = "Rubber", reusable = false}
        }
    },
    
    ['pirelli_tires'] = {
        label = "Pirelli", 
        usability = {exclusive = {}, vehicletypes = {}},
        traction = 0.65,
        width = 0.5,
        size = 0.2,
        lowspeedtraction = 0.0,
        durability = 40.0,
        repair = {
            ['rubber'] = {amount = 6, label = "Rubber", reusable = false}
        }
    },

    ['hankook_tires'] = {
        label = "Hankook", 
        usability = {exclusive = {}, vehicletypes = {}},
        traction = 0.25,
        width = 0.5,
        size = 0.2,
        lowspeedtraction = 0.0,
        durability = 50.0,
        repair = {
            ['rubber'] = {amount = 8, label = "Rubber", reusable = false}
        }
    },

    ['dunlop_tires'] = {
        label = "Dunlop", 
        usability = {exclusive = {}, vehicletypes = {}},
        traction = 0.5,
        width = 0.5,
        size = 0.2,
        lowspeedtraction = 0.0,
        durability = 40.0,
        repair = {
            ['rubber'] = {amount = 5, label = "Rubber", reusable = false}
        }
    },

    ['falken_tires'] = {
        label = "Falken", 
        usability = {exclusive = {}, vehicletypes = {}},
        traction = 0.75,
        width = 0.5,
        size = 0.2,
        lowspeedtraction = 0.0,
        durability = 25.0,
        repair = {
            ['rubber'] = {amount = 8, label = "Rubber", reusable = false}
        }
    },
    
    ['nitto_tires'] = {
        label = "Nitto", 
        usability = {exclusive = {}, vehicletypes = {}},
        traction = 0.0,
        width = 0.5,
        size = 0.2,
        lowspeedtraction = 1.0,
        durability = 5.0,
        repair = {
            ['rubber'] = {amount = 9, label = "Rubber", reusable = false}
        }
    }
    
    
    },
    
    Brakes = { -- Brakes allow you to stop your car. Increase power to make brakes more affective. When brakes break you will lose ability to break 
    
    ['stock_brakes'] = {
        label = "OEM", 
        usability = {exclusive = {}, vehicletypes = {}},
        power = 1.0,
        durability = 25.0,
        repair = {
            ['rotor'] = {amount = 4, label = "Rotors", reusable = false},
            ['brake_pad'] = {amount = 4, label = "Brake Pads", reusable = false}
        }
    },
    
    ['upgraded_brake_pads'] = {
        label = "Upgraded Brakes", 
        usability = {exclusive = {}, vehicletypes = {}},
        power = 1.4,
        durability = 30.0,
        repair = {
            ['rotor'] = {amount = 4, label = "Rotors", reusable = false},
            ['race_brake_pad'] = {amount = 4, label = "Race Pads", reusable = false}
        }
    },
    
    ['brembo_brakes'] = {
        label = "Brembo", 
        usability = {exclusive = {}, vehicletypes = {}},
        power = 1.75,
        durability = 40.0,
        repair = {
            ['rotor'] = {amount = 5, label = "Rotors", reusable = false},
            ['race_brake_pad'] = {amount = 4, label = "Race Pads", reusable = false},
            ['nuts_and_bolts'] = {amount = 2, label = "Nuts & Bolts", reusable = false},
        }
    },
    
    ['wilwood_brakes'] = {
        label = "Wilwood", 
        usability = {exclusive = {}, vehicletypes = {}},
        power = 2.0,
        durability = 45.0,
        repair = {
            ['rotor'] = {amount = 5, label = "Rotors", reusable = false},
            ['race_brake_pad'] = {amount = 4, label = "Race Pads", reusable = false},
            ['nuts_and_bolts'] = {amount = 4, label = "Nuts & Bolts", reusable = false},
        }
    }
    
    },
    
    SparkPlugs = { -- Spark Plugs affect your car ignition. This will cause the vehicle to switch the engine off randomly
    
        ['stock_sparkplugs'] = {
            label = "OEM", 
            usability = {exclusive = {}, vehicletypes = {}}, 
            durability = 30.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
            startbreak = 5.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
            minfail = 10000, -- min time when engine turns off in ms
            maxfail = 50000, -- max time when engine turns off in ms
        },
    
        ['ngk_sparkplugs'] = {
            label = "NGK", 
            usability = {exclusive = {}, vehicletypes = {}}, 
            durability = 50.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
            startbreak = 8.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
            minfail = 20000, -- min time when engine turns off in ms
            maxfail = 35000, -- max time when engine turns off in ms
        },
    
        ['champion_sparkplugs'] = {
            label = "Champion", 
            usability = {exclusive = {}, vehicletypes = {}}, 
            durability = 40.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
            startbreak = 6.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
            minfail = 15000, -- min time when engine turns off in ms
            maxfail = 30000, -- max time when engine turns off in ms
        }
    
    },
    
    --en
    Text = {
    
        ['hood_closed'] = 'Hood closed!',
        ['mechanic_action_complete'] = 'Repair finished',
        ['mechanic_action_started'] = 'Repair started',
        ['wrong_job'] = 'Wrong Job',
        ['not_enough'] = 'Not enough items',
        
        --Added
        ['vehicle_locked'] = 'Vehicle locked!',
        ['vehicle_nearby'] = 'No vehicle nearby!',
        ['vehicle_notonlift'] = 'Vehicle not on the lift!',
        ['vehicle_notoncarjack'] = 'Vehicle not on the carjack!',
        
        --Parts Stuff
        ['install_engine'] = '[~r~E~w~] Install engine',
        ['repair_engine'] = '[~r~E~w~] Repair engine',
        ['installing_engine'] = '~r~Engine is being installed',
        ['repairing_engine'] = '~r~Engine is being repaired',
        ['install_turbo'] = '[~r~E~w~] Install turbo',
        ['repair_turbo'] = '[~r~E~w~] Repair turbo',
        ['installing_turbo'] = '~r~Turbo is being installed',
        ['repairing_turbo'] = '~r~Turbo is being repaired',
        ['install_nitro'] = '[~r~E~w~] Install nitro',
        ['repair_nitro'] = '[~r~E~w~] Repair nitro',
        ['installing_nitro'] = '~r~Nitro is being installed',
        ['repairing_nitro'] = '~r~Nitro is being repaired',
        ['exchange_oil'] = '[~r~E~w~] Change oil',
        ['refill_oil'] = '[~r~E~w~] Refill oil',
        ['refilling_oil'] = '~r~Oil is being refilled',
        ['exchanging_oil'] = '~r~Oil is being changed',
        ['install_transmission'] = '[~r~E~w~] Install transmission',
        ['repair_transmission'] = '[~r~E~w~] Repair transmission',
        ['installing_transmission'] = '~r~Transmission is being installed',
        ['repairing_transmission'] = '~r~Transmission is being repaired',
        ['install_tire'] = '[~r~E~w~] Install tire',
        ['install_brakes'] = '[~r~E~w~] Install brake',
        ['install_suspension'] = '[~r~E~w~] Install suspension',
        
            
        --New
        ['install_sparkplugs'] = '[~r~E~w~] Install sparkplugs'
    }
    
    }
    
    
    
    function SendTextMessage(msg)
    
            --SetNotificationTextEntry('STRING')
            --AddTextComponentString(msg)
            --DrawNotification(0,1)
    
            exports['mythic_notify']:SendAlert('inform', msg)
    end
    