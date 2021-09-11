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

RegisterNetEvent("labrp_store:startRobbery")
AddEventHandler("labrp_store:startRobbery", function()
    ESX.TriggerServerCallback('labrp_store:checkrequired', function(Required)
        local playerCoords = GetEntityCoords(PlayerPedId(), true)
        if Required then
            for id,v in pairs(StoreRobberies) do
                if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then

                    TriggerServerEvent('labrp_store:cooldown')

                    local data = {displayCode = '10-68', description = 'Store Robbery', isImportant = 0, recipientList = {'police', 'fbi'}, length = '15000',blipSprite = 618, blipColour = 11, blipScale = 1.2, infoM = 'fas fa-cash-register', info = 'Store Robbery'} --
                    local dispatchData = {dispatchData = data, caller = 'Security System', coords = playerCoords}
                    TriggerServerEvent('wf-alerts:svNotify', dispatchData)

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
                            animDict = "amb@medic@standing@kneel@idle_a",
                            anim = "idle_a",
                        },
                    })

                    Citizen.Wait(35000)

                    exports["memorygame"]:thermiteminigame(10, 300, 3, 10,
                    function()
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
                                animDict = "mp_missheist_ornatebank",
                                anim = "put_cash_into_bag_loop",
                            },
                        })
                        Citizen.Wait(40000)
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent('labrp_store:givereward')
                    end,
                    function()
                        exports['mythic_notify']:SendAlert('error', "Hack Failed!")
                    end)
                    TriggerServerEvent('labrp_store:removeLockpick')
                    ClearPedTasks(PlayerPedId())
                end
            end
        else
            exports['mythic_notify']:SendAlert('error', 'System Currently Down!')
        end
    end)
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
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
            event = "labrp_store:startRobbery",
            icon = "fas fa-lock",
            label = "Crack Safe",
            required_item = "advancedlockpick"
        },
    },
    
    distance = 1.6
})

exports['labrp_Eye']:AddTargetModel({303280717}, {
    options = {
        {
            event = "labrp_store:robRegister",
            icon = "fas fa-hammer",
            label = "Smash Register",
            required_item = "advancedlockpick",
            canInteract = function(entity)
                if GetEntityHealth(entity) < 900 then
                    return true
                end
                return false
            end
        },
    },
    distance = 2.5
})

AddEventHandler('labrp_store:robRegister', function(data)
    local register = data.entity
    ESX.TriggerServerCallback('labrp_store:checkRegister', function(canRob)
        if canRob then
            local data = {displayCode = '10-68', description = 'Store Robbery', isImportant = 0, recipientList = {'police', 'fbi'}, length = '15000',blipSprite = 618, blipColour = 11, blipScale = 1.2, infoM = 'fas fa-cash-register', info = 'Store Robbery'} --
            local dispatchData = {dispatchData = data, caller = 'Security System', coords = playerCoords}
            TriggerServerEvent('wf-alerts:svNotify', dispatchData)
            
            TriggerServerEvent('labrp_store:TableInsertRegister', register)
            local skillcheck = exports["reload-skillbar"]:taskBar(25000,math.random(5,15))
            if skillcheck == 100 then
                local skillcheck2 = exports["reload-skillbar"]:taskBar(750,math.random(5,8))
                if skillcheck2 == 100 then
                    exports['mythic_progbar']:Progress({
						name = "unique_action_name",
						duration = math.random(10000, 20000),
						label = 'Robbing Register',
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
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('labrp_store:RegisterReward')
                else
                    exports['mythic_notify']:SendAlert('error', 'Lockpick Failed!') 
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Lockpick Failed!') 
            end
        else
            exports['mythic_notify']:SendAlert('error', 'Looks like this has already been robbed!') 
        end
    end, register)
end)