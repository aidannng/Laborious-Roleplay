ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('labrp_fish:getreward')
AddEventHandler('labrp_fish:getreward', function(fish)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = math.random(1, 3)
    xPlayer.addInventoryItem(fish, quantity)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have caught '..quantity..' '..fish, })
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
    local sharkmoney = math.random(500, 750)
    local turtlemoney = math.random(750, 1000)

    if Shark >= 1 then
        xPlayer.removeInventoryItem('Shark', Shark)
        xPlayer.addInventoryItem('black_money', sharkmoney * Shark)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have sold '..Shark..' Sharks for $'..sharkmoney * Shark, })
    elseif Turtle >= 1 then
        xPlayer.removeInventoryItem('Turtle', Turtle)
        xPlayer.addInventoryItem('black_money', turtlemoney * Turtle)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have sold '..Turtle..' Turtles for $'..turtlemoney * Turtle, })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You have nothing to sell!', })
    end
end)


RegisterNetEvent('labrp_fish:sell')
AddEventHandler('labrp_fish:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local Fish = xPlayer.getInventoryItem('Fish').count
    local FishMoney = math.random(200, 400)

    if Fish >= 1 then
        xPlayer.removeInventoryItem('Fish', Fish)
        xPlayer.addInventoryItem('money', FishMoney * Fish)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have sold '..Fish..' Fish for $'..FishMoney * Fish, })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You have nothing to sell!', })
    end
end)
