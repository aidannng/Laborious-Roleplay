---------------------------------------------------------------------
                --[[SCRIPT MADE BY : ALEXMIHAI04]]--
               --[[DO NOT SELL OR COPY THIS SCRIPT]]--
                   --[[github.com/ItsAlexYTB]]--
        --[[ENJOY THE SCRIPT , DO NOT MAKE 1000 NPCS :))))) ]]
---------------------------------------------------------------------

--[[EXPLANATION [EN]: 

-1,2,3 : Coordonates
-4 : Name for the drawtext
-5 : Ped heading
-6 : Ped hash
-7: Ped model

]]--

--[[DO NOT TOUCH IF YOU DON'T KNOW WHAT YOU DO]]--

--[[EXPLANATION [RO]
-1,2,3 : sunt coordonatele de la npc
-4 : Numele care apare deasupra npc-ului
-5 : Heading (partea in care sta orientat)
-6 : Hash de la ped , se poate lua de pe net
-7 : Modelul de la ped , asemenea , il gasiti pe net


]]--

local coordonate = {
  --24/7's
  {24.47,-1347.84,28.4,"",269.57,0x18ce57d0,"mp_m_shopkeep_01"},--Innocence Boulevard
  {-706.07,-914.64,18.22,"",90.00,0x18ce57d0,"mp_m_shopkeep_01"},--Little Seoul
  {372.42,326.00,102.57,"",252.91,0x18ce57d0,"mp_m_shopkeep_01"},--Clinton Avenue
  {-3241.40,999.94,11.83,"",355.50,0x18ce57d0,"mp_m_shopkeep_01"},--Barbareno Road
  {-3038.36,584.60,6.91,"",16.38,0x18ce57d0,"mp_m_shopkeep_01"}, --Ineseno Road
  {2557.95,380.80,107.64,"",359.13,0x18ce57d0,"mp_m_shopkeep_01"}, --Tataviam Truckstop
  {549.07,2671.95,41.16,"",94.76,0x18ce57d0,"mp_m_shopkeep_01"}, --Route 68
  {2678.50,3279.00,54.24,"",325.18,0x18ce57d0,"mp_m_shopkeep_01"}, --Earl's Mini-Mart 
  {1960.22,3739.35,31.34,"",294.17,0x18ce57d0,"mp_m_shopkeep_01"}, --Sandy 24/7
  {1727.44,6414.75,34.04,"",228.95,0x18ce57d0,"mp_m_shopkeep_01"}, --Globe Oil gas station
  {1165.002,-323.6571,68.19702,"",70.95,0x18ce57d0,"mp_m_shopkeep_01"}, -- Mirror Park 
  {1697.222,4923.376,41.052,"",300.95,0x18ce57d0,"mp_m_shopkeep_01"}, ---47.35384,-1758.686,28.41467
  {-47.35384,-1758.686,28.41467,"",60.95,0x18ce57d0,"mp_m_shopkeep_01"}, ---1819.437, 793.5428, 138.0791
  {-1819.437, 793.5428, 137.0791,"",130.00,0x18ce57d0,"mp_m_shopkeep_01"},--
  {-259.7407, -965.5648, 30.21753,"",60.00,0x9712C38F,"a_m_m_prolhost_01"}, -- -552.6989, -191.7099, 38.21021
  --Amunation's
  {22.91,-1105.36,28.80,"",160.00,0xCAE9E5D5,"csb_cletus"},
  {809.68,-2159.22,28.62,"",360.00,0xCAE9E5D5,"csb_cletus"},
  {842.24,-1035.52,27.19,"",0.00,0xCAE9E5D5,"csb_cletus"},
  {254.02,-50.82,68.94,"",69.19,0xCAE9E5D5,"csb_cletus"},
  {-1303.88,-394.92,35.70,"",74.91,0xCAE9E5D5,"csb_cletus"},
  {-661.98,-933.34,20.83,"",178.01,0xCAE9E5D5,"csb_cletus"},
  {-3173.72,1088.80,19.84,"",244.28,0xCAE9E5D5,"csb_cletus"},
  {2567.62,292.36,107.73,"",360.00,0xCAE9E5D5,"csb_cletus"},
  {-1119.09,2700.09,17.55,"",220.83,0xCAE9E5D5,"csb_cletus"},
  {1692.19,3761.27,33.71,"",227.07,0xCAE9E5D5,"csb_cletus"},
  {-331.61,6085.41,30.45,"",226.14,0xCAE9E5D5,"csb_cletus"},
  {-680.3,5838.8,16.31,"",226.14,0xCE1324DE,"ig_hunter"},
  {-42.42198, -1094.308, 25.38171,"",140.14,0x9760192E,"cs_bankman"},
  {72.21,-1398.98, 28.36,"",270.14,0x445AC854,"a_f_y_bevhills_01"},
}
-- 2748.97
local coords = {
  {45.04, -1748.36, 28.55,"",51.00,0x040EABE3,"s_m_m_autoshop_01"},
  {2748.97, 3472.31, 54.68,"",246.00,0x040EABE3,"s_m_m_autoshop_01"},
  {-11.14, 6499.56, 30.50,"",42.00,0x040EABE3,"s_m_m_autoshop_01"}, -- 396.356, 352.167, 102.5428
  {1197.653, -3119.842, 4.538452,"",270.00,0xE497BBEF,"s_m_y_dealer_01"},--1197.653, -3119.842, 5.538452
  {552.77, 2663.67, 41.21,"",236.00,0x459762CA,"cs_josef"}, --Pawnshop Guy --552.77, 2663.67, 41.21  236
  {450.01, -1299.39, 28.42,"",320.71,0xCE96030B,"u_m_m_promourn_01"}, --Export Dealer   450.01, -1299.39, 29.42   320.71
  {1275.521, -1710.593, 53.75684,"",130.71,0x4DA6E849,"ig_lestercrest"}, -- Lester 1275.521 -1710.593 54.75684
  {-1609.675, -1121.618, 1.454956,"",320.71,0xC79F6928,"a_f_y_beach_01"}, -- Water Rentals
  --{-1631.947, -1160.215, 0.650728,"",440.71,0xE7A963D9,"a_m_y_beach_03"}, -- Water Rentals (RETURN)
  {1123.741, 2115.204, 54.46448,"",135.71,0xFF3E88AB,"a_m_y_dhill_01"}, -- Dirt Rentals
  {139.0154, -762.2637, 257.1509,"",345.71,0x26EF3426,"g_m_y_mexgoon_01"}, -- drug sales 
  {135.6528, -761.8945, 257.1509,"",345.71,0x106D9A99,"g_m_m_chicold_01"}, -- blackmarket -259.7407, -965.5648, 31.21753

  -- Liquor Stores
  {-193.411, -1162.497, 22.66882,"",270.00,0xC4B715D2,"ig_benny"}, --
  {-205.7407, -1007.13, 28.14502,"",360.00,0x76474545,"u_m_m_bikehire_01"},--461.6703, -975.2308, 25.6908
  {461.6703, -975.2308, 24.6908,"",140.00,0x5E3DA4A4,"s_m_y_cop_01"}, ---235.411, -1185.758, 23.02856
  {-235.411, -1185.758, 22.02856,"",360.00,0x62CC28E2,"s_m_y_armymech_01"},

  -- LS Customs
  {-369.4286, -79.78022, 38.0022,"",195.00,0xF7A74139,"mp_m_waremech_01"},
  {-324.8571, -87.38901, 38.03589,"",175.00,0xF5908A06,"s_m_y_dwservice_02"},
  {-317.5253, -90.07912, 38.03589,"",175.00,0xF5908A06,"s_m_y_dwservice_02"},
  {455.4857, -987.2176, 42.6864,"",50.00,0xAB300C07,"s_m_y_pilot_01"},
}


Citizen.CreateThread(function()

  for _,v in pairs(coordonate) do
    RequestModel(GetHashKey(v[7]))
    while not HasModelLoaded(GetHashKey(v[7])) do
      Wait(1)
    end

    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
    ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
    SetEntityHeading(ped, v[5])
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)


Citizen.CreateThread(function()

  for _,v in pairs(coords) do
    RequestModel(GetHashKey(v[7]))
    while not HasModelLoaded(GetHashKey(v[7])) do
      Wait(1)
    end

    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
    ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
    SetEntityHeading(ped, v[5])
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","static", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)


-- Citizen.CreateThread(function()

--   for _,v in pairs(coords) do
--     RequestModel(GetHashKey(v[7]))
--     while not HasModelLoaded(GetHashKey(v[7])) do
--       Wait(1)
--     end

--     RequestAnimDict("mini@strip_club@idles@bouncer@base")
--     while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
--       Wait(1)
--     end
--     ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
--     SetEntityHeading(ped, v[5])
--     FreezeEntityPosition(ped, true)
--     SetEntityInvincible(ped, true)
--     SetBlockingOfNonTemporaryEvents(ped, true)
--     TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
--   end
-- end)






