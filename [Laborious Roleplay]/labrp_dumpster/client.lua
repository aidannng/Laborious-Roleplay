ESX = nil

local searched = {3423423424}
local canSearch = true
local dumpsters = {218085040, 666561306, -58485588, -206690185, 1511880420, 682791951}
local searchTime = 0
local dumpsterTrigger = false
local ped = GetPlayerPed(-1)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)




Citizen.CreateThread(function()
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
            {
                event = 'dumpsterTrigger',
                icon = 'fas fa-dumpster',
                label = 'Search Dumpster'
            },
        },
        job = {'all'},
        distance = 1.5
    })
end)

RegisterNetEvent('dumpsterTrigger')
AddEventHandler('dumpsterTrigger', function()
    dumpsterTrigger = true
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if canSearch then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local dumpsterFound = false

            for i = 1, #dumpsters do
                local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
                local dumpPos = GetEntityCoords(dumpster)

                if dumpsterTrigger == true then
                    for i = 1, #searched do
                        if searched[i] == dumpster then
                            dumpsterFound = true
                        end
                        if i == #searched and dumpsterFound then
                            exports['mythic_notify']:SendAlert('error', 'This dumpster has already been searched')
                            dumpsterTrigger = false
                        elseif i == #searched and not dumpsterFound then
                            exports['mythic_notify']:SendAlert('inform', 'You begin to search the dumpster')
                            startSearching(searchTime, 'amb@prop_human_bum_bin@base', 'base', 'stv:giveDumpsterReward')
                            TriggerServerEvent('stv:startDumpsterTimer', dumpster)
                            table.insert(searched, dumpster)
                            dumpsterTrigger = false
                        end
                    end
                end
            end
        end
    end
end)



RegisterNetEvent('stv:removeDumpster')
AddEventHandler('stv:removeDumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

-- Functions

function startSearching(time, dict, anim, cb)
    local animDict = dict
    local animation = anim
    local ped = GetPlayerPed(-1)

    canSearch = false

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    --exports['progressBars']:startUI(time, "Searching Dumpster") 
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 30000,
        label = 'Searching Dumpster',
        useWhileDead = true,
        canCancel = false,
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
    Citizen.Wait(30000)
    DisableControlAction(0, 245) --309
    DisableControlAction(0, 309)
    local ped = GetPlayerPed(-1)

    Wait(time)
    ClearPedTasks(ped)
    canSearch = true
    TriggerServerEvent(cb)
end





Citizen.CreateThread(function()
    local smashParkingMeter = {
        -1940238623,
        2108567945,
    }

    exports['labrp_Eye']:AddTargetModel(smashParkingMeter, {
        options = {
            {
                event = 'smashparkingmeter',
                icon = 'fas fa-hammer',
                label = 'Smash Parking Meter'
            },
        },
        job = {'all'},
        distance = 1.5
    })
end)

local cooldown = false

RegisterNetEvent('smashparkingmeter')
AddEventHandler('smashparkingmeter', function()
    if cooldown == false then
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
        ClearPedTasks(ped)
        TriggerEvent('payparkingmeter')
        TriggerEvent('startcooldown')
    else
        exports['mythic_notify']:SendAlert('error', 'Uh Oh Action Unavailable!')
    end
    
end)

RegisterNetEvent('startcooldown')
AddEventHandler('startcooldown', function()
    cooldown = true
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            cooldown = false
        end
    end

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

Citizen.CreateThread(function()
    --local smashSign = {
    --[[-949234773,
        442297252,
        -1124643460,
        962570067,
        -2065375912,
        966571283,
        -2018392280,
        -582192764,
        -1547577184
        1392401630,
        -133126160,
        156945028
    --]]
    --}
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
end)

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
