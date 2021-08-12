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

