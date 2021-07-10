Config = {
    ESX = {
        client = "esx:getSharedObject", -- the client event used to load ESX
        server = "esx:getSharedObject", -- the server event used to load ESX
    },

    Inventory = "linden", -- what inventory you use, valid options: 
    --[[
        default (menu based)
        modfreakz (MF inventory: https://modit.store/products/mf-inventory?variant=39985142268087) PAID
        linden (linden_inventory: https://github.com/thelindat/linden_inventory) FREE, I RECOMMEND THIS
    --]]

    Policeraid = {
        Enabled = false,
        Jobs = {
            {job = "police", grade = 1},
        },
    },
    
    Use3DText = true, --[[
        true = https://i.gyazo.com/29dbcb68efe6ecdbfa545cc073ab5b54.png
        false = https://i.gyazo.com/63cc5e9497ac86221611f98ce496b6fa.png
        nil = https://i.gyazo.com/1a1fa9e5210c675bf625dced112ed1aa.png
    --]]
    
    Markers = { -- markers does not impact performance
        Enabled = true,
        Colour = {r = 255, g = 240, b = 0, a = 200},
        Owned = {r = 15, g = 255, b = 150, a = 200},
    },

    Options = {
        Align = "center",
        Control = 51,
    },

    Blips = {
        Enabled = true,
        Sprite = 475,
        Colour = 0,
        Scale = 0.6,
    },

    Storage = {
        Limit = true, -- limit the amount/weight of items you can store?
        Limits = {
            500, -- 500 items/kg for instance 1
            1000, -- 1000 items/kg for instance 2
            1000, -- 1000 items/kg for instance 3
            1000, -- 100 items/kg for instance 4
            1500, -- 1500 items/kg for instance 5
        },
        Weapons = true, -- allow people to store weapons?
        WeaponWeight = 10, -- how many slots/kg a weapon takes up
    },

    Prices = {
        500, -- price for interior 1
        2000, -- price for interior 2
        1000, -- price for interior 3
        1500, -- price for interior 4
        3000, -- price for interior 5
    },

    Motels = {
        {
            Name = "Alta Street Apartments",
            Interiors = {1}, -- possible interiors you can buy in this motel
            --Interiors = {1, 2, 3, 4}, -- possible interiors you can buy in this motel
            Rent = false, -- should it cost to live in this motel?

            Location = vector4(
                -265, -- x
                -964, -- y
                31, -- z
                155.96 -- heading
            ),

            Rooms = {
                vector4(-268.7473, -962.3077, 31.21753, 338),
                vector4(-263.9736, -959.7495, 31.21753, 338),
                vector4(-270.989, -957.9033, 31.21753, 338),
                vector4(-266.3604, -955.5428, 31.21753, 338),
            }
        },
    }
}