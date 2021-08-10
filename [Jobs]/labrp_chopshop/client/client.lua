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
local car = nil

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
        TriggerEvent('ChopShop:resetchop')
    else
        exports['mythic_notify']:SendAlert('error', 'Try Again Later!')
    end
end)

RegisterNetEvent('ChopShop:BeginChop')
AddEventHandler('ChopShop:BeginChop', function(vehicle)
    local currentVehicle = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle.entity)))
    if car == currentVehicle then
        TriggerServerEvent('removepapers')
        exports['mythic_progbar']:Progress({
            name = "unique_action_name",
            duration = 30000,
            label = 'Chopping Car',
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
            },
        })
        Citizen.Wait(30000)
        ClearPedTasks(PlayerPedId(-1))
        DeleteEntity(vehicle.entity)
        TriggerServerEvent('choppayout')
        inMission = false
    else
        exports['mythic_notify']:SendAlert('error', 'Invalid Vehicle!')
    end
end)


RegisterNetEvent('ChopShop:resetchop')
AddEventHandler('ChopShop:resetchop', function()
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            canChop = true
            print('ChopShop Cooldown : Off')
        end
    end
end)



Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("chopshop", vector3(1204.391, -3116.967, 5.538452), 15.0, 10.0, {
        name="chopshop",
        heading=90,
        debugPoly=false,
    })
end)

local inChopLocation = false

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "chopshop" then
        exports['labrp_Eye']:Vehicle({
            options = {
                {
                    event = "ChopShop:BeginChop",
                    icon = "fas fa-screwdriver",
                    label = "Chop Car",
                    canInteract = function(entity)
                        hasChecked = false
                        if inMission and not hasChecked then
                            hasChecked = true
                            return true
                        end
                    end
                },
            },
            distance = 2.5,
        })
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "chopshop" then
        exports['labrp_Eye']:RemoveVehicle({
            'Chop Car',
        })
    end
end)

RegisterNetEvent('CarPapers')
AddEventHandler('CarPapers', function(newcar)
    car = string.lower(newcar)
    print(car)
end)
