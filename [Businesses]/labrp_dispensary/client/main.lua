Config = {}
ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterCommand('test', function(source)
  exports['mythic_notify']:SendAlert('inform', 'Testing New CSS')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)




    exports['labrp_Eye']:AddBoxZone("KronicKushCashRegister", vector3(380.24, -827.3, 29.2), 0.55, 0.4, {
    name="KronicKushCashRegister",
    heading=180,
    minZ=29.0,
    maxZ=29.8,
    debugPoly=false,
}, {
    options = {

        {
            event = "kk:payment",
            icon = "fas fa-credit-card",
            label = "Charge Customer",
            job = "kronickush",
        },
     },
    distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("KronicKushBuyStock", vector3(375.5, -827.3, 29.2), 0.55, 0.4, {
  name="KronicKushBuyStock",
  heading=180,
  minZ=29.0,
  maxZ=29.8,
  debugPoly=false,
}, {
  options = {

      {
          event = "kk:purchase",
          icon = "fas fa-credit-card",
          label = "Buy Stock",
          job = "kronickush",
      },
      {
        event = "kk:hire",
        icon = "fas fa-credit-card",
        label = "Hire Person",
        job = "kronickush",
    },
   },
  distance = 1.5
})

RegisterNetEvent("kk:payment")
AddEventHandler("kk:payment", function()
    local bill = exports["nh-keyboard"]:KeyboardInput({
        header = "Kronic Kush",
        rows = {
            {
                id = 0,
                txt = "Player ID"
            },
            {
                id = 1,
                txt = "Amount"
            },
            {
              id = 2,
              txt = "Order"
            },
        }
    })
    if bill then
      TriggerServerEvent("kk:payment", bill[1].input, bill[2].input, bill[3].input)
    end
end)

RegisterNetEvent("kk:hire")
AddEventHandler("kk:hire", function()
    local bill = exports["nh-keyboard"]:KeyboardInput({
        header = "Hire Person",
        rows = {
            {
                id = 0,
                txt = "Player ID"
            },
        }
    })
    if bill then
        TriggerServerEvent("kk:payment", bill[1].input)
    end
end)

RegisterNetEvent("kk:purchase")
AddEventHandler("kk:purchase", function()
  	TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Buy Stock",
            txt = ""
        },
		    {
            id = 2,
            header = "Cookie",
            txt = "$100",
            params = {
                event = "dispensary:buycookie",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Brownie",
            txt = "$100",
            params = {
                event = "dispensary:buybrownie",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Gummies",
            txt = "$100",
            params = {
                event = "dispensary:buygummies",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
        {
          id = 5,
          header = "Rolling Paper",
          txt = "$100",
          params = {
              event = "dispensary:buyrollingpaper",
              args = {
                  number = 4,
                  id = 5
              }
          }
      },
      {
        id = 6,
        header = "Rolling Tray",
        txt = "$100",
        params = {
            event = "dispensary:buyrollingtray",
            args = {
                number = 5,
                id = 6
            }
        }
    },
    })
end)


RegisterNetEvent("dispensary:buycookie")
AddEventHandler("dispensary:buycookie", function()
  TriggerServerEvent('kk:purchase', 'cookie')
end)

RegisterNetEvent("dispensary:buybrownie")
AddEventHandler("dispensary:buybrownie", function()
  TriggerServerEvent('kk:purchase', 'brownie')
end)

RegisterNetEvent("dispensary:buygummies")
AddEventHandler("dispensary:buygummies", function()
  TriggerServerEvent('kk:purchase', 'gummies')
end)

RegisterNetEvent("dispensary:buyrollingtray")
AddEventHandler("dispensary:buyrollingtray", function()
  TriggerServerEvent('kk:purchase', 'rollingtray')
end)

RegisterNetEvent("dispensary:buyrollingpaper")
AddEventHandler("dispensary:buyrollingpaper", function()
  TriggerServerEvent('kk:purchase', 'rolling_paper')
end)





























exports['labrp_Eye']:AddBoxZone("KKWeedTable", vector3(382.49, -817.4, 29.3), 1.0, 2.0, {
  name="KKWeedTable",
  heading=0,
  minZ=29.0,
  maxZ=29.8,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:weedtable",
          icon = "fas fa-cannabis",
          label = "Weed Table",
      },
      {
        event = "dispensary:bakingtable",
        icon = "fas fa-cookie-bite",
        label = "Baking Tray",
    },
   },
   job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("KKStorage", vector3(383.6, -819.7, 30), 1.8, 0.5, {
  name="KKStorage",
  heading=0,
  minZ=28.0,
  maxZ=30.5,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:storage",
          icon = "fas fa-cannabis",
          label = "Kronic Kush Storage",
      },
   },
   job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("KKFrontDesk", vector3(377.8418, -827.5, 29.5), 0.6, 4.1, {
  name="KKFrontDesk",
  heading=0,
  minZ=28.0,
  maxZ=30.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:cabinet",
          icon = "fas fa-cannabis",
          label = "Cabinet",
      },
   },
   job = {"all"},
  distance = 1.5
})




AddEventHandler('dispensary:weedtable', function()
	TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Weed Table",
            txt = ""
        },
		{
            id = 2,
            header = "Kronic Kush",
            txt = "Lowest",
            params = {
                event = "dispensary:kronickush",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Zurple Punch",
            txt = "Medium",
            params = {
                event = "dispensary:zurplepunch",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Wedding Pie",
            txt = "Highest",
            params = {
                event = "dispensary:weddingpie",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
    })
end)

AddEventHandler('dispensary:bakingtable', function()
	TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Baking Tray",
            txt = ""
        },
		{
            id = 2,
            header = "Edible Gummies",
            txt = "Kronic Kush | Gummies",
            params = {
                event = "dispensary:gummies",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Edible Brownie's",
            txt = "Kronic Kush | Brownie",
            params = {
                event = "dispensary:brownie",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Edible Cookie's",
            txt = "Kronic Kush | Cookie",
            params = {
                event = "dispensary:cookie",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
    })
end)

RegisterNetEvent('dispensary:rollingtray')
AddEventHandler('dispensary:rollingtray', function()
  exports['mythic_progbar']:Progress({
    name = "unique_action_name",
    duration = 1500,
    label = 'Using Rolling Tray',
    useWhileDead = false,
    canCancel = false,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },
    animation = {
      animDict = "missheistdockssetup1clipboard@idle_a",
      anim = "idle_a",
    },
  })
  Citizen.Wait(1500)
  ClearPedTasks(PlayerPedId(-1))
	TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Rolling Tray",
            txt = ""
        },
		{
            id = 2,
            header = "Kronic Kush Joint",
            txt = "Items : Kronic Kush | Rolling Paper",
            params = {
                event = "dispensary:rollkk",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Zurple Punch",
            txt = "Items : Zurple Punch | Rolling Paper",
            params = {
                event = "dispensary:rollzp",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Wedding Pie",
            txt = "Items : Wedding Pie | Rolling Paper",
            params = {
                event = "dispensary:rollwp",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
    })
end)


RegisterNetEvent('dispensary:kronickush')
AddEventHandler('dispensary:kronickush', function()
  TriggerServerEvent('make:kronickush')
end)

RegisterNetEvent('dispensary:zurplepunch')
AddEventHandler('dispensary:zurplepunch', function()
  TriggerServerEvent('make:zurplepunch')
end)

RegisterNetEvent('dispensary:weddingpie')
AddEventHandler('dispensary:weddingpie', function()
  TriggerServerEvent('make:weddingpie')
end)




RegisterNetEvent('dispensary:gummies')
AddEventHandler('dispensary:gummies', function()
  TriggerServerEvent('make:gummies')
end)

RegisterNetEvent('dispensary:brownie')
AddEventHandler('dispensary:brownie', function()
  TriggerServerEvent('make:brownie')
end)

RegisterNetEvent('dispensary:cookie')
AddEventHandler('dispensary:cookie', function()
  TriggerServerEvent('make:cookie')
end)








RegisterNetEvent('dispensary:rollkk')
AddEventHandler('dispensary:rollkk', function()
  TriggerServerEvent('make:rollkk')
end)

RegisterNetEvent('dispensary:rollzp')
AddEventHandler('dispensary:rollzp', function()
  TriggerServerEvent('make:rollzp')
end)

RegisterNetEvent('dispensary:rollwp')
AddEventHandler('dispensary:rollwp', function()
  TriggerServerEvent('make:rollwp')
end)




RegisterNetEvent('dispensary:storage')
AddEventHandler('dispensary:storage', function()
  exports['linden_inventory']:OpenStash({ id = 'Kronic Kush Storage', slots = 100, job= 'kronickush'})
end)

RegisterNetEvent('dispensary:cabinet')
AddEventHandler('dispensary:cabinet', function()
  exports['linden_inventory']:OpenStash({ id = 'Front Cabinet', slots = 5, job= 'all'})
end)

RegisterNetEvent('dispensary:harvest')
AddEventHandler('dispensary:harvest', function()
  exports['mythic_progbar']:Progress({
    name = "unique_action_name",
    duration = 10000,
    label = 'Harvesting Weed',
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
  ClearPedTasks(GetPlayerPed(-1))
  TriggerServerEvent('dispensary:harvestweed')
end)













-- Item Usage --

RegisterNetEvent('use:kkjoint')
AddEventHandler('use:kkjoint', function()
  TriggerServerEvent('removekkjoint')
  exports['mythic_progbar']:Progress({
    name = "unique_action_name",
    duration = 5000,
    label = 'Smoking Joint',
    useWhileDead = false,
    canCancel = false,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = false,
    },
  })
  ExecuteCommand('e smoke')
  Citizen.Wait(5000)
  AnimpostfxPlay("ChopVision", 10000001, true)
  ShakeGameplayCam("DRUNK_SHAKE", 1.0)

  SetEntityHealth(GetPlayerPed(-1), 200)
  SetPedArmour(PlayerPedId(), 33)
  ClearPedTasks(GetPlayerPed(-1))
  Citizen.Wait(50000)
  AnimpostfxStopAll()
  ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end)

RegisterNetEvent('use:zpjoint')
AddEventHandler('use:zpjoint', function()
  TriggerServerEvent('removezpjoint')
  exports['mythic_progbar']:Progress({
    name = "unique_action_name",
    duration = 5000,
    label = 'Smoking Joint',
    useWhileDead = false,
    canCancel = false,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = false,
    },
  })
  ExecuteCommand('e smoke')
  Citizen.Wait(5000)
  AnimpostfxPlay("ChopVision", 10000001, true)
  ShakeGameplayCam("DRUNK_SHAKE", 1.0)

  SetEntityHealth(GetPlayerPed(-1), 200)
  SetPedArmour(PlayerPedId(), 66)
  ClearPedTasks(GetPlayerPed(-1))
  Citizen.Wait(50000)
  AnimpostfxStopAll()
  ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end)

RegisterNetEvent('use:wpjoint')
AddEventHandler('use:wpjoint', function()
  TriggerServerEvent('removewpjoint')
  exports['mythic_progbar']:Progress({
    name = "unique_action_name",
    duration = 5000,
    label = 'Smoking Joint',
    useWhileDead = false,
    canCancel = false,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = false,
    },
  })
  ExecuteCommand('e smoke')
  Citizen.Wait(5000)
  AnimpostfxPlay("ChopVision", 10000001, true)
  ShakeGameplayCam("DRUNK_SHAKE", 1.0)

  SetEntityHealth(GetPlayerPed(-1), 200)
  SetPedArmour(PlayerPedId(), 100)
  ClearPedTasks(GetPlayerPed(-1))
  Citizen.Wait(50000)
  AnimpostfxStopAll()
  ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end)

RegisterNetEvent('use:kkgummies')
AddEventHandler('use:kkgummies', function()
  TriggerServerEvent('removekkgummies')
  exports['mythic_progbar']:Progress({
    name = "unique_action_name",
    duration = 5000,
    label = 'Eating Edible Gummies',
    useWhileDead = false,
    canCancel = false,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = false,
    },
  })
  ExecuteCommand('e eat')
  Citizen.Wait(5000)
  AnimpostfxPlay("ChopVision", 10000001, true)
  ShakeGameplayCam("DRUNK_SHAKE", 1.0)

  SetPedArmour(PlayerPedId(), 30)
  ClearPedTasks(GetPlayerPed(-1))
  Citizen.Wait(50000)
  AnimpostfxStopAll()
  ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end)

RegisterNetEvent('use:kkbrownie')
AddEventHandler('use:kkbrownie', function()
  TriggerServerEvent('removekkbrownie')
  exports['mythic_progbar']:Progress({
    name = "unique_action_name",
    duration = 5000,
    label = 'Eating Edible Brownie',
    useWhileDead = false,
    canCancel = false,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = false,
    },
  })
  ExecuteCommand('e eat')
  Citizen.Wait(5000)
  AnimpostfxPlay("ChopVision", 10000001, true)
  ShakeGameplayCam("DRUNK_SHAKE", 1.0)

  SetPedArmour(PlayerPedId(), 30)
  ClearPedTasks(GetPlayerPed(-1))
  Citizen.Wait(50000)
  AnimpostfxStopAll()
  ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end)

RegisterNetEvent('use:kkcookie')
AddEventHandler('use:kkcookie', function()
  TriggerServerEvent('removekkcookie')
  exports['mythic_progbar']:Progress({
    name = "unique_action_name",
    duration = 5000,
    label = 'Eating Edible Cookie',
    useWhileDead = false,
    canCancel = false,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = false,
    },
  })
  ExecuteCommand('e eat')
  Citizen.Wait(5000)
  AnimpostfxPlay("ChopVision", 10000001, true)
  ShakeGameplayCam("DRUNK_SHAKE", 1.0)

  SetPedArmour(PlayerPedId(), 30)
  ClearPedTasks(GetPlayerPed(-1))
  Citizen.Wait(50000)
  AnimpostfxStopAll()
  ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end)













































-- Weed Plants -- 

exports['labrp_Eye']:AddBoxZone("WeedPlant", vector3(383.2, -813.4, 28.4), 0.5, 0.5, {
  name="WeedPlant",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant2", vector3(382.2, -813.4, 28.4), 0.5, 0.5, {
  name="WeedPlant2",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant3", vector3(380.4, -813.3, 28.4), 0.5, 0.5, {
  name="WeedPlant3",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant4", vector3(379.2, -813.3, 28.4), 0.5, 0.5, {
  name="WeedPlant4",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant5", vector3(378.2, -813.3, 28.4), 0.5, 0.5, {
  name="WeedPlant5",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant6", vector3(382.8, -811.5, 28.4), 0.5, 0.5, {
  name="WeedPlant6",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant7", vector3(381.8, -811.5, 28.4), 0.5, 0.5, {
  name="WeedPlant7",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant8", vector3(380.6, -811.5, 28.4), 0.5, 0.5, {
  name="WeedPlant8",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant9", vector3(379.4, -811.5, 28.4), 0.5, 0.5, {
  name="WeedPlant9",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

exports['labrp_Eye']:AddBoxZone("WeedPlant10", vector3(378.2, -811.5, 28.4), 0.5, 0.5, {
  name="WeedPlant10",
  heading=0,
  minZ=28.0,
  maxZ=29.0,
  debugPoly=false,
}, {
  options = {

      {
          event = "dispensary:harvest",
          icon = "fas fa-cannabis",
          label = "Cannabis Plant",
      },
   },
    job = {"all"},
  distance = 1.5
})

local blips2 = {
  -- Example {title="", colour=, id=, x=, y=, z=},
 {title="Kronic Kush Dispensary", colour=11, id=140, x = 378.3165, y = -834.3692, z = 29.27991},
}

Citizen.CreateThread(function()

  for _, info in pairs(blips2) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.8)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
end)