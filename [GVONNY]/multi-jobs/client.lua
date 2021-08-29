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

RegisterNetEvent("bigdogs:signonoff")
AddEventHandler("bigdogs:signonoff", function()
    TriggerServerEvent("jobsignonoff", "bigdogs")
end)

RegisterNetEvent("sonora:signonoff")
AddEventHandler("sonora:signonoff", function()
    TriggerServerEvent("jobsignonoff", "sonora")
end)

RegisterNetEvent("notolerance:signonoff")
AddEventHandler("notolerance:signonoff", function()
    TriggerServerEvent("jobsignonoff", "notolerance")
end)

RegisterNetEvent("zerohes:signonoff")
AddEventHandler("zerohes:signonoff", function()
    TriggerServerEvent("jobsignonoff", "zerohes")
end)

exports['labrp_Eye']:AddBoxZone("BallasDesk", vector3(126.4615, -1955.222, 20.2821), 2.00, 0.50, {
    name="BallasDesk",
    debugPoly=false,
    heading=233.0,
    minZ=20.0,
    maxZ=21.2
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

exports['labrp_Eye']:AddBoxZone("BigDogsDesk", vector3(989.0242, -135.7055, 74.8418), 2.00, 0.50, {
    name="BigDogsDesk",
    debugPoly=false,
    heading=150.0,
    minZ=73.5,
    maxZ=74.2
}, 
{
    options = {
        {
            event = "bigdogs:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
    },
    job = {"all"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("SonoraDesk", vector3(-163.7802, 902.1495, 233.9714), 2.00, 0.50, {
    name="SonoraDesk",
    debugPoly=false,
    heading=136.0,
    minZ=232.8,
    maxZ=233.9
}, 
{
    options = {
        {
            event = "sonora:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
    },
    job = {"all"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("SonoraDesk", vector3(-163.7802, 902.1495, 233.9714), 2.00, 0.50, {
    name="SonoraDesk",
    debugPoly=false,
    heading=136.0,
    minZ=232.8,
    maxZ=233.9
}, 
{
    options = {
        {
            event = "sonora:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
    },
    job = {"all"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("NotoriousDesk", vector3(939.6132, -1489.635, 30.20654), 2.00, 0.50, {
    name="NotoriousDesk",
    debugPoly=false,
    heading=95.0,
    minZ=28.8,
    maxZ=31.9
}, 
{
    options = {
        {
            event = "notolerance:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
    },
    job = {"all"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("ZeroHesBox", vector3(61.96484, -2566.47, 7.240234), 1.75, 0.8, {
    name="ZeroHesBox",
    debugPoly=false,
    heading=90.0,
    minZ=5.1,
    maxZ=6.5
}, 
{
    options = {
        {
            event = "zerohes:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
    },
    job = {"all"},
    distance = 1.6
})