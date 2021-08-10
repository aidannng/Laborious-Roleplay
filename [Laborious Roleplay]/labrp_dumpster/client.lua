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
        TriggerEvent('meter:removemeter', parkingmeter)
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
    local timer = 7 * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            for i = 1, #Smashed do
                if Smashed[i] == meter then
                    table.remove(Smashed, i)
                end
            end
        end
    end
end)





-- SIGN SMASH --

local SmashedSign = {}

local smashSign = {
    966571283,
    749704633,
    -2018392280,
    -928289202,
    -582192764,
    -1547577184,
    1392401630,
    -133126160,
    1898279756,
    1803721002,
    768318833,
    1384097539,
    1212260769,
    -1914350933,
    -1853115340,
    240277467,
    -639994124,
    -9158461,
    -172481957,
    -249781228,
    -1798096217,
    1822452318,
    -2090002469,
    -290853289,
    -735074497,
    029303486,
    60777741,
    -488700007,
    995405207,
    -1721242988,
    -1293825,
    1509115140,
    -156356737,
    -1522620555,
    282735287,
    -1454939221,
    219009290,
    -1753555592,
    1502931467,
    793482617,
}

exports['labrp_Eye']:AddTargetModel(smashSign, {
    options = {
        {
            event = 'scrapsign',
            icon = 'fas fa-hammer',
            label = 'Scrap Sign',
            canInteract = function(entity)
                return true
            end
        },
    },
    job = {'all'},
    distance = 1.5
})


function CheckSign(data)
    local sign = data.entity
    for k, v in ipairs(SmashedSign) do
        if v == sign then
            return true
        end
    end
    return false
end

RegisterNetEvent('scrapsign')
AddEventHandler('scrapsign', function(data)
    local sign = data.entity
    if CheckSign(data) then
        exports['mythic_notify']:SendAlert('error', "This has already been scrapped")
    else
        exports['mythic_notify']:SendAlert('inform', "Scrapping Sign")
        table.insert(SmashedSign, sign)
        TriggerEvent('sign:removesign', sign)
        ScrapSign()
    end
end)

RegisterNetEvent('sign:removesign')
AddEventHandler('sign:removesign', function(sign)
    local timer = 7 * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            for i = 1, #SmashedSign do
                if SmashedSign[i] == sign then
                    table.remove(SmashedSign, i)
                end
            end
        end
    end
end)


function ScrapSign()
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
            animDict = "amb@world_human_hammering@male@base",
            anim = "base",
        },
    })
    Wait(30000)
    ClearPedTasks(PlayerPedId(-1))
    TriggerServerEvent('payscrapsign')
end