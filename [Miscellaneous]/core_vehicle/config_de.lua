Config = {

-------------------------------------------------------------
-- IMPORTANT  
-- All parts need to be added to inventory
-- Custom vehicle sounds for engines (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
-------------------------------------------------------------


WearRate = 200000, -- The rate parts wear off (Higher the value less wear on the parts)
UseMiles = false, -- If set to false it will use kilometers
UseRelativeValues = true, -- If set to true cars performance wouldnt be affected with stock parts. Otherwise stock car parts will make the car slower
UseT1gerMechanic = true, -- If set to true Vehicles will use the CarJack (toolbox) and Lift (mechanic_toolbox) from the t1ger_mechanic script. Look at the Readme for using this
DetectDistance = 3.0, -- Distance where vehicles are being detected
OnlyOwnedVehicles = true, -- Script excludes not owned cars
--Double UI----------------------------------------------------------------------------------------------------------------------
SetWaitTimeBeforeLoadHud = 500, -- Wait time for show/hide the HUD when entering/leaving the vehicle in ms. Play with this value
---------------------------------------------------------------------------------------------------------------------------------
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

    {coords = vector3(-211.58894348145,6241.2221679688,31.62286376953), radius = 20.0}

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

    ['turbo_lvl_1'] = {
        label = "GARET TURBO", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 10.0,
        durability = 50.0,
        --[[repair = {
            ['iron'] = {amount = 5, label = "Eisen", reusable = false}
        }--]]
    }

},

NitroKey = 'LEFTSHIFT', -- Key to use nitro when available

Nitros = { -- Nitro affect vehicle power and increases vehicle wear during usage

    ['nos'] = {
        label = "NOS", 
        usability = {exclusive = {}, vehicletypes = {}},
        power = 100.0,
        durability = 30.0 -- Here enter seconds until nitro will run out
    }

},

Transmissions = {

['stock_transmission'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 0.9,
    drivingwheels = 'DEFAULT',
    durability = 80.0,
    repair = {
            ['car_transmissionkitstock'] = {amount = 1, label = "Getriebekit Standard", reusable = false}
        }
},

['race_transmission'] = {
    label = "R. RWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 3.0,
    drivingwheels = 'RWD',
    durability = 50.0,
    repair = {
            ['car_transmissionkitplus'] = {amount = 1, label = "Getriebekit Plus", reusable = false}
        }
},
['race_transmission_4wd'] = {
    label = "R. AWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 3.0,
    drivingwheels = 'AWD', -- FWD RWD AWD
    durability = 50.0,
    repair = {
            ['car_transmissionkitplus'] = {amount = 5, label = "Getriebekit Plus", reusable = false}
        }
},

['race_transmission_fwd'] = {
    label = "R. FWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 3.0,
    drivingwheels = 'FWD', -- FWD RWD 4WD
    durability = 50.0,
    repair = {
            ['car_transmissionkitplus'] = {amount = 5, label = "Getriebekit Plus", reusable = false}
        }
}

},

Suspensions = { -- Suspension will affect handling and will look super cool. Decrease power to lower the vehicle and give better handling.

['stock_suspension'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    height = 0,
    traction = 0,
    durability = 80.0,
    repair = {
            ['car_suspensionkitstock'] = {amount = 1, label = "Fahrwerkskit Standard", reusable = false}
        }
},

['race_suspension'] = {
    label = "RENNFAHRWERK", 
    usability = {exclusive = {}, vehicletypes = {}},
    height = -0.04,
    traction = 1.0,
    durability = 50.0,
    repair = {
            ['car_supensionkitrace'] = {amount = 1, label = "Fahrwerkskit Sport", reusable = false}
        }
}



},

Oils = { -- Oils keep your car cool and happy if oil runs out car parts will start to wear off fast.

['stock_oil'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    durability = 10.0,
},

['shell_oil'] = {
    label = "SHELL", 
    usability = {exclusive = {}, vehicletypes = {}},
    durability = 50.0,
}

},



Engines = { -- Engines will make your car faster and will give it a different sound. Increase power to make car faster. 

['stock_engine'] = {
        label = "STANDARD", 
        power = 0.0,
        durability = 99.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "DEFAULT",
        repair = {
            ['car_enginekitstock'] = {amount = 1, label = "Motorkit Standard", reusable = false}
        }
}, 

['v8engine'] = {
        label = "V8", 
        power = 30.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "brabus850", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['car_enginekitbig'] = {amount = 1, label = "Motorkit gross", reusable = false}
        }
}, 

['2jzengine'] = {
        label = "2JZ", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "toysupmk4", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['car_enginekitsmall'] = {amount = 1, label = "Motorkit klein", reusable = false}
        }
},

['lambov10'] = {
        label = "lambov10", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "lambov10", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['musv8'] = {
        label = "musv8", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "musv8", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['shonen'] = {
        label = "shonen", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "shonen", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['rb26det'] = {
        label = "rb26det", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "rb26det", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['rotary7'] = {
        label = "rotary7", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "rotary7", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['m297zonda'] = {
        label = "m297zonda", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "m297zonda", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
},
['m158huayra'] = {
        label = "m158huayra", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "m158huayra", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['k20a'] = {
        label = "k20a", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "k20a", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['gt3flat6'] = {
        label = "gt3flat6", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "gt3flat6", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['predatorv8'] = {
        label = "predatorv8", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "predatorv8", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
}, 
['p60b40'] = {
        label = "p60b40", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "p60b40", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Eisen", reusable = false},
            ['piston'] = {amount = 6, label = "Kolben", reusable = false}
        }
} 

},
 
Tires = { -- Tires affect your cars handling when launching and in corners. Increase traction for better grip or decrease for more drift. When they wear off you will drive without tires lol

['stock_tires'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    traction = -0.04,
    lowspeedtraction = 0.0,
    durability = 80.0,
    repair = {
            ['car_tirekitstock'] = {amount = 1, label = "Reifenkit Standard", reusable = false}
        }
},

['michelin_tires'] = {
    label = "MICHELIN", 
    usability = {exclusive = {}, vehicletypes = {}},
    traction = 1.0,
    lowspeedtraction = -2.7,
    durability = 30.0,
    repair = {
            ['car_tirekitmichelin'] = {amount = 1, label = "Reifenkit Plus", reusable = false}
        }
}


},

Brakes = { -- Brakes allow you to stop your car. Increase power to make brakes more affective. When brakes break you will lose ability to break 

['stock_brakes'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    power = 1.0,
    durability = 30.0,
    repair = {
            ['car_brakekitstock'] = {amount = 1, label = "Bremsenkit Standard", reusable = false}
        }
},

['race_brakes'] = {
    label = "KERAMIK", 
    usability = {exclusive = {}, vehicletypes = {}},
    power = 2.0,
    durability = 30.0,
    repair = {
            ['car_brakekitrace'] = {amount = 1, label = "Bremsenkit Keramik", reusable = false}
        }
},

},

SparkPlugs = { -- Spark Plugs affect your car ignition. This will cause the vehicle to switch the engine off randomly

    ['stock_sparkplugs'] = {
        label = "STANDARD", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        durability = 50.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
		startbreak = 25.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
		minfail = 10000, -- min time when engine turns off in ms
		maxfail = 50000, -- max time when engine turns off in ms
    },
	['ngk_sparkplugs'] = {
        label = "NGK", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        durability = 90.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
		startbreak = 15.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
		minfail = 20000, -- min time when engine turns off in ms
		maxfail = 60000, -- max time when engine turns off in ms
    }

},

Text = {

    ['hood_closed'] = 'Motorhaube ist geschlossen!',
    ['mechanic_action_complete'] = 'Reparatur abgeschlossen',
    ['mechanic_action_started'] = 'Reparatur gestartet',
    ['wrong_job'] = 'Falscher Beruf',
    ['not_enough'] = 'Nicht genug Items',
	
	--Added
	['vehicle_locked'] = 'Fahrzeug abgeschlossen!',
	['vehicle_nearby'] = 'Zu weit vom Fahrzeug entfernt!',
	['vehicle_notonlift'] = 'Fahrzeug nicht auf der Hebebühne!',
	['vehicle_notoncarjack'] = 'Fahrzeug nicht auf dem Wagenheber!',
	
	--Parts Stuff
	['install_engine'] = '[~r~E~w~] Motor installieren',
	['repair_engine'] = '[~r~E~w~] Motor reparieren',
	['installing_engine'] = '~r~Motor wird installiert',
	['repairing_engine'] = '~r~Motor wird repariert',
	['install_turbo'] = '[~r~E~w~] Turbo installieren',
	['repair_turbo'] = '[~r~E~w~] Turbo reparieren',
	['installing_turbo'] = '~r~Turbo wird installiert',
	['repairing_turbo'] = '~r~Turbo wird repariert',
	['install_nitro'] = '[~r~E~w~] Nitro installieren',
	['repair_nitro'] = '[~r~E~w~] Nitro reparieren',
	['installing_nitro'] = '~r~Nitro wird installiert',
	['repairing_nitro'] = '~r~Nitro wird repariert',
	['exchange_oil'] = '[~r~E~w~] Öl wechseln',
	['refill_oil'] = '[~r~E~w~] Öl nachfüllen',
	['refilling_oil'] = '~r~Öl wird nachgefüllt',
	['exchanging_oil'] = '~r~Öl wird gewechselt',
	['install_transmission'] = '[~r~E~w~] Getriebe installieren',
	['repair_transmission'] = '[~r~E~w~] Getriebe reparieren',
	['installing_transmission'] = '~r~Getriebe wird installiert',
	['repairing_transmission'] = '~r~Getriebe wird repariert',
	['install_tire'] = '[~r~E~w~] Reifen installieren',
	['install_brakes'] = '[~r~E~w~] Bremsen installieren',
	['install_suspension'] = '[~r~E~w~] Installiere Fahrwerk',
	['install_sparkplugs'] = '[~r~E~w~] Zündkerzen installieren',
}

}



function SendTextMessage(msg)

        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)

        --EXAMPLE USED IN VIDEO
        --exports['mythic_notify']:SendAlert('inform', msg)

end
