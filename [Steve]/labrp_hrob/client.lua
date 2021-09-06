ESX = nil

local MakeZones = false
local LeaveCoords, loc, PC, saveCoords, robbingHouse
local robSpot1, robSpot2, robSpot3, robSpot4, robSpot5, robSpot6
local HouseData, OffSets = nil, nil
local isInside = false
local hasProp = false
local sellerSpawned = false
local refreshPed = false
local onMission = false
local startSpawn, refreshJob = false, false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerJob = ESX.GetPlayerData().job
    Wait(100)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerJob = job
end)

--[ NPC Spawning -- ]

-- Spawn NPC if close by
Citizen.CreateThread(function()
    while true do
    Wait(1000)
        if refreshPed then
            if DoesEntityExist(sellPed) then
            exports['labrp_Eye']:AddEntityZone('sellPed', sellPed, {
            name="sellPed",
            debugPoly=false,
            useZ = true
              }, {
              options = {
                {
                event = "labrp-robbery:sendSellServer",
                icon = "fas fa-money-bill-wave-alt",
                label = "Sell Goods",
                },
              },
                job = {"all"},
                distance = 1.5
              })
            refreshPed = false
            end
        end

        if refreshJob then
            if DoesEntityExist(jobPed) then
                ESX.TriggerServerCallback('labrp_hrob:checkpolice', function(isEnough)
                    if isEnough then
                        exports['labrp_Eye']:AddEntityZone('jobPed', jobPed, {
                        name="jobPed",
                        debugPoly=false,
                        useZ = true
                        }, {
                        options = {
                                {
                                    event = "labrp-robbery:jobSelect",
                                    icon = "fas fa-house-user",
                                    label = "Get a Job",
                                },
                                {
                                    event = "labrp-robbery:abandon",
                                    icon = "fas fa-ban",
                                    label = "Cancel Job",
                                },

                            },
                            job = {"all"},
                            distance = 1.5
                        })
                    end
                end)
            refreshJob = false
            end
        end

    end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)

      local pedCoords = GetEntityCoords(GetPlayerPed(-1))
      local dst = #(Config.SellerLocation - pedCoords)
      if dst < 200 and sellerSpawned == false then
        TriggerEvent('labrp-robbery:spawnSeller',Config.SellerLocation, 335.93)
        sellerSpawned = true
        refreshPed = true
      end
      if dst >= 201  then
        if DoesEntityExist(sellPed) then
          DeletePed(sellPed)
        end
        sellerSpawned = false
      end

      local dst2 = #(Config.startLocation - pedCoords)
      if dst2 < 200 and startSpawn == false then
        TriggerEvent('labrp-robbery:spawnJobPed',Config.startLocation, 145.9)
        startSpawn = true
        refreshJob = true
      end
      if dst2 >= 201  then
        if DoesEntityExist(jobPed) then
          DeletePed(jobPed)
        end
        startSpawn = false
      end
  end
end)



-- Spawn the actual NPC
RegisterNetEvent('labrp-robbery:spawnSeller')
AddEventHandler('labrp-robbery:spawnSeller',function(coords, heading)
  local hash = GetHashKey('u_m_m_jewelthief')
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  sellPed = CreatePed(5, hash, coords, heading, false, false)
  FreezeEntityPosition(sellPed, true)
  SetEntityInvincible(sellPed, true)
  SetEntityHeading(jobPed, 140)
  SetBlockingOfNonTemporaryEvents(sellPed, true)
  SetModelAsNoLongerNeeded(hash)
end)

-- Spawn the actual NPC
RegisterNetEvent('labrp-robbery:spawnJobPed')
AddEventHandler('labrp-robbery:spawnJobPed',function(coords, heading)
  local hash = GetHashKey('ig_sol')
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  jobPed = CreatePed(5, hash, coords, heading, false, false)
  FreezeEntityPosition(jobPed, true)
  SetEntityInvincible(jobPed, true)
  SetEntityHeading(jobPed, 11)
  SetBlockingOfNonTemporaryEvents(jobPed, true)
  SetModelAsNoLongerNeeded(hash)
end)



-- Tell labrp_Eye to send server side

RegisterNetEvent('labrp-robbery:sendSellServer')
AddEventHandler('labrp-robbery:sendSellServer', function()
TriggerServerEvent('labrp-robbery:sellItems')
if hasProp then
    hasProp = false
    DeleteObject(PC)
    ClearPedTasksImmediately(PlayerPedId())
end
end)

-- [ End NPC Stuff ]



-- Police Notification
RegisterNetEvent('labrp-robbery:notifyPolice')
AddEventHandler('labrp-robbery:notifyPolice',function(playerCoords,currentStreetName)
    if PlayerJob.name == Config.PoliceName then
    exports['mythic_notify']:SendAlert('error', 'Dispatch: An alarm has gone off on '  .. currentStreetName , 10000) 
    RemoveBlip(blipRobbery)
    blipRobbery = AddBlipForCoord(playerCoords)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
    Wait(60000)
    RemoveBlip(blipRobbery)
    
    end
end)

-- Functions for things
function GetCurrentStreetName()
    local pedCoords = GetEntityCoords(PlayerPedId())

    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(pedCoords["x"], pedCoords["y"], pedCoords["z"], currentStreetHash, intersectStreetHash)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

    return currentStreetName
end



RegisterNetEvent('labrp-robbery:jobSelect')
AddEventHandler('labrp-robbery:jobSelect', function(mission)

    if GetClockHours() <= 7 and GetGameTimer() > 23   then
    local num = math.random(1,#Config.Houses)
    local numy = 0
    while Config.Houses[num].hasJob and numy < 100 do
        numy = numy+1
        num = math.random(1,#Config.Houses)
    end
    if numy == 100 then

    else
        CurrentEventNum = num
        TriggerEvent('labrp-robbery:jobStart',num)
        exports['mythic_notify']:SendAlert('inform', 'House GPS Set!') 
    end

  end
end)

RegisterNetEvent('labrp-robbery:abandon')
AddEventHandler('labrp-robbery:abandon', function()
    if DoesBlipExist(jobBlip) then
        RemoveBlip(jobBlip)
        exports['mythic_notify']:SendAlert('error', 'Job Cancelled!') 
    end 
end)

RegisterNetEvent('labrp-robbery:jobStart')
AddEventHandler('labrp-robbery:jobStart', function(num)

onMission = true
coords = Config.Houses[num].houseloc

Config.Houses[num].hasJob = true
    if DoesBlipExist(jobBlip) then
        RemoveBlip(jobBlip)
    end 
  jobBlip = AddBlipForCoord(coords)
  SetBlipSprite(jobBlip, 40)
  SetBlipDisplay(jobBlip, 4)
  SetBlipScale(jobBlip, 0.8)
  SetBlipColour(jobBlip, 40)
  SetBlipAsShortRange(jobBlip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Target House")
  EndTextCommandSetBlipName(jobBlip)

end)


RegisterNetEvent('labrp-robbery:pickDoor')
AddEventHandler('labrp-robbery:pickDoor', function(xPlayer)
    for k,v in pairs(Config.Houses) do
      local playerPed = PlayerPedId()
      local house = k
      local coords = GetEntityCoords(playerPed)
      --local dist   = GetDistanceBetweenCoords(v.pos.x, v.pos.y, v.pos.z, coords.x, coords.y, coords.z, false)
      local housecoords = vector3(v.pos.x, v.pos.y,v.pos.z)
      local dist = #(housecoords - coords)
        if GetClockHours() <= 7 and GetGameTimer() > 23 then
          if dist <= 1.2  then
            if v.hasJob then                 
                local skillcheck = exports["reload-skillbar"]:taskBar(2500,math.random(5,15))
                if skillcheck == 100 then
                    local skillcheck2 = exports["reload-skillbar"]:taskBar(1500,math.random(5,8))
                    if skillcheck2 == 100 then
                        HouseBreak(house)
                        v.hasJob = false
                    else
                        TriggerServerEvent('labrp-robbery:removeItem', 'lockpick')
                        local data = {displayCode = '10-68', description = 'Residential Disturbance', isImportant = 0, recipientList = {'police','fbi'}, length = '10000', infoM = 'fas fa-home', info = 'House Robbery'}
                        local dispatchData = {dispatchData = data, caller = 'Alarm', coords = GetEntityCoords(PlayerPedId(-1))}
                        TriggerEvent('wf-alerts:svNotify', dispatchData)
                    end
                end
            end
          end
        end
    end
end)

          
function HouseBreak(house)
  local v = GetHouseValues(house, Config.Houses)
  local playerPed = PlayerPedId()

  FreezeEntityPosition(playerPed, true)
  SetEntityCoords(playerPed, v.animPos.x, v.animPos.y, v.animPos.z - 0.98)
  SetEntityHeading(playerPed, v.animPos.h)
  loadAnimDict("mini@safe_cracking")
  TaskPlayAnim(playerPed, "mini@safe_cracking", "idle_base", 3.5, - 8, - 1, 2, 0, 0, 0, 0, 0)

  rand = math.random(1, 10)
  if rand == 1 then
    TriggerServerEvent('labrp-robbery:removeItem', 'lockpick', 1)
  end 

  ClearPedTasks(playerPed)
  FreezeEntityPosition(playerPed, false)
           if DoesBlipExist(jobBlip) then
            RemoveBlip(jobBlip)
          end 
  TriggerEvent('labrp-robbery:SpawnShell')

end 

function GetHouseValues(house, pair)
  for k, v in pairs(pair) do
    if k == house then
      return v
    end
  end
end

-- Load animations for the player
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

-- We use this to check for Noise
function isInsideHouse()
local alarmTriggered = false
Citizen.CreateThread(function()
    while isInside do
        Wait(2000)
        local noise = GetPlayerCurrentStealthNoise(PlayerId())
        if noise >= 6 and alarmTriggered == false then
            alarmTriggered = true
            local playerCoords = GetEntityCoords(PlayerPedId(-1))
            local currentStreetName = GetCurrentStreetName()

            local data = {displayCode = '10-68', description = 'Residential Disturbance', isImportant = 0, recipientList = {'police','fbi'}, length = '10000', infoM = 'fas fa-home', info = 'House Robbery'}
            local dispatchData = {dispatchData = data, caller = 'Alarm', coords = GetEntityCoords(PlayerPedId(-1))}
            TriggerEvent('wf-alerts:svNotify', dispatchData)
        end
    end
end)
end

RegisterNetEvent('labrp-robbery:SpawnShell')
AddEventHandler('labrp-robbery:SpawnShell',function(args)

    local robbingHouse = {}
    loc = GetEntityCoords(GetPlayerPed(-1))
    shloc = vector3(loc.x,loc.y,loc.z - 50)
    saveCoords = loc
    MakeZones = true
    robbingHouse = exports['labrp_housing']:CreateTier1HouseFurnished(shloc,false)
    Wait(4000) 
    LeaveCoords = GetEntityCoords(GetPlayerPed(-1))
    MakeZones = true
    HouseData, OffSets = robbingHouse[1], robbingHouse[2]
    isInside = true
    isInsideHouse()
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)
 
            if refreshItems then
            exports['labrp_Eye']:AddEntityZone('robPC', PC, {
                name="robPC",
                debugPoly=false,
                useZ = true
                    }, {
                    options = {
                        {
                        event = "labrp-robbery:carryObj",
                        icon = "fas fa-hand-holding",
                        label = "Carry",
                        },                        
                    },
                        job = {"all"},
                        distance = 2.5
                    })
            refreshItems = false
            end


            if MakeZones then
                robSpot1 = false
                robSpot2 = false
                robSpot3 = false
                robSpot4 = false
                robSpot5 = false
                robSpot6 = false

            robLoc1 = math.random(1,2)
            if robLoc1 == 1 then
                rob1Coords = vector3(shloc.x-3.50363200, shloc.y-6.55289400, shloc.z+1.30625800)
            else
                rob1Coords = vector3(shloc.x+2.84053000,shloc.y-4.30947100,shloc.z+1.24577300)
            end
            robLoc2 = math.random(1,2)
            if robLoc2 == 1 then
                rob2Coords = vector3(shloc.x+7.24382000,shloc.y+4.53423500,shloc.z+1.19625800)
            else
                rob2Coords = vector3(shloc.x+8.46626300, shloc.y+4.53223600, shloc.z+1.19425800)
            end
            robLoc4 = math.random(1,2)
            if robLoc4 == 1 then
                rob4Coords = vector3(shloc.x+2.03442400,shloc.y-4.61585100,shloc.z+2.30395600)
            else
                rob4Coords = vector3(shloc.x+1.90339700, shloc.y-3.80026800, shloc.z+1.29917900)
            end
                            
                Wait(4000)
            
            propRNG = math.random(1,Config.PropChance)
            if propRNG == Config.PropChance then
                PC = CreateObject(`prop_tv_02`,shloc.x-3.50712600,shloc.y-4.13621600,shloc.z+1.89625800,false,false,false)
                refreshItems = true
            end
                
        exports['labrp_Eye']:AddBoxZone("LeaveHouse", vector3(shloc.x+3.656456, shloc.y-15.37439, shloc.z+1.0037586), 1.4, 1.4, {
            name="LeaveHouse",
            heading=0,
            debugPoly=false,
            minZ=LeaveCoords.z,
            maxZ=LeaveCoords.z+10
        }, {
            options = {
                {
                event = "labrp-robbery:leaveHouse",
                icon = "fas fa-door-open",
                label = "Leave House",
                },
            },
                job = {"all"},
                distance = 3
        })
        -- Tables
        exports['labrp_Eye']:AddBoxZone("robSpot1", rob1Coords, 1.0, 1.0, {
            name="robSpot1",
            heading=0,
            debugPoly=false,
            minZ=shloc.z,
            maxZ=shloc.z+3
        }, {
            options = {
                {
                event = "labrp-robbery:robSpot1",
                icon = "fas fa-search",
                label = "Search",
                },
            },
                job = {"all"},
                distance = 3
        })
        -- Wardrobe
        exports['labrp_Eye']:AddBoxZone("robSpot2", rob2Coords, 1.0, 1.0, {
            name="robSpot2",
            heading=0,
            debugPoly=false,
            minZ=shloc.z,
            maxZ=shloc.z+3
        }, {
            options = {
                {
                event = "labrp-robbery:robSpot2",
                icon = "fas fa-search",
                label = "Search",
                },
            },
                job = {"all"},
                distance = 3
        })

        exports['labrp_Eye']:AddBoxZone("robSpot3", vector3(shloc.x+5.84416200, shloc.y+2.57377400, shloc.z+1.22089100), 1.0, 1.0, {
            name="robSpot3",
            heading=0,
            debugPoly=false,
            minZ=shloc.z,
            maxZ=shloc.z+3
        }, {
            options = {
                {
                event = "labrp-robbery:robSpot3",
                icon = "fas fa-search",
                label = "Search",
                },
            },
                job = {"all"},
                distance = 3
        })
        -- Fridge/Microwave
        exports['labrp_Eye']:AddBoxZone("robSpot4", rob4Coords, 1.0, 1.0, {
            name="robSpot4",
            heading=0,
            debugPoly=false,
            minZ=shloc.z,
            maxZ=shloc.z+3
        }, {
            options = {
                {
                event = "labrp-robbery:robSpot4",
                icon = "fas fa-search",
                label = "Search",
                },
            },
                job = {"all"},
                distance = 3
        })

        exports['labrp_Eye']:AddBoxZone("robSpot5", vector3(shloc.x+8.70730600,shloc.y-2.55503600,shloc.z+1.94059590), 1.0, 1.0, {
            name="robSpot5",
            heading=0,
            debugPoly=false,
            minZ=shloc.z,
            maxZ=shloc.z+3
        }, {
            options = {
                {
                event = "labrp-robbery:robSpot5",
                icon = "fas fa-search",
                label = "Search",
                },
            },
                job = {"all"},
                distance = 3
        })
        -- Storage Chest
        exports['labrp_Eye']:AddBoxZone("robSpot6", vector3(shloc.x+9.75982700,shloc.y-1.35874100,shloc.z+1.29625800), 1.0, 1.0, {
            name="robSpot6",
            heading=0,
            debugPoly=false,
            minZ=shloc.z,
            maxZ=shloc.z+3
        }, {
            options = {
                {
                event = "labrp-robbery:robSpot6",
                icon = "fas fa-search",
                label = "Search",
                },
            },
                job = {"all"},
                distance = 3
        })


            MakeZones = false
            end

    end
end)
-- All the loot spots
RegisterNetEvent('labrp-robbery:robSpot1')
AddEventHandler('labrp-robbery:robSpot1',function()
    if robSpot1 then 
        exports['mythic_notify']:SendAlert('inform', 'Nothing here.', 5000)
    else
        robSpot1 = true
        weRobbinMayne()
    end
end)

RegisterNetEvent('labrp-robbery:robSpot2')
AddEventHandler('labrp-robbery:robSpot2',function()
    if robSpot2 then 
        exports['mythic_notify']:SendAlert('inform', 'Nothing here.', 5000)
    else
        robSpot2 = true
        weRobbinMayne()
    end
end)

RegisterNetEvent('labrp-robbery:robSpot3')
AddEventHandler('labrp-robbery:robSpot3',function()
    if robSpot3 then 
        exports['mythic_notify']:SendAlert('inform', 'Nothing here.', 5000)
    else
        robSpot3 = true
        weRobbinMayne()
    end
end)

RegisterNetEvent('labrp-robbery:robSpot4')
AddEventHandler('labrp-robbery:robSpot4',function()
    if robSpot4 then 
        exports['mythic_notify']:SendAlert('inform', 'Nothing here.', 5000)
    else
        robSpot4 = true
        weRobbinMayne()
    end
end)

RegisterNetEvent('labrp-robbery:robSpot5')
AddEventHandler('labrp-robbery:robSpot5',function()
    if robSpot5 then 
        exports['mythic_notify']:SendAlert('inform', 'Nothing here.', 5000)
    else
        robSpot5 = true
        weRobbinMayne()
    end
end)

RegisterNetEvent('labrp-robbery:robSpot6')
AddEventHandler('labrp-robbery:robSpot6',function()
    if robSpot6 then 
        exports['mythic_notify']:SendAlert('inform', 'Nothing here.', 5000)
    else
        robSpot6 = true
        weRobbinMayne()
    end
end)


function weRobbinMayne()
    local Loot = Config.Loot[math.random(#Config.Loot)] 
    local playerPed = PlayerPedId()
    FreezeEntityPosition(playerPed, true)
    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(6000)
    TriggerServerEvent('labrp-robbery:addItem', Loot, 1)
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false) 
end


RegisterNetEvent('labrp-robbery:carryObj')
AddEventHandler('labrp-robbery:carryObj',function()
    if hasProp then

    else
        hasProp = true
        TriggerServerEvent('labrp-robbery:addItem', 'tv')
        local playerPed = PlayerPedId()
        local bone = GetPedBoneIndex(playerPed, 0xE5F3)
        AttachEntityToEntity(PC, playerPed, bone, 0.0, 0.24, 0.10, 340.0, 330.0, 330.0, true, true, false, true, 1, true)
        exports['mythic_notify']:SendAlert('inform', 'If scuffed, type /dropProp to drop.', 5000)
        RequestAnimDict("anim@heists@box_carry@")
        while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
        TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
    end
end)

RegisterCommand('dropProp', function()
    if IsEntityAttached(PC) then
    DetachEntity(PC, nil, nil)
    DeleteObject(PC)
    ClearPedTasksImmediately(PlayerPedId())


local inventory = ESX.GetPlayerData().inventory
  local Item = 0
    for i=1, #inventory, 1 do
      if inventory[i].name == 'tv' then
        Item = inventory[i].count
      end
    end
      if Item > 0 then
        TriggerServerEvent('labrp-robbery:removeItem', 'tv')
      end

    hasProp = false
    end
end, false)


RegisterNetEvent('labrp-robbery:leaveHouse')
AddEventHandler('labrp-robbery:leaveHouse',function()
    SetEntityCoordsNoOffset(GetPlayerPed(-1), saveCoords.x, saveCoords.y, saveCoords.z)
    isInside = false
    exports['labrp_housing']:DespawnInterior(HouseData, function()
    HouseData, OffSets = nil, nil
    end)

    if hasProp then 
    local playerPed = PlayerPedId()
        while not IsEntityPlayingAnim(playerPed,'anim@heists@box_carry@','idle', 3) do
        RequestAnimDict("anim@heists@box_carry@")
        TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
        Wait(300)
        end
    end

end)

