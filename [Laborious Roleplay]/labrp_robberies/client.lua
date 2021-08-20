local isRobbing = false
local cooldown = false
local playerCoords = GetEntityCoords(PlayerPedId(), true)
local Robbed = {}

local robbableFleeca = {
    [1] = {x = 146.3341, y = -1045.464, z = 29.36414, info = 'Legion Square Fleeca'},
    [2] = {x = 311.1297, y = -284.3736, z = 54.15015, info = 'Pink Cage Fleeca'},
    [3] = {x = -353.8286, y = -55.2, z = 49.02783, info = 'CourtHouse Fleeca'},
    [4] = {x = -1210.813, y = -336.567, z = 37.77222, info = 'CourtHouse Fleeca'},
    [5] = {x = -2956.563, y = 481.6879, z = 15.68201, info = 'West LS Fleeca'}, 
    [5] = {x = 1176.04, y = 2712.857, z = 38.07544, info = 'Route 68 Fleeca'},
}

local PowerStation = {
    [1] = {x = 713.0242, y = 164.2813, z = 80.73926, info = 'LS Power Station'},
}

local FleecaTrolleys = {
    [1] = {x = 147.3363, y = -1050.185, z = 28.33044, info = 'LS Power Station'},
    [1] = {x = 311.433, y = -288.2374, z = 53.1333, info = 'LS Power Station'},
}

local StoreRobberies = {
    [1] = {x = 28.02198, y = -1339.134, z = 29.48206, info = 'Innocence Blvd 24/7'},
    [2] = {x = 2549.459, y = 384.8703, z = 108.6088, info = 'Palomino 24/7'},
    [3] = {x = -43.37143, y = -1748.611, z = 29.41467, info = 'Grove Street 24/7'},
    [4] = {x = -709.5297, y = -904.1407, z = 19.20361, info = 'Little Seoul 24/7'},
    [5] = {x = 1159.556, y = -314.1363, z = 69.19702, info = 'Mirror Park 24/7'},
    [6] = {x = 378.0659, y = 333.3099, z = 103.5538, info = 'Pacific Standard 24/7'},
    [7] = {x = -1828.971, y = 798.8307, z = 138.1802, info = 'West LS 24/7'},
    [8] = {x = -3047.776, y = 585.4681, z = 7.897461, info = 'GreatOcean Hwy 24/7'},
    [9] = {x = -3250.022, y = 1004.426, z = 12.81763, info = 'GreatOcean Hwy#2 24/7'},
}


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

function CheckRobbed(data)
    local doormodel = data.entity
    for k, v in ipairs(Robbed) do
        if v == doormodel then
            print('is in table')
            return true
        end
    end
    print('not in table')
    return false
end


exports['labrp_Eye']:AddTargetModel({2121050683}, {
    options = {
        {
            event = "fleeca:attemptrob",
            icon = "fas fa-laptop-code",
            label = "Hack Vault Door",
            canInteract = function(entity)
                return true
            end
        },
    },
    distance = 1.5,
})

RegisterNetEvent('fleeca:attemptrob')
AddEventHandler('fleeca:attemptrob', function(data)
    local model = data.entity
    if not CheckRobbed(data) then
        local doorCoords = GetEntityCoords(model)
        table.insert(Robbed, model)
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
        Citizen.Wait(8000)
        TriggerEvent('SpawnTrolley', model)
        TriggerServerEvent('openfleecadoor', data)
        print(data.entity)
        --[[exports['hacking']:OpenHackingGame(function(Success)
        if Success then 
                print('passed')
                exports['mythic_notify']:SendAlert('success', 'Nice Job!')
                local count = 0
                repeat
                    local heading = GetEntityHeading(model) - 0.10
                    SetEntityHeading(model, heading)
                    count = count + 1
                    Citizen.Wait(10)
                until count == 900
                TriggerEvent('SpawnTrolley', model)
            else
                exports['mythic_notify']:SendAlert('error', 'This hack is too complicated?!')
            end
        end)]]
    else
        print('closing door')
        TriggerEvent("fleeca:closevaultdoor", data)
    end
end)

RegisterNetEvent("fleeca:openvaultdoor")
AddEventHandler("fleeca:openvaultdoor", function(data)
    local obj = data.entity
    print(obj)
	local count = 0
	repeat
		local heading = GetEntityHeading(obj) - 0.10
		SetEntityHeading(obj, heading)
		count = count + 1
		Citizen.Wait(10)
	until count == 900
end)

RegisterNetEvent("fleeca:closevaultdoor")
AddEventHandler("fleeca:closevaultdoor", function(data)
    local obj = data.entity
    print(obj)
	local count = 0
	repeat
		local heading = GetEntityHeading(obj) + 0.10
		SetEntityHeading(obj, heading)
		count = count + 1
		Citizen.Wait(10)
	until count == 900
end)


RegisterNetEvent("SpawnTrolley")
AddEventHandler("SpawnTrolley", function(model)
	local playerCoords = GetEntityCoords(PlayerPedId(), true)
	for id,v in pairs(FleecaTrolleys) do
        RequestModel("hei_prop_hei_cash_trolly_01")
        while not HasModelLoaded("hei_prop_hei_cash_trolly_01") do
          Citizen.Wait(4)
        end
        Trolley1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), v.x, v.y, v.z, 1, 1, 0)
	end
end)


exports['labrp_Eye']:AddTargetModel({269934519}, {
    options = {
    {
        event = "fleeca:grabcash",
        icon = "fas fa-money-bill",
        label = "Grab Cash",
        canInteract = function(entity)
            return true
        end
    },
    },
    job = {"all"},
    distance = 2.5
})

RegisterNetEvent("fleeca:grabcash")
AddEventHandler("fleeca:grabcash", function(data)
	local lootcart = data.entity
    TaskTurnPedToFaceEntity(PlayerPedId(), lootcart, 1000)
    SetEntityAsMissionEntity(lootcart, false, false)
    Citizen.Wait(1000)
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 10000,
        label = 'Grabbing Cash',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@prop_human_bum_bin@base",
            anim = "base",
        },
    })
    Citizen.Wait(10000)
    TriggerServerEvent('fleeca:reward')
    ClearPedTasks(PlayerPedId())
    DeleteEntity(data.entity)
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
    local coords = GetEntityCoords(PlayerPedId())
    if cooldown == false then
        for id,v in pairs(StoreRobberies) do
            if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
                TriggerEvent('storecooldown')
                exports['core_dispatch']:addCall('10-68', "Store Robbery", {
                    {icon="fa-store", info="24/7 Robbery"}
                    }, {coords.x, coords.y, coords.z}, "police", 10000, 59, 1)
                exports['mythic_progbar']:Progress({
                    name = "unique_action_name",
                    duration = 35000,
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
                Citizen.Wait(35000)
                exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
                function() -- success
                    exports['mythic_notify']:SendAlert('success', "Nice Job!")
                    exports['mythic_progbar']:Progress({
                        name = "unique_action_name",
                        duration = 40000,
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
                    Citizen.Wait(40000)
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


local RegisterModel = {
    -354930144,
    303280717,
    534367705,
    892543765,
}

exports['labrp_Eye']:AddTargetModel(RegisterModel, {
    options = {
        {
            event = "labrp:store:rob",
            icon = "fas fa-hammer",
            label = "Smash Register",
            canInteract = function(entity)
                return true
            end
        },
    },
    distance = 1.5,
})

AddEventHandler('labrp:store:rob', function(data)
    local health = GetEntityHealth(data.entity)
    print(health)
    if health >= 1000 then
        exports['mythic_notify']:SendAlert('error', "This hasn't been smashed yet!")
    else
        exports['mythic_notify']:SendAlert('inform', "Robbing!")
        ESX.TriggerServerCallback('labrp:store:haslockpick', function(hasEnough)
            if hasEnough then
                local finished = exports["reload-skillbar"]:taskBar(30000,math.random(5,15))
                if finished ~= 100 then
                    exports['mythic_notify']:SendAlert('error', "Lockpick bent out of shape!")
                else
                    local finished2 = exports["reload-skillbar"]:taskBar(1500,math.random(5,15))
                    if finished2 ~= 100 then
                        exports['mythic_notify']:SendAlert('error', "Lockpick bent out of shape!")
                    else
                        local finished3 = exports["reload-skillbar"]:taskBar(25000,math.random(5,15))
                        if finished3 ~= 100 then
                            exports['mythic_notify']:SendAlert('error', "Lockpick bent out of shape!")
                        else
                            exports['mythic_progbar']:Progress({
                                name = "unique_action_name",
                                duration = 10000,
                                label = 'Robbing Store',
                                useWhileDead = true,
                                canCancel = false,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                                animation = {
                                    animDict = "random@shop_robbery",
                                    anim = "robbery_intro_loop_b",
                                },
                            })
                            Citize.Wait(10000)
                            ClearPedTasks(PlayerPedId(-1))
                            TriggerServerEvent('labrp:store:payout')
                        end
                    end
                end
            else
                exports['mythic_notify']:SendAlert('error', "You don't have a lockpick!")
            end
        end)
    end
end)