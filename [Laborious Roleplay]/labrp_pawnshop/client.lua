ESX = nil
local PlayerData = {}
local pedspawneado = false

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


RegisterNetEvent('openpawnshop')
AddEventHandler('openpawnshop', function()
    exports['br-menu']:SetTitle("Pawnshop")

    exports['br-menu']:AddButton("Casio Watch" , "$30 - $70" ,'sellcasio' ,'' , 'menuone')
    exports['br-menu']:AddButton("Wedding Ring" , "$150 - $280" ,'sellwring' ,'' , 'menuone')
    exports['br-menu']:AddButton("2CT Chain" , "$70 - $95" ,'sell2chain' ,'' , 'menuone')
    exports['br-menu']:AddButton("5CT Chain" , "$100 - $125" ,'sell5chain' ,'' , 'menuone')
    exports['br-menu']:AddButton("8CT Chain" , "$140 - $190" ,'sell8chain' ,'' , 'menuone')
    exports['br-menu']:AddButton("10CT Chain" , "$250 - $400" ,'sell10chain' ,'' , 'menuone')
    exports['br-menu']:AddButton("Rolex" , "$700 - $1500" ,'sellrolex' ,'' , 'menuone')
    exports['br-menu']:SubMenu("Jewellery" , "Rings | Chain's | Watch's" , "menuone" )


    exports['br-menu']:AddButton("Scrap Metal" , "$45 - $60" ,'sellscrap' ,'' , 'menutwo')
    exports['br-menu']:AddButton("Aluminium" , "$35 - $45" ,'sellaluminium' ,'' , 'menutwo')
    exports['br-menu']:AddButton("Copper" , "$25 - $35" ,'sellcopper' ,'' , 'menutwo')
    exports['br-menu']:AddButton("Rubber" , "$25 - $35" ,'sellrubber' ,'' , 'menutwo')
    exports['br-menu']:AddButton("Electronics" , "$45 - $60" ,'sellelectronics' ,'' , 'menutwo')
    exports['br-menu']:SubMenu("Materials" , "Rubber | Copper | Aluminium | Scrap Metal" , "menutwo" )

    exports['br-menu']:SubMenu("Coming Soon..." , "👀" ,'' ,'' , '')
end)



-- Server Triggers -- 

RegisterNetEvent('sellcasio')
AddEventHandler('sellcasio', function()
    TriggerServerEvent('pawnshop:sellcasio')
end)

RegisterNetEvent('sellwring')
AddEventHandler('sellwring', function()
    TriggerServerEvent('pawnshop:sellwring')
end)

RegisterNetEvent('sell2chain')
AddEventHandler('sell2chain', function()
    TriggerServerEvent('pawnshop:sell2chain')
end)

RegisterNetEvent('sell5chain')
AddEventHandler('sell5chain', function()
    TriggerServerEvent('pawnshop:sell5chain')
end)

RegisterNetEvent('sell8chain')
AddEventHandler('sell8chain', function()
    TriggerServerEvent('pawnshop:sell8chain')
end)

RegisterNetEvent('sell10chain')
AddEventHandler('sell10chain', function()
    TriggerServerEvent('pawnshop:sell10chain')
end)

RegisterNetEvent('sellrolex')
AddEventHandler('sellrolex', function()
    TriggerServerEvent('pawnshop:sellrolex')
end)







RegisterNetEvent('sellscrap')
AddEventHandler('sellscrap', function()
    TriggerServerEvent('pawnshop:sellscrap')
end)

RegisterNetEvent('sellaluminium')
AddEventHandler('sellaluminium', function()
    TriggerServerEvent('pawnshop:sellaluminium')
end)

RegisterNetEvent('sellcopper')
AddEventHandler('sellcopper', function()
    TriggerServerEvent('pawnshop:sellcopper')
end)

RegisterNetEvent('sellrubber')
AddEventHandler('sellrubber', function()
    TriggerServerEvent('pawnshop:sellrubber')
end)

RegisterNetEvent('sellelectronics')
AddEventHandler('sellelectronics', function()
    TriggerServerEvent('pawnshop:sellelectronics')
end)



exports['labrp_Eye']:AddBoxZone("smallcrafting", vector3(2514.356, 4215.771, 39.02417), 1.7, 0.9, {
	name="smallcrafting",
	heading=55,
	debugPoly=false,
	minZ=38.55,
	maxZ=40.05
    }, {
        options = {
            {
                event = 'smallcrafting',
                icon = 'fas fa-hammer',
                label = 'Crafting Bench'
            },

        },
        job = {"all"},
        distance = 2.5
    })


RegisterNetEvent('smallcrafting')
AddEventHandler('smallcrafting', function()
    exports['br-menu']:SetTitle("Small Crafting")    
    
    exports['br-menu']:AddButton("Advanced Lockpick" , "Materials : 5 Scrap Metal" ,'craftadlock' ,'' , 'menutwo')
    exports['br-menu']:AddButton("Casio Watch" , "Materials : 2 Batteries | 5 Plastic" ,'craftcasio' ,'' , 'menutwo')
    
end)

RegisterNetEvent('craftadlock')
AddEventHandler('craftadlock', function()
    TriggerServerEvent('craft:adlock')
end)

RegisterNetEvent('craftcasio')
AddEventHandler('craftcasio', function()
    TriggerServerEvent('craft:casio')
end)