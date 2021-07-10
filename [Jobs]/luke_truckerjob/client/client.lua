-- Variable defaulting
local isPedInDutyZone = false
local isOnDuty = false
local workVehicle = nil
local workTrailer = nil
local isGoingBackToDepot = false
local notified = false

-- Polyzones
local depotZone = BoxZone:Create( -- The zone you return your truck to when finished with a delivery
    vector3(Config.PolyZones.DepotZone.x, Config.PolyZones.DepotZone.y, Config.PolyZones.DepotZone.z),
    Config.PolyZones.DepotZone.length, Config.PolyZones.DepotZone.width, {
    name="luke_truckerjob:Depot",
    heading=0,
    --debugPoly=true,
    minZ=Config.PolyZones.DepotZone.minZ,
    maxZ=Config.PolyZones.DepotZone.maxZ
}) 

local dutyZone = BoxZone:Create(
    vector3(Config.PolyZones.LockerZone.x, Config.PolyZones.LockerZone.y, Config.PolyZones.LockerZone.z),
    Config.PolyZones.LockerZone.length, Config.PolyZones.LockerZone.width, {
    name="luke_truckerjob:Duty",
    heading=0,
    --debugPoly=true,
    minZ=Config.PolyZones.LockerZone.minZ,
    maxZ=Config.PolyZones.LockerZone.maxZ
})
local truckZone = BoxZone:Create(
    vector3(Config.PolyZones.JobSelectZone.x, Config.PolyZones.JobSelectZone.y, Config.PolyZones.JobSelectZone.z), 
    Config.PolyZones.JobSelectZone.length, Config.PolyZones.JobSelectZone.width, {
    name="luke_truckerjob:Truck",
    heading=0,
    --debugPoly=true,
    minZ=Config.PolyZones.JobSelectZone.minZ,
    maxZ=Config.PolyZones.JobSelectZone.maxZ
})

local deleteZone = BoxZone:Create(
    vector3(Config.PolyZones.DeleteVehicleZone.x, Config.PolyZones.DeleteVehicleZone.y, Config.PolyZones.DeleteVehicleZone.z), 
    Config.PolyZones.DeleteVehicleZone.length, Config.PolyZones.DeleteVehicleZone.width, {
    name="luke_truckerjob:DeleteVehicle",
    heading=0,
    --debugPoly=true,
    minZ=Config.PolyZones.DeleteVehicleZone.minZ,
    maxZ=Config.PolyZones.DeleteVehicleZone.maxZ
})

PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(PlayerData)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    if job ~= nil then
        if PlayerData == nil then
            PlayerData = ESX.GetPlayerData()
        end
    end

    PlayerData.job = job

    if PlayerData.job.name == 'trucker' then
        hasJob = true
        SetJob(true)
    else
        hasJob = false
        SetJob(false)
        return
    end
end)

-- Job checking thread 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2500)
        if ESX ~= nil then
            PlayerData = ESX.GetPlayerData()
            if PlayerData.job ~= nil and PlayerData.job.name == 'trucker' then
                SetJob(true)
                hasJob = true
                break
            else
                hasJob = false
            end
        end
    end
end)

-- Main thread for getting player and checking points with polyzone
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)

        isPedInDutyZone = dutyZone:isPointInside(playerCoords)

        if isOnDuty then
            isPedInTruckZone = truckZone:isPointInside(playerCoords)
        end

        if workVehicle ~= nil and IsPedInAnyVehicle(playerPed, false) then
            isPedInDeleteZone = deleteZone:isPointInside(playerCoords)
        end

        if isGoingBackToDepot then
            isTrailerInDepot = depotZone:isPointInside(GetEntityCoords(workTrailer))
            if isTrailerInDepot then
                EndDelivery()
            end
        end
    end
end)

-- Input and marker drawing thread
Citizen.CreateThread(function()
    while true do
        if isPedInDutyZone and hasJob then
            wait = 4
            Draw3DText(vector3(Config.PolyZones.LockerZone.x, Config.PolyZones.LockerZone.y, Config.PolyZones.LockerZone.z), "[~g~E~w~] - Locker")
            if IsControlJustReleased(0, 51) then
                DutySelectMenu()
            end
        elseif isPedInTruckZone then
            wait = 4
            Draw3DText(vector3(Config.PolyZones.JobSelectZone.x, Config.PolyZones.JobSelectZone.y, Config.PolyZones.JobSelectZone.z), '[~g~E~w~] - Select a Job')
            if IsControlJustReleased(0, 51) then
                TruckSelectMenu()
            end
        elseif isPedInDeleteZone and IsPedInAnyVehicle(playerPed, false) then
            wait = 4
            Draw3DText(vector3(Config.PolyZones.DeleteVehicleZone.x, Config.PolyZones.DeleteVehicleZone.y, Config.PolyZones.DeleteVehicleZone.z), '[~g~E~w~] - Return Truck')
            if IsControlJustReleased(0, 51) then
                DeleteWorkVehicle()
            end
        else
            wait = 500
        end
        Citizen.Wait(wait)
    end
end)

RegisterNetEvent('luke_truckerjob:StartRoute')
AddEventHandler('luke_truckerjob:StartRoute', function(data)
    ESX.TriggerServerCallback('luke_truckerjob:CheckLevel', function(level, progress, pay)
        if level < data.routeLevel then
            exports['mythic_notify']:SendAlert('error', 'You are not high enough level to do this job...') 
            DeliverySelectMenu()
        else
            if workTrailer == nil then
                for i = 1, #Config.TrailerSpawn do
                    if ESX.Game.IsSpawnPointClear(vector3(Config.TrailerSpawn[i].x, Config.TrailerSpawn[i].y, Config.TrailerSpawn[i].z), 5.0) then
                        local trailer = Config.TrailerModels[math.random(#Config.TrailerModels)]
                        RequestModel(trailer)
                        while not HasModelLoaded(trailer) do
                            Citizen.Wait(10)
                        end
                        workTrailer = CreateVehicle(trailer, Config.TrailerSpawn[i].x, Config.TrailerSpawn[i].y, Config.TrailerSpawn[i].z, Config.TrailerSpawn[i].h, true, false)
                        SetModelAsNoLongerNeeded(trailer)
                        
                        TrailerBlip(GetEntityCoords(workTrailer))
                        StartDelivery(data.id)
                        jobPayment = data.pay

                        break
                    else
                        if i == #Config.TrailerSpawn then
                            exports['mythic_notify']:SendAlert('error', 'There is not space for the truck.')
                        end
                    end
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You already have a trailer out.') 
            end
        end
    end)
end)

RegisterNetEvent('luke_truckerjob:SpawnTruck')
AddEventHandler('luke_truckerjob:SpawnTruck', function(data)
    -- Checking the player's level to make sure he can take out the truck
    ESX.TriggerServerCallback('luke_truckerjob:CheckLevel', function(level, progress)
        if level < data.truckLevel then
            exports['mythic_notify']:SendAlert('error', 'You are not high enough level to drive this...') 
            TruckSelectMenu()
        else
            -- If the player already has a vehicle, don't spawn
            if workVehicle == nil then
                for i = 1, #Config.TruckSpawn do
                    if ESX.Game.IsSpawnPointClear(vector3(Config.TruckSpawn[i].x, Config.TruckSpawn[i].y, Config.TruckSpawn[i].z), 3.0) then
                        RequestModel(data.truck)
                        while not HasModelLoaded(data.truck) do
                            Citizen.Wait(10)
                        end
                        workVehicle = CreateVehicle(data.truck, Config.TruckSpawn[i].x, Config.TruckSpawn[i].y, Config.TruckSpawn[i].z, Config.TruckSpawn[i].h, true, false)
                        SetModelAsNoLongerNeeded(data.truck)

                        DeliverySelectMenu()
                        ReturnBlip()

                        break
                    else
                        if i == #Config.TruckSpawn then
                            exports['mythic_notify']:SendAlert('error', 'There is not space for the truck.') 
                        end
                    end
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You already have a truck out.')
            end
        end
    end)
end)


RegisterNetEvent('luke_truckerjob:EndDeliveryHandle')
AddEventHandler('luke_truckerjob:EndDeliveryHandle', function(type)
    if type == 'newJob' then
        DeliverySelectMenu()
    else
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        LeaveDeleteVehicle(vehicle, workTrailer)
    end
end)

RegisterNetEvent('luke_truckerjob:DutyHandle')
AddEventHandler('luke_truckerjob:DutyHandle', function(duty)
    if duty then
        isOnDuty = true
        JobSelectBlip()
        ESX.TriggerServerCallback('luke_truckerjob:CheckLevel', function(level, progress)
            if Config.MultiplyProgressPerLevel then
                maxProgress = level * Config.MaxProgress
            else
                maxProgress = Config.MaxProgress
            end

            SendNUIMessage({
                type = 'visibility',
                setVisibility = true,
                level = level,
                maxLevel = Config.MaxLevel,
                progress = progress,
                maxProgress = maxProgress
            })

            exports['mythic_notify']:SendAlert('inform', 'Clocked in. You can now pick and start a job!') 
        end)
        if Config.EnableWorkClothes then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.WorkClothes.skin_male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, Config.WorkClothes.skin_female)
                end
            end)
        end
    else
        isOnDuty = false

        RemoveBlip(depotBlip)
        RemoveBlip(deliveryBlip)
        RemoveBlip(jobBlip)
        RemoveBlip(returnBlip)
        RemoveBlip(trailerBlip)

        if Config.EnableWorkClothes then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
        end

        SendNUIMessage({
            type = 'visibility',
            setVisibility = false
        })
    end
end)

RegisterNetEvent('luke_truckerjob:UpdateNUI')
AddEventHandler('luke_truckerjob:UpdateNUI', function(level, progress, maxProgress)
    SendNUIMessage({
        type = 'update',
        level = level,
        progress = progress,
        maxProgress = maxProgress
    })
end)

function SetJob(isJob)
    if isJob then
        LockerBlip()
    else
        workVehicle = nil
        workTrailer = nil
        isOnDuty = false

        RemoveBlip(lockerBlip)
        RemoveBlip(depotBlip)
        RemoveBlip(deliveryBlip)
        RemoveBlip(jobBlip)
        RemoveBlip(returnBlip)
        RemoveBlip(trailerBlip)
    end
end

function StartDelivery(id)
    local isDelivering = false
    local heading = 0

    exports['mythic_notify']:SendAlert('inform', 'Attach your trailer then take it to the marked spot on your minimap to unload it.') 

    if Config.DeliveryPoints[id].zone.markerHeading == 0 then
        heading = 0.0
    else
        heading = Config.DeliveryPoints[id].zone.markerHeading + 90
    end

    local deliveryZone = BoxZone:Create(
        vector3(Config.DeliveryPoints[id].zone.x, Config.DeliveryPoints[id].zone.y, Config.DeliveryPoints[id].zone.z), 
        Config.DeliveryPoints[id].zone.length, Config.DeliveryPoints[id].zone.width, {
        name="luke_truckerjob:Delivery",
        heading = Config.DeliveryPoints[id].zone.heading,
        --debugPoly=true,
        minZ = Config.DeliveryPoints[id].zone.minZ,
        maxZ = Config.DeliveryPoints[id].zone.maxZ
    })

    local deliveryArea = CircleZone:Create(
        vector3(Config.DeliveryPoints[id].zone.x, Config.DeliveryPoints[id].zone.y, Config.DeliveryPoints[id].zone.z),
        50.0, {
        name="luke_truckerjob:DeliveryArea",
        useZ=true,
        --debugPoly=true
      })
      

    DeliveryBlip(Config.DeliveryPoints[id].zone.x, Config.DeliveryPoints[id].zone.y, Config.DeliveryPoints[id].zone.z)

    while isDelivering == false do
        Citizen.Wait(800)
        if IsVehicleAttachedToTrailer(workVehicle) then
            isDelivering = true
            RemoveBlip(trailerBlip)
        end
    end

    notified = false
    while isDelivering == true do
        local wait
        if deliveryArea:isPointInside(GetEntityCoords(workTrailer)) then
            local isInside = deliveryZone:isPointInside(GetEntityCoords(workTrailer))
            wait = 4

            if not notified then
                ESX.ShowHelpNotification("Park the trailer onto the marker with ~INPUT_CONTEXT~")
                notified = true
            end

            if not isInside then
                DrawMarker(30, Config.DeliveryPoints[id].zone.x, Config.DeliveryPoints[id].zone.y, Config.DeliveryPoints[id].zone.z-1.25, 0.0, 0.0, 0.0, 0.0, 0.0, heading, 8.0, 25.0, 1.0, 255, 0, 0, 255, false, false, false, false)
            else
                DrawMarker(30, Config.DeliveryPoints[id].zone.x, Config.DeliveryPoints[id].zone.y, Config.DeliveryPoints[id].zone.z-1.25, 0.0, 0.0, 0.0, 0.0, 0.0, heading, 8.0, 25.0, 1.0, 0, 255, 0, 255, false, false, false, false)
                if IsControlJustReleased(0, 51) then
                    isGoingBackToDepot = true
                    RemoveBlip(deliveryBlip)
                    deliveryZone:destroy()
                    deliveryArea:destroy()
                    isDelivering = false
                    
                    exports['mythic_notify']:SendAlert('inform', 'Trailer unloaded. Take it back to the depot.') 

                    DepotBlip()
                end
            end
        else
            wait = 500
        end
        Citizen.Wait(wait)
    end
end

function EndDelivery()
    DeleteEntity(workTrailer)
    RemoveBlip(depotBlip)
    workTrailer = nil
    isGoingBackToDepot = false

    -- Stops the truck when it enters the zone
    FreezeEntityPosition(workVehicle, true)
    FreezeEntityPosition(workVehicle, false)
    
    TriggerServerEvent('luke_truckerjob:FinishJob', jobPayment)

    TriggerEvent('nh-context:sendMenu', {
        {
            id = 0,
            header = 'Job Completed',
            txt = ''
        },
        {
            id = 1,
            header = 'Get Another Job',
            txt = 'Get a new trailer and start a job',
            params = {
                event = 'luke_truckerjob:EndDeliveryHandle',
                args = 'newJob'
            }
        },
        {
            id = 2,
            header = 'Return Truck',
            txt = 'Return the truck to the depot',
            params = {
                event = 'luke_truckerjob:EndDeliveryHandle',
                args = 'returnTruck'
            }
        }
    })
end

function LeaveDeleteVehicle(vehicle, trailer)
    TaskLeaveVehicle(playerPed, vehicle, 0)
    Wait(3000)
    DeleteEntity(vehicle)
    DeleteEntity(trailer)

    workVehicle = nil
    workTrailer = nil
    RemoveBlip(returnBlip)
end

function DeleteWorkVehicle()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle == workVehicle then
        LeaveDeleteVehicle(vehicle, workTrailer)

        RemoveBlip(trailerBlip)
        RemoveBlip(returnBlip)
    else
        return exports['mythic_notify']:SendAlert('error', 'This is not your work vehicle.') 
    end
end

function DeliverySelectMenu()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 0,
            header = 'Choose a Job:',
            txt = ''
        }
    })
    for k, v in pairs(Config.DeliveryPoints) do
        TriggerEvent('nh-context:sendMenu', {
            {
                id = k,
                header = v.label,
                txt = string.format(v.desc, v.pay, v.level),
                params = {
                    event = 'luke_truckerjob:StartRoute',
                    args = {id = k, routeLevel = v.level, pay = v.pay}
                }
            },
        })
    end
end

function TruckSelectMenu()
    for k, v in pairs(Config.Vehicles) do
        TriggerEvent('nh-context:sendMenu', {
            {
                id = k,
                header = v.label,
                txt = 'Required level: '.. v.level,
                params = {
                    event = 'luke_truckerjob:SpawnTruck',
                    args = {truck = v.spawn, truckLevel = v.level}
                }
            },
        })
    end
end

function DutySelectMenu()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Clock In",
            txt = "Start Truckin'",
            params = {
                event = 'luke_truckerjob:DutyHandle',
                args = true
            }
        },
        {
            id = 2,
            header = "Clock Out",
            txt = "Stop Truckin'",
            params = {
                event = 'luke_truckerjob:DutyHandle',
                args = false
            }
        }
    })
end

function DepotBlip()
    if DoesBlipExist(depotBlip) then
        return
    else
        depotBlip = AddBlipForCoord(Config.PolyZones.DepotZone.x, Config.PolyZones.DepotZone.y, Config.PolyZones.DepotZone.z)

        SetBlipScale(depotBlip, 1.0)
        SetBlipColour(depotBlip, 5)
        SetBlipAsShortRange(depotBlip, false)
        SetBlipRoute(depotBlip, true)
        SetBlipRouteColour(depotBlip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Return to the Depot')
        EndTextCommandSetBlipName(depotBlip)
    end
end

function DeliveryBlip(x, y, z)
    if DoesBlipExist(deliveryBlip) then
        return
    else
        deliveryBlip = AddBlipForCoord(x, y, z)

        SetBlipScale(deliveryBlip, 1.0)
        SetBlipColour(deliveryBlip, 5)
        SetBlipAsShortRange(deliveryBlip, false)
        SetBlipRoute(deliveryBlip, true)
        SetBlipRouteColour(deliveryBlip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Delivery Point')
        EndTextCommandSetBlipName(deliveryBlip)
    end
end

function ReturnBlip()
    if DoesBlipExist(returnBlip) then
        return
    else
        returnBlip = AddBlipForCoord(Config.PolyZones.DeleteVehicleZone.x, Config.PolyZones.DeleteVehicleZone.y, Config.PolyZones.DeleteVehicleZone.z)

        SetBlipScale(returnBlip, 0.8)
        SetBlipSprite(returnBlip, 50)
        SetBlipColour(returnBlip, 5)
        SetBlipAsShortRange(returnBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Return Truck')
        EndTextCommandSetBlipName(returnBlip)
    end
end

function TrailerBlip(coords)
    if DoesBlipExist(trailerBlip) then
        return
    else
        trailerBlip = AddBlipForCoord(coords)

        SetBlipScale(trailerBlip, 0.8)
        SetBlipSprite(trailerBlip, 479)
        SetBlipColour(trailerBlip, 5)
        SetBlipAsShortRange(trailerBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Truck Trailer')
        EndTextCommandSetBlipName(trailerBlip)
    end
end

function JobSelectBlip()
    if DoesBlipExist(jobBlip) then
        return
    else
        jobBlip = AddBlipForCoord(Config.PolyZones.JobSelectZone.x, Config.PolyZones.JobSelectZone.y, Config.PolyZones.JobSelectZone.z)

        SetBlipScale(jobBlip, 0.6)
        SetBlipSprite(jobBlip, 521)
        SetBlipColour(jobBlip, 5)
        SetBlipAsShortRange(jobBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Trucker Job Select')
        EndTextCommandSetBlipName(jobBlip)
    end
end

function LockerBlip()
    if DoesBlipExist(lockerBlip) then
        return
    else
        lockerBlip = AddBlipForCoord(Config.PolyZones.LockerZone.x, Config.PolyZones.LockerZone.y, Config.PolyZones.LockerZone.z)

        SetBlipScale(lockerBlip, 0.8)
        SetBlipSprite(lockerBlip, 477)
        SetBlipColour(lockerBlip, 5)
        SetBlipAsShortRange(lockerBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Trucker Locker')
        EndTextCommandSetBlipName(lockerBlip)
    end
end

function Draw3DText(coords, text)
	SetDrawOrigin(coords)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(0.0, 0.0)
	DrawRect(0.0, 0.0125, 0.015 + text:gsub('~.-~', ''):len() / 370, 0.03, 41, 11, 41, 150)
	ClearDrawOrigin()
end