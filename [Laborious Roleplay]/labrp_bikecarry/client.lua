RegisterNetEvent('pickup:bike')
AddEventHandler('pickup:bike', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
    local bone = GetPedBoneIndex(playerPed, 0xE5F3)
    local bike = false

    if GetEntityModel(vehicle) == GetHashKey("bmx") or GetEntityModel(vehicle) == GetHashKey("jet") or GetEntityModel(vehicle) == GetHashKey("cruiser") or GetEntityModel(vehicle) == GetHashKey("fixter") or GetEntityModel(vehicle) == GetHashKey("tribike") or GetEntityModel(vehicle) == GetHashKey("tribike2") or GetEntityModel(vehicle) == GetHashKey("tribike3")  then

    AttachEntityToEntity(vehicle, playerPed, bone, 0.0, 0.24, 0.10, 340.0, 330.0, 330.0, true, true, false, true, 1, true)
    exports['mythic_notify']:SendAlert('inform', 'Press G to drop the bike.', 5000)

    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
    bike = true

    RegisterCommand('dropbike', function()
        if IsEntityAttached(vehicle) then
        DetachEntity(vehicle, nil, nil)
        SetVehicleOnGroundProperly(vehicle)
        ClearPedTasksImmediately(playerPed)
        bike = false
        end
    end, false)

        RegisterKeyMapping('dropbike', 'Drop Bike', 'keyboard', 'g')

                Citizen.CreateThread(function()
                while true do
                Citizen.Wait(0)
                if bike and IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "idle", 3) ~= 1 then
                    RequestAnimDict("anim@heists@box_carry@")
                    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
                    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
                    DisableControlAction(0, 157) --1
                    DisableControlAction(0, 158) --2
                    DisableControlAction(0, 160) --3
                    DisableControlAction(0, 164) --4
                    DisableControlAction(0, 165)
                    DisableControlAction(0, 289)
                    if not IsEntityAttachedToEntity(playerPed, vehicle) then
                        bike = false
                        ClearPedTasksImmediately(playerPed)
                    end
                end
            end
        end)
    end
end)

Citizen.CreateThread(function()

    local bike = {
        `bmx`,
        `cruiser`,
        `scorcher`,
        `fixter`,
        `tribike`,
        `tribike2`,
        `tribike3`,
    }

    exports['labrp_Eye']:AddTargetModel(bike, {
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
    
end)