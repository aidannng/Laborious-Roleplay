ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local display = false

--[[ RegisterCommand("respray", function(source)
    TriggerEvent("mechanic:respray")
end) ]]

RegisterNetEvent("mechanic:respray")
AddEventHandler("mechanic:respray", function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		SetDisplay(not display)
	else
		exports['mythic_notify']:SendAlert('error', "You are not in a vehicle.")
	end
end)

RegisterNetEvent("respray:primary")
AddEventHandler("respray:primary", function(type, color)
    local xPlayer = PlayerPedId()
    
    local vehicleID = GetVehiclePedIsIn(xPlayer, false)

    if vehicleID ~= 0 then
        local upgrades = {color1=color}
        ESX.Game.SetVehicleProperties(vehicleID, upgrades)
        local props = ESX.Game.GetVehicleProperties(vehicleID)
        props.modLivery = GetVehicleLivery(vehicleID)
	    props.modTrimA = GetVehicleInteriorColor(vehicleID)
        props.color1 = color
        TriggerServerEvent("esx_lscustom:refreshOwnedVehicle", props)
    end
end)

RegisterNetEvent("respray:secondary")
AddEventHandler("respray:secondary", function(type, color)

    local xPlayer = PlayerPedId()
    
    local vehicleID = GetVehiclePedIsIn(xPlayer, false)

    if vehicleID ~= 0 then
        local upgrades = {color2=color}
        ESX.Game.SetVehicleProperties(vehicleID, upgrades)
        local props = ESX.Game.GetVehicleProperties(vehicleID)
        props.modLivery = GetVehicleLivery(vehicleID)
	    props.modTrimA = GetVehicleInteriorColor(vehicleID)
        props.color2 = color
        TriggerServerEvent("esx_lscustom:refreshOwnedVehicle", props)
    end
end)

RegisterNetEvent("respray:pearl")
AddEventHandler("respray:pearl", function(type, color)

    local xPlayer = PlayerPedId()
    
    local vehicleID = GetVehiclePedIsIn(xPlayer, false)

    if vehicleID ~= 0 then
        local upgrades = {pearlescentColor=color}
        ESX.Game.SetVehicleProperties(vehicleID, upgrades)
        local props = ESX.Game.GetVehicleProperties(vehicleID)
        props.modLivery = GetVehicleLivery(vehicleID)
	    props.modTrimA = GetVehicleInteriorColor(vehicleID)
        props.pearlescentColor = color
        TriggerServerEvent("esx_lscustom:refreshOwnedVehicle", props)
    end
end)

RegisterNetEvent("respray:interior")
AddEventHandler("respray:interior", function(color)

    local xPlayer = PlayerPedId()
    
    local vehicleID = GetVehiclePedIsIn(xPlayer, false)
    local props = ESX.Game.GetVehicleProperties(vehicleID)

    if vehicleID ~= 0 then
        local upgrades = {modTrimA=color}
        SetVehicleInteriorColor(vehicleID, color)
        props = ESX.Game.GetVehicleProperties(vehicleID)
        props.modLivery = GetVehicleLivery(vehicleID)
	    props.modTrimA = GetVehicleInteriorColor(vehicleID)
        TriggerServerEvent("esx_lscustom:refreshOwnedVehicle", props)
    end
end)

RegisterNetEvent("respray:wheel")
AddEventHandler("respray:wheel", function(color)

    local xPlayer = PlayerPedId()
    
    local vehicleID = GetVehiclePedIsIn(xPlayer, false)

    if vehicleID ~= 0 then
        local upgrades = {wheelColor=color}
        ESX.Game.SetVehicleProperties(vehicleID, upgrades)
        local props = ESX.Game.GetVehicleProperties(vehicleID)
        props.modLivery = GetVehicleLivery(vehicleID)
	    props.modTrimA = GetVehicleInteriorColor(vehicleID)
        props.wheelColor = color
        TriggerServerEvent("esx_lscustom:refreshOwnedVehicle", props)
    end
end)

function CheckIfInVehicle()
    local veh = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    
    local isPedInVehicle = GetPedInVehicleSeat(veh, -1)
    if isPedInVehicle ~= 0 then
        return true
    else
        return false
    end
end

RegisterNUICallback("primary", function(data)
    if CheckIfInVehicle() then
        TriggerEvent("respray:primary", data.type, data.color)
    else
        exports['mythic_notify']:SendAlert('error', 'Must be inside the vehicle.') 
    end
end)

RegisterNUICallback("secondary", function(data)
    if CheckIfInVehicle() then
        TriggerEvent("respray:secondary", data.type, data.color)
    else
        exports['mythic_notify']:SendAlert('error', 'Must be inside the vehicle.') 
    end
end)

RegisterNUICallback("pearl", function(data)
    if CheckIfInVehicle() then
        TriggerEvent("respray:pearl", data.type, data.color)
    else
        exports['mythic_notify']:SendAlert('error', 'Must be inside the vehicle.') 
    end
end)

RegisterNUICallback("interior", function(data)
    if CheckIfInVehicle() then
        TriggerEvent("respray:interior", data.color)
    else
        exports['mythic_notify']:SendAlert('error', 'Must be inside the vehicle.') 
    end
end)

RegisterNUICallback("trim", function(data)
    if CheckIfInVehicle() then
        TriggerEvent("respray:trim", data.color)
    else
        exports['mythic_notify']:SendAlert('error', 'Must be inside the vehicle.') 
    end
end)

RegisterNUICallback("wheel", function(data)
    if CheckIfInVehicle() then
        TriggerEvent("respray:wheel", data.color)
    else
        exports['mythic_notify']:SendAlert('error', 'Must be inside the vehicle.') 
    end
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