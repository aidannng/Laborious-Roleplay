ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local policedealership = {
    `s_m_y_cop_01`,
    }   
exports["labrp_Eye"]:AddTargetModel(policedealership, {
    options = {
    {
        event = "pdvehicle:menu",
        icon = "fas fa-car", 
        label = "Police Dealership",
    },
    },
    job = {"police"},
    distance = 2.5
})

RegisterNetEvent('pdvehicle:menu')--pd:heli
AddEventHandler('pdvehicle:menu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Police Dealership",
            txt = ""
        },
		{
			id = 2,
			header = "Crown Victoria",
			txt = "$12,500",
			params = {
				event = "pdvehicle:buycar",
				args = {
					id = 2,
                    price = 12500
				}
			}
		},
		{
			id = 3,
			header = "Ford Taurus",
			txt = "$25,000",
			params = {
				event = "pdvehicle:buycar",
				args = {
					id = 3,
                    price = 25000
				}
			}
		},
		{
			id = 4,
			header = "2014 Tahoe",
			txt = "$30,000 (Off-Road)",
			params = {
				event = "pdvehicle:buycar",
				args = {
					id = 4,
                    price = 30000
				}
			}
		},
        {
			id = 5,
			header = "Dodge RAM",
			txt = "$35,000 (Off-Road)",
			params = {
				event = "pdvehicle:buycar",
				args = {
					id = 5,
                    price = 35000
				}
			}
		},
        {
			id = 6,
			header = "BMW Motorcycle",
			txt = "$25,000 (Motor)",
			params = {
				event = "pdvehicle:buycar",
				args = {
					id = 6,
                    price = 25000
				}
			}
		},
        {
			id = 7,
			header = "2018 Charger",
			txt = "$50,000",
			params = {
				event = "pdvehicle:buycar",
				args = {
					id = 7,
                    price = 50000
				}
			}
		}
	})
end)


RegisterNetEvent('pdvehicle:buycar')
AddEventHandler('pdvehicle:buycar', function(data)
    ESX.TriggerServerCallback('labrp_pdvehicles:checkmoney', function(hasEnough)
        if hasEnough then
            print(data.id)
            local id = data.id
            local hash = nil
            if id == 2 then
                hash = GetHashKey("code3cvpi")
            elseif id == 3 then
                hash = GetHashKey("code3fpis")
            elseif id == 4 then
                hash = GetHashKey("code14tahoe")
            elseif id == 5 then
                hash = GetHashKey("code3ram")
            elseif id == 6 then
                hash = GetHashKey("code3bmw")
            elseif id == 7 then
                hash = GetHashKey("code318charg")
            end
            print(hash)
            print(data.price)
                
            if not HasModelLoaded(hash) then
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Citizen.Wait(10)
                end
            end
            local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
            SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            Citizen.Wait(1000)
            local plate = GetVehicleNumberPlateText(vehicle)
            exports["labrp_vehiclelock"]:givePlayerKeys(plate)
            Citizen.Wait(1000)
            local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
            local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
            exports["labrp_vehiclegarage"]:setOwnership(plate, vehicleProps)
        else
            exports['mythic_notify']:SendAlert('error', 'Not Enough Cash!') 
        end
	end, data.price)
end)


