ESX = nil

local vehicles = {}
local searchedVehicles = {}
local pickedVehicled = {}
local hasCheckedOwnedVehs = false
local lockDisable = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

function givePlayerKeys(plate)
    table.insert(vehicles, plate)
end

function hasToggledLock()
    lockDisable = true
    Wait(100)
    lockDisable = false
end

function playLockAnim(vehicle)
    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)

    local veh = vehicle

    while not HasAnimDictLoaded do
        Citizen.Wait(0)
    end

    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
    end
end

function toggleLock(vehicle)
    local veh = vehicle

    local plate = GetVehicleNumberPlateText(veh)
    local lockStatus = GetVehicleDoorLockStatus(veh)
    if hasKeys(plate) and not lockDisable then
        print('lock status: ' .. lockStatus)
        if lockStatus == 1 then
            SetVehicleDoorsLocked(veh, 2)
            SetVehicleDoorsLockedForAllPlayers(veh, true)
            exports['mythic_notify']:SendAlert('inform', 'Vehicle Locked')
            TriggerEvent('InteractSound_CL:PlayOnOne', 'lock', 0.2)
            playLockAnim()
            hasToggledLock()
        elseif lockStatus == 2 then
            SetVehicleDoorsLocked(veh, 1)
            SetVehicleDoorsLockedForAllPlayers(veh, false)
            exports['mythic_notify']:SendAlert('inform', 'Vehicle Unlocked')
            TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 0.2)
            playLockAnim(veh)
            hasToggledLock()
        else
            SetVehicleDoorsLocked(veh, 2)
            SetVehicleDoorsLockedForAllPlayers(veh, true)
            exports['mythic_notify']:SendAlert('inform', 'Vehicle Locked')
            TriggerEvent('InteractSound_CL:PlayOnOne', 'lock', 0.2)
            playLockAnim()
            hasToggledLock()
        end
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            Wait(500)
            local flickers = 0
            while flickers < 2 do
                SetVehicleLights(veh, 2)
                Wait(170)
                SetVehicleLights(veh, 0)
                flickers = flickers + 1
                Wait(170)
            end
        end
    end
end

-- Locking vehicles
Citizen.CreateThread(function()
    while true do
        local wait = 750
        local pos = GetEntityCoords(GetPlayerPed(-1))
        if IsControlJustReleased(0, 182) then
            print('lock')
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                toggleLock(veh)
            else
                local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 70)
                if DoesEntityExist(vehicle) then
                    toggleLock(vehicle)
                end
            end
        end
        Citizen.Wait(1)
    end
end)

local isSearching = false
local isHotwiring = false

-- Has entered vehicle without keys
Citizen.CreateThread(function()
    while true do
        local wait = 750
        local ped = GetPlayerPed(-1)
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped)
            local driver = GetPedInVehicleSeat(veh, -1)
            local plate = GetVehicleNumberPlateText(veh)
            if driver == ped then
                if not hasKeys(plate) and not isHotwiring and not isSearching then
                    local pos = GetEntityCoords(ped)
                    if hasBeenSearched(plate) then
                        wait = 2
                        DrawText3Ds(pos.x, pos.y, pos.z + 0.2, 'Press ~y~[H] ~w~to hotwire')
                    else
                        wait = 2
                        DrawText3Ds(pos.x, pos.y, pos.z + 0.2, 'Press ~y~[H] ~w~to hotwire or ~g~[G] ~w~to search')
                    end
                    SetVehicleEngineOn(veh, false, false, true)
                    -- Searching
                    if IsControlJustReleased(0, 47) and not isSearching and not hasBeenSearched(plate) then -- G
                        if hasBeenSearched(plate) then
                            isSearching = true
                            exports['mythic_progbar']:Progress({
                                name = "unique_action_name",
                                duration = 5000,
                                label = 'Searching Vehicle',
                                useWhileDead = true,
                                canCancel = false,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                            })
                            Citizen.Wait(5000)
                            isSearching = false
                            exports['mythic_notify']:SendAlert('error', 'You search the vehicle and find nothing')
                        else
                            local rnd = math.random(1, 8)
                            if rnd == 4 then
                                isSearching = true
                                exports['mythic_progbar']:Progress({
                                    name = "unique_action_name",
                                    duration = 6000,
                                    label = 'Searching Vehicle',
                                    useWhileDead = true,
                                    canCancel = false,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                })
                                Citizen.Wait(6000)
                                isSearching = false
                                exports['mythic_notify']:SendAlert('inform', "You found the keys for plate [" .. plate .. ']')
                                table.insert(vehicles, plate)
                                TriggerServerEvent('onyx:updateSearchedVehTable', plate)
                                table.insert(searchedVehicles, plate)
                            else
                                isSearching = true
                                exports['mythic_progbar']:Progress({
                                    name = "unique_action_name",
                                    duration = 6000,
                                    label = 'Searching Vehicle',
                                    useWhileDead = true,
                                    canCancel = false,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                })
                                Citizen.Wait(6000)
                                isSearching = false
                                exports['mythic_notify']:SendAlert('error', 'You search the vehicle and find nothing')

                                -- Update veh table so other players cant search the same vehicle
                                TriggerServerEvent('onyx:updateSearchedVehTable', plate)
                                table.insert(searchedVehicles, plate)
                            end
                        end
                    end
                    -- Hotwiring
                    if IsControlJustReleased(0, 74) and not isHotwiring then -- E
                        TriggerServerEvent('onyx:reqHotwiring', plate)
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		local ped = GetPlayerPed(-1)
		
		if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
			local engineWasRunning = GetIsVehicleEngineRunning(GetVehiclePedIsIn(ped, true))
			Citizen.Wait(1000)
			if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, false) and not IsEntityDead(ped) and not IsPauseMenuActive() then
				local veh = GetVehiclePedIsIn(ped, true)
				if (engineWasRunning) then
					SetVehicleEngineOn(veh, true, true, true)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 750
        if isHotwiring then
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(0, 74, true)  -- Lights
        end
        Citizen.Wait(wait)
    end
end)

RegisterNetEvent('onyx:updatePlates')
AddEventHandler('onyx:updatePlates', function(plate)
    table.insert(vehicles, plate)
end)

RegisterNetEvent('onyx:beginHotwire')
AddEventHandler('onyx:beginHotwire', function(plate)
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    RequestAnimDict("veh@std@ds@base")

    while not HasAnimDictLoaded("veh@std@ds@base") do
        Citizen.Wait(100)
	end
    local time = 12500 -- in ms

    local vehPlate = plate
    isHotwiring = true

    SetVehicleLights(veh, 0)
    
    if Config.HotwireAlarmEnabled then
        local alarmChance = math.random(1, Config.HotwireAlarmChance)

        if alarmChance == 1 then
            SetVehicleAlarm(veh, true)
            StartVehicleAlarm(veh)
        end
    end

    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 35000,
        label = 'Hotwiring',
        useWhileDead = true,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })
    TaskPlayAnim(PlayerPedId(), "veh@std@ds@base", "hotwire", 8.0, 8.0, -1, 1, 0.3, true, true, true)
    Citizen.Wait(35000)
    table.insert(vehicles, vehPlate)
    StopAnimTask(PlayerPedId(), 'veh@std@ds@base', 'hotwire', 1.0)
    isHotwiring = false
end)

local isRobbing = false
local canRob = false
local prevPed = false
local prevCar = false
local canTakeKeys = true


RegisterNetEvent('onyx:returnSearchedVehTable')
AddEventHandler('onyx:returnSearchedVehTable', function(plate)
    local vehPlate = plate
    table.insert(searchedVehicles, vehPlate)
end)

function hasBeenSearched(plate)
    local vehPlate = plate
    for k, v in ipairs(searchedVehicles) do
        if v == vehPlate then
            return true
        end
    end
    return false
end

function hasKeys(plate)
    local vehPlate = plate
    for k, v in ipairs(vehicles) do
        if v == vehPlate or v == vehPlate .. ' ' then
            return true
        end
    end
    return false
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 460
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.3, 0.3)
	SetTextFont(6)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 160)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0115, 0.02 + factor, 0.027, 28, 28, 28, 95)
end

local playerIsClose = false

Citizen.CreateThread(function()
    while true do
        local wait = 750
        local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestPlayerDistance > 4.0 then
            playerIsClose = false
        else
            playerIsClose = true
        end 
        Citizen.Wait(wait)  
    end
end)

exports['labrp_Eye']:Vehicle({
    options = {
        {
            event = "vehiclelock:givekeys",
            icon = "fas fa-key",
            label = "Give Keys",
            canInteract = function(entity)
                hasChecked = false
                if playerIsClose and not hasChecked then
                    hasChecked = true
                    return true
                end
            end
        },
    },
    distance = 2.5,
})

local checkplate = nil

RegisterNetEvent('vehiclelock:givekeys')
AddEventHandler('vehiclelock:givekeys', function(data)
    local vehicle = ESX.Game.GetVehicleInDirection()
    checkplate = GetVehicleNumberPlateText(vehicle)
    print(checkplate)
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    if hasKeys(checkplate) then
        if closestplayer ~= -1 and closestPlayerDistance  <= 3.0 then
            TriggerServerEvent('vehiclelock', GetPlayerServerId(closestPlayer), checkplate)
            exports['mythic_notify']:SendAlert('error', "You've give keys!")
        end
    else
        exports['mythic_notify']:SendAlert('inform', "You don't have keys!")
    end
end)

RegisterNetEvent('vehiclelock:setkeys')
AddEventHandler('vehiclelock:setkeys', function(plate)
    exports['mythic_notify']:SendAlert('inform', "Received Keys")
    exports["labrp_vehiclelock"]:givePlayerKeys(plate)
end)


