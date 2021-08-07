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

RegisterNetEvent("racing:addtovehicledropdown")
AddEventHandler("racing:addtovehicledropdown", function(a, b)
    SendNUIMessage({
        addtovehicledropdown=true,
        model=a,
        name=b,
    })
end)

RegisterNetEvent("racing:addtotrackdropdown")
AddEventHandler("racing:addtotrackdropdown", function(a)
    SendNUIMessage({
        addtotrackdropdown=true,
        track=a,
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
AddEventHandler("racing:addmodeltotracktable", function(a, b, c, d, f, g)
    SendNUIMessage({
        addtotracktable=true,
        track=a,
        model=b,
        name=c,
        prizepool=d,
        active=f,
        laps=g,
    })
end)

RegisterCommand("trials", function(source)
    TriggerEvent('racing:menu')
end)

RegisterNUICallback("activatetrial", function(data)
    TriggerServerEvent("activatetrial", data.track, data.model)
end)

RegisterNUICallback("deactivatetrial", function(data)
    TriggerServerEvent("deactivatetrial", data.track, data.model)
end)

RegisterNUICallback("getactivetrials", function(data)
    TriggerServerEvent("getactivetrials")
end)

RegisterNUICallback("checkjob", function(data)
    TriggerServerEvent("racingcheckjob")
end)

RegisterNUICallback("deletetrial", function(data)
    TriggerServerEvent("deletetrial", data.track, data.model)
end)

RegisterNUICallback("createtrial", function(data)
    TriggerServerEvent("createtrial", data.track, data.model, data.laps)
end)

RegisterNUICallback("gettrackinfo", function(data)
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