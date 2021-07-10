ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local display = false

RegisterNetEvent("billing:refreshui")
AddEventHandler("billing:refreshui", function()
    SetDisplay(true)
    TriggerServerEvent("getmybills")
end)

RegisterNetEvent("billing:getbills")
AddEventHandler("billing:getbills", function()
    SetDisplay(not display)
    TriggerServerEvent("getmybills")
end)

RegisterNetEvent("billing:updatebill")
AddEventHandler("billing:updatebill", function()
    SetDisplay(not display)
    TriggerServerEvent("updatebill")
end)

RegisterNetEvent("billing:createbillingrow")
AddEventHandler("billing:createbillingrow", function(a, b, c, d, f, g, h, i, j, k, l)
    SendNUIMessage({
        id=a,
        sender=b,
        label=c,
        amount=d,
        firstname=f,
        lastname=g,
        target=h,
        termlength=i,
        termamount=j,
        termdaysleft=k,
        daysoverdue=l
	})
end)

RegisterNetEvent("billing:error")
AddEventHandler("billing:error", function(a)
    SendNUIMessage({
        error=a,
    })
end)

RegisterCommand("bills", function(source)
    TriggerEvent('billing:getbills')
end)

RegisterNUICallback("updatebill", function(data)
    TriggerServerEvent('updatebill', data.billid, data.billamount)
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