ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Server event for payment
RegisterNetEvent('luke_garbagejob:Payment')
AddEventHandler('luke_garbagejob:Payment', function(level)
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount

    if level == 1 then
        amount = Config.LevelOneAmount
    elseif level == 2 then
        amount = Config.LevelTwoAmount
    else
        amount = Config.LevelMaxAmount
    end

    if Config.PaymentInCash == true then
        xPlayer.addMoney(amount)
    else
        xPlayer.addAccountMoney('bank', amount)
    end
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '$'..amount..' has been deposited into your bank for collecting garbage', })end)