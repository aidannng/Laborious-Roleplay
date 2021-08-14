ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('labrp_vicodin:checkmoney', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 1000 then
        callback(true)
        xPlayer.removeMoney(1000)
    else
        callback(false)
    end
end)

RegisterServerEvent('labrp_vicodin:payout')
AddEventHandler('labrp_vicodin:payout', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local dirtymoney = math.random(200, 500)
    local pills = math.random(1, 4)

    xPlayer.addInventoryItem('black_money', dirtymoney)
    xPlayer.addInventoryItem('vicodin', pills)
end)

RegisterServerEvent('labrp_vicodin:tradein')
AddEventHandler('labrp_vicodin:tradein', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = math.random(35, 60)
    local vicodin = xPlayer.getInventoryItem('vicodin').count

    xPlayer.removeInventoryItem('vicodin', vicodin)
    xPlayer.addInventoryItem('black_money', vicodin*price)
end)
