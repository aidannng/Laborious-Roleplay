ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('labrp_carwash:checkMoney')
AddEventHandler('labrp_carwash:checkMoney', function(price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    price = tonumber(price)
    if price < xPlayer.getAccount('bank').money then
        TriggerClientEvent('labrp_carwash:clean', _source)
        xPlayer.removeAccountMoney('bank', price)
    elseif price < xPlayer.getMoney() then
        TriggerClientEvent('labrp_carwash:clean', _source)
        xPlayer.removeMoney(price)
    elseif price < xPlayer.getAccount('bank').money + xPlayer.getMoney() then
        TriggerClientEvent('labrp_carwash:clean', _source)
        local bankPrice = xPlayer.getAccount('bank').money
        xPlayer.removeAccountMoney('bank', bankPrice)
        local cashPrice = price - bankPrice
        xPlayer.removeMoney(cashPrice)
    else
        TriggerClientEvent('labrp_carwash:cancel', _source)
    end
end)

