ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('steamidentifier:id', function(source, steam)
    steam(GetPlayerIdentifiers(source)[1])
end)

RegisterServerEvent('score:getplayers')
AddEventHandler('score:getplayers', function()
    TriggerClientEvent('score:returnPlayerCount', -1, #GetPlayers())
end) 

