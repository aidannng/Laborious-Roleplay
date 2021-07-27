ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterNetEvent("mechanic:signonoff")
AddEventHandler("mechanic:signonoff", function()
    TriggerServerEvent("jobsignonoff", "mechanic")
end)

RegisterNetEvent("pdm:signonoff")
AddEventHandler("pdm:signonoff", function()
    TriggerServerEvent("jobsignonoff", "cardealer")
end)

RegisterNetEvent("ballas:signonoff")
AddEventHandler("ballas:signonoff", function()
    TriggerServerEvent("jobsignonoff", "ballas")
end)

RegisterNetEvent("fbi:signonoff")
AddEventHandler("fbi:signonoff", function()
    TriggerServerEvent("jobsignonoff", "fbi")
end)

RegisterNetEvent("galaxy:signonoff")
AddEventHandler("galaxy:signonoff", function()
    TriggerServerEvent("jobsignonoff", "galaxy")
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

exports['labrp_Eye']:AddBoxZone("FBIDesk", vector3(110.1231, -750.2242, 242.9355), 2.00, 0.50, {
    name="FBIDesk",
    debugPoly=false,
    heading=280.0,
    minZ=241.5,
    maxZ=242.5
}, 
{
    options = {
        {
            event = "fbi:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
    },
    job = {"all"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("GalaxyDesk", vector3(389.0769, 273.2703, 95.80298), 2.00, 0.50, {
    name="GalaxyDesk",
    debugPoly=false,
    heading=125.0,
    minZ=94.5,
    maxZ=95.2
}, 
{
    options = {
        {
            event = "galaxy:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
    },
    job = {"all"},
    distance = 1.6
})