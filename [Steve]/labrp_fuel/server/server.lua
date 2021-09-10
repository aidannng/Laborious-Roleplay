ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('labrp_fuel:checkmoney', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

    if money >= 100 then
        callback(true)
    else
        callback(false)
    end
end)

RegisterServerEvent('labrp_fuel:takemoney')
AddEventHandler('labrp_fuel:takemoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(100)
end)