
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

TimerEnabled = false

-- TACKLE 
function TryTackle()
		if not TimerEnabled then
			--print("attempting a tackle.")
			t, distance = ESX.Game.GetClosestPlayer()
			if(distance ~= -1 and distance < 2) then
				local maxheading = (GetEntityHeading(PlayerPedId()) + 15.0)
				local minheading = (GetEntityHeading(PlayerPedId()) - 15.0)
				local theading = (GetEntityHeading(t))

				TriggerServerEvent('CrashTackle',GetPlayerServerId(t))
				TriggerEvent("animation:tacklelol") 

				TimerEnabled = true
				Citizen.Wait(4500)
				TimerEnabled = false

			else
				TimerEnabled = true
				Citizen.Wait(1000)
				TimerEnabled = false

			end

		end
--SetPedToRagdoll(PlayerPedId(), 500, 500, 0, 0, 0, 0) 
end

RegisterNetEvent('playerTackled')
AddEventHandler('playerTackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(8500), math.random(8500), 0, 0, 0, 0) 

	TimerEnabled = true
	Citizen.Wait(1500)
	TimerEnabled = false
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if IsControlPressed(0, 61) and IsControlPressed(0, 38) then
			--print('key pressed')
			Citizen.Wait(10)
			local closestPlayer, distance = ESX.Game.GetClosestPlayer()

			if not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) and not IsPedRagdoll(PlayerPedId()) then
				TryTackle()
			end
		end
	end
end)

RegisterNetEvent('animation:tacklelol')
AddEventHandler('animation:tacklelol', function()
		if not IsPedRagdoll(PlayerPedId()) then
			local lPed = PlayerPedId()
			RequestAnimDict("swimming@first_person@diving")
			while not HasAnimDictLoaded("swimming@first_person@diving") do
				Citizen.Wait(1)
			end
			
			if IsEntityPlayingAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
				ClearPedSecondaryTask(lPed)
			else
				TaskPlayAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
				seccount = 3
				while seccount > 0 do
					Citizen.Wait(100)
					seccount = seccount - 1
				end
				ClearPedSecondaryTask(lPed)
				SetPedToRagdoll(PlayerPedId(), 150, 150, 0, 0, 0, 0) 
			end
		end
end)


AddTextEntry('PM_PANE_CFX', 'Laborious Roleplay')

local holdingBody = false
local carrying = false
local escort = false

RegisterNetEvent('carry:command')
AddEventHandler('carry:command', function()
	if not carrying then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent('carry:sync', GetPlayerServerId(closestPlayer))
		end
		DisableControlAction(1, 24, true)
	else
		--TriggerEvent('notification', 'Cant.', 2)
		exports['mythic_notify']:SendAlert('error', 'Action Invalid!') 
	end
end,false)

RegisterNetEvent('carry:syncTarget')
AddEventHandler('carry:syncTarget', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carrying = true

	--TriggerEvent('notification', 'Press E to release carry.')
	exports['mythic_notify']:SendAlert('inform', "You're being carried!") 

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)
		
	while carrying do

		DisableControlAction(1, 19, true)
		DisableControlAction(0, 34, true)
		DisableControlAction(0, 9, true)
	
		DisableControlAction(0, 288, true)
		DisableControlAction(0, 289, true)
		DisableControlAction(0, 170, true)
		DisableControlAction(0, 73, true)
		DisableControlAction(0, 79, true)
		DisableControlAction(0, 305, true)
		DisableControlAction(0, 82, true)
		DisableControlAction(0, 182, true)

		DisableControlAction(0, 32, true)
		DisableControlAction(0, 8, true)
		DisableControlAction(2, 31, true)
		DisableControlAction(2, 32, true)
		DisableControlAction(1, 33, true)
		DisableControlAction(1, 34, true)
		DisableControlAction(1, 35, true)
		DisableControlAction(1, 21, true)  -- space
		DisableControlAction(1, 22, true)  -- space
		DisableControlAction(1, 23, true)  -- F  -- F
		DisableControlAction(1, 25, true)  -- F
		DisableControlAction(1, 24, true)

	
	
		DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
		DisableControlAction(1, 140, true) --Disables Melee Actions
		DisableControlAction(1, 141, true) --Disables Melee Actions
		DisableControlAction(1, 142, true) --Disables Melee Actions 
		DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
		DisablePlayerFiring(playerPed, true) -- Disable weapon firing

		if not IsEntityPlayingAnim(playerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 3) then
			loadAnim("amb@world_human_bum_slumped@male@laying_on_left_side@base")
			TaskPlayAnim(playerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
		end

		Wait(1)
	end

end)


RegisterNetEvent('carry:syncMe')
AddEventHandler('carry:syncMe', function()
	local playerPed = GetPlayerPed(-1)

	--TriggerEvent('notification', 'Press E to release carry.')
	exports['mythic_notify']:SendAlert('inform', 'Press G to release carry.')

	carrying = true

	while carrying do
		if not IsEntityPlayingAnim(playerPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
			loadAnim("missfinale_c2mcs_1")
			TaskPlayAnim(playerPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
		end

		if IsControlJustPressed(0, 47) then
			carrying = false
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(GetPlayerPed(-1), true, false)
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
			end
		end

		Wait(1)
	end

end)

RegisterNetEvent('carry:stop')
AddEventHandler('carry:stop', function()
	carrying = false
	ClearPedTasks(PlayerPedId())
	DetachEntity(GetPlayerPed(-1), true, false)
end)

local count = 0



RegisterNetEvent('escort:player')
AddEventHandler('escort:player', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('escort:sync', GetPlayerServerId(closestPlayer))
	end
end)


RegisterNetEvent('escort:syncTarget')
AddEventHandler('escort:syncTarget', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	escort = true

	--TriggerEvent('notification', 'Press E to release carry.')
	exports['mythic_notify']:SendAlert('inform', "You're being escorted!") 

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	--AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		
	while escort do

		DisableControlAction(1, 19, true)
		DisableControlAction(0, 34, true)
		DisableControlAction(0, 9, true)
	
		DisableControlAction(0, 288, true)
		DisableControlAction(0, 289, true)
		DisableControlAction(0, 170, true)
		DisableControlAction(0, 73, true)
		DisableControlAction(0, 79, true)
		DisableControlAction(0, 305, true)
		DisableControlAction(0, 82, true)
		DisableControlAction(0, 182, true)

		DisableControlAction(0, 32, true)
		DisableControlAction(0, 8, true)
		DisableControlAction(2, 31, true)
		DisableControlAction(2, 32, true)
		DisableControlAction(1, 33, true)
		DisableControlAction(1, 34, true)
		DisableControlAction(1, 35, true)
		DisableControlAction(1, 21, true)  -- space
		DisableControlAction(1, 22, true)  -- space
		DisableControlAction(1, 23, true)  -- F  -- F
		DisableControlAction(1, 25, true)  -- F
		DisableControlAction(1, 24, true)

	
	
		DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
		DisableControlAction(1, 140, true) --Disables Melee Actions
		DisableControlAction(1, 141, true) --Disables Melee Actions
		DisableControlAction(1, 142, true) --Disables Melee Actions 
		DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
		DisablePlayerFiring(playerPed, true) -- Disable weapon firing

		Wait(1)
	end
end)

RegisterNetEvent('escort:syncMe')
AddEventHandler('escort:syncMe', function()
	local playerPed = GetPlayerPed(-1)

	--TriggerEvent('notification', 'Press E to release carry.')
	exports['mythic_notify']:SendAlert('inform', 'Press G to release escort.')

	escort = true

	while escort do
		if IsControlJustPressed(0, 47) then
			escort = false
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(GetPlayerPed(-1), true, false)
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent("escort:stop",GetPlayerServerId(closestPlayer))
			end
		end

		Wait(1)
	end

end)

RegisterNetEvent('escort:stop')
AddEventHandler('escort:stop', function()
	escort = false
	ClearPedTasks(PlayerPedId())
	DetachEntity(GetPlayerPed(-1), true, false)
end)

function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent("roll")
AddEventHandler("roll",function(times,weight)

	times = tonumber(times)
	weight = tonumber(weight)
	rollAnim()
	local strg = ""
	for i = 1, times do
		if i == 1 then
			strg = strg .. " " .. math.random(weight) .. "/" .. weight
		else
			strg = strg .. " | " .. math.random(weight) .. "/" .. weight
		end
		
	end
	TriggerServerEvent("showRoll", "Dice rolled " .. strg)
end)

function rollAnim()
    loadAnim( "anim@mp_player_intcelebrationmale@wank" ) 
    TaskPlayAnim( PlayerPedId(), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(1500)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'dice', 0.1)
    ClearPedTasks(PlayerPedId())
    Citizen.Wait(500)
end

RegisterNetEvent("showRoll")
AddEventHandler('showRoll', function(user, str)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(user)
	if #(GetEntityCoords(GetPlayerPed(monid)) - GetEntityCoords(GetPlayerPed(sonid))) < 8.0 and HasEntityClearLosToEntity( GetPlayerPed(monid), GetPlayerPed(sonid), 17 ) then
		TriggerEvent('phone:DoHudTextCoords', str, GetPlayerPed(sonid))
	end
end)

function DrawText3DTest(x,y,z, text, dicks,power)

	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	if dicks > 255 then
		dicks = 255
	end
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0, 0, 0, 0, 155)
		SetTextEdge(1, 0, 0, 0, 250)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		 SetTextColour(255, 255, 255, dicks)
  
		DrawText(_x,_y)
		local factor = (string.len(text)) / 250
		if dicks < 115 then
			 DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 11, 1, 11, dicks)
		else
			 DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 11, 1, 11, 115)
		end
  
	end
end

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterNetEvent('general:putInVehicle')
AddEventHandler('general:putInVehicle', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('putinvehicle:sync', GetPlayerServerId(closestPlayer))
	end
end)


RegisterNetEvent('putinvehicle:target')
AddEventHandler('putinvehicle:target', function(target)
	local coords = GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		SetPedIntoVehicle(playerPed, vehicle, 1)
	end
end)












