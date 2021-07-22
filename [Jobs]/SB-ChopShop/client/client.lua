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
local inMission = false
local pogg = false
local poggg = false

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
        inMission = true
        ClearPedTasks(PlayerPedId(-1))
        TriggerServerEvent('givechoppaper')
        TriggerEvent('chop:blip')
    else
        exports['mythic_notify']:SendAlert('error', 'No Cars Available!')
    end
end)


RegisterNetEvent('resetchop')
AddEventHandler('resetchop', function()
    Citizen.Wait(1500000)
    canChop = true
end)


RegisterNetEvent('chop:blip')
AddEventHandler('chop:blip', function()
    if inMission == true then
        local blips2 = {
                -- Example {title="", colour=, id=, x=, y=, z=},
            {title="Chop Warehouse", colour=3, id=569, x = 1204.3165, y = -3115.9, z = 5.5},
        }
              
              
        for _, info in pairs(blips2) do
            info.blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.blip, info.id)
            SetBlipDisplay(info.blip, 4)
            SetBlipScale(info.blip, 0.8)
            SetBlipColour(info.blip, info.colour)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(info.title)
            EndTextCommandSetBlipName(info.blip)
        end
    else
        RemoveBlip(blips2)
    end
end)

local vehiclename = nil
local chopname = nil
local test = true
local name = 0

Citizen.CreateThread(function()
    while test do
        local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped)
		local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1204.2, -3115.9, 5.5, true)



        local vehicle = GetVehiclePedIsIn(ped, false)
        local model = GetEntityModel(vehicle)

        if dist <= 5 and model == chopname then
            poggg = true
            exports['mythic_notify']:SendAlert('error', 'Press [E] to chop car')
            test = false
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if poggg == true then
            if IsControlPressed(0, 38) then
                TriggerEvent('EnterChopVehicle')
                poggg = false
                TriggerServerEvent('removepapers')
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('CarPapers')
AddEventHandler('CarPapers', function(car)
    chopname = GetHashKey(car)
    print(chopname)
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
    inMission = false
    TriggerEvent('chop:blip')
    DeleteEntity(current)
    TriggerServerEvent('choppayout')
end)
