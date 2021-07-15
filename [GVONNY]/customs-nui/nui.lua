ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local display = false

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



--[[ RegisterCommand("customs", function(source)
    TriggerEvent('mechanic:customs')
end) ]]

RegisterNUICallback("getlscbills", function(data)
	TriggerServerEvent("getlscbills")
end)

RegisterNUICallback("createbill", function(data)
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