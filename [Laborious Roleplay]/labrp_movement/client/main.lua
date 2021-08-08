
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











-- Source: https://github.com/ZAUB1/ESX-Binoculars author ZAUB1
-- Source script heavily based and used many elements of https://github.com/mraes/FiveM-scripts/tree/master/heli

-- This release: Removed unused code. Changed UI to use binocular scaleform.
--				 Fixed zoom in/out. Added keybind support
--				 twitch.tv/SerpicoTV
--CONFIG--
local fov_max = 70.0
local fov_min = 5.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right
local speed_ud = 8.0 -- speed by which the camera pans up-down

local binoculars = false
local fov = (fov_max+fov_min)*0.5

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local keybindEnabled = true -- When enabled, binocular are available by keybind
local binocularKey = Keys["."]
local storeBinoclarKey = Keys["BACKSPACE"]

--THREADS--

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		local lPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(lPed)

		if binoculars then
			binoculars = true
			if not ( IsPedSittingInAnyVehicle( lPed ) ) then
				Citizen.CreateThread(function()
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BINOCULARS", 0, 1)
					PlayAmbientSpeech1(GetPlayerPed(-1), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
				end)
			end

			Wait(2000)

			SetTimecycleModifier("default")

			SetTimecycleModifierStrength(0.3)

			local scaleform = RequestScaleformMovie("BINOCULARS")

			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end

			local lPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, lPed, 0.0,0.0,1.0, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(1) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()

			while binoculars and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
				if IsControlJustPressed(0, storeBinoclarKey) then -- Toggle binoculars
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ClearPedTasks(GetPlayerPed(-1))
					binoculars = false
				end

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam, zoomvalue)

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(10)
			end

			binoculars = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

--EVENTS--

-- Activate binoculars
RegisterNetEvent('binoculars:Activate')
AddEventHandler('binoculars:Activate', function()
	binoculars = not binoculars
end)

--FUNCTIONS--
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
	HideHudComponentThisFrame(19) -- weapon wheel
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = GetPlayerPed(-1)
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	end
end

--[[ -- CONFIG --

-- Allow passengers to shoot
local passengerDriveBy = true

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if GetPedInVehicleSeat(car, -1) == playerPed then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			elseif passengerDriveBy then
				SetPlayerCanDoDriveBy(PlayerId(), true)
			else
				SetPlayerCanDoDriveBy(PlayerId(), false)
			end
		end
	end
end) ]]

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local invehicle = IsPedInVehicle(playerPed, vehicle, true)
		if invehicle then
			if IsPedArmed(playerPed, 4) then
				SetFollowPedCamViewMode(4)
				print('is aiming gun in vehicle')
			else
				print('not aiming')
			end
		else
			print('error')
		end
	end
end)]]

--[[local speedlimiter = false

Citizen.CreateThread(function()
	while true do
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local stop = false
			repeat
				if IsControlPressed(0, 244) then
					if speedlimiter == true then
						exports['mythic_notify']:SendAlert('inform', 'Speed Limitler : ON')
						speedlimiter = false
						stop = true
					else
						exports['mythic_notify']:SendAlert('inform', 'Speed Limitler : OFF')
						speedlimiter = true
						stop = true
					end
				end
				Citizen.Wait(5)
			until stop
			Citizen.Wait(1000)
		end
	end
end)]]

Config = {}
Config.otherthancars = false --Setting this true forces everyother vehicle first person driven than cars
Config.forcefirstperson = false --Setting this true forces every action in car first person (I suppose :D)
Config.firstpersonshooting = true --Set True to force first person shooting in CARS. (You can still drive in any viewmode you want)
Config.drivebyspeed = 65 -- set speed you can shoot from car (60 = you can shoot when vehicles goes under 60kmh)

local notforcedfirstperson = { --Table for vehicles which are not affected Config.forcefirstperson
	'',
}
local notforcedfirstpersonshooting = { --Table for vehicles which are not affected Config.firstperonshooting
	'',
}

if Config.firstpersonshooting then
	Citizen.CreateThread(function()
	local ped = PlayerPedId()
		while true do
			sleep = 100
			local car = GetVehiclePedIsIn(ped, false)
			local vehiclehash = GetEntityModel(GetVehiclePedIsIn(ped, false))
			local driver = GetPedInVehicleSeat(car, -1), GetPedInVehicleSeat(car, 0), GetPedInVehicleSeat(car, 1), GetPedInVehicleSeat(car, 2)
			for i,o in pairs(notforcedfirstpersonshooting) do
				if vehiclehash ~= GetHashKey(o) then
					sleep = 10
					if driver then	
						if IsPedDoingDriveby(ped) then
							SetFollowVehicleCamViewMode(4)
						end
						if GetEntitySpeed(car) * 3.6 <= Config.drivebyspeed then
							SetPlayerCanDoDriveBy(PlayerId(), true)
						else
							SetPlayerCanDoDriveBy(PlayerId(), false)
						end
					end
				end
			end
		Citizen.Wait(sleep)
		end
	end)
end


local check = false
if Config.forcefirstperson then
	Citizen.CreateThread(function()
		while true do
		local ped = PlayerPedId()
		local boat = IsPedInAnyBoat(ped)
		local heli = IsPedInAnyHeli(ped)
		local subm = IsPedInAnySub(ped)
		local bike = IsPedOnAnyBike(ped)
		local plane = IsPedInAnyPlane(ped)
		local car = GetVehiclePedIsIn(ped, false)
		local vehiclehash = GetEntityModel(GetVehiclePedIsIn(ped, false))
		local driver = GetPedInVehicleSeat(car, -1), GetPedInVehicleSeat(car, 0), GetPedInVehicleSeat(car, 1), GetPedInVehicleSeat(car, 2)
			w = 1000
		if Config.otherthancars then
			if boat then
				SetCamViewModeForContext(3, 4)
			elseif	heli then
				SetCamViewModeForContext(6, 4)
			elseif	plane then
				SetCamViewModeForContext(4, 4)
			elseif subm then
				SetCamViewModeForContext(5, 4)
			elseif bike then
				SetCamViewModeForContext(2, 4)
			end
		end
			for k,v in pairs(notforcedfirstperson) do
				if car then
					w = 100
					if driver then
						if vehiclehash ~= GetHashKey(v) and check == false then
							SetFollowVehicleCamViewMode(4)
							check = true
						end
					end
					if check == true then
						check = false
					end
				end
			end
			Citizen.Wait(w)
		end
	end)
end


local recoils = {
	[453432689] = 0.5, -- PISTOL
	[3219281620] = 0.3, -- PISTOL MK2
	[1593441988] = 0.4, -- COMBAT PISTOL
	[584646201] = 0.6, -- AP PISTOL
	[3523564046] = 0.8, -- HEAVY PISTOL
	[2578377531] = 1.0, -- PISTOL .50
	[324215364] = 0.5, -- MICRO SMG
	[736523883] = 0.8, -- SMG
	[2024373456] = 0.5, -- SMG MK2
	[4024951519] = 0.1, -- ASSAULT SMG
	[3220176749] = 0.7, -- ASSAULT RIFLE
	[961495388] = 0.2, -- ASSAULT RIFLE MK2
	[2210333304] = 0.1, -- CARBINE RIFLE
	[4208062921] = 0.1, -- CARBINE RIFLE MK2
	[2937143193] = 0.1, -- ADVANCED RIFLE
	[2634544996] = 0.1, -- MG
	[2144741730] = 0.1, -- COMBAT MG
	[3686625920] = 0.1, -- COMBAT MG MK2
	[487013001] = 0.7, -- PUMP SHOTGUN
	[1432025498] = 0.6, -- PUMP SHOTGUN MK2
	[2017895192] = 0.6, -- SAWNOFF SHOTGUN
	[3800352039] = 0.8, -- ASSAULT SHOTGUN
	[2640438543] = 0.6, -- BULLPUP SHOTGUN
	[911657153] = 0.1, -- STUN GUN
	[100416529] = 1.5, -- SNIPER RIFLE
	[205991906] = 1.8, -- HEAVY SNIPER
	[177293209] = 1.6, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.2, -- SNS PISTOL
	[1627465347] = 0.5, -- GUSENBERG
	[3231910285] = 0.2, -- SPECIAL CARBINE
	[-1768145561] = 0.15, -- SPECIAL CARBINE MK2
	[3523564046] = 1.0, -- HEAVY PISTOL
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[-2066285827] = 0.15, -- BULLPUP RIFLE MK2
	[137902532] = 0.4, -- VINTAGE PISTOL
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 0.2, -- HEAVY SHOTGUN
	[3342088282] = 0.3, -- MARKSMAN RIFLE
	[1785463520] = 0.25, -- MARKSMAN RIFLE MK2
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.9, -- FLARE GUN
	[171789620] = 0.2, -- COMBAT PDW
	[3696079510] = 0.9, -- MARKSMAN PISTOL
	[1834241177] = 2.4, -- RAILGUN
	[3675956304] = 0.3, -- MACHINE PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.6, -- REVOLVER MK2
	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.4, -- COMPACT RIFLE
	[317205821] = 0.2, -- AUTO SHOTGUN
	[125959754] = 0.5, -- COMPACT LAUNCHER
	[3173288789] = 0.1, -- MINI SMG		
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				if GetFollowPedCamViewMode() ~= 4 then
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						SetGameplayCamRelativePitch(p+0.1, 0.2)
						tv = tv+0.1
					until tv >= recoils[wep]
				else
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						if recoils[wep] > 0.1 then
							SetGameplayCamRelativePitch(p+0.6, 1.2)
							tv = tv+0.6
						else
							SetGameplayCamRelativePitch(p+0.016, 0.333)
							tv = tv+0.1
						end
					until tv >= recoils[wep]
				end
			end
		end
	end
end)






