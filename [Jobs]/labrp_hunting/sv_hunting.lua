ESX = nil

TriggerEvent(AOD.Strings.ESXServer, function(obj) ESX = obj end)

ESX.RegisterUsableItem('huntingknife', function(source)
    TriggerClientEvent('AOD-huntingknife',source)
end)

ESX.RegisterUsableItem('huntingbait', function(source)
    TriggerClientEvent('AOD-huntingbait', source)
end)

local inventoryspace = 0

RegisterServerEvent('check:weight')
AddEventHandler('check:weight', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    print(xPlayer.getWeight())
end)

RegisterServerEvent('AOD-butcheranimal')
AddEventHandler('AOD-butcheranimal', function(animal)
    local xPlayer = ESX.GetPlayerFromId(source)
    local boar = -832573324
    local deer = -664053099
    local coyote = 1682622302
    local rarity = math.random(1, 100)

    if xPlayer.getWeight() <= 30000 then

        if animal == boar then
            if rarity >= 85 then
                xPlayer.addInventoryItem('meat3star', math.random(1, 5))
                xPlayer.addInventoryItem('leather3star', 1)
            elseif rarity >= 60 then
                xPlayer.addInventoryItem('meat2star', math.random(1, 5))
                xPlayer.addInventoryItem('leather2star', 1)
            elseif rarity <= 59 then
                xPlayer.addInventoryItem('meat', math.random(1, 5))
                xPlayer.addInventoryItem('leather', 1)
            end
        elseif animal == deer then
            if rarity >= 85 then
                xPlayer.addInventoryItem('meat3star', math.random(1, 5))
                xPlayer.addInventoryItem('leather3star', 1)
            elseif rarity >= 60 then
                xPlayer.addInventoryItem('meat2star', math.random(1, 5))
                xPlayer.addInventoryItem('leather2star', 1)
            elseif rarity <= 59 then
                xPlayer.addInventoryItem('meat', math.random(1, 5))
                xPlayer.addInventoryItem('leather', 1)
            end
        elseif animal == coyote then
            if rarity >= 85 then
                xPlayer.addInventoryItem('meat3star', math.random(1, 5))
                xPlayer.addInventoryItem('leather3star', 1)
            elseif rarity >= 60 then
                xPlayer.addInventoryItem('meat2star', math.random(1, 5))
                xPlayer.addInventoryItem('leather2star', 1)
            elseif rarity <= 59 then
                xPlayer.addInventoryItem('meat', math.random(1, 5))
                xPlayer.addInventoryItem('leather', 1)
            end
        else
            print('exploit detected')
        --add your ban event here for cheating
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You can\'t carry anymore'})
    end
end)

RegisterServerEvent('AOD-hunt:TakeItem')
AddEventHandler('AOD-hunt:TakeItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, 1)
end)


RegisterServerEvent('hunting:sellMeat')
AddEventHandler('hunting:sellMeat', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local MeatPrice = math.random(150, 200)
    local MeatQuantity = xPlayer.getInventoryItem('meat').count
    local MeatQuantity2 = xPlayer.getInventoryItem('meat2star').count
    local MeatQuantity3 = xPlayer.getInventoryItem('meat3star').count
    local MeatQuantity4 = xPlayer.getInventoryItem('meat4star').count
    local MeatQuantity5 = xPlayer.getInventoryItem('meat5star').count
    
    if MeatQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * MeatPrice * MeatQuantity)
        xPlayer.removeInventoryItem('meat', MeatQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. MeatQuantity .. ' x 1 star Meats and earned $' .. MeatPrice * MeatQuantity .. '.', length = 10000})
    elseif MeatQuantity2 >= 1 then
        local quality = 2
        xPlayer.addMoney(math.ceil(quality * MeatPrice) * MeatQuantity2)
        xPlayer.removeInventoryItem('meat2star', MeatQuantity2)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. MeatQuantity2 .. ' x 2 star Meats and earned $' .. MeatPrice * quality * MeatQuantity2 .. '.', length = 10000})
    elseif MeatQuantity3 >= 1 then
        local quality = 3
        xPlayer.addMoney(math.ceil(quality * MeatPrice) * MeatQuantity3)
        xPlayer.removeInventoryItem('meat3star', MeatQuantity3)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. MeatQuantity3 .. ' x 3 star Meats and earned $' .. MeatPrice * quality * MeatQuantity3 .. '.', length = 10000})
    elseif MeatQuantity4 >= 1 then
        local quality = 4
        xPlayer.addMoney(math.ceil(quality * MeatPrice) * MeatQuantity4)
        xPlayer.removeInventoryItem('meat4star', MeatQuantity4)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. MeatQuantity4 .. ' x 4 star Meats and earned $' .. MeatPrice * quality * MeatQuantity4 .. '.', length = 10000})
    elseif MeatQuantity5 >= 1 then
        local quality = 5
        xPlayer.addMoney(math.ceil(quality * MeatPrice) * MeatQuantity5)
        xPlayer.removeInventoryItem('meat5star', MeatQuantity5)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. MeatQuantity5 .. ' x 5 star Meats and earned $' .. MeatPrice * quality * MeatQuantity5 .. '.', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You don\'t have any meat to sell?'})
    end
end)

RegisterServerEvent('hunting:sellLeather')
AddEventHandler('hunting:sellLeather', function()
    math.randomseed(os.time())
    local xPlayer = ESX.GetPlayerFromId(source)
    local LeatherPrice = math.random(150, 200)
    local LeatherQuantity = xPlayer.getInventoryItem('leather').count
    local LeatherQuantity2 = xPlayer.getInventoryItem('leather2star').count
    local LeatherQuantity3 = xPlayer.getInventoryItem('leather3star').count
    local LeatherQuantity4 = xPlayer.getInventoryItem('leather4star').count
    local LeatherQuantity5 = xPlayer.getInventoryItem('leather5star').count

    
    if LeatherQuantity >= 1 then
        local quality = 1
        xPlayer.addMoney(quality * LeatherPrice * LeatherQuantity)
        xPlayer.removeInventoryItem('leather', LeatherQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. LeatherQuantity .. ' x 1 star Leathers and earned $' .. LeatherPrice * LeatherQuantity .. '.', length = 12500})
    elseif LeatherQuantity2 >= 1 then
        local quality = 2
        xPlayer.addMoney(math.ceil(quality * LeatherPrice) * LeatherQuantity2)
        xPlayer.removeInventoryItem('leather2star', LeatherQuantity2)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. LeatherQuantity2 .. ' x 2 star Leathers and earned $' .. LeatherPrice * 1.25 * quality * LeatherQuantity2 .. '.', length = 12500})
    elseif LeatherQuantity3 >= 1 then
        local quality = 3
        xPlayer.addMoney(math.ceil(quality * LeatherPrice) * LeatherQuantity3)
        xPlayer.removeInventoryItem('leather3star', LeatherQuantity3)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. LeatherQuantity3 .. ' x 3 star Leathers and earned $' .. LeatherPrice * 1.5 * quality * LeatherQuantity3 .. '.', length = 12500})
    elseif LeatherQuantity4 >= 1 then
        local quality = 4
        xPlayer.addMoney(math.ceil(quality * LeatherPrice) * LeatherQuantity4)
        xPlayer.removeInventoryItem('leather4star', LeatherQuantity4)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. LeatherQuantity4 .. ' x 4 star Leathers and earned $' .. LeatherPrice * 2 * quality * LeatherQuantity4 .. '.', length = 12500})
    elseif LeatherQuantity5 >= 1 then
        local quality = 5
        xPlayer.addMoney(math.ceil(quality * LeatherPrice) * LeatherQuantity5)
        xPlayer.removeInventoryItem('leather5star', LeatherQuantity5)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have sold ' .. LeatherQuantity5 .. ' x 5 star Leathers and earned $' .. LeatherPrice * 2.5 * quality * LeatherQuantity5 .. '.', length = 12500})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You don\'t have any leather to sell?'})
    end
end)
