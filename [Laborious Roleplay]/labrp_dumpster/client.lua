ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)














local dumspterModel = {
    218085040,
    666561306,
    -58485588,
    -206690185,
    1511880420,
    682791951,
}

exports['labrp_Eye']:AddTargetModel(dumspterModel, {
    options = {
        --[[{
            event = 'dumpsterGetIn',
            icon = 'fas fa-dumpster',
            label = 'Get in Dumpster',
            canInteract = function(entity)
                return true
            end
        },]]
        {
            event = 'dumpsterTrigger',
            icon = 'fas fa-dumpster',
            label = 'Search Dumpster',
            canInteract = function(entity)
                return true
            end
        },
    },
    job = {'all'},
    distance = 1.5
})


local Searched = {}
local InDumpster = false

function CheckSearch(dumpster)
    local dumpstermodel = dumpster.entity
    for k, v in ipairs(Searched) do
        if v == dumpstermodel then
            return true
        end
    end
    return false
end

--[[RegisterNetEvent('dumpsterGetIn')
AddEventHandler('dumpsterGetIn', function(data)
    local playerCoord = GetEntityCoords(PlayerPedId(-1))
    local dumpstermodel = data.entity
    print(dumpstermodel)
    local dumpCoords = GetEntityCoords(dumpstermodel)
    if not InDumpster then
        SetEntityCoords(PlayerPedId(-1), dumpCoords, false, false, false, true)
        SetEntityVisible(PlayerPedId(), false, 0)
        InDumpster = true
    else
        SetEntityCoords(PlayerPedId(-1), playerCoord, false, false, false, true)
        SetEntityVisible(PlayerPedId(), true, 0)
        InDumpster = false
    end
end)]]


RegisterNetEvent('dumpsterTrigger')
AddEventHandler('dumpsterTrigger', function(data)
    local dumpstermodel = data.entity
    print(dumpstermodel)
    if CheckSearch(data) then
        exports['mythic_notify']:SendAlert('error', "You've already searched this dumpster")
    else
        exports['mythic_notify']:SendAlert('inform', "Searching Dumpster")
        table.insert(Searched, dumpstermodel)
        TriggerEvent('dumpster:starttimer', dumpstermodel)
        SearchDumpster()
    end
end)

function SearchDumpster()
    local time = math.random(30000, 40000)
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = time,
        label = 'Searching Dumpster',
        useWhileDead = false,
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
    Citizen.Wait(time)
    ClearPedTasks(PlayerPedId(-1))
    TriggerServerEvent('dumpster:givereward')
end

RegisterNetEvent('dumpster:starttimer')
AddEventHandler('dumpster:starttimer', function(dumpster)
    local timer = 7 * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            for i = 1, #Searched do
                if Searched[i] == dumpster then
                    table.remove(Searched, i)
                end
            end
        end
    end
end)


--[[exports['labrp_Eye']:AddTargetBone({"platelight"}, {
    options = {
        {
            icon = "far fa-newspaper",
            label = "Check VIN",
            event = "police:checkvin",
            canInteract = function(entity)
                return true
            end
        },
    },
    distance = 1.0,
})

RegisterNetEvent('police:checkvin')
AddEventHandler('police:checkvin', function(data)
    local vehicle = data.entity
    local plate = GetVehicleNumberPlateText(vehicle)
    print(plate)
    TriggerServerEvent('vehiclegarage:checkvin', plate)
end)]]







































































local smashParkingMeter = {
    -1940238623,
    2108567945,
}

exports['labrp_Eye']:AddTargetModel(smashParkingMeter, {
    options = {
        {
            event = 'smashparkingmeter',
            icon = 'fas fa-hammer',
            label = 'Smash Parking Meter',
            canInteract = function(entity)
                return true
            end
        },
    },
    job = {'all'},
    distance = 1.5
})


local Smashed = {}

function CheckSmash(dumpster)
    local parkingmeter = dumpster.entity
    print(parkingmeter)
    for k, v in ipairs(Smashed) do
        if v == parkingmeter then
            return true
        end
    end
    return false
end

RegisterNetEvent('smashparkingmeter')
AddEventHandler('smashparkingmeter', function(data)
    local parkingmeter = data.entity
    if CheckSmash(data) then
        exports['mythic_notify']:SendAlert('error', "This has already been smashed")
    else
        exports['mythic_notify']:SendAlert('inform', "Smashing Meter")
        table.insert(Smashed, parkingmeter)
        TriggerServerEvent('parkingmeter:starttimer', parkingmeter)
        SmashMeter()
    end
end)

function SmashMeter()
    exports['mythic_progbar']:Progress({
        name = "smash parking meter",
        duration = 30000,
        label = 'Smashing Meter',
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@prop_human_bum_bin@base",
            anim = "base",
        },
    })
    Wait(30000)
    ClearPedTasks(PlayerPedId(-1))
    TriggerServerEvent('payparkingmeter')
end

RegisterNetEvent('meter:removemeter')
AddEventHandler('meter:removemeter', function(meter)
    table.remove(Smashed, meter)
end)


























RegisterNetEvent('payparkingmeter')
AddEventHandler('payparkingmeter', function()
    if cooldown == false then
        TriggerServerEvent('payparkingmeter')
    else
        exports['mythic_notify']:SendAlert('error', 'This has already been smashed!')
    end
end)




-- SIGN SMASH --


local smashSign = {
    -949234773,
    442297252,
    -1124643460,
    962570067,
    -2065375912,
    -582192764,
}

exports['labrp_Eye']:AddTargetModel(smashSign, {
    options = {
        {
            event = 'scrapsign',
            icon = 'fas fa-hammer',
            label = 'Scrap Sign'
        },
    },
    job = {'all'},
    distance = 1.5
})


local ped = GetPlayerPed(-1)

local signcooldown = false

RegisterNetEvent('scrapsign')
AddEventHandler('scrapsign', function()
    if signcooldown == false then
        exports['mythic_progbar']:Progress({
            name = "smash parking meter",
            duration = 30000,
            label = 'Scrapping Sign',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@prop_human_bum_bin@base",
                anim = "base",
            },
        })
        Wait(30000)
        ClearPedTasks(ped)
        TriggerEvent('payscrapsign')
        TriggerEvent('startsigncooldown')
    else
        exports['mythic_notify']:SendAlert('error', 'Uh Oh Action Unavailable!')
    end
    
end)


RegisterNetEvent('startsigncooldown')
AddEventHandler('startsigncooldown', function()
    signcooldown = true
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            cooldown = false
        end
    end

end)

RegisterNetEvent('payscrapsign')
AddEventHandler('payscrapsign', function()
    if signcooldown == false then
        TriggerServerEvent('payscrapsign')
    else
        exports['mythic_notify']:SendAlert('error', 'This has already been scrapped!')
    end
end)
