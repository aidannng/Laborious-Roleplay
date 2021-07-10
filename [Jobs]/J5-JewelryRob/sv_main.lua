
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local rob = false 
local robbers = {}

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


resetTimer = GetGameTimer()

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(60000)
        if (GetGameTimer() - resetTimer)/1000/60 > Config.ReggieTimer then 
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
            TriggerClientEvent('ResetBITCH', -1)
            resetTimer = GetGameTimer()
        end 
    end 
end)

function enoughCops()
    local xPlayers = ESX.GetPlayers()

    connectedCops = 0 
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then 
            connectedCops = connectedCops + 1
        end
    end
    SetTimeout(120 * 10000, enoughCops) 
end

enoughCops()

RegisterServerEvent('SyncShit')
AddEventHandler('SyncShit', function(NoCab)
    canRob = false
    if NoCab == 1 then 
        if Cab1Robbed == false then 
            Cab1Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab1Robbed)
            canRob = true
        end
    end
    if NoCab == 2 then 
        if Cab2Robbed == false then 
            Cab2Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab2Robbed)
            canRob = true
        end
    end
    if NoCab == 3 then 
        if Cab3Robbed == false then 
            Cab3Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab3Robbed)
            canRob = true
        end
    end
    if NoCab == 4 then 
        if Cab4Robbed == false then 
            Cab4Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab4Robbed)
            canRob = true
        end
    end
    if NoCab == 5 then 
        if Cab5Robbed == false then 
            Cab5Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab5Robbed)
            canRob = true
        end
    end
    if NoCab == 6 then 
        if Cab6Robbed == false then 
            Cab6Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab6Robbed)
            canRob = true
        end
    end
    if NoCab == 7 then 
        if Cab7Robbed == false then 
            Cab7Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab7Robbed)
            canRob = true
        end
    end
    if NoCab == 8 then 
        if Cab8Robbed == false then 
            Cab8Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab8Robbed)
            canRob = true
        end
    end
    if NoCab == 9 then 
        if Cab9Robbed == false then 
            Cab9Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab9Robbed)
            canRob = true
        end
    end
    if NoCab == 10 then 
        if Cab10Robbed == false then 
            Cab10Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab10Robbed)
            canRob = true
        end
    end
    if NoCab == 11 then 
        if Cab11Robbed == false then 
            Cab11Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab11Robbed)
            canRob = true
        end
    end
    if NoCab == 12 then 
        if Cab12Robbed == false then 
            Cab12Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab12Robbed)
            canRob = true
        end
    end
    if NoCab == 13 then 
        if Cab13Robbed == false then 
            Cab13Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab13Robbed)
            canRob = true
        end
    end
    if NoCab == 14 then 
        if Cab14Robbed == false then 
            Cab14Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab14Robbed)
            canRob = true
        end
    end
    if NoCab == 15 then 
        if Cab15Robbed == false then 
            Cab15Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab15Robbed)
            canRob = true
        end
    end
    if NoCab == 16 then 
        if Cab16Robbed == false then 
            Cab16Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab16Robbed)
            canRob = true
        end
    end
    if NoCab == 17 then 
        if Cab17Robbed == false then 
            Cab17Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab17Robbed)
            canRob = true
        end
    end
    if NoCab == 18 then 
        if Cab18Robbed == false then 
            Cab18Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab18Robbed)
            canRob = true
        end
    end
    if NoCab == 19 then 
        if Cab19Robbed == false then 
            Cab19Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab19Robbed)
            canRob = true
        end
    end
    if NoCab == 20 then 
        if Cab20Robbed == false then 
            Cab20Robbed = true 
            TriggerClientEvent('Pussi', -1, NoCab, Cab20Robbed)
            canRob = true
        end
    end
    TriggerClientEvent('Pussi',source,canrob)
    resettimer = GetGameTimer()
end)


local r = rolex 
local g = jewels
local gg = greenlaptop 

RegisterServerEvent('JewelRob:GiveItems')
AddEventHandler('JewelRob:GiveItems', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local suckme = math.random(1,2)
    if suckme == 1 then 
        xPlayer.addInventoryItem(r, amount)
    else
        xPlayer.addInventoryItem(g, (amount))
    end
    local peen = math.random(1, 150)
    if peen >= 145 then 
        xPlayer.addInventoryItem(gg, 1)
    end
end)

ESX.RegisterServerCallback('JewelRob:Police', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	cb(connectedCops)
end)