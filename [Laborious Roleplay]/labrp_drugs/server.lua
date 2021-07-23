ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Aidan:server:CheckItem', function(source, cb, item)
    local ply = ESX.GetPlayerFromId(source)
    itemcount = ply.getInventoryItem(item).count
    if itemcount > 0 then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('Aidan:server:CheckItem3', function(source, cb, item)
    local ply = ESX.GetPlayerFromId(source)
    itemcount = ply.getInventoryItem(item).count
    if itemcount >= 3 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('plasma1')
AddEventHandler('plasma1', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local weed = xPlayer.getInventoryItem('weed').count
    local packedweed = xPlayer.getInventoryItem('packagedweed').count

    if weed >= 1 then
        xPlayer.addInventoryItem('packagedweed', 1)
        xPlayer.removeInventoryItem('weed', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have packaged weed!', length = 10000})
    end
end)

RegisterServerEvent('plasma2')
AddEventHandler('plasma2', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local weed = xPlayer.getInventoryItem('weed').count
        xPlayer.addInventoryItem('weed', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have picked weed!', length = 10000})
end)

RegisterServerEvent('server:joint')
AddEventHandler('server:joint', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local weed = xPlayer.getInventoryItem('packagedweed').count
    local joint = xPlayer.getInventoryItem('joint').count
    local paper = xPlayer.getInventoryItem('rolling_paper').count

    if weed >= 1 then
        xPlayer.removeInventoryItem('packagedweed', 1)
        xPlayer.removeInventoryItem('rolling_paper', 1)
        xPlayer.addInventoryItem('joint', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have unpacked weed!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Packaged Weed to unpack!', length = 5000})
    end
end)