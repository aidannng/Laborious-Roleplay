ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

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
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
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
        
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials!', })
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
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Insufficient Materials', })
            end
        end
    end  
end)