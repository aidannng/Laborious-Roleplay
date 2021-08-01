ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local display = false

RegisterNetEvent("racing:menu")
AddEventHandler("racing:menu", function()
    SetDisplay(not display)
end)

RegisterNetEvent("racing:setupvehicletable")
AddEventHandler("racing:setupvehicletable", function(a, b, c)
    SendNUIMessage({
        setupvehicletable=true,
        model=a,
        name=b,
        track=c,
    })
end)

RegisterNetEvent("racing:addtodropdown")
AddEventHandler("racing:addtodropdown", function(a, b, c)
    SendNUIMessage({
        addtodropdown=true,
        model=a,
        name=b,
        track=c,
    })
end)

RegisterNetEvent("racing:addtomodel")
AddEventHandler("racing:addtomodel", function(a, b, c, d, f, g, h)
    SendNUIMessage({
        addtomodel=true,
        firstname=a,
        lastname=b,
        minutes=c,
        seconds=d,
        milliseconds=f,
        model=g,
        place=h,
    })
end)

RegisterNetEvent("racing:error")
AddEventHandler("racing:error", function(a, b)
    SendNUIMessage({
        error=true,
        track=a,
        text=b,
    })
end)

RegisterNetEvent("racing:hideadminfunctions")
AddEventHandler("racing:hideadminfunctions", function(a)
    SendNUIMessage({
        hide=a,
    })
end)

RegisterNetEvent("racing:setuptracktable")
AddEventHandler("racing:setuptracktable", function(a)
    SendNUIMessage({
        setuptracktable=true,
        track=a,
    })
end)

RegisterNetEvent("racing:addmodeltotracktable")
AddEventHandler("racing:addmodeltotracktable", function(a, b, c)
    SendNUIMessage({
        addtotracktable=true,
        track=a,
        model=b,
        name=c,
    })
end)


RegisterCommand("trials", function(source)
    TriggerEvent('racing:menu')
end)

RegisterNUICallback("getactivetrials", function(data)
    TriggerServerEvent("getactivetrials")
end)

RegisterNUICallback("checkjob", function(data)
    TriggerServerEvent("racingcheckjob")
end)

RegisterNUICallback("createtrial", function(data)
    TriggerServerEvent("createtrial", data.track, data.luckyNumber, data.model, data.minutes, data.seconds, data.milliseconds)
end)

RegisterNUICallback("gettrackinfo", function(data)
    print(data.track)
    TriggerServerEvent("racinggettrackinfo", data.track)
end)

RegisterNUICallback("error", function(data)
	SetDisplay(false)
end)

RegisterNUICallback("exit", function(data)
	SetDisplay(false)
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

function SetDisplay(bool)
	display = bool
	--<bool> allow mouse, <bool> focus nui
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type="ui",
		status = bool,
	})
end

-- CRAFTIN WORK BENCHES --

exports['labrp_Eye']:AddBoxZone("BenchV1", vector3(-346.6813, -111.2703, 38.84473), 0.72, 3.95, {
    name="BenchV1",
    debugPoly=false,
    heading=250.0,
    minZ=38.5,
    maxZ=39.0
}, 
{
    options = {
        {
            event = "mechanic:crafting",
            icon = "fas fa-tools",
            label = "Crafting Bench",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("BenchV2", vector3(-322.2066, -146.4527, 38.84473), 0.72, 3.95, {
    name="BenchV2",
    debugPoly=false,
    heading=250.0,
    minZ=38.5,
    maxZ=39.0
}, 
{
    options = {
        {
            event = "mechanic:crafting",
            icon = "fas fa-tools",
            label = "Crafting Bench",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("BenchV3", vector3(-310.2725, -113.644, 38.84473), 0.72, 3.95, {
    name="BenchV3",
    debugPoly=false,
    heading=250.0,
    minZ=38.5,
    maxZ=39.0
}, 
{
    options = {
        {
            event = "mechanic:crafting",
            icon = "fas fa-tools",
            label = "Crafting Bench",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("BenchV4", vector3(-339.0461, -90.09231, 38.84473), 0.72, 3.95, {
    name="BenchV4",
    debugPoly=false,
    heading=340.0,
    minZ=38.5,
    maxZ=39.0
}, 
{
    options = {
        {
            event = "mechanic:crafting",
            icon = "fas fa-tools",
            label = "Crafting Bench",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})

exports['labrp_Eye']:AddBoxZone("BenchV5", vector3(-367.1472, -79.85934, 38.84473), 0.72, 3.95, {
    name="BenchV5",
    debugPoly=false,
    heading=340.0,
    minZ=38.5,
    maxZ=39.0
}, 
{
    options = {
        {
            event = "mechanic:crafting",
            icon = "fas fa-tools",
            label = "Crafting Bench",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})--  -341.5253, -163.0417, 46.68567

exports['labrp_Eye']:AddBoxZone("ToggleDuty", vector3(-341.4521, -162.978, 45.68567), 1.02, 0.80, {
    name="ToggleDuty",
    debugPoly=false,
    heading=180.0,
    minZ=44.0,
    maxZ=45.8
}, 
{
    options = {
        {
            event = "mechanic:signonoff",
            icon = "fas fa-tools",
            label = "Sign On/Off",
        },
        {
            event = "personallocker",
            icon = "fas fa-tools",
            label = "Open Locker",
        },
    },
    job = {"all"},
    distance = 1.6
})

RegisterNetEvent('personallocker')
AddEventHandler('personallocker', function()
    exports['linden_inventory']:OpenStash({ id = 'Employee Locker', slots = 10, job = 'mechanic', owner = true})
end)---319.1209, -137.7231, 40.19849


exports['labrp_Eye']:AddBoxZone("StorageV1", vector3(-319.1209, -137.7231, 38.84473), 0.72, 3.75, {
    name="StorageV1",
    debugPoly=false,
    heading=250.0,
    minZ=38.0,
    maxZ=39.5
}, 
{
    options = {
        {
            event = "storageV1",
            icon = "fas fa-tools",
            label = "Storage",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})

RegisterNetEvent('storageV1')
AddEventHandler('storageV1', function()
    exports['linden_inventory']:OpenStash({ id = 'Mechanic Storage - 1', slots = 30, job = 'mechanic', owner = false})
end)

exports['labrp_Eye']:AddBoxZone("StorageV2", vector3(-316.4176, -130.6418, 38.84473), 0.72, 3.75, {
    name="StorageV2",
    debugPoly=false,
    heading=250.0,
    minZ=38.0,
    maxZ=40.0
}, 
{
    options = {
        {
            event = "storageV2",
            icon = "fas fa-tools",
            label = "Storage",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})

RegisterNetEvent('storageV2')
AddEventHandler('storageV2', function()
    exports['linden_inventory']:OpenStash({ id = 'Mechanic Storage - 2', slots = 30, job = 'mechanic', owner = false})
end)

exports['labrp_Eye']:AddBoxZone("StorageV3", vector3(-308.6242, -109.2132, 38.84473), 0.72, 3.05, {
    name="StorageV3",
    debugPoly=false,
    heading=250.0,
    minZ=38.0,
    maxZ=40.0
}, 
{
    options = {
        {
            event = "storageV3",
            icon = "fas fa-tools",
            label = "Storage",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})

RegisterNetEvent('storageV3')
AddEventHandler('storageV3', function()
    exports['linden_inventory']:OpenStash({ id = 'Mechanic Storage - 3', slots = 30, job = 'mechanic', owner = false})
end)

RegisterNetEvent('mechsign')
AddEventHandler('mechsign', function()
    TriggerServerEvent('mechduty:onoff')
end)

exports['labrp_Eye']:AddBoxZone("StorageV4", vector3(-353.4725, -129.8769, 38.84473), 0.72, 3.05, {
    name="StorageV4",
    debugPoly=false,
    heading=250.0,
    minZ=38.0,
    maxZ=40.0
}, 
{
    options = {
        {
            event = "storageV4",
            icon = "fas fa-tools",
            label = "Storage",
        },
    },
    job = {"mechanic"},
    distance = 1.6
})

RegisterNetEvent('storageV4')
AddEventHandler('storageV4', function()
    exports['linden_inventory']:OpenStash({ id = 'Mechanic Storage - 4', slots = 30, job = 'mechanic', owner = false})
end)