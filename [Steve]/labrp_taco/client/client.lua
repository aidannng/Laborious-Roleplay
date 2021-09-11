ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

local RunStarted = false
local currentDropOff = false

local DropOffs = {
    [1] = {id = 1, x = -160.8923, y = -1638.396, z = 33.01465, h = 345.00},
    [2] = {id = 2, x = -156.1582, y = -1348.404, z = 28.65051, h = 270.00},
    [3] = {id = 3, x = 39.17802, y = -1005.56, z = 28.46521, h = 70.00},
    [4] = {id = 4, x = 3.323077, y = -706.9187, z = 44.96118, h = 200.00},
    [5] = {id = 5, x = -787.2791, y = -911.8945, z = 18.07471, h = 270.00},
    [6] = {id = 6, x = -1160.954, y = -451.8989, z = 34.67175, h = 206.00},
    [7] = {id = 7, x = -510.6725, y = -52.86593, z = 42.10254, h = 340.00},
    [8] = {id = 8, x = 1131.481, y = -454.2725, z = 65.48425, h = 75.00},
}

exports['labrp_Eye']:AddBoxZone("TacoDelivery", vector3(10.15385, -1604.11, 28.36414), 0.75, 0.75, {
	name="TacoDelivery",
	heading=220.0,
	debugPoly=false,
	}, {
		options = {
			{
				event = "labrp_taco:start",
				icon = "fas fa-truck-loading",
				label = "Deliver Food",
                canInteract = function(entity)
                    if not RunStarted then 
                        return true
                    end
                end, 
			},
            {
				event = "labrp_taco:cancel",
				icon = "fas fa-ban",
				label = "Cancel Delivery",
                canInteract = function(entity)
                    if RunStarted then 
                        return true
                    end
                end, 
			},
		},
	distance = 2.5
})


AddEventHandler('labrp_taco:start', function()
    RunStarted = true
    DropOffLocation = DropOffs[math.random(1, #DropOffs)]


    exports['mythic_notify']:SendAlert('inform', "Delivery GPS Received!")
    deliveryBlip = AddBlipForCoord(DropOffLocation.x, DropOffLocation.y, DropOffLocation.z)

    SetBlipScale(deliveryBlip, 0.8)
    SetBlipColour(deliveryBlip, 5)
    SetBlipSprite(deliveryBlip, 514)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Delivery Location')
    EndTextCommandSetBlipName(deliveryBlip)

    LoadModel(`a_m_m_afriamer_01`)

    ped = CreatePed(4, `a_m_m_afriamer_01`, DropOffLocation.x, DropOffLocation.y, DropOffLocation.z, 3374176, true, true)
    SetEntityHeading(ped, DropOffLocation.h)
    FreezeEntityPosition(ped, true)
    currentDropOff = true
end)

AddEventHandler('labrp_taco:cancel', function()
    RunStarted = false
    DeleteEntity(ped)
    RemoveBlip(deliveryBlip)
    exports['mythic_notify']:SendAlert('error', "You've cancelled this delivery!")
end)

AddEventHandler('labrp_taco:deliver', function()
    RunStarted = false
    currentDropOff = false
    FreezeEntityPosition(ped, false)
    SetEntityAsMissionEntity(ped)
    animationgive()
    Citizen.Wait(3000)
    DeleteEntity(ped)
    RemoveBlip(deliveryBlip)
    exports['mythic_notify']:SendAlert('inform', "Successfully Delivered Order!")
    TriggerServerEvent('labrp_taco:givereward')
end)

local TacoCustomer = {
    `a_m_m_afriamer_01`,
}

exports['labrp_Eye']:AddTargetModel(TacoCustomer, {
	options = {
		{
			event = "labrp_taco:deliver",
			icon = "fas fa-hotdog",
			label = "Deliver Food",
            canInteract = function(entity)
                hasChecked = false
                if currentDropOff and not hasChecked then
                    hasChecked = true
                    return true
                end
            end
		},			
	},
	job = {"all"},
	distance = 2.5
})

function loadAnimDict2(dict)
    while ( not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function animationgive()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict2("mp_safehouselost@") 
    TaskPlayAnim(PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end


local blips2 = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	 {title="Taco Shop", colour=5, id=440, x = 10.81319, y = -1603.477, z = 29.36414},
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