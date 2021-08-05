local Config, Players, Types, Entities, Models, Zones, Bones, M = load(LoadResourceFile(GetCurrentResourceName(), 'config.lua'))()
local playerPed, hasFocus, success, sendData = PlayerPedId(), false, false

if not Config.Standalone then
	ESX = exports['es_extended']:getSharedObject()
	
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(xPlayer)
		ESX.PlayerData = xPlayer
	end)

	AddEventHandler('esx:setPlayerData', function(key, val, last)
		if GetInvokingResource() == 'es_extended' then
			ESX.PlayerData[key] = val
			if key == 'ped' then playerPed = ESX.PlayerData.ped end
		end
	end)
end

local RaycastCamera = function(flag)
	local cam = GetGameplayCamCoord()
	local direction = GetGameplayCamRot()
	direction = vec2(math.rad(direction.x), math.rad(direction.z))
	local num = math.abs(math.cos(direction.x))
	direction = vec3((-math.sin(direction.y) * num), (math.cos(direction.y) * num), math.sin(direction.x))
	local destination = vec3(cam.x + direction.x * 30, cam.y + direction.y * 30, cam.z + direction.z * 30)
	local rayHandle = StartShapeTestLosProbe(cam, destination, flag or -1, playerPed or PlayerPedId(), 0)
	while true do
		Wait(5)
		local result, _, endCoords, _, materialHash, entityHit = GetShapeTestResultIncludingMaterial(rayHandle)
		if result ~= 1 then
			local entityType
			if entityHit then entityType = GetEntityType(entityHit) end
			return flag, endCoords, entityHit, entityType or 0
		end
	end
end
exports("raycast", RaycastCamera)

local DisableNUI = function()
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	hasFocus = false
end 

local EnableNUI = function()
	if targetActive and not hasFocus then 
		SetCursorLocation(0.5, 0.5)
		SetNuiFocus(true, true)
		SetNuiFocusKeepInput(true)
		hasFocus = true
	end
end

local CheckEntity = function(hit, data, entity, distance)
	local send_options = {}
	local send_distance = {}
	for o, data in pairs(data) do
		if M.CheckOptions(data, entity, distance) then
			local slot = #send_options + 1 
			send_options[slot] = data
			send_options[slot].entity = entity
			send_distance[data.distance] = true
		else send_distance[data.distance] = false end
	end
	sendData = send_options
	if next(send_options) then
		success = true
		SendNUIMessage({response = "validTarget", data = M.CloneTable(sendData)})
		while targetActive do
			local playerCoords = GetEntityCoords(playerPed)
			local _, coords, entity2 = RaycastCamera(hit)
			local distance = #(playerCoords - coords)
			if entity ~= entity2 then 
				if hasFocus then DisableNUI() end
				break
			elseif not hasFocus and IsDisabledControlPressed(0, 24) then
				EnableNUI()
			else
				for k, v in pairs(send_distance) do
					if (v == false and distance < k) or v == true and distance > k then
						return CheckEntity(hit, data, entity, distance)
					end
				end
			end
			Wait(5)
		end
		success = false
		SendNUIMessage({response = "leftTarget"})
	end
end

local CheckBones = function(coords, entity, min, max, bonelist)
	local closestBone, closestDistance, closestPos, closestBoneName = -1, 20
	for k, v in pairs(bonelist) do
		local coords = coords
		if Bones[v] then
			local boneId = GetEntityBoneIndexByName(entity, v)
			local bonePos = GetWorldPositionOfEntityBone(entity, boneId)
			local distance = #(coords - bonePos)
			if closestBone == -1 or distance < closestDistance then
				closestBone, closestDistance, closestPos, closestBoneName = boneId, distance, bonePos, v
			end
		end
	end
	if closestBone ~= -1 then return closestBone, closestPos, closestBoneName
	else return false end
end

local curFlag = 30
local switch = function()
	if curFlag == 30 then curFlag = -1 else curFlag = 30 end
	return curFlag
end

function EnableTarget()
	if success or not IsControlEnabled(0, 24) then return end
	if not targetActive then 
		targetActive = true
		SendNUIMessage({response = "openTarget"})
		
		CreateThread(function()
			repeat
				if hasFocus then
					DisableControlAction(0, 1, true)
					DisableControlAction(0, 2, true)
				end
				DisablePlayerFiring(PlayerId(), true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 37, true)
				Wait(5)
			until targetActive == false
		end)
		playerPed = PlayerPedId()

		while targetActive do
			local sleep = 10
			local plyCoords = GetEntityCoords(playerPed)
			local hit, coords, entity, entityType = RaycastCamera(switch())
			if entityType > 0 then

				-- Owned entity targets
				if NetworkGetEntityIsNetworked(entity) then 
					local data = Entities[NetworkGetNetworkIdFromEntity(entity)]
					if data then
						CheckEntity(hit, data, entity, #(plyCoords - coords))
					end
				end
				

				-- Player targets
				if entityType == 1 and IsPedAPlayer(entity) then
					CheckEntity(hit, Players, entity, #(plyCoords - coords))

				-- Vehicle bones
				elseif entityType == 2 and #(plyCoords - coords) <= 1.1 then
					local min, max = GetModelDimensions(GetEntityModel(entity))
					local closestBone, closestPos, closestBoneName = CheckBones(coords, entity, min, max, Config.VehicleBones)
					local data = Bones[closestBoneName]
					if closestBone and #(coords - closestPos) <= data.distance then
						local send_options = {}
						for o, data in pairs(data.options) do
							if M.CheckOptions(data, entity) then 
								local slot = #send_options + 1 
								send_options[slot] = data
								send_options[slot].entity = entity
							end
						end
						sendData = send_options
						if next(send_options) then
							success = true
							SendNUIMessage({response = "validTarget", data = M.CloneTable(sendData)})
							while targetActive do
								local playerCoords = GetEntityCoords(playerPed)
								local _, coords, entity2 = RaycastCamera(hit)
								if hit and entity == entity2 then
									local closestBone2, closestPos2, closestBoneName2 = CheckBones(coords, entity, min, max, Config.VehicleBones)
								
									if closestBone ~= closestBone2 or #(coords - closestPos2) > data.distance or #(playerCoords - coords) > 1.1 then
										if hasFocus then DisableNUI() end
										break
									elseif not hasFocus and IsDisabledControlPressed(0, 24) then EnableNUI() end
								else
									if hasFocus then DisableNUI() end
									break
								end
								Wait(5)
							end
						end
					end

				-- Entity targets
				else
					local data = Models[GetEntityModel(entity)]
					if data then CheckEntity(hit, data, entity, #(plyCoords - coords)) end
				end

				-- Generic targets
				if not success then
					local data = Types[entityType]
					if data then CheckEntity(hit, data, entity, #(plyCoords - coords)) end
				end	
			else sleep = sleep + 10 end
			if not success then
				-- Zone targets
				for _,zone in pairs(Zones) do
					local distance = #(plyCoords - zone.center)
					if zone:isPointInside(coords) and distance <= zone.targetoptions.distance then
						local send_options = {}
						for o, data in pairs(zone.targetoptions.options) do
							if M.CheckOptions(data, entity, distance) then
								local slot = #send_options + 1 
								send_options[slot] = data
								send_options[slot].entity = entity
							end
						end
						sendData = send_options
						if next(send_options) then
							success = true
							SendNUIMessage({response = "validTarget", data = M.CloneTable(sendData)})
							while targetActive do
								local playerCoords = GetEntityCoords(playerPed)
								local _, coords, entity2 = RaycastCamera(hit)
								if not zone:isPointInside(coords) or #(playerCoords - zone.center) > zone.targetoptions.distance then 
									if hasFocus then DisableNUI() end
									break
								elseif not hasFocus and IsDisabledControlPressed(0, 24) then
									EnableNUI()
								end
							end
							success = false
							SendNUIMessage({response = "leftTarget"})
						else
							repeat
								Wait(50)
								local playerCoords = GetEntityCoords(playerPed)
								local _, coords, entity2 = RaycastCamera(hit)
							until not targetActive or entity ~= entity2 or not zone:isPointInside(coords)
							break
						end
					end 
				end
			else success = false SendNUIMessage({response = "leftTarget"}) end
			Wait(sleep)
		end
		hasFocus, success = false, false
		SendNUIMessage({response = "closeTarget"})
	end
end

function DisableTarget()
	if targetActive then
		SetNuiFocus(false, false)
		SetNuiFocusKeepInput(false)
		targetActive = false
	end
end

RegisterNUICallback('selectTarget', function(option, cb)
	hasFocus = false
	local data = sendData[option]
	CreateThread(function()
		Wait(50)
		if data.action ~= nil then
			data.action(data.entity)
		else
			TriggerEvent(data.event, data)
		end
	end)

	sendData = nil
end)

RegisterNUICallback('closeTarget', function(data, cb)
	success = false
	hasFocus = false
end)

TriggerEvent('chat:addSuggestion', '/blink', 'Reset the Eye')

RegisterCommand('blink', function()
    SendNUIMessage({response = "leftTarget"})
    SendNUIMessage({response = "closeTarget"})
    targetActive = false
    success = false
end, false)

RegisterKeyMapping("+playerTarget", "Enable targeting~", "keyboard", "LMENU")
RegisterCommand('+playerTarget', EnableTarget, false)
RegisterCommand('-playerTarget', DisableTarget, false)
TriggerEvent("chat:removeSuggestion", "/+playerTarget")
TriggerEvent("chat:removeSuggestion", "/-playerTarget")

--Exports
AddCircleZone = function(name, center, radius, options, targetoptions)
	Zones[name] = CircleZone:Create(center, radius, options)
	Zones[name].targetoptions = targetoptions
end
exports("AddCircleZone", AddCircleZone)

AddBoxZone = function(name, center, length, width, options, targetoptions)
	Zones[name] = BoxZone:Create(center, length, width, options)
	Zones[name].targetoptions = targetoptions
end
exports("AddBoxZone", AddBoxZone)

AddPolyzone = function(name, points, options, targetoptions)
	Zones[name] = PolyZone:Create(points, options)
	Zones[name].targetoptions = targetoptions
end
exports("AddPolyzone", AddPolyzone)

AddTargetBone = function(bones, parameters)
	for _, bone in pairs(bones) do
		Bones[bone] = parameters
	end
end
exports("AddTargetBone", AddTargetBone)

AddTargetEntity = function(entity, parameters)
	local entity = NetworkGetEntityIsNetworked(entity) and NetworkGetNetworkIdFromEntity(entity) or false
	if entity then
		local distance, options = parameters.distance or Config.MaxDistance, parameters.options
		if not Entities[entity] then Entities[entity] = {} end
		for k, v in pairs(options) do
			if not v.distance or v.distance > distance then v.distance = distance end
			Entities[entity][v.label] = v
		end
	end
end
exports("AddTargetEntity", AddTargetEntity)

AddEntityZone = function(name, entity, options, targetoptions)
	Zones[name] = EntityZone:Create(entity, options)
	Zones[name].targetoptions = targetoptions
end
exports("AddEntityZone", AddEntityZone)

AddTargetModel = function(models, parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	for _, model in pairs(models) do
		if type(model) == 'string' then model = GetHashKey(model) end
		if not Models[model] then Models[model] = {} end
		for k, v in pairs(options) do
			if not v.distance or v.distance > distance then v.distance = distance end
			Models[model][v.label] = v
		end
	end
end
exports("AddTargetModel", AddTargetModel)

RemoveZone = function(name)
	if not Zones[name] then return end
	if Zones[name].destroy then
		Zones[name]:destroy()
	end
	Zones[name] = nil
end
exports("RemoveZone", RemoveZone)

RemoveTargetModel = function(models, labels)
	for _, model in pairs(models) do
		if type(model) == 'string' then model = GetHashKey(model) end
		for k, v in pairs(labels) do
			if Models[model] then
				Models[model][v] = nil
			end
		end
	end
end
exports("RemoveTargetModel", RemoveTargetModel)

RemoveTargetEntity = function(entity, labels)
	local entity = NetworkGetEntityIsNetworked(entity) and NetworkGetNetworkIdFromEntity(entity) or false
	if entity then
		for k, v in pairs(labels) do
			if Entities[entity] then
				Entities[entity][v] = nil
			end
		end
	end
end
exports("RemoveTargetEntity", RemoveTargetEntity)

local AddType = function(type, parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	for k, v in pairs(options) do
		if not v.distance or v.distance > distance then v.distance = distance end
		Types[type][v.label] = v
	end
end

AddPed = function(parameters) AddType(1, parameters) end
exports("Ped", AddPed)
AddVehicle = function(parameters) AddType(2, parameters) end
exports("Vehicle", AddVehicle)
AddObject = function(parameters) AddType(3, parameters) end
exports("Object", AddObject)

AddPlayer = function(parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	for k, v in pairs(options) do
		if not v.distance or v.distance > distance then v.distance = distance end
		Players[v.label] = v
	end
end
exports("Player", AddPlayer)

local RemoveType = function(type, labels)
	for k, v in pairs(labels) do
		Types[type][v] = nil
	end
end

RemovePed = function(labels) RemoveType(1, labels) end
exports("RemovePed", RemovePed)
RemoveVehicle = function(labels) RemoveType(2, labels) end
exports("RemoveVehicle", RemoveVehicle)
RemoveObject = function(labels) RemoveType(3, labels) end
exports("RemoveObject", RemoveObject)

RemovePlayer = function(type, labels)
	for k, v in pairs(labels) do
		Players[v.label] = nil
	end
end
exports("RemovePlayer", RemovePlayer)

if Config.Debug then
	AddEventHandler('qtarget:debug', function(data)
		print( 'Flag: '..curFlag..'', 'Entity: '..data.entity..'', 'Type: '..GetEntityType(data.entity)..'' )
		if data.remove then
			RemoveTargetEntity(data.entity, {
				'HelloWorld'
			})
		else
			AddTargetEntity(data.entity, {
				options = {
					{
						event = "qtarget:debug",
						icon = "fas fa-box-circle-check",
						label = "HelloWorld",
						remove = true
					},
				},
				distance = 3.0
			})
		end


	end)

	AddPed({
		options = {
			{
				event = "qtarget:debug",
				icon = "fas fa-male",
				label = "(Debug) Ped",
			},
		},
		distance = Config.MaxDistance
	})

	AddVehicle({
		options = {
			{
				event = "qtarget:debug",
				icon = "fas fa-car",
				label = "(Debug) Vehicle",
			},
		},
		distance = Config.MaxDistance
	})

	AddObject({
		options = {
			{
				event = "qtarget:debug",
				icon = "fas fa-cube",
				label = "(Debug) Object",
			},
		},
		distance = Config.MaxDistance
	})

	AddPlayer({
		options = {
			{
				event = "qtarget:debug",
				icon = "fas fa-cube",
				label = "(Debug) Player",
			},
		},
		distance = Config.MaxDistance
	})

end




-- Config --

AddBoxZone("PoliceDuty", vector3(441.79, -982.07, 30.69), 0.4, 0.6, {
	name="PoliceDuty",
	heading=91,
	debugPoly=false,
	minZ=30.79,
	maxZ=30.99
    }, {
        options = {
            {
                event = "pdsign", --
                icon = "fas fa-sign-in-alt",
                label = "Sign On/Off",
                job = "police",
            },

        },
        distance = 1.5
    })

    AddBoxZone("EMSDuty", vector3(310.23, -597.56, 43.29), 0.25, 0.4, {
        name="EMSDuty",
        heading=60,
        debugPoly=false,
        minZ=43.26,
        maxZ=43.31
        }, {
            options = {
                {
                    event = "emssign",
                    icon = "fas fa-business-time",
                    label = "EMS Duty",
                    job = "ambulance",
                },
            },
            distance = 1.49
        })
    

    local weaponstore = {
        -890640939,
        }
        AddTargetModel(weaponstore, {
        options = {
            {
                event = "OpenShop",
                icon = "fas fa-id-card-alt",
                label = "Ammunation",
            },
        },
        job = {"all"},
        distance = 2.5
    }) 

    local burgershot = {
        510552540,
        }
        AddTargetModel(burgershot, {
        options = {
        {
            event = "bgtray1",
            icon = "fas fa-truck-moving",
            label = "Open Tray",
        },
        },
        job = {"all"},
        distance = 2.5
    })


    local jobcenter = {
        776079908,
        }
        AddTargetModel(jobcenter, {
        options = {
        {
            event = "JobCenter",
            icon = "fas fa-briefcase",
            label = "Job Center",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local atm = {
        -870868698,
        -1126237515,
        506770882,
        -1364697528
        }
        AddTargetModel(atm, {
        options = {
        {
            event = "atm",
            icon = "fas fa-money-check-alt",
            label = "ATM",
        },
        },
        job = {"all"},
        distance = 2.5
    }) 

    local bike = {
    	1131912276,
        -2007026063,
        1058115860,
        }   
        AddTargetModel(bike, {
        options = {
        {
            event = "pickup:bike",
            icon = "fas fa-bicycle",
            label = "Pickup Bike",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local pawnshop = {
    	`cs_josef`,
        }   
        AddTargetModel(pawnshop, {
        options = {
        {
            event = "openpawnshop",
            icon = "fas fa-briefcase",
            label = "Pawnshop",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local gokart = {
    	`u_m_y_cyclist_01`,
        }   
        AddTargetModel(gokart, {
        options = {
        {
            event = "gokart:menu",
            icon = "fas fa-flag-checkered",
            label = "Spawn Go Kart",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local car = {
        `cs_bankman`,
        }   
        AddTargetModel(car, {
        options = {
        {
            event = "dealership",
            icon = "fas fa-car",
            label = "View Catalog",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local edealer = {
    	`u_m_m_promourn_01`,
        }   
        AddTargetModel(edealer, {
        options = {
        {
            event = "dealersell",
            icon = "fas fa-hand-holding-usd",
            label = "Sell",
        },
        {
            event = "dealerbuy",
            icon = "fas fa-shopping-cart",
            label = "Buy",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local garage = {
    	`csb_trafficwarden`,
        -44746786,
        }   
        AddTargetModel(garage, {
        options = {
        {
            event = "open-garage",
            icon = "fas fa-warehouse",
            label = "Access Garage",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local trolley = {
        269934519
        }   
        AddTargetModel(trolley, {
        options = {
        {
            event = "lootcart",
            icon = "fas fa-money-bill",
            label = "Grab Cash",
        },
        },
        job = {"all"},
        distance = 2.5
    })

    local impoundRent = {
    	`ig_benny`,
        }   
        AddTargetModel(impoundRent, {
        options = {
        {
            event = "tow:menu",
            icon = "fas fa-truck-pickup",
            label = "Rent A Tow Truck",
        },
        },
        job = {"all"},
        distance = 2.5
    })

--refundtowtruck
    local policedealership = {
        `s_m_y_cop_01`,
        }   
        AddTargetModel(policedealership, {
        options = {
        {
            event = "PoliceDealership",
            icon = "fas fa-car", 
            label = "Police Dealership",
        },
        },
        job = {"police"},
        distance = 2.5
    })

    local lsc_mech = {
        `mp_m_waremech_01`,
    }
    AddTargetModel(lsc_mech, {
        options = {
        {
            event = "lsc_twotruck",
            icon = "fas fa-wrench",
            label = "Get Tow Truck",
        },
        },
        job = {"mechanic"},
        distance = 1.5
    })

    local lsc_mech = {
        `s_m_y_dwservice_02`,
    }
    AddTargetModel(lsc_mech, {
        options = {
        {
            event = "mechanic:respray",
            icon = "fas fa-spray-can",
            label = "Respray",
        },
        },
        job = {"mechanic"},
        distance = 5
    })
    local beachrental = {
        `a_f_y_beach_01`,
        }   
        AddTargetModel(beachrental, {
        options = {
        {
            event = "beachrental:menu",
            icon = "fas fa-anchor", 
            label = "Beach Rental's",
        },
        },
        job = {"all"},
        distance = 2.5
    })
    local beachreturn = {
        `a_m_y_beach_03`,
        }   
        AddTargetModel(beachreturn, {
        options = {
        {
            event = "sonoraboats:menu",
            icon = "fas fa-anchor", 
            label = "Beach Returns",
        },
        },
        job = {"all"},
        distance = 2.5
    })
    local dirtrental = {
        `a_m_y_dhill_01`,
        }   
        AddTargetModel(dirtrental, {
        options = {
        {
            event = "dirtrental:menu",
            icon = "fas fa-flag-checkered", 
            label = "Dirt Rentals",
        },
        },
        job = {"all"},
        distance = 2.5
    })
    local drugsales = {
        `g_m_y_mexgoon_01`,
        }   
        AddTargetModel(drugsales, {
        options = {
        {
            event = "drugsales:menu",
            icon = "fas fa-cannabis", 
            label = "Drug Sales",
        },
        },
        job = {"all"},
        distance = 2.5
    })
    local drugsales = {
        `g_m_y_mexgoon_01`,
    }
    AddTargetModel(drugsales, {
        options = {
        {
            event = "drugsales:menu",
            icon = "fas fa-cannabis",
            label = "Drug Sales",
        },
        {
            event = "drugunpack:menu",
            icon = "fas fa-cannabis",
            label = "Unpack Drugs",
        },
        },
        job = {"all"},
        distance = 4.5
    })
    local blackmarket = {
        `g_m_m_chicold_01`,
        }   
        AddTargetModel(blackmarket, {
        options = {
        {
            event = "blackmarket:menu",
            icon = "fas fa-suitcase", 
            label = "Blackmarket",
        },
        },
        job = {"all"},
        distance = 2.5
    })--mp_f_freemode_01


    local pdheli = {
        `s_m_y_pilot_01`,
        }   
        AddTargetModel(pdheli, {
        options = {
        {
            event = "pd:heli",
            icon = "fas fa-helicopter", 
            label = "Helicopter Garage",
        },
        },
        job = {"police"},
        distance = 2.5
    })  

        AddBoxZone("FBILift1", vector3(136.6300, -763.4200, 45.74219), 0.25, 0.35, {
            name="FBILift1",
            heading=160,
            debugPoly=false,
            minZ=45.40,
            maxZ=46.45
            }, {
                options = {
                    {
                        event = "fbi:Lift", 
                        icon = "fas fa-clipboard",
                        label = "elevator",
                    },
        
                },
                job = {"all"},
                distance = 2.5
            }) ---192.5934, -1161.798, 23.66882

        AddBoxZone("FBILift49", vector3(136.6900, -763.3300, 242.1436), 0.25, 0.35, {
            name="FBILift49",
            heading=160,
            debugPoly=false,
            minZ=241.90,
            maxZ=242.78
            }, {
                options = {
                    {
                        event = "fbi:Lift", 
                        icon = "fas fa-clipboard",
                        label = "elevator",
                    },
        
                },
                job = {"all"},
                distance = 2.5
            }) ---192.5934, -1161.798, 23.66882

        AddBoxZone("stevepent1", vector3(-306.3500, -721.8500, 28.01611), 0.25, 0.35, {
            name="stevepent1",
            heading=160,
            debugPoly=false,
            minZ=27.80,
            maxZ=28.65
            }, {
                options = {
                    {
                        event = "steve:lift", 
                        icon = "fas fa-clipboard",
                        label = "elevator",
                    },
        
                },
                job = {"all"},
                distance = 2.5
            }) ---192.5934, -1161.798, 23.66882

        AddBoxZone("stevepent2", vector3(-287.4000, -723.9000, 125.4586), 0.25, 0.35, {
            name="stevepent2",
            heading=70,
            debugPoly=false,
            minZ=125.25,
            maxZ=126.10
            }, {
                options = {
                    {
                        event = "steve:lift", 
                        icon = "fas fa-clipboard",
                        label = "elevator",
                    },
        
                },
                job = {"all"},
                distance = 2.5
            }) ---192.5934, -1161.798, 23.66882

            local sonoraboats = {
                `a_m_y_beach_01`,
                }   
                AddTargetModel(sonoraboats, {
                options = {
                {
                    event = "open-garage",
                    icon = "fas fa-anchor",
                    label = "Sonora Boats",
                },
                },
                job = {"all"},
                distance = 2.5
            })

RegisterNetEvent('dealership')
AddEventHandler('dealership', function()  
    TriggerEvent('dealership:open')
end)

RegisterNetEvent('dealership')
AddEventHandler('dealership', function()  
    TriggerEvent('dealership:open')
end)

RegisterNetEvent('lsc_twotruck')
AddEventHandler('lsc_twotruck', function()  
    TriggerServerEvent('checklsckeys')
end)


--            exports['cn-taskbar']:taskbar(1500, 'Starting Hack...')

RegisterNetEvent('PoliceDealership')--pd:heli
AddEventHandler('PoliceDealership', function()

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
				event = "buycvpi",
				args = {
					number = 1,
					id = 2
				}
			}
		},
		{
			id = 3,
			header = "Ford Taurus",
			txt = "$25,000",
			params = {
				event = "buyfpis",
				args = {
					number = 2,
					id = 3
				}
			}
		},
		{
			id = 4,
			header = "2014 Tahoe",
			txt = "$30,000 (Off-Road)",
			params = {
				event = "buytahoe",
				args = {
					number = 3,
					id = 4
				}
			}
		},
        {
			id = 5,
			header = "Dodge RAM",
			txt = "$35,000 (Off-Road)",
			params = {
				event = "buyram",
				args = {
					number = 4,
					id = 5
				}
			}
		},
        {
			id = 6,
			header = "BMW Motorcycle",
			txt = "$25,000 (Motor)",
			params = {
				event = "buybmw",
				args = {
					number = 5,
					id = 6
				}
			}
		},
        {
			id = 7,
			header = "2018 Charger",
			txt = "$50,000",
			params = {
				event = "buycharg",
				args = {
					number = 6,
					id = 7
				}
			}
		}
	})
end)


RegisterNetEvent('pd:heli')--pd:heli
AddEventHandler('pd:heli', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "MRPD Helipad",
            txt = ""
        },
		{
            id = 2,
            header = "Police Helicopter",
            txt = "$5,000",
            params = {
                event = "buyheli",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('fbi:dealer')--pd:heli
AddEventHandler('fbi:dealer', function()

    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "FBI Helipad",
            txt = ""
        },
		{
            id = 2,
            header = "Police Helicopter",
            txt = "$5,000",
            params = {
                event = "buyheli",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('buycvpi')
AddEventHandler('buycvpi', function()  
    TriggerServerEvent('cvpimoney')
end)

RegisterNetEvent('buyheli')
AddEventHandler('buyheli', function()  
    TriggerServerEvent('helimoney')
end)

RegisterNetEvent('buyram')
AddEventHandler('buyram', function()  
    TriggerServerEvent('rammoney')
end)

RegisterNetEvent('buyfpis')
AddEventHandler('buyfpis', function()  
    TriggerServerEvent('fpismoney')
end)

RegisterNetEvent('buytahoe')
AddEventHandler('buytahoe', function()  
    TriggerServerEvent('tahoemoney')
end)

RegisterNetEvent('buybmw')
AddEventHandler('buybmw', function()  
    TriggerServerEvent('bmwmoney')
end)

RegisterNetEvent('buycharg')
AddEventHandler('buycharg', function()  
    TriggerServerEvent('chargmoney')
end)

local spawn = false
local playerPed = PlayerPedId()

RegisterNetEvent('cvpispawn')
AddEventHandler('cvpispawn', function()
    local hash = GetHashKey("code3cvpi")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('ramspawn')
AddEventHandler('ramspawn', function()
    local hash = GetHashKey("code3ram")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('fpisspawn')
AddEventHandler('fpisspawn', function()
    local hash = GetHashKey("code3fpis")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('tahoespawn')
AddEventHandler('tahoespawn', function()
    local hash = GetHashKey("code314tahoe")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('bmwspawn')
AddEventHandler('bmwspawn', function()
    local hash = GetHashKey("code3bmw")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('chargspawn')
AddEventHandler('chargspawn', function()
    local hash = GetHashKey("code318charg")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 450.1846, -975.8373, 25.6908, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    local plate = GetVehicleNumberPlateText(vehiclebuy)
    Citizen.Wait(1000)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleBuy)))
    TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
    TriggerEvent('bb-garages:client:insertOwnedVehicle', plate, vehicleBuy)
end)

RegisterNetEvent('helispawn')--helispawn
AddEventHandler('helispawn', function()
    local hash = GetHashKey("eheli")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, 449.3143, -981.1252, 43.6864, 90.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
end)

-- LSC CUSTOMS TOW TRUCK RENTAL --

local lsctruck = 1

RegisterNetEvent('spawnlsctruck')
AddEventHandler('spawnlsctruck', function()
    local hash = GetHashKey("20ramrbc")
        
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -365.8681, -85.41099, 39.0022, 250.00, 1, 1)
    local plate = GetVehicleNumberPlateText(vehicleBuy)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    lsctruck = GetHashKey(vehicleBuy)
    print(lsctruck)
    Citizen.Wait(1000)
    TriggerServerEvent('Aidan_isCool:giveKeys')
    TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicleBuy)
end)

RegisterNetEvent('return_lsc')
AddEventHandler('return_lsc', function()
    local current = GetVehiclePedIsIn(PlayerPedId(), false)
    local hash = GetHashKey(current)
    if hash == lsctruck then
        print('correct truck')
        exports['mythic_notify']:SendAlert('inform', 'Truck Returned') 
        TriggerServerEvent('returnLSCKeys')
        DeleteVehicle(current)
        lsctruck = 1
    else
        print('invalid truck')
        exports['mythic_notify']:SendAlert('error', 'This truck ain\'t the same bitch') 
    end

    --    TriggerServerEvent('returnLSCKeys')
end)

RegisterNetEvent('open_paint_menu')
AddEventHandler('open_paint_menu', function()
    local closecar = ESX.Game.GetClosestVehicle(coords, modelFilter)
    
end)

RegisterNetEvent('pdsign')
AddEventHandler('pdsign', function()
    TriggerServerEvent('pdduty:onoff')
end)

RegisterNetEvent('emssign')
AddEventHandler('emssign', function()
    TriggerServerEvent('emsduty:onoff')
end)--tow:duty

RegisterNetEvent('towsign')
AddEventHandler('towsign', function()
    TriggerServerEvent('towduty:onoff')
end)

RegisterNetEvent('sellweedjoint')
AddEventHandler('sellweedjoint', function()
    TriggerServerEvent('sellweedjoint')
end)

RegisterNetEvent('sellcokebaggy')
AddEventHandler('sellcokebaggy', function()
    TriggerServerEvent('sellcokebaggy')
end)