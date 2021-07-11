ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

RegisterServerEvent('pawnshop:sellcasio')
AddEventHandler('pawnshop:sellcasio', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local CasioPrice = math.random(27, 54)
    local CasioQuantity = xPlayer.getInventoryItem('casiowatch').count
   
    if CasioQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * CasioPrice * CasioQuantity)
        xPlayer.removeInventoryItem('casiowatch', CasioQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. CasioQuantity .. ' Casio Watches and earned $' .. CasioPrice * CasioQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Casio Watches to sell!', length = 5000})
    end
end)


RegisterServerEvent('pawnshop:sellrubber')
AddEventHandler('pawnshop:sellrubber', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(27, 54)
    local RubberQuantity = xPlayer.getInventoryItem('rubber').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('rubber', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. RubberQuantity .. ' Rubber and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Rubber to sell!', length = 5000})
    end
end)

RegisterServerEvent('pawnshop:sellcopper')
AddEventHandler('pawnshop:sellcopper', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(27, 54)
    local RubberQuantity = xPlayer.getInventoryItem('copper').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('copper', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. RubberQuantity .. ' Copper and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Copper to sell!', length = 5000})
    end
end)

--electronics

RegisterServerEvent('pawnshop:sellelectronics')
AddEventHandler('pawnshop:sellelectronics', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(27, 54)
    local RubberQuantity = xPlayer.getInventoryItem('electronics').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('electronics', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. RubberQuantity .. ' Electronics and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Electronics to sell!', length = 5000})
    end
end)


-- rolex

RegisterServerEvent('pawnshop:sellrolex')
AddEventHandler('pawnshop:sellrolex', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(700, 1500)
    local RubberQuantity = xPlayer.getInventoryItem('rolex').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('rolex', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. RubberQuantity .. ' Rolexs and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Rolexs to sell!', length = 5000})
    end
end)































    



RegisterServerEvent('drugsales:weed')
AddEventHandler('drugsales:weed', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(125, 200)
    local RubberQuantity = xPlayer.getInventoryItem('packagedweed').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('packagedweed', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. RubberQuantity .. ' Packaged Weed and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Packaged Weed to sell!', length = 5000})
    end
end)

RegisterServerEvent('drugsales:cocaine')
AddEventHandler('drugsales:cocaine', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(125, 200)
    local RubberQuantity = xPlayer.getInventoryItem('packagedcoca').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('packagedcoca', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. RubberQuantity .. ' Packaged Cocaine and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Packaged Cocaine to sell!', length = 5000})
    end
end)

RegisterServerEvent('drugsales:meth')
AddEventHandler('drugsales:meth', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(125, 200)
    local RubberQuantity = xPlayer.getInventoryItem('packagedmeth').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('packagedmeth', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. RubberQuantity .. ' Packaged Meth and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Packaged Meth to sell!', length = 5000})
    end
end)


RegisterServerEvent('drugunpack:weed')
AddEventHandler('drugunpack:weed', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('packagedweed').count

    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.removeInventoryItem('packagedweed', RubberQuantity)
        xPlayer.addInventoryItem('joint', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have unpacked ' .. RubberQuantity .. ' Packaged Weed.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Packaged Weed to unpack!', length = 5000})
    end
end)

RegisterServerEvent('drugunpack:coca')
AddEventHandler('drugunpack:coca', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('packagedcoca').count
    

    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.removeInventoryItem('packagedcoca', RubberQuantity)
        xPlayer.addInventoryItem('cocaine', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have unpacked ' .. RubberQuantity .. ' Packaged Cocaine.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Packaged Cocaine to unpack!', length = 5000})
    end
end)


RegisterServerEvent('blackmarket:ammonia')
AddEventHandler('blackmarket:ammonia', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count
    
    if money >= 1000 then
        xPlayer.addInventoryItem('ammonia', 1)
        xPlayer.removeInventoryItem('money', 1000)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have purchased the item!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have enough cash.', length = 5000})
    end
end)

RegisterServerEvent('blackmarket:labcard')
AddEventHandler('blackmarket:labcard', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count
    
    if money >= 1000 then
        xPlayer.addInventoryItem('labcard', 1)
        xPlayer.removeInventoryItem('money', 1000)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have purchased the item!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have enough cash.', length = 5000})
    end
end)

RegisterServerEvent('blackmarket:sacid')
AddEventHandler('blackmarket:sacid', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count
    
    if money >= 1000 then
        xPlayer.addInventoryItem('sacid', 1)
        xPlayer.removeInventoryItem('money', 1000)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have purchased the item!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have enough cash.', length = 5000})
    end
end)
