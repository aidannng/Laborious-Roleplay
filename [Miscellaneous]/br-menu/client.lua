
exports('AddButton', function(title , description , trigger , par , id)
    if(id == nil) then id = false end
    SetNuiFocus(true , true)
    SendNUIMessage({addbutton = true , title = title , description = description , trigger = trigger , par = par , id = id })
end)

exports('SubMenu', function(title , description , menuid)
    SetNuiFocus(true , true)
    SendNUIMessage({addmenu = true , title = title , description = description , menuid = menuid })
end)

exports('SetTitle', function(title)
    SendNUIMessage({SetTitle = true , title = title})
end)

local sound = Config.Sound
local soundName = Config.SoundName 
local enablesound = Config.EnableSound 

RegisterNUICallback("clicked" , function(data , cb)
    local trigger = data.trigger
    local d = data.server
    local d = data.server 
    TriggerServerEvent(trigger ,data.param)
    TriggerEvent(trigger , data.param)
    if(enablesound == true) then
        PlaySoundFrontend(-1, soundName,sound, 1)
    end
end)
RegisterNUICallback("close" , function(data , cb)
    SetNuiFocus(false , false)
    if(enablesound == true) then
        PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    end
    
end)

RegisterNetEvent("menu:test")
AddEventHandler("menu:test" , function(parameter)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        args = {"[BR-MENU]", "Hey, menu test with specific parameter: "..parameter}
      })
      
      
end)


RegisterNetEvent('labrp_eye:pdsign')
AddEventHandler('labrp_eye:pdsign', function()
    exports['br-menu']:SetTitle("Mission Row Police Department")
    exports['br-menu']:AddButton("LSPD" , "Toggle On Duty" ,'duty:onoff' ,'' , 'menuone')
    exports['br-menu']:AddButton("LSPD" , "Toggle Off Duty" ,'duty:onoff' ,'' , "me" )
end)

RegisterNetEvent('labrp_eye:emssign')
AddEventHandler('labrp_eye:emssign', function()
    exports['br-menu']:SetTitle("PillBox Medical Center")
    exports['br-menu']:AddButton("EMS" , "Toggle On Duty" ,'duty:onoff' ,'' , 'menuone')
    exports['br-menu']:AddButton("EMS" , "Toggle Off Duty" ,'duty:onoff' ,'' , "me" )
    exports['br-menu']:SubMenu("Sign On" , "San Andreas EMS" , "menuone" )
    exports['br-menu']:SubMenu("Sign Off" , "San Andreas EMS" , "me" )
end)

RegisterNetEvent('JobCenter')
AddEventHandler('JobCenter', function()
    exports['br-menu']:SetTitle("Los Santos Job Center")
    exports['br-menu']:AddButton("Miner" , "Miner some shit" ,'' ,'' , 'meone')
    exports['br-menu']:AddButton("GoPostal" , "Go deliver some shit" ,'' ,'' , "metwo" )
    exports['br-menu']:AddButton("Trucking" , "Go drive some shit" ,'' ,'' , "methree" )
end)

RegisterNetEvent('pawnshop')
AddEventHandler('pawnshop', function()
    exports['br-menu']:SetTitle("Pawnshop")
    exports['br-menu']:AddButton("Casio Watch" , "Sell your Casio Watches" ,'pawnshop:sellcasio' ,'' , 'meone')
    exports['br-menu']:AddButton("Rubber" , "Sell your Rubber" ,'pawnshop:sellrubber' ,'' , "metwo" )
    exports['br-menu']:AddButton("Copper" , "Sell your Copper" ,'pawnshop:sellcopper' ,'' , "methree" ) --pawnshop:sellcopper
    exports['br-menu']:AddButton("Electronics" , "Sell your Electronics" ,'pawnshop:sellelectronics' ,'' , "mefour" )
end)


RegisterNetEvent('crafting')
AddEventHandler('crafting', function()
    exports['br-menu']:SetTitle("Crafting Bench")
    exports['br-menu']:AddButton("M70 Rifle" , "250 Scrap Metal, 180 Aluminium and 50 Rubber" ,'craft:m70rifle' ,'' , 'meone')
end)

--Export Dealer

RegisterNetEvent('dealersell')
AddEventHandler('dealersell', function()
    exports['br-menu']:SetTitle("Export Dealer")
    exports['br-menu']:AddButton("Jewels" , "Sell your Jewels" ,'dealersell:selljewels' ,'' , 'meone')
    exports['br-menu']:AddButton("Rolex" , "Sell your Rolexs" ,'dealersell:sellrolex' ,'' , "metwo" )
    exports['br-menu']:AddButton("Bands" , "Exchange your bands!" ,'pawnshop:sellbands' ,'' , "methree" ) --pawnshop:sellcopper
    -- exports['br-menu']:AddButton("Electronics" , "Sell your Electronics" ,'pawnshop:sellelectronics' ,'' , "mefour" )
end)


RegisterNetEvent('dealerbuy')
AddEventHandler('dealerbuy', function()
    exports['br-menu']:SetTitle("Export Dealer")
    exports['br-menu']:AddButton("Carbine Rifle MKII" , "$30,000" ,'dealerbuy:cbmk2' ,'' , 'meone')
    exports['br-menu']:AddButton("Thermite" , "$2,500" ,'dealerbuy:thermite' ,'' , "metwo" )
    -- exports['br-menu']:AddButton("Copper" , "Sell your Copper" ,'pawnshop:sellcopper' ,'' , "methree" ) --pawnshop:sellcopper
    -- exports['br-menu']:AddButton("Electronics" , "Sell your Electronics" ,'pawnshop:sellelectronics' ,'' , "mefour" )
end)

RegisterNetEvent('lesterbuy')
AddEventHandler('lesterbuy', function()
    exports['br-menu']:SetTitle("Lester Inventory")
    exports['br-menu']:AddButton("Green Laptop" , "Exchange USB for Laptop" ,'lesterbuy:laptop' ,'' , 'meone')
    --exports['br-menu']:AddButton("Thermite" , "$2,500" ,'dealerbuy:thermite' ,'' , "metwo" )
    -- exports['br-menu']:AddButton("Copper" , "Sell your Copper" ,'pawnshop:sellcopper' ,'' , "methree" ) --pawnshop:sellcopper
    -- exports['br-menu']:AddButton("Electronics" , "Sell your Electronics" ,'pawnshop:sellelectronics' ,'' , "mefour" )
end)

RegisterNetEvent('tow:menu')
AddEventHandler('tow:menu', function()
    exports['br-menu']:SetTitle("Rent A Vehicle")
    exports['br-menu']:AddButton("Flatbed Tow Truck" , "$500" ,'towtruckRent' ,'' , 'meone')
end)

RegisterNetEvent('tow:duty')
AddEventHandler('tow:duty', function()
    exports['br-menu']:SetTitle("Tow Yard")
    exports['br-menu']:AddButton("Tow Mechanic" , "Toggle On/Off Duty" ,'duty:onoff' ,'' , 'meone')
end)



RegisterNetEvent('bikerent:menu')
AddEventHandler('bikerent:menu', function()
    exports['br-menu']:SetTitle("Rent A Bicycle")
    exports['br-menu']:AddButton("BMX" , "$25" ,'bmx' ,'' , 'meone')
    exports['br-menu']:AddButton("Cruiser" , "$30" ,'cruiser' ,'' , 'me2')
    exports['br-menu']:AddButton("Tribike" , "$40" ,'tribike' ,'' , 'me4')
    exports['br-menu']:AddButton("Tribike 2" , "$50" ,'tribike2' ,'' , 'me4')
end)

RegisterNetEvent('bikerent5:menu')
AddEventHandler('bikerent5:menu', function()
    exports['br-menu']:SetTitle("Rent A Bicycle")
    exports['br-menu']:AddButton("BMX" , "$25" ,'bmx5' ,'' , 'meone')
    exports['br-menu']:AddButton("Cruiser" , "$30" ,'cruiser5' ,'' , 'me2')
    exports['br-menu']:AddButton("Tribike" , "$40" ,'tribike5' ,'' , 'me3')
    exports['br-menu']:AddButton("Tribike 2" , "$50" ,'tribike25' ,'' , 'me4')
end)

-- plasma

-- Beach Rentals
RegisterNetEvent('beachrental:menu')
AddEventHandler('beachrental:menu', function()
    exports['br-menu']:SetTitle("Beach Rentals")
    exports['br-menu']:AddButton("Jetski" , "$500" ,'seashark' ,'' , 'meone')
    exports['br-menu']:AddButton("Dinghy" , "$1,000" ,'dinghy' ,'' , 'me2')
    exports['br-menu']:AddButton("Windsurf" , "$1,000" ,'windsurf' ,'' , 'me3')
    exports['br-menu']:AddButton("Squalo" , "$1,750" ,'squalo' ,'' , 'me4')
    exports['br-menu']:AddButton("Speeder" , "$2,500" ,'speeder' ,'' , 'me5')
    exports['br-menu']:AddButton("Dune Buggy" , "$4,500" ,'dune' ,'' , 'me6')
end)

-- Dirt Rentals
RegisterNetEvent('dirtrental:menu')
AddEventHandler('dirtrental:menu', function()
    exports['br-menu']:SetTitle("Dirt Rentals")
    exports['br-menu']:AddButton("Sanchez" , "$500" ,'sanchez' ,'' , 'meone')
    exports['br-menu']:AddButton("Blazer" , "$1,250" ,'blazer' ,'' , 'me2')
    exports['br-menu']:AddButton("Street Blazer" , "$1,750" ,'blazer4' ,'' , 'me3')
end)



-- Sonora Boats
RegisterNetEvent('sonoraboats:menu')
AddEventHandler('sonoraboats:menu', function()
    exports['br-menu']:SetTitle("Sonora Cartel Boats")
    exports['br-menu']:AddButton("Jetski" , "$500" ,'seashark' ,'' , 'meone')
end)




-- LS CUSTOMS
--[[ RegisterNetEvent('mechanic:crafting')
AddEventHandler('mechanic:crafting', function()
    exports['br-menu']:SetTitle("LS Customs Crafting")

    exports['br-menu']:AddButton("Iron" , "5 Scrap Metal" ,'craft:iron' ,'' , 'materials')
    exports['br-menu']:AddButton("Nuts & Bolts" , "1 Scrap Metal" ,'craft:nutsandbolts' ,'' , 'materials')
    exports['br-menu']:SubMenu("Materials" , "General Materials" , "materials" )

    exports['br-menu']:AddButton("Piston" , "1 Iron" ,'craft:piston' ,'' , 'parts')
    exports['br-menu']:AddButton("Crankshaft" , "2 Iron" ,'craft:crankshaft' ,'' , 'parts')
    exports['br-menu']:AddButton("Engine Block" , "3 Iton" ,'craft:block' ,'' , 'parts')
    exports['br-menu']:AddButton("Aluminum Engine Block" , "10 Aluminum" ,'craft:aluminumblock' ,'' , 'parts')
    exports['br-menu']:AddButton("Engine Head" , "1 Iron" ,'craft:head' ,'' , 'parts')
    exports['br-menu']:AddButton("High Flow Engine Head" , "2 Iron" ,'craft:highflowhead' ,'' , 'parts')
    exports['br-menu']:AddButton("Spring" , "1 Iron" ,'craft:spring' ,'' , 'parts')
    exports['br-menu']:AddButton("Lowering Spring" , "1 Iron" ,'craft:loweringspring' ,'' , 'parts')
    exports['br-menu']:AddButton("Strut" , "1 Iron" ,'craft:strut' ,'' , 'parts')
    exports['br-menu']:AddButton("Race Strut" , "2 Iron" ,'craft:racestrut' ,'' , 'parts')
    exports['br-menu']:AddButton("Brake Pad" , "1 Iron" ,'craft:brakepad' ,'' , 'parts')
    exports['br-menu']:AddButton("Race Brake Pad" , "2 Iron" ,'craft:racebrakepad' ,'' , 'parts')
    exports['br-menu']:AddButton("Rotor" , "2 Iron" ,'craft:rotor' ,'' , 'parts')
    exports['br-menu']:AddButton("Race Rotor" , "3 Iron" ,'craft:racerotor' ,'' , 'parts')
    exports['br-menu']:AddButton("Transmission Gear" , "1 Iron" ,'craft:transmissiongear' ,'' , 'parts')
    exports['br-menu']:SubMenu("Parts" , "General Parts" , "parts" )

    exports['br-menu']:AddButton("Single Turbo" , "5 Iron" ,'craft:singleturbo' ,'' , 'turbos')
    exports['br-menu']:AddButton("Upgraded Turbo" , "7 Iron" ,'craft:bigsingleturbo' ,'' , 'turbos')
    exports['br-menu']:AddButton("Twin Turbo" , "10 Iron" ,'craft:twinturbo' ,'' , 'turbos')
    exports['br-menu']:AddButton("Race Twin Turbo" , "12 Iron" ,'craft:racetwinturbo' ,'' , 'turbos')
    exports['br-menu']:SubMenu("Turbos" , "Turbo Options" , "turbos" )
    
    exports['br-menu']:AddButton("10 Shot" , "CraftingRecipeDescription" ,'craft:' ,'' , 'nos')
    exports['br-menu']:SubMenu("NOS" , "Nitrous Options" , "nos" )

    exports['br-menu']:AddButton("OEM Transmission" , "5 Gears | 1 Stock Oil" ,'craft:stocktransmission' ,'' , 'transmissions')
    exports['br-menu']:AddButton("Street Transmission (RWD)" , "5 Gears | 1 Shell Oil" ,'craft:streettransmissionrwd' ,'' , 'transmissions')
    exports['br-menu']:AddButton("Street Transmission (AWD)" , "5 Gears | 1 Shell Oil" ,'craft:streettransmissionawd' ,'' , 'transmissions')
    exports['br-menu']:AddButton("Street Transmission (FWD)" , "5 Gears | 1 Shell Oil" ,'craft:streettransmissionfwd' ,'' , 'transmissions')
    exports['br-menu']:AddButton("Race Transmission (RWD)" , "6 Gears | 1 Amsoil" ,'craft:racetransmissionrwd' ,'' , 'transmissions')
    exports['br-menu']:AddButton("Race Transmission (AWD)" , "6 Gears | 1 Amsoil" ,'craft:racetransmissionrwd' ,'' , 'transmissions')
    exports['br-menu']:AddButton("Race Transmission (FWD)" , "6 Gears | 1 Amsoil" ,'craft:racetransmissionrwd' ,'' , 'transmissions')
    exports['br-menu']:SubMenu("Transmissions" , "Trans Options" , "transmissions" )


    exports['br-menu']:AddButton("OEM Suspension" , "4 Springs | 4 Struts" ,'craft:stocksuspension' ,'' , 'suspension')
    exports['br-menu']:AddButton("Lowering Springs" , "4 Lowering Springs | 4 Struts" ,'craft:loweringsprings' ,'' , 'suspension')
    exports['br-menu']:AddButton("Coil Overs" , "4 Springs | 4 Race Struts" ,'craft:coilovers' ,'' , 'suspension')
    exports['br-menu']:AddButton("Race Coil Overs" , "4 Lowering Springs | 4 Race Struts" ,'craft:racecoilovers' ,'' , 'suspension')
    exports['br-menu']:AddButton("Stanced Coil Overs" , "4 Lowering Springs | 4 Race Struts" ,'craft:stancedcoilovers' ,'' , 'suspension')
    exports['br-menu']:AddButton("Lifted Coil Overs" , "4 Springs | 4 Race Struts" ,'craft:liftedsuspension' ,'' , 'suspension')
    exports['br-menu']:SubMenu("Suspension" , "Suspension Options" , "suspension" )

    exports['br-menu']:AddButton("OEM Oil x2" , "1 Iron" ,'craft:stockoil' ,'' , 'oil')
    exports['br-menu']:AddButton("Shell" , "1 Iron" ,'craft:shelloil' ,'' , 'oil')
    exports['br-menu']:AddButton("Mobile 1" , "2 Iron" ,'craft:mobile1' ,'' , 'oil')
    exports['br-menu']:AddButton("Amsoil" , "4 Iron" ,'craft:amsoil' ,'' , 'oil')
    exports['br-menu']:AddButton("Royal Purple" , "3 Iron" ,'craft:royalpurple' ,'' , 'oil')
    exports['br-menu']:SubMenu("Oil" , "Oil Options" , "oil" )

    exports['br-menu']:AddButton("OEM Engine" , "4 Pistons | 1 Crankshaft | 1 Block | 1 Head" ,'craft:stockengine' ,'' , 'engines')
    exports['br-menu']:AddButton("Honda K20" , "CraftingRecipeDescription" ,'craft:' ,'' , 'engines')
    exports['br-menu']:AddButton("AMG V8" , "8 Pistons | 1 Crankshaft | 1 Block | 2 HF Heads" ,'craft:amgv8' ,'' , 'engines')
    exports['br-menu']:AddButton("Toyota 2JZ" , "6 Pistons | 1 Crankshaft | 1 Block | 1 HF Head" ,'craft:2jz' ,'' , 'engines')
    exports['br-menu']:AddButton("Nissan RB 26" , "CraftingRecipeDescription" ,'craft:' ,'' , 'engines')
    exports['br-menu']:AddButton("Chevy LT5 S/C" , "CraftingRecipeDescription" ,'craft:' ,'' , 'engines')
    exports['br-menu']:AddButton("Mazda 13b" , "CraftingRecipeDescription" ,'craft:' ,'' , 'engines')
    exports['br-menu']:AddButton("Full Bolt On" , "6 Pistons | 1 Crankshaft | 1 Block | 2 Heads" ,'craft:fullboltonengine' ,'' , 'engines')
    exports['br-menu']:AddButton("Tuned OEM" , "6 Pistons | 1 Crankshaft | 1 Block | 2 HF Heads" ,'craft:' ,'' , 'engines')
    exports['br-menu']:AddButton("Lambo V10" , "10 Pistons | 1 Crankshaft | 1 Block | 2 HF Heads" ,'craft:' ,'' , 'engines')
    exports['br-menu']:SubMenu("Engines" , "Engine Options" , "engines" )

    exports['br-menu']:AddButton("OEM Tires" , "8 Rubber" ,'craft:stocktires' ,'' , 'tires')
    exports['br-menu']:AddButton("Michelin" , "10 Rubber" ,'craft:michelintires' ,'' , 'tires')
    exports['br-menu']:AddButton("Pirelli" , "12 Rubber" ,'craft:pirellitires' ,'' , 'tires')
    exports['br-menu']:AddButton("Hankook" , "15 Rubber" ,'craft:hankooktires' ,'' , 'tires')
    exports['br-menu']:AddButton("Dunlop" , "10 Rubber" ,'craft:dunloptires' ,'' , 'tires')
    exports['br-menu']:AddButton("Falken" , "8 Rubber" ,'craft:falkentires' ,'' , 'tires')
    exports['br-menu']:AddButton("Nitto" , "18 Rubber" ,'craft:nittotires' ,'' , 'tires')
    exports['br-menu']:SubMenu("Tires" , "Tire Options" , "tires" )

    exports['br-menu']:AddButton("OEM Brakes" , "4 Rotors | 8 Brake Pads" ,'craft:stockbrakes' ,'' , 'brakes')
    exports['br-menu']:AddButton("Upgraded Brakes" , "4 Rotors | 8 Race Brake Pads" ,'craft:upgradedbrakepads' ,'' , 'brakes')
    exports['br-menu']:AddButton("Brembo" , "4 Race Rotors | 8 Race Brake Pads" ,'craft:brembobrakes' ,'' , 'brakes')
    exports['br-menu']:AddButton("Wilwood" , "4 Race Rotors | 8 Race Brake Pads" ,'craft:wilwoodbrakes' ,'' , 'brakes')
    exports['br-menu']:SubMenu("Brakes" , "Brake Options" , "brakes" )

    exports['br-menu']:AddButton("OEM Sparkplugs" , "2 Iron" ,'craft:stocksparkplugs' ,'' , 'sparkplugs')
    exports['br-menu']:AddButton("NGK" , "4 Iron" ,'craft:ngksparkplugs' ,'' , 'sparkplugs')
    exports['br-menu']:AddButton("Champion" , "3 Iron" ,'craft:championsparkplugs' ,'' , 'sparkplugs')
    exports['br-menu']:SubMenu("Sparkplugs" , "Sparkplug Options" , "sparkplugs" )
end) ]]