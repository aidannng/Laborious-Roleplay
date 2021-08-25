ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

local DropOffs = {
    [1] = {id = 1, x = 364.0879, y = -1987.648, z = 23.22485, h = 0.00},
    [2] = {id = 2, x = 252.7121, y = -1670.993, z = 28.65051, h = 150.00},
    [3] = {id = 3, x = -197.5253, y = -1700.004, z = 32.49231, h = 40.00},
    [4] = {id = 4, x = 310.3648, y = -180.6198, z = 56.2843, h = 340.00},
    [5] = {id = 5, x = 515.7626, y = -1080.026, z = 27.7406, h = 270.00},
    [6] = {id = 6, x = -292.4044, y = -600.8176, z = 32.54285, h = 180.00},
    [7] = {id = 7, x = -1201.187, y = -338.4659, z = 37.07544, h = 300.00},
    [8] = {id = 8, x = -1178.4, y = -1180.273, z = 4.622681, h = 280.00},
    [9] = {id = 9, x = -2963.591, y = 432.1846, z = 14.26086, h = 90.00},
    [10] = {id = 10, x = 1148.189, y = -450.9362, z = 65.9729, h = 160.00},
}



local hasStarted = false
local vehicleSpawn = nil
local currentDropOff = false
local DroppedOff = {}
local hasFinished = false
local Cooldown = false

exports['labrp_Eye']:AddBoxZone("VicodinTrade", vector3(975.4813, -2358.013, 30.80737), 0.75, 0.75, {
	name="VicodinTrade",
	heading=220.0,
	debugPoly=false,
	}, {
        options = {
            {
                event = "labrp_vicodin:tradein",
                icon = "fas fa-capsules",
                label = "Trade In Vicodin",
                canInteract = function(entity)
                    return true
                end
            },	
            {
                event = "labrp_vicodin:start",
                icon = "fas fa-capsules",
                label = "Vicodin Run - $1000",
                canInteract = function(entity)
                    hasChecked = false
                    if not hasStarted and not Cooldown and not hasChecked then
                        hasChecked = true
                        return true
                    end
                end
            },
            {
                event = "labrp_vicodin:cancelrun",
                icon = "fas fa-times",
                label = "Cancel Run",
                canInteract = function(entity)
                    hasChecked = false
                    if hasStarted and not hasFinished and not hasChecked then
                        hasChecked = true
                        return true
                    end
                end
            },
            {
                event = "labrp_vicodin:finishrun",
                icon = "fas fa-flag-checkered",
                label = "Finish Run",
                canInteract = function(entity)
                    hasChecked = false
                    if hasStarted and hasFinished and not hasChecked then
                        hasChecked = true
                        return true
                    end
                end
            },	
        },
        job = {"all"},
        distance = 2.5
    })


AddEventHandler('labrp_vicodin:start', function()
    print('Vicodin Run Started')
    car = LabVicodin.Vehicles[math.random(1, #LabVicodin.Vehicles)]
    print('Vicodin Vehicle : '..car.name)
    ESX.TriggerServerCallback('labrp_vicodin:checkmoney', function(hasEnough)
		if hasEnough then
            if not hasStarted then
                exports['mythic_notify']:SendAlert('inform', 'Vicodin Dealer : Yo take this dog ass van and delivery vicodin to my customers around the city, then come back and return the truck', 10000)
                if not HasModelLoaded(car.name) then
                    RequestModel(car.name)
                    while not HasModelLoaded(car.name) do
                        Citizen.Wait(10)
                    end
                end
                vehicleSpawn = CreateVehicle(car.name, 984.5406, -2363.341, 29.49304, 180.0, 1, 1)
                Citizen.Wait(1000)
                local plate = GetVehicleNumberPlateText(vehicleSpawn)
                exports["labrp_vehiclelock"]:givePlayerKeys(plate)
                StartVicodin()
                StartCooldown()
            else
                exports['mythic_notify']:SendAlert('error', 'Please end your run to start another!')
            end
		else
			exports['mythic_notify']:SendAlert('error', 'Not Enough Cash!')
		end
	end)
end)

AddEventHandler('labrp_vicodin:cancelrun', function()
    hasStarted = false
    exports['mythic_notify']:SendAlert('inform', "You've successfully cancelled your run!")
    DeleteEntity(vehicleSpawn)
    RemoveBlip(deliveryBlip)
    DeletePed(ped)
end)

function StartVicodin()
    hasStarted = true
    currentDropOff = true
    print(#DropOffs)
    if #DropOffs == 0 then
        FinishDelivery()
        hasFinished = true
        print('finish deliveries')
    else
        print('start new delivery')
        DropOffLocation = DropOffs[math.random(1, #DropOffs)]
        FirstDelivery()
    end
end

local VicoCustomer = {
    `a_m_m_trampbeac_01`
}

exports['labrp_Eye']:AddTargetModel(VicoCustomer, {
	options = {
		{
			event = "labrp_vicodin:deliver",
			icon = "fas fa-capsules",
			label = "Deliver Package",
            canInteract = function(entity)
                hasChecked = false
                if currentDropOff and not hasChecked then
                    hasChecked = true
                    return true
                end
            end
		},			
	},
	job = {"all"},
	distance = 2.5
})


AddEventHandler('labrp_vicodin:deliver', function()
    animationgive()
    currentDropOff = false
    exports['mythic_notify']:SendAlert('inform', "You've successfully delivered a package, Now wait for a new offer to appear on your GPS!")
    FreezeEntityPosition(ped, false)
    RemoveBlip(deliveryBlip)
    for i = 1, #DropOffs do
        if DropOffs[i] == DropOffLocation then
            table.remove(DropOffs, i)
        end
    end
    exports['mythic_notify']:SendAlert('inform', 'Delivered : '..10-#DropOffs..'/10', 10000)
    Citizen.Wait(4000)
    TriggerServerEvent('labrp_vicodin:payout')
    if #DropOffs == 0 then
        Citizen.Wait(0)
    else
        Citizen.Wait(math.random(15000, 30000))
    end
    DeletePed(ped)
    StartVicodin()
end)

function FirstDelivery()
    exports['mythic_notify']:SendAlert('inform', "New Location Received!")
    deliveryBlip = AddBlipForCoord(DropOffLocation.x, DropOffLocation.y, DropOffLocation.z)

    SetBlipScale(deliveryBlip, 0.8)
    SetBlipColour(deliveryBlip, 5)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipRoute(deliveryBlip, true)
    SetBlipRouteColour(deliveryBlip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Drop Off')
    EndTextCommandSetBlipName(deliveryBlip)

    hash = GetHashKey("a_m_m_trampbeac_01")

    LoadModel(`a_m_m_trampbeac_01`)
    

    ped = CreatePed(4, `a_m_m_trampbeac_01`, DropOffLocation.x, DropOffLocation.y, DropOffLocation.z, 3374176, true, true)
    SetEntityHeading(ped, DropOffLocation.h)
    FreezeEntityPosition(ped, true)
    currentDropOff = true
end

AddEventHandler('labrp_vicodin:finishrun', function()
    hasFinished = false
    hasStarted = false
    currentDropOff = false
    DeleteEntity(vehicleSpawn)
    exports['mythic_notify']:SendAlert('inform', "Come back later and ill give you some more work!")
    table.insert(DropOffs, {id = 1, x = 364.0879, y = -1987.648, z = 23.22485, h = 0.00})
    table.insert(DropOffs, {id = 2, x = 252.7121, y = -1670.993, z = 28.65051, h = 150.00})
    table.insert(DropOffs, {id = 3, x = -197.5253, y = -1700.004, z = 32.49231, h = 40.00})
end)

function FinishDelivery()
    exports['mythic_notify']:SendAlert('inform', "You've finished your deliveries, Return the van and piss off!")
end

function loadAnimDict2(dict)
    while ( not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function animationgive()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict2("mp_safehouselost@") 
    TaskPlayAnim(PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

AddEventHandler('labrp_vicodin:tradein', function()
    animationgive()
    Citizen.Wait(4500)
    TriggerServerEvent('labrp_vicodin:tradein')
end)

function StartCooldown()
    Cooldown = true
    local timer = 15 * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end