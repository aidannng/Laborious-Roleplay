local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local HasKey, IsHotwiring, IsRobbing, isLoggedIn, AlertSend = false, false, false, false, false
local LastVehicle = nil
local NeededAttempts, SucceededAttempts, FailedAttemps = 0, 0, 0
local vehicleSearched, vehicleHotwired = {}, {}


RegisterNetEvent("vehiclekeys:client:gimmie")
AddEventHandler("vehiclekeys:client:gimmie", function()
    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true))
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        if not HasKey then  
            exports['mythic_notify']:SendAlert('error', 'You do not have the keys to this vehicle')
        else
            TriggerServerEvent("vehiclekeys:server:givePeopleKeys", plate)
            exports['mythic_notify']:SendAlert('inform', 'You have given the keys to x')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'You are not in a vehicle')
    end
end)     

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if ESX ~= nil then
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), true), -1) == GetPlayerPed(-1) then
                local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true))
                if LastVehicle ~= GetVehiclePedIsIn(GetPlayerPed(-1), false) then
                    ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(result)
                        Wait(350)
                        local model = GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false));
                        if result or model == `bus` or model == `airbus` or model == `coach` or model == `trash` or model == `trash2` or model == `riata` or model == `hauler` or model == `phantom` or model == `bmx` or model == `cruiser` or model == `fixter` or model == `scorecher` or model == `tribike` or model == `tribike2` or model == `tribike3` or model == `packer` or model == `phantom3` then
                            HasKey = true
                            SetVehicleEngineOn(veh, true, false, true)
                             TriggerServerEvent('Aidan_isCool:giveKeys')
                        else
                            HasKey = false
                            SetVehicleEngineOn(veh, false, false, true)
                        end
                        LastVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                    end, plate)
                end
            else
                if SucceededAttempts ~= 0 then
                    SucceededAttempts = 0
                end
                if NeededAttempts ~= 0 then
                    NeededAttempts = 0
                end
                if FailedAttemps ~= 0 then
                    FailedAttemps = 0
                end
            end
        end

        if not HasKey and IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and ESX ~= nil and not IsHotwiring then
            local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            SetVehicleEngineOn(veh, false, false, true)
            local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local vehpos = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 0.0)
            local vehpos2 = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 0.2)
            local vehpos3 = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 0.4)

            BBGarages.Functions.DrawText3D(vehpos, "[G] Search Vehicle" )
            BBGarages.Functions.DrawText3D(vehpos2, "[H] Hotwire With Hands" )
            BBGarages.Functions.DrawText3D(vehpos3, "[B] Hotwire With Lockpick" )
            SetVehicleEngineOn(veh, false, false, true)

            if IsControlJustPressed(0, Keys["H"]) then
                Hotwire()
            end

            if IsControlJustPressed(1, Keys["G"]) then
                Search()
            end

            if IsControlJustPressed(1, Keys["B"]) then
                LockPickVeh()
            end
        end

        if IsControlJustPressed(1, Keys["L"]) then
            --LockVehicle()
        end
    end
end)

--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if not IsRobbing and ESX ~= nil then
            if GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= nil and GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= 0 then
                local vehicle = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver ~= 0 and not IsPedAPlayer(driver) then
                    if IsEntityDead(driver) then
                        IsRobbing = true
                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
                        HasKey = true
                        IsRobbing = false
                    end
                end
            end

        end
    end
end) ]]

RegisterNetEvent('vehiclekeys:client:SetOwner')
AddEventHandler('vehiclekeys:client:SetOwner', function(plate, vehicle)
    local VehPlate = plate
    Citizen.Wait(100)
    if VehPlate == nil then
        VehPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true))
    end

    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', plate, vehicle)
    if (IsPedInAnyVehicle(GetPlayerPed(-1) and plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true)))) then
        SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), true), true, false, true)
    end
    HasKey = true
end)

RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function()
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local latestveh = getVehicleInDirection(coordA, coordB)
    
    if latestveh == nil or not DoesEntityExist(latestveh) then
        exports['mythic_notify']:SendAlert('error', 'No vehicle nearby')
        return
    end
    
    ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(hasKey)
        if not hasKey then
            exports['mythic_notify']:SendAlert('error', 'You do not have the keys to this vehicle')
            return
        end

        if #(GetEntityCoords(latestveh) - GetEntityCoords(PlayerPedId(), 0)) > 5 then
            exports['mythic_notify']:SendAlert('error', 'You are too far away from the vehicle')
            return
        end
        
        t, distance = ESX.Game.GetClosestPlayer()
        if(distance ~= -1 and distance < 5) then
            TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', GetVehicleNumberPlateText(latestveh), GetPlayerServerId(t))
        else
            exports['mythic_notify']:SendAlert('error', 'There is no one near you')
        end
    end, GetVehicleNumberPlateText(latestveh))
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
  
    for i = 0, 100 do
      rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0) 
      a, b, c, d, vehicle = GetRaycastResult(rayHandle)
      
      offset = offset - 1
  
      if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end
  
      return vehicle ~= nil and vehicle or 0
  end

RegisterNetEvent('vehiclekeys:client:ToggleEngine')
AddEventHandler('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1)))
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
    if HasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    if (IsPedInAnyVehicle(GetPlayerPed(-1))) then
        if not HasKey then
            LockpickIgnition(isAdvanced)
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

function RobVehicle(target)
    IsRobbing = true
    Citizen.CreateThread(function()
        while IsRobbing do
            local RandWait = math.random(10000, 15000)
            loadAnimDict("random@mugging3")

            TaskLeaveVehicle(target, GetVehiclePedIsIn(target, true), 256)
            Citizen.Wait(1000)
            ClearPedTasksImmediately(target)

            TaskStandStill(target, RandWait)
            TaskHandsUp(target, RandWait, GetPlayerPed(-1), 0, false)

            Citizen.Wait(RandWait)

            --TaskReactAndFleePed(target, GetPlayerPed(-1))
            IsRobbing = false
        end
    end)
end

function LockVehicle()
    local veh = ESX.Game.GetClosestVehicle()
    local coordA = GetEntityCoords(GetPlayerPed(-1), true)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 255.0, 0.0)
    local veh = GetClosestVehicleInDirection(coordA, coordB)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    end
    local plate = GetVehicleNumberPlateText(veh)
    local vehpos = GetEntityCoords(veh, false)
    if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 7.5 then
        ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(result)
            if result then
                local isParked = isParked(plate)
                if not isParked then
                    if HasKey then
                        local vehLockStatus = GetVehicleDoorLockStatus(veh)
                        loadAnimDict("anim@mp_player_intmenu@key_fob@")
                        TaskPlayAnim(GetPlayerPed(-1), 'anim@mp_player_intmenu@key_fob@', 'fob_click' ,3.0, 3.0, -1, 49, 0, false, false, false)
                    
                        if vehLockStatus == 1 then
                            Citizen.Wait(750)
                            ClearPedTasks(GetPlayerPed(-1))
                            TriggerEvent('InteractSound_CL:PlayOnOne', 'lock', 0.5)
                            SetVehicleDoorsLocked(veh, 2)
                            if(GetVehicleDoorLockStatus(veh) == 2)then
                                exports['mythic_notify']:SendAlert('inform', 'Vehicle Locked')
                            else
                                --exports['mythic_notify']:SendAlert('inform', 'Updated your waypoint on your GPS to your vehicle')
                            end
                        else
                            Citizen.Wait(750)
                            ClearPedTasks(GetPlayerPed(-1))
                            TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 0.3)
                            SetVehicleDoorsLocked(veh, 1)
                            if(GetVehicleDoorLockStatus(veh) == 1)then
                                exports['mythic_notify']:SendAlert('inform', 'Vehicle Unlocked')
                            else
                                --exports['mythic_notify']:SendAlert('inform', 'Updated your waypoint on your GPS to your vehicle')
                            end
                        end
                    
                        if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                            SetVehicleInteriorlight(veh, true)
                            SetVehicleIndicatorLights(veh, 0, true)
                            SetVehicleIndicatorLights(veh, 1, true)
                            Citizen.Wait(450)
                            SetVehicleIndicatorLights(veh, 0, false)
                            SetVehicleIndicatorLights(veh, 1, false)
                            Citizen.Wait(450)
                            SetVehicleInteriorlight(veh, true)
                            SetVehicleIndicatorLights(veh, 0, true)
                            SetVehicleIndicatorLights(veh, 1, true)
                            Citizen.Wait(450)
                            SetVehicleInteriorlight(veh, false)
                            SetVehicleIndicatorLights(veh, 0, false)
                            SetVehicleIndicatorLights(veh, 1, false)
                        end
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'You cannot use your vehicle while it is parked')
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You do not have the keys to this vehicle')
            end
        end, plate, veh)
    end
end

function Search()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)

        if vehicleSearched[GetVehicleNumberPlateText(vehicle)] then
            exports['mythic_notify']:SendAlert('error', 'You have already searched this vehicle')
            return
        end

        vehicleSearched[GetVehicleNumberPlateText(vehicle)] = true
        IsHotwiring = true
        local searchTime = math.random(10000, 20000)
        exports['mythic_progbar']:Progress({
            name = "hotwire",
            duration = searchTime,
            label = 'Searching Vehicle',
            useWhileDead = true,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        })
        Wait(searchTime)
        StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
        if (math.random(0, 100) < 10) then
            HasKey = true
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
            exports['mythic_notify']:SendAlert('inform', 'You found the keys while searching the vehicle!')
            TriggerEvent("debug", 'Keys: Found', 'success')
        else
            HasKey = false
            SetVehicleEngineOn(veh, false, false, true)
        end
        IsHotwiring = false
    end
end    

function LockPickVeh()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)

        ESX.TriggerServerCallback('vehiclekeys:server:hasitem', function(data)
            if data then
                vehicleSearched[GetVehicleNumberPlateText(vehicle)] = true
                IsHotwiring = true
                local lockpicktime = math.random(30000, 40000)
                exports['mythic_progbar']:Progress({
                    name = "lockpocl",
                    duration = lockpicktime,
                    label = 'Lockpicking Vehicle',
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                })
                Wait(lockpicktime)
                StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                HasKey = true
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                exports['mythic_notify']:SendAlert('inform', 'You have used a lockpick!') 
                TriggerEvent("debug", 'Keys: Found', 'success')
                IsHotwiring = false
            else
                exports['mythic_notify']:SendAlert('error', 'You do not have a lockpick!') 
             end
         end, "lockpick")
    end
end 

function Hotwire()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        local isParked = isParked(GetVehicleNumberPlateText(vehicle))
        if not isParked then
            
            if vehicleHotwired[GetVehicleNumberPlateText(vehicle)] then
                exports['mythic_notify']:SendAlert('inform', 'This vehicle has already been hot-wired') 
                return
            end

            vehicleHotwired[GetVehicleNumberPlateText(vehicle)] = true
            IsHotwiring = true
            local hotwireTime = math.random(10000, 20000)
            SetVehicleAlarm(vehicle, true)
            SetVehicleAlarmTimeLeft(vehicle, hotwireTime)
            exports['mythic_progbar']:Progress({
                name = "hotwire",
                duration = hotwireTime,
                label = 'Hotwiring Vehicle',
                useWhileDead = true,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            })
            Wait(hotwireTime)
            
            StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            if (math.random(0, 100) < 20) then
                HasKey = true
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                exports['mythic_notify']:SendAlert('inform', 'Hotwire succeeded!') 
            else
                TriggerEvent('dispatch:lockpick', vehicle)
                HasKey = false
                SetVehicleEngineOn(veh, false, false, true)
                exports['mythic_notify']:SendAlert('error', 'Hotwire failed!') 
            end
            IsHotwiring = false
        else
            exports['mythic_notify']:SendAlert('error', 'You cannot use a lockpick on a locked/parked vehicle!') 
        end
    end
end

function isParked(plate)
    for name, data in pairs(BBGarages.Config['garages']) do
        for key, value in pairs(data['slots']) do
            if value[3] ~= nil and value[3].plate == plate then
                return true
            end
        end
    end
    return false
end

-- functions
function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, GetPlayerPed(-1), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 250 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = ESX.Game.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and closestDistance < 30.0 then
		retval = closestPed
	end
	return retval
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
    if weapon ~= nil then
        for _, v in pairs(BBGarages.Config['settings']['blacklistedWeapons']) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

RegisterCommand('lock', function()
    LockVehicle()
end)
RegisterKeyMapping('lock', 'Locks/Unlocks Vehicle', 'keyboard', 'L')