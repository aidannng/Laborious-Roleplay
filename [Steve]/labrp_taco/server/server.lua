ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('labrp_taco:givereward')
AddEventHandler('labrp_taco:givereward', function()
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(math.random(250, 500))
    dirty = xPlayer.getInventoryItem('black_money').count
    percent = math.random(30, 50)

    if dirty > 0 then
        xPlayer.removeInventoryItem('black_money', dirty//percent)
        xPlayer.addMoney(dirty//percent)
    end
end)
