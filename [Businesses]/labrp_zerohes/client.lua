Config = {}
ESX              = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------

-- Polyzones / Eye Events

Citizen.CreateThread(function()
  exports['labrp_Eye']:AddBoxZone("zerohes:meleecraft", vector3(61.7011, -2582.927, 7.071777), 3.5, 0.9, {
    name="zerohes:meleecraft",
    heading=85.0,
    debugPoly=false,
    minZ=6.0,
    maxZ=7.0
    }, {
        options = {
            {
                event = "melee:menu1", 
                icon = "fas fa-tools",
                label = "Melee Crafting",
            },

        },
        job = {"zerohes"},
        distance = 3.5
    }) --
end)



--------------------------------------------------------------------------------------------------------------------------------------------

-- NH Context Events

RegisterNetEvent('melee:menu1')
AddEventHandler('melee:menu1', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Melee Crafting",
            txt = ""
        },
        {
            id = 2,
            header = "Knuckle Dusters",
            txt = "Required Items | x10 Steel, x5 Scrap",
            params = {
                event = "craftduster",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Switch Blade",
            txt = "Required Items | x4 Steel, x1 Rubber, x3 Scrap",
            params = {
                event = "craftblade",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Machete",
            txt = "Required Items | x10 Steel, x3 Rubber, x5 Scrap",
            params = {
                event = "craftmachete",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
    })
end)

RegisterNetEvent('craftduster')
AddEventHandler('craftduster', function()
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 60000,
        label = 'Crafting Knuckle Duster',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })
    Citizen.Wait(60000)
    TriggerServerEvent('craft:duster')
end)

RegisterNetEvent('craftblade')
AddEventHandler('craftblade', function()
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 60000,
        label = 'Crafting Switch Blade',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })
    Citizen.Wait(60000)
    TriggerServerEvent('craft:blade')
end)

RegisterNetEvent('craftmachete')
AddEventHandler('craftmachete', function()
    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 60000,
        label = 'Crafting Machete',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })
    Citizen.Wait(60000)
    TriggerServerEvent('craft:machete')
end)















































































-- RegisterNetEvent('ammo:menu1')
-- AddEventHandler('ammo:menu1', function()
--     TriggerEvent('nh-context:sendMenu', {
--         {
--             id = 1,
--             header = "Weapon Crafting",
--             txt = ""
--         },
-- 		{
--             id = 2,
--             header = "Micro Uzi",
--             txt = "Required Items | x4 Weapon Bodies, x1 Weapon Handle, x2 Weapon Stock, x2 Weapon Barrels, x1 Weapon Magazine",
--             params = {
--                 event = "ammo:menu1",
--                 args = {
--                     number = 1,
--                     id = 2
--                 }
--             }
--         },
--         {
--             id = 3,
--             header = "Mini SMG",
--             txt = "Required Items | x3 Weapon Bodies, x1 Weapon Handle, x1 Weapon Stock, x2 Weapon Barrels, x1 Weapon Magazine",
--             params = {
--                 event = "ammo:menu1",
--                 args = {
--                     number = 2,
--                     id = 3
--                 }
--             }
--         },
--         {
--             id = 4,
--             header = "Machine Pistol",
--             txt = "Required Items | x3 Weapon Bodies, x1 Weapon Handle, x1 Weapon Stock, x2 Weapon Barrels, x1 Weapon Magazine",
--             params = {
--                 event = "ammo:menu1",
--                 args = {
--                     number = 3,
--                     id = 4
--                 }
--             }
--         },
--         {
--             id = 5,
--             header = "Desert Eagle",
--             txt = "Required Items | x2 Weapon Bodies, x3 Weapon Handle, x2 Weapon Barrels, x1 Weapon Magazine",
--             params = {
--                 event = "ammo:menu1",
--                 args = {
--                     number = 4,
--                     id = 5
--                 }
--             }
--         },
--         {
--             id = 6,
--             header = "AP Pistol",
--             txt = "Required Items | x2 Weapon Bodies, x2 Weapon Handle, x2 Weapon Barrels, x1 Weapon Magazine",
--             params = {
--                 event = "ammo:menu1",
--                 args = {
--                     number = 5,
--                     id = 6
--                 }
--             }
--         },
--     })
-- end)

-- RegisterNetEvent('ammo:menu2')
-- AddEventHandler('ammo:menu2', function()
--     TriggerEvent('nh-context:sendMenu', {
--         {
--             id = 1,
--             header = "Weapon Parts Crafting",
--             txt = ""
--         },
-- 		{
--             id = 2,
--             header = "x1 Weapon Body",
--             txt = "Required Items - x80 Scrap Metal",
--             params = {
--                 event = "ammo:body",
--                 args = {
--                     number = 1,
--                     id = 2
--                 }
--             }
--         },
--         {
--             id = 3,
--             header = "x1 Weapon Handle",
--             txt = "Required Items - x35 Rubber",
--             params = {
--                 event = "ammo:handle",
--                 args = {
--                     number = 2,
--                     id = 3
--                 }
--             }
--         },
--         {
--             id = 4,
--             header = "x1 Weapon Stock",
--             txt = "Required Items - x40 Steel",
--             params = {
--                 event = "ammo:stock",
--                 args = {
--                     number = 3,
--                     id = 4
--                 }
--             }
--         },
--         {
--             id = 5,
--             header = "x1 Weapon Barrel",
--             txt = "Required Items - x30 Scrap Metal",
--             params = {
--                 event = "ammo:barrel",
--                 args = {
--                     number = 4,
--                     id = 5
--                 }
--             }
--         },
--         {
--             id = 6,
--             header = "x1 Weapon Magazine",
--             txt = "Required Items - x10 Steel",
--             params = {
--                 event = "ammo:mag",
--                 args = {
--                     number = 5,
--                     id = 6
--                 }
--             }
--         },
--     })
-- end)


-- RegisterNetEvent('ammo:menupurchase')
-- AddEventHandler('ammo:menupurchase', function()
--     TriggerEvent('nh-context:sendMenu', {
--         {
--             id = 1,
--             header = "Ammunation - Purchase Materials",
--             txt = ""
--         },
-- 		{
--             id = 2,
--             header = "Scrap Metal",
--             txt = "x10 - $250",
--             params = {
--                 event = "ammo:scrap",
--                 args = {
--                     number = 1,
--                     id = 2
--                 }
--             }
--         },
--     })
-- end)

-- RegisterNetEvent('ammo:menuammo')
-- AddEventHandler('ammo:menuammo', function()
--     TriggerEvent('nh-context:sendMenu', {
--         {
--             id = 1,
--             header = "Ammunation - Craft Ammo Boxes",
--             txt = ""
--         },
-- 		{
--             id = 2,
--             header = "x1 9mm Ammo Box",
--             txt = "",
--             params = {
--                 event = "ammo:menuammo",
--                 args = {
--                     number = 1,
--                     id = 2
--                 }
--             }
--         },
--         {
--             id = 3,
--             header = "x1 .45 ACP Ammo Box",
--             txt = "",
--             params = {
--                 event = "ammo:menuammo",
--                 args = {
--                     number = 2,
--                     id = 3
--                 }
--             }
--         },
--         {
--             id = 4,
--             header = "Scrap Metal",
--             txt = "x10 - $250",
--             params = {
--                 event = "ammo:menuammo",
--                 args = {
--                     number = 3,
--                     id = 4
--                 }
--             }
--         },
--     })
-- end)

-- --------------------------------------------------------------------------------------------------------------------------------------------

-- -- Weapon Part Crafting

-- RegisterNetEvent('ammo:body')
-- AddEventHandler('ammo:body', function()
--     ESX.TriggerServerCallback("plasmabodycheck", function(data)
--         if data then
--             TriggerEvent("ammo:craftbody")
--         else
--             exports['mythic_notify']:SendAlert('error', 'You do not have the required Items.')
--         end
--     end, "scrapmetal")
-- end)

-- RegisterNetEvent("ammo:craftbody")
-- AddEventHandler("ammo:craftbody", function()
--     ESX.TriggerServerCallback("plasmabodycheck", function(data)
--         if data then
--             exports['mythic_progbar']:Progress({
--                 name = "unique_action_name",
--                 duration = 10000,
--                 label = 'Crafting Weapon Body',
--                 useWhileDead = false,
--                 canCancel = false,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 },
--             })
--             Citizen.Wait(10000)
--             TriggerServerEvent('ammo:givebody')
--             else
--                 exports['mythic_notify']:SendAlert('error', 'You do not have the required materials.') 
--         end
--     end, "scrapmetal")
-- end)



-- RegisterNetEvent('ammo:handle')
-- AddEventHandler('ammo:handle', function()
--     ESX.TriggerServerCallback("plasmahandlecheck", function(data)
--         if data then
--             TriggerEvent("ammo:crafthandle")
--         else
--             exports['mythic_notify']:SendAlert('error', 'You do not have the required Items.')
--         end
--     end, "rubber")
-- end)

-- RegisterNetEvent("ammo:crafthandle")
-- AddEventHandler("ammo:crafthandle", function()
--     ESX.TriggerServerCallback("plasmahandlecheck", function(data)
--         if data then
--             exports['mythic_progbar']:Progress({
--                 name = "unique_action_name",
--                 duration = 10000,
--                 label = 'Crafting Weapon Handle',
--                 useWhileDead = false,
--                 canCancel = false,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 },
--             })
--             Citizen.Wait(10000)
--             TriggerServerEvent('ammo:givehandle')
--             else
--                 exports['mythic_notify']:SendAlert('error', 'You do not have the required materials.') 
--         end
--     end, "rubber")
-- end)

-- RegisterNetEvent('ammo:stock')
-- AddEventHandler('ammo:stock', function()
--     ESX.TriggerServerCallback("plasmahandlecheck", function(data)
--         if data then
--             TriggerEvent("ammo:craftstock")
--         else
--             exports['mythic_notify']:SendAlert('error', 'You do not have the required Items.')
--         end
--     end, "steel")
-- end)

-- RegisterNetEvent("ammo:craftstock")
-- AddEventHandler("ammo:craftstock", function()
--     ESX.TriggerServerCallback("plasmastockcheck", function(data)
--         if data then
--             exports['mythic_progbar']:Progress({
--                 name = "unique_action_name",
--                 duration = 10000,
--                 label = 'Crafting Weapon Stock',
--                 useWhileDead = false,
--                 canCancel = false,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 },
--             })
--             Citizen.Wait(10000)
--             TriggerServerEvent('ammo:givestock')
--             else
--                 exports['mythic_notify']:SendAlert('error', 'You do not have the required materials.') 
--         end
--     end, "steel")
-- end)

-- RegisterNetEvent('ammo:barrel')
-- AddEventHandler('ammo:barrel', function()
--     ESX.TriggerServerCallback("plasmabarrelcheck", function(data)
--         if data then
--             TriggerEvent("ammo:craftbarrel")
--         else
--             exports['mythic_notify']:SendAlert('error', 'You do not have the required Items.')
--         end
--     end, "scrapmetal")
-- end)

-- RegisterNetEvent("ammo:craftbarrel")
-- AddEventHandler("ammo:craftbarrel", function()
--     ESX.TriggerServerCallback("plasmabarrelcheck", function(data)
--         if data then
--             exports['mythic_progbar']:Progress({
--                 name = "unique_action_name",
--                 duration = 10000,
--                 label = 'Crafting Weapon Barrel',
--                 useWhileDead = false,
--                 canCancel = false,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 },
--             })
--             Citizen.Wait(10000)
--             TriggerServerEvent('ammo:givebarrel')
--             else
--                 exports['mythic_notify']:SendAlert('error', 'You do not have the required materials.') 
--         end
--     end, "scrapmetal")
-- end)

-- RegisterNetEvent('ammo:mag')
-- AddEventHandler('ammo:mag', function()
--     ESX.TriggerServerCallback("plasmamagcheck", function(data)
--         if data then
--             TriggerEvent("ammo:craftmag")
--         else
--             exports['mythic_notify']:SendAlert('error', 'You do not have the required Items.')
--         end
--     end, "steel")
-- end)

-- RegisterNetEvent("ammo:craftmag")
-- AddEventHandler("ammo:craftmag", function()
--     ESX.TriggerServerCallback("plasmamagcheck", function(data)
--         if data then
--             exports['mythic_progbar']:Progress({
--                 name = "unique_action_name",
--                 duration = 10000,
--                 label = 'Crafting Weapon Magazine',
--                 useWhileDead = false,
--                 canCancel = false,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 },
--             })
--             Citizen.Wait(10000)
--             TriggerServerEvent('ammo:givemag')
--             else
--                 exports['mythic_notify']:SendAlert('error', 'You do not have the required materials.') 
--         end
--     end, "steel")
-- end)

-- --------------------------------------------------------------------------------------------------------------------------------------------

-- RegisterNetEvent("ammo:payment")
-- AddEventHandler("ammo:payment", function()
--     local bill = exports["nh-keyboard"]:KeyboardInput({
--         header = "Ammunation",
--         rows = {
--             {
--                 id = 0,
--                 txt = "Player ID"
--             },
--             {
--                 id = 1,
--                 txt = "Amount"
--             },
--             {
--               id = 2,
--               txt = "Order"
--             },
--         }
--     })
--     if bill then
--       TriggerServerEvent("ammo:payment", bill[1].input, bill[2].input, bill[3].input)
--     end
-- end)

-- RegisterNetEvent("ammo:announce")
-- AddEventHandler("ammo:announce", function()
--   TriggerServerEvent('ammo:openmsg')
-- end)

-- RegisterNetEvent("ammo:scrap")
-- AddEventHandler("ammo:scrap", function()
--     ESX.TriggerServerCallback("plasma:ammo:moneycheck", function(data)
--         if data then
--             exports['mythic_progbar']:Progress({
--                 name = "unique_action_name",
--                 duration = 5000,
--                 label = 'Purchasing Scrap Metal',
--                 useWhileDead = false,
--                 canCancel = false,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 },
--             })
--             Citizen.Wait(5000)
--             TriggerServerEvent('ammo:buyscrap')
--         else
--             exports['mythic_notify']:SendAlert('error', 'You do not have enough money.')
--         end
--     end, "money")
-- end)

-- RegisterNetEvent("ammobox:rifle")
-- AddEventHandler("ammobox:rifle", function()
--     exports['mythic_progbar']:Progress({
--         name = "unique_action_name",
--         duration = 2500,
--         label = 'Using Ammo Box',
--         useWhileDead = false,
--         canCancel = false,
--         controlDisables = {
--             disableMovement = false,
--             disableCarMovement = false,
--             disableMouse = false,
--             disableCombat = true,
--         },
--     })
--     Citizen.Wait(2500)
--     TriggerServerEvent('rifleammobox:give')
-- end)

-- RegisterNetEvent("ammobox:9mm")
-- AddEventHandler("ammobox:9mm", function()
--     exports['mythic_progbar']:Progress({
--         name = "unique_action_name",
--         duration = 2500,
--         label = 'Using Ammo Box',
--         useWhileDead = false,
--         canCancel = false,
--         controlDisables = {
--             disableMovement = false,
--             disableCarMovement = false,
--             disableMouse = false,
--             disableCombat = true,
--         },
--     })
--     Citizen.Wait(2500)
--     TriggerServerEvent('9mmammobox:give')
-- end)

-- RegisterNetEvent("ammobox:45")
-- AddEventHandler("ammobox:45", function()
--     exports['mythic_progbar']:Progress({
--         name = "unique_action_name",
--         duration = 2500,
--         label = 'Using Ammo Box',
--         useWhileDead = false,
--         canCancel = false,
--         controlDisables = {
--             disableMovement = false,
--             disableCarMovement = false,
--             disableMouse = false,
--             disableCombat = true,
--         },
--     })
--     Citizen.Wait(2500)
--     TriggerServerEvent('45ammobox:give')
-- end)

-- --------------------------------------------------------------------------------------------------------------------------------------------