ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('towtruckspawn')
AddEventHandler('towtruckspawn', function()
    local spawntow = vector3(-328.50,-1520.99, 27.53)
    local currentVehicle = "flatbed"

    ESX.Game.SpawnVehicle(flatbed, spawntow, 90, function() --ESX.Game.SpawnVehicle(modelOrHash, coords, heading, cb)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleColours(vehicle, 112, 112)
    end)
end)