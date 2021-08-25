ESX = nil
local FishingRod = false
local isFishing = false
local baitUsed = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function DeleteRod()
    local position = GetEntityCoords(PlayerPedId())
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 1.0, GetHashKey("prop_fishing_rod_01"), false, false, false)
    SetEntityAsMissionEntity(object, 1, 1)
    DeleteEntity(object)
    ClearPedTasks(PlayerPedId())
end


RegisterNetEvent('labrp_fish:start')
AddEventHandler('labrp_fish:start', function()
    print('start fishing')

    local pedc = GetEntityCoords(PlayerPedId())
    local boat = GetClosestVehicle(pedc.x, pedc.y, pedc.z, 5.0, 0, 12294)
    if IsEntityInWater(PlayerPedId()) or IsEntityInWater(boat) then
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if not IsPedSwimming(PlayerPedId()) then
                if not isFishing then
                    exports['mythic_notify']:SendAlert('inform', "You've started fishing, Use bait to catch a fish") 
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, true)
                    FishingRod = true
                    isFishing = true
                else
                    isFishing = false
                    FishingRod = false
                    baitUsed = false
                    DeleteRod()
                    exports['mythic_notify']:SendAlert('error', "You've stopped fishing") 
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You have to decide, whether you want to swim or fish') 
            end
        end
    else
        exports['mythic_notify']:SendAlert('error', 'I can´t fish here...') 
    end
end)

RegisterNetEvent('labrp_fish:usebait')
AddEventHandler('labrp_fish:usebait', function()
    if FishingRod then
        if not baitUsed then
            exports['mythic_notify']:SendAlert('inform', "Bait Used")
            TriggerServerEvent('labrp_fish:removebait')
            exports['mythic_progbar']:Progress({
                name = "unique_action_name",
                duration = 10000,
                label = 'Using Bait',
                useWhileDead = true,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
            })
            Citizen.Wait(10000)
            baitUsed = true
            Citizen.Wait(500)
            local catchRarity = math.random(1, 100)

            if catchRarity >= 80 then
                local finished = exports["reload-skillbar"]:taskBar(400,math.random(2,15))
                if finished ~= 100 then
                    exports['mythic_notify']:SendAlert('error', 'The Shark broke the line!')
                    baitUsed = false
                else
                    TriggerServerEvent('labrp_fish:getreward', 'Shark')
                    baitUsed = false
                end
            elseif catchRarity >= 60 and catchRarity < 80 then
                local finished = exports["reload-skillbar"]:taskBar(600,math.random(2,15))
                if finished ~= 100 then
                    exports['mythic_notify']:SendAlert('error', 'The Turtle broke the line!')
                    baitUsed = false
                else
                    TriggerServerEvent('labrp_fish:getreward', 'Turtle')
                    baitUsed = false
                end
            elseif catchRarity < 60 then
                local finished = exports["reload-skillbar"]:taskBar(1000,math.random(2,15))
                if finished ~= 100 then
                    exports['mythic_notify']:SendAlert('error', 'The fish broke the line!')
                    baitUsed = false
                else
                    TriggerServerEvent('labrp_fish:getreward', 'Fish')
                    baitUsed = false
                end
            end
        else
            exports['mythic_notify']:SendAlert('error', "There is already bait on the hook")
        end
    else
        exports['mythic_notify']:SendAlert('error', "You need a fishing rod out")
    end

end)


exports['labrp_Eye']:AddBoxZone("fish-illegal", vector3(-1846.958, -1190.796, 13.3172), 0.5, 0.5, {
	name="fish-illegal",
	heading=150,
	debugPoly=false,
    }, {
        options = {
            {
                event = 'labrp_fish:sellillegal',
                icon = 'fas fa-fish',
                label = 'Sell Fish'
            },

        },
    distance = 1.5
})

RegisterNetEvent('labrp_fish:sellillegal')
AddEventHandler('labrp_fish:sellillegal', function()
    TriggerServerEvent('labrp_fish:sellillegal')
end)

exports['labrp_Eye']:AddBoxZone("fish-sell", vector3(-3277.793, 969.9165, 8.335571), 0.5, 0.5, {
	name="fish-sell",
	heading=180,
	debugPoly=false,
    }, {
        options = {
            {
                event = 'labrp_fish:sell',
                icon = 'fas fa-fish',
                label = 'Sell Fish'
            },

        },
    distance = 1.5
})

RegisterNetEvent('labrp_fish:sell')
AddEventHandler('labrp_fish:sell', function()
    TriggerServerEvent('labrp_fish:sell')
end)


deliveryBlip = AddBlipForCoord(-3277.793, 969.9165, 8.335571)

SetBlipScale(deliveryBlip, 0.8)
SetBlipColour(deliveryBlip, 5)
SetBlipSprite(deliveryBlip, 356)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString('Sell Fish')
EndTextCommandSetBlipName(deliveryBlip)