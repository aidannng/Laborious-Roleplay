ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
	end
end)


Citizen.CreateThread(function()
    exports['labrp_Eye']:AddBoxZone("WeedPacking", vector3(2862.857, 4465.546, 42.27112), 1.0, 2.9, {
        name="WeedPacking",
        heading=18,
        debugPoly=false,
        minZ=40.95,
        maxZ=41.70
        }, {
            options = {
                {
                    event = "plasma:weedcheck",
                    icon = "fas fa-cannabis",
                    label = "Package Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedPacking2", vector3(2866.200, 4466.600, 42.32166), 1.0, 2.5, {
        name="WeedPacking2",
        heading=18,
        debugPoly=false,
        minZ=40.95,
        maxZ=41.60
        }, {
            options = {
                {
                    event = "plasma:weedcheck",
                    icon = "fas fa-cannabis",
                    label = "Package Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering", vector3(2864.136, 4456.773, 41.31067), 3.0, 4.0, {
        name="WeedGathering",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering1", vector3(2859.679, 4455.363, 41.31067), 3.0, 4.0, {
        name="WeedGathering1",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering2", vector3(2860.879, 4451.42, 41.31067), 3.0, 4.0, {
        name="WeedGathering2",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering3", vector3(2865.653, 4452.936, 41.31067), 3.0, 4.0, {
        name="WeedGathering3",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering4", vector3(2870.545, 4454.545, 41.31067), 3.0, 4.0, {
        name="WeedGathering4",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering5", vector3(2869.319, 4458.435, 41.31067), 3.0, 4.0, {
        name="WeedGathering5",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering6", vector3(2867.974, 4462.259, 41.31067), 3.0, 4.0, {
        name="WeedGathering6",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering7", vector3(2863.108, 4460.558, 41.31067), 3.0, 4.0, {
        name="WeedGathering7",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("WeedGathering8", vector3(2858.268, 4459.095, 41.31067), 3.0, 4.0, {
        name="WeedGathering8",
        heading=18,
        debugPoly=false,
        minZ=40.50,
        maxZ=42.90
        }, {
            options = {
                {
                    event = "plasma:weedgather",
                    icon = "fas fa-cannabis",
                    label = "Pick Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })

    exports['labrp_Eye']:AddBoxZone("weedunpack", vector3(2852.914, 4448.861, 41.31067), 1.9, 1.9, {
        name="weedunpack",
        heading=18,
        debugPoly=false,
        minZ=40.70,
        maxZ=42.30
        }, {
            options = {
                {
                    event = "plasma:weedunpack",
                    icon = "fas fa-cannabis",
                    label = "Unpack Weed",
                },

            },
            job = {"all"},
            distance = 2.5
        })
end)

RegisterNetEvent("plasma:weedpack")
AddEventHandler("plasma:weedpack", function()
    local finished = exports["reload-skillbar"]:taskBar(10000,math.random(7,10))
    ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
        if data then
            if finished ~= 100 then
                exports['mythic_notify']:SendAlert('error', 'You dropped the buds!')
            else
                TriggerServerEvent('plasma1')
            end
        end
    end, "weed")
end)

RegisterNetEvent("plasma:weedcheck")
AddEventHandler("plasma:weedcheck", function()
    ESX.TriggerServerCallback("Aidan:server:CheckItem3", function(data)
        if data then
            TriggerEvent("plasma:weedpack")
        else
            exports['mythic_notify']:SendAlert('error', 'You do not have enough weed to pack.')
        end
    end, "weed")

end)

RegisterNetEvent("plasma:weedgather")
AddEventHandler("plasma:weedgather", function()
    ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
        if data then
            TriggerEvent("plasma:weedgather2")
        else
            exports['mythic_notify']:SendAlert('error', 'You do not have the right tool.')
        end
    end, "trimmers")
end)

RegisterNetEvent("plasma:weedgather2")
AddEventHandler("plasma:weedgather2", function()
    local finished = exports["reload-skillbar"]:taskBar(8000,math.random(7,10))
    ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
        if data then
            if finished ~= 100 then
                exports['mythic_notify']:SendAlert('error', 'You trimmed too much.')
            else
                TriggerServerEvent('plasma2')
            end
        end
    end, "trimmers")
end)

RegisterNetEvent("plasma:weedunpack")
AddEventHandler("plasma:weedunpack", function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Unpack Weed",
            txt = ""
        },
		{
			id = 2,
			header = "Joints",
			txt = "",
			params = {
				event = "plasma6",
				args = {
					number = 1,
					id = 2
				}
			}
		},
		
	})
end)


-- RegisterNetEvent("plasma6")
-- AddEventHandler("plasma6", function()
--     ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
--         if data then
--             TriggerEvent("plasma5")
--         else
--             exports['mythic_notify']:SendAlert('error', 'You do not have the required materials.')
--         end
--     end, "packagedweed")
-- end)

-- RegisterNetEvent("plasma5")
-- AddEventHandler("plasma5", function()
--     local finished = exports["reload-skillbar"]:taskBar(8000,math.random(7,10))
--     ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
--         if data then
--             if finished ~= 100 then
--                 exports['mythic_notify']:SendAlert('error', 'You dropped the weed.')
--             else
--                 TriggerServerEvent('server:joint')
--             end
--         end
--     end, "packagedweed")
-- end)

RegisterNetEvent("plasma6")
AddEventHandler("plasma6", function()
    ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
        if data then
            ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
                if data then
                    TriggerEvent("plasma5")
                else
                    exports['mythic_notify']:SendAlert('error', 'You have no packaged weed.')
                end
            end, "packagedweed")
        else
            exports['mythic_notify']:SendAlert('error', 'You have no rolling paper.')
        end
    end, "rolling_paper")
end)

RegisterNetEvent("plasma5")
AddEventHandler("plasma5", function()
    local finished = exports["reload-skillbar"]:taskBar(8000,math.random(7,10))
    ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
        if data then
            ESX.TriggerServerCallback("Aidan:server:CheckItem", function(data)
                if data then
                    if finished ~= 100 then
                        exports['mythic_notify']:SendAlert('error', 'You dropped the weed.')
                    else
                        TriggerServerEvent('server:joint')
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'You have no packaged weed.')
                end
            end, "packagedweed")
        else
            exports['mythic_notify']:SendAlert('error', 'You have no rolling paper.')
        end
    end, "rolling_paper")
end)