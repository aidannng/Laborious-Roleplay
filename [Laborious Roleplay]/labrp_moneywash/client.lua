ESX = nil

local PlayerData = {}
local BlackMoneyAmount = 0

Type = nil
usedLaundryCard = false
startedWashing = false
WashingTime = nil
hasWashed = false
BLaundry1 = false
ULaundry1 = false
BLaundry2 = false
ULaundry2 = false
BLaundry3 = false
ULaundry3 = false
BLaundry4 = false
ULaundry4 = false
timer = icfg.Timer
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent('inside-moneywash:getBusyLaundry')
    ESX.TriggerServerCallback('inside-moneywash:lastDrivers', function(Drivers)
        actDrivers = Drivers
        print(actDrivers)
    end)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 1000

        Citizen.Wait(sleep)
        if WashingTime ~= nil then
            if WashingTime > 0 then
                WashingTime = WashingTime - 1
            elseif WashingTime == 0 then
                hasWashed = true
                WashingTime = nil
                exports['mythic_notify']:SendAlert('inform', "Your Laundry is ready!")
            end
        end
        if hasWashed then
            if timer > 0 then
                timer = timer - 1
                if timer == 0 then
                    exports['mythic_notify']:SendAlert('inform', "You didn't take Laundry out of Washing Machine, you lose your Laundry Card and Washed Money!")
                    startedWashing = false
                    usedLaundryCard = false
                    hasWashed = false
                    timer = icfg.Timer
                    if ULaundry1 then
                        TriggerServerEvent('inside-moneywash:unlockLaundry1')
                        ULaundry1 = false
                    elseif ULaundry2 then
                        TriggerServerEvent('inside-moneywash:unlockLaundry2')
                        ULaundry2 = false
                    elseif ULaundry3 then
                        TriggerServerEvent('inside-moneywash:unlockLaundry3')
                        ULaundry3 = false
                    elseif ULaundry4 then
                        TriggerServerEvent('inside-moneywash:unlockLaundry4')
                        ULaundry4 = false
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)


            if hasWashed then
                sleep = 5
                DrawText2Ds(0.5, 0.95, 'You have ~b~' ..timer.. '~s~ seconds to take Laundry out of Washing Machine', 0.35)
            end
            if not ULaundry2 and not ULaundry3 and not ULaundry4 then
                if not BLaundry1 then
                    if (#(coords - vector3(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z)) < 0.6) then
                        sleep = 5
                        DrawText3Ds(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                        DrawMarker(25, icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        if IsControlJustReleased(0, Keys["E"]) then
                            Type = 'Laundry1'
                            OpenLaundryMenu()
                        end
                    elseif (#(coords - vector3(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        DrawMarker(29, icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 75, false, true, 2, false, false, false, false)
                    end
                elseif BLaundry1 then
                    if (#(coords - vector3(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z)) < 0.6) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 100, false, true, 2, false, false, false, false)
                        if ULaundry1 then
                            if not startedWashing then
                                DrawText3Ds(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    Type = 'Laundry1'
                                    OpenLaundryMenu()
                                end
                            elseif startedWashing then
                                if hasWashed then
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.35, "~g~Money~s~ is ready to be pulled out")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        Type = 'Laundry1'
                                        OpenLaundryMenu()
                                    end
                                elseif WashingTime > 0 then
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.5, "Washing Black Money: ~r~" ..BlackMoneyAmount.. "$~s~")
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.35, "Remaining time: ~g~" ..WashingTime.. " sec~s~")
                                end
                            end
                        else
                            DrawText3Ds(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.5, "Someone's Laundry Card is already Connected")
                        end
                    elseif (#(coords - vector3(icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 100, false, true, 2, false, false, false, false)
                        DrawMarker(29, icfg.LaundryPlaces.Laundry1.Pos.x, icfg.LaundryPlaces.Laundry1.Pos.y, icfg.LaundryPlaces.Laundry1.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 75, false, true, 2, false, false, false, false)
                    end
                end
            end

            if not ULaundry1 and not ULaundry3 and not ULaundry4 then
                if not BLaundry2 then
                    if (#(coords - vector3(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z)) < 0.6) then
                        sleep = 5
                        DrawText3Ds(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                        DrawMarker(25, icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        if IsControlJustReleased(0, Keys["E"]) then
                            Type = 'Laundry2'
                            OpenLaundryMenu()
                        end
                    elseif (#(coords - vector3(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        DrawMarker(29, icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 75, false, true, 2, false, false, false, false)
                    end
                elseif BLaundry2 then
                    if (#(coords - vector3(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z)) < 0.6) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 100, false, true, 2, false, false, false, false)
                        if ULaundry2 then
                            if not startedWashing then
                                DrawText3Ds(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    Type = 'Laundry2'
                                    OpenLaundryMenu()
                                end
                            elseif startedWashing then
                                if hasWashed then
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.35, "~g~Money~s~ is ready to be pulled out")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        Type = 'Laundry2'
                                        OpenLaundryMenu()
                                    end
                                elseif WashingTime > 0 then
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.5, "Washing Black Money: ~r~" ..BlackMoneyAmount.. "$~s~")
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.35, "Remaining time: ~g~" ..WashingTime.. " sec~s~")
                                end
                            end
                        else
                            DrawText3Ds(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.5, "Someone's Laundry Card is already Connected")
                        end
                    elseif (#(coords - vector3(icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 100, false, true, 2, false, false, false, false)
                        DrawMarker(29, icfg.LaundryPlaces.Laundry2.Pos.x, icfg.LaundryPlaces.Laundry2.Pos.y, icfg.LaundryPlaces.Laundry2.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 75, false, true, 2, false, false, false, false)
                    end
                end
            end

            if not ULaundry1 and not ULaundry2 and not ULaundry4 then
                if not BLaundry3 then
                    if (#(coords - vector3(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z)) < 0.6) then
                        sleep = 5
                        DrawText3Ds(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                        DrawMarker(25, icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        if IsControlJustReleased(0, Keys["E"]) then
                            Type = 'Laundry3'
                            OpenLaundryMenu()
                        end
                    elseif (#(coords - vector3(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        DrawMarker(29, icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 75, false, true, 2, false, false, false, false)
                    end
                elseif BLaundry3 then
                    if (#(coords - vector3(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z)) < 0.6) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 100, false, true, 2, false, false, false, false)
                        if ULaundry3 then
                            if not startedWashing then
                                DrawText3Ds(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    Type = 'Laundry3'
                                    OpenLaundryMenu()
                                end
                            elseif startedWashing then
                                if hasWashed then
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.35, "~g~Money~s~ is ready to be pulled out")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        Type = 'Laundry3'
                                        OpenLaundryMenu()
                                    end
                                elseif WashingTime > 0 then
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.5, "Washing Black Money: ~r~" ..BlackMoneyAmount.. "$~s~")
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.35, "Remaining time: ~g~" ..WashingTime.. " sec~s~")
                                end
                            end
                        else
                            DrawText3Ds(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.5, "Someone's Laundry Card is already Connected")
                        end
                    elseif (#(coords - vector3(icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 100, false, true, 2, false, false, false, false)
                        DrawMarker(29, icfg.LaundryPlaces.Laundry3.Pos.x, icfg.LaundryPlaces.Laundry3.Pos.y, icfg.LaundryPlaces.Laundry3.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 75, false, true, 2, false, false, false, false)
                    end
                end
            end

            if not ULaundry1 and not ULaundry2 and not ULaundry3 then
                if not BLaundry4 then
                    if (#(coords - vector3(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z)) < 0.6) then
                        sleep = 5
                        DrawText3Ds(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                        DrawMarker(25, icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        if IsControlJustReleased(0, Keys["E"]) then
                            Type = 'Laundry4'
                            OpenLaundryMenu()
                        end
                    elseif (#(coords - vector3(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        DrawMarker(29, icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 75, false, true, 2, false, false, false, false)
                    end
                elseif BLaundry4 then
                    if (#(coords - vector3(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z)) < 0.6) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 100, false, true, 2, false, false, false, false)
                        if ULaundry4 then
                            if not startedWashing then
                                DrawText3Ds(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    Type = 'Laundry4'
                                    OpenLaundryMenu()
                                end
                            elseif startedWashing then
                                if hasWashed then
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.5, "Press [~g~E~s~] to interact with Washing Mashine")
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.35, "~g~Money~s~ is ready to be pulled out")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        Type = 'Laundry4'
                                        OpenLaundryMenu()
                                    end
                                elseif WashingTime > 0 then
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.5, "Washing Black Money: ~r~" ..BlackMoneyAmount.. "$~s~")
                                    DrawText3Ds(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.35, "Remaining time: ~g~" ..WashingTime.. " sec~s~")
                                end
                            end
                        else
                            DrawText3Ds(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.5, "Someone's Laundry Card is already Connected")
                        end
                    elseif (#(coords - vector3(icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 100, false, true, 2, false, false, false, false)
                        DrawMarker(29, icfg.LaundryPlaces.Laundry4.Pos.x, icfg.LaundryPlaces.Laundry4.Pos.y, icfg.LaundryPlaces.Laundry4.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 150, 10, 0, 75, false, true, 2, false, false, false, false)
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

function OpenLaundryMenu()

    local elements = {}

    if not usedLaundryCard then
        table.insert(elements, {label = 'Put Laundry Card', value = 'PutCard'})
    elseif usedLaundryCard then
        if not hasWashed then
            table.insert(elements, {label = 'Wash Black Money', value = 'WashBlackMoney'})
            table.insert(elements, {label = 'Pull Out Laundry Card', value = 'PullOutCard'})
        elseif hasWashed then
            table.insert(elements, {label = 'Pull Out Money', value = 'PullOutMoney'})
        end
    end
    FreezeEntityPosition(PlayerPedId(), true)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'laundrymenu', {
			title    = 'Washing Machine',
			align    = 'center',
            elements = elements,
            }, 
            function(data, menu)
            FreezeEntityPosition(PlayerPedId(), false)
            ESX.UI.Menu.CloseAll()
			if data.current.value == 'PutCard' then
                ESX.TriggerServerCallback('inside-moneywash:checkLaundryCard', function(hasCard)
                    if hasCard then
                        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
                        exports['mythic_progbar']:Progress({
                            name = "unique_action_name",
                            duration = 2500,
                            label = 'Inserting Laundry Card...',
                            useWhileDead = true,
                            canCancel = false,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                        })
                        Citizen.Wait(2000)
                        ClearPedTasksImmediately(PlayerPedId())
                        if Type == "Laundry1" then
                            TriggerServerEvent('inside-moneywash:blockLaundry1')
                            ULaundry1 = true
                        elseif Type == "Laundry2" then
                            TriggerServerEvent('inside-moneywash:blockLaundry2')
                            ULaundry2 = true
                        elseif Type == "Laundry3" then
                            TriggerServerEvent('inside-moneywash:blockLaundry3')
                            ULaundry3 = true
                        elseif Type == "Laundry4" then
                            TriggerServerEvent('inside-moneywash:blockLaundry4')
                            ULaundry4 = true
                        end
                        usedLaundryCard = true
                        exports['mythic_notify']:SendAlert('inform', "Card connected!")
                    else
                        exports['mythic_notify']:SendAlert('inform', "You don't have Laundry Card")
                    end
                end)
			end
            if data.current.value == 'PullOutCard' then
                if usedLaundryCard then
                    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
                    exports['mythic_progbar']:Progress({
                        name = "unique_action_name",
                        duration = 3000,
                        label = 'Removing Laundry Card...',
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                    })
                    Citizen.Wait(3000)
                    ClearPedTasksImmediately(PlayerPedId())
                    usedLaundryCard = false
                    exports['mythic_notify']:SendAlert('inform', "Card disconnected!")
                    TriggerServerEvent('inside-moneywash:returnLaundryCard')
                    Citizen.Wait(100)
                    if Type == "Laundry1" then
                        TriggerServerEvent('inside-moneywash:unlockLaundry1')
                        ULaundry1 = false
                    elseif Type == "Laundry2" then
                        TriggerServerEvent('inside-moneywash:unlockLaundry2')
                        ULaundry2 = false
                    elseif Type == "Laundry3" then
                        TriggerServerEvent('inside-moneywash:unlockLaundry3')
                        ULaundry3 = false
                    elseif Type == "Laundry4" then
                        TriggerServerEvent('inside-moneywash:unlockLaundry4')
                        ULaundry4 = false
                    end
                end
            end
            if data.current.value == 'WashBlackMoney' then --- You putting Black Money into Washing Machine...
                exports['mythic_progbar']:Progress({
                    name = "unique_action_name",
                    duration = 2500,
                    label = 'Putting Money into Washing Machine',
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                })
                Citizen.Wait(2000)
                ClearPedTasksImmediately(PlayerPedId())
                ESX.TriggerServerCallback('inside-moneywash:LoadBlackMoney', function(AmountToWash)
                    WashingTime = math.random(icfg.MinWashingTime, icfg.MaxWashingTime)
                    BlackMoneyAmount = AmountToWash
                    startedWashing = true
                end)
            end
            if data.current.value == 'PullOutMoney' then
                ClearPedTasksImmediately(PlayerPedId())
                TriggerServerEvent('inside-moneywash:GetWashedMoney')
                startedWashing = false
                hasWashed = false
            end
		end, function(data, menu)
			menu.close()
            FreezeEntityPosition(PlayerPedId(), false)
		end)
end
-- Washing Machine

actDrivers = 0
startedWork = false
startedDelivery = false
hasCar = false
Plate = nil
DeliveryPlace = nil
NowWorking = false

RegisterNetEvent('inside-moneywash:startLaundering')
AddEventHandler('inside-moneywash:startLaundering', function()
    actDrivers = actDrivers + 1
end)

RegisterNetEvent('inside-moneywash:stopLaundering')
AddEventHandler('inside-moneywash:stopLaundering', function()
    actDrivers = actDrivers - 1
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(ped)

            if not startedWork then
                if (#(coords - vector3(icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z)) < 0.6) then
                    sleep = 5
                    DrawMarker(25, icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 148, 148, 148, 100, false, true, 2, false, false, false, false)
                    if actDrivers < icfg.MaxDrivers then
                        DrawText3Ds(icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z + 0.8, "Press [~g~E~s~] to start interact with Auto Repairs")
                        if IsControlJustReleased(0, Keys["E"]) then
                            OpenLaunderingMenu()
                        end
                    else
                        DrawText3Ds(icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z + 0.8, "All vehicles are currently seized [~r~" ..actDrivers.. "~s~/~r~" ..icfg.MaxDrivers.. "~s~]")
                    end
                elseif (#(coords - vector3(icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z)) < 8.0) then
                    sleep = 5
                    DrawMarker(25, icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 148, 148, 148, 100, false, true, 2, false, false, false, false)
                    DrawMarker(36, icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 148, 148, 148, 75, false, true, 2, false, false, false, false)
                end
            elseif startedWork then
                if (#(coords - vector3(icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z)) < 0.6) then
                    sleep = 5
                    DrawMarker(25, icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                    DrawText3Ds(icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z + 0.8, "Press [~g~E~s~] to start interact with Auto Repairs")
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenLaunderingMenu()
                    end
                elseif (#(coords - vector3(icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z)) < 8.0) then
                    sleep = 5
                    DrawMarker(25, icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                    DrawMarker(36, icfg.LaundererPlaces.Base.Pos.x, icfg.LaundererPlaces.Base.Pos.y, icfg.LaundererPlaces.Base.Pos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 75, false, true, 2, false, false, false, false)
                end
                if startedDelivery then
                    if (#(coords - vector3(icfg.LaundererPlaces.Garage.ChoosePos.x, icfg.LaundererPlaces.Garage.ChoosePos.y, icfg.LaundererPlaces.Garage.ChoosePos.z)) < 0.6) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundererPlaces.Garage.ChoosePos.x, icfg.LaundererPlaces.Garage.ChoosePos.y, icfg.LaundererPlaces.Garage.ChoosePos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        if not hasCar then
                            DrawText3Ds(icfg.LaundererPlaces.Garage.ChoosePos.x, icfg.LaundererPlaces.Garage.ChoosePos.y, icfg.LaundererPlaces.Garage.ChoosePos.z + 0.8, "Press [~g~E~s~] to start interact with Garage")
                            if IsControlJustReleased(0, Keys["E"]) then
                                OpenGarageMenu()
                            end
                        elseif hasCar then
                            DrawText3Ds(icfg.LaundererPlaces.Garage.ChoosePos.x, icfg.LaundererPlaces.Garage.ChoosePos.y, icfg.LaundererPlaces.Garage.ChoosePos.z + 0.8, "You have a currently ~r~pulled out~s~ Vehicle")
                        end
                    elseif (#(coords - vector3(icfg.LaundererPlaces.Garage.ChoosePos.x, icfg.LaundererPlaces.Garage.ChoosePos.y, icfg.LaundererPlaces.Garage.ChoosePos.z)) < 8.0) then
                        sleep = 5
                        DrawMarker(25, icfg.LaundererPlaces.Garage.ChoosePos.x, icfg.LaundererPlaces.Garage.ChoosePos.y, icfg.LaundererPlaces.Garage.ChoosePos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                        DrawMarker(39, icfg.LaundererPlaces.Garage.ChoosePos.x, icfg.LaundererPlaces.Garage.ChoosePos.y, icfg.LaundererPlaces.Garage.ChoosePos.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 30, 224, 20, 75, false, true, 2, false, false, false, false)
                    end
                    if IsPedInAnyVehicle(ped, false) then
                        if (#(coords - vector3(icfg.LaundererPlaces.Garage.ReturnVehicle.x, icfg.LaundererPlaces.Garage.ReturnVehicle.y, icfg.LaundererPlaces.Garage.ReturnVehicle.z)) < 2.0) then
                            DrawMarker(25, icfg.LaundererPlaces.Garage.ReturnVehicle.x, icfg.LaundererPlaces.Garage.ReturnVehicle.y, icfg.LaundererPlaces.Garage.ReturnVehicle.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                            DrawText3Ds(icfg.LaundererPlaces.Garage.ReturnVehicle.x, icfg.LaundererPlaces.Garage.ReturnVehicle.y, icfg.LaundererPlaces.Garage.ReturnVehicle.z + 0.8, "Press [~g~E~s~] to return Vehicle")
                            if IsControlJustReleased(0, Keys["E"]) then
                                if Plate == GetVehicleNumberPlateText(vehicle) and hasCar then
                                    ESX.Game.DeleteVehicle(vehicle)
                                    hasCar = false
                                    Plate = nil
                                else
                                    exports['mythic_notify']:SendAlert('inform', "This is not your vehicle")
                                end
                            end
                        elseif (#(coords - vector3(icfg.LaundererPlaces.Garage.ReturnVehicle.x, icfg.LaundererPlaces.Garage.ReturnVehicle.y, icfg.LaundererPlaces.Garage.ReturnVehicle.z)) < 8.0) then
                            sleep = 5
                            DrawMarker(25, icfg.LaundererPlaces.Garage.ReturnVehicle.x, icfg.LaundererPlaces.Garage.ReturnVehicle.y, icfg.LaundererPlaces.Garage.ReturnVehicle.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 30, 224, 20, 100, false, true, 2, false, false, false, false)
                            DrawMarker(39, icfg.LaundererPlaces.Garage.ReturnVehicle.x, icfg.LaundererPlaces.Garage.ReturnVehicle.y, icfg.LaundererPlaces.Garage.ReturnVehicle.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3, 1.3, 1.3, 30, 224, 20, 75, false, true, 2, false, false, false, false)
                        end
                    end
                    if NowWorking then
                        if IsPedInAnyVehicle(ped, false) then
                            if (#(coords - vector3(DeliveryPlace.x, DeliveryPlace.y, DeliveryPlace.z)) < 2.0) then
                                sleep = 5
                                DrawText3Ds(DeliveryPlace.x, DeliveryPlace.y, DeliveryPlace.z + 0.8, "Press [~g~E~s~] to unload your Vehicle")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if hasCar and Plate == GetVehicleNumberPlateText(vehicle) then
                                        TriggerServerEvent('inside-moneywash:addnotifyCops', coords)
                                        DoScreenFadeOut(1000)
                                        Citizen.Wait(1000)
                                        FreezeEntityPosition(vehicle, true)
                                        FreezeEntityPosition(ped, true)
                                        SetVehicleEngineOn(vehicle, false, false, true)
                                        exports['mythic_progbar']:Progress({
                                            name = "unique_action_name",
                                            duration = 7000,
                                            label = 'Exchanging your Money',
                                            useWhileDead = true,
                                            canCancel = false,
                                            controlDisables = {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            },
                                        })
                                        Citizen.Wait(7000)
                                        DoScreenFadeIn(1000)
                                        TriggerServerEvent('inside-moneywash:ExchangeMoney')
                                        FreezeEntityPosition(vehicle, false)
                                        FreezeEntityPosition(ped, false)
                                        SetVehicleEngineOn(vehicle, true, false, true)
                                        removeDeliveryBlip()
                                        ESX.TriggerServerCallback('inside-moneywash:checkBlackMoney', function(haveBlackMoney)
                                            if haveBlackMoney then
                                                NowWorking = false
                                                DeliveryPlace = nil
                                                DeliveryPlace = icfg.DeliveryPlace[math.random(1,#icfg.DeliveryPlace)]
                                                street = GetStreetNameAtCoord(DeliveryPlace.x, DeliveryPlace.y, DeliveryPlace.z)
                                                street2 = GetStreetNameFromHashKey(street)
                                                exports['mythic_notify']:SendAlert('inform', "Deliver Black Money to " ..street2)
                                                SetNewWaypoint(DeliveryPlace.x, DeliveryPlace.y)
                                                addDeliveryBlip()
                                                NowWorking = true
                                            elseif not haveBlackMoney then
                                                NowWorking = false
                                                DeliveryPlace = nil
                                                exports['mythic_notify']:SendAlert('inform', "You have no more Black Money to wash. Back to base, return the vehicle and get back your permit")
                                                SetNewWaypoint(icfg.LaundererPlaces.Garage.ReturnVehicle.x, icfg.LaundererPlaces.Garage.ReturnVehicle.y)
                                            end
                                        end)
                                    else
                                        exports['mythic_notify']:SendAlert('inform', "This is not your vehicle")
                                    end
                                end
                            elseif (#(coords - vector3(DeliveryPlace.x, DeliveryPlace.y, DeliveryPlace.z)) < 8.0) then
                                sleep = 5
                                DrawMarker(39, DeliveryPlace.x, DeliveryPlace.y, DeliveryPlace.z + 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3, 1.3, 1.3, 30, 224, 20, 75, false, true, 2, false, false, false, false)
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

function addGarageBlip()
    GarageBlip = AddBlipForCoord(icfg.LaundererPlaces.Garage.ChoosePos.x, icfg.LaundererPlaces.Garage.ChoosePos.y, icfg.LaundererPlaces.Garage.ChoosePos.z)
    SetBlipSprite(GarageBlip, icfg.LaundererPlaces.Garage.BlipType)
    SetBlipDisplay(GarageBlip, 4)
    SetBlipScale(GarageBlip, icfg.LaundererPlaces.Garage.BlipScale)
    SetBlipAsShortRange(GarageBlip, true)
    SetBlipColour(GarageBlip, icfg.LaundererPlaces.Garage.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(icfg.LaundererPlaces.Garage.BlipLabel)
    EndTextCommandSetBlipName(GarageBlip)
end

function removeGarageBlip()
    RemoveBlip(GarageBlip)
end

function OpenGarageMenu()

    local elements = {}

    if not hasCar then
        table.insert(elements, {label = 'Parking Place #1', value = 'place1'})
        table.insert(elements, {label = 'Parking Place #2', value = 'place2'})
        table.insert(elements, {label = 'Parking Place #3', value = 'place3'})
    end
    FreezeEntityPosition(PlayerPedId(), true)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'GarageMenu', {
			title    = 'Auto Repairs Garage',
			align    = 'center',
            elements = elements,
            }, 
            function(data, menu)
            FreezeEntityPosition(PlayerPedId(), false)
            ESX.UI.Menu.CloseAll()
			if data.current.value == 'place1' then
                ESX.Game.SpawnVehicle(icfg.AutoRepairsVehicle, vector3(icfg.LaundererPlaces.Garage.SpawnPoint1.x, icfg.LaundererPlaces.Garage.SpawnPoint1.y, icfg.LaundererPlaces.Garage.SpawnPoint1.z), icfg.LaundererPlaces.Garage.SpawnPoint1.h, function(vehicle)
                    SetVehicleNumberPlateText(vehicle, "ARG"..tostring(math.random(1000, 9999)))
                    SetVehicleEngineOn(vehicle, true, true)
                    hasCar = true
                    Plate = GetVehicleNumberPlateText(vehicle)
                end)
			end
            if data.current.value == 'place2' then
                ESX.Game.SpawnVehicle(icfg.AutoRepairsVehicle, vector3(icfg.LaundererPlaces.Garage.SpawnPoint2.x, icfg.LaundererPlaces.Garage.SpawnPoint2.y, icfg.LaundererPlaces.Garage.SpawnPoint2.z), icfg.LaundererPlaces.Garage.SpawnPoint2.h, function(vehicle)
                    SetVehicleNumberPlateText(vehicle, "ARG"..tostring(math.random(1000, 9999)))
                    SetVehicleEngineOn(vehicle, true, true)
                    hasCar = true
                    Plate = GetVehicleNumberPlateText(vehicle)
                end)
			end
            if data.current.value == 'place3' then
                ESX.Game.SpawnVehicle(icfg.AutoRepairsVehicle, vector3(icfg.LaundererPlaces.Garage.SpawnPoint3.x, icfg.LaundererPlaces.Garage.SpawnPoint3.y, icfg.LaundererPlaces.Garage.SpawnPoint3.z), icfg.LaundererPlaces.Garage.SpawnPoint3.h, function(vehicle)
                    SetVehicleNumberPlateText(vehicle, "ARG"..tostring(math.random(1000, 9999)))
                    SetVehicleEngineOn(vehicle, true, true)
                    hasCar = true
                    Plate = GetVehicleNumberPlateText(vehicle)
                end)
			end
            DeliveryPlace = icfg.DeliveryPlace[math.random(1,#icfg.DeliveryPlace)]
            street = GetStreetNameAtCoord(DeliveryPlace.x, DeliveryPlace.y, DeliveryPlace.z)
            street2 = GetStreetNameFromHashKey(street)
            exports['mythic_notify']:SendAlert('inform', "Deliver Black Money to " ..street2)
            SetNewWaypoint(DeliveryPlace.x, DeliveryPlace.y)
            addDeliveryBlip()
            NowWorking = true
		end, function(data, menu)
			menu.close()
            FreezeEntityPosition(PlayerPedId(), false)
		end)
end

function OpenLaunderingMenu()

    local elements = {}

    if not startedWork then
        table.insert(elements, {label = 'Start Work', value = 'StartJob'})
    elseif startedWork then
        if not startedDelivery then
            table.insert(elements, {label = 'Start Delivering Black Money', value = 'StartDelivery'})
            table.insert(elements, {label = 'Cancel Work', value = 'CancelJob'})
        elseif startedDelivery then
            table.insert(elements, {label = 'Cancel Work', value = 'CancelJob'})
        end
    end
    FreezeEntityPosition(PlayerPedId(), true)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'LaundererMenu', {
			title    = 'Auto Repairs Company',
			align    = 'center',
            elements = elements,
            }, 
            function(data, menu)
            FreezeEntityPosition(PlayerPedId(), false)
            ESX.UI.Menu.CloseAll()
			if data.current.value == 'StartJob' then
                ESX.TriggerServerCallback('inside-moneywash:checkWorkPermit', function(hasPermit)
                    if hasPermit then
                        exports['mythic_notify']:SendAlert('inform', "Work Permit is Correct")
                        TriggerServerEvent('inside-moneywash:addDriver')
                        startedWork = true
                    else
                        exports['mythic_notify']:SendAlert('inform', "You don't have a Work Permit for this place")
                    end
                end)
			end
            if data.current.value == 'CancelJob' then
                TriggerServerEvent('inside-moneywash:removeDriver')
                TriggerServerEvent('inside-moneywash:returnWorkPermit')
                exports['mythic_notify']:SendAlert('inform', "You took your Work Permit")
                if DeliveryPlace and NowWorking then
                    removeDeliveryBlip()
                end
                removeGarageBlip()
                hasCar = false
                Plate = nil
                startedDelivery = false
                startedWork = false
                NowWorking = false
                DeliveryPlace = nil
            end
            if data.current.value == 'StartDelivery' then
                ESX.TriggerServerCallback('inside-moneywash:payforVehicle', function(hasMoney)
                    if hasMoney then
                        addGarageBlip()
                        startedDelivery = true
                        exports['mythic_notify']:SendAlert('success', "You paid "..icfg.DepositPrice.. " deposit for Vehicle, go to the Garage and get it out")
                    elseif not hasMoney then
                        exports['mythic_notify']:SendAlert('error', "You don't have Money to pay Deposit")
                    end
                end)
            end
		end, function(data, menu)
			menu.close()
            FreezeEntityPosition(PlayerPedId(), false)
		end)
end

function addDeliveryBlip()
    DeliveryPlace.blip = AddBlipForCoord(DeliveryPlace.x, DeliveryPlace.y, DeliveryPlace.z)
    SetBlipSprite(DeliveryPlace.blip, icfg.LocationBlip.BlipType)
    SetBlipDisplay(DeliveryPlace.blip, 4)
    SetBlipScale(DeliveryPlace.blip, icfg.LocationBlip.BlipScale)
    SetBlipAsShortRange(DeliveryPlace.blip, true)
    SetBlipColour(DeliveryPlace.blip, icfg.LocationBlip.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(icfg.LocationBlip.BlipLabel)
    EndTextCommandSetBlipName(DeliveryPlace.blip)
end

RegisterNetEvent('inside-moneywash:notifyCops')
AddEventHandler('inside-moneywash:notifyCops', function(coords)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
		street2 = GetStreetNameFromHashKey(street)
		exports.pNotify:SendNotification({text = "<b>CENTRAL PD</b></br>Suspect Van with registration " ..Plate.. " on " ..street2.. " street", timeout = 7500})

		blipcops = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blipcops, 326)
		SetBlipColour(blipcops, 1)
		SetBlipAlpha(blipcops, 250)
		SetBlipScale(blipcops, 0.8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Suspect Van [' ..Plate.. ']')
		EndTextCommandSetBlipName(blipcops)
        Wait(35000)
        RemoveBlip(blipcops)
	end
end)

function removeDeliveryBlip()
    RemoveBlip(DeliveryPlace.blip)
end

function DrawText2Ds(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0.0, 0.0, 0.0, 0.0, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
	SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('inside-moneywash:stopLaundry1')
AddEventHandler('inside-moneywash:stopLaundry1', function()
    BLaundry1 = false
end)

RegisterNetEvent('inside-moneywash:startLaundry1')
AddEventHandler('inside-moneywash:startLaundry1', function()
    BLaundry1 = true
end)

RegisterNetEvent('inside-moneywash:stopLaundry2')
AddEventHandler('inside-moneywash:stopLaundry2', function()
    BLaundry2 = false
end)

RegisterNetEvent('inside-moneywash:startLaundry2')
AddEventHandler('inside-moneywash:startLaundry2', function()
    BLaundry2 = true
end)

RegisterNetEvent('inside-moneywash:stopLaundry3')
AddEventHandler('inside-moneywash:stopLaundry3', function()
    BLaundry3 = false
end)

RegisterNetEvent('inside-moneywash:startLaundry3')
AddEventHandler('inside-moneywash:startLaundry3', function()
    BLaundry3 = true
end)

RegisterNetEvent('inside-moneywash:stopLaundry4')
AddEventHandler('inside-moneywash:stopLaundry4', function()
    BLaundry4 = false
end)

RegisterNetEvent('inside-moneywash:startLaundry4')
AddEventHandler('inside-moneywash:startLaundry4', function()
    BLaundry4 = true
end)