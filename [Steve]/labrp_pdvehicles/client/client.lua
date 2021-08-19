ESX = nil
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if ESX ~= nil then
       
        else
            ESX = nil
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end
    end
end)

local firstnames = {
    [1] = {id = 1, name = 'Sebastian'},
    [2] = {id = 2, name = 'Hugh'},
    [3] = {id = 3, name = 'Geoffrey'},
    [4] = {id = 4, name = 'Isaiah'},
    [5] = {id = 5, name = 'Alejandro'},
    [6] = {id = 6, name = 'Harry'},
    [7] = {id = 7, name = 'Douglas'},
    [8] = {id = 8, name = 'Gordon'},
    [9] = {id = 9, name = 'Jack'},
    [10] = {id = 10, name = 'Owen'},
    [11] = {id = 11, name = 'Tyler'},
    [12] = {id = 12, name = 'Jeremiah'},
    [13] = {id = 13, name = 'Howard'},
    [14] = {id = 14, name = 'Ashton'},
    [15] = {id = 15, name = 'Daniel'},
    [16] = {id = 16, name = 'Graham'},
    [17] = {id = 17, name = 'Richard'},
    [18] = {id = 18, name = 'Norman'},
    [19] = {id = 19, name = 'Timothy'},
    [20] = {id = 20, name = 'Jacob'},
}

local lastnames = {
    [1] = {id = 1, name = 'Michaelson'},
    [2] = {id = 2, name = 'Ogden'},
    [3] = {id = 3, name = 'Reynolds'},
    [4] = {id = 4, name = 'Macey'},
    [5] = {id = 5, name = 'Gimson'},
    [6] = {id = 6, name = 'Finch'},
    [7] = {id = 7, name = 'Albertson'},
    [8] = {id = 8, name = 'Dunce'},
    [9] = {id = 9, name = 'Barnes'},
    [10] = {id = 10, name = 'Gustman'},
    [11] = {id = 11, name = 'Livingston'},
    [12] = {id = 12, name = 'Clapton'},
    [13] = {id = 13, name = 'Bargeman'},
    [14] = {id = 14, name = 'Goodman'},
    [15] = {id = 15, name = 'Benson'},
    [16] = {id = 16, name = 'Shackley'},
    [17] = {id = 17, name = 'Creighton'},
    [18] = {id = 18, name = 'Smith'},
    [19] = {id = 19, name = 'Dyson'},
    [20] = {id = 20, name = 'Ramacey'},
}

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
            TriggerServerEvent('labrp_pdvehicles:takemoney', data.price)
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

exports['labrp_Eye']:AddTargetBone({"platelight"}, {
    options = {
        {
            event = "labrp_pdvehicles:checkvin",
            icon = "fas fa-newspaper",
            label = "Check VIN",
            job = "police",
        },
    },
    distance = 1.0,
})


RegisterNetEvent('labrp_pdvehicles:checkvin')
AddEventHandler('labrp_pdvehicles:checkvin', function(data)
    plate = GetVehicleNumberPlateText(data.entity)
    print(plate)
    ESX.TriggerServerCallback('labrp_pdvehicles:checkvin', function(fullname)
        if fullname == 'unknown' then
            TriggerEvent('chat:addMessage', {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0}</div>',
                args = { "^*^4Name^0 : "..firstnames[math.random(1, #firstnames)].name.." "..lastnames[math.random(1, #lastnames)].name.." | ^4Plate^0 : "..plate}
            });
        else
            TriggerEvent('chat:addMessage', {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0}</div>',
                args = { "^*^4Name^0 : "..fullname.. " | ^4Plate^0 : "..plate}
            });
        end
	end, plate)
end)
