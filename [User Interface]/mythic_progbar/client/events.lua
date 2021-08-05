RegisterNetEvent("mythic_progbar:client:progress")
AddEventHandler("mythic_progbar:client:progress", function(action, finish)
	Process(action, nil, nil, finish)
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithStartEvent")
AddEventHandler("mythic_progbar:client:ProgressWithStartEvent", function(action, start, finish)
	Process(action, start, nil, finish)
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithTickEvent")
AddEventHandler("mythic_progbar:client:ProgressWithTickEvent", function(action, tick, finish)
	Process(action, nil, tick, finish)
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithStartAndTick")
AddEventHandler("mythic_progbar:client:ProgressWithStartAndTick", function(action, start, tick, finish)
	Process(action, start, tick, finish)
end)

RegisterNetEvent("mythic_progbar:client:cancel")
AddEventHandler("mythic_progbar:client:cancel", function()
	Cancel()
end)

RegisterNUICallback('actionFinish', function(data, cb)
	Finish()
end)


RegisterCommand('progtest', function()
	exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 5000,
        label = 'Testing',
        useWhileDead = true,
        canCancel = false,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        },
    })
end, false)

