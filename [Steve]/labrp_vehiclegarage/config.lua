Config = {}

Config.EnableVersionCheck = false -- If set to true you'll get a print in server console when your resource is out of date
Config.VersionCheckInterval = 60 -- in minutes

Config.GaragePed = `s_m_y_airworker`
Config.ImpoundPed = `s_m_y_construct_01`

Config.BlipColors = {
    Car = 3,
    Boat = 51,
    Aircraft = 81
}

Config.ImpoundPrices = {
    -- These are vehicle classes
    ['0'] = 100, -- Compacts
    ['1'] = 200, -- Sedans
    ['2'] = 200, -- SUVs
    ['3'] = 350, -- Coupes
    ['4'] = 400, -- Muscle
    ['5'] = 450, -- Sports Classics
    ['6'] = 550, -- Sports
    ['7'] = 600, -- Super
    ['8'] = 250, -- Motorcycles
    ['9'] = 400, -- Off-road
    ['10'] = 500, -- Industrial
    ['11'] = 500, -- Utility
    ['12'] = 300, -- Vans
    ['13'] = 100, -- Cylces
    ['14'] = 2800, -- Boats
    ['15'] = 3500, -- Helicopters
    ['16'] = 3800, -- Planes
    ['17'] = 500, -- Service
    ['18'] = 0, -- Emergency
    ['19'] = 100, -- Military
    ['20'] = 1500, -- Commercial
    ['21'] = 0 -- Trains (lol)
}

Config.PayInCash = true -- whether you want to pay impound price in cash, otherwise uses bank

Config.Impounds = {
    InnocenceBlvd = {
        ImpoundType = 'car', -- car, boat or aircraft
        PedCoords = {x = 409.25, y = -1623.08, z = 28.29, h = 228.84},
        Zone = {name = 'innocence', x = 408.02, y = -1637.08, z = 29.29, l = 31.6, w = 26.8, h = 320, minZ = 28.29, maxZ = 32.29}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        Spawns = {
            {x = 416.83, y = -1628.29, z = 29.11, h = 140.43}, 
            {x = 419.58, y = -1629.71, z = 29.11, h = 141.98},
            {x = 421.17, y = -1636.00, z = 29.11, h = 88.21},
            {x = 420.05, y = -1638.93, z = 29.11, h = 88.95},
        }
    },
    --[[LSBoatImpound = {
        ImpoundType = 'boat',
        PedCoords = {x = -462.92, y = -2443.44, z = 5.00, h = 322.40},
        Zone = {name = 'lsboat impound', x = -451.72, y = -2440.42, z = 6.0, l = 22.6, w = 29.4, h = 325, minZ = 5.0, maxZ = 9.0},
        Spawns = {
            {x = -493.48, y = -2466.38, z = -0.06, h = 142.26}, 
            {x = -471.09, y = -2483.94, z = 0.28, h = 152.74},
        }
    },
    SandyAircraft = {
        ImpoundType = 'aircraft',
        PedCoords = {x = 1758.29, y = 3297.50, z = 40.15, h = 148.27},
        Zone = {name = 'sandy air', x = 1757.71, y = 3296.72, z = 41.15, l = 14.4, w = 18.0, h = 50, minZ = 40.13, maxZ = 44.13},
        Spawns = {
            {x = 1753.72, y = 3272.12, z = 41.99, h = 105.71},
            {x = 1746.85, y = 3252.57, z = 42.30, h = 105.58},
        }
    },
    
        TEMPLATE:
        SomeName = {
            ImpoundType = 'car', - can be 'car', 'boat' or 'aircraft',
            PedCoords = {x = X, y = X, z = X, h = X}, -- Ped MUST be inside the create zone
            Zone = {name = 'somename', x = X, y = X, z = X, l = X, w = X, h = X, minZ = X, maxZ = x}, -- l is length of the box zone, w is width, h is heading, take all walues from generated zone from /pzcreate
            Spawns = { -- You can have as many as you'd like
                {x = X, y = X, z = X, h = X},
                {x = X, y = X, z = X, h = X}
            }
        },
    ]]
}

Config.Garages = {
    LSC = {
        Display = "LSC Garage",
        GarageType = 'car', -- car, boat or aircraft
        PedCoords = {x = -349.5956, y = -148.9714, z = 38.0022, h = 293.0}, -- The Ped MUST be inside the PolyZone
        Zone = {display = 'LSC Garage', name = 'lsc', x = -345.5472, y = -150.778, z = 39.0022, l = 52.4, w = 39.6, h = 340, minZ = 38.00, maxZ = 40.00},
        Spawns = {
            {x = -346.022, y = -151.0022, z = 39.0022, h = 288.00},
            {x = -344.2945, y = -154.444, z = 39.0022, h = 288.00},
            {x = -342.3165, y = -157.7802, z = 39.0022, h = 288.00},
            {x = -340.378, y = -161.3143, z = 39.0022, h = 288.00},
        }
    },
    LSCTow = {
        Display = "LSC Tow Garage",
        GarageType = 'car', -- car, boat or aircraft
        PedCoords = {x = -369.4418, y = -80.03077, z = 38.0022, h = 220.0}, -- The Ped MUST be inside the PolyZone
        Zone = {display = 'LSC Tow Garage', name = 'lsctow', x = -366.1319, y = -85.51648, z = 39.0022, l = 52.4, w = 39.6, h = 340, minZ = 38.00, maxZ = 40.00},
        Spawns = {
            {x = -366.1319, y = -85.51648, z = 39.0022, h = 250.47},
        }
    },
    Legion = {
        Display = "Legion Square",
        GarageType = 'car', -- car, boat or aircraft
        PedCoords = {x = 215.90, y = -808.87, z = 29.74, h = 248.0}, -- The Ped MUST be inside the PolyZone
        Zone = {display = 'Legion Square', name = 'legion', x = 228.68, y = -789.15, z = 30.59, l = 52.4, w = 39.6, h = 340, minZ = 28.99, maxZ = 32.99},
        Spawns = {
            {x = 206.25, y = -801.21, z = 31.00, h = 250.47},
            {x = 208.72, y = -796.45, z = 30.95, h = 246.74},
            {x = 210.89, y = -791.42, z = 30.90, h = 248.02},
            {x = 216.12, y = -801.68, z = 30.80, h = 68.72},  
            {x = 218.21, y = -796.79, z = 30.77, h = 68.80},  
            {x = 219.76, y = -791.47, z = 30.76, h = 69.89},  
            {x = 221.37, y = -786.53, z = 30.78, h = 70.72},  
            {x = 212.52, y = -783.46, z = 30.89, h = 248.63},
        }
    },
    Americano = {
        Display = "Americano Way",
        GarageType = 'car',
        PedCoords = {x = -1651.83, y = 63.90, z = 61.86, h = 338.03},
        Zone = {name = 'americano', x = -1682.74, y = 60.93, z = 63.5, l = 59.6, w = 60.6, h = 329, minZ = 61.15, maxZ = 68.35},
        Spawns = {
            {x = -1660.57, y = 75.52, z = 63.20, h = 170.90}, 
            {x = -1666.24, y = 79.84, z = 63.45, h = 171.92},
            {x = -1671.97, y = 84.59, z = 63.83, h = 169.94},
            {x = -1662.57, y = 57.99, z = 62.90, h = 293.91},
            {x = -1664.75, y = 60.63, z = 63.05, h = 292.60},
            {x = -1667.53, y = 62.90, z = 63.21, h = 291.82},
        }
    },
    Route68 = {
        Display = "Route 68",
        GarageType = 'car',
        PedCoords = {x = 587.23, y = 2723.50, z = 41.13, h = 7.85},
        Zone = {display = 'Route 68', name = 'route68', x = 573.19, y = 2727.17, z = 42.06, l = 22.4, w = 51.2, h = 4, minZ = 41.08, maxZ = 45.08},
        Spawns = {
            {x = 584.51, y = 2721.56, z = 41.88, h = 3.59}, 
            {x = 581.14, y = 2721.32, z = 41.88, h = 3.99},
            {x = 578.15, y = 2720.59, z = 41.88, h = 4.65},
            {x = 574.86, y = 2721.09, z = 41.88, h = 4.85},
            {x = 572.01, y = 2720.28, z = 41.88, h = 5.40},
            {x = 568.78, y = 2720.25, z = 41.88, h = 5.15},
            {x = 565.86, y = 2719.79, z = 41.88, h = 3.42},
            {x = 562.68, y = 2719.95, z = 41.88, h = 3.98},
            {x = 559.54, y = 2719.52, z = 41.88, h = 3.45},
        }
    },
    Paleto = {
        Display = "Paleto",
        GarageType = 'car',
        PedCoords = {x = 140.62, y = 6613.02, z = 31.06, h = 183.37},
        Zone = {display = 'Paleto', name = 'paleto', x = 152.63, y = 6600.21, z = 30.84, l = 28.2, w = 27.2, h = 0, minZ = 30.84, maxZ = 34.84},
        Spawns = {
            {x = 145.55, y = 6601.92, z = 31.67, h = 357.80},
            {x = 150.56, y = 6597.71, z = 31.67, h = 359.00},
            {x = 155.55, y = 6592.92, z = 31.67, h = 359.57},
            {x = 145.90, y = 6613.97, z = 31.64, h = 0.60},
            {x = 151.04, y = 6609.26, z = 31.69, h = 357.50},
            {x = 155.84, y = 6602.45, z = 31.86, h = 0.47},
        }
    },
    MRPD = {
        Display = "MRPD",
        GarageType = 'car',
        PedCoords = {x = 441.4418, y = -984.8571, z = 24.6908, h = 0.37},
        Zone = {display = 'MRPD', name = 'MRPD', x = 442.5231, y = -986.5978, z = 24.6908, l = 28.2, w = 27.2, h = 0, minZ = 24.69, maxZ = 28.69},
        Spawns = {
            {x = 445.7275, y = -986.2418, z = 24.6908, h = 270.00},
            {x = 445.7275, y = -988.9451, z = 24.6908, h = 270.00},
            {x = 445.7275, y = -991.6616, z = 24.6908, h = 270.00},
            {x = 445.7275, y = -994.3384, z = 24.6908, h = 270.00},
            {x = 445.7275, y = -997.0286, z = 24.6908, h = 270.00},

            {x = 437.3802, y = -986.0967, z = 24.6908, h = 90.00},
            {x = 437.3802, y = -988.9055, z = 24.6908, h = 90.00},
            {x = 437.3802, y = -991.5692, z = 24.6908, h = 90.00},
            {x = 437.3802, y = -994.2462, z = 24.6908, h = 90.00},
            {x = 437.3802, y = -996.9363, z = 24.6908, h = 90.00},
        }
    },
    PDM = {
        Display = "PDM",
        GarageType = 'car',
        PedCoords = {x = -50.76923, y = -1082.796, z = 25.87036, h = 340.00},
        Zone = {display = 'PDM', name = 'pdm', x = -47.59121, y = -1078.325, z = 25.87036, l = 20.0, w = 25.0, h = 340.0, minZ = 25.87036, maxZ = 27.73547},
        Spawns = {
            {x = -45.53407, y = -1083.059, z = 25.71863, h = 70.00},
        }
    },
    Alta = {
        Display = "Alta Street",
        GarageType = 'car',
        PedCoords = {x = -293.5385, y = -986.8615, z = 30.06592, h = 70.00},
        Zone = {display = 'Alta Street', name = 'Alta Street', x = -318.1714, y = -976.1934, z = 30.06592, l = 60.4, w = 20.6, h = 70, minZ = 29.0, maxZ = 35.0},
        Spawns = {
            {x = -297.8637, y = -990.7648, z = 30.06592, h = 340.00},
            {x = -301.4242, y = -989.4066, z = 30.06592, h = 340.00},
            {x = -304.7604, y = -988.0088, z = 30.06592, h = 340.00},
            {x = -308.2813, y = -986.7033, z = 30.06592, h = 340.00},
            {x = -311.8945, y = -985.5824, z = 30.06592, h = 340.00},

            {x = -315.2176, y = -984.224, z = 30.06592, h = 340.00}, 
            {x = -318.6593, y = -982.9583, z = 30.06592, h = 340.00},
            {x = -322.2066, y = -981.6132, z = 30.06592, h = 340.00},
            {x = -325.7407, y = -980.545, z = 30.06592, h = 340.00},
            {x = -329.1297, y = -979.3846, z = 30.06592, h = 340.00},
        }
    },
    --[[HighwayPier = {
        GarageType = 'boat',
        PedCoords = {x = -3428.27, y = 967.34, z = 7.35, h = 269.47},
        Zone = {name = 'pier', x = -3426.48, y =  968.89, z = 8.35, l = 31.2, w = 39.2, h = 0, minZ = nil, maxZ = nil},
        Spawns = {
            {x = -3444.37, y = 952.64, z = 1.02, h = 98.70}, 
            {x = -3441.02, y = 965.30, z = 0.17, h = 87.18},
        }
    },
    LSIA = {
        GarageType = 'aircraft',
        PedCoords = {x = -941.43, y = -2954.87, z = 12.95, h = 151.00},
        Zone = {name = 'lsia', x = -968.31, y = -2992.47, z = 13.95, l = 94.4, w = 84.6, h = 330, minZ = nil, maxZ = nil},
        Spawns = {
            {x = -958.57, y = -2987.20, z = 13.95, h = 58.19},
            {x = -971.89, y = -3008.83, z = 13.95, h = 59.47},
            {x = -984.30, y = -3025.04, z = 13.95, h = 58.52}, 
        }
    },
    
        TEMPLATE:
        SomeName = {
            GarageType = 'car', - can be 'car', 'boat' or 'aircraft',
            PedCoords = {x = X, y = X, z = X, h = X}, -- Ped MUST be inside the create zone
            Zone = {name = 'somename', x = X, y = X, z = X, l = X, w = X, h = X, minZ = X, maxZ = x}, -- l is length of the box zone, w is width, h is heading, take all walues from generated zone from /pzcreate
            Spawns = { -- You can have as many as you'd like
                {x = X, y = X, z = X, h = X},
                {x = X, y = X, z = X, h = X}
            }
        },
    ]]
}
