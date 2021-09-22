ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local discord_webhook = {url = "https://discord.com/api/webhooks/890051237494530048/X6m0tqzNv-EiWOYVC8vlMNOSPxmZKU--vBc6dxyrzPQrkqWODudBPVhC8hIwM1WfDtUj",image = "https://i.iodine.gg/i5fba.png"}

--------------------------------------------------------------------------------------------------------------------------------------------

-- Server Callbacks

RegisterServerEvent('craft:duster')
AddEventHandler('craft:duster', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count
    local steelQuantity = xPlayer.getInventoryItem('steel').count

    if scrapQuantity >= 5  then
        if steelQuantity >= 10 then
            xPlayer.addInventoryItem('WEAPON_KNUCKLE', 1)
            xPlayer.removeInventoryItem('scrapmetal', 5)
            xPlayer.removeInventoryItem('steel', 10)
            function(err, text, header) end, 
            'POST', 
            json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted dusters", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
            function(err, text, header) end, 
            'POST', 
            json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to craft crafted dusters", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
        end
    end
end)

RegisterServerEvent('craft:machete')
AddEventHandler('craft:machete', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count
    local steelQuantity = xPlayer.getInventoryItem('steel').count
    local rubberQuantity = xPlayer.getInventoryItem('rubber').count

    if scrapQuantity >= 5 then
        if steelQuantity >= 10 then
            if rubberQuantity >= 5 then
                xPlayer.addInventoryItem('WEAPON_MACHETE', 1)
                xPlayer.removeInventoryItem('scrapmetal', 5)
                xPlayer.removeInventoryItem('rubber', 5)
                xPlayer.removeInventoryItem('steel', 10)
                function(err, text, header) end, 
                'POST', 
                json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted machete", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
        
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
                function(err, text, header) end, 
                'POST', 
                json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to craft machete", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
            end
        end
    end  
end)

RegisterServerEvent('craft:blade')
AddEventHandler('craft:blade', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count
    local steelQuantity = xPlayer.getInventoryItem('steel').count
    local rubberQuantity = xPlayer.getInventoryItem('rubber').count

    if scrapQuantity >= 5 then
        if steelQuantity >= 5 then
            if rubberQuantity >= 2 then
                xPlayer.addInventoryItem('WEAPON_SWITCHBLADE', 1)
                xPlayer.removeInventoryItem('scrapmetal', 5)
                xPlayer.removeInventoryItem('rubber', 2)
                xPlayer.removeInventoryItem('steel', 5)
                function(err, text, header) end, 
                'POST', 
                json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted blade", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials', })
                function(err, text, header) end, 
                'POST', 
                json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to crafted dusters", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
            end
        end
    end  
end)

RegisterServerEvent('craft:browning')
AddEventHandler('craft:browning', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count

    if scrapQuantity >= 1  then
        xPlayer.addInventoryItem('WEAPON_BROWNING', 1)
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted browning", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to crafted browning", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    end
end)

RegisterServerEvent('craft:dp9')
AddEventHandler('craft:dp9', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count

    if scrapQuantity >= 1  then
        xPlayer.addInventoryItem('WEAPON_DP9', 1)
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted dp9", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to crafted dp9", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    end
end)

RegisterServerEvent('craft:pistol50')
AddEventHandler('craft:pistol50', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count

    if scrapQuantity >= 1  then
        xPlayer.addInventoryItem('WEAPON_PISTOL50', 1)
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted deagle", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to crafted deagle", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    end
end)

RegisterServerEvent('craft:mac10')
AddEventHandler('craft:mac10', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count

    if scrapQuantity >= 1  then
        xPlayer.addInventoryItem('WEAPON_MICROSMG2', 1)
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted mac 10", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to crafted mac 10", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    end
end)

RegisterServerEvent('craft:ammo45')
AddEventHandler('craft:ammo45', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count

    if scrapQuantity >= 1  then
        xPlayer.addInventoryItem('ammo-45', 150)
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted ammo 45", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to crafted ammo 45", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    end
end)

RegisterServerEvent('craft:ammo50')
AddEventHandler('craft:ammo50', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local scrapQuantity = xPlayer.getInventoryItem('scrapmetal').count

    if scrapQuantity >= 1  then
        xPlayer.addInventoryItem('ammo-50', 150)
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") crafted ammo 50", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
        function(err, text, header) end, 
        'POST', 
        json.encode({username = "CRAFTING LOGS | PLASMA", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") tried to crafted ammo 50", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    end
end)