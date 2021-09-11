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
    [9] = {id = 9, x = -140.2418, y = -1587.402, z = 36.40149, h = 255.00}, 
    [10] = {id = 10, x = -120.1187, y = -1574.519, z = 33.16626, h = 150.00},
    [11] = {id = 11, x = -216.5011, y = -1648.694, z = 36.62048, h = 175.00},
    [12] = {id = 12, x = -216.4352, y = -1648.694, z = 33.45276, h = 175.00},
    [13] = {id = 13, x = -158.8088, y = -1679.657, z = 35.96338, h = 175.00},
    [14] = {id = 14, x = -147.9565, y = -1687.961, z = 31.8542, h = 150.00},
    [15] = {id = 15, x = -197.4198, y = -1711.886, z = 31.64978, h = 150.00},
    [16] = {id = 16, x = -224.3341, y = -1674.448, z = 33.45276, h = 330.00},
    [17] = {id = 17, x = -1024.484, y = -1139.683, z = 1.741455, h = 20.00},
    [18] = {id = 18, x = -1555.767, y = -279.5341, z = 47.26965, h = 330.00},
    [19] = {id = 19, x = -1536.396, y = -270.4615, z = 47.26965, h = 50.00},
    [20] = {id = 20, x = -1478.268, y = -649.2527, z = 28.58313, h = 230.00},
    [21] = {id = 21, x = -1454.321, y = -655.9385, z = 32.37439, h = 50.00},
    [22] = {id = 22, x = -1478.229, y = -649.134, z = 32.37439, h = 230.00},
    [23] = {id = 23, x = 176.7824, y = 45.19121, z = 86.81616, h = 140.00},
    [24] = {id = 24, x = 279.811, y = 32.30769, z = 87.47327, h = 140.00},
    [25] = {id = 25, x = 254.189, y = 24.67253, z = 87.11938, h = 320.00},
    [26] = {id = 26, x = 221.4198, y = 80.25494, z = 86.91724, h = 320.00}, 
    [27] = {id = 27, x = 970.7077, y = -701.5121, z = 57.48059, h = 320.00},
    [28] = {id = 28, x = 987.7846, y = -525.8242, z = 59.68787, h = 230.00},
    [29] = {id = 29, x = -500.5319, y = -712.6417, z = 32.20581, h = 230.00},
    [30] = {id = 30, x = -783.7055, y = -390.6198, z = 36.31726, h = 140.00},
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