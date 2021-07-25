ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterNetEvent("mechanic:signonoff")
AddEventHandler("mechanic:signonoff", function()
    TriggerServerEvent("mechanicsignonoff")
end)

RegisterNetEvent("pdm:signonoff")
AddEventHandler("pdm:signonoff", function()
    TriggerServerEvent("pdmsignonoff")
end)

RegisterNetEvent("ballas:signonoff")
AddEventHandler("ballas:signonoff", function()
    TriggerServerEvent("ballassignonoff")
end)



exports['labrp_Eye']:AddBoxZone("BallasDesk", vector3(122.7824, -1945.833, 16.12012), 2.00, 0.50, {
    name="BallasDesk",
    debugPoly=false,
    heading=233.0,
    minZ=15.0,
    maxZ=15.2
}, 
{
    options = {
        {
            event = "ballas:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
    },
    job = {"all"},
    distance = 1.6
})