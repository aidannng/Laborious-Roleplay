local isRobbing = false
local cooldown = false
local playerCoords = GetEntityCoords(PlayerPedId(), true)

local robbableFleeca = {
    [1] = {x = 146.3341, y = -1045.464, z = 29.36414, info = 'Legion Square Fleeca'},--  311.1297, -284.3736, 54.15015
    [2] = {x = 311.1297, y = -284.3736, z = 54.15015, info = 'Pink Cage Fleeca'},---353.8286, -55.2, 49.02783
    [3] = {x = -353.8286, y = -55.2, z = 49.02783, info = 'CourtHouse Fleeca'},-- -1210.813, -336.567, 37.77222
    [4] = {x = -1210.813, y = -336.567, z = 37.77222, info = 'CourtHouse Fleeca'},-- -2956.563, 481.6879, 15.68201
    [5] = {x = -2956.563, y = 481.6879, z = 15.68201, info = 'West LS Fleeca'}, --1176.04, 2712.857, 38.07544
    [5] = {x = 1176.04, y = 2712.857, z = 38.07544, info = 'Route 68 Fleeca'},
}

local PowerStation = {
    [1] = {x = 713.0242, y = 164.2813, z = 80.73926, info = 'LS Power Station'},--  311.1297, -284.3736, 54.15015
}--713.0242, 164.2813, 80.73926

local StoreRobberies = {
    [1] = {x = 28.02198, y = -1339.134, z = 29.48206, info = 'Innocence Blvd 24/7'},--  28.02198, -1339.134, 29.48206
    [2] = {x = 2549.459, y = 384.8703, z = 108.6088, info = 'Palomino 24/7'},--  2549.459, 384.8703, 108.6088
    [3] = {x = -43.37143, y = -1748.611, z = 29.41467, info = 'Grove Street 24/7'},--  -43.37143, -1748.611, 29.41467
    [4] = {x = -709.5297, y = -904.1407, z = 19.20361, info = 'Little Seoul 24/7'},--  -709.5297, -904.1407, 19.20361
    [5] = {x = 1159.556, y = -314.1363, z = 69.19702, info = 'Mirror Park 24/7'},--  1159.556, -314.1363, 69.19702
    [6] = {x = 378.0659, y = 333.3099, z = 103.5538, info = 'Pacific Standard 24/7'},--  378.0659, 333.3099, 103.5538
    [7] = {x = -1828.971, y = 798.8307, z = 138.1802, info = 'West LS 24/7'},--  -1828.971, 798.8307, 138.1802
    [8] = {x = -3047.776, y = 585.4681, z = 7.897461, info = 'GreatOcean Hwy 24/7'},--  -3047.776, 585.4681, 7.897461
    [9] = {x = -3250.022, y = 1004.426, z = 12.81763, info = 'GreatOcean Hwy#2 24/7'},--  -3250.022, 1004.426, 12.81763
}--713.0242, 164.2813, 80.73926

local FleecaTrolleys = {
    [1] = {x = 147.3363, y = -1050.185, z = 28.33044, info = 'Legion Fleeca Trolley'},--  147.3363, -1050.185, 29.33044
}--713.0242, 164.2813, 80.73926


local ESX = nil
local PlayerData = {}
local pedSpawned = false

Citizen.CreateThread(function ()
    while ESX == nil do
     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
     Citizen.Wait(1)
    end
   
    while ESX.GetPlayerData() == nil do
     Citizen.Wait(10)
    end
   
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
 PlayerData = xPlayer
end)

RegisterNetEvent('FleecaRobberies:attempt')
AddEventHandler('FleecaRobberies:attempt', function()
 if not isRobbing then
  local playerCoords = GetEntityCoords(PlayerPedId(), true)
  for id,v in pairs(robbableFleeca) do
   if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
    --TriggerServerEvent('openfleecadoor')
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 8000,
        label = 'Using Laptop',
        useWhileDead = true,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })
    local data = {displayCode = '10-68', description = 'Fleeca Robbery', isImportant = 1, recipientList = {'police', 'fbi'}, length = '15000', infoM = 'fas fa-university', info = 'Fleeca Robbery'}
    local dispatchData = {dispatchData = data, caller = 'Security System', coords = vector3(v.x, v.y, v.z)}
    TriggerServerEvent('wf-alerts:svNotify', dispatchData)
    Citizen.Wait(8000)
    exports['hacking']:OpenHackingGame(function(Success)
    if Success then 
            print('passed')
            exports['mythic_notify']:SendAlert('success', 'Nice Job!')
            TriggerServerEvent('openfleecadoor')
            TriggerEvent('SpawnTrolley')
        else
            exports['mythic_notify']:SendAlert('error', 'This hack is too complicated?!')
        end
    end)
    --TriggerEvent('fleeca:openvaultdoor')

   end
  end
 end
end)


RegisterNetEvent("vaultsound")
AddEventHandler("vaultsound", function()
    local sescount = 0
    repeat
      PlaySoundFrontend(-1,"OPENING", "MP_PROPERTIES_ELEVATOR_DOORS" ,1)
      Citizen.Wait(900)
      sescount = sescount + 1
    until sescount == 9
end)

local despawntrolley = false

RegisterNetEvent("SpawnTrolley")
AddEventHandler("SpawnTrolley", function()
	local playerCoords = GetEntityCoords(PlayerPedId(), true)
	for id,v in pairs(FleecaTrolleys) do
        RequestModel("hei_prop_hei_cash_trolly_01")
        while not HasModelLoaded("hei_prop_hei_cash_trolly_01") do
          Citizen.Wait(4)
        end
        Trolley1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), v.x, v.y, v.z, 1, 1, 0)
	end
end)

RegisterNetEvent("fleeca:openvaultdoor")
AddEventHandler("fleeca:openvaultdoor", function()
    local obj = GetClosestObjectOfType(playerCoords, 5.0, GetHashKey('v_ilev_gb_vauldr'), false, false, false)
	local count = 0
	repeat
		local heading = GetEntityHeading(obj) - 0.10
		SetEntityHeading(obj, heading)
		count = count + 1
		Citizen.Wait(10)
	until count == 900
end)

RegisterNetEvent("fleeca:closevaultdoor")
AddEventHandler("fleeca:closevaultdoor", function()
    local obj = GetClosestObjectOfType(playerCoords, 5.0, GetHashKey('v_ilev_gb_vauldr'), false, false, false)
	local count = 0
	repeat
		local heading = GetEntityHeading(obj) + 0.10
		SetEntityHeading(obj, heading)
		count = count + 1
		Citizen.Wait(10)
	until count == 900
end)

RegisterNetEvent("powerblackout")
AddEventHandler("powerblackout", function()
    SetArtificialLightsState(false)
    print('blackout')
end)

RegisterNetEvent("lootcart")
AddEventHandler("lootcart", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)
    local CashAppear = function()
    local pedCoords = GetEntityCoords(ped)
    local grabmodel = GetHashKey(model)

    RequestModel(grabmodel)
    while not HasModelLoaded(grabmodel) do
      Citizen.Wait(100)
    end
    local grabobj = CreateObject(grabmodel, pedCoords, true)

    FreezeEntityPosition(grabobj, true)
    SetEntityInvincible(grabobj, true)
    SetEntityNoCollisionEntity(grabobj, ped)
    SetEntityVisible(grabobj, false, false)
    AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local startedGrabbing = GetGameTimer()

    Citizen.CreateThread(function()
    while GetGameTimer() - startedGrabbing < 37000 do
      Citizen.Wait(4)
      DisableControlAction(0, 73, true)
      if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
        if not IsEntityVisible(grabobj) then
          SetEntityVisible(grabobj, true, false)
        end
      end
      if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
        if IsEntityVisible(grabobj) then
          SetEntityVisible(grabobj, false, false)
          TriggerServerEvent("fleecaReward")
        end
      end
    end
    DeleteObject(grabobj)
    end)
  end
  local trollyobj = Trolley
  local emptyobj = GetHashKey("hei_prop_hei_cash_trolly_03")

  if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
    return
  end
  local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

  RequestAnimDict("anim@heists@ornate_bank@grab_cash")
  RequestModel(baghash)
  RequestModel(emptyobj)
  while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
    Citizen.Wait(100)
  end
  while not NetworkHasControlOfEntity(trollyobj) do
    Citizen.Wait(4)
    NetworkRequestControlOfEntity(trollyobj)
  end
  local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
  local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

  NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
  SetPedComponentVariation(ped, 5, 0, 0, 0)
  NetworkStartSynchronisedScene(scene1)
  Citizen.Wait(1500)
  CashAppear()
  local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

  NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
  NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
  NetworkStartSynchronisedScene(scene2)
  Citizen.Wait(37000)
  local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

  NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
  NetworkStartSynchronisedScene(scene3)
  NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, - 0.985), true)
  --TriggerServerEvent("vrp:updateObj", name, NewTrolley, 2)
  SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
  while not NetworkHasControlOfEntity(trollyobj) do
    Citizen.Wait(4)
    NetworkRequestControlOfEntity(trollyobj)
  end
  DeleteObject(trollyobj)
  PlaceObjectOnGroundProperly(NewTrolley)
  Citizen.Wait(1800)
  DeleteObject(bag)
  SetPedComponentVariation(ped, 5, 45, 0, 0)
  RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
  SetModelAsNoLongerNeeded(emptyobj)
  SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
  disableinput = false
end)

RegisterNetEvent("dildothrow")
AddEventHandler("dildothrow", function()
    local playerPed = PlayerPedId()
    local animDict = "melee@unarmed@streamed_variations"
    local anim = "plyr_takedown_front_slap"
    local object = `prop_boombox_01`
    while (not HasAnimDictLoaded(animDict)) do
        RequestAnimDict(animDict)
        Citizen.Wait(5)
    end
    RequestModel(object)
    while not HasModelLoaded(object) do 
        Citizen.Wait(1)
    end 
    local pos = GetWorldPositionOfEntityBone(playerPed,6286)
    TaskPlayAnim(playerPed, animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    local obj = CreateObject(object, pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(obj,playerPed, GetPedBoneIndex(playerPed,6286),0,0,0, 0,0,0)
    Citizen.Wait(500)
    DetachEntity(obj)
    local forwardVector = GetEntityForwardVector(playerPed)
    ApplyForceToEntity(obj,1,forwardVector.x*65.0,forwardVector.y*65.0,forwardVector.z+5.0,0,0,0,0,false,true,true,false,true)
    TriggerServerEvent('deleteboomboxitem')
    Citizen.Wait(15000)
    DeleteEntity(obj)
end)







































RegisterNetEvent('PowerStation:attempt')
AddEventHandler('PowerStation:attempt', function()
 if not isRobbing then
  local playerCoords = GetEntityCoords(PlayerPedId(), true)
  for id,v in pairs(PowerStation) do
   if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 10000,
        label = 'Hacking Power Station',
        useWhileDead = true,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@medic@standing@kneel@idle_a",--amb@medic@standing@kneel@idle_a idle_a
            anim = "idle_a",
        },
    })
    Citizen.Wait(10000)
    ClearPedTasks(PlayerPedId())
    --TriggerEvent('PowerStation:dispatch')
    exports['hacking']:OpenHackingGame(function(Success)
        if Success then 
            print('passed')
            exports['mythic_notify']:SendAlert('success', 'Nice Job!')
            exports['mythic_notify']:SendAlert('inform', 'Power Shutting Down!') 
            Citizen.Wait(10000)--120000 = 2 mins
            TriggerServerEvent('powerblackout')
            --TriggerEvent('esx_holdupbank:opendoors')
            local data = {displayCode = '10-68', description = 'LS Power Station', isImportant = 1, recipientList = {'police', 'fbi'}, length = '15000', infoM = 'fas fa-broadcast-tower', info = 'Disturbance at LS Power Station'}
            local dispatchData = {dispatchData = data, caller = 'Security System', coords = vector3(v.x, v.y, v.z)}
            TriggerServerEvent('wf-alerts:svNotify', dispatchData)
        else
            exports['mythic_notify']:SendAlert('error', 'This hack is too complicated?!')
            local data = {displayCode = '10-68', description = 'LS Power Station', isImportant = 1, recipientList = {'police', 'fbi'}, length = '15000', infoM = 'fas fa-broadcast-tower', info = 'Disturbance at LS Power Station'}
            local dispatchData = {dispatchData = data, caller = 'Security System', coords = vector3(v.x, v.y, v.z)}
            TriggerServerEvent('wf-alerts:svNotify', dispatchData)
        end
    end)
    --TriggerEvent('esx_holdupbank:opendoors')
    --TriggerEvent('vaultsound')
   end
  end
 end
end)--checkadvancedlockpick
--startStoreHack

RegisterNetEvent('blackoutcity')
AddEventHandler('blackoutcity', function()
    SetBlackout(blackout)
end)
RegisterNetEvent("startStoreHack")
AddEventHandler("startStoreHack", function()
    TriggerServerEvent('checkadvancedlockpick')
end)

RegisterNetEvent("nolockpick")
AddEventHandler("nolockpick", function()
    exports['mythic_notify']:SendAlert('error', "You don't have the right tool?!")
end)

local enoughCops = false

RegisterNetEvent("startHack")
AddEventHandler("startHack", function()
    TriggerServerEvent('checkstorecops')
end)

RegisterNetEvent("doHack")
AddEventHandler("doHack", function()
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    if cooldown == false then
        for id,v in pairs(StoreRobberies) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
                TriggerEvent('storecooldown')
                local data = {displayCode = '10-68', description = 'Store Robbery', isImportant = 1, recipientList = {'police', 'fbi'}, length = '15000', infoM = 'fas fa-cash-register', info = 'Store Robbery'} --
                local dispatchData = {dispatchData = data, caller = 'Security System', coords = playerCoords}
                TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                exports['mythic_progbar']:Progress({
                    name = "unique_action_name",
                    duration = 40000,
                    label = 'Cracking Safe',
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "amb@medic@standing@kneel@idle_a",--amb@medic@standing@kneel@idle_a idle_a
                        anim = "idle_a",
                    },
                })
                Citizen.Wait(40000)
                exports["memorygame"]:thermiteminigame(10, 3, 3, 9,
                function() -- success
                    exports['mythic_notify']:SendAlert('success', "Nice Job!")
                    exports['mythic_progbar']:Progress({
                        name = "unique_action_name",
                        duration = 60000,
                        label = 'Grabbing Items',
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "mp_missheist_ornatebank",--amb@medic@standing@kneel@idle_a idle_a
                            anim = "put_cash_into_bag_loop",
                        },
                    })
                    Citizen.Wait(60000)
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('GiveSafeReward')
                end,
                function() -- failure
                    exports['mythic_notify']:SendAlert('error', "You failed!")
                end)
                TriggerServerEvent('TakeLockPPick')
                ClearPedTasks(PlayerPedId())
            end
        end
    else
        exports['mythic_notify']:SendAlert('error', 'This has recently been robbed!')
    end
end)


RegisterNetEvent('storecooldown')
AddEventHandler('storecooldown', function()
    cooldown = true
    local timer = 30 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            cooldown = false
        end
    end

end)



    exports['labrp_Eye']:AddBoxZone("PalominoFwyShop", vector3(2548.61, 384.87, 107.63), 0.72, 0.72, {
		name="PalominoFwyShop",
		debugPoly=false,
		heading=87.716,
		minZ=107.63,
		maxZ=108.51
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("InesenoRoadShop", vector3(-3048.47, 585.39, 6.92), 0.72, 0.72, {
		name="PalominoFwyShop",
		debugPoly=false,
		heading=107.759,
		minZ=6.92,
		maxZ=7.81
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("BarbarenoRoadShop", vector3(-3250.69, 1004.44, 11.85), 0.72, 0.72, {
		name="BarbarenoRoadShop",
		debugPoly=false,
		heading=85.74,
		minZ=11.85,
		maxZ=12.73
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("Rout68Shop", vector3(546.53, 2662.17, 41.17), 0.72, 0.72, {
		name="Rout68Shop",
		debugPoly=false,
		heading=187.5,
		minZ=41.17,
		maxZ=42.05
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("AlhambraDrAndNilandAveShop", vector3(1958.93, 3749.47, 31.34), 0.72, 0.72, {
		name="AlhambraDrAndNilandAveShop",
		debugPoly=false,
		heading=30.0,
		minZ=31.34,
		maxZ=32.22
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("SenoraFrwyShop", vector3(1735.09, 6421.44, 34.03), 0.72, 0.72, {
		name="SenoraFrwyShop",
		debugPoly=false,
		heading=333.641,
		minZ=34.03,
		maxZ=34.91
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("DavisAveAndGroveStShop", vector3(-43.93, -1747.96, 28.47), 0.72, 0.72, {
		name="DavisAveAndGroveStShop",
		debugPoly=false,
		heading=49.986,
		minZ=28.46,
		maxZ=29.34
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("MirrorParkBlvdShop", vector3(1158.86, -314.14, 68.22), 0.72, 0.72, {
		name="MirrorParkBlvdShop",
		debugPoly=false,
		heading=100.0,
		minZ=68.22,
		maxZ=69.1
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("PalominoAveAndGingerShop", vector3(-710.34, -904.15, 18.22), 0.72, 0.72, {
		name="PalominoAveAndGingerShop",
		debugPoly=false,
		heading=90.0,
		minZ=18.22,
		maxZ=19.1
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("BanhamCanyonDrShop", vector3(-1829.65, 798.34, 137.2), 0.72, 0.72, {
		name="BanhamCanyonDrShop",
		debugPoly=false,
		heading=132.466,
		minZ=137.2,
		maxZ=138.08
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("GrapeseedMainStShop", vector3(1708.27, 4920.98, 41.05), 0.72, 0.72, {
		name="GrapeseedMainStShop",
		debugPoly=false,
		heading=325.0,
		minZ=41.05,
		maxZ=41.93
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("InnocenceBlvdAndElginAveShop", vector3(28.18, -1338.53, 28.49), 0.72, 0.72, {
		name="InnocenceBlvdAndElginAveShop",
		debugPoly=false,
		heading=0.0,
		minZ=28.49,
		maxZ=29.37
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})
	exports['labrp_Eye']:AddBoxZone("ClintonAveShop", vector3(378.31, 334.02, 102.58), 0.72, 0.72, {
		name="ClintonAveShop",
		debugPoly=false,
		heading=345.885,
		minZ=102.58,
		maxZ=103.46
	}, 
	{
		options = {
			{
				event = "startStoreHack",
				icon = "fas fa-lock",
				label = "Crack Safe",
			},
		},
		job = {"all"},
		distance = 1.6
	})




Banks = {
    F1 = {
        prop = {
            first = {coords = vector3(311.5481, -284.5114, 54.285), rot = vector3(90.0, 180.0, 21.0)},
            second = {coords = vector3(312.90, -284.95, 54.285), rot = vector3(90.0, 180.0, 110.0)}
        },
        trolley1 = {x = 313.45, y = -289.24, z = 53.14, h = -15},
        trolley2 = {x = 311.51, y = -288.54, z = 53.14, h = -15},
        trolley3 = {x = 314.49, y = -283.65, z = 53.14, h = 160},
        objects = {
            vector3(313.45, -289.24, 53.14),
            vector3(311.51, -288.54, 53.14),
            vector3(314.49, -283.65, 53.14)
        },
        loot1 = false,
        loot2 = false,
        loot3 = false,
        onaction = false,
        lastrobbed = 0
    },
    F2 = {
        doors = {
            startloc = {x = 146.61, y = -1046.02, z = 29.37, h = 244.20, animcoords = {x = 146.75, y = -1045.60, z = 28.37, h = 244.20}},
            secondloc = {x = 148.76, y = -1045.89, z = 29.37, h = 158.54, animcoords = {x = 149.10, y = -1046.08, z = 28.37, h = 158.54}}
        },
        prop = {
            first = {coords = vector3(147.22, -1046.148, 29.487), rot = vector3(90.0, 180.0, 20.0)},
            second = {coords = vector3(148.57, -1046.578, 29.487), rot = vector3(90.0, 180.0, 110.0)}
        },
        trolley1 = {x = 147.25, y = -1050.38, z = 28.35, h = -15},
        trolley2 = {x = 149.21, y = -1051.07, z = 28.35, h = -15},
        trolley3 = {x = 150.23, y = -1045.40, z = 28.35, h = 160},
        objects = {
            vector3(147.25, -1050.38, 28.35),
            vector3(149.21, -1051.07, 28.35),
            vector3(150.23, -1045.40, 28.35)
        },
        loot1 = false,
        loot2 = false,
        loot3 = false,
        onaction = false,
        lastrobbed = 0
    },
    F3 = {
        doors = {
            startloc = {x = -1211.07, y = -336.68, z = 37.78, h = 296.76, animcoords = {x = -1211.25, y = -336.37, z = 36.78, h = 296.76}}, 
            secondloc = {x = -1209.66, y = -335.15, z = 37.78, h = 213.67, animcoords = {x = -1209.40, y = -335.05, z = 36.78, h = 213.67}}
        },
        prop = {
            first = {coords = vector3(-1210.50, -336.37, 37.901), rot = vector3(-90.0, 0.0, 25.0)},
            second = {coords = vector3(-1209.27, -335.68, 37.90), rot = vector3(90.0, 180.0, 65.0)}
        },
        trolley1 = {x = -1207.50, y = -339.20, z = 36.76, h = 30},
        trolley2 = {x = -1205.61, y = -338.24, z = 36.76, h = 30},
        trolley3 = {x = -1209.10, y = -333.59, z = 36.76, h = 210},
        objects = {
            vector3(-1207.50, -339.20, 36.76),
            vector3(-1205.61, -338.24, 36.76),
            vector3(-1209.10, -333.59, 36.76)
        },
        loot1 = false,
        loot2 = false,
        loot3 = false,
        onaction = false,
        lastrobbed = 0
    },
    F4 = {
        hash = 4231427725, -- exception
        doors = {
            startloc = {x = -2956.68, y = 481.34, z = 15.70, h = 353.97, animcoords = {x = -2956.68, y = 481.34, z = 14.70, h = 353.97}},
            secondloc = {x = -2957.26, y = 483.53, z = 15.70, h = 267.73, animcoords = {x = -2957.26, y = 483.53, z = 14.70, h = 267.73}}
        },
        prop = {
            first = {coords = vector3(-2956.59, 482.05, 15.815), rot = vector3(90.0, 180.0, -88.0)},
            second = {coords = vector3(-2956.60, 483.46, 15.815), rot = vector3(90.0, 180.0, 3.0)}
        },
        trolley1 = {x = -2952.69, y = 483.34, z = 14.68, h = 85},
        trolley2 = {x = -2952.57, y = 485.18, z = 14.68, h = 85},
        trolley3 = {x = -2958.35, y = 484.69, z = 14.68, h = 270},
        objects = {
            vector3(-2952.69, 483.34, 14.68),
            vector3(-2952.57, 485.18, 14.68),
            vector3(-2958.35, 484.69, 14.68)
        },
        loot1 = false,
        loot2 = false,
        loot3 = false,
        onaction = false,
        lastrobbed = 0
    },
    F5 = {
        doors = {
            startloc = {x = -354.15, y = -55.11, z = 49.04, h = 251.05, animcoords = {x = -354.15, y = -55.11, z = 48.04, h = 251.05}},
            secondloc = {x = -351.97, y = -55.18, z = 49.04, h = 159.79, animcoords = {x = -351.97, y = -55.18, z = 48.04, h = 159.79}}
        },
        prop = {
            first = {coords = vector3(-353.50, -55.37, 49.157), rot = vector3(90.0, 180.0, 20.0)},
            second = {coords = vector3(-352.15, -55.77, 49.157), rot = vector3(90.0, 180.0, 110.0)}
        },
        trolley1 = {x = -353.34, y = -59.48, z = 48.01, h = -15},
        trolley2 = {x = -351.57, y = -60.09, z = 48.01, h = -15},
        trolley3 = {x = -350.57, y = -54.45, z = 48.01, h = 160},
        objects = {
            vector3(-353.34, -59.48, 48.01),
            vector3(-351.57, -60.09, 48.01),
            vector3(-350.57, -54.45, 48.01)
        },
        loot1 = false,
        loot2 = false,
        loot3 = false,
        onaction = false,
        lastrobbed = 0
    },
    F6 = {
        doors = {
            startloc = {x = 1176.40, y = 2712.75, z = 38.09, h = 84.83, animcoords = {x = 1176.40, y = 2712.75, z = 37.09, h = 84.83}},
            secondloc = {x = 1174.24, y = 2712.47, z = 38.09, h = 359.05, animcoords = {x = 1174.33, y = 2712.09, z = 37.09, h = 359.05}}
        },
        prop = {
            first = {coords = vector3(1175.70, 2712.82, 38.207), rot = vector3(90.0, 180.0, 180.0)},
            second = {coords = vector3(1174.267, 2712.736, 38.207), rot = vector3(90.0, 180.0, -90.0)}
        },
        trolley1 = {x = 1174.24, y = 2716.69, z = 37.07, h = -180},
        trolley2 = {x = 1172.27, y = 2716.67, z = 37.07, h = -180},
        trolley3 = {x = 1173.23, y = 2711.02, z = 37.07, h = 0},
        objects = {
            vector3(1174.24, 2716.69, 37.07),
            vector3(1172.27, 2716.67, 37.07),
            vector3(1173.23, 2711.02, 37.07)
        },
        loot1 = false,
        loot2 = false,
        loot3 = false,
        onaction = false,
        lastrobbed = 0
    }
}