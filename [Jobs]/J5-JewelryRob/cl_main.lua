local robbingNow = false 
local store = ''
local isRobbing = false 
local refreshTimer = GetGameTimer()
--ESX
    ESX = nil 
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                PlayerData = ESX.GetPlayerData()
            Citizen.Wait(0)
        end
    end)

    -- Reg Police // Job
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)
--

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1) 
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 


Citizen.CreateThread(function()
    if Config.ShowStore then 
        local bliper = AddBlipForCoord(-624.33, -232.44,38.6)
        SetBlipSprite(bliper, 617)
        SetBlipScale(bliper, 0.7)
        SetBlipAsShortRange(bliper, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Jewelry Store')
        EndTextCommandSetBlipName(bliper)
    end
end)

inrobspot = false 

Cab1Robbed = false
Cab2Robbed = false
Cab3Robbed = false
Cab4Robbed = false
Cab5Robbed = false
Cab6Robbed = false
Cab7Robbed = false
Cab8Robbed = false
Cab9Robbed = false
Cab10Robbed = false
Cab11Robbed = false
Cab12Robbed = false
Cab13Robbed = false
Cab14Robbed = false
Cab15Robbed = false
Cab16Robbed = false
Cab17Robbed = false
Cab18Robbed = false
Cab19Robbed = false
Cab20Robbed = false

RegisterNetEvent('ResetBITCH') -- Resets the bitch
AddEventHandler('ResetBITCH', function(NoCab ,CabRobbed)
    print('RESET')
    Cab1Robbed = false
    Cab2Robbed = false
    Cab3Robbed = false
    Cab4Robbed = false
    Cab5Robbed = false
    Cab6Robbed = false
    Cab7Robbed = false
    Cab8Robbed = false
    Cab9Robbed = false
    Cab10Robbed = false
    Cab11Robbed = false
    Cab12Robbed = false
    Cab13Robbed = false
    Cab14Robbed = false
    Cab15Robbed = false
    Cab16Robbed = false
    Cab17Robbed = false
    Cab18Robbed = false
    Cab19Robbed = false
    Cab20Robbed = false
end)

RegisterNetEvent('Pussi')
AddEventHandler('Pussi', function(NoCab, CabRobbed)
    if NoCab == 1 then
        Cab1Robbed = CabRobbed 
    elseif NoCab == 2 then
        Cab2Robbed = CabRobbed 
    elseif NoCab == 3 then
        Cab3Robbed = CabRobbed 
    elseif NoCab == 4 then
        Cab4Robbed = CabRobbed 
    elseif NoCab == 5 then
        Cab5Robbed = CabRobbed 
    elseif NoCab == 6 then
        Cab6Robbed = CabRobbed 
    elseif NoCab == 7 then
        Cab7Robbed = CabRobbed 
    elseif NoCab == 8 then
        Cab8Robbed = CabRobbed 
    elseif NoCab == 9 then
        Cab9Robbed = CabRobbed 
    elseif NoCab == 10 then
        Cab10Robbed = CabRobbed 
    elseif NoCab == 11 then
        Cab11Robbed = CabRobbed 
    elseif NoCab == 12 then
        Cab12Robbed = CabRobbed 
    elseif NoCab == 13 then
        Cab13Robbed = CabRobbed 
    elseif NoCab == 14 then
        Cab14Robbed = CabRobbed 
    elseif NoCab == 15 then
        Cab15Robbed = CabRobbed 
    elseif NoCab == 16 then
        Cab16Robbed = CabRobbed 
    elseif NoCab == 17 then
        Cab17Robbed = CabRobbed 
    elseif NoCab == 18 then
        Cab18Robbed = CabRobbed 
    elseif NoCab == 19 then
        Cab19Robbed = CabRobbed 
    elseif NoCab == 20 then
        Cab20Robbed = CabRobbed 
    end
end)

-- local dist = #(vector3(ChopLocation['x'],ChopLocation['y'],ChopLocation['z']) - playerCoords)
local sleep = 500
Citizen.CreateThread(function()
    while true do 
        sleep = 250
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        isClose = false 
        NoCab = 0 
        local dist =  #(vector3(-624.0,-232.47,38.0) - pos)
        if dist < 25 then
            sleep = 50
            isClose = true 
            if Cab1Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -627.11, -234.95, 38.06) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-627.11, -234.95, 37.86, '[E]')
                    NoCab = 1 
                    locx,locy,locz = -627.11, -234.95, 37.86
                end
            end
            if Cab2Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -627.58, -234.36, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-627.58, -234.36, 37.86, '[E]')
                    NoCab = 2 
                    locx,locy,locz = -627.58, -234.36, 37.86
                end
            end
            if Cab3Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -626.51, -233.65, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-626.51, -233.65, 37.86, '[E]')
                    NoCab = 3
                    locx,locy,locz = -626.51, -233.65, 37.86
                end
            end
            if Cab4Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -626.13, -234.21, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-626.13, -234.21, 37.86, '[E]')
                    NoCab = 4
                    locx,locy,locz = -626.13, -234.21, 37.86
                end
            end
            if Cab5Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -625.28, -238.27, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-625.28, -238.27, 37.86, '[E]')
                    NoCab = 5
                    locx,locy,locz = -625.28, -238.27, 37.86
                end
            end
            if Cab6Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -626.32, -239.06, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-626.32, -239.06, 37.86, '[E]')
                    NoCab = 6
                    locx,locy,locz = -626.32, -239.06, 37.86
                end
            end
            if Cab7Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -625.28, -227.43, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-625.28, -227.43, 37.86, '[E]')
                    NoCab = 7
                    locx,locy,locz = -625.28, -227.43, 37.86
                end
            end
            if Cab8Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -624.27, -226.62, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-624.27, -226.62, 37.86, '[E]')
                    NoCab = 8
                    locx,locy,locz = -624.27, -226.62, 37.86
                end
            end
            if Cab9Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -619.96, -226.20, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-619.96, -226.20, 37.86, '[E]')
                    NoCab = 9
                    locx,locy,locz = -619.96, -226.20, 37.86
                end
            end
            if Cab10Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -619.24, -227.23, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-619.24, -227.23, 37.86, '[E]')
                    NoCab = 10
                    locx,locy,locz = -619.24, -227.23, 37.86
                end
            end
            if Cab11Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -617.88, -229.12, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-617.88, -229.12, 37.86, '[E]')
                    NoCab = 11
                    locx,locy,locz = -617.88, -229.12, 37.86
                end
            end
            if Cab12Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -617.1, -230.15, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-617.1, -230.15, 37.86, '[E]')
                    NoCab = 12
                    locx,locy,locz = -617.1, -230.15, 37.86
                end
            end
            if Cab13Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -618.84, -234.06, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-618.84, -234.06, 37.86, '[E]')
                    NoCab = 13
                    locx,locy,locz = -618.84, -234.06, 37.86
                end
            end
            if Cab14Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -619.87, -234.88, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-619.87, -234.88, 37.86, '[E]')
                    NoCab = 14
                    locx,locy,locz = -619.87, -234.88, 37.86
                end
            end
            if Cab15Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -620.54, -232.87, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-620.54, -232.87, 37.86, '[E]')
                    NoCab = 15
                    locx,locy,locz = -620.54, -232.87, 37.86
                end
            end
            if Cab16Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -620.05, -230.77, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-620.05, -230.77, 37.86, '[E]')
                    NoCab = 16
                    locx,locy,locz = -620.05, -230.77, 37.86
                end
            end
            if Cab17Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -621.53, -228.95, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-621.53, -228.95, 37.86, '[E]')
                    NoCab = 17
                    locx,locy,locz = -621.53, -228.95, 37.86
                end
            end
            if Cab18Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -623.68, -228.54, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-623.68, -228.54, 37.86, '[E]')
                    NoCab = 18
                    locx,locy,locz = -623.68, -228.54, 37.86
                end
            end
            if Cab19Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -624.09, -230.8, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-624.09, -230.8, 37.86, '[E]')
                    NoCab = 19
                    locx,locy,locz = -624.09, -230.8, 37.86
                end
            end
            if Cab20Robbed == false then 
                if (Vdist(pos.x, pos.y, pos.z, -622.64, -232.55, 37.86) < 0.8) then	
                    sleep = 7
                    DrawText3Ds(-622.64, -232.55, 37.86, '[E]')
                    NoCab = 20
                    locx,locy,locz = -622.64, -232.55, 37.86
                end
            end
        end

        if NoCab ~= 0  then 
            local ped = GetPlayerPed(-1)
            local whore = IsPedArmed(ped, 4 )
            if IsControlJustPressed(0, 38) then 
                ESX.TriggerServerCallback('JewelRob:Police', function(connectedCops)
                    if connectedCops >= Config.PoliceAmount then 
                        if not whore then 
                            print('Dumbfuck') -- or do a notif
                        else
                            TriggerServerEvent('SyncShit', NoCab)
                            if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                RequestNamedPtfxAsset("scr_jewelheist")
                            end
                            while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                Citizen.Wait(0)
                            end
                            SetPtfxAssetNextCall("scr_jewelheist")

                                    
                            StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", locx,locy,locz+0.2, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                            loadAnimDict( "missheist_jewel" ) 
                            TaskPlayAnim( GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                            local waiting = GetGameTimer()
                            repeat 
                                Wait(50)
                            until GetGameTimer() - waiting > Config.HulkSmash
                            ClearPedTasks(GetPlayerPed(-1))
                            local chance = math.random(1,100)
                            if chance < Config.AlartPercentPerBox then 
                                print('ALARM PLS DAD')
                            end
                            local amount = math.random(1,7)
                            TriggerServerEvent('JewelRob:GiveItems', amount)

                            print('doshit')
                        end
                    else
                        print('NoCop')
                    end
                end)
            end
        end
        Citizen.Wait(sleep)
    end
end)