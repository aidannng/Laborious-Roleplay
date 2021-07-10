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

--craft:m70rifle


RegisterServerEvent('craft:m70rifle')
AddEventHandler('craft:m70rifle', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapcount = xPlayer.getInventoryItem('scrapmetal').count
    local rubbercount = xPlayer.getInventoryItem('rubber').count
    local aluminiumcount = xPlayer.getInventoryItem('aluminium').count

    if scrapcount >= 250 then
        if aluminiumcount >= 180 then
            if rubbercount >= 50 then
                xPlayer.addInventoryItem('WEAPON_ASSAULTRIFLE', 1)
                xPlayer.removeInventoryItem('scrapmetal', 250)
                xPlayer.removeInventoryItem('rubber', 50)
                xPlayer.removeInventoryItem('aluminium', 180)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Materials to Craft!', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Materials to Craft!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Materials to Craft!', length = 5000})
    end
end)

--jewles

RegisterServerEvent('dealersell:selljewels')
AddEventHandler('dealersell:selljewels', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(225, 350)
    local RubberQuantity = xPlayer.getInventoryItem('jewels').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('jewels', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have sold ' .. RubberQuantity .. ' Jewels and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Jewels to sell!', length = 5000})
    end
end)

-- rolex

RegisterServerEvent('dealersell:sellrolex')
AddEventHandler('dealersell:sellrolex', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(125, 200)
    local RubberQuantity = xPlayer.getInventoryItem('rolex').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('rolex', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have sold ' .. RubberQuantity .. ' Rolexs and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Rolexs to sell!', length = 5000})
    end
end)

-- Bands

RegisterServerEvent('pawnshop:sellbands')
AddEventHandler('pawnshop:sellbands', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberPrice = math.random(165, 215)
    local RubberQuantity = xPlayer.getInventoryItem('bands').count
   
    if RubberQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
        xPlayer.removeInventoryItem('bands', RubberQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have exchanged ' .. RubberQuantity .. ' Bands and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Bands to exchange!', length = 5000})
    end
end)

--Carbine

RegisterServerEvent('dealerbuy:cbmk2')
AddEventHandler('dealerbuy:cbmk2', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count
    
    if money >= 30000 then
        xPlayer.addInventoryItem('WEAPON_CARBINERIFLE_MK2', 1)
        xPlayer.removeInventoryItem('money', 30000)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have purchased the item!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Money!', length = 5000})
    end
end)
    
RegisterServerEvent('dealerbuy:thermite')
AddEventHandler('dealerbuy:thermite', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count
    
    if money >= 2500 then
        xPlayer.addInventoryItem('thermite', 1)
        xPlayer.removeInventoryItem('money', 2500)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have purchased thermite!.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Money!', length = 5000})
    end
end)

RegisterServerEvent('lesterbuy:laptop')
AddEventHandler('lesterbuy:laptop', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local usbcount = xPlayer.getInventoryItem('usb').count

    if usbcount >= 1 then
        xPlayer.addInventoryItem('greenlaptop', 1)
        xPlayer.removeInventoryItem('usb', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have exchanged a usb for a laptop!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You dont have a usb!', length = 5000})
    end
end)


-- plasma drug sales/unpack

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
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have sold ' .. RubberQuantity .. ' Packaged Weed and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
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
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have sold ' .. RubberQuantity .. ' Packaged Cocaine and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
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
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have sold ' .. RubberQuantity .. ' Packaged Meth and earned $' .. RubberPrice * RubberQuantity .. '.', length = 10000})
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
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have unpacked ' .. RubberQuantity .. ' Packaged Weed.', length = 10000})
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
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have unpacked ' .. RubberQuantity .. ' Packaged Cocaine.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Packaged Cocaine to unpack!', length = 5000})
    end
end)

-- RegisterServerEvent('drugunpack:coca')
-- AddEventHandler('drugunpack:coca', function()
--     math.randomseed(os.time())
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local RubberQuantity = xPlayer.getInventoryItem('packagedcoca').count
    

--     if RubberQuantity >= 1 then
--         local quality = 1
--         xPlayer.removeInventoryItem('packagedcoca', RubberQuantity)
--         xPlayer.addInventoryItem('cocaine', RubberQuantity)
--         TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have unpacked ' .. RubberQuantity .. ' Packaged Cocaine.', length = 10000})
--     else
--         TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You have no Packaged Cocaine to unpack!', length = 5000})
--     end
-- end)

-- Blackmarket Dealer

RegisterServerEvent('blackmarket:ammonia')
AddEventHandler('blackmarket:ammonia', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count
    
    if money >= 1000 then
        xPlayer.addInventoryItem('ammonia', 1)
        xPlayer.removeInventoryItem('money', 1000)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have purchased the item!', length = 10000})
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
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have purchased the item!', length = 10000})
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
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'success', text = 'You have purchased the item!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have enough cash.', length = 5000})
    end
end)
