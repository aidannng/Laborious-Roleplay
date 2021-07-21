Config = {}

-- Polyzone coords
Config.PolyZones = {
    DepotZone = {x = 174.87, y = -3198.28, z = 5.61, length = 50.0, width = 40.4, minZ = 4.61, maxZ = 8.61},
    LockerZone = {x = 145.9, y = -3219.0, z = 5.86, length = 1.2, width = 1.6, minZ = 2.66, maxZ = 6.66},
    JobSelectZone = {x = 152.82, y = -3211.65, z = 5.9, length = 1, width = 1, minZ = 2.9, maxZ = 6.9},
    DeleteVehicleZone = {x = 140.8, y = -3183.49, z = 5.86, length = 6.0, width = 5.6, minZ = 4.46, maxZ = 9.06}
}

Config.TruckSpawn = {
    {x = 131.71, y = -3210.28, z = 5.86, h = 269.98},
    {x = 140.68, y = -3189.16, z = 5.86, h = 181.21},
    {x = 146.58, y = -3190.22, z = 5.86, h = 184.08},
}

Config.TrailerSpawn = {
    {x = 166.07, y = -3213.30, z = 5.89, h = 266.83}, 
    {x = 166.20, y = -3223.61, z = 5.88, h = 270.72}, 
    {x = 167.04, y = -3231.21, z = 5.87, h = 269.30}, 
    {x = 167.00, y = -3236.08, z = 5.87, h = 270.27}, 
    {x = 192.42, y = -3244.69, z = 5.79, h = 184.92}, 
    {x = 192.61, y = -3268.57, z = 5.79, h = 180.51}, 
    {x = 165.48, y = -3299.04, z = 5.90, h = 273.10}, 
}

Config.EnableWorkClothes = false -- Sets work clothes once you sign on duty for the job

-- Leveling stuff
Config.MaxLevel = 10
Config.MaxProgress = 5
Config.MultiplyProgressPerLevel = true -- if set to true it will multiply the max progress with the current level

Config.PaymentInCash = false

Config.WorkClothes = { -- Ignore if Config.EnableWorkClothes is set to false
    ['skin_male'] = {
        tshirt_1 = 15,
        torso_1 = 26,
        torso_2 = 6,
        arms = 11,
        pants_1 = 4,
        pants_2 = 1,
        shoes_1 = 12,
        shoes_2 = 6,
    },

    ['skin_female'] = {
        tshirt_1 = 14,
        torso_1 = 9,
        torso_2 = 7,
        arms = 0,
        pants_1 = 0,
        pants_2 = 0,
        shoes_1 = 24,
        shoes_2 = 0,
    }
}

Config.Vehicles = {
    {label = 'Hauler', spawn = 'hauler', level = 1},
    {label = 'Phantom', spawn = 'phantom', level = 3},
    {label = 'Packer', spawn = 'packer', level = 5},
    {label = 'Phantom Custom', spawn = 'phantom3', level = 8}
}

Config.TrailerModels = {'trailers', 'trailers2', 'trailers4'}

-- Please note that heading is not the same as markerHeading
-- heading is for the polyzone, where as markerHeading you have to get from your own coords where you want the marker to be facing the direction of where you want the trailer parked
-- If your polyzone heading is 0 (which I recommend you always try to have it at 0) then your markerHeading can be 0 as well and it will work fine!
Config.DeliveryPoints = {
    {
        label = 'Oil Fields Delivery',
        desc = 'Job Payout: $%d | Required Level: %d ',
        pay = 225,
        level = 1,
        zone = {x = 1512.13, y = -2098.36, z = 76.85, length = 3.8, width = 11.4, heading = 0, minZ = 75.85, maxZ = 79.85, markerHeading = 0},
    },
    {
        label = "Popular Street - Darnell", 
        desc = "Job Payout: $%d | Required Level: %d ", 
        pay = 300,
        level = 1,
        zone = {x = 715.94, y = -874.59, z = 24.11, length = 2.8, width = 12.9, heading = 0, minZ = 22.81, maxZ = 26.81, markerHeading = 0} 
    },
    {
        label = 'YouTool Delivery',
        desc = 'Job Payout $%d | Required Level: %d ',
        pay = 1100,
        level = 2,
        zone = {x = 2702.77, y = 3453.39, z = 55.8, length = 7.4, width = 2.6, heading = 336, minZ = 54.8, maxZ = 58.8, markerHeading = 158.16}
    },
    {
        label = 'Sandy Delivery',
        desc = 'Job Payout $%d | Required Level: %d ',
        pay = 1200,
        level = 3,
        zone = {x = 1965.85, y = 3756.83, z = 32.27, length = 7.8, width = 2.4, heading = 31, minZ = 31.27, maxZ = 35.27, markerHeading = 211.02}
    },
    {
        label = 'Vinery Delivery',
        desc = 'Job Payout $%d | Required Level: %d ',
        pay = 1500,
        level = 5,
        zone = {x = -1920.41, y = 2046.49, z = 140.74, length = 7.0, width = 2.6, heading = 77, minZ = 139.74, maxZ = 143.74, markerHeading = 258.52}
    },
    {
        label = 'Grapeseed Extragavanza',
        desc = 'Job Payout $%d | Required Level: %d ',
        pay = 1800,
        level = 7,
        zone = {x = 1703.14, y = 4835.36, z = 41.95, length = 6.2, width = 2.4, heading = 277, minZ = 40.95, maxZ = 44.95, markerHeading = 97.64}
    },
    {
        label = 'Paleto Bay Journey',
        desc = 'Joy Payout $%d | Required Level: %d ',
        pay = 2100,
        level = 10,
        zone = {x = 182.23, y = 6393.71, z = 31.38, length = 7.2, width = 2.8, heading = 297, minZ = 30.38, maxZ = 34.38, markerHeading = 297.31}
    }
}


--[[
    Example zone (first one in the Config) made with pzcreate tool with PolyZone:
    --Name: zone | 2021-06-04T14:26:21Z
    BoxZone:Create(vector3(716.66, -874.63, 24.81), 2.8, 12.9, {
        name="zone",
        heading=0,
        --debugPoly=true,
        minZ=22.81,
        maxZ=26.81
    })
    So if I were to get this zone in the config I'd set the first 3 params of vector3() to x, y, z, the two params after are width and then length and the heading
    You also need to put in minZ and maxZ into the config for a zone.
]]--