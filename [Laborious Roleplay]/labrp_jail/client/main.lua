local isInJail, unjail = false, false
local jailTime, fastTimer = 0, 0
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_jail:jailPlayer')
AddEventHandler('esx_jail:jailPlayer', function(_jailTime)
	jailTime = _jailTime

	local playerPed = PlayerPedId()

	SetPedArmour(playerPed, 0)
	ESX.Game.Teleport(playerPed, Config.JailLocation)
	isInJail, unjail = true, false

	while not unjail do
		playerPed = PlayerPedId()

		RemoveAllPedWeapons(playerPed, true)
		if IsPedInAnyVehicle(playerPed, false) then
			ClearPedTasksImmediately(playerPed)
		end

		Citizen.Wait(20000)

		-- Is the player trying to escape?
		if #(GetEntityCoords(playerPed) - Config.JailLocation) > 200 then
			ESX.Game.Teleport(playerPed, Config.JailLocation)
		end
	end

	ESX.Game.Teleport(playerPed, Config.JailBlip)
	isInJail = false

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if jailTime > 0 and isInJail then
			if fastTimer < 0 then
				fastTimer = jailTime
			end

			fastTimer = fastTimer - 0.01
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_jail:unjailPlayer')
AddEventHandler('esx_jail:unjailPlayer', function()
	unjail, jailTime, fastTimer = true, 0, 0
end)

AddEventHandler('playerSpawned', function(spawn)
	if isInJail then
		ESX.Game.Teleport(PlayerPedId(), Config.JailLocation)
	end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.JailBlip)

	SetBlipSprite(blip, 188)
	SetBlipScale (blip, 0.8)
	SetBlipColour(blip, 6)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_name'))
	EndTextCommandSetBlipName(blip)
end)

function draw2dText(text, x, y)
	SetTextFont(4)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
end

RegisterNetEvent('jailintro')
AddEventHandler('jailintro', function()
    DoScreenFadeOut(10)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'handcuff', 1.0)

    
    SetPedComponentVariation(PlayerPedId(), 1, -1, -1, -1)
    ClearPedProp(PlayerPedId(), 0)

    Citizen.Wait(1000)

    SetEntityCoords(PlayerPedId(),472.9714, -1011.376, 25.26379)
    SetEntityHeading(PlayerPedId(),270.0)
    Citizen.Wait(1500) 
    DoScreenFadeIn(500)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)     
    SetEntityHeading(PlayerPedId(),-355.74) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)  
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)         
    SetEntityHeading(PlayerPedId(),170.74) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
     TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)       

    SetEntityHeading(PlayerPedId(),270.0)

    Citizen.Wait(2000)
    DoScreenFadeOut(1100)   
    Citizen.Wait(2000)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'jaildoor', 1.0)
	FreezeEntityPosition(PlayerPedId(), false)
	Citizen.Wait(2000)
	DoScreenFadeIn(1100)
end)

Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("jailtime", vector3(1831.965, 2580.844, 46.01172), 2.0, 2.0, {
        name="jailtime",
        heading=180,
        debugPoly=false,
    })
end)

local jailtimezone = false

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "jailtime" then
        jailtimezone = true
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "jailtime" then
        jailtimezone = false
    end
end)

local timecheck = false

Citizen.CreateThread(function()
	while true do
    	if jailtimezone == true then
			--exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', "[E] Check Jail Time")
			exports['cd_drawtextui']:ShowInteraction('show', 'SteelBlue', "[E] Check Jail Time")
			if IsControlPressed(0, 38) then
				local months = fastTimer//60
				exports['mythic_notify']:SendAlert('inform', 'You have '..months..' months left') 
				exports['cd_drawtextui']:HideInteraction()
				jailtimezone = false
			end
		else
		end
		Citizen.Wait(0)
	end
end)

local makingslush = false

Citizen.CreateThread(function()
	while true do
        local sleep = 200
        local playerCoords = GetEntityCoords(PlayerPedId())
    	local distCheck =  GetDistanceBetweenCoords(1778.73, 2557.609, 45.65784, playerCoords)
        if distCheck <= 1.5 then 
			sleep = 500
            if IsControlPressed(0, 38) then
				if makingslush == false then
					TriggerEvent('makeslushy')
					exports['mythic_notify']:SendAlert('inform', 'yo fool you making a slushy')
				else
					exports['mythic_notify']:SendAlert('error', 'Action Invalid, Try Again Later')
				end
			end
        end
        Citizen.Wait(300)
	end
end)

RegisterNetEvent('makeslushy')
AddEventHandler('makeslushy', function()
	exports['mythic_progbar']:Progress({
		name = "unique_action_name",
		duration = 5000,
		label = 'Making God Slushy',
		useWhileDead = true,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	})
	makingslush = true
	Citizen.Wait(180000)
	makingslush = false
end)