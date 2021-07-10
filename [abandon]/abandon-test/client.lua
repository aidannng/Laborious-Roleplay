ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterCommand("vehicle",
    function(source, args)
        local playerPed = PlayerPedId()
        if args[1] == "upgrade"  then
            local vehicle = GetVehiclePedIsIn(playerPed, not IsPedInAnyVehicle(playerPed, false))
            local props = ESX.Game.GetVehicleProperties(vehicle)
            if args[2] == "primary" then
                local upgrades = {
                    modEngine = 3,
                    modTurbo = true,
                    modTransmission = 2
                }
                ESX.Game.SetVehicleProperties(vehicle, upgrades)
                print('Maxed Engine, Turbo, and Transmission')
                exports['mythic_notify']:SendAlert('inform', 'Updated car') 
            else
                local k = args[2]
                local v = args[3]
                if setContains(props, k) then
                    local upgrades = {}
                    if type(props[k]) == "boolean" then
                        if v == 'true' then
                          upgrades[k] = true
                        else
                            upgrades[k] = false
                        end
                    elseif type(props[k]) == "number" then
                        upgrades[k] = tonumber(v)
                    end
                    ESX.Game.SetVehicleProperties(vehicle, upgrades)
                    local newprops = ESX.Game.GetVehicleProperties(vehicle)
                    print(k .. " = " .. tostring(newprops[k]))
                    exports['mythic_notify']:SendAlert('inform', 'Updated car') 
                else 
                exports['mythic_notify']:SendAlert('error', 'No upgrade by the name ' .. k .. ' was found') 
                end
            end
        elseif args[1] == "fix"  then
            local vehicle = GetVehiclePedIsIn(playerPed, not IsPedInAnyVehicle(playerPed, false))
            SetVehicleEngineHealth(vehicle, 1000)
            SetVehicleEngineOn( vehicle, true, true )
            SetVehicleFixed(vehicle)
            exports['mythic_notify']:SendAlert('inform', 'Fixed car') 
        elseif args[1] == "topspeed"  then
            local vehicle = GetVehiclePedIsIn(playerPed, not IsPedInAnyVehicle(playerPed, false))
            local top = tonumber(args[2])
            ModifyVehicleTopSpeed(vehicle, top)
            exports['mythic_notify']:SendAlert('inform', 'Updated car modifications') 
            print('Top Speed: ' .. GetVehicleTopSpeedModifier(vehicle))
            exports['mythic_notify']:SendAlert('inform', 'Top Speed: ' .. GetVehicleTopSpeedModifier(vehicle)) 
        elseif args[1] == "upgradedef"  then
            local vehicle = GetVehiclePedIsIn(playerPed, not IsPedInAnyVehicle(playerPed, false))
            ESX.Game.SetVehicleProperties(vehicle, {
                modTurbo = True,
                modEngine = 3,
            })
            exports['mythic_notify']:SendAlert('inform', 'Updated car modifications') 
            print('Top Speed: ' .. GetVehicleTopSpeedModifier(vehicle))
            exports['mythic_notify']:SendAlert('inform', 'Top Speed: ' .. GetVehicleTopSpeedModifier(vehicle)) 
        elseif args[1] == "checkall" then
            local vehicle = GetVehiclePedIsIn(playerPed, not IsPedInAnyVehicle(playerPed, false))
            local props = ESX.Game.GetVehicleProperties(vehicle)
            for k,v in pairs(props) do
                if type(v) == "boolean" then
                    if v == true then
                        print(k .. ': True')
                        exports['mythic_notify']:SendAlert('inform', k .. ': True')
                    else
                        print(k .. ': False')
                        exports['mythic_notify']:SendAlert('inform', k .. ': False')
                    end
                elseif type(v) == "table" then
                    for sk,sv in pairs(v) do
                        if type(sv) == "boolean" then
                            if sv == true then
                                print(sk .. ': True')
                                exports['mythic_notify']:SendAlert('inform', sk .. ': True')
                            else
                                print(sk .. ': False')
                                exports['mythic_notify']:SendAlert('inform', sk .. ': False')
                            end
                        else
                            print(sk .. ': ' .. sv)
                            exports['mythic_notify']:SendAlert('inform', sk .. ': ' .. sv) 
                        end
                    end
                else
                    print(k .. ': ' .. v)
                    exports['mythic_notify']:SendAlert('inform', k .. ': ' .. v) 
                end
            end
        elseif args[1] == "check" then
            local vehicle = GetVehiclePedIsIn(playerPed, not IsPedInAnyVehicle(playerPed, false))
            local props = ESX.Game.GetVehicleProperties(vehicle)
            local value = args[2]
            if setContains(props, value) then
                local v = props[value]
                if type(v) == "boolean" then
                    if v == true then
                        print(value .. ': True')
                        exports['mythic_notify']:SendAlert('inform', value .. ': True')
                    else
                        print(value .. ': False')
                        exports['mythic_notify']:SendAlert('inform', value .. ': False')
                    end
                elseif type(v) == "table" then
                    for sk,sv in pairs(v) do
                        if type(sv) == "boolean" then
                            if sv == true then
                                print(sk .. ': True')
                                exports['mythic_notify']:SendAlert('inform', sk .. ': True')
                            else
                                print(sk .. ': False')
                                exports['mythic_notify']:SendAlert('inform', sk .. ': False')
                            end
                        else
                            print(sk .. ': ' .. sv)
                            exports['mythic_notify']:SendAlert('inform', sk .. ': ' .. sv) 
                        end
                    end
                else
                    print(value .. ': ' .. v)
                    exports['mythic_notify']:SendAlert('inform', value .. ': ' .. v) 
                end
            else 
                exports['mythic_notify']:SendAlert('error', 'No upgrade by the name ' .. value .. ' was found') 
            end
        end
    end
)

function setContains(set, key)
    return set[key] ~= nil
end