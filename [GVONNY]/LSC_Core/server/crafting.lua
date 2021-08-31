ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

--############################
--##       CORE PARTS       ##
--############################

RegisterServerEvent('craft:iron')
AddEventHandler('craft:iron', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapCount = xPlayer.getInventoryItem('scrapmetal').count

    if scrapCount > 1 then
        xPlayer.removeInventoryItem('scrapmetal', 2)
        xPlayer.addInventoryItem('iron', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough scrap metal", })
    end
end)

RegisterServerEvent('craft:rubber')
AddEventHandler('craft:rubber', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapCount = xPlayer.getInventoryItem('cartire').count

    if scrapCount > 0 then
        xPlayer.removeInventoryItem('cartire', 1)
        xPlayer.addInventoryItem('rubber', 5)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have a car tire", })
    end
end)

RegisterServerEvent('craft:piston')
AddEventHandler('craft:piston', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 0 then
        xPlayer.removeInventoryItem('iron', 1)
        xPlayer.addInventoryItem('piston', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:oil')
AddEventHandler('craft:oil', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 3 then
        xPlayer.removeInventoryItem('iron', 4)
        xPlayer.addInventoryItem('oil', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:transmissionoil')
AddEventHandler('craft:transmissionoil', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 5 then
        xPlayer.removeInventoryItem('iron', 6)
        xPlayer.addInventoryItem('transmission_oil', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:clutch')
AddEventHandler('craft:clutch', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 7 then
        xPlayer.removeInventoryItem('iron', 8)
        xPlayer.addInventoryItem('clutch', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:airfilter')
AddEventHandler('craft:airfilter', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 2 then
        xPlayer.removeInventoryItem('iron', 3)
        xPlayer.addInventoryItem('air_filter', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:sparkplugs')
AddEventHandler('craft:sparkplugs', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 5 then
        xPlayer.removeInventoryItem('iron', 6)
        xPlayer.addInventoryItem('spark_plugs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:serpentinebelt')
AddEventHandler('craft:serpentinebelt', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('rubber').count

    if itemCount > 6 then
        xPlayer.removeInventoryItem('iron', 7)
        xPlayer.addInventoryItem('serpentine_belt', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough rubber", })
    end
end)

RegisterServerEvent('craft:nitrous')
AddEventHandler('craft:nitrous', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 9 then
        xPlayer.removeInventoryItem('iron', 10)
        xPlayer.addInventoryItem('nitrous', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:fuelfilter')
AddEventHandler('craft:fuelfilter', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 4 then
        xPlayer.removeInventoryItem('iron', 5)
        xPlayer.addInventoryItem('fuel_filter', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:crankshaft')
AddEventHandler('craft:crankshaft', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('crankshaft', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:block')
AddEventHandler('craft:block', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 0 then
        xPlayer.removeInventoryItem('iron', 3)
        xPlayer.addInventoryItem('engine_block', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:aluminumblock')
AddEventHandler('craft:aluminumblock', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('aluminum').count

    if itemCount > 0 then
        xPlayer.removeInventoryItem('aluminum', 10)
        xPlayer.addInventoryItem('aluminum_engine_block', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough aluminum", })
    end
end)

RegisterServerEvent('craft:highflowhead')
AddEventHandler('craft:highflowhead', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('high_flow_head', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:head')
AddEventHandler('craft:head', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 0 then
        xPlayer.removeInventoryItem('iron', 1)
        xPlayer.addInventoryItem('head', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:spring')
AddEventHandler('craft:spring', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('spring', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:loweringspring')
AddEventHandler('craft:loweringspring', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 0 then
        xPlayer.removeInventoryItem('iron', 1)
        xPlayer.addInventoryItem('lowering_spring', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:strut')
AddEventHandler('craft:strut', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 2 then
        xPlayer.removeInventoryItem('iron', 3)
        xPlayer.addInventoryItem('strut', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:racestrut')
AddEventHandler('craft:racestrut', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('race_strut', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:nutsandbolts')
AddEventHandler('craft:nutsandbolts', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('scrapmetal').count

    if itemCount > 0 then
        xPlayer.removeInventoryItem('scrapmetal', 1)
        xPlayer.addInventoryItem('nuts_and_bolts', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough scrap metal", })
    end
end)

RegisterServerEvent('craft:brakepad')
AddEventHandler('craft:brakepad', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 0 then
        xPlayer.removeInventoryItem('iron', 1)
        xPlayer.addInventoryItem('brake_pad', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:racebrakepad')
AddEventHandler('craft:racebrakepad', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('race_brake_pad', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:rotor')
AddEventHandler('craft:rotor', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 3 then
        xPlayer.removeInventoryItem('iron', 4)
        xPlayer.addInventoryItem('rotor', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:racerotor')
AddEventHandler('craft:racerotor', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 2 then
        xPlayer.removeInventoryItem('iron', 3)
        xPlayer.addInventoryItem('race_rotor', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:transmissiongear')
AddEventHandler('craft:transmissiongear', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('transmission_gear', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

--############################
--##       SUSPENSION       ##
--############################
RegisterServerEvent('craft:stocksuspension')
AddEventHandler('craft:stocksuspension', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local springCount = xPlayer.getInventoryItem('spring').count
    local strutCount = xPlayer.getInventoryItem('strut').count

    if (springCount > 3 and strutCount > 3) then
        xPlayer.removeInventoryItem('spring', 4)
        xPlayer.removeInventoryItem('strut', 4)
        xPlayer.addInventoryItem('stock_suspension', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:loweringsprings')
AddEventHandler('craft:loweringsprings', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local springCount = xPlayer.getInventoryItem('lowering_spring').count
    local strutCount = xPlayer.getInventoryItem('strut').count

    if (springCount > 3 and strutCount > 3) then
        xPlayer.removeInventoryItem('lowering_spring', 4)
        xPlayer.removeInventoryItem('strut', 4)
        xPlayer.addInventoryItem('lowering_springs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:coilovers')
AddEventHandler('craft:coilovers', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local springCount = xPlayer.getInventoryItem('spring').count
    local strutCount = xPlayer.getInventoryItem('race_strut').count

    if (springCount > 3 and strutCount > 3) then
        xPlayer.removeInventoryItem('spring', 4)
        xPlayer.removeInventoryItem('race_strut', 4)
        xPlayer.addInventoryItem('coil_overs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:racecoilovers')
AddEventHandler('craft:racecoilovers', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local springCount = xPlayer.getInventoryItem('lowering_spring').count
    local strutCount = xPlayer.getInventoryItem('race_strut').count

    if (springCount > 3 and strutCount > 3) then
        xPlayer.removeInventoryItem('lowering_spring', 4)
        xPlayer.removeInventoryItem('race_strut', 4)
        xPlayer.addInventoryItem('race_coil_overs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:stancedcoilovers')
AddEventHandler('craft:stancedcoilovers', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local springCount = xPlayer.getInventoryItem('lowering_spring').count
    local strutCount = xPlayer.getInventoryItem('race_strut').count

    if (springCount > 3 and strutCount > 3) then
        xPlayer.removeInventoryItem('lowering_spring', 4)
        xPlayer.removeInventoryItem('race_strut', 4)
        xPlayer.addInventoryItem('stanced_coil_overs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:liftedcoilovers')
AddEventHandler('craft:liftedcoilovers', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local springCount = xPlayer.getInventoryItem('spring').count
    local strutCount = xPlayer.getInventoryItem('race_strut').count

    if (springCount > 3 and strutCount > 3) then
        xPlayer.removeInventoryItem('spring', 4)
        xPlayer.removeInventoryItem('race_strut', 4)
        xPlayer.addInventoryItem('lifted_coil_overs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:liftedcoilovers2')
AddEventHandler('craft:liftedcoilovers2', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local springCount = xPlayer.getInventoryItem('spring').count
    local strutCount = xPlayer.getInventoryItem('race_strut').count

    if (springCount > 3 and strutCount > 3) then
        xPlayer.removeInventoryItem('spring', 4)
        xPlayer.removeInventoryItem('race_strut', 4)
        xPlayer.addInventoryItem('lifted_coil_overs2', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)


--############################
--##        ENGINES         ##
--############################
RegisterServerEvent('craft:stockengine')
AddEventHandler('craft:stockengine', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('head').count

    if (pistonCount > 3 and crankshaftCount > 0 and blockCount > 0 and headCount > 0) then
        xPlayer.removeInventoryItem('piston', 4)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('head', 1)
        xPlayer.addInventoryItem('stock_engine', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:fullboltonengine')
AddEventHandler('craft:fullboltonengine', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('head').count

    if (pistonCount > 5 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 6)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('head', 2)
        xPlayer.addInventoryItem('full_bolt_on_engine', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:tunedengine')
AddEventHandler('craft:tunedengine', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('high_flow_head').count

    if (pistonCount > 5 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 6)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('high_flow_head', 2)
        xPlayer.addInventoryItem('tuned_engine', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:2jz')
AddEventHandler('craft:2jz', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('high_flow_head').count

    if (pistonCount > 5 and crankshaftCount > 0 and blockCount > 0 and headCount > 0) then
        xPlayer.removeInventoryItem('piston', 6)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('high_flow_head', 1)
        xPlayer.addInventoryItem('2jzengine', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:amgv8')
AddEventHandler('craft:amgv8', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('high_flow_head').count

    if (pistonCount > 7 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 8)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('high_flow_head', 2)
        xPlayer.addInventoryItem('amgv8', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:lambov10')
AddEventHandler('craft:lambov10', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('high_flow_head').count

    if (pistonCount > 9 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 10)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('high_flow_head', 2)
        xPlayer.addInventoryItem('lambov10', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:policeengine')
AddEventHandler('craft:policeengine', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('head').count

    if (pistonCount > 5 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 6)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('head', 2)
        xPlayer.addInventoryItem('police_engine', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:rb26')
AddEventHandler('craft:rb26', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('head').count

    if (pistonCount > 5 and crankshaftCount > 0 and blockCount > 0 and headCount > 0) then
        xPlayer.removeInventoryItem('piston', 6)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('head', 1)
        xPlayer.addInventoryItem('rb26', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:chevylt5')
AddEventHandler('craft:chevylt5', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('head').count

    if (pistonCount > 7 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 8)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('head', 2)
        xPlayer.addInventoryItem('chevylt5', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:gt3flat6')
AddEventHandler('craft:gt3flat6', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('aluminum_engine_block').count
    local headCount = xPlayer.getInventoryItem('high_flow_head').count

    if (pistonCount > 5 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 6)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('aluminum_engine_block', 1)
        xPlayer.removeInventoryItem('high_flow_head', 2)
        xPlayer.addInventoryItem('gt3flat6', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:k20')
AddEventHandler('craft:k20', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('high_flow_head').count

    if (pistonCount > 3 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 4)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('aluminum_engine_block', 1)
        xPlayer.removeInventoryItem('high_flow_head', 1)
        xPlayer.addInventoryItem('k20a', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:musv8')
AddEventHandler('craft:musv8', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local pistonCount = xPlayer.getInventoryItem('piston').count
    local crankshaftCount = xPlayer.getInventoryItem('crankshaft').count
    local blockCount = xPlayer.getInventoryItem('engine_block').count
    local headCount = xPlayer.getInventoryItem('head').count

    if (pistonCount > 7 and crankshaftCount > 0 and blockCount > 0 and headCount > 1) then
        xPlayer.removeInventoryItem('piston', 8)
        xPlayer.removeInventoryItem('crankshaft', 1)
        xPlayer.removeInventoryItem('engine_block', 1)
        xPlayer.removeInventoryItem('head', 2)
        xPlayer.addInventoryItem('musv8', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)



--############################
--##       SUSPENSION       ##
--############################

RegisterServerEvent('craft:stockbrakes')
AddEventHandler('craft:stockbrakes', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rotorCount = xPlayer.getInventoryItem('rotor').count
    local padCount = xPlayer.getInventoryItem('brake_pad').count

    if (rotorCount > 3 and padCount > 7) then
        xPlayer.removeInventoryItem('rotor', 4)
        xPlayer.removeInventoryItem('brake_pad', 8)
        xPlayer.addInventoryItem('stock_brakes', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:upgradedbrakepads')
AddEventHandler('craft:upgradedbrakepads', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rotorCount = xPlayer.getInventoryItem('rotor').count
    local padCount = xPlayer.getInventoryItem('race_brake_pad').count

    if (rotorCount > 3 and padCount > 7) then
        xPlayer.removeInventoryItem('rotor', 4)
        xPlayer.removeInventoryItem('race_brake_pad', 8)
        xPlayer.addInventoryItem('upgraded_brake_pads', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:brembobrakes')
AddEventHandler('craft:brembobrakes', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rotorCount = xPlayer.getInventoryItem('race_rotor').count
    local padCount = xPlayer.getInventoryItem('race_brake_pad').count

    if (rotorCount > 3 and padCount > 7) then
        xPlayer.removeInventoryItem('race_rotor', 4)
        xPlayer.removeInventoryItem('race_brake_pad', 8)
        xPlayer.addInventoryItem('brembo_brakes', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:wilwoodbrakes')
AddEventHandler('craft:wilwoodbrakes', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rotorCount = xPlayer.getInventoryItem('race_rotor').count
    local padCount = xPlayer.getInventoryItem('race_brake_pad').count

    if (rotorCount > 3 and padCount > 7) then
        xPlayer.removeInventoryItem('race_rotor', 4)
        xPlayer.removeInventoryItem('race_brake_pad', 8)
        xPlayer.addInventoryItem('wilwood_brakes', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

--############################
--##         TIRES         ##
--############################

RegisterServerEvent('craft:stocktires')
AddEventHandler('craft:stocktires', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rubberCount = xPlayer.getInventoryItem('rubber').count

    if rubberCount > 7  then
        xPlayer.removeInventoryItem('rubber', 8)
        xPlayer.addInventoryItem('stock_tires', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough rubber", })
    end
end)

RegisterServerEvent('craft:pirellitires')
AddEventHandler('craft:pirellitires', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rubberCount = xPlayer.getInventoryItem('rubber').count

    if rubberCount > 11  then
        xPlayer.removeInventoryItem('rubber', 12)
        xPlayer.addInventoryItem('pirelli_tires', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough rubber", })
    end
end)

RegisterServerEvent('craft:michelintires')
AddEventHandler('craft:michelintires', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rubberCount = xPlayer.getInventoryItem('rubber').count

    if rubberCount > 9  then
        xPlayer.removeInventoryItem('rubber', 10)
        xPlayer.addInventoryItem('michelin_tires', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough rubber", })
    end
end)

RegisterServerEvent('craft:nittotires')
AddEventHandler('craft:nittotires', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rubberCount = xPlayer.getInventoryItem('rubber').count

    if rubberCount > 17  then
        xPlayer.removeInventoryItem('rubber', 18)
        xPlayer.addInventoryItem('nitto_tires', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough rubber", })
    end
end)

RegisterServerEvent('craft:hankooktires')
AddEventHandler('craft:handkooktires', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rubberCount = xPlayer.getInventoryItem('rubber').count

    if rubberCount > 14  then
        xPlayer.removeInventoryItem('rubber', 15)
        xPlayer.addInventoryItem('hankook_tires', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough rubber", })
    end
end)

RegisterServerEvent('craft:falkentires')
AddEventHandler('craft:falkentires', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rubberCount = xPlayer.getInventoryItem('rubber').count

    if rubberCount > 7  then
        xPlayer.removeInventoryItem('rubber', 8)
        xPlayer.addInventoryItem('falken_tires', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough rubber", })
    end
end)

RegisterServerEvent('craft:dunloptires')
AddEventHandler('craft:dunloptires', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local rubberCount = xPlayer.getInventoryItem('rubber').count

    if rubberCount > 7  then
        xPlayer.removeInventoryItem('rubber', 8)
        xPlayer.addInventoryItem('dunlop_tires', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough rubber", })
    end
end)

--############################
--##         TURBOS         ##
--############################

RegisterServerEvent('craft:singleturbo')
AddEventHandler('craft:singleturbo', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 4  then
        xPlayer.removeInventoryItem('iron', 5)
        xPlayer.addInventoryItem('single_turbo', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:bigsingleturbo')
AddEventHandler('craft:bigsingleturbo', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 6  then
        xPlayer.removeInventoryItem('iron', 7)
        xPlayer.addInventoryItem('big_single_turbo', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:twinturbo')
AddEventHandler('craft:twinturbo', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 9  then
        xPlayer.removeInventoryItem('iron', 10)
        xPlayer.addInventoryItem('twin_turbo', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:racetwinturbo')
AddEventHandler('craft:racetwinturbo', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 11  then
        xPlayer.removeInventoryItem('iron', 12)
        xPlayer.addInventoryItem('race_twin_turbo', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

--###########################
--##     TRANSMISSIONS     ##
--###########################

RegisterServerEvent('craft:stocktransmission')
AddEventHandler('craft:stocktransmission', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local gearCount = xPlayer.getInventoryItem('transmission_gear').count
    local oilCount = xPlayer.getInventoryItem('stock_oil').count

    if (gearCount > 4 and oilCount > 0) then
        xPlayer.removeInventoryItem('transmission_gear', 5)
        xPlayer.removeInventoryItem('stock_oil', 1)
        xPlayer.addInventoryItem('stock_transmission', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:streettransmissionfwd')
AddEventHandler('craft:streettransmissionfwd', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local gearCount = xPlayer.getInventoryItem('transmission_gear').count
    local oilCount = xPlayer.getInventoryItem('shell_oil').count

    if (gearCount > 4 and oilCount > 1) then
        xPlayer.removeInventoryItem('transmission_gear', 5)
        xPlayer.removeInventoryItem('stock_oil', 2)
        xPlayer.addInventoryItem('street_transmission_fwd', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:streettransmission4wd')
AddEventHandler('craft:streettransmission4wd', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local gearCount = xPlayer.getInventoryItem('transmission_gear').count
    local oilCount = xPlayer.getInventoryItem('shell_oil').count

    if (gearCount > 4 and oilCount > 1) then
        xPlayer.removeInventoryItem('transmission_gear', 5)
        xPlayer.removeInventoryItem('stock_oil', 2)
        xPlayer.addInventoryItem('street_transmission_4wd', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:streettransmissionrwd')
AddEventHandler('craft:streettransmissionrwd', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local gearCount = xPlayer.getInventoryItem('transmission_gear').count
    local oilCount = xPlayer.getInventoryItem('shell_oil').count

    if (gearCount > 4 and oilCount > 1) then
        xPlayer.removeInventoryItem('transmission_gear', 5)
        xPlayer.removeInventoryItem('stock_oil', 2)
        xPlayer.addInventoryItem('street_transmission', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:racetransmissionfwd')
AddEventHandler('craft:racetransmissionfwd', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local gearCount = xPlayer.getInventoryItem('transmission_gear').count
    local oilCount = xPlayer.getInventoryItem('amsoil_oil').count

    if (gearCount > 5 and oilCount > 2) then
        xPlayer.removeInventoryItem('transmission_gear', 6)
        xPlayer.removeInventoryItem('stock_oil', 3)
        xPlayer.addInventoryItem('race_transmission_fwd', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:racetransmission4wd')
AddEventHandler('craft:racetransmission4wd', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local gearCount = xPlayer.getInventoryItem('transmission_gear').count
    local oilCount = xPlayer.getInventoryItem('amsoil_oil').count

    if (gearCount > 5 and oilCount > 2) then
        xPlayer.removeInventoryItem('transmission_gear', 6)
        xPlayer.removeInventoryItem('stock_oil', 3)
        xPlayer.addInventoryItem('race_transmission_4wd', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:racetransmissionrwd')
AddEventHandler('craft:racetransmissionrwd', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local gearCount = xPlayer.getInventoryItem('transmission_gear').count
    local oilCount = xPlayer.getInventoryItem('amsoil_oil').count

    if (gearCount > 5 and oilCount > 2) then
        xPlayer.removeInventoryItem('transmission_gear', 6)
        xPlayer.removeInventoryItem('stock_oil', 3)
        xPlayer.addInventoryItem('race_transmission', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

RegisterServerEvent('craft:policetransmission')
AddEventHandler('craft:policetransmission', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local gearCount = xPlayer.getInventoryItem('transmission_gear').count
    local oilCount = xPlayer.getInventoryItem('shell_oil').count

    if (gearCount > 4 and oilCount > 0) then
        xPlayer.removeInventoryItem('transmission_gear', 5)
        xPlayer.removeInventoryItem('stock_oil', 1)
        xPlayer.addInventoryItem('police_transmission', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have all the parts to craft this item", })
    end
end)

--###########################
--##          OIL          ##
--###########################

RegisterServerEvent('craft:stockoil')
AddEventHandler('craft:stockoil', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 0 then
        xPlayer.removeInventoryItem('iron', 1)
        xPlayer.addInventoryItem('stock_oil', 2)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:shelloil')
AddEventHandler('craft:shelloil', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 0 then
        xPlayer.removeInventoryItem('iron', 1)
        xPlayer.addInventoryItem('shell_oil', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:mobile1')
AddEventHandler('craft:mobile1', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('mobile1_oil', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:amsoil')
AddEventHandler('craft:amsoil', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 3 then
        xPlayer.removeInventoryItem('iron', 4)
        xPlayer.addInventoryItem('amsoil_oil', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:royalpurple')
AddEventHandler('craft:royalpurple', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 2 then
        xPlayer.removeInventoryItem('iron', 3)
        xPlayer.addInventoryItem('royal_purple_oil', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

--############################
--##       SPARKPLUGS       ##
--############################

RegisterServerEvent('craft:stocksparkplugs')
AddEventHandler('craft:stocksparkplugs', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('stock_sparkplugs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:ngksparkplugs')
AddEventHandler('craft:ngksparkplugs', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 3 then
        xPlayer.removeInventoryItem('iron', 4)
        xPlayer.addInventoryItem('ngk_sparkplugs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:championsparkplugs')
AddEventHandler('craft:championsparkplugs', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 2 then
        xPlayer.removeInventoryItem('iron', 3)
        xPlayer.addInventoryItem('champion_sparkplugs', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:toolbox')
AddEventHandler('craft:toolbox', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 1 then
        xPlayer.removeInventoryItem('iron', 2)
        xPlayer.addInventoryItem('toolbox', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:mechanictools')
AddEventHandler('craft:mechanictools', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 2 then
        xPlayer.removeInventoryItem('iron', 3)
        xPlayer.addInventoryItem('mechanic_tools', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:advancedlockpick')
AddEventHandler('craft:advancedlockpick', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local ironCount = xPlayer.getInventoryItem('iron').count

    if ironCount > 4 then
        xPlayer.removeInventoryItem('iron', 5)
        xPlayer.addInventoryItem('advancedlockpick', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:nos')
AddEventHandler('craft:nos', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 9 then
        xPlayer.removeInventoryItem('iron', 10)
        xPlayer.addInventoryItem('nos', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:nos2')
AddEventHandler('craft:nos2', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 6 then
        xPlayer.removeInventoryItem('iron', 7)
        xPlayer.addInventoryItem('nos2', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)

RegisterServerEvent('craft:nos3')
AddEventHandler('craft:nos3', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem('iron').count

    if itemCount > 3 then
        xPlayer.removeInventoryItem('iron', 4)
        xPlayer.addInventoryItem('nos3', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You do not have enough iron", })
    end
end)