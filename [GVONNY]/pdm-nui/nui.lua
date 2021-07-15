ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local display = false

RegisterNetEvent("pdm:purchaselist")
AddEventHandler("pdm:purchaselist", function(a, b)
    SendNUIMessage({
		category=a,
        index=b,
	})
end)

RegisterNetEvent("pdm:addtopurchaselist")
AddEventHandler("pdm:addtopurchaselist", function(a, b, c, d)
    SendNUIMessage({
		subcategory=a,
        model=b,
        name=c,
        price=d,
	})
end)

RegisterNetEvent("pdm:addtostocklist")
AddEventHandler("pdm:addtostocklist", function(a, b, c, d, f, g)
    SendNUIMessage({
		stockmodel=a,
        plate=b,
        resellprice=c,
        canshowcar=d,
        finance=f,
        testdrive=g,
	})
end)

RegisterNetEvent('pdm:addtocategorydropdown')
AddEventHandler('pdm:addtocategorydropdown', function(a)
    SendNUIMessage({
		categorydropdown=a,
	})
end)

RegisterNetEvent('pdm:addtomodeldropdown')
AddEventHandler('pdm:addtomodeldropdown', function(a, b)
    SendNUIMessage({
		modeldropdown=a,
        modeldropdownname=b,
	})
end)

RegisterNetEvent('pdm:addtoshowroomlist')
AddEventHandler('pdm:addtoshowroomlist', function(a, b, c, d)
    SendNUIMessage({
		showroomslot=a,
        showroomplate=b,
        showroommodel=c,
        cantestdrive=d,
	})
end)

RegisterNetEvent("pdm:refreshshowroom")
AddEventHandler("pdm:refreshshowroom", function()
    TriggerServerEvent("getshowroom")
end)

RegisterNetEvent("pdm:addtobillinglist")
AddEventHandler("pdm:addtobillinglist", function(a,b,c,d,e,f,g)
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

RegisterNetEvent("pdm:refreshbilllist")
AddEventHandler("pdm:refreshbilllist", function()
    TriggerServerEvent("getbills")
end)

RegisterNetEvent("pdm:billerror")
AddEventHandler("pdm:billerror", function(a)
    SendNUIMessage({
		error=a,
	})
end)

RegisterNetEvent("pdm:despawnvehicle")
AddEventHandler("pdm:despawnvehicle", function(x, y, z)
    coords = vector3(x,y,z)
    local slotvehicle = ESX.Game.GetClosestVehicle(coords)
    local vehicle =  ESX.Game.DeleteVehicle(slotvehicle)

    
end)

RegisterNetEvent("pdm:spawnvehicle")
AddEventHandler("pdm:spawnvehicle", function(a, b, c, d, f, g)
    local hash = GetHashKey(d)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    g = g / 1.0
    local vehicle = CreateVehicle(hash, a, b, c, g, 1, 1)
    SetVehicleNumberPlateText(vehicle, f)
    FreezeEntityPosition(vehicle, 1)
    SetVehicleDoorsLocked(vehicle, 3)
    SetEntityInvincible(vehicle, 1);
    TriggerEvent("vehiclekeys:client:SetOwner", f, vehicle)
end)

RegisterNetEvent("pdm:spawntestdrive")
AddEventHandler("pdm:spawntestdrive", function(a, b, c, d, f, g)
    local hash = GetHashKey(d)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    g = g / 1.0
    local vehicle = CreateVehicle(hash, a, b, c, g, 1, 1)
    SetVehicleNumberPlateText(vehicle, f)
    TriggerEvent("vehiclekeys:client:SetOwner", f, vehicle)
end)

RegisterNetEvent("pdm:refreshstocklist")
AddEventHandler("pdm:refreshstocklist", function()
    SendNUIMessage({
		clearstocklist=true,
	})
    TriggerServerEvent("getallstock")
end)


--[[ RegisterCommand("pdm", function()
    TriggerEvent("pdm:menu")
end) ]]

RegisterNetEvent("pdm:menu")
AddEventHandler("pdm:menu", function()
    SetDisplay(not display)
end)

RegisterNUICallback("endtestdrive", function(data)
    TriggerServerEvent("endtestdrive", data.plate)
end)

RegisterNUICallback("spawntestdrive", function(data)
    TriggerServerEvent("spawntestdrive", data.showroomslot)
end)

RegisterNUICallback("getbills", function(data)
    TriggerServerEvent("getbills")
end)

RegisterNUICallback("createbill", function(data)
    TriggerServerEvent("createbill", data.luckyNumber, data.plateNumber, data.purchasePrice, data.termLength)
end)

RegisterNUICallback("movetoshowroom", function(data)
    TriggerServerEvent("movetoshowroom", data.slot, data.plate)
end)

RegisterNUICallback("removefromshowroom", function(data)
    TriggerServerEvent("removefromshowroom", data.showroomslot)
end)

RegisterNUICallback("getshowroom", function(data)
    TriggerServerEvent("getshowroom")
end)

RegisterNUICallback("getvehiclemodels", function(data)
    TriggerServerEvent("getvehiclemodels", data.category)
end)

RegisterNUICallback("getvehiclecategories", function(data)
    TriggerServerEvent("getvehiclecategories", data.firstload)
end)

RegisterNUICallback("getallstock", function(data)
    TriggerServerEvent("getallstock")
end)

RegisterNUICallback("getallvehicles", function(data)
    TriggerServerEvent("getallvehicles")
end)

RegisterNUICallback("purchase", function(data)
    local hash = GetHashKey(data.model)

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end

    local modelhash = RequestModel(hash)
    local newvehicle = CreateVehicle(modelhash, -17.63077, -1079.776, 26.78613, 132.0, 1, 1)
    local vehicleProps = ESX.Game.GetVehicleProperties(newvehicle)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(newvehicle)))
    ESX.Game.DeleteVehicle(newvehicle)
    
    TriggerServerEvent("purchase", data.model, data.price, vehicleProps.plate)

    TriggerServerEvent('pdmbuy', vehicleProps, "{\"damage\":10,\"fuel\":98}", data.model)
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