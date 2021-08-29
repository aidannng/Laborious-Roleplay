ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('labrp_pdvehicles:checkmoney', function(source, callback, RequiredMoney)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= RequiredMoney then
        callback(true)
    else
        callback(false)
    end
end)

RegisterServerEvent('labrp_pdvehicles:takemoney')
AddEventHandler('labrp_pdvehicles:takemoney', function(price)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(price)
end)





