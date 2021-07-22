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
        inMission = true
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


Citizen.CreateThread(function()
    while true do
        if inMission == true then
            local blips2 = {
                -- Example {title="", colour=, id=, x=, y=, z=},
               {title="Chop Warehouse", colour=3, id=569, x = 1204.3165, y = -3115.9, z = 5.5},
            }
              
            Citizen.CreateThread(function()
              
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
            end)
        else
            RemoveBlip(blips2)
        end
        Citizen.Wait(1000000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped)
		local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1204.2, -3115.9, 5.5, true)
        if dist <= 5 then
            inMission = false
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while poggg do
        if IsControlPressed(0, 38) then
            inMission = false
            TriggerEvent('EnterChopVehicle')
            poggg = false
            TriggerServerEvent('removepapers')
        end
        Citizen.Wait(100)
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
