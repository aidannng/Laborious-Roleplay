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

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 3.0 then

	else
	TriggerServerEvent('gl-drugselling:removeReputation',GetPlayerServerId(closestPlayer))
	end

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
	ExecuteCommand('e mugshot')
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
	SetEntityHeading(PlayerPedId(),270.0)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(1500)       


    Citizen.Wait(2000)
    DoScreenFadeOut(1100)   
    Citizen.Wait(2000)
	ExecuteCommand('e c')
    TriggerEvent('InteractSound_CL:PlayOnOne', 'jaildoor', 1.0)
	FreezeEntityPosition(PlayerPedId(), false)
	Citizen.Wait(2000)
	DoScreenFadeIn(2000)
end)


exports['labrp_Eye']:AddBoxZone("jailphone", vector3(1832, 2580.0, 46.6), 0.5, 0.3, {
	name="jailphone",
	heading=90,
	debugPoly=false,
	minZ=46.2,
	maxZ=47.0
    }, {
        options = {
            {
                event = 'checkjailtime',
                icon = 'fas fa-stopwatch-20',
                label = 'Check Jail Time'
            },

        },
        job = {"all"},
        distance = 2.5
    })

RegisterNetEvent('checkjailtime')
AddEventHandler('checkjailtime', function()
	local months = fastTimer//60
	exports['mythic_notify']:SendAlert('inform', 'You have '..months..' months left', 5000) 
end)

