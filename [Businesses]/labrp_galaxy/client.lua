Config = {}
ESX              = nil
local PlayerData = {}
local pedspawneado = false
local notify = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(vector3(355.2264, 301.4242, 103.7391))
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 35)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.8)
	SetBlipSprite(blip, 614)
	
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Galaxy Nightclub')
	EndTextCommandSetBlipName(blip)
end)


Citizen.CreateThread(function()
  exports['labrp_Eye']:AddBoxZone("galaxymixer", vector3(356.7700, 283.4500, 94.1853), 0.7, 0.8, {
    name="galaxymixer",
    heading=165,
    debugPoly=false,
    minZ=93.20,
    maxZ=95.35
    }, {
        options = {
            {
                event = "galaxy:takemixer", 
                icon = "fas fa-glass-martini-alt",
                label = "Take Mixers",
            },
            {
                event = "galaxy:takefood", 
                icon = "fas fa-hamburger",
                label = "Take Frozen Food",
            },

        },
        job = {"galaxy"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxyice", vector3(355.1500, 280.8000, 94.1853), 0.7, 0.8, {
    name="galaxyice",
    heading=75,
    debugPoly=false,
    minZ=93.20,
    maxZ=94.35
    }, {
        options = {
            {
                event = "giveice", 
                icon = "fas fa-cubes",
                label = "Take Ice",
            },

        },
        job = {"galaxy"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxyliquor", vector3(355.3000, 282.2200, 94.1853), 0.6, 3.5, {
    name="galaxyliquor",
    heading=75,
    debugPoly=false,
    minZ=94.80,
    maxZ=95.30
    }, {
        options = {
            {
                event = "galaxy:takeliquor", 
                icon = "fas fa-beer",
                label = "Take Liquor",
            },

        },
        job = {"galaxy"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxycounter1", vector3(358.6500, 279.6, 95.14575), 1.05, 1.0, {
    name="galaxycounter1",
    heading=75,
    debugPoly=false,
    minZ=94.12,
    maxZ=94.30
    }, {
        options = {
            {
                event = "galaxystash1", 
                icon = "fas fa-shopping-bag",
                label = "Open Tray",
            },

        },
        job = {"all"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxycounter2", vector3(359.3000, 282.0, 95.14575), 1.05, 1.0, {
    name="galaxycounter2",
    heading=75,
    debugPoly=false,
    minZ=94.12,
    maxZ=94.30
    }, {
        options = {
            {
                event = "galaxystash2", 
                icon = "fas fa-shopping-bag",
                label = "Open Tray",
            },

        },
        job = {"all"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxycraft1", vector3(358.7000, 280.800, 95.14575), 0.8, 1.1, {
    name="galaxycraft1",
    heading=75,
    debugPoly=false,
    minZ=93.12,
    maxZ=94.15
    }, {
        options = {
            {
                event = "galaxy:craftdrink",
                icon = "fas fa-glass-martini", 
                label = "Make Drink",
            },
            {
                event = "galaxy:craftfood",
                icon = "fas fa-hamburger", 
                label = "Make Food",
            },
            {
                event = "giveshaker",
                icon = "fas fa-blender", 
                label = "Take Shaker",
            },
  
          },
          job = {"galaxy"},
          distance = 2.5
      }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxytv1", vector3(362.2250, 281.9200, 94.1853), 0.08, 1.45, {
    name="galaxytv1",
    heading=74.5,
    debugPoly=false,
    minZ=94.75,
    maxZ=95.46
    }, {
        options = {
            {
                event = "galaxymenu", 
                icon = "fas fa-tv",
                label = "Open Bar Menu",
            },

        },
        job = {"all"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxytv2", vector3(361.0500, 277.6000, 94.1853), 0.08, 1.45, {
    name="galaxytv2",
    heading=75,
    debugPoly=false,
    minZ=94.75,
    maxZ=95.46
    }, {
        options = {
            {
                event = "galaxymenu", 
                icon = "fas fa-tv",
                label = "Open Bar Menu",
            },

        },
        job = {"all"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxydj", vector3(375.3000, 275.800, 92.3000), 1.3, 2.0, {
    name="galaxydj",
    heading=75,
    debugPoly=false,
    minZ=91.00,
    maxZ=93.50
    }, {
        options = {
            {
                event = "myDj:open", 
                icon = "fas fa-music",
                label = "Open DJ Menu",
            },

        },
        job = {"galaxy"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("laserdj", vector3(-1151.650, -1239.596, -79.97437), 0.25, 1.3, {
    name="laserdj",
    heading=0,
    debugPoly=false,
    minZ=-80.75,
    maxZ=-80.00
    }, {
        options = {
            {
                event = "myDj:open", 
                icon = "fas fa-music",
                label = "Open DJ Menu",
            },

        },
        job = {"galaxy"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("stevepent", vector3(-292.1000, -730.8000, 130.4293), 0.55, 1.3, {
    name="stevepent",
    heading=60,
    debugPoly=false,
    minZ=130.00,
    maxZ=130.55
    }, {
        options = {
            {
                event = "myDj:open", 
                icon = "fas fa-music",
                label = "Open DJ Menu",
            },

        },
        job = {"all"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("stevepentliquor", vector3(-289.3000, -725.1000, 126.1831), 0.6, 1.65, {
    name="stevepentliquor",
    heading=160,
    debugPoly=false,
    minZ=125.30,
    maxZ=125.60
    }, {
        options = {
            {
                event = "galaxy:takeliquor", 
                icon = "fas fa-beer",
                label = "Take Liquor",
            },

        },
        job = {"all"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxycraft1", vector3(383.1000, 278.2000, 94.97729), 0.5, 0.7, {
    name="galaxycraft1",
    heading=75,
    debugPoly=false,
    minZ=94.05,
    maxZ=94.90
    }, {
        options = {
            {
                event = "galaxy:craftdrink2",
                icon = "fas fa-glass-martini", 
                label = "Make Drink",
            },
            {
                event = "galaxy:craftfood2",
                icon = "fas fa-hamburger", 
                label = "Make Food",
            },
            },
            job = {"galaxy"},
            distance = 2.5
        }) ---192.5934, -1161.798, 23.66882

  exports['labrp_Eye']:AddBoxZone("galaxycondom", vector3(382.3000, 270.1000, 91.18604), 0.50, 0.55, {
    name="galaxycondom",
    heading=75,
    debugPoly=false,
    minZ=91.30,
    maxZ=92.40
    }, {
        options = {
            {
                event = "givecondom", 
                icon = "fas fa-restroom",
                label = "Condom Dispensor",
            },

        },
        job = {"all"},
        distance = 2.5
    }) ---192.5934, -1161.798, 23.66882

end)

RegisterNetEvent('giveice')
AddEventHandler('giveice', function()  
    TriggerServerEvent('galaxy:giveice')
end)

RegisterNetEvent('giveshaker')
AddEventHandler('giveshaker', function()  
    TriggerServerEvent('galaxy:takeshaker')
end)

-- RegisterNetEvent('galaxystash1')
-- AddEventHandler('galaxystash1', function()  
--     TriggerServerEvent('galaxy:tray1')
-- end)

RegisterNetEvent('galaxystash1')
AddEventHandler('galaxystash1', function()
    ExecuteCommand('galaxytray1')
end)

RegisterNetEvent('galaxystash2')
AddEventHandler('galaxystash2', function()
    ExecuteCommand('galaxytray2')
end)

RegisterNetEvent('givecondom')
AddEventHandler('givecondom', function()
    TriggerServerEvent('galaxy:takecondom')
end)


RegisterNetEvent('galaxy:craftdrink')
AddEventHandler('galaxy:craftdrink', function()
    exports['br-menu']:SetTitle("Galaxy Nightclub - Make Drink")
    exports['br-menu']:AddButton("Make Space Vodka" , "Vodka & Ice" ,'galaxy:vodka' ,'' , 'meone')
    exports['br-menu']:AddButton("Make Multiversal Whiskey" , "Whiskey & Ice" ,'galaxy:whiskey' ,'' , 'me2')
    exports['br-menu']:AddButton("Make Sweet Blast Cocktail" , "Sweet Mango Mixer & Ice & Vodka" ,'galaxy:cocktail1' ,'' , 'me3')
    exports['br-menu']:AddButton("Make Blue Sensation Cocktail" , "Blueberry Daquiri Mixer & Ice & Vodka" ,'galaxy:cocktail2' ,'' , 'me4')
    exports['br-menu']:AddButton("Make The Eliptical Cocktail" , "Strawberry Daquiri Mixer & Ice & Vodka" ,'galaxy:cocktail3' ,'' , 'me5')
    exports['br-menu']:AddButton("Make Star Wine" , "Wine" ,'galaxy:wine' ,'' , 'me6')
    exports['br-menu']:AddButton("Make Wordly Beer" , "Beer" ,'galaxy:beer' ,'' , 'me7')
    exports['br-menu']:AddButton("Make Cosmic Soda" , "Soda Can" ,'galaxy:soda' ,'' , 'me8')
end)

RegisterNetEvent('galaxy:craftfood')
AddEventHandler('galaxy:craftfood', function()
    exports['br-menu']:SetTitle("Galaxy Nightclub - Make Food")
    exports['br-menu']:AddButton("Make Galaxy Burger" , "Burger Bun & Ground Beef & Cheese" ,'galaxy:burger' ,'' , 'meone')
    exports['br-menu']:AddButton("Make Solar Fries" , "Potato" ,'galaxy:fries' ,'' , 'me2')
    exports['br-menu']:AddButton("Make Universal Wings" , "Frozen Wings" ,'galaxy:wings' ,'' , 'me3')
end)

RegisterNetEvent('galaxy:craftdrink2')
AddEventHandler('galaxy:craftdrink2', function()
    exports['br-menu']:SetTitle("Galaxy Nightclub VIP Room - Take Drink")
    exports['br-menu']:AddButton("Take Space Vodka" , "" ,'galaxy:vodka2' ,'' , 'meone')
    exports['br-menu']:AddButton("Take Multiversal Whiskey" , "" ,'galaxy:whiskey2' ,'' , 'me2')
    exports['br-menu']:AddButton("Take Sweet Blast Cocktail" , "" ,'galaxy:cocktail12' ,'' , 'me3')
    exports['br-menu']:AddButton("Take Blue Sensation Cocktail" , "" ,'galaxy:cocktail22' ,'' , 'me4')
    exports['br-menu']:AddButton("Take The Eliptical Cocktail" , "" ,'galaxy:cocktail32' ,'' , 'me5')
    exports['br-menu']:AddButton("Take Star Wine" , "" ,'galaxy:wine2' ,'' , 'me6')
    exports['br-menu']:AddButton("Take Wordly Beer" , "" ,'galaxy:beer2' ,'' , 'me7')
    exports['br-menu']:AddButton("Take Cosmic Soda" , "" ,'galaxy:soda2' ,'' , 'me8')
end)

RegisterNetEvent('galaxy:craftfood2')
AddEventHandler('galaxy:craftfood2', function()
    exports['br-menu']:SetTitle("Galaxy Nightclub VIP Room - Take Food")
    exports['br-menu']:AddButton("Take Galaxy Burger" , "" ,'galaxy:burger2' ,'' , 'meone')
    exports['br-menu']:AddButton("Take Solar Fries" , "" ,'galaxy:fries2' ,'' , 'me2')
    exports['br-menu']:AddButton("Take Universal Wings" , "" ,'galaxy:wings2' ,'' , 'me3')
end)

RegisterNetEvent('galaxy:takemixer')
AddEventHandler('galaxy:takemixer', function()
    exports['br-menu']:SetTitle("Galaxy Nightclub - Take Mixer")
    exports['br-menu']:AddButton("Sweet Mango Mixer" , "Free" ,'galaxy:mixer1' ,'' , 'meone')
    exports['br-menu']:AddButton("Blueberry Daquiri Mixer" , "Free" ,'galaxy:mixer3' ,'' , 'me2')
    exports['br-menu']:AddButton("Strawberry Daquiri Mixer" , "Free" ,'galaxy:mixer2' ,'' , 'me3')
end)

RegisterNetEvent('galaxy:takeliquor')
AddEventHandler('galaxy:takeliquor', function()
    exports['br-menu']:SetTitle("Galaxy Nightclub - Take Mixer")
    exports['br-menu']:AddButton("Take Beer" , "Free" ,'galaxy:takebeer' ,'' , 'meone')
    exports['br-menu']:AddButton("Take Wine" , "Free" ,'galaxy:takewine' ,'' , 'me2')
    exports['br-menu']:AddButton("Take Whiskey" , "Free" ,'galaxy:takewhiskey' ,'' , 'me3')
    exports['br-menu']:AddButton("Take Vodka" , "Free" ,'galaxy:takevodka' ,'' , 'me4')
end)

RegisterNetEvent('galaxy:takefood')
AddEventHandler('galaxy:takefood', function()
    exports['br-menu']:SetTitle("Galaxy Nightclub - Take Frozen Food")
    exports['br-menu']:AddButton("Take Beef" , "Free" ,'galaxy:takebeef' ,'' , 'meone')
    exports['br-menu']:AddButton("Take Wings" , "Free" ,'galaxy:takewings' ,'' , 'meone')
    exports['br-menu']:AddButton("Take Potato" , "Free" ,'galaxy:takefries' ,'' , 'meone')
    exports['br-menu']:AddButton("Take Burger Bun" , "Free" ,'galaxy:takebun' ,'' , 'meone')
    exports['br-menu']:AddButton("Take Cheese" , "Free" ,'galaxy:takecheese' ,'' , 'meone')
end)

RegisterNetEvent('galaxymenu')
AddEventHandler('galaxymenu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Galaxy Nightclub - Food & Drinks",
            txt = ""
        },
		{
            id = 2,
            header = "Drinks",
            txt = "",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Food",
            txt = "",
            params = {
                event = "galaxymenu3",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
    })
end)

RegisterNetEvent('galaxymenu2')
AddEventHandler('galaxymenu2', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Galaxy Nightclub - Drinks",
            txt = ""
        },
		{
            id = 2,
            header = "Space Vodka",
            txt = "Vodka & Ice - $15",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Multiversal Whiskey",
            txt = "Whiskey & Ice - $20",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Sweet Blast Cocktail",
            txt = "Sweet Mango Mixer, Ice, And Vodka - $15",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
        {
            id = 5,
            header = "Blue Sensation Cocktail",
            txt = "Blueberry Daquiri Mixer, Ice, And Vodka - $15",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 4,
                    id = 5
                }
            }
        },
        {
            id = 6,
            header = "The Eliptical Cocktail",
            txt = "Strawberry Daquiri Mixer, Ice, And Vodka - $15",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 5,
                    id = 6
                }
            }
        },
        {
            id = 7,
            header = "Star Wine",
            txt = "Red Wine & Star Mixer - $15",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 6,
                    id = 7
                }
            }
        },
        {
            id = 8,
            header = "Wordly Beer",
            txt = "Beer & Worldy Mixer - $10",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 7,
                    id = 8
                }
            }
        },
        {
            id = 9,
            header = "Cosmic Soda",
            txt = "Soda & Cosmic Mixer - $5",
            params = {
                event = "galaxymenu2",
                args = {
                    number = 8,
                    id = 9
                }
            }
        },
        {
            id = 10,
            header = "Back",
            txt = "Return to Main Menu",
            params = {
                event = "galaxymenu",
                args = {
                    number = 9,
                    id = 10
                }
            }
        },
    })
end)

RegisterNetEvent('galaxymenu3')
AddEventHandler('galaxymenu3', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Galaxy Nightclub - Food",
            txt = ""
        },
		{
            id = 2,
            header = "Galaxy Burger",
            txt = "Buger Bun, Ground Beef, Cheese - $12",
            params = {
                event = "galaxymenu3",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Solar Fries",
            txt = "French Fries, Ketchup, Mayo - $8",
            params = {
                event = "galaxymenu3",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Universal Wings",
            txt = "Frozen Wings, Buffalo Sauce - $15",
            params = {
                event = "galaxymenu3",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
        {
            id = 5,
            header = "Back",
            txt = "Return to Main Menu",
            params = {
                event = "galaxymenu",
                args = {
                    number = 4,
                    id = 5
                }
            }
        },
    })
end)