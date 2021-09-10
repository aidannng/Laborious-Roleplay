local garages = {}
local impounds = {}

local currentGarage = nil
local garageCode = nil
local garageType = nil
local currentImpound = nil
local impoundType = nil

Citizen.CreateThread(function()
    for k, v in pairs(Config.Garages) do

        GarageBlips(vector3(v.PedCoords.x, v.PedCoords.y, v.PedCoords.z), firstToUpper(v.GarageType))

        garages[k] = BoxZone:Create(
            vector3(v.Zone.x, v.Zone.y, v.Zone.z),
            v.Zone.l, v.Zone.w, {
                name = v.Zone.name,
                heading = v.Zone.h,
                debugPoly = false,
                minZ = v.Zone.minZ,
                maxZ = v.Zone.maxZ
            }
        )

        garages[k].type = v.GarageType
        garages[k].display = v.Display

        garages[k]:onPlayerInOut(function(isPointInside, point)
            local model = Config.GaragePed
            if isPointInside then


                ESX.Streaming.RequestModel(model)

                ped = CreatePed(0, model, v.PedCoords.x, v.PedCoords.y, v.PedCoords.z, v.PedCoords.h, false, true)
                SetEntityAlpha(ped, 0, false)
                Wait(50)
                SetEntityAlpha(ped, 255, false)

                SetPedFleeAttributes(ped, 2)
                SetBlockingOfNonTemporaryEvents(ped, true)
                SetPedCanRagdollFromPlayerImpact(ped, false)
                SetPedDiesWhenInjured(ped, false)
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)
                SetPedCanPlayAmbientAnims(ped, false)
            else
                DeletePed(ped)
            end
        end)
    end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Impounds) do

        ImpoundBlips(vector3(v.PedCoords.x, v.PedCoords.y, v.PedCoords.z), firstToUpper(v.ImpoundType))

        impounds[k] = BoxZone:Create(
            vector3(v.Zone.x, v.Zone.y, v.Zone.z),
            v.Zone.l, v.Zone.w, {
                name = v.Zone.name,
                heading = v.Zone.h,
                debugPoly = false,
                minZ = v.Zone.minZ,
                maxZ = v.Zone.maxZ,
                display = v.Display
            }
        )

        impounds[k].type = v.ImpoundType

        impounds[k]:onPlayerInOut(function(isPointInside, point)
            local model = Config.ImpoundPed
            if isPointInside then
        
                ESX.Streaming.RequestModel(model)

                ped = CreatePed(0, model, v.PedCoords.x, v.PedCoords.y, v.PedCoords.z, v.PedCoords.h, false, true)
                SetEntityAlpha(ped, 0, false)
                Wait(50)
                SetEntityAlpha(ped, 255, false)

                SetPedFleeAttributes(ped, 2)
                SetBlockingOfNonTemporaryEvents(ped, true)
                SetPedCanRagdollFromPlayerImpact(ped, false)
                SetPedDiesWhenInjured(ped, false)
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)
                SetPedCanPlayAmbientAnims(ped, false)
            else
                DeletePed(ped)
            end
        end)
    end
end)

exports['labrp_Eye']:AddTargetModel({Config.ImpoundPed}, {
    options = {
        {
            event = 'luke_vehiclegarage:GetImpoundedMenu',
            icon = "fas fa-key",
            label = "Access Impound",
            canInteract = function(entity)
                hasChecked = false
                if IsInsideImpound(entity) and not hasChecked then
                    hasChecked = true
                    return true
                end
            end
        },
    },
    distance = 2.5,
})

exports['labrp_Eye']:AddTargetModel({Config.GaragePed}, {
    options = {
        {
            event = "luke_vehiclegarage:OwnedVehicleMenu",
            icon = "fas fa-warehouse",
            label = "Access Garage",
            canInteract = function(entity)
                hasChecked = false
                if IsInsideGarage(entity) and not hasChecked then
                    hasChecked = true
                    return true
                end
            end
        },
    },
    distance = 2.5,
})


exports['labrp_Eye']:Vehicle({
	options = {
		{
			event = 'luke_vehiclegarage:StoreVehicle',
			label = 'Store Vehicle',
			icon = 'fas fa-parking',
            canInteract = function(entity)
                hasChecked = false
                if IsInsideGarage(entity) and not hasChecked then
                    hasChecked = true
                    return true
                end
            end
		},
	},
	distance = 2.5
})


RegisterNetEvent('luke_vehiclegarage:OwnedVehicleMenu')
AddEventHandler('luke_vehiclegarage:OwnedVehicleMenu', function(target)
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Car Garage",
            txt = ""
        },
        {
            id = 2,
            header = "Personal Garage",
            txt = "List of Personal Vehicles",
            params = {
                event = "luke_vehiclegarage:GetOwnedVehicles",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Shared Vehicles",
            txt = "List of Shared Vehicles",
            params = {
                event = "luke_vehiclegarage:GetJobOwnedVehicles",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
    })
end)

RegisterNetEvent('luke_vehiclegarage:GetImpoundedMenu')
AddEventHandler('luke_vehiclegarage:GetImpoundedMenu', function(target)
    local menu = {}
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Impound",
            txt = ""
        },
        {
            id = 2,
            header = "Personal Impound",
            txt = "List of Personal Vehicles",
            params = {
                event = "luke_vehiclegarage:GetImpoundedVehicles",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Shared Impound",
            txt = "List of Shared Vehicles",
            params = {
                event = "luke_vehiclegarage:GetJobImpoundedVehicles",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Seized Vehicles",
            txt = "List of Seized Vehicles",
            params = {
                event = "luke_vehiclegarage:GetSeizedVehicles",
            }
        },
    })
    if ESX.PlayerData.job.name == "police" then
        table.insert(menu, {
            id = 5,
            header = "Police Seizures",
            txt = 'Manage all seized vehicles',
            params = {
                event = 'luke_vehiclegarage:GetSeizedPoliceVehicles'
            }
        })
        TriggerEvent('nh-context:sendMenu', menu)
    else
        print('you aint police')
    end
end)

RegisterNetEvent('luke_vehiclegarage:StoreBothVehicle')
AddEventHandler('luke_vehiclegarage:StoreBothVehicle', function(target)
    TriggerEvent('luke_vehiclegarage:StoreVehicle', target)
end)

RegisterNetEvent('luke_vehiclegarage:GetSeizedPoliceVehicles')
AddEventHandler('luke_vehiclegarage:GetSeizedPoliceVehicles', function()
    ESX.TriggerServerCallback('luke_vehiclegarage:GetPoliceSeized', function(vehicles, job)
        local menu = {}


        TriggerEvent('nh-context:sendMenu', {
            {
                id = 0,
                header = 'Seized Vehicles',
                txt = ''
            },
        })

        if vehicles ~= nil then
            for k, v in pairs(vehicles) do
                if v.seized >= 0 then
                    local vehicle = v.vehicle.model
                    local vehMake = GetLabelText(GetMakeNameFromVehicleModel(vehicle))
                    local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(vehicle))
                    local vehTitle = vehMake .. ' ' .. vehicleName

                    table.insert(menu, {
                        id = k,
                        header = vehTitle,
                        txt = 'Plate: ' .. v.plate .. ' <br> Days Left : ' .. v.seized//24,
                        params = {
                            event = 'luke_vehiclegarage:VehicleSeizedInfo',
                            args = {name = vehTitle, plate = v.plate, model = vehicle, vehicle = v.vehicle, seized = v.seized}
                        }
                    })
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'No vehicles are seized',
                        txt = ''
                    }
                })
            end
        else
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = 'No vehicles are seized',
                    txt = ''
                }
            })
        end
    end)
end)

RegisterNetEvent('luke_vehiclegarage:GetSeizedVehicles')
AddEventHandler('luke_vehiclegarage:GetSeizedVehicles', function()
    ESX.TriggerServerCallback('luke_vehiclegarage:GetSeized', function(vehicles, job)
        local menu = {}


        TriggerEvent('nh-context:sendMenu', {
            {
                id = 0,
                header = 'Seized Vehicles',
                txt = ''
            },
        })

        if vehicles ~= nil then
            for k, v in pairs(vehicles) do
                if v.seized >= 0 then
                    local vehicle = v.vehicle.model
                    local vehMake = GetLabelText(GetMakeNameFromVehicleModel(vehicle))
                    local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(vehicle))
                    local vehTitle = vehMake .. ' ' .. vehicleName

                    table.insert(menu, {
                        id = k,
                        header = vehTitle,
                        txt = 'Plate: ' .. v.plate .. ' <br> Days Left : ' .. v.seized//24,
                        params = {
                            event = '',
                        }
                    })
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'No vehicles are seized',
                        txt = ''
                    }
                })
            end
        else
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = 'No vehicles are seized',
                    txt = ''
                }
            })
        end
    end)
end)

RegisterNetEvent('luke_vehiclegarage:GetImpoundedVehicles')
AddEventHandler('luke_vehiclegarage:GetImpoundedVehicles', function()
    ESX.TriggerServerCallback('luke_vehiclegarage:GetImpound', function(vehicles)
        local menu = {}

        TriggerEvent('nh-context:sendMenu', {
            {
                id = 0,
                header = firstToUpper(impoundType) .. ' Impound',
                txt = ''
            },
        })

        if vehicles ~= nil then
            for k, v in pairs(vehicles) do
                if not DoesVehicleExist(v.plate) then
                    local vehModel = v.vehicle.model
                    local vehMake = GetLabelText(GetMakeNameFromVehicleModel(vehModel))
                    local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
                    local vehTitle = vehMake .. ' ' .. vehName
                    
                    local impoundPrice = Config.ImpoundPrices['' .. GetVehicleClassFromName(vehModel)]

                    table.insert(menu, {
                        id = k,
                        header = vehTitle,
                        txt = 'Plate: ' .. v.plate,
                        params = {
                            event = 'luke_vehiclegarage:ImpoundVehicleMenu',
                            args = {name = vehTitle, plate = v.plate, model = vehModel, vehicle = v.vehicle, health = v.health, price = impoundPrice}
                        }
                    })
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'No vehicles in impound',
                        txt = ''
                    }
                })
            end
        else
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = 'No vehicles in impound',
                    txt = ''
                }
            })
        end
    end, impoundType)
end)

RegisterNetEvent('luke_vehiclegarage:GetJobImpoundedVehicles')
AddEventHandler('luke_vehiclegarage:GetJobImpoundedVehicles', function()
    ESX.TriggerServerCallback('luke_vehiclegarage:GetJobImpound', function(vehicles)
        local menu = {}

        TriggerEvent('nh-context:sendMenu', {
            {
                id = 0,
                header = firstToUpper(impoundType) .. ' Impound',
                txt = ''
            },
        })

        if vehicles ~= nil then
            for k, v in pairs(vehicles) do
                if not DoesVehicleExist(v.plate) then
                    local vehModel = v.vehicle.model
                    local vehMake = GetLabelText(GetMakeNameFromVehicleModel(vehModel))
                    local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
                    local vehTitle = vehMake .. ' ' .. vehName
                    
                    local impoundPrice = Config.ImpoundPrices['' .. GetVehicleClassFromName(vehModel)]

                    table.insert(menu, {
                        id = k,
                        header = vehTitle,
                        txt = 'Plate: ' .. v.plate,
                        params = {
                            event = 'luke_vehiclegarage:ImpoundVehicleMenu',
                            args = {name = vehTitle, plate = v.plate, model = vehModel, vehicle = v.vehicle, health = v.health, price = impoundPrice}
                        }
                    })
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'No vehicles in impound',
                        txt = ''
                    }
                })
            end
        else
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = 'No vehicles in impound',
                    txt = ''
                }
            })
        end
    end, impoundType)
end)

RegisterNetEvent('luke_vehiclegarage:GetOwnedVehicles')
AddEventHandler('luke_vehiclegarage:GetOwnedVehicles', function()
    ESX.TriggerServerCallback('luke_vehiclegarage:GetVehicles', function(vehicles)
        local menu = {}
        local type = nil

        TriggerEvent('nh-context:sendMenu', {
            {
                id = 0,
                header = firstToUpper(garageType) .. ' Garage',
                txt = ''
            },
        })

        if vehicles ~= nil then
            for k, v in pairs(vehicles) do
                local vehModel = v.vehicle.model
                local vehMake = GetLabelText(GetMakeNameFromVehicleModel(vehModel))
                local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
                local vehTitle = vehMake .. ' ' .. vehName
                local vehStatus = ''
                if v.stored then
                    vehStatus = 'In Garage'
                    table.insert(menu, {
                        id = k,
                        header = vehTitle,
                        txt = 'Plate: ' .. v.plate .. ' <br> Status: ' .. vehStatus,
                        params = {
                            event = 'luke_vehiclegarage:VehicleMenu',
                            args = {name = vehTitle, plate = v.plate, model = vehModel, vehicle = v.vehicle, health = v.health}
                        }
                    })
                else
                    vehStatus = 'Not In Garage'
                    table.insert(menu, {
                        id = k,
                        header = vehTitle,
                        txt = 'Plate: ' .. v.plate .. ' <br> Status: ' .. vehStatus,
                    })
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'No vehicles in garage',
                        txt = ''
                    }
                })
            end
        else
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = 'No vehicles in garage',
                    txt = '',
                }
            })
        end
    end, garageType, currentGarage)
end)

RegisterNetEvent('luke_vehiclegarage:GetJobOwnedVehicles')
AddEventHandler('luke_vehiclegarage:GetJobOwnedVehicles', function()
    ESX.TriggerServerCallback('luke_vehiclegarage:GetJobVehicles', function(vehicles)
        local menu = {}
        local type = nil

        TriggerEvent('nh-context:sendMenu', {
            {
                id = 0,
                header = firstToUpper(garageType) .. ' Garage',
                txt = ''
            },
        })

        if vehicles ~= nil then
            for k, v in pairs(vehicles) do
                local vehModel = v.vehicle.model
                local vehMake = GetLabelText(GetMakeNameFromVehicleModel(vehModel))
                local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
                local vehTitle = vehMake .. ' ' .. vehName
                local vehStatus = ''
                if v.stored then
                    vehStatus = 'In Garage'
                    table.insert(menu, {
                        id = k,
                        header = vehTitle,
                        txt = 'Plate: ' .. v.plate .. ' <br> Status: ' .. vehStatus,
                        params = {
                            event = 'luke_vehiclegarage:VehicleMenu',
                            args = {name = vehTitle, plate = v.plate, model = vehModel, vehicle = v.vehicle, health = v.health}
                        }
                    })
                else
                    vehStatus = 'Not In Garage'
                    table.insert(menu, {
                        id = k,
                        header = vehTitle,
                        txt = 'Plate: ' .. v.plate .. ' <br> Status: ' .. vehStatus,
                    })
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'No vehicles in garage',
                        txt = ''
                    }
                })
            end
        else
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = 'No vehicles in garage',
                    txt = '',
                }
            })
        end
    end, garageType, currentGarage)
end)

RegisterNetEvent('luke_vehiclegarage:ImpoundVehicleMenu')
AddEventHandler('luke_vehiclegarage:ImpoundVehicleMenu', function(data)
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 0,
            header = '< Go Back',
            txt = '',
            params = {
                event = 'luke_vehiclegarage:GetImpoundedVehicles',
            }
        },
        {
            id = 1,
            header = "Take Vehicle Out Of Impound",
            txt = 'Car: ' .. data.name .. ' <br> Plate: ' .. data.plate .. ' <br> Price: $' .. data.price,
            params = {
                event = 'luke_vehiclegarage:SpawnVehicle',
                args = {
                    vehicle = data.vehicle,
                    health = data.health,
                    price = data.price,
                    type = 'impound'
                }
            }
        }
    })
end)

RegisterNetEvent('luke_vehiclegarage:VehicleSeizedInfo')
AddEventHandler('luke_vehiclegarage:VehicleSeizedInfo', function(data)
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 0,
            header = '< Go Back',
            txt = '',
            params = {
                event = '',
            }
        },
        {
            id = 1,
            header = "Release Vehicle",
            txt = 'Car: ' .. data.name .. ' <br> Plate: ' .. data.plate.. ' <br> Days Left : ' .. data.seized//24,
            params = {
                event = 'luke_vehiclegarage:FreeFromSeize',
                args = {
                    plate = data.plate,
                    time = data.seized
                }
            }
        }
    })
end)

AddEventHandler('luke_vehiclegarage:FreeFromSeize', function(plate)
    timeleft = plate.time
    if timeleft == 0 then
        TriggerServerEvent("luke_vehiclegarage:SetFreeSeize", plate.plate)
        exports['mythic_notify']:SendAlert('inform', "Vehicle Released!")
    else
        exports['mythic_notify']:SendAlert('error', "You can't release this vehicle yet!")
    end
end)

local Status = ''

RegisterNetEvent('luke_vehiclegarage:VehicleMenu')
AddEventHandler('luke_vehiclegarage:VehicleMenu', function(data)
    local Carmenu = {}

    table.insert(Carmenu, {
        id = 0,
        header = '< Go Back',
        txt = '',
        params = {
            event = 'luke_vehiclegarage:GetOwnedVehicles'
        }
    })
    table.insert(Carmenu, {
        id = 1,
        header = 'Take Out Vehicle',
        txt = 'Car: ' .. data.name .. ' | Plate: ' .. data.plate,
        params = {
            event = 'luke_vehiclegarage:SpawnVehicle',
            args = {
                vehicle = data.vehicle,
                health = data.health,
                plate = data.plate,
                type = 'garage'
            }
        }
    })
    --[[table.insert(Carmenu, {
        id = 2,
        header = 'Transfer Vehicle',
        txt = 'Transfer Vehicle to Person',
        params = {
            event = 'luke_vehiclegarage:TransferVehicle',
            args = {
                plate = data.plate,
            }
        }
    })]]
    TriggerEvent('nh-context:sendMenu', Carmenu)
end)

RegisterNetEvent('luke_vehiclegarage:TransferVehicle')
AddEventHandler('luke_vehiclegarage:TransferVehicle', function(plate)
    local keyboard = exports["nh-keyboard"]:KeyboardInput({
        header = "Transfer Vehicle", 
        rows = {
            {
                id = 0, 
                txt = "Player ID"
            }
        }
    })

end)

RegisterNetEvent('luke_vehiclegarage:SwitchOwnerShip')
AddEventHandler('luke_vehiclegarage:SwitchOwnerShip', function(plate)
    TriggerServerEvent('luke_vehiclegarage:SwitchOwnerShip', plate)
    TriggerEvent('luke_vehiclegarage:GetOwnedVehicles')
end)



RegisterNetEvent('luke_vehiclegarage:SpawnVehicle')
AddEventHandler('luke_vehiclegarage:SpawnVehicle', function(data)
    local spawn = nil
    local model = data.vehicle.model

    if data.type == 'garage' then
        spawn = Config.Garages[garageCode].Spawns
    else
        spawn = Config.Impounds[currentImpound].Spawns
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    SetModelAsNoLongerNeeded(model)

    for i = 1, #spawn do
        if ESX.Game.IsSpawnPointClear(vector3(spawn[i].x, spawn[i].y, spawn[i].z), 1.0) then
            --[[ ESX.TriggerServerCallback('luke_vehiclegarage:SpawnVehicle', function(veh)
                vehicle = NetToVeh(veh) ]]

            local spawnedVehicle = CreateVehicle(model, vector3(spawn[i].x, spawn[i].y, spawn[i].z), spawn[i].h, 1, 1)
            ESX.Game.SetVehicleProperties(spawnedVehicle, data.vehicle)
            SetVehicleInteriorColor(spawnedVehicle, tonumber(data.vehicle.modTrimA))
            SetVehicleLivery(spawnedVehicle, tonumber(data.vehicle.modLivery))
            TriggerServerEvent('luke_vehiclegarage:ChangeStored', GetVehicleNumberPlateText(spawnedVehicle), false, currentGarage)

            if data.type == 'impound' then
                TriggerServerEvent('luke_vehiclegarage:PayImpound', data.price)
            end

            DoVehicleDamage(spawnedVehicle, data.health)

            local spawnedplate = GetVehicleNumberPlateText(spawnedVehicle)
            exports["labrp_vehiclelock"]:givePlayerKeys(spawnedplate)

            --[[ end, data.vehicle.model, vector3(spawn[i].x, spawn[i].y, spawn[i].z-1), spawn[i].h) ]]
            break
        end
        if i == #spawn then
            exports['mythic_notify']:SendAlert('error', 'There are no available parking spots') 
        end
    end
end)

RegisterNetEvent('luke_vehiclegarage:StoreVehicle')
AddEventHandler('luke_vehiclegarage:StoreVehicle', function(target)
    local health = {}

    local vehicle = target.entity
    local vehPlate = GetVehicleNumberPlateText(vehicle)
    
    health.body = ESX.Math.Round(GetVehicleBodyHealth(vehicle), 2)
    health.engine = ESX.Math.Round(GetVehicleEngineHealth(vehicle), 2)

    ESX.TriggerServerCallback('luke_vehiclegarage:CheckOwnership', function(doesOwn)
        if doesOwn then
            local vehProps = ESX.Game.GetVehicleProperties(vehicle)
            vehProps.modTrimA = GetVehicleInteriorColor(vehicle)
            vehProps.modLivery = GetVehicleLivery(vehicle)

            ESX.Game.DeleteVehicle(vehicle)

            TriggerServerEvent('luke_vehiclegarage:ChangeStored', vehPlate, true, currentGarage)

            TriggerServerEvent('luke_vehiclegarage:SaveVehicle', vehProps, health, vehPlate)
        else
            exports['mythic_notify']:SendAlert('error', 'You do not own this vehicle.')
        end
    end, vehPlate)

end)

RegisterNetEvent('luke_vehiclegarage:StoreJobVehicle')
AddEventHandler('luke_vehiclegarage:StoreJobVehicle', function(target)
    local health = {}

    local vehicle = target.entity
    local vehPlate = GetVehicleNumberPlateText(vehicle)
    
    health.body = ESX.Math.Round(GetVehicleBodyHealth(vehicle), 2)
    health.engine = ESX.Math.Round(GetVehicleEngineHealth(vehicle), 2)

    ESX.TriggerServerCallback('luke_vehiclegarage:CheckJobOwnership', function(doesOwn)
        if doesOwn then
            local vehProps = ESX.Game.GetVehicleProperties(vehicle)

            ESX.Game.DeleteVehicle(vehicle)

            TriggerServerEvent('luke_vehiclegarage:ChangeStored', vehPlate, true, currentGarage)

            TriggerServerEvent('luke_vehiclegarage:SaveVehicle', vehProps, health, vehPlate)
        else
            exports['mythic_notify']:SendAlert('error', 'You do not own this vehicle.')
        end
    end, vehPlate)

end)

local tires = {0, 1, 4, 5}
function DoVehicleDamage(vehicle, health)
    if health ~= nil then
        Citizen.Wait(1500)
        health.engine = ESX.Math.Round(health.engine, 2)
        health.body = ESX.Math.Round(health.body, 2)

        -- Making the vehicle still drivable if it's completely totaled
        if health.engine < 200.0 then
            health.engine = 200.0
        end
    
        if health.body < 150.0 then
            health.body = 150.0
        end
    
        if health.body < 950.0 then
            for i = 0, 7 do
                SmashVehicleWindow(vehicle, i)
            end
        end
    
        if health.body < 920.0 then
            math.randomseed(GetGameTimer())
            local num = math.random(1, 4)
            for i = 0, 5, num do
            end
        end

        if health.body < 825.0 then
            math.randomseed(GetGameTimer())
            local randomTire = tires[math.random(#tires)]
        end

        SetVehicleBodyHealth(vehicle, health.body)
        SetVehicleEngineHealth(vehicle, health.engine)
    else
        return
    end
end

function DoesVehicleExist(playerPlate)
    local vehicles = ESX.Game.GetVehicles()
    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        if DoesEntityExist(vehicle) then
            if ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)) == ESX.Math.Trim(playerPlate) then
                return true
            end
        end
    end
end

function IsInsideImpound(entity)
    local entityCoords = GetEntityCoords(entity)
    for k, v in pairs(impounds) do
        if impounds[k]:isPointInside(entityCoords) then
            impoundType = v.type
            currentImpound = k
            return true 
        end
        if k == #impounds then
            return false
        end
    end
end

function IsInsideGarage(entity)
    local entityCoords = GetEntityCoords(entity)
    for k, v in pairs(garages) do
        if garages[k]:isPointInside(entityCoords) then
            garageType = v.type
            currentGarage = v.display
            garageCode = k
            return true
        end
        if k == #garages then
            return false
        end
    end
end

function ImpoundBlips(coords, type)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, 285)
    SetBlipScale(blip, 0.8)

    if type == 'Car' then
        SetBlipColour(blip, Config.BlipColors.Car)
    elseif type == 'Boat' then
        SetBlipColour(blip, Config.BlipColors.Boat)
    elseif type == 'Aircraft' then
        SetBlipColour(blip, Config.BlipColors.Aircraft)
    end

    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(type .. ' Impound Lot')
    EndTextCommandSetBlipName(blip)
end

function GarageBlips(coords, type)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, 357)
    SetBlipScale(blip, 0.8)

    if type == 'Car' then
        SetBlipColour(blip, Config.BlipColors.Car)
    elseif type == 'Boat' then
        SetBlipColour(blip, Config.BlipColors.Boat)
    elseif type == 'Aircraft' then
        SetBlipColour(blip, Config.BlipColors.Aircraft)
    end

    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(type .. ' Garage')
    EndTextCommandSetBlipName(blip)
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end


function setOwnership(plate, vehicle)
    TriggerServerEvent('luke_vehiclegarage:SetOwner', plate, vehicle)
end





RegisterCommand('ownvehicle', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicleBuy = GetVehiclePedIsIn(PlayerPedId(), false)
        local plate = GetVehicleNumberPlateText(vehicleBuy)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
        local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
        print(plate)
        print(vehicleBuy)
        print(vehicleProps)
        print(model)
        TriggerServerEvent('luke_vehiclegarage:SetOwner', plate, vehicleProps)
        exports["labrp_vehiclelock"]:givePlayerKeys(plate)
    else
        exports['mythic_notify']:SendAlert('error', "You're not in a vehicle")
    end
end, false)

--[[RegisterCommand('getkeys', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicleBuy = GetVehiclePedIsIn(PlayerPedId(), false)
        local plate = GetVehicleNumberPlateText(vehicleBuy)
        exports["labrp_vehiclelock"]:givePlayerKeys(plate)
    else
        exports['mythic_notify']:SendAlert('error', "You're not in a vehicle")
    end
end, false)]]