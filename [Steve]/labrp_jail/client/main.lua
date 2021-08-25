ESX = nil
local isJailed = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


AddEventHandler('playerSpawned', function(spawn)
	-- Check Whether person is in jail --
end)



RegisterNetEvent('labrp_jail:unjail')
AddEventHandler('labrp_jail:unjail', function()
    print('ah your unjailed')
    SetEntityCoords(PlayerPedId(), 1841.42, 2580.448, 46.01172)
    SetEntityHeading(PlayerPedId(), 360.0)
    isJailed = false
end)




Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.JailBlip)

	SetBlipSprite(blip, 188)
	SetBlipScale (blip, 1.2)
	SetBlipColour(blip, 6)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Bolingbroke Penitentiary')
	EndTextCommandSetBlipName(blip)
end)

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
    SetEntityCoords(PlayerPedId(), 1773.125, 2482.101, 50.40955)
	Citizen.Wait(2000)
	DoScreenFadeIn(2000)
    isJailed = true
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
                event = 'labrp_jail:checkjailtime',
                icon = 'fas fa-stopwatch-20',
                label = 'Check Jail Time'
            },

        },
        job = {"all"},
        distance = 2.5
    })



	
RegisterNetEvent('labrp_jail:checkjailtime')
AddEventHandler('labrp_jail:checkjailtime', function()
    ESX.TriggerServerCallback('labrp_jail:checktime', function(time)
        exports['mythic_notify']:SendAlert('inform', "You're in jail for "..time.." months")
    end) 
end)

RegisterNetEvent('show:identification')
AddEventHandler('show:identification', function()
	local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    if closestplayer ~= -1 and closestPlayerDistance  <= 3.0 then
        TriggerServerEvent('show:identification', GetPlayerServerId(closestPlayer))
        exports['mythic_notify']:SendAlert('inform', "ID Shown!")
    end
	ESX.TriggerServerCallback('labrp_jail:identification', function(name, dob)
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0}</div>',
			args = { "^*^4Name^0 : "..name.." | ^4DOB^0 : "..dob }
		});
	end)
end)

Citizen.CreateThread(function()
    local jailarea = PolyZone:Create({
        vector2(1852.47, 2701.437),
	    vector2(1775.895, 2766.382),
	    vector2(1648.47, 2763.468),
	    vector2(1566.844, 2684.532),
	    vector2(1529.987, 2587.174),
	    vector2(1536.224, 2467.754),
	    vector2(1657.134, 2389.583),
	    vector2(1762.273, 2405.051),
	    vector2(1828.813, 2473.213),
	    vector2(1867.24, 2597.222)
    }, {
        name="jail_area",
        debugGrid=false,
        gridDivisions=25
    })

    while true do
        Citizen.Wait(500)
        if not jailarea:isPointInside(GetEntityCoords(PlayerPedId())) and isJailed then
            SetEntityCoords(PlayerPedId(), 1773.125, 2482.101, 50.40955)
            print('out of jail zone')
        end
    end
end)