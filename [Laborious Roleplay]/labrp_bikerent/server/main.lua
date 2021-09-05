ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('labrp_bikerent:checkmoney', function(source, cb, price)
    local ply = ESX.GetPlayerFromId(source)
    money = ply.getInventoryItem('money').count

    if money >= price then
        cb(true)
		ply.removeInventoryItem('money', price)
    else
        cb(false)
    end
end)

RegisterNetEvent('labrp_bikerent:returnfee')
AddEventHandler('labrp_bikerent:returnfee', function(price)
    local ply = ESX.GetPlayerFromId(source)
    local returnprice = price - math.random(15, 30)

    ply.addInventoryItem('money', returnprice)
end)