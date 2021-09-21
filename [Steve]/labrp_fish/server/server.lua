ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('labrp_fish:getreward')
AddEventHandler('labrp_fish:getreward', function(fish)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getWeight() <= 30000 then
        local quantity = math.random(1, 30)
        if(quantity > 0 and quantity < 23) then
            quantity = 1
        elseif(quantity >= 23 and quantity < 30) then
            quantity = 2
        else
            quantity = 3
        end
        xPlayer.addInventoryItem(fish, quantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have caught '..quantity..' '..fish, })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You pockets are too full', })
    end
end)

RegisterNetEvent('labrp_fish:removebait')
AddEventHandler('labrp_fish:removebait', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('fishbait', 1)
end)


RegisterNetEvent('labrp_fish:sellillegal')
AddEventHandler('labrp_fish:sellillegal', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local Shark = xPlayer.getInventoryItem('Shark').count
    local Turtle = xPlayer.getInventoryItem('Turtle').count
    local sharkmoney = math.random(1450, 2250)
    local turtlemoney = math.random(1400, 2600)

    if Shark >= 1 then
        xPlayer.removeInventoryItem('Shark', 1)
        xPlayer.addInventoryItem('black_money', sharkmoney)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have sold '..Shark..' Sharks for $'..sharkmoney, })
    elseif Turtle >= 1 then
        xPlayer.removeInventoryItem('Turtle', 1)
        xPlayer.addInventoryItem('black_money', turtlemoney)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have sold '..Turtle..' Turtles for $'..turtlemoney, })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You have nothing to sell!', })
    end
end)


RegisterNetEvent('labrp_fish:sell')
AddEventHandler('labrp_fish:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local Fish = xPlayer.getInventoryItem('Fish').count
    local FishMoney = math.random(1290, 2150)

    if Fish >= 5 then
        xPlayer.removeInventoryItem('Fish', 5)
        xPlayer.addInventoryItem('money', FishMoney * 5)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have sold '..Fish..' Fish for $'..FishMoney * 5, })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough to sell!', })
    end
end)
