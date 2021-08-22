ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('cvpimoney')
AddEventHandler('cvpimoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 12500 then
        TriggerClientEvent('cvpispawn', source)
        xPlayer.removeInventoryItem('money', 12500)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Congratulations!', })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You don\'t have enough money!', })
    end
end)

RegisterNetEvent('fpismoney')
AddEventHandler('fpismoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 25000 then
        TriggerClientEvent('fpisspawn', source)
        xPlayer.removeInventoryItem('money', 25000)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Congratulations!', })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You don\'t have enough money!', })
    end
end)

RegisterNetEvent('tahoemoney')
AddEventHandler('tahoemoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 30000 then
        TriggerClientEvent('tahoespawn', source)
        xPlayer.removeInventoryItem('money', 30000)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Congratulations!', })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You don\'t have enough money!', })
    end
end)

RegisterNetEvent('bmwmoney')
AddEventHandler('bmwmoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 25000 then
        TriggerClientEvent('bmwspawn', source)
        xPlayer.removeInventoryItem('money', 25000)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Congratulations!', })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You don\'t have enough money!', })
    end
end)

RegisterNetEvent('rammoney')
AddEventHandler('rammoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 35000 then
        TriggerClientEvent('ramspawn', source)
        xPlayer.removeInventoryItem('money', 35000)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Congratulations!', })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You don\'t have enough money!', })
    end
end)--helimoney

RegisterNetEvent('chargmoney')
AddEventHandler('chargmoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 50000 then
        TriggerClientEvent('chargspawn', source)
        xPlayer.removeInventoryItem('money', 50000)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Congratulations!', })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You don\'t have enough money!', })
    end
end)

-- RegisterNetEvent('helimoney')
-- AddEventHandler('helimoney', function()
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local money = xPlayer.getInventoryItem('money').count

--     if money >= 5000 then
--         TriggerClientEvent('helispawn', source)
--         xPlayer.removeInventoryItem('money', 5000)
--         TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Congratulations!', })
--     else
--         TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You don\'t have enough money!', })
--     end
-- end) --refundpdheli

RegisterNetEvent('helimoney')
AddEventHandler('helimoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('helispawn', source)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Congratulations!', })
end) --refundpdheli

RegisterNetEvent('refundpdheli')
AddEventHandler('refundpdheli', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local tax = math.random(100, 500)
    local newval = 5000 - tax
    xPlayer.addInventoryItem('money', 5000)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You\'ve been refuned $'..newval, })
end)









































RegisterNetEvent('checklsckeys')
AddEventHandler('checklsckeys', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local keys = xPlayer.getInventoryItem('mechanic_truck_key').count

    if keys > 0 then
        TriggerClientEvent('spawnlsctruck', source)
        xPlayer.removeInventoryItem('mechanic_truck_key', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'UH OH You don\'t have keys', })
    end
end)

--xPlayer.addMoney(quality * RubberPrice * RubberQuantity)
--returnLSCKeys

RegisterNetEvent('returnLSCKeys')
AddEventHandler('returnLSCKeys', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('mechanic_truck_key', 1)
end)


