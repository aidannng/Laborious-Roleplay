 Config = {}

Config.ESX = true



Citizen.CreateThread(function()

    AddBoxZone("PoliceDuty", vector3(441.79, -982.07, 30.69), 0.4, 0.6, {
	name="PoliceDuty",
	heading=91,
	debugPoly=false,
	minZ=30.79,
	maxZ=30.99
    }, {
        options = {
            {
                event = "pdsign", --
                icon = "fas fa-sign-in-alt",
                label = "Sign On/Off",
            },

        },
        job = {"all"},
        distance = 1.5
    }) ---192.5934, -1161.798, 23.66882

    AddBoxZone("TowDuty", vector3(-192.4934, -1161.898, 23.56882), 0.3, 0.5, {
    name="TowDuty",
    heading=90,
    debugPoly=true,
    minZ=23.5,
    maxZ=23.6
    }, {
        options = {
            {
                event = "towsign", --
                icon = "fas fa-sign-in-alt",
                label = "Duty Toggle",
            },
        },
        job = {"all"},
        distance = 1.5
    }) ---192.5934, -1161.798, 23.66882

    AddBoxZone("EMSDuty", vector3(310.23, -597.56, 43.29), 0.25, 0.4, {
        name="EMSDuty",
        heading=60,
        debugPoly=false,
        minZ=43.26,
        maxZ=43.31
        }, {
            options = {
                {
                    event = "emssign",
                    icon = "fas fa-business-time",
                    label = "EMS Duty",
                },
            },
            job = {"all"},
            distance = 1.49
        })
    

    local weaponstore = {
        -890640939,
        }
        AddTargetModel(weaponstore, {
        options = {
        {
            event = "OpenShop",
            icon = "fas fa-id-card-alt",
            label = "Ammunation",
        },
        },
        job = {"all"},
        distance = 2.5
    }) 

    local burgershot = {
        510552540,
        }
        AddTargetModel(burgershot, {
        options = {
        {
            event = "bgtray1",
            icon = "fas fa-truck-moving",
            label = "Open Tray",
        },
        },
        job = {"all"},
        distance = 2.5
    })


    local jobcenter = {
        776079908,
        }
        AddTargetModel(jobcenter, {
        options = {
        {
            event = "JobCenter",
            icon = "fas fa-briefcase",
            label = "Job Center",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local atm = {
        -870868698,
        -1126237515,
        506770882,
        -1364697528
        }
        AddTargetModel(atm, {
        options = {
        {
            event = "atm",
            icon = "fas fa-money-check-alt",
            label = "ATM",
        },
        },
        job = {"all"},
        distance = 2.5
    }) 

    local bike = {
    	1131912276,
        -2007026063,
        1058115860,
        }   
        AddTargetModel(bike, {
        options = {
        {
            event = "pickup:bike",
            icon = "fas fa-bicycle",
            label = "Pickup Bike",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local pawnshop = {
    	`cs_josef`,
        }   
        AddTargetModel(pawnshop, {
        options = {
        {
            event = "pawnshop",
            icon = "fas fa-briefcase",
            label = "Pawnshop",
        },
        },
        job = {"all"},
        distance = 2.5
    })


    local car = {
        `cs_bankman`,
        }   
        AddTargetModel(car, {
        options = {
        {
            event = "dealership",
            icon = "fas fa-car",
            label = "View Catalog",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local edealer = {
    	`u_m_m_promourn_01`,
        }   
        AddTargetModel(edealer, {
        options = {
        {
            event = "dealersell",
            icon = "fas fa-hand-holding-usd",
            label = "Sell",
        },
        {
            event = "dealerbuy",
            icon = "fas fa-shopping-cart",
            label = "Buy",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local garage = {
    	`csb_trafficwarden`,
        -44746786,
        }   
        AddTargetModel(garage, {
        options = {
        {
            event = "open-garage",
            icon = "fas fa-warehouse",
            label = "Access Garage",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local trolley = {
        269934519
        }   
        AddTargetModel(trolley, {
        options = {
        {
            event = "lootcart",
            icon = "fas fa-money-bill",
            label = "Grab Cash",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local impoundRent = {
    	`ig_benny`,
        }   
        AddTargetModel(impoundRent, {
        options = {
        {
            event = "tow:menu",
            icon = "fas fa-truck-pickup",
            label = "Rent A Tow Truck",
        },
        },
        job = {"all"},
        distance = 2.5
    })

--refundtowtruck
    local policedealership = {
        `s_m_y_cop_01`,
        }   
        AddTargetModel(policedealership, {
        options = {
        {
            event = "PoliceDealership",
            icon = "fas fa-car", 
            label = "Police Dealership",
        },
        },
        job = {"police"},
        distance = 2.5
    })

    local lsc_mech = {
        `mp_m_waremech_01`,
    }
    AddTargetModel(lsc_mech, {
        options = {
        {
            event = "lsc_twotruck",
            icon = "fas fa-wrench",
            label = "Get Tow Truck",
        },
        {
            event = "return_lsc",
            icon = "fas fa-wrench",
            label = "Return Tow Truck",
        },
        },
        job = {"all"},
        distance = 4.5
    })

    local lsc_mech = {
        `s_m_y_dwservice_02`,
    }
    AddTargetModel(lsc_mech, {
        options = {
        {
            event = "mechanic:respray",
            icon = "fas fa-spray-can",
            label = "Respray",
        },
        },
        job = {"mechanic"},
        distance = 5
    })
    local beachrental = {
        `a_f_y_beach_01`,
        }   
        AddTargetModel(beachrental, {
        options = {
        {
            event = "beachrental:menu",
            icon = "fas fa-anchor", 
            label = "Beach Rental's",
        },
        },
        job = {"all"},
        distance = 2.5
    })
    local beachreturn = {
        `a_m_y_beach_03`,
        }   
        AddTargetModel(beachreturn, {
        options = {
        {
            event = "beachreturn:menu",
            icon = "fas fa-anchor", 
            label = "Beach Returns",
        },
        },
        job = {"all"},
        distance = 2.5
    })
    local dirtrental = {
        `a_m_y_dhill_01`,
        }   
        AddTargetModel(dirtrental, {
        options = {
        {
            event = "dirtrental:menu",
            icon = "fas fa-flag-checkered", 
            label = "Dirt Rentals",
        },
        },
        job = {"all"},
        distance = 2.5
    })
    local drugsales = {
        `g_m_y_mexgoon_01`,
        }   
        AddTargetModel(drugsales, {
        options = {
        {
            event = "drugsales:menu",
            icon = "fas fa-cannabis", 
            label = "Drug Sales",
        },
        },
        job = {"all"},
        distance = 2.5
    })
    local drugsales = {
        `g_m_y_mexgoon_01`,
    }
    AddTargetModel(drugsales, {
        options = {
        {
            event = "drugsales:menu",
            icon = "fas fa-cannabis",
            label = "Drug Sales",
        },
        {
            event = "drugunpack:menu",
            icon = "fas fa-cannabis",
            label = "Unpack Drugs",
        },
        },
        job = {"all"},
        distance = 4.5
    })
    local blackmarket = {
        `g_m_m_chicold_01`,
        }   
        AddTargetModel(blackmarket, {
        options = {
        {
            event = "blackmarket:menu",
            icon = "fas fa-suitcase", 
            label = "Blackmarket",
        },
        },
        job = {"all"},
        distance = 2.5
    })--mp_f_freemode_01


    local pdheli = {
        `s_m_y_pilot_01`,
        }   
        AddTargetModel(pdheli, {
        options = {
        {
            event = "pd:heli",
            icon = "fas fa-helicopter", 
            label = "Helicopter Garage",
        },
        },
        job = {"police"},
        distance = 2.5
    })

end)-- s_m_y_pilot_01

RegisterNetEvent('dealership')
AddEventHandler('dealership', function()  
    TriggerEvent('dealership:open')
end)

RegisterNetEvent('dealership')
AddEventHandler('dealership', function()  
    TriggerEvent('dealership:open')
end)

local lsctruckcount = 0
RegisterNetEvent('lsc_twotruck')
AddEventHandler('lsc_twotruck', function()  
    TriggerServerEvent('checklsckeys')
    lsctruckcount = 1
end)


--            exports['cn-taskbar']:taskbar(1500, 'Starting Hack...')

RegisterNetEvent('PoliceDealership')--pd:heli
AddEventHandler('PoliceDealership', function()
    exports['br-menu']:SetTitle("Police Dealership")
    exports['br-menu']:AddButton("Crown Victoria" , "$20,000" ,'buycvpi' ,'' , 'menuone')
    exports['br-menu']:AddButton("Ford Taurus" , "$45,000" ,'buyfpis' ,'' , 'menuone')
    exports['br-menu']:AddButton("2014 Tahoe" , "$55,500 (Off-Road)" ,'buytahoe' ,'' , 'menuone')
    exports['br-menu']:AddButton("Dodge RAM" , "$30,000 (Off-Road)" ,'buyram' ,'' , 'menuone')
    exports['br-menu']:AddButton("BMW Motorcycle" , "$65,000 (Motor)" ,'buybmw' ,'' , 'menuone')
    exports['br-menu']:AddButton("2018 Charger" , "$80,000" ,'buycharg' ,'' , 'menuone')
end)

RegisterNetEvent('pd:heli')--pd:heli
AddEventHandler('pd:heli', function()
    exports['br-menu']:SetTitle("MRPD Helipad")
    exports['br-menu']:AddButton("Police Helicopter" , "$5,000" ,'buyheli' ,'' , 'menuone')
end)

RegisterNetEvent('buycvpi')
AddEventHandler('buycvpi', function()  
    TriggerServerEvent('cvpimoney')
end)

RegisterNetEvent('buyheli')
AddEventHandler('buyheli', function()  
    TriggerServerEvent('helimoney')
end)

RegisterNetEvent('buyram')
AddEventHandler('buyram', function()  
    TriggerServerEvent('rammoney')
end)

RegisterNetEvent('buyfpis')
AddEventHandler('buyfpis', function()  
    TriggerServerEvent('fpismoney')
end)

RegisterNetEvent('buytahoe')
AddEventHandler('buytahoe', function()  
    TriggerServerEvent('tahoemoney')
end)

RegisterNetEvent('buybmw')
AddEventHandler('buybmw', function()  
    TriggerServerEvent('bmwmoney')
end)

RegisterNetEvent('buycharg')
AddEventHandler('buycharg', function()  
    TriggerServerEvent('chargmoney')
end)

local spawn = false
local playerPed = PlayerPedId()

RegisterNetEvent('cvpispawn')
AddEventHandler('cvpispawn', function()
    local hash = GetHashKey("code3cvpi")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('ramspawn')
AddEventHandler('ramspawn', function()
    local hash = GetHashKey("code3ram")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('fpisspawn')
AddEventHandler('fpisspawn', function()
    local hash = GetHashKey("code3fpis")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('tahoespawn')
AddEventHandler('tahoespawn', function()
    local hash = GetHashKey("code314tahoe")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('bmwspawn')
AddEventHandler('bmwspawn', function()
    local hash = GetHashKey("code3bmw")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('chargspawn')
AddEventHandler('chargspawn', function()
    local hash = GetHashKey("code318charg")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('helispawn')--helispawn
AddEventHandler('helispawn', function()
    local hash = GetHashKey("eheli")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 449.3143, -981.1252, 43.6864, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)


-- LSC CUSTOMS TOW TRUCK RENTAL --


RegisterNetEvent('spawnlsctruck')
AddEventHandler('spawnlsctruck', function()
    local hash = GetHashKey("20ramrbc")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -365.8681, -85.41099, 39.0022, 250.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)

RegisterNetEvent('return_lsc')
AddEventHandler('return_lsc', function()
    local towhash = GetHashKey("20ramrbc")
    if not HasModelLoaded(towhash) then
        RequestModel(towhash)
        while not HasModelLoaded(towhash) do
            Citizen.Wait(10)
        end
    end
    local current = GetVehiclePedIsIn(PlayerPedId(), false)
    local hash = GetHashKey(current)
    if hash == 1328214065 then
        print('poggers')
    else
        print(current)
    end

    --    TriggerServerEvent('returnLSCKeys')
end)

RegisterNetEvent('open_paint_menu')
AddEventHandler('open_paint_menu', function()
    local closecar = ESX.Game.GetClosestVehicle(coords, modelFilter)
    
end)

RegisterNetEvent('pdsign')
AddEventHandler('pdsign', function()
    TriggerServerEvent('pdduty:onoff')
end)

RegisterNetEvent('emssign')
AddEventHandler('emssign', function()
    TriggerServerEvent('emsduty:onoff')
end)--tow:duty

RegisterNetEvent('towsign')
AddEventHandler('towsign', function()
    TriggerServerEvent('towduty:onoff')
end)

RegisterNetEvent('sellweedjoint')
AddEventHandler('sellweedjoint', function()
    TriggerServerEvent('sellweedjoint')
end)

RegisterNetEvent('sellcokebaggy')
AddEventHandler('sellcokebaggy', function()
    TriggerServerEvent('sellcokebaggy')
end)
