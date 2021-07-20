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
    exports["labrp_Eye"]:AddBoxZone("BurgerShotDuty", vector3(-1196.7125, -902.902, 14.99121), 0.2, 1.2, { -- -1197.64, -899.433, 14.90698
        name="BurgerShotDuty",
        heading=34,
        debugPoly=false,
        minZ=14.0,
        maxZ=15.1
        }, {
        options = {
            {
                event = "bgShotDuty",
                icon = "fas fa-hamburger",
                label = "Toggle Duty",
            },
        },
        job = {"burgershot"},
        distance = 2.0
    })
    
    exports["labrp_Eye"]:AddBoxZone("BSFoodPrep", vector3(-1197.613, -899.3538, 13.90698), 0.7, 1.5, { -- -1201.991, -899.3802, 13.98022
        name="BSFoodPrep",
        heading=34,
        debugPoly=false,
        minZ=13.5,
        maxZ=14.2
        }, {
        options = {
            {
                event = "BSPrepFood",
                icon = "fas fa-hamburger",
                label = "Prep Food",
            },
        },
        job = {"burgershot"},
        distance = 2.0
    })

    local bscups = {
        360098518,
    }

    exports['labrp_Eye']:AddTargetModel(bscups, {
        options = {
            {
                event = 'grabcup',
                icon = 'fas fa-wine-bottle',
                label = "Grab Cup"
            },
        },
        job = {'burgershot'},
        distance = 2.0
    })

    exports["labrp_Eye"]:AddBoxZone("BSFryer", vector3(-1201.596, -898.9846, 13.98022), 2.5, 0.7, { -- -1197.481, -894.3692, 13.98022
    name="BSFryer",
    heading=34,
    debugPoly=false,
    minZ=13.5,
    maxZ=14.2
    }, {
    options = {
        {
            event = "BSFryer",
            icon = "fas fa-temperature-high",
            label = "Use Fryer",
        },
    },
    job = {"burgershot"},
    distance = 2.0
  })

    exports["labrp_Eye"]:AddBoxZone("BSFoodShelf", vector3(-1197.5905, -894.4615, 13.98022), 4.5, 0.9, { -- -1202.848, -897.244, 14.90698
    name="BSFoodShelf",
    heading=34,
    debugPoly=false,
    minZ=13.0,
    maxZ=14.7
    }, {
    options = {
        {
            event = "BSFoodShelf",
            icon = "fas fa-hamburger",
            label = "Open Food Shelf",
        },
    },
    job = {"burgershot"},
    distance = 2.0
  })

  exports["labrp_Eye"]:AddBoxZone("BSBurger", vector3(-1202.769, -897.244, 14.90698), 2.0, 0.7, { -- -1202.848, -897.244, 14.90698
  name="BSBurger",
  heading=34,
  debugPoly=false,
  minZ=13.0,
  maxZ=14.2
  }, {
  options = {
      {
          event = "BSBurger",
          icon = "fas fa-hamburger",
          label = "Make Burger",
      },
  },
  job = {"burgershot"},
  distance = 2.0
})



  exports["labrp_Eye"]:AddBoxZone("BSDrinkMachine", vector3(-1199.3595, -895.42965, 15.80005), 2.25, 0.3, { -- -1202.848, -897.244, 14.90698
  name="BSDrinkMachine",
  heading=34,
  debugPoly=false,
  minZ=13.9,
  maxZ=14.78
  }, {
  options = {
        {
            event = "BSDrinkMachine",
            icon = "fas fa-cash-register",
            label = "Use Drink Machine",
        },
    },
    job = {"burgershot"},
    distance = 2.0
  })
  


end)
---1199.921, -895.8329, 15.80005 --- -1198.958, -895.2264, 13.98022
RegisterNetEvent('bgShotDuty')
AddEventHandler('bgShotDuty', function()
    TriggerServerEvent('bgduty:onoff')
end)

RegisterNetEvent('BSBurger')
AddEventHandler('BSBurger', function()
	TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Food Prep",
            txt = ""
        },
		{
            id = 2,
            header = "Beef Patty",
            txt = "Meat: 3",
            params = {
                event = "beefburger",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Veggie Patty",
            txt = "Veggie Meat: 4",
            params = {
                event = "fakeburger",
                args = {
                    number = 2,
                    id = 3
                }
            }
        }
    })
end)

RegisterNetEvent('BSPrepFood')
AddEventHandler('BSPrepFood', function()

    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Food Prep",
            txt = ""
        },
		{
            id = 2,
            header = "Heart Stopper",
            txt = "Meat: 3",
            params = {
                event = "heartstopper",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Money Shot",
            txt = "Bun: 2 | Beef Patty: 3 | Lettuce: 3 ",
            params = {
                event = "moneyshot",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Bleeder",
            txt = "Bun: 2 | Beef Patty: 3 | Filling: 2 ",
            params = {
                event = "bleeder",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
        {
            id = 4,
            header = "Torpedo",
            txt = "Bun: 2 | Beef Patty: 4 | Filling: 2 ",
            params = {
                event = "torpedo",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
        {
            id = 4,
            header = "Meat Free",
            txt = "Bun: 2 | Veggie Burger: 3 | Filling: 6 ",
            params = {
                event = "meatfree",
                args = {
                    number = 3,
                    id = 4
                }
            }
        }
    })
end)--BSDrinkMachine

RegisterNetEvent('BSDrinkMachine')
AddEventHandler('BSDrinkMachine', function()
    exports['br-menu']:SetTitle("Drink Machine")
    exports['br-menu']:AddButton("Sprunk" , "Use a Cup" ,'sprunk' ,'' , 'menuone')
    exports['br-menu']:AddButton("ECola" , "Use a Cup" ,'ecola' ,'' , 'menuone')
end)

RegisterNetEvent('BSFryer')
AddEventHandler('BSFryer', function()
    exports['br-menu']:SetTitle("Fryer")
    exports['br-menu']:AddButton("Fries" , "Potatoes: 5" ,'BSFries' ,'' , 'menuone')
end)

RegisterNetEvent('sprunk')
AddEventHandler('sprunk', function()
    TriggerServerEvent('makesprunk')
end)

RegisterNetEvent('BSFries')
AddEventHandler('BSFries', function()
    TriggerServerEvent('makefries')
end)

RegisterNetEvent('ecola')
AddEventHandler('ecola', function()
    TriggerServerEvent('makeecola')
end)

RegisterNetEvent('moneyshot')
AddEventHandler('moneyshot', function()
    TriggerServerEvent('makemoneyshot')
end)

RegisterNetEvent('meatfree')
AddEventHandler('meatfree', function()
    TriggerServerEvent('makemeatfree')
end)

RegisterNetEvent('bleeder')
AddEventHandler('bleeder', function()
    TriggerServerEvent('makebleeder') --maketorpedo
end)

RegisterNetEvent('torpedo')
AddEventHandler('torpedo', function()
    TriggerServerEvent('maketorpedo') --maketorpedo
end)

--makeheart
RegisterNetEvent('heartstopper')
AddEventHandler('heartstopper', function()
    TriggerServerEvent('makeheart') --maketorpedo
end)

RegisterNetEvent('beefburger')
AddEventHandler('beefburger', function()
    TriggerServerEvent('makeburger')
end) --meatfree

RegisterNetEvent('fakeburger')
AddEventHandler('fakeburger', function()
    TriggerServerEvent('veggieburger')
end)
--grabcup

RegisterNetEvent('grabcup')
AddEventHandler('grabcup', function()
    TriggerServerEvent('grabbscup')
end)

local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     {title="Burgershot", colour=59, id=106, x = -1197.204, y = -896.4528, z = 13.98022},
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)



RegisterNetEvent('BSpay')
AddEventHandler('BSpay', function()  
    TriggerServerEvent('payPay')
end)

    --exports['mythic_notify']:SendAlert('inform', 'You were billed $' .. orderamount)
    --exports['mythic_notify']:SendAlert('inform', 'You bought ' .. ordernote)


RegisterNetEvent("staszek-receipts:createReceipt")
AddEventHandler("staszek-receipts:createReceipt", function()
    local bill = exports["nh-keyboard"]:KeyboardInput({
        header = "Create Receipt",
        rows = {
            {
                id = 0,
                txt = "Player ID"
            },
            {
                id = 1,
                txt = "Amount"
            },
        }
    })
    if bill then
        TriggerServerEvent("staszek-receipts:registerReceipt", bill[1].input, bill[2].input)
    end
end)

Citizen.CreateThread(function()
exports['labrp_Eye']:AddBoxZone("BurgerShot_register_1", vector3(-1196.01, -891.34, 14.0), 0.5, 0.4, {
    name="BurgerShot_register_1",
    heading=125,
    minZ=14.0,
    maxZ=14.5,
}, {
    options = {

        {
            event = "staszek-receipts:createReceipt",
            parms = "1",
            icon = "fas fa-credit-card",
            label = "Charge Customer",
        },
     },
     job = {"burgershot"},
    distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("BurgerShot_register_2", vector3(-1194.65, -893.3, 14.0), 0.6, 0.5, {
    name="BurgerShot_register_2",
    heading=302,
    minZ=14.1,
    maxZ=14.5,
}, {
    options = {

        {
            event = "staszek-receipts:createReceipt",
            parms = "2",
            icon = "fas fa-credit-card",
            label = "Charge Customer",
        },
     },
     job = {"burgershot"},
    distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("BurgerShot_register_3", vector3(-1193.39, -895.22, 14.0), 0.6, 0.4, {
    name="BurgerShot_register_3",
    heading=125,
    minZ=14.0,
    maxZ=14.4,
}, {
    options = {

        {
            event = "staszek-receipts:createReceipt",
            parms = "3",
            icon = "fas fa-credit-card",
            label = "Charge Customer",
        },
     },
     job = {"burgershot"},
    distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("BurgerShot_register_4", vector3(-1192.52, -906.65, 14.0), 0.5, 0.5, {
    name="BurgerShot_register_4",
    heading=0,
    --debugPoly=true,
    minZ=13.8,
    maxZ=14.2,
}, {
    options = {
        {
            event = "staszek-receipts:createReceipt",
            parms = "4",
            icon = "fas fa-credit-card",
            label = "Charge Customer",
        },
    },
    job = {"burgershot"},
    distance = 1.5
})
end)--pdweaponlicense


RegisterNetEvent("BSFoodShelf")
AddEventHandler("BSFoodShelf", function()
    exports['linden_inventory']:OpenStash({ id = 'Food Shelf', slots = 70, job= 'burgershot'})
end)
