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

local gokart = {}

local CheckPoints = {}
CheckPoints[1] =  	{ x = 1120.998, y = -3105.323, z = -12.27185, type = 13}
CheckPoints[2] =	{ x = 1066.18, y = -3094.681, z = -12.27185, type = 13}
CheckPoints[3] =	{ x = 1050.633, y = -3207.561, z = -12.27185, type = 13}
CheckPoints[4] =	{ x = 1029.27, y = -3117.336, z = -12.27185, type = 13}
CheckPoints[5] =	{ x = 857.9868, y = -3121.991, z = -12.27185, type = 13}
CheckPoints[6] =	{ x = 911.1824, y = -3147.02, z = -12.27185, type = 13}
CheckPoints[7] =	{ x = 862.7209, y = -3166.695, z = -12.27185, type = 13}
CheckPoints[8] =	{ x = 868.5494, y = -3307.424, z = -12.27185, type = 13}
CheckPoints[9] =	{ x = 887.3011, y = -3243.534, z = -12.27185, type = 13}
CheckPoints[10] =	{ x = 994.6945, y = -3231.27, z = -12.27185, type = 13}
CheckPoints[11] =	{ x = 1000.51, y = -3167.116, z = -12.27185, type = 13}
CheckPoints[12] =	{ x = 953.2879, y = -3164.545, z = -12.27185, type = 13}
CheckPoints[13] =	{ x = 948.778, y = -3276.818, z = -12.27185, type = 13}
CheckPoints[14] =	{ x = 1017.31, y = -3261.732, z = -12.27185, type = 13}
CheckPoints[15] =	{ x = 1124.716, y = -3294.33, z = -12.27185, type = 13}
CheckPoints[16] =	{ x = 1094.782, y = -3302.756, z = -12.27185, type = 13}
CheckPoints[17] =  	{ x = 1092.765, y = -3207.099, z = -12.27185, type = 16}


exports['PolyZone']:AddBoxZone("gokartfinish", vector3(-123.5736, -2119.925, 16.69299), 14.0, 8, {
    name="gokartfinish",
    heading=20,
    debugPoly=false,
})

exports['PolyZone']:AddBoxZone("undergroundfinish", vector3(1092.198, -3219.837, -12.27185), 18.0, 24, {
    name="undergroundfinish",
    heading=90,
    debugPoly=false,
})

local timerstarted = false
local active = false
local starttime = 0
local time = 0
local laps = 0
local lap = 0
local model = ''
local track = ''
local cP = 1
local cP2 = 2
local checkpoint
local blip
local driver

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "gokartfinish" or name == "undergroundfinish" then
        if name == "gokartfinish" then
            track = "gokart"
        elseif name == "undergroundfinish" then
            track = "underground"
        end

        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if(vehicle ~= 0) then
            driver = GetPedInVehicleSeat(vehicle, 1)
            local props = ESX.Game.GetVehicleProperties(vehicle)
            local hash = props.model
            model = GetDisplayNameFromVehicleModel(hash)
            if(model == "CADDY") then
                model = "CADDY2"
            end
            TriggerEvent("checktrialactive")
        end
    end
end)

RegisterNetEvent("checktrialactive")
AddEventHandler("checktrialactive", function()
    while not active do
        Wait(250)
        ESX.TriggerServerCallback('trialisactive', function(isactive)
            if isactive then
                active = true
            end
        end, track, model)

        ESX.TriggerServerCallback('gettriallaps', function(dblaps, dbtrack)
            laps = dblaps
            track = dbtrack
        end, track, model)
    end
end)
    
function UpdateLaps()
    SendNUIMessage({
        updatelaps = true,
        lap=lap,
        laps=laps,
        time=formatTimer(starttime, GetGameTimer())
    })
end

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "gokartfinish" or name == "undergroundfinish" then
        if active then
            if lap == 0 then
                lap = lap + 1
                TriggerEvent("starttimer", true, name)

                UpdateLaps()
                SetDisplay(true)
                TriggerServerEvent("deactivatetrial", track, model)
            elseif lap < laps then
                lap = lap + 1
                UpdateLaps()
                cp = 1
                cp2 = 2
                TriggerEvent("drawcheckpoint")
            else
                active = false
                Citizen.Wait(7000)
                SetDisplay(false)
                lap = 0
                time = 0
                laps = 0
            end
        end
    end
end)

RegisterNetEvent("starttimer")
AddEventHandler("starttimer", function(toggle, name)
    timerstarted = toggle
    if(timerstarted) then
        starttime = GetGameTimer()
        TriggerEvent("drawcheckpoint")
    end

    while time >= 0 and timerstarted do
        Wait(10)
        SendNUIMessage({
            updatetime=true,
            time=formatTimer(starttime, GetGameTimer()),
        })

        if GetDistanceBetweenCoords(CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
            if CheckPoints[cP].type == 13 then
                DeleteCheckpoint(checkpoint)
                RemoveBlip(blip)
                PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
                cP = cP + 1
                if(CheckPoints[cP].type == 13) then
                    cP2 = cP2+1
                end
                
                checkpoint = CreateCheckpoint(CheckPoints[cP].type, CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z + 2, CheckPoints[cP2].x, CheckPoints[cP2].y, CheckPoints[cP2].z + 2, 8.0, 204, 204, 1, 100, 0)
                blip = AddBlipForCoord(CheckPoints[cP].x, CheckPoints[cP].y, CheckPoints[cP].z)
            else
                PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
                DeleteCheckpoint(checkpoint)
                RemoveBlip(blip)
                if(lap == laps) then
                    TriggerEvent("starttimer", false)
                    UpdateLaps()
                    if(GetPlayerPed(-1) == driver) then
                        SendNUIMessage({
                            gettime=true,
                            time=formatTimer(starttime, GetGameTimer()),
                            model=model,
                            track=track
                        })
                    end
                end
                cP = 1
                cP2 = 2
            end
        end
    end
    if not timerstarted then
        SendNUIMessage({
            updatetime = true,
            time=formatTimer(starttime, GetGameTimer()),
        })
    end
end)

RegisterNetEvent("drawcheckpoint")
AddEventHandler("drawcheckpoint", function()
    checkpoint = CreateCheckpoint(CheckPoints[cP].type, CheckPoints[cP].x,  CheckPoints[cP].y,  CheckPoints[cP].z + 2, CheckPoints[cP2].x, CheckPoints[cP2].y, CheckPoints[cP2].z + 2, 8.0, 204, 204, 1, 100, 0)
    blip = AddBlipForCoord(CheckPoints[cP].x, CheckPoints[cP].y, CheckPoints[cP].z)
end)

function formatTimer(startTime, currTime)
    local newString = currTime - startTime
    return newString
end

RegisterNUICallback("createtrialtime", function(data)
    TriggerServerEvent("createtrialtime", data.track, data.model, data.minutes, data.seconds, data.milliseconds)
end)


