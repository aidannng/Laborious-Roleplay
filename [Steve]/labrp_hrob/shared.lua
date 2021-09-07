Config = {}

Config.Loot = {'rolex','2ct_gold_chain','advancedlockpick','diamond','gold','tv','5ct_gold_chain','8ct_gold_chain','10ct_gold_chain','lcard'}
Config.PoliceName = 'police'

Config.SellerLocation = vector3(414.75,344.5,101.42) -- Location of the NPC to sell to
Config.startLocation = vector3(205.99,-1852.24,26.47) -- Location of NPC to start Job


Config.PropChance = 1 

Config.Item1 = 'rolex' -- Database name here
Config.Item1Price = math.random(300, 800) -- Number value here

Config.Item2 = '2ct_gold_chain'
Config.Item2Price = math.random(150, 200)

Config.Item3 = 'advancedlockpick'
Config.Item3Price = math.random(70, 100)

Config.Item4 = 'diamond'
Config.Item4Price = math.random(200, 500)

Config.Item5 = 'gold'
Config.Item5Price = math.random(400, 700)

Config.Item6 = 'tv'
Config.Item6Price = math.random(10, 200)

Config.Item7 = '5ct_gold_chain'
Config.Item7Price = math.random(190, 250)

Config.Item8 = '8ct_gold_chain'
Config.Item8Price = math.random(270, 400)

Config.Item9 = '10ct_gold_chain'
Config.Item9Price = math.random(450, 600)

Config.Houses = {

 {
    hasJob = false,
    houseloc = vector3(1229.1, -725.47, 60.80),  -- Just Coords no heading
    pos = { x = 1229.1, y = -725.47, z = 60.80, h = 89.98 }, -- door coords
    animPos = { x = 1229.53, y = -724.81, z = 60.96, h = 277.96 }, -- The animation position
  },


 {
    hasJob = false,
    houseloc = vector3(1220.44, -689.44 ,  61.1), -- Just Coords no heading or letter
    pos = { x = 1220.44, y = -689.44, z = 61.1, h = 268.01 }, -- door coords
    animPos = { x = 1220.44, y = -689.44, z = 61.1, h = 268.01}, -- The animation position

  },
  

    {
    hasJob = false,
    houseloc = vector3(1265.62, -648.29, 67.92), -- Just Coords no heading or letter
    pos = { x = 1265.62, y = -648.29, z = 67.92, h = 207.34 }, -- door coords
    animPos = { x = 1265.62, y = -648.29, z = 67.92, h = 207.34 }, -- The animation position
    
  },

   {
    hasJob = false,
    houseloc = vector3(1271.14, -683.14 , 66.03), -- Just Coords no heading or letter
    pos = { x = 1271.14, y = -683.14, z = 66.03, h = 174.42 }, -- door coords
    animPos = { x = 1271.14, y = -683.14, z = 66.03, h = 174.42 }, -- The animation position
    
  },

   {
    hasJob = false,
    houseloc = vector3( 1265.47 , -703.24,  64.57), -- Just Coords no heading or letter
    pos = { x = 1265.47, y = -703.24, z = 64.57, h = 76.78 }, -- door coords
    animPos = { x = 1265.47, y = -703.24, z = 64.57, h = 76.78 }, -- The animation position
    
  },
  

     {
    hasJob = false,
    houseloc = vector3(1251.67 , -621.32 , 69.41), -- Just Coords no heading or letter
    pos = { x = 1251.67, y = -621.32, z = 69.41, h = 46.25 }, -- door coords
    animPos = { x = 1251.67, y = -621.32, z = 69.41, h = 46.25 }, -- The animation position
    
  },
  
   {
    hasJob = false,
    houseloc = vector3(126.73 , -1930.20,  22.0), -- Just Coords no heading or letter
    pos = { x = 126.73, y = -1930.20, z = 22.0, h = 207.79 },  -- door coords
    animPos = { x = 126.73, y = -1930.00, z = 21.38, h = 207.79 }, -- The animation position
    
  },
  

   {
    hasJob = false,
    houseloc = vector3(85.58 , -1959.38 ,  21.12), -- Just Coords no heading or letter
    pos = { x = 85.58 , y = -1959.38 , z = 21.12, h = 220.54 },  -- door coords
    animPos = { x = 85.58 , y = -1959.38 , z = 21.12, h = 220.54 }, -- The animation position
 },

   {
    hasJob = false,
    houseloc = vector3(76.6 , -1948.36,  1.17), -- Just Coords no heading or letter
    pos = { x = 76.6, y = -1948.36, z = 21.17, h = 45.87 },  -- door coords
    animPos = { x = 76.6, y = -1948.36, z = 21.17, h = 45.87 }, -- The animation position
  },
  
   {
    hasJob = false,
    houseloc = vector3(23.55 , -1896.36 ,  22.97), -- Just Coords no heading or letter
    pos = { x = 23.55, y = -1896.36, z = 22.97, h = 128.51 },  -- door coords
    animPos = { x = 23.55, y = -1896.36, z = 22.97, h = 128.51 }, -- The animation position
  },

   {
    hasJob = false,
    houseloc = vector3(5.29 , -1883.93 ,  23.7), -- Just Coords no heading or letter
    pos = { x = 5.29, y = -1883.93, z = 23.7, h = 139.14 },  -- door coords
    animPos = { x = 5.29, y = -1883.93, z = 23.7, h = 139.14 }, -- The animation position
  },

   {
    hasJob = false,
    houseloc = vector3(21.2 , -1844.79 ,  24.6), -- Just Coords no heading or letter
    pos = { x = 21.2, y = -1844.79, z = 24.6, h = 207.87 },  -- door coords
    animPos = { x = 21.2, y = -1844.79, z = 24.6, h = 207.87  }, -- The animation position
  },

   {
    hasJob = false,
    houseloc = vector3(30.07 , -1854.58, 24.07), -- Just Coords no heading or letter
    pos = { x = 30.07, y = -1854.58, z = 24.07, h = 218.99 },  -- door coords
    animPos = { x = 30.07, y = -1854.58, z = 24.07, h = 218.99 }, -- The animation position
  },

}