
ESX =  nil

local pos = GetEntityCoords(GetPlayerPed(-1),  true)
local s1, s2 = GetStreetNameAtCoord( pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
local street1 = GetStreetNameFromHashKey(s1)
local street2 = GetStreetNameFromHashKey(s2)
local isRobbing = false
local hasRobbed = false
local looting = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('animation:rob')
AddEventHandler('animation:rob', function()
    local Ped = GetPlayerPed(-1)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    while isRobbing == true do
        if not IsEntityPlayingAnim(Ped, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end)

RegisterNetEvent('animation:hack')
AddEventHandler('animation:hack', function()
    local coords = GetEntityCoords(PlayerPedId())
    exports['core_dispatch']:addCall('10-68', "Truck Robbery", {
        {icon="fa-truck-moving", info="Money Truck Robbery"}
        }, {coords.x, coords.y, coords.z}, "police", 10000, 616, 1)
    local Ped = GetPlayerPed(-1)
    RequestAnimDict("anim@heists@humane_labs@emp@hack_door")
    while not HasAnimDictLoaded("anim@heists@humane_labs@emp@hack_door") do
        Citizen.Wait(0)
    end

    while Hacking == true do
        if not IsEntityPlayingAnim(Ped, "anim@heists@humane_labs@emp@hack_door", "hack_loop", 3) then
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "anim@heists@humane_labs@emp@hack_door", "hack_loop", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end)

RegisterNetEvent('RS7x:getReward')
AddEventHandler('RS7x:getReward', function()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)

    if vehicle == GetHashKey('stockade') or GetEntityModel(vehicle) then
      createped()
      pedSpawned = true
      TriggerServerEvent('RS7x:NotifyPolice', street1, street2, pos)
    end
    Citizen.Wait(0)
end)

function PlateCheck(CurPlate, CurrentPlate)
    local Ped = GetPlayerPed(-1)

    if CurrentPlate ~= CurPlate then
        return
    else
        looting = true
        TriggerEvent('animation:rob')
        exports['mythic_progbar']:Progress({
            name = "robbingtruck",
            duration = 150000,
            label = 'Searching Vehicle',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        })    
        Citizen.Wait(150000)    
        TriggerServerEvent('RS7x:Payout')
        isRobbing = false
        exports['cd_drawtextui']:HideInteraction()
    end
end

RobbedPlates = {}

Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    local pos = GetEntityCoords(GetPlayerPed(-1))
    local stockade = GetHashKey('stockade')
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, stockade, 70)
    local text = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -4.25, 0.0)
    local dstCheck = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(vehicle), true)
    local Plate = GetVehicleNumberPlateText(vehicle)
    local Ped = GetPlayerPed(-1)

    if DoesEntityExist(vehicle) then
        if not isRobbing then
            if dstCheck < 5.0 then
                if IsControlJustReleased(0, 38) and not hasRobbed then
                    if not RobbedPlates[Plate] then
                        CurPlate = GetVehicleNumberPlateText(vehicle)
                        TriggerServerEvent('RS7x:Itemcheck', 1)
                    else
                        exports['mythic_notify']:DoHudText('error', 'This truck appears to be empty (already hit)')
                    end
                end
            end
        end

        if not IsEntityDead(GetPlayerPed(-1)) then

            if pedSpawned == true and vehicle then
                if dstCheck < 5.0 then
                    exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', "[E] Search Truck")
                    if IsControlJustReleased(0,38) and not looting then
                        CurrentPlate = GetVehicleNumberPlateText(vehicle)
                        PlateCheck(CurPlate, CurrentPlate)
                    end
                end
                if finished then
                    SetPedAsNoLongerNeeded(guard)
                    SetPedAsNoLongerNeeded(guard2)
                    SetPedAsNoLongerNeeded(guard3)
                    pedSpawned = false
                    isRobbing = false
                    looting = false
                    Timeout(true)
                    RobbedPlates[Plate] = true
                    TriggerServerEvent('RS7x:UpdatePlates', RobbedPlates, Plate)
                    TriggerServerEvent('RS7x:moneytruck_false')
                    exports['cd_drawtextui']:HideInteraction()
                end
            end
        else
            TriggerServerEvent('RS7x:moneytruck_false')
            Citizen.Wait(Config.Timeout * 1000)
            finished = false
            isRobbing = false
            pedSpawned = false
            looting = false
        end
    else
        Citizen.Wait(500)
    end
    end
end)

RegisterNetEvent('RS7x:newTable')
AddEventHandler('RS7x:newTable', function(UpdatedTable)
    RobbedPlates = UpdatedTable
end)

RegisterNetEvent('RS7x:startHacking')
AddEventHandler('RS7x:startHacking', function()
  isRobbing = true
  Hacking = true
    if isRobbing == true then
      print('started')
      exports["memorygame"]:thermiteminigame(12, 4, 4, 12,
      function() -- success
        print("success")
        exports['mythic_notify']:SendAlert('success', "Grab the money!")
        TriggerEvent('RS7x:getReward')
        Hacking = false
    end,
    function() -- failure
        print("failure")
        exports['mythic_notify']:SendAlert('error', "You failed to hack you need to wait 30 seconds")
        Hacking = false
        Wait(30 * 1000) -- add a time penalty if failed, so it gives police more time to arrive // feel free to remove
        isRobbing = false
        exports['mythic_notify']:SendAlert('inform', 'you can now hit the truck again')
        TriggerServerEvent('RS7x:moneytruck_false')
    end)
    end
end)

RegisterNetEvent('RS7x:NotifyPolice')
AddEventHandler('RS7x:NotifyPolice', function(msg)
    exports['mythic_notify']:DoHudText('error', msg)
end)

function createped()

    local pos = GetEntityCoords(GetPlayerPed(-1))
    local hashKey = GetHashKey("ig_casey")
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)
    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(500)
    end

    print('Spawning Peds?')

    guard = CreatePedInsideVehicle(vehicle, pedType, hashKey, 0, 1, 1)
    guard2 = CreatePedInsideVehicle(vehicle, pedType, hashKey, 1, 1, 1)
    guard3 =  CreatePedInsideVehicle(vehicle, pedType, hashKey, 2, 1, 1)

  --////////////
  --  Guard 1
  --///////////

    SetPedShootRate(guard,  750)
    SetPedCombatAttributes(guard, 46, true)
    SetPedFleeAttributes(guard, 0, 0)
    SetPedAsEnemy(guard,true)
    SetPedMaxHealth(guard, 900)
    SetPedAlertness(guard, 3)
    SetPedCombatRange(guard, 0)
    SetPedCombatMovement(guard, 3)
    TaskCombatPed(guard, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard, vehicle, 0)
    GiveWeaponToPed(guard, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard, GetHashKey("HATES_PLAYER"))

    --////////////
    --  Guard 2
    --///////////
    SetPedShootRate(guard2,  750)
    SetPedCombatAttributes(guard2, 46, true)
    SetPedFleeAttributes(guard2, 0, 0)
    SetPedAsEnemy(guard2,true)
    SetPedMaxHealth(guard2, 900)
    SetPedAlertness(guard2, 3)
    SetPedCombatRange(guard2, 0)
    SetPedCombatMovement(guard2, 3)
    TaskCombatPed(guard2, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard2, vehicle, 0)
    GiveWeaponToPed(guard2, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard2, GetHashKey("HATES_PLAYER"))
  
    --////////////
    --  Guard3
    --///////////
    SetPedShootRate(guard3,  750)
    SetPedCombatAttributes(guard3, 46, true)
    SetPedFleeAttributes(guard3, 0, 0)
    SetPedAsEnemy(guard3,true)
    SetPedMaxHealth(guard3, 900)
    SetPedAlertness(guard3, 3)
    SetPedCombatRange(guard3, 0)
    SetPedCombatMovement(guard3, 3)
    TaskCombatPed(guard3, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard3, vehicle, 0)
    GiveWeaponToPed(guard3, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard3, GetHashKey("HATES_PLAYER"))
end