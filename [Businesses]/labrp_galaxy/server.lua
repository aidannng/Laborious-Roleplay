ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('galaxy:vodka')
AddEventHandler('galaxy:vodka', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local vodka = xPlayer.getInventoryItem('vodka').count
    
    if vodka >= 1 then
        xPlayer.addInventoryItem('spacevodka', 1)
        xPlayer.removeInventoryItem('vodka', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made Space Vodka!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:whiskey')
AddEventHandler('galaxy:whiskey', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ice = xPlayer.getInventoryItem('ice').count
    local whiskey = xPlayer.getInventoryItem('whiskey').count
    
    if ice and whiskey >= 1 then
        xPlayer.addInventoryItem('multiversalwhiskey', 1)
        xPlayer.removeInventoryItem('ice', 1)
        xPlayer.removeInventoryItem('whiskey', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made Multiversal Whiskey!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:cocktail1')
AddEventHandler('galaxy:cocktail1', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ice = xPlayer.getInventoryItem('ice').count
    local vodka = xPlayer.getInventoryItem('vodka').count
    local mixer = xPlayer.getInventoryItem('orangemixer').count
    local shaker = xPlayer.getInventoryItem('shaker').count
    
    if ice and mixer and vodka and shaker >= 1 then
        xPlayer.addInventoryItem('sourblast', 1)
        xPlayer.removeInventoryItem('ice', 1)
        xPlayer.removeInventoryItem('vodka', 1)
        xPlayer.removeInventoryItem('orangemixer', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made a Sour Blast Cocktail!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:cocktail2')
AddEventHandler('galaxy:cocktail2', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ice = xPlayer.getInventoryItem('ice').count
    local vodka = xPlayer.getInventoryItem('vodka').count
    local mixer = xPlayer.getInventoryItem('bluemixer').count
    local shaker = xPlayer.getInventoryItem('shaker').count
    
    if ice and mixer and vodka and shaker >= 1 then
        xPlayer.addInventoryItem('bluesensation', 1)
        xPlayer.removeInventoryItem('ice', 1)
        xPlayer.removeInventoryItem('vodka', 1)
        xPlayer.removeInventoryItem('bluemixer', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made a Blue Sensation Cocktail!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:cocktail3')
AddEventHandler('galaxy:cocktail3', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ice = xPlayer.getInventoryItem('ice').count
    local vodka = xPlayer.getInventoryItem('vodka').count
    local mixer = xPlayer.getInventoryItem('redmixer').count
    local shaker = xPlayer.getInventoryItem('shaker').count
    
    if ice and mixer and vodka and shaker >= 1 then
        xPlayer.addInventoryItem('eliptical', 1)
        xPlayer.removeInventoryItem('ice', 1)
        xPlayer.removeInventoryItem('vodka', 1)
        xPlayer.removeInventoryItem('redmixer', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made The Eliptical Cocktail!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:wine')
AddEventHandler('galaxy:wine', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local wine = xPlayer.getInventoryItem('wine').count
    
    if wine >= 1 then
        xPlayer.addInventoryItem('starwine', 1)
        xPlayer.removeInventoryItem('wine', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made Star Wine!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:beer')
AddEventHandler('galaxy:beer', function()
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.addInventoryItem('worldlybeer', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Worldly Beer!', length = 10000})
end)

RegisterServerEvent('galaxy:soda')
AddEventHandler('galaxy:soda', function()
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.addInventoryItem('cosmicsoda', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Cosmic Soda!', length = 10000})
end)

RegisterServerEvent('galaxy:burger')
AddEventHandler('galaxy:burger', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local beef = xPlayer.getInventoryItem('beef').count
    local cheese = xPlayer.getInventoryItem('cheese').count
    local bun = xPlayer.getInventoryItem('bun').count
    
    if beef and cheese and bun >= 1 then
        xPlayer.addInventoryItem('galaxyburger', 1)
        xPlayer.removeInventoryItem('beef', 1)
        xPlayer.removeInventoryItem('cheese', 1)
        xPlayer.removeInventoryItem('bun', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made a Galaxy Burger!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:fries')
AddEventHandler('galaxy:fries', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local potato = xPlayer.getInventoryItem('potato').count
    
    if potato >= 1 then
        xPlayer.addInventoryItem('solarfries', 1)
        xPlayer.removeInventoryItem('potato', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made Solar Fries!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:wings')
AddEventHandler('galaxy:wings', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local wings = xPlayer.getInventoryItem('wings').count

    if wings >= 1 then
        xPlayer.addInventoryItem('universalwings', 1)
        xPlayer.removeInventoryItem('wings', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have made Universal Wings!', length = 10000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You do not have the required items.', length = 5000})
    end
end)

RegisterServerEvent('galaxy:takeshaker')
AddEventHandler('galaxy:takeshaker', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('shaker', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Shaker!', length = 10000})
end)

RegisterServerEvent('galaxy:giveice')
AddEventHandler('galaxy:giveice', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('ice', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken Ice!', length = 10000})
end)


RegisterServerEvent('galaxy:mixer1')
AddEventHandler('galaxy:mixer1', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('orangemixer', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Sour Orange Mixer!', length = 10000})
end)

RegisterServerEvent('galaxy:mixer2')
AddEventHandler('galaxy:mixer2', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('redmixer', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Strawberry Daquiri Mixer!', length = 10000})
end)

RegisterServerEvent('galaxy:mixer3')
AddEventHandler('galaxy:mixer3', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('bluemixer', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Blueberry Daquiri Mixer!', length = 10000})
end)













RegisterServerEvent('galaxy:takebeer')
AddEventHandler('galaxy:takebeer', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('beer', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken Beer!', length = 10000})
end)

RegisterServerEvent('galaxy:takewine')
AddEventHandler('galaxy:takewine', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('wine', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken Wine!', length = 10000})
end)

RegisterServerEvent('galaxy:takewhiskey')
AddEventHandler('galaxy:takewhiskey', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('whiskey', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken Whiskey!', length = 10000})
end)

RegisterServerEvent('galaxy:takevodka')
AddEventHandler('galaxy:takevodka', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('vodka', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken Vodka!', length = 10000})
end)

RegisterServerEvent('galaxy:takebeef')
AddEventHandler('galaxy:takebeef', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('beef', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken Frozen Beef!', length = 10000})
end)

RegisterServerEvent('galaxy:takewings')
AddEventHandler('galaxy:takewings', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('wings', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken Frozen Wings!', length = 10000})
end)

RegisterServerEvent('galaxy:takefries')
AddEventHandler('galaxy:takefries', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('potato', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Potato!', length = 10000})
end)

RegisterServerEvent('galaxy:takebun')
AddEventHandler('galaxy:takebun', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('bun', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Burger Bun!', length = 10000})
end)

RegisterServerEvent('galaxy:takecheese')
AddEventHandler('galaxy:takecheese', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('cheese', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken Cheese!', length = 10000})
end)

RegisterServerEvent('galaxy:takecondom')
AddEventHandler('galaxy:takecondom', function()
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('condom', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'You have taken a Condom, stay safe!', length = 10000})
end)

RegisterCommand('galaxytray1', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local stash = {id = 'Galaxy-Tray-1', label = 'Galaxy Tray 1', slots = 5, coords = vector3(359.367, 279.3758, 94.1853)}
    exports['linden_inventory']:OpenStash(xPlayer, stash)
end)

RegisterCommand('galaxytray2', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local stash = {id = 'Galaxy-Tray-2', label = 'Galaxy Tray 2', slots = 5, coords = vector3(360.0396, 281.4462, 94.1853)}
    exports['linden_inventory']:OpenStash(xPlayer, stash)
end)



--exports['linden_inventory']:OpenStash({ id = 'Hospital Locker', slots = 70, job= 'ambulance'})