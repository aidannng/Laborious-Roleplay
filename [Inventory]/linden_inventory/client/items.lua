AddEventHandler('linden_inventory:burger', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You ate a delicious burger', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:sandwich', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You ate a sandwich', length = 2500})
		end
	end)
end)



AddEventHandler('linden_inventory:donut', function(item, wait, cb)
	cb(true)
	SetPedMoveRateOverride(PlayerId(),10.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.20)
	exports['mythic_notify']:SendAlert('inform', 'Enjoy the sugar rush!')
	Citizen.Wait(10000)
	SetPedMoveRateOverride(PlayerId(),1.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You ate a donut', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:cookie', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You ate a cookie', length = 2500})
		end
	end)
end)


AddEventHandler('linden_inventory:water', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You drank some refreshing water', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:cola', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You drank some delicious eCola', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:energydrink', function(item, wait, cb)
	cb(true)
	SetPedMoveRateOverride(PlayerId(),10.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.20)
	exports['mythic_notify']:SendAlert('inform', 'Enjoy the energy rush!')
	Citizen.Wait(10000)
	SetPedMoveRateOverride(PlayerId(),1.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You drank an energy drink', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:mustard', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You.. drank mustard', length = 2500})
		end
	end)
end)

AddEventHandler('linden_inventory:bandage', function(item, wait, cb)
	local maxHealth = 200
	local health = GetEntityHealth(ESX.PlayerData.ped)
	if health < maxHealth then
		cb(true)
		SetTimeout(wait, function()
			if not cancelled then
				local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
				SetEntityHealth(ESX.PlayerData.ped, newHealth)
				TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'You feel better already', length = 2500})
			end
		end)
	else cb(false) end
end)

--[[ AddEventHandler('linden_inventory:lockpick', function(item, wait, cb)
	-- This is just for unlocking car doors - if you want more advanced options either set it up or hope somebody PRs it
	local vehicle, vehicleCoords = ESX.Game.GetVehicleInDirection()
	if vehicle then
		local locked = GetVehicleDoorLockStatus(vehicle)
		if #(vehicleCoords - GetEntityCoords(ESX.PlayerData.ped)) <= 2.0 and locked == 2 or locked == 3 then
			cb(true)
			SetTimeout(wait, function()
				if not cancelled then
					math.randomseed(math.random(1,9999))
					local random = math.random(1,10)
					print(random)
					if random >= 7 then
						TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'Successfuly picked the lock', length = 2500})
						SetVehicleAlarm(vehicle, true)
						SetVehicleAlarmTimeLeft(vehicle, 7000)
						SetVehicleDoorsLocked(vehicle, 1)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					elseif random <= 2 then
						TriggerEvent('mythic_notify:client:SendAlert', {type = 'error', text = 'Your lockpick broke', length = 2500})
						TriggerServerEvent('linden_inventory:removeItem', item, 1)
					else
						TriggerEvent('mythic_notify:client:SendAlert', {type = 'error', text = 'You failed to pick the lock', length = 2500})
					end
				end
			end)
		else cb(false) end
	else cb(false) end
end) ]]

AddEventHandler('linden_inventory:armour', function(item, wait, cb)
	cb(true)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Using Armour",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
	Citizen.Wait(10000)
	TriggerServerEvent('removearmour')
	local currenthealth = GetPedArmour(ESX.PlayerData.ped)

	SetPedArmour(ESX.PlayerData.ped, 100)
end)

AddEventHandler('use:copium', function(item, wait, cb)
	cb(true)

	local playerPed = GetPlayerPed(-1)
  	local playerPed = PlayerPedId()

	RequestAnimSet("MOVE_M@QUICK") 
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
      Citizen.Wait(0)
    end 
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 7500,
        label = "Sniffing Copium",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
		animation = {
			animDict = "gestures@miss@fbi_5", --gestures@miss@fbi_5 fbi5_gesture_sniff
			anim = "fbi5_gesture_sniff",
		},
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
	Citizen.Wait(7500)
	ClearPedTasksImmediately(playerPed)
	SetPedMoveRateOverride(PlayerId(),10.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.25)
	AnimpostfxPlay("DrugsMichaelAliensFight", 14000, true)
	exports['mythic_notify']:SendAlert('inform', 'Copium!')
	Citizen.Wait(13500)
	SetPedMoveRateOverride(PlayerId(),1.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	ResetPedMovementClipset(GetPlayerPed(-1))
	AnimpostfxStopAll()
	exports['mythic_notify']:SendAlert('inform', 'Failure!')
end)

AddEventHandler('linden_inventory:ifak', function(item, wait, cb)
	cb(true)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Using IFAK",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
	Citizen.Wait(10000)
	TriggerServerEvent('removeifak')
	local currenthealth = GetEntityHealth(ESX.PlayerData.ped)
	local newhealth = currenthealth + math.random(90, 100)

	SetEntityHealth(ESX.PlayerData.ped, newhealth)
end)
	

AddEventHandler('linden_inventory:cocaine', function(item, wait, cb)
	cb(true)
	SetTimeout(wait, function()
		if not cancelled then
			TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'WOAH that was a big sniff', length = 2500})
		end
	end)
end)

--policegoggles:toggleNight
