local CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask = {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, isSoftcuffed, hasAlreadyJoined, playerInService = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged, isInShopMenu = false, false

if ESX.PlayerLoaded and ESX.PlayerData.job == 'police' then
	Citizen.Wait(1000)
	TriggerServerEvent('esx_policejob:forceBlip')
end


-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Create blips FBI BLIP
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(vector3(103.0549, -744.1319, 45.74219))
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 43)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.2)
	SetBlipSprite(blip, 60)
	
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Federal Bureau of Investigation')
	EndTextCommandSetBlipName(blip)
end)



-- Enter / Exit entity zone events


-- Key Controls


-- Create blip for colleagues

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.EnableESXService then
			TriggerServerEvent('esx_service:disableService', 'police')
		end

		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

local peds = {
	`mp_f_freemode_01`,
	1885233650,
}

exports['labrp_Eye']:Player({
	options = {
		{
			event = 'labrp_police:escort',
			icon = 'fas fa-user-friends',
			label = 'Escort',
		},
		{
			event = 'qrp_police:requestCuffPed',
			icon = 'fas fa-handshake',
			label = 'Handcuff/Uncuff',
			job = "police",
		},
		{
			event = 'searchsuspect',
			icon = 'fas fa-search',
			label = 'Search',
			job = "police",
		},
		{
			event = 'labrp_police:gsr',
			icon = 'fas fa-search',
			label = 'GSR Test',
			job = "police",
		},
		{
			event = 'labrp_police:requestrevive',
			icon = 'fas fa-stethoscope',
			label = 'Revive',
			job = "ambulance",
		},
	},
	distance = 3.0
})

AddEventHandler('labrp_police:requestrevive', function(data)
	exports['mythic_progbar']:Progress({
		name = "unique_action_name",
		duration = 10000,
		label = 'Reviving Person',
		useWhileDead = true,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "amb@medic@standing@tendtodead@base",
			anim = "base",
		},
	})
	Citizen.Wait(10000)
	ClearPedTasks(PlayerPedId())
	local targetPlayer = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
	TriggerServerEvent('ambulance:reviveclosest', targetPlayer)
end)



RegisterNetEvent('qrp_police:requestCuffPed')
AddEventHandler('qrp_police:requestCuffPed', function(data)
    if GetEntityType(data.entity) == 1 and ESX.PlayerData.job.name == 'police' then 
        local target = data.entity
        if IsPedAPlayer(target) then 
            -- The target is a Player
            local targetPlayer = GetPlayerServerId(NetworkGetPlayerIndexFromPed(target))
            if Player(targetPlayer).state.cuffed then 
                TriggerServerEvent('qrp_police:uncuffPlayer', targetPlayer)
            else
                TriggerServerEvent('qrp_police:cuffPlayer', targetPlayer)
            end 
        end 
    end 
end)

-- The player cuffing the ped
RegisterNetEvent('qrp_police:cuffPed')
AddEventHandler('qrp_police:cuffPed',function()
    LoadAnimDict('mp_arrest_paired')
    Citizen.Wait(250)
    TaskPlayAnim(ESX.PlayerData.ped, 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
    Citizen.Wait(3000)
end)

-- The player uncuffing the pped
RegisterNetEvent('qrp_police:uncuffPed')
AddEventHandler('qrp_police:uncuffPed',function()
    LoadAnimDict('mp_arresting')
    Citizen.Wait(250)
    TaskPlayAnim(ESX.PlayerData.ped, 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
    Citizen.Wait(5500)
    ClearPedTasks(ESX.PlayerData.ped)
end)

local cuffState = false

-- The player being cuffed
RegisterNetEvent('qrp_police:getCuffed')
AddEventHandler('qrp_police:getCuffed',function(sourceNetID)
	local cuffingPed = GetPlayerPed(GetPlayerFromServerId(sourceNetID))
    LoadAnimDict('mp_arrest_paired')
    SetCurrentPedWeapon(ESX.PlayerData.ped, `WEAPON_UNARMED`,true)
    SetEntityCoords(ESX.PlayerData.ped,GetOffsetFromEntityInWorldCoords(cuffingPed,0.0,0.45,0.0))
    SetEntityHeading(ESX.PlayerData.ped,GetEntityHeading(cuffingPed))
    Citizen.Wait(250)
    TaskPlayAnim(ESX.PlayerData.ped,'mp_arrest_paired','crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
    Citizen.Wait(3760)
    LoadAnimDict('mp_arresting')
    TaskPlayAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	LocalPlayer.state:set('cuffed',true,true)
	cuffState = true
	exports['mythic_notify']:SendAlert('inform', 'You were cuffed!')
end)

Citizen.CreateThread(function()
	while true do
		if cuffState then
			DisableAllControlActions(0)
			EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
		end
		Citizen.Wait(5)
	end
end)

-- The player being uncuffed
RegisterNetEvent('qrp_police:getUncuffed')
AddEventHandler('qrp_police:getUncuffed',function()
    Citizen.Wait(250)
    LoadAnimDict('mp_arresting')
    TaskPlayAnim(ESX.PlayerData.ped, 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
    Citizen.Wait(5500)
    ClearPedTasks(ESX.PlayerData.ped)
    LocalPlayer.state:set('cuffed',false,true)
	cuffState = false
end)

-- Function to load anim dicts
function LoadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do 
            Citizen.Wait(1)
        end 
    end
end

dragStatus.isDragged = false


exports['labrp_Eye']:Vehicle({
	options = {
		{
			event = "labrp_police:takeoutveh",
			icon = "fas fa-sign-out-alt",
			label = "Unseat",
			canInteract = function(entity)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					return true
				end
			end,
		},
		{
			event = "labrp_police:putinveh",
			icon = "fas fa-sign-in-alt",
			label = "Seat",
			canInteract = function(entity)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					return true
				end
			end,
		},
	},
	distance = 3.0
})


AddEventHandler('labrp_police:putinveh', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
	else
		exports['mythic_notify']:SendAlert('error', 'Invalid Target!') 
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end
			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()
	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

AddEventHandler('labrp_police:takeoutveh', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
	else
		exports['mythic_notify']:SendAlert('error', 'Invalid Target!') 
	end
end)

AddEventHandler('labrp_police:escort', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('labrp_police:drag', GetPlayerServerId(closestPlayer))
	else
		exports['mythic_notify']:SendAlert('error', 'Invalid Target!') 
	end
end)

RegisterNetEvent('labrp_police:drag')
AddEventHandler('labrp_police:drag', function(copId)
	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed
	while true do
		Citizen.Wait(100)
		playerPed = PlayerPedId()
		if dragStatus.isDragged then
			targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))
			if not IsPedSittingInAnyVehicle(targetPed) then
				AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			else
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
			if IsPedDeadOrDying(targetPed, true) then
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		else
			DetachEntity(playerPed, true, false)
		end
	end
end)

local hospitalbedmodel = {
	1631638868,
}

exports['labrp_Eye']:AddTargetModel(hospitalbedmodel,{
	options = {
		{
			event = "labrp_police:putinbed",
			icon = "fas fa-car-side",
			label = "Put in Bed",
			job = "ambulance"
		},
	},
	distance = 3.0
})

AddEventHandler('labrp_police:putinbed', function(data)
	print(GetEntityCoords(data.entity))
	bedcoords = GetEntityCoords(data.entity)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		print(GetPlayerServerId(closestPlayer))
		TriggerServerEvent('labrp_police:requestputinbed', GetPlayerServerId(closestPlayer), bedcoords)
	else
		exports['mythic_notify']:SendAlert('error', 'Invalid Target!') 
	end
end)

RegisterNetEvent('labrp_police:getinbed')
AddEventHandler('labrp_police:getinbed', function(bed)
	SetEntityCoords(PlayerPedId(), bed, false, false, false, false)
	print('test')
end)

