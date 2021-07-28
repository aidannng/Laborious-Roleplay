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



local bmx = false
local cruiser = false
local fixter = false
local scorcher = false
local tribike = false
local tribike2 = false
local tribike3 = false

RegisterNetEvent('bmx')
AddEventHandler('bmx', function()
    TriggerServerEvent('chargebmx')
end)

RegisterNetEvent('spawnbmx')
AddEventHandler('spawnbmx', function()
    local hash = GetHashKey("bmx")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -243.2044, -990.4879, 29.27991, 200.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)


RegisterNetEvent('cruiser')
AddEventHandler('cruiser', function()
    TriggerServerEvent("chargecruiser")
end)

RegisterNetEvent('spawncruiser')
AddEventHandler('spawncruiser', function()
    local hash = GetHashKey("cruiser")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -243.2044, -990.4879, 29.27991, 200.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)



RegisterNetEvent('tribike')
AddEventHandler('tribike', function()
    TriggerServerEvent("chargetri")
end)

RegisterNetEvent('spawntri')
AddEventHandler('spawntri', function()
    local hash = GetHashKey("tribike")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -243.2044, -990.4879, 29.27991, 200.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)

RegisterNetEvent('tribike2')
AddEventHandler('tribike2', function()
    TriggerServerEvent("chargetri2")
end)

RegisterNetEvent('spawntri2')
AddEventHandler('spawntri2', function()
    local hash = GetHashKey("tribike2")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -243.2044, -990.4879, 29.27991, 200.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)

-- TOW TRUCK RENTAL --

local towtruck = false

RegisterNetEvent('towtruckRent')
AddEventHandler('towtruckRent', function()
    TriggerServerEvent('chargetowtruck')
end)

RegisterNetEvent('spawntowtruck')
AddEventHandler('spawntowtruck', function()
    local hash = GetHashKey("flatbed")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -205.9516, -1168.853, 23.02856, 180.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)


local refundcount = 0 

RegisterNetEvent('deletebike')
AddEventHandler('deletebike', function()
    local xPlayer = ESX.GetPlayerData()
   
    refundcount = refundcount + 1
    local bicis = GetVehiclePedIsIn(PlayerPedId(),true)
    local refundbike = false
    if refundcount <= 1 then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            exports['mythic_notify']:SendAlert('inform', "You have returned your bike")
            refundcount = false
            SetEntityAsMissionEntity(bicis, true, true)
            TaskLeaveVehicle(PlayerPedId(), vbicis, 0)
            Wait(2000)
            DeleteVehicle(bicis) --refundbike
            TriggerServerEvent("refundbike")
        else
            exports['mythic_notify']:SendAlert('error', 'You do not have a bike to return')
        end
    end
    refundcount = 0
end)

RegisterNetEvent('returntowtruck')
AddEventHandler('returntowtruck', function()
    local xPlayer = ESX.GetPlayerData()
   
    
    local bicis = GetVehiclePedIsIn(PlayerPedId(),true) -- GetClosestVehicle(PlayerPedId(),true)
    

    exports['mythic_notify']:SendAlert('inform', "You've have returned your Tow Truck")
    SetEntityAsMissionEntity(bicis, true, true)
    TaskLeaveVehicle(PlayerPedId(), vbicis, 0)
    Wait(2000)
    DeleteVehicle(bicis) --refundbike
    TriggerServerEvent("refundtowtruck")

end)

local impoundcooldown = false


RegisterNetEvent('impoundvehicle')
AddEventHandler('impoundvehicle', function()
    local xPlayer = ESX.GetPlayerData()
   
    
    local impoundVeh = ESX.Game.GetClosestVehicle(coords, modelFilter) -- GetClosestVehicle(PlayerPedId(),true)--ESX.Game.GetClosestVehicle(coords, modelFilter)
    if impoundcooldown == false then
        TriggerEvent("mythic_progbar:client:progress", {
            name = "unique_action_name",
            duration = 10000,
            label = "Impounding Vehicle",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)
            if not status then
            -- Do Something If Event Wasn't Cancelled
            end
        end)
        Citizen.Wait(10000)
        exports['mythic_notify']:SendAlert('inform', "You've have impounded a vehicle")
        SetEntityAsMissionEntity(impoundVeh, true, true)
        TaskLeaveVehicle(PlayerPedId(), vimpoundVeh, 0)
        Wait(2000)
        DeleteVehicle(impoundVeh) --refundbike
        TriggerServerEvent("impoundedVehiclePog")
        TriggerEvent('startimpoundcooldown')
    else
        exports['mythic_notify']:SendAlert('error', "Try Again Later")
    end

end)

RegisterNetEvent('startimpoundcooldown')
AddEventHandler('startimpoundcooldown', function()
    impoundcooldown = true
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            impoundcooldown = false
        end
    end

end)

--    -192.5934, -1161.798, 23.66882

-- Prison Rentals

local bmx5 = false
local cruiser5 = false
local fixter5 = false
local scorcher5 = false
local tribike5 = false
local tribike25 = false
local tribike35 = false

RegisterNetEvent('bmx5')
AddEventHandler('bmx5', function()
    TriggerServerEvent('chargebmx5')
end)

RegisterNetEvent('spawnbmx5')
AddEventHandler('spawnbmx5', function()
    local hash = GetHashKey("bmx")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 1886.927, 2589.508, 45.65784, 200.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)


RegisterNetEvent('cruiser5')
AddEventHandler('cruiser5', function()
    TriggerServerEvent("chargecruiser5")
end)

RegisterNetEvent('spawncruiser5')
AddEventHandler('spawncruiser5', function()
    local hash = GetHashKey("cruiser")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 1886.927, 2589.508, 45.65784, 200.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)



RegisterNetEvent('tribike5')
AddEventHandler('tribike5', function()
    TriggerServerEvent("chargetri5")
end)

RegisterNetEvent('spawntri5')
AddEventHandler('spawntri5', function()
    local hash = GetHashKey("tribike")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 1886.927, 2589.508, 45.65784, 200.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)

RegisterNetEvent('tribike25')
AddEventHandler('tribike25', function()
    TriggerServerEvent("chargetri25")
end)

RegisterNetEvent('spawntri25')
AddEventHandler('spawntri25', function()
    local hash = GetHashKey("tribike2")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 1886.927, 2589.508, 45.65784, 200.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)


local refundcount = 0 

RegisterNetEvent('deletebike2')
AddEventHandler('deletebike2', function()
    local xPlayer = ESX.GetPlayerData()
   
    refundcount = refundcount + 1
    local bicis = GetVehiclePedIsIn(PlayerPedId(),true)
    local refundbike = false
    if refundcount <= 1 then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            exports['mythic_notify']:SendAlert('inform', "You have returned your bike")
            refundcount = false
            SetEntityAsMissionEntity(bicis, true, true)
            TaskLeaveVehicle(PlayerPedId(), vbicis, 0)
            Wait(2000)
            DeleteVehicle(bicis) --refundbike
            TriggerServerEvent("refundbike2")
        else
            exports['mythic_notify']:SendAlert('error', 'You do not have a bike to return')
        end
    end
    refundcount = 0
end)


Citizen.CreateThread(function()
    local shopKeeps = {
		`u_m_m_bikehire_01`
    }

    exports['labrp_Eye']:AddTargetModel(shopKeeps, {
        options = {
            {
                event = 'bikerent:menu',
                icon = 'fas fa-bicycle',
                label = "Open cycles menu"
            },
            {
                event = 'deletebike',
                icon = 'fas fa-exchange-alt',
                label = "Return Bike"
            },
        },
        job = {'all'},
        distance = 2.0
    })
end)

Citizen.CreateThread(function()
    local shopKeeps = {
		`u_m_y_sbike`
    }

    exports['labrp_Eye']:AddTargetModel(shopKeeps, {
        options = {
            {
                event = 'bikerent5:menu',
                icon = 'fas fa-bicycle',
                label = "Open cycles menu"
            },
            {
                event = 'deletebike2',
                icon = 'fas fa-exchange-alt',
                label = "Return Bike"
            },
        },
        job = {'all'},
        distance = 2.0
    })
end)




local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     {title="Bike Rental", colour=47, id=348, x = -251.7407, y = -980.53, z = 30.21502}, -- -251.7407, -980.53, 30.21502
     {title="Prison Bike Rental", colour=47, id=348, x = 1887.996, y = 2592.989, z = 45.65784}, -- 1887.996 2592.989 45.65784
     {title="Tow Yard", colour=62, id=67, x = -209.3407, y = -1174.193, z = 23.02856},---209.3407, -1174.193, 23.02856
     {title="Beach Rentals", colour=47, id=410, x = -1609.292, y = -1121.301, z = 2.471802}, -- -1609.292, -1121.301, 2.471802
     {title="Dirt Rentals", colour=47, id=376, x = 1123.569, y = 2114.611, z = 55.46448}, -- 1123.569, 2114.611, 55.46448
     {title="Go Karting", colour=47, id=38, x = -161.3011, y = -2145.837, z = 16.69299}, -- -161.3011, -2145.837, 16.69299
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 2)
      SetBlipScale(info.blip, 0.75)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)



-- plasma

-- Beach Rentals
local seashark = false
local dinghy = false
local squalo = false
local speeder = false
local dune = false

-- Beach Rentals Spawn

RegisterNetEvent('seashark')
AddEventHandler('seashark', function()
    TriggerServerEvent("chargeseashark")
end)

RegisterNetEvent('spawnseashark')
AddEventHandler('spawnseashark', function()
    local hash = GetHashKey("seashark")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -1636.246, -1148.268, 0.04541016, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Jetski for $500!')
end)




RegisterNetEvent('squalo')
AddEventHandler('squalo', function()
    TriggerServerEvent("chargesqualo")
end)

RegisterNetEvent('spawnsqualo')
AddEventHandler('spawnsqualo', function()
    local hash = GetHashKey("squalo")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -1636.246, -1148.268, 0.04541016, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Squalo for $1,500!')
end)





RegisterNetEvent('speeder')
AddEventHandler('speeder', function()
    TriggerServerEvent("chargespeeder")
end)

RegisterNetEvent('spawnspeeder')
AddEventHandler('spawnspeeder', function()
    local hash = GetHashKey("speeder")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -1636.246, -1148.268, 0.04541016, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Speeder for $2,500!')
end)





RegisterNetEvent('dinghy')
AddEventHandler('dinghy', function()
    TriggerServerEvent("chargedinghy")
end)

RegisterNetEvent('spawndinghy')
AddEventHandler('spawndinghy', function()
    local hash = GetHashKey("dinghy")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -1636.246, -1148.268, 0.04541016, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Dinghy for $1,000!')
end)




RegisterNetEvent('dune')
AddEventHandler('dune', function()
    TriggerServerEvent("chargedune")
end)

RegisterNetEvent('spawndune')
AddEventHandler('spawndune', function()
    local hash = GetHashKey("dune")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -1600.47, -1121.209, 2.522339, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Dune Buggy for $4,500!')
end)

RegisterNetEvent('windsurf')
AddEventHandler('windsurf', function()
    TriggerServerEvent("windsurf")
end)

RegisterNetEvent('spawnwindsurf')
AddEventHandler('spawnwindsurf', function()
    local hash = GetHashKey("windsurfing")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -1600.47, -1121.209, 2.522339, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Windsurf for $1,000!')
end)

-- dirt rentals
RegisterNetEvent('sanchez')
AddEventHandler('sanchez', function()
    TriggerServerEvent("chargesanchez")
end)

RegisterNetEvent('spawnsanchez')
AddEventHandler('spawnsanchez', function()
    local hash = GetHashKey("sanchez")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 1127.011, 2109.917, 56.41394, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Sanchez for $1,000!')
end)


RegisterNetEvent('blazer')
AddEventHandler('blazer', function()
    TriggerServerEvent("chargeblazer")
end)

RegisterNetEvent('spawnblazer')
AddEventHandler('spawnblazer', function()
    local hash = GetHashKey("blazer")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 1127.011, 2109.917, 56.41394, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Blazer for $1,250!')
end)



RegisterNetEvent('blazer4')
AddEventHandler('blazer4', function()
    TriggerServerEvent("chargeblazer4")
end)

RegisterNetEvent('spawnblazer4')
AddEventHandler('spawnblazer4', function()
    local hash = GetHashKey("blazer4")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 1127.011, 2109.917, 56.41394, 90.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have purchased a Street Blazer for $1,750!')
end)

RegisterNetEvent('callforimpound')
AddEventHandler('callforimpound', function()
    --local impoundLocation = GetEntityCoords(PlayerPedId())
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 2500,
        label = "Impounding Vehicle",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
        -- Do Something If Event Wasn't Cancelled
        end
    end)
    Citizen.Wait(2500)
    local impoundVeh = ESX.Game.GetClosestVehicle(coords, modelFilter)
    print(impoundVeh)
    DeleteVehicle(impoundVeh)
end)


RegisterNetEvent('gokart:menu')
AddEventHandler('gokart:menu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Go Karting",
            txt = ""
        },
		{
            id = 2,
            header = "Spawn Go Kart",
            txt = "Free",
            params = {
                event = "spawngokart",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Return Go Kart",
            txt = "",
            params = {
                event = "returngokart",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
    })
end)

-- RegisterNetEvent('spawngokart')
-- AddEventHandler('spawngokart', function()
--     TriggerServerEvent('server:spawngokart')
-- end)

-- RegisterNetEvent('returngokart')
-- AddEventHandler('returngokart', function()
--     TriggerServerEvent('server:returngokart')
-- end)

RegisterNetEvent('spawngokart')
AddEventHandler('spawngokart', function()
    local hash = GetHashKey("veto")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -163.7407, -2133.93, 15.90112, 180.00, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    exports['mythic_notify']:SendAlert('inform', 'You have taken out a Go Kart!')
end)

RegisterNetEvent('returngokart')
AddEventHandler('returngokart', function()
    local xPlayer = ESX.GetPlayerData()
   
    refundcount = refundcount + 1
    local bicis = GetVehiclePedIsIn(PlayerPedId(),true)
    local refundbike = false
    if refundcount <= 1 then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            exports['mythic_notify']:SendAlert('inform', "You have returned your Go Kart")
            refundcount = false
            SetEntityAsMissionEntity(bicis, true, true)
            TaskLeaveVehicle(PlayerPedId(), vbicis, 0)
            Wait(1250)
            DeleteVehicle(bicis) --refundbike
        else
            exports['mythic_notify']:SendAlert('error', 'You do not have a Go Kart to return.')
        end
    end
    refundcount = 0
end)