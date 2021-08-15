ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local display = false

RegisterCommand("impound", function(source, args)
    TriggerServerEvent("impound:vehicle", args[1])
end)

RegisterNetEvent("local:inspect")
AddEventHandler("local:inspect", function()
    TriggerServerEvent('checktoolbox')
end)

RegisterNetEvent("mechanic:inspect")
AddEventHandler("mechanic:inspect", function()
    TriggerEvent('advanced_vehicles:showStatusUI')
end)


RegisterNetEvent("mechanic:customs")
AddEventHandler("mechanic:customs", function()
    SetDisplay(not display)
end)

RegisterNetEvent("lsc:billerror")
AddEventHandler("lsc:billerror", function(a)
    SendNUIMessage({
		error=a,
	})
end)

RegisterNetEvent("lsc:addtobillinglist")
AddEventHandler("lsc:addtobillinglist", function(a,b,c,d,e,f,g)
    SendNUIMessage({
		firstname=a,
        lastname=b,
        employeefirstname=c,
        employeelastname=d,
        amount=e,
        termlength=f,
        daysoverdue=g,
	})
end)

RegisterNetEvent("lsc:refreshbilling")
AddEventHandler("lsc:refreshbilling", function(a)
    TriggerServerEvent("getlscbills")
end)


RegisterNetEvent("lsc:addemployeetolist")
AddEventHandler("lsc:addemployeetolist", function(a, b, c, d, f, g)
    SendNUIMessage({
		jobgrade=a,
        employeefirstname=b,
        employeelastname=c,
        identifier=d,
        isowner=f,
        balance=g,
	})
end)


--[[ RegisterCommand("customs", function(source)
    TriggerEvent('mechanic:customs')
end) ]]

RegisterNUICallback("lscwithdraw", function(data)
    TriggerServerEvent("lscwithdraw", data.amount)
end)

RegisterNUICallback("lscdeposit", function(data)
    TriggerServerEvent("lscdeposit", data.amount)
end)

RegisterNUICallback("lscrefresh", function(data)
    TriggerServerEvent("lscrefresh", data.identifier, data.grade)
end)

RegisterNUICallback("lscpay", function(data)
    TriggerServerEvent("lscpay", data.identifier, data.amount)
end)

RegisterNUICallback("lscpromote", function(data)
    TriggerServerEvent("lscpromote", data.identifier, data.grade)
end)

RegisterNUICallback("lscdemote", function(data)
    TriggerServerEvent("lscdemote", data.identifier, data.grade)
end)

RegisterNUICallback("lscfire", function(data)
    TriggerServerEvent("lscfire", data.identifier)
end)

RegisterNUICallback("lschire", function(data)
    TriggerServerEvent("lschire", data.luckynumber)
end)

RegisterNUICallback("getbossinfo", function(data)
	TriggerServerEvent("lscgetbossinfo")
end)

RegisterNUICallback("getlscbills", function(data)
	TriggerServerEvent("getlscbills")
end)

RegisterNUICallback("lsccreatebill", function(data)
	TriggerServerEvent("lsccreatebill", data.luckyNumber, data.purchasePrice, data.termLength)
end)

RegisterNUICallback("buymaterial", function(data)
    TriggerServerEvent("buymaterial", data.part, data.price, data.amount)
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