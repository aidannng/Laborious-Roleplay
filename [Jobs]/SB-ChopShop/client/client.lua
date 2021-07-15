ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
    local chopshop = {
        `s_m_y_dealer_01`,
        }
        exports["labrp_Eye"]:AddTargetModel(chopshop, {
        options = {
        {
            event = "ChopCarPaper",
            icon = "fas fa-clipboard-list",
            label = "Get Car Papers",
        },
        },
        job = {"all"},
        distance = 2.5
    }) 
end)

local canChop = true
local missionProgress = false

RegisterNetEvent('ChopCarPaper')
AddEventHandler('ChopCarPaper', function()
    if canChop == true then
        canChop = false
        exports['mythic_progbar']:Progress({
            name = "unique_action_name",
            duration = 10000,
            label = 'Getting Chop Papers',
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missheistdockssetup1clipboard@idle_a",
                anim = "idle_a",
            },
            prop = {
                model = "prop_fib_clipboard",
            }
        })
	    Citizen.Wait(10000)
        ClearPedTasks(PlayerPedId(-1))
        TriggerServerEvent('givechoppaper')
    else
        exports['mythic_notify']:SendAlert('error', 'No Cars Available!')
    end
end)


RegisterNetEvent('resetchop')
AddEventHandler('resetchop', function()
    Citizen.Wait(1500000)
    canChop = true
end)

local ChopSpawn = 0

RegisterNetEvent('CarPapers')
AddEventHandler('CarPapers', function(car)
    print(car)
    exports['mythic_notify']:SendAlert('inform', "I've marked the area the car should be in, Find it then bring it to my warehouse at the docks!", 6500)
    local hash = GetHashKey(car)
    local spawncar = Config.SpawnCar[math.random(1, #Config.SpawnCar)]
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    ChopSpawn = CreateVehicle(hash, spawncar.x, spawncar.y, spawncar.z, 1, 1)
           
    zoneblip = AddBlipForRadius(spawncar.x+math.random(25, 75), spawncar.y+math.random(25, 75), spawncar.z, 250.0)
    SetBlipSprite(zoneblip,9)
    SetBlipColour(zoneblip,3)
    SetBlipAlpha(zoneblip,75)
    missionProgress = true
    --[[Citizen.Wait(10000)
    RemoveBlip(zoneblip)
    print('zone removed')]]
end)

local pog = false
local pogg = false
local poggg = false
local closetoVehicle = false

Citizen.CreateThread(function()
    while not pog do
        local current = GetVehiclePedIsIn(PlayerPedId(), false)
        local hash = GetHashKey(current)
        local newHash = GetHashKey(ChopSpawn)
        if closetoVehicle and hash == newHash then
            exports['mythic_notify']:SendAlert('inform', 'Now delivery this to my warehouse at the docks!')
            pog = true
            RemoveBlip(zoneblip)
            BLIP_1 = AddBlipForCoord(1204.497, -3117.297, 5.538452)
            SetBlipRoute(BLIP_1,true) -- waypoint to blip
        end
        Citizen.Wait(500)
    end
    while not pogg do
        local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped)
		local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1204.497, -3117.297, 5.538452, true)
        if dist <= 5 then
            ClearGpsCustomRoute()
            exports['mythic_notify']:SendAlert('inform', 'Press [E] to Chop Vehicle', 15000)
            pogg = true
            ClearAllBlipRoutes()
            RemoveBlip(BLIP_1)
            poggg = true
        end
        Citizen.Wait(500)
    end
    while poggg do
        if IsControlPressed(0, 38) then
            TriggerEvent('EnterChopVehicle')
            poggg = false
            TriggerServerEvent('removepapers')
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('EnterChopVehicle')
AddEventHandler('EnterChopVehicle', function()
    local current = GetVehiclePedIsIn(PlayerPedId(), false)
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 30000,
        label = 'Chopping Vehicle',
        useWhileDead = true,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })
    Citizen.Wait(30000)
    DeleteEntity(current)
    TriggerServerEvent('choppayout')
end)
