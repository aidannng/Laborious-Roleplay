Config = {}
ESX = nil
local PlayerData = {}

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
end)


local BikeHire = {}


exports['labrp_Eye']:AddBoxZone("BikeRent", vector3(-204.1055, -1007.644, 28.14502), 0.5, 0.5, {
	name="BikeRent",
	heading=150,
	debugPoly=false,
    }, {
        options = {
            {
                event = 'labrp_bikerent:openmenu',
                icon = 'fas fa-bicycle',
                label = "Open cycles menu",
                canInteract = function(entity)
                    if #BikeHire < 1 then
                        return true
                    end
                end,
            },
            {
                event = 'labrp_bikerent:returnbike',
                icon = 'fas fa-exchange-alt',
                label = "Return Bike",
                canInteract = function(entity)
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        return true
                    end
                end,
            },
        },
    distance = 2.0
})



RegisterNetEvent('labrp_bikerent:openmenu')
AddEventHandler('labrp_bikerent:openmenu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Bike Rental",
            txt = ""
        },
		{
            id = 2,
            header = "BMX",
            txt = "$100",
            params = {
                event = "labrp_bikerent:buybike",
                args = {
                    bike = 'bmx',
                    price = 100
                }
            }
        },
        {
            id = 3,
            header = "TriBike",
            txt = "$150",
            params = {
                event = "labrp_bikerent:buybike",
                args = {
                    bike = 'tribike',
                    price = 150
                }
            }
        },
        {
            id = 4,
            header = "TriBike 2",
            txt = "$200",
            params = {
                event = "labrp_bikerent:buybike",
                args = {
                    bike = 'tribike2',
                    price = 200
                }
            }
        },
    })
end)

RegisterNetEvent('labrp_bikerent:buybike')
AddEventHandler('labrp_bikerent:buybike', function(data)
    bike = data.bike
    price = data.price
    print(price)
    print(bike)
    ESX.TriggerServerCallback('labrp_bikerent:checkmoney', function(data)
        if data then
            local hash = GetHashKey(bike)
        
            if not HasModelLoaded(hash) then
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Citizen.Wait(10)
                end
            end

            local bike = CreateVehicle(hash, -204.3165, -1004.044, 29.14502, 20.00, 1, 1)
            SetPedIntoVehicle(PlayerPedId(), bike, -1)
            local plate = GetVehicleNumberPlateText(bike)
            Citizen.Wait(1000)
            exports["labrp_vehiclelock"]:givePlayerKeys(plate)
            table.insert(BikeHire, plate)
        else
            exports['mythic_notify']:SendAlert('error', 'Not Enough Cash!') 
        end
    end, price)
end)


RegisterNetEvent('labrp_bikerent:returnbike')
AddEventHandler('labrp_bikerent:returnbike', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local vehiclename = GetDisplayNameFromVehicleModel(vehicle)
    if CheckReturn(plate) then
        DeleteVehicle(vehicle)
        RemoveRented(plate)
        TriggerServerEvent('labrp_bikerent:returnfee', price)
    else
        exports['mythic_notify']:SendAlert('error', "You didn't rent this bike!")
    end
end)

function CheckReturn(plate)
    for k, v in ipairs(BikeHire) do
        if v == plate then
            return true
        end
    end
    return false
end

function RemoveRented(plate)
    for i = 1, #BikeHire do
        if BikeHire[i] == plate then
            table.remove(BikeHire, i)
        end
    end
end

local blips = {
    {title="Bike Rental", colour=47, id=348, x = -204.1451, y = -1007.78, z = 29.14502},
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

RegisterNetEvent('spawngokart')
AddEventHandler('spawngokart', function()
    local hash = GetHashKey("veto2")
        
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