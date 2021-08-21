ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('labrp_taco:givereward')
AddEventHandler('labrp_taco:givereward', function()
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(math.random(150, 400))
end)
