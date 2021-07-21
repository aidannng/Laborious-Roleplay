Citizen.CreateThread(function()
    local shopKeeps = {
        `mp_m_shopkeep_01`
    }

    exports['labrp_Eye']:AddTargetModel(shopKeeps, {
        options = {
            {
                event = 'linden_inventory:openShopInventory',
                icon = 'fas fa-shopping-basket',
                label = '24/7 Store'
            },
        },
        job = {'all'},
        distance = 3.0
    })
end)


AddEventHandler('linden_inventory:openShopInventory', function()
    for i = 1, #Config.Shops, 1 do
        for k,v in pairs(Config.Shops[i].type) do
            if Config.Shops[i].type['name'] == 'Shop' then
                if #(GetEntityCoords(PlayerPedId()) - Config.Shops[i].coords) <= 1.8 then
                    OpenShop(i)
                    break
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local AmmunationKeeps = {
        `csb_cletus`
    }

    exports['labrp_Eye']:AddTargetModel(AmmunationKeeps, {
        options = {
            {
                event = 'linden_inventory:openAmmuInventory',
                icon = 'fas fa-bomb',
                label = 'Ammunation'
            },
        },
        job = {'all'},
        distance = 3.0
    })
end)

AddEventHandler('linden_inventory:openAmmuInventory', function()
    for i = 1, #Config.Shops, 1 do
        for k,v in pairs(Config.Shops[i].type) do
            if Config.Shops[i].type['name'] == 'Ammunation' then
                if #(GetEntityCoords(PlayerPedId()) - Config.Shops[i].coords) <= 1.8 then
                    OpenShop(i)
                    break
                end
            end
        end
    end
end)

AddEventHandler('linden_inventory:openYTInventory', function()
    for i = 1, #Config.Shops, 1 do
        for k,v in pairs(Config.Shops[i].type) do
            if Config.Shops[i].type['name'] == 'YouTool' then
                if #(GetEntityCoords(PlayerPedId()) - Config.Shops[i].coords) <= 1.8 then
                    OpenShop(i)
                    break
                end
            end
        end
    end
end)


exports['labrp_Eye']:AddBoxZone("YouToolKeeps", vector3(45.04, -1748.36, 29.55), 1.0, 1.0, {
	name="YouToolKeeps",
	heading=40,
	debugPoly=false,
	minZ=28.55,
	maxZ=30.55
    }, {
        options = {
            {
                event = 'linden_inventory:openYTInventory',
                icon = 'fas fa-hammer',
                label = 'YouTool'
            },

        },
        job = {"all"},
        distance = 1.5
    })

    exports['labrp_Eye']:AddBoxZone("YouToolKeeps2", vector3(2748.97, 3472.31, 55.68), 1.0, 1.0, {
        name="YouToolKeeps2",
        heading=40,
        debugPoly=false,
        minZ=54.68,
        maxZ=56.68
        }, {
            options = {
                {
                    event = 'linden_inventory:openYTInventory',
                    icon = 'fas fa-hammer',
                    label = 'YouTool'
                },
    
            },
            job = {"all"},
            distance = 1.5
        })

        exports['labrp_Eye']:AddBoxZone("YouToolKeeps3", vector3(-11.14, 6499.56, 31.50), 1.0, 1.0, {
            name="YouToolKeeps3",
            heading=40,
            debugPoly=false,
            minZ=30.50,
            maxZ=32.50
            }, {
                options = {
                    {
                        event = 'linden_inventory:openYTInventory',
                        icon = 'fas fa-hammer',
                        label = 'YouTool'
                    },
        
                },
                job = {"all"},
                distance = 1.5
            })


Citizen.CreateThread(function()
        
    
    
    exports['labrp_Eye']:AddBoxZone("PoliceArmoury", vector3(481.5, -994.8, 30.6), 3.0, 0.8, {
    name="PoliceArmoury",
    heading=91,
    debugPoly=false,
    minZ=29.6,
    maxZ=31.6
    }, {
        options = {
            {
                event = "linden_inventory:openPoliceArmouryInventory",
                icon = "far fa-clipboard",
                label = "Police Armoury",
            },
        },
        job = {"police"},
        distance = 1.5
    })


    
end)

RegisterNetEvent("fbi:Lift")
AddEventHandler("fbi:Lift", function()
    exports['br-menu']:SetTitle("FBI Lift")
    exports['br-menu']:AddButton("Floor 49" , "Communications/Main Offices" ,'fbi:Lift:f49' ,true ,"menuone")
    exports['br-menu']:AddButton("Floor 01" , "Main Lobby" ,'fbi:Lift:f01' ,true ,"menuone")
    exports['br-menu']:AddButton("Floor -1" , "FBI Car Park" ,'fbi:Lift:f01' ,true ,"menuone")
end)

RegisterNetEvent("fbi:Lift:f49")
AddEventHandler("fbi:Lift:f49", function()
    local ped = PlayerPedId()
    SetEntityCoords(ped, 136.2725 , -761.5516 , 242.1436 ) 
end)

RegisterNetEvent("fbi:Lift:f01")
AddEventHandler("fbi:Lift:f01", function()    
    local ped = PlayerPedId()
    SetEntityCoords(ped, 136.2725 , -760.5516 , 45.1436 ) 
end) 

-- Citizen.CreateThread(function()
--     exports['labrp_Eye']:AddBoxZone("FBILift1", vector3(136.6022, -763.0417, 45.74219), 1.0, 0.8, {
--     name="FBILift1",
--     heading=90,
--     debugPoly=false,
--     minZ=45.7,
--     maxZ=46.6
--     }, {
--         options = {
--             {
--                 event = "fbi:Lift",
--                 icon = "far fa-clipboard",
--                 label = "Use Elevator",
--             },
--         },
--         job = {"all"},
--         distance = 1.5
--     })   
-- end)

-- Citizen.CreateThread(function()
--     exports['labrp_Eye']:AddBoxZone("FBILift49", vector3(136.6681, -763.0549, 242.1436), 1.0, 0.8, {
--     name="FBILift49",
--     heading=90,
--     debugPoly=false,
--     minZ=242.1, 
--     maxZ=243.0
--     }, {
--         options = {
--             {
--                 event = "fbi:Lift",
--                 icon = "far fa-clipboard",
--                 label = "Use Elevator",
--             },
--         },
--         job = {"all"},
--         distance = 1.5
--     })   
-- end)



Citizen.CreateThread(function()
        
    
    
    exports['labrp_Eye']:AddBoxZone("FbiArm", vector3(125.4176, -733.1208, 242.1436), 3.0, 0.8, {
    name="FBIArmoury",
    heading=165,
    debugPoly=false,
    minZ=242.14,
    maxZ=242.50
    }, {
        options = {
            {
                event = "linden_inventory:openFBIArmouryInventory",
                icon = "far fa-clipboard",
                label = "FBI Armoury",
            },
        },
        job = {"fbi"},
        distance = 1.5
    })


    
end)

AddEventHandler('linden_inventory:openPoliceArmouryInventory', function()
    for i = 1, #Config.Shops, 1 do
        for k,v in pairs(Config.Shops[i].type) do
            if Config.Shops[i].type['name'] == 'Police Armoury' then
                if #(GetEntityCoords(PlayerPedId()) - Config.Shops[i].coords) <= 1.8 then
                    OpenShop(i)
                    break
                end
            end
        end
    end
end)

AddEventHandler('linden_inventory:openFBIArmouryInventory', function()
    for i = 1, #Config.Shops, 1 do
        for k,v in pairs(Config.Shops[i].type) do
            if Config.Shops[i].type['name'] == 'FBI Armoury' then
                if #(GetEntityCoords(PlayerPedId()) - Config.Shops[i].coords) <= 1.8 then
                    OpenShop(i)
                    break
                end
            end
        end
    end
end)

AddEventHandler('linden_inventory:openEMSArmouryInventory', function()
    for i = 1, #Config.Shops, 1 do
        for k,v in pairs(Config.Shops[i].type) do
            if Config.Shops[i].type['name'] == 'EMS Store' then
                if #(GetEntityCoords(PlayerPedId()) - Config.Shops[i].coords) <= 1.8 then
                    OpenShop(i)
                    break
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
local shopKeeps = {
    `ig_hunter`
}

exports['labrp_Eye']:AddTargetModel(shopKeeps, {
    options = {
        {
            event = 'linden_inventory:openHuntingInventory',
            icon = 'fas fa-paw',
            label = 'Hunting Store'
        },
        {
            event = 'sellMeat',
            icon = 'fas fa-dollar-sign',
            label = 'Sell Meat'
        },
        {
            event = 'sellLeather',
            icon = 'fas fa-dollar-sign',
            label = 'Sell Leather'
        },
    },
    job = {'all'},
    distance = 3.0
})
end)

RegisterNetEvent('sellMeat')
AddEventHandler('sellMeat', function()
    TriggerServerEvent('hunting:sellMeat')
end)

RegisterNetEvent('sellLeather')
AddEventHandler('sellLeather', function()
    TriggerServerEvent('hunting:sellLeather')
end)

AddEventHandler('linden_inventory:openHuntingInventory', function()
for i = 1, #Config.Shops, 1 do
    for k,v in pairs(Config.Shops[i].type) do
        if Config.Shops[i].type['name'] == 'Hunting' then
            if #(GetEntityCoords(PlayerPedId()) - Config.Shops[i].coords) <= 1.8 then
                OpenShop(i)
                break
            end
        end
    end
end
end)

AddEventHandler('linden_inventory:openPrisonInventory', function()
    for i = 1, #Config.Shops, 1 do
        for k,v in pairs(Config.Shops[i].type) do
            if Config.Shops[i].type['name'] == 'Prison' then
                if #(GetEntityCoords(PlayerPedId()) - Config.Shops[i].coords) <= 1.8 then
                    OpenShop(i)
                    break
                end
            end
        end
    end
end)
