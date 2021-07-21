-- ESX Stuff (DON'T TOUCH!!!)
ESX = nil 

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
		PlayerData = ESX.GetPlayerData() 
end) 
 
RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	PlayerData = xPlayer 
end) 
 
RegisterNetEvent('esx:setJob') 
AddEventHandler('esx:setJob', function(job) 
	PlayerData.job = job 
end) 

Citizen.CreateThread(function() 
	exports["labrp_Eye"]:AddBoxZone("PBCheckIn", vector3(307.5428, -595.3055, 43.30767), 0.3, 0.4, { -- -1197.64, -899.433, 14.90698
		name="PBCheckIn",
		heading=70,
		debugPoly=false,
		minZ=43.0,
		maxZ=43.5
		}, {
		options = {
			{
				event = "checkinEye",
				icon = "fas fa-hospital",
				label = "Check In - $500",
			},
		},
		job = {"all"},
		distance = 2.0
	})
end) 

RegisterNetEvent('checkinEye') 
AddEventHandler('checkinEye', function() 
	TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Checking In",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
        },
        prop = {
            model = "prop_fib_clipboard",
        }
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
	Citizen.Wait(10000)
	TriggerEvent('esx_checkin:checkIn')
end)



-- Main Event
RegisterNetEvent('esx_checkin:checkIn')
AddEventHandler('esx_checkin:checkIn', function()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	local head = GetEntityHeading(ped)
	local chance = math.random(1,8)
	local source = source
	TriggerEvent('checkinReviveCheck')
	Citizen.Wait(200)

	-- Bed 1
	if chance == 1 then
		print(chance)
		DoScreenFadeOut(500)
		Citizen.Wait(550)
		TriggerEvent('esx_ambulancejob:revive')
		Citizen.Wait(1500)
		DoScreenFadeIn(500)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', 322.6682, -587.1297, 43.30 + 1, 160, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 20000)
		Citizen.Wait(35000)
		exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', 'Press [F] to get out of bed.')
		while true do 
			Citizen.Wait(0)
			if IsControlJustReleased(0, 23) then
				exports['cd_drawtextui']:HideInteraction()
				FreezeEntityPosition(ped, false) 
				ClearPedTasksImmediately(ped)
				TriggerServerEvent('esx_checkin:takeMoney')
				SetEntityCoords(ped, 321.7055, -586.8792, 43.2821, false, false, false, false)
				break
			end
		end
	end
	-- Bed 2
	if chance == 2 then
		print(chance)
		DoScreenFadeOut(500)
		Citizen.Wait(550)
		TriggerEvent('esx_ambulancejob:revive')
		Citizen.Wait(1500)
		DoScreenFadeIn(500)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', 324.2242, -582.8307, 43.30 + 1, 330, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 20000)
		Citizen.Wait(35000)
		exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', 'Press [F] to get out of bed.')
		while true do 
			Citizen.Wait(0)
			if IsControlJustReleased(0, 23) then
				exports['cd_drawtextui']:HideInteraction()
				FreezeEntityPosition(ped, false) 
				ClearPedTasksImmediately(ped)
				TriggerServerEvent('esx_checkin:takeMoney')
				SetEntityHealth(ped, 200)
				SetEntityCoords(ped, 323.1693, -582.6594, 43.2821, false, false, false, false)
				break
			end
		end
	end
	-- Bed 3
	if chance == 3 then
		print(chance)
		DoScreenFadeOut(500)
		Citizen.Wait(550)
		TriggerEvent('esx_ambulancejob:revive')
		Citizen.Wait(1500)
		DoScreenFadeIn(500)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', 317.7231, -585.1912, 43.30 + 1, 160.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 20000)
		Citizen.Wait(35000)
		exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', 'Press [F] to get out of bed.')
		while true do 
			Citizen.Wait(0)
			if IsControlJustReleased(0, 23) then
				exports['cd_drawtextui']:HideInteraction()
				FreezeEntityPosition(ped, false) 
				ClearPedTasksImmediately(ped)
				TriggerServerEvent('esx_checkin:takeMoney')
				SetEntityHealth(ped, 200)
				SetEntityCoords(ped, 318.8044, -585.6, 43.2821, false, false, false, false)
				break
			end
		end
	end
	-- Bed 4 
	if chance == 4 then
		print(chance)
		DoScreenFadeOut(500)
		Citizen.Wait(550)
		TriggerEvent('esx_ambulancejob:revive')
		Citizen.Wait(1500)
		DoScreenFadeIn(500)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', 319.3451, -581.3406, 43.30 + 1, 330.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 20000)
		Citizen.Wait(35000)
		exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', 'Press [F] to get out of bed.')
		while true do 
			Citizen.Wait(0)
			if IsControlJustReleased(0, 23) then
				exports['cd_drawtextui']:HideInteraction()
				FreezeEntityPosition(ped, false) 
				ClearPedTasksImmediately(ped)
				TriggerServerEvent('esx_checkin:takeMoney')
				SetEntityHealth(ped, 200)
				SetEntityCoords(ped, 320.2418, -581.4462, 43.2821, false, false, false, false)
				break
			end
		end
	end
	-- Bed 5
	if chance == 5 then
		print(chance)
		DoScreenFadeOut(500)
		Citizen.Wait(550)
		TriggerEvent('esx_ambulancejob:revive')
		Citizen.Wait(1500)
		DoScreenFadeIn(500)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', 314.4396, -584.1363, 43.30 + 1, 160.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 20000)
		Citizen.Wait(35000)
		exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', 'Press [F] to get out of bed.')
		while true do 
			Citizen.Wait(0)
			if IsControlJustReleased(0, 23) then
				exports['cd_drawtextui']:HideInteraction()
				FreezeEntityPosition(ped, false) 
				ClearPedTasksImmediately(ped)
				TriggerServerEvent('esx_checkin:takeMoney')
				SetEntityHealth(ped, 200)
				SetEntityCoords(ped, 315.5605, -584.334, 43.2821, false, false, false, false)
				break
			end
		end
	end
	-- Bed 6 
	if chance == 6 then
		print(chance)
		DoScreenFadeOut(500)
		Citizen.Wait(550)
		TriggerEvent('esx_ambulancejob:revive')
		Citizen.Wait(1500)
		DoScreenFadeIn(500)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', 313.9253, -579.1385, 43.30 + 1, 330.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 20000)
		Citizen.Wait(35000)
		--exports['mythic_notify']:SendAlert('inform', _U('Press [F] to get out of bed.'), 5000)
		exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', 'Press [F] to get out of bed.')
		while true do 
			Citizen.Wait(0)
			if IsControlJustReleased(0, 23) then
				exports['cd_drawtextui']:HideInteraction()
				FreezeEntityPosition(ped, false) 
				ClearPedTasksImmediately(ped)
				TriggerServerEvent('esx_checkin:takeMoney')
				SetEntityHealth(ped, 200)
				SetEntityCoords(ped, 312.567, -579.2967, 43.2821 + 1, false, false, false, false)
				break
			end
		end
	end
	-- Bed 7 
	if chance == 7 then
		print(chance)
		DoScreenFadeOut(500)
		Citizen.Wait(550)
		TriggerEvent('esx_ambulancejob:revive')
		Citizen.Wait(1500)
		DoScreenFadeIn(500)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', 311.0638, -582.7648, 43.30 + 1, 160.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 20000)
		Citizen.Wait(35000)
		exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', 'Press [F] to get out of bed.')
		while true do 
			Citizen.Wait(0)
			if IsControlJustReleased(0, 23) then
				exports['cd_drawtextui']:HideInteraction()
				FreezeEntityPosition(ped, false) 
				ClearPedTasksImmediately(ped)
				TriggerServerEvent('esx_checkin:takeMoney')
				SetEntityHealth(ped, 200)
				SetEntityCoords(ped, 314.756, -579.4154, 43.2821, false, false, false, false)
				break
			end
		end
	end
	-- Bed 8
	if chance == 8 then
		print(chance)
		DoScreenFadeOut(500)
		Citizen.Wait(550)
		TriggerEvent('esx_ambulancejob:revive')
		Citizen.Wait(1500)
		DoScreenFadeIn(500)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', 307.7011, -581.7363, 43.30 + 1, 160.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 20000)
		Citizen.Wait(35000)
		exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', 'Press [F] to get out of bed.')
		while true do 
			Citizen.Wait(0)
			if IsControlJustReleased(0, 23) then
				exports['cd_drawtextui']:HideInteraction()
				FreezeEntityPosition(ped, false) 
				ClearPedTasksImmediately(ped)
				TriggerServerEvent('esx_checkin:takeMoney')
				SetEntityHealth(ped, 200)
				SetEntityCoords(ped, 308.7692, -582.0396, 43.2821, false, false, false, false)
				break
			end
		end
	end
end)