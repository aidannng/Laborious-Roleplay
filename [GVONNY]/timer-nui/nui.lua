ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local display = false

RegisterNetEvent("timer:menu")
AddEventHandler("timer:menu", function()
    SetDisplay(not display)
end)




RegisterCommand("timer", function(source)
    TriggerEvent('timer:menu')
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
	SetNuiFocus(false, false)
	SendNUIMessage({
		type="ui",
		status = bool,
	})
end

exports['PolyZone']:AddBoxZone("gokartstart", vector3(-116.0044, -2116.826, 16.69299), 14.0, 8, {
    name="gokartstart",
    heading=20,
    debugPoly=false,
})

--vector3(-123.5736, -2119.925, 16.69299)
exports['PolyZone']:AddBoxZone("gokartfinish", vector3(-123.5736, -2119.925, 16.69299), 14.0, 8, {
    name="gokartfinish",
    heading=20,
    debugPoly=false,
})

local timerstarted = false
local laps = 0
local lap = 0
local time = 0
local model = ''
local track = ''
local active = false

AddEventHandler('bt-polyzone:enter', function(name)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if(vehicle ~= 0) then
        local props = ESX.Game.GetVehicleProperties(vehicle)
        local hash = props.model
        local model = GetDisplayNameFromVehicleModel(hash)
        if(model == "CADDY") then
            model = "CADDY2"
        end

        if name == "gokartstart" then
            ESX.TriggerServerCallback('trialisactive', function(isactive)
                if isactive then
                    active = true
                end
            end, "gokart", model)
    
            ESX.TriggerServerCallback('gettriallaps', function(dblaps, dbtrack, dbmodel)
                laps = dblaps
                track = dbtrack
                modal = dbmodel
            end, "gokart", model)

            Citizen.Wait(200)
            if(active) then
                if lap == 0 then
                    lap = lap + 1
                    TriggerEvent("starttimer", true)
                    UpdateLaps()
                    SetDisplay(true)
                end
            end
        elseif name == "gokartfinish" then
            if(active) then
                if lap < laps then
                    lap = lap + 1
                    UpdateLaps()
                else
                    TriggerEvent("starttimer", false)
                    TriggerServerEvent("deactivatetrial", "gokart", model)
                    UpdateLaps()
                    SendNUIMessage({
                        gettime=true,
                        time=time*1.5,
                        model=model,
                        track=track,
                    })
                    Citizen.Wait(7000)
                    SetDisplay(false)
                    lap = 0
                    time = 0
                    laps = 0
                    active = false
                end
            end
        end
    end
end)
    
function UpdateLaps()
    SendNUIMessage({
        updatelaps = true,
        lap=lap,
        laps=laps,
        time=time*1.5,
    })
end

AddEventHandler('bt-polyzone:exit', function(name)
    --[[ if name == "gokartfinish" then
        if(active) then
            if lap < laps then
                lap = lap + 1
                UpdateLaps()
            else
                TriggerEvent("starttimer", false)
                TriggerServerEvent("deactivatetrial", "gokart", model)
                UpdateLaps()
                SendNUIMessage({
                    gettime=true,
                    time=time*1.5,
                    model=model,
                    track=track,
                })
                Citizen.Wait(7000)
                SetDisplay(false)
                lap = 0
                time = 0
                laps = 0
                active = false
            end
        end
    end ]]
end)

RegisterNetEvent("starttimer")
AddEventHandler("starttimer", function(toggle)
    timerstarted = toggle

    while time >= 0 and timerstarted do
        Citizen.Wait(1)
        time = time + 1
        SendNUIMessage({
            updatetime = true,
            time=time*1.5,
        })
    end
    if not timerstarted then
        time = time - 1
        SendNUIMessage({
            updatetime = true,
            time=time*1.5,
        })
    end
end)

RegisterNUICallback("createtrialtime", function(data)
    TriggerServerEvent("createtrialtime", data.track, data.model, data.minutes, data.seconds, data.milliseconds)
end)