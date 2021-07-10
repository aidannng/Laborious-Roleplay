ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterNetEvent('vehcontrol:repair')
AddEventHandler('vehcontrol:repair', function()
    local veh = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    local plate = GetVehicleNumberPlateText(veh)
    
    local isPedInVehicle = GetPedInVehicleSeat(veh, -1)
    if isPedInVehicle ~= 0 then
        repairVehicle()
    else
        exports["mythic_notify"]:SendAlert("error", "Need to be inside the vehicle.")
    end
end)

function repairVehicle()
	local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, not IsPedInAnyVehicle(playerPed, false))
    SetVehicleFixed(vehicle)
    exports['mythic_notify']:SendAlert('inform', 'Fixed car') 
end