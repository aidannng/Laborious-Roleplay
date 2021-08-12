----- VARIABLE DEFAULTING -----
local isJobGarbage = false
local isPedNearLocker = false
local isPedNearReturn = false
local isPedNearVehicleSpawn = false
local isInRange = false
local inMenu = false
local isPedOnDuty = false
local hasWorkVehicle = false
local jobVehicle = nil
local inJobVehicle = false
local trashFound = false
local isExcluded = false
local hasBagInHand = false
local isNearVehicle = false
local hasRan = false
local totalCollected = 0
local levelCollected = 0
local level = 1
excludedCoord = { {x = Config.Vehicle.x, y = Config.Vehicle.y, z = Config.Vehicle.z} }
----- ------------------- -----

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

    if PlayerData.job.name == 'garbage' then
        isJobGarbage = true
        GarbageLocker()
    else
        isPedNearLocker = false
        isJobGarbage = false
        isPedOnDuty = false
        hasWorkVehicle = false
        jobVehicle = nil
        RemoveBlip(LockerBlip)
        RemoveBlip(VehiclesReturnBlip)
        OffDutyValues()
        SendNUIMessage({
            type = 'changeJob',
        })
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        if ESX ~= nil then
            PlayerData = ESX.GetPlayerData()
            if PlayerData.job ~= nil and PlayerData.job.name == 'garbage' then
                GarbageLocker()
                isJobGarbage = true
                break
            else
                isPedOnDuty = false
                isPedNearLocker = false
                isJobGarbage = false
            end
        end
    end
end)

-- Thread for distance checking
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        lockerText = 'Garbage Locker'
        vehicleText = 'Vehicles'
        returnText = 'Return Vehicle'
        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.Locker.x, Config.Locker.y, Config.Locker.z) < Config.DrawDistance then
            isPedNearLocker = true
            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.Locker.x, Config.Locker.y, Config.Locker.z) < 1.5 then
                isInRange = true
            else
                isInRange = false
            end
        else
            isPedNearLocker = false
        end
        if isPedOnDuty and not hasWorkVehicle and GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.Vehicle.x, Config.Vehicle.y, Config.Vehicle.z) < Config.DrawDistance then
            isPedNearVehicleSpawn = true
            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.Vehicle.x, Config.Vehicle.y, Config.Vehicle.z) < 1.5 then
                isInRange = true
            else
                isInRange = false
            end
        else
            isPedNearVehicleSpawn = false
        end
        if isPedOnDuty and hasWorkVehicle and GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.Return.x, Config.Return.y, Config.Return.z) < Config.DrawDistance then
            isPedNearReturn = true
            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.Return.x, Config.Return.y, Config.Return.z) < 3.0 then
                isInRange = true
            else
                isInRange =  false
            end
        else
            isPedNearReturn = false
        end
    end
end)

-- Thread for text and marker drawing
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        -- Drawing marker and text for the locker
        if isJobGarbage and isPedNearLocker and not inMenu then
            DrawMarker(2, Config.Locker.x, Config.Locker.y, Config.Locker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 150, 30, 30, 222, false, false, false, true, false, false, false)
            if isInRange then
                lockerText = '[~g~E~w~] - ' .. 'Garbage Locker'
            end
            Draw3DText(Config.Locker.x, Config.Locker.y, Config.Locker.z, lockerText, 0.4)
            if IsControlJustReleased(0, 51) and isInRange then
                inMenu = true
                SetNuiFocus(true, true)
                SendNUIMessage({
                    type = 'locker',
                })
            end
        end
        -- Drawing marker and text for the vehicles
        if isPedOnDuty and isPedNearVehicleSpawn and not inMenu then
            DrawMarker(2, Config.Vehicle.x, Config.Vehicle.y, Config.Vehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 150, 30, 30, 222, false, false, false, true, false, false, false)
            if isInRange then
                vehicleText = '[~g~E~w~] - ' .. 'Vehicles'
            end
            Draw3DText(Config.Vehicle.x, Config.Vehicle.y, Config.Vehicle.z, vehicleText, 0.4)
            if IsControlJustReleased(0, 51) and isInRange then
                inMenu = true
                SetNuiFocus(true, true)
                SendNUIMessage({
                    type = 'vehicle',
                })
            end
        end
        -- Drawing marker and text to return vehicle
        if isPedOnDuty and isPedNearReturn and hasWorkVehicle then
            DrawMarker(2, Config.Return.x, Config.Return.y, Config.Return.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 150, 30, 30, 222, false, false, false, true, false, false, false)
            if isInRange then
                returnText = '[~g~E~w~] - ' .. 'Return Vehicle'
            end
            Draw3DText(Config.Return.x, Config.Return.y, Config.Return.z, returnText, 0.4)
            if IsControlJustReleased(0, 51) and isInRange then
                TaskLeaveVehicle(playerPed, jobVehicle, 0)
                Citizen.Wait(1800)
                ESX.Game.DeleteVehicle(jobVehicle)
                GarbageVehicles()
                hasWorkVehicle = false
                jobVehicle = nil
                RemoveBlip(VehiclesReturnBlip)
            end
        end
    end
end)

-- Main thread, finding objects and excluding
Citizen.CreateThread(function()
    local trashCan = Config.Pickups.Cans.Models
    local dumpster = Config.Pickups.Dumpsters.Models
    local trashCanDumpster = Config.Pickups.CansAndDumpsters.Models
    while true do
        Citizen.Wait(1500)
        if hasWorkVehicle and isPedOnDuty then
            pedVehicle = GetVehiclePedIsIn(playerPed, false)
            if pedVehicle == jobVehicle then
                inJobVehicle = true
                if inJobVehicle == true and trashFound == false then
                    -- This can probably be written a lot better, I'm just dumb.
                    if level == 1 then
                        for k, v in pairs(trashCan) do
                            local modelHash = GetHashKey(v)
                            trash = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, Config.ScanDistance, modelHash, false, false, false)
                            if trash ~= 0 then
                                trashCoords = GetEntityCoords(trash)
                                isExcluded = false
                                for i = 1, #excludedCoord do
                                    if GetDistanceBetweenCoords(excludedCoord[i].x, excludedCoord[i].y, excludedCoord[i].z, trashCoords.x, trashCoords.y, trashCoords.z) < Config.ExclusionDistance then
                                        isExcluded = true
                                    end
                                end
        
                                -- When there are more than 30 excluded coords, empty the table
                                if #excludedCoord > 30 then
                                    excludedCoord = {}
                                end
        
                                if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, trashCoords.x, trashCoords.y, trashCoords.z) < Config.ScanDistance and not isExcluded then
                                    table.insert(excludedCoord, trashCoords)
                                    trashFound = true
                                    AddBlip(trashCoords)
                                else
                                    trashFound = false
                                end
                                break
                            end
                        end
                    elseif level == 2 then
                        for k, v in pairs(dumpster) do
                            local modelHash = GetHashKey(v)
                            trash = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, Config.ScanDistance, modelHash, false, false, false)
                            if trash ~= 0 then
                                trashCoords = GetEntityCoords(trash)
                                isExcluded = false
                                for i = 1, #excludedCoord do
                                    if GetDistanceBetweenCoords(excludedCoord[i].x, excludedCoord[i].y, excludedCoord[i].z, trashCoords.x, trashCoords.y, trashCoords.z) < Config.ExclusionDistance then
                                        isExcluded = true
                                    end
                                end
        
                                -- When there are more than 30 excluded coords, empty the table
                                if #excludedCoord > 30 then
                                    excludedCoord = {}
                                end
        
                                if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, trashCoords.x, trashCoords.y, trashCoords.z) < Config.ScanDistance and not isExcluded then
                                    table.insert(excludedCoord, trashCoords)
                                    trashFound = true
                                    AddBlip(trashCoords)
                                else
                                    trashFound = false
                                end
                                break
                            end
                        end
                    elseif level == 3 then
                        for k, v in pairs(trashCanDumpster) do
                            local modelHash = GetHashKey(v)
                            trash = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, Config.ScanDistance, modelHash, false, false, false)
                            if trash ~= 0 then
                                trashCoords = GetEntityCoords(trash)
                                isExcluded = false
                                for i = 1, #excludedCoord do
                                    if GetDistanceBetweenCoords(excludedCoord[i].x, excludedCoord[i].y, excludedCoord[i].z, trashCoords.x, trashCoords.y, trashCoords.z) < Config.ExclusionDistance then
                                        isExcluded = true
                                    end
                                end
        
                                -- When there are more than 30 excluded coords, empty the table
                                if #excludedCoord > 30 then
                                    excludedCoord = {}
                                end
        
                                if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, trashCoords.x, trashCoords.y, trashCoords.z) < Config.ScanDistance and not isExcluded then
                                    table.insert(excludedCoord, trashCoords)
                                    trashFound = true
                                    AddBlip(trashCoords)
                                else
                                    trashFound = false
                                end
                                break
                            end
                        end
                    end
                end
            else
                inJobVehicle = false
            end
        end
    end
end)


-- Picking up garbage thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if trashFound then
            local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, trashCoords.x, trashCoords.y, trashCoords.z)
            if distance < 1.5 then
                isInRange = true
                ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to collect the ~g~garbage")
            else
                isInRange = false
            end

            while true and isInRange == true do
                Citizen.Wait(0)
                if IsControlJustReleased(0, 51) and not IsPedInAnyVehicle(playerPed, false) then
                    RequestAnimDict("anim@heists@narcotics@trash")

                    while (not HasAnimDictLoaded("anim@heists@narcotics@trash")) do
                        Citizen.Wait(0)
                    end

                    TaskPlayAnim(playerPed, "anim@heists@narcotics@trash", "pickup_45_r", 1.0, -1.0, -1, 0, 1, 1, 1, 1)

                    CollectTrash()
                    Citizen.Wait(500)
                    break
                end
            end
        end
    end
end)

-- Vehicle spawning
RegisterNUICallback('luke_garbagejob:SpawnJobVehicle', function(data)
    if data == 'vehicle1' then
        ESX.Game.SpawnVehicle('trash', vector3(Config.Vehicle.x, Config.Vehicle.y, Config.Vehicle.z), Config.Vehicle.h, function(vehicle)
            jobVehicle = vehicle
            hasWorkVehicle = true
            jobVehiclePlate = GetVehicleNumberPlateText(jobVehicle)
            TaskWarpPedIntoVehicle(playerPed, jobVehicle, -1) -- Teleports the ped into driver seat on spawn
            Citizen.Wait(500)
            exports["labrp_vehiclelock"]:givePlayerKeys(jobVehiclePlate)
        end)
    elseif data == 'vehicle2' then
        ESX.Game.SpawnVehicle('trash2', vector3(Config.Vehicle.x, Config.Vehicle.y, Config.Vehicle.z), Config.Vehicle.h, function(vehicle)
            jobVehicle = vehicle
            hasWorkVehicle = true
            jobVehiclePlate = GetVehicleNumberPlateText(jobVehicle)
            TaskWarpPedIntoVehicle(playerPed, jobVehicle, -1) -- Teleports the ped into driver seat on spawn
            Citizen.Wait(500)
            exports["labrp_vehiclelock"]:givePlayerKeys(jobVehiclePlate)
        end)
    end
    RemoveBlip(VehiclesBlip)
    GarbageReturnVehicles()
end)

RegisterNUICallback('luke_garbagejob:SetOnDuty', function()
    isPedOnDuty = true
    TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You have started your job. Drive around the city and wait for markers to appear on your map so you can collect garbage!', length = 10000})
    GarbageVehicles()
    SetWorkClothes()
    SendNUIMessage({
        type = 'setDefault',
        maxLevelTwo = Config.LevelTwo,
    })
end)

RegisterNUICallback('luke_garbagejob:SetOffDuty', function()
    isPedOnDuty = false
    OffDutyValues()
end)

RegisterNUICallback('luke_garbagejob:CloseMenu', function()
    inMenu = false
    SetNuiFocus(false, false)
end)

function OffDutyValues()
    RemoveBlip(VehiclesBlip)
    RemoveWorkClothes()
    totalCollected = 0
    levelCollected = 0
    level = 1
    SendNUIMessage({
        type = 'updateCollected',
        value = totalCollected,
        value2 = levelCollected,
        maxValue = Config.LevelTwo
    })
    SendNUIMessage({
        type = 'updateLevel',
        level = 1,
        max = Config.LevelTwo
    })
end

-- Function for collecting trash
function CollectTrash()
    TrashBag()
    ESX.ShowHelpNotification("When near the back of your vehicle, press ~INPUT_CONTEXT~ to deposit the ~g~garbage.", false, true, 2500)

    while hasBagInHand == true do
        Citizen.Wait(300)
        
        local veh = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 8.0, 0, 70)
        local vehPlate = GetVehicleNumberPlateText(veh)
        local vehDimensions = GetModelDimensions(GetEntityModel(veh))*1.2
        local vehBack = GetEntityCoords(veh) + (GetEntityForwardVector(veh) * vehDimensions.y)

        if vehPlate == jobVehiclePlate then
            isNearVehicle = true
        else
            isNearVehicle = false
        end

        while isNearVehicle == true do
            Citizen.Wait(0)
            SetVehicleDoorOpen(veh, 5, false, false)
            isVehDoorOpen = true

            -- If the vehicle door is open and the condition hasn't ran yet
            if isVehDoorOpen == true and not hasRan then
                PlaySoundFrontend(-1, "GARAGE_DOOR_SCRIPTED_OPEN", 0, 1);
                hasRan = true
            end

            if IsPedInAnyVehicle(playerPed) then
                DeleteObject(bagModel)
                SetVehicleDoorLatched(veh, 5, false, false)
                hasBagInHand = false
                ClearPedTasks(playerPed)
                isVehDoorOpen = false

                break
            end

            if IsControlJustReleased(0, 51) and isNearVehicle and not IsPedInAnyVehicle(playerPed, false) and GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, vehBack.x, vehBack.y, vehBack.z) < 2 then
                DeleteObject(bagModel)
                SetVehicleDoorShut(veh, 5, false)
                PlaySoundFrontend(-1, "GARAGE_DOOR_SCRIPTED_CLOSE", 0, 1);
                hasBagInHand = false
                ClearPedTasks(playerPed)
                isVehDoorOpen = false
                isNearVehicle = false
                hasDelivered = true
                hasRan = false

                totalCollected = totalCollected + 1
                levelCollected = levelCollected + 1

                -- Payment event
                TriggerServerEvent('luke_garbagejob:Payment', level)

                if levelCollected == Config.LevelTwo and level ~= 2 and level ~= 3  then
                    level = 2
                    levelCollected = 0
                    SendNUIMessage({
                        type = 'updateLevel',
                        level = 2,
                        max = Config.LevelThree
                    })
                end

                if levelCollected == Config.LevelThree and level ~= 3 then
                    level = 3
                    levelCollected = 0
                    SendNUIMessage({
                        type = 'updateLevel',
                        level = 3,
                        max = 'Max'
                    })
                end

                if level == 3 then
                    SendNUIMessage({
                        type = 'updateCollected',
                        value = totalCollected,
                        value2 = 'Max'
                    })
                elseif level == 2 then
                    SendNUIMessage({
                        type = 'updateCollected',
                        value = totalCollected,
                        value2 = levelCollected,
                        maxValue = Config.LevelThree
                    })
                else
                    SendNUIMessage({
                        type = 'updateCollected',
                        value = totalCollected,
                        value2 = levelCollected,
                        maxValue = Config.LevelTwo
                    })
                end

                ResetPedMovementClipset(playerPed, 0.0)
                break
            end
        end

        if hasDelivered then
            -- Payment functions
        end
    end

    trashFound = false
    RemoveBlip(blip)
end

-- Attaches a trash bag to the ped
function TrashBag()
    hasBagInHand = true

    local bagHash = GetHashKey('hei_prop_heist_binbag')

    RequestModel(bagHash)
    local bone = GetPedBoneIndex(playerPed, 28422)

    while not HasModelLoaded(bagHash) do
        Citizen.Wait(0)
    end

    bagModel = CreateObject(bagHash, playerCoords.x, playerCoords.y, playerCoords.z, 1, 1, 0)

    AttachEntityToEntity(bagModel, playerPed, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 0)

    RequestAnimSet('clipset@move@trash_fast_turn')
    while not HasAnimSetLoaded('clipset@move@trash_fast_turn') do
        Citizen.Wait(0)
    end
    SetPedMovementClipset(playerPed, "clipset@move@trash_fast_turn", 0.0)
    return
end

function SetWorkClothes()
    if Config.UseWorkClothes == true then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
            else
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
            end
        end)
    else
        return
    end
end

function RemoveWorkClothes()
    if Config.UseWorkClothes == true then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    else
        return
    end
end

function Draw3DText(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 700
    DrawRect(_x, _y + 0.0150, 0.06 + factor, 0.03, 41, 11, 41, 100)
end

Citizen.CreateThread(function()
    Citizen.Wait(0)

    function AddBlip(coords)
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipRoute(blip, true)
        while trashFound == true and jobVehicle ~= nil do
            Citizen.Wait(0)
            DrawMarker(29, coords.x, coords.y, coords.z + 3, 0, 0, 0, 0, 0, 0, 2.001, 0.5001, 2.1001, 0, 255, 0, 50, 1, 1, 0, 0)

            local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, playerCoords.x, playerCoords.y, playerCoords.z)

            if distance > Config.BreakDistance then
                break
            end

        end

        trashFound = false
        SetBlipRoute(blip, false)
        RemoveBlip(blip)

        Citizen.Wait(300)
        return
    end
end)
function GarbageReturnVehicles()
    if DoesBlipExist(VehiclesReturnBlip) then
        return
    else
        VehiclesReturnBlip = AddBlipForCoord(Config.Return.x, Config.Return.y, Config.Return.z)

        SetBlipSprite(VehiclesReturnBlip, 289)
        SetBlipScale(VehiclesReturnBlip, 0.8)
        SetBlipColour(VehiclesReturnBlip, 5)
        SetBlipDisplay(VehiclesReturnBlip, 2)
        SetBlipAsShortRange(VehiclesReturnBlip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Return Garbage Vehicle')
        EndTextCommandSetBlipName(VehiclesReturnBlip)
    end
end

function GarbageVehicles()
    if DoesBlipExist(VehiclesBlip) then
        return
    else
        VehiclesBlip = AddBlipForCoord(Config.Vehicle.x, Config.Vehicle.y, Config.Vehicle.z)

        SetBlipSprite(VehiclesBlip, 632)
        SetBlipScale(VehiclesBlip, 0.9)
        SetBlipColour(VehiclesBlip, 5)
        SetBlipDisplay(VehiclesBlip, 2)
        SetBlipAsShortRange(VehiclesBlip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Garbage Collector Vehicles')
        EndTextCommandSetBlipName(VehiclesBlip)
    end
end

function GarbageLocker()
    if DoesBlipExist(LockerBlip) then
        return
    else
        LockerBlip = AddBlipForCoord(Config.Locker.x, Config.Locker.y, Config.Locker.z)

        SetBlipSprite(LockerBlip, 318)
        SetBlipScale(LockerBlip, 0.9)
        SetBlipColour(LockerBlip, 5)
        SetBlipDisplay(LockerBlip, 2)
        SetBlipAsShortRange(LockerBlip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Garbage Collector Locker')
        EndTextCommandSetBlipName(LockerBlip)
    end
end