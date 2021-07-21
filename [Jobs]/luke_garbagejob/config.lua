Config =  {}

Config.DrawDistance = 15 -- The distance that the markers are going to draw at (Does not include the garbage marker)

Config.Locker = {x = -355.01, y = -1514.30, z = 27.72}
Config.Vehicle = {x = -316.26, y = -1536.49, z = 27.65, h = 336.34}
Config.Return = {x = -357.32, y = -1530.78, z = 27.70}

Config.UseWorkClothes = true -- Whether or not you want work clothes for the job, uses esx_skin and skinchanger

-- I would recommend having all 3 values th same, but play around with it and see what you like
Config.ScanDistance = 80.0 -- The distance it's going to scan for objects
Config.BreakDistance = 80.0 -- The distance that when player goes over it starts finding a new object
Config.ExclusionDistance = 80.0 -- The distance from excluded coord that player can't get any garbage in

Config.LevelTwo = 10 -- How much garbage do you need to collect to get to level 2
Config.LevelThree = 20 -- How much garbage do you need to collect to get to level 3
-- ^ Keep in mind that it starts from 0 when you level up

Config.PaymentInCash = false -- Set to false if you want the money to go to the bank

-- How much the player is going to earn at the levels
Config.LevelOneAmount = 35
Config.LevelTwoAmount = 55
Config.LevelMaxAmount = 70

Config.Pickups = {
    Dumpsters = {
        Models = { 'p_dumpster_t' , 'prop_cs_dumpster_01a', 'prop_dumpster_01a', 'prop_dumpster_02a', 'prop_dumpster_02b', 'prop_dumpster_3a', 'prop_dumpster_4a', 'prop_dumpster_4b', 'prop_snow_dumpster_01' }
    },

    Cans = {
        Models = { 'prop_bin_01a' , 'prop_bin_02a', 'prop_bin_03a', 'prop_bin_04a', 'prop_bin_05a', 'prop_bin_06a', 'prop_bin_07a', 'prop_bin_07b', 'prop_bin_07c', 'prop_bin_07d', 'prop_bin_08a', 'prop_bin_08open', 'prop_bin_09a', 'prop_bin_12a', 'prop_bin_beach_01a', 'prop_bin_beach_01d'  }
    },

    -- All the models from Dumpsters and Cans
    CansAndDumpsters = {
        Models = {'prop_bin_01a' , 'prop_bin_02a', 'prop_bin_03a', 'prop_bin_04a', 'prop_bin_05a', 'prop_bin_06a', 'prop_bin_07a', 'prop_bin_07b', 
        'prop_bin_07c', 'prop_bin_07d', 'prop_bin_08a', 'prop_bin_08open', 'prop_bin_09a', 'prop_bin_12a', 'prop_bin_beach_01a', 'prop_bin_beach_01d', 
        'p_dumpster_t' , 'prop_cs_dumpster_01a', 'prop_dumpster_01a', 'prop_dumpster_02a', 'prop_dumpster_02b', 'prop_dumpster_3a', 'prop_dumpster_4a', 
        'prop_dumpster_4b', 'prop_snow_dumpster_01'}
    }
}