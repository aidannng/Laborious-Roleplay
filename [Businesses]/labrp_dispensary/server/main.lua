ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('make:kronickush')
AddEventHandler('make:kronickush', function()
    print('test')
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('cannabis').count
   
    if RubberQuantity >= 1 then
        xPlayer.removeInventoryItem('cannabis', 1)
        xPlayer.addInventoryItem('kronickush', 3)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
    end
end)


RegisterServerEvent('make:zurplepunch')
AddEventHandler('make:zurplepunch', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('cannabis').count
   
    if RubberQuantity >= 1 then
        xPlayer.removeInventoryItem('cannabis', 1)
        xPlayer.addInventoryItem('zurplepunch', 2)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
    end
end)

RegisterServerEvent('make:weddingpie')
AddEventHandler('make:weddingpie', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('cannabis').count
   
    if RubberQuantity >= 1 then
        xPlayer.removeInventoryItem('cannabis', 1)
        xPlayer.addInventoryItem('weddingpie', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
    end
end)





RegisterServerEvent('make:gummies')
AddEventHandler('make:gummies', function()
    print('test')
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('kronickush').count
    local Quantity = xPlayer.getInventoryItem('gummies').count
   
    if RubberQuantity >= 1 then
        if Quantity >= 1 then
            xPlayer.removeInventoryItem('kronickush', 1)
            xPlayer.removeInventoryItem('gummies', 1)
            xPlayer.addInventoryItem('kkgummies', 2)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
    end
end)


RegisterServerEvent('make:brownie')
AddEventHandler('make:brownie', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('kronickush').count
    local Quantity = xPlayer.getInventoryItem('brownie').count
   
    if RubberQuantity >= 1 then
        if Quantity >= 1 then
            xPlayer.removeInventoryItem('kronickush', 1)
            xPlayer.removeInventoryItem('brownie', 1)
            xPlayer.addInventoryItem('kkbrownie', 2)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
    end
end)


RegisterServerEvent('make:cookie')
AddEventHandler('make:cookie', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('kronickush').count
    local Quantity = xPlayer.getInventoryItem('cookie').count
   
    if RubberQuantity >= 1 then
        if Quantity >= 1 then
            xPlayer.removeInventoryItem('kronickush', 1)
            xPlayer.removeInventoryItem('cookie', 1)
            xPlayer.addInventoryItem('kkcookies', 2)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
    end
end)









RegisterServerEvent('dispensary:harvestweed')
AddEventHandler('dispensary:harvestweed', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = math.random(5, 10)

    xPlayer.addInventoryItem('cannabis', quantity)
end)



RegisterServerEvent('make:rollzp')
AddEventHandler('make:rollzp', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('zurplepunch').count
    local PaperQuantity = xPlayer.getInventoryItem('rolling_paper').count
   
    if RubberQuantity >= 1 then
        if PaperQuantity >= 1 then
            xPlayer.removeInventoryItem('zurplepunch', 1)
            xPlayer.removeInventoryItem('rolling_paper', 1)
            xPlayer.addInventoryItem('zpjoint', 1)
        else 
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
            print('not enough rolling paper')
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
        print('not enough zurple punch')
    end
end)

RegisterServerEvent('make:rollwp')
AddEventHandler('make:rollwp', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('weddingpie').count
    local PaperQuantity = xPlayer.getInventoryItem('rolling_paper').count
   
    if RubberQuantity >= 1 then
        if PaperQuantity >= 1 then
            xPlayer.removeInventoryItem('weddingpie', 1)
            xPlayer.removeInventoryItem('rolling_paper', 1)
            xPlayer.addInventoryItem('wpjoint', 1)
        else 
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
    end
end)

RegisterServerEvent('make:rollkk')
AddEventHandler('make:rollkk', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local RubberQuantity = xPlayer.getInventoryItem('kronickush').count
    local PaperQuantity = xPlayer.getInventoryItem('rolling_paper').count
   
    if RubberQuantity >= 1 then
        if PaperQuantity >= 1 then
            xPlayer.removeInventoryItem('kronickush', 1)
            xPlayer.removeInventoryItem('rolling_paper', 1)
            xPlayer.addInventoryItem('kkjoint', 1)
        else 
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Ingredients!', length = 5000})
    end
end)

RegisterServerEvent('removekkjoint')
AddEventHandler('removekkjoint', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('kkjoint', 1)
end)

RegisterServerEvent('removezpjoint')
AddEventHandler('removezpjoint', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('zpjoint', 1)
end)

RegisterServerEvent('removewpjoint')
AddEventHandler('removewpjoint', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('wpjoint', 1)
end)


RegisterServerEvent('kk:payment')
AddEventHandler("kk:payment", function(TargetID, amount, order)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(TargetID)
    local fine = amount
    local job = xPlayer.job.name
    local MoneyQuantity = xTarget.getInventoryItem('money').count

    if job == "kronickush" then
	    if xTarget ~= nil then
            if tonumber(MoneyQuantity) >= tonumber(fine) then
                xTarget.removeMoney(fine)
                xTarget.addInventoryItem('receipt', 1, {type='Kronic Kush Order of $'..fine.. ': ', description=order})
                xPlayer.addInventoryItem('receipt', 1, {type='Kronic Kush Order of $'..fine.. ': ', description=order})
                TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'inform', text = 'You have been billed for $'..fine})
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have successfully wrote a bill for $'..fine})
                xPlayer.addMoney(fine)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You recieved $'..fine})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Recipient does not have enough'})
            end
	    end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You are not currently employed here'})
    end
end)

RegisterServerEvent('removekkgummies')
AddEventHandler('removekkgummies', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('kkgummies', 1)
end)

RegisterServerEvent('removekkbrownie')
AddEventHandler('removekkbrownie', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('kkbrownie', 1)
end)

RegisterServerEvent('removekkcookie')
AddEventHandler('removekkcookie', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('kkcookie', 1)
end)



RegisterServerEvent('kk:purchase')
AddEventHandler("kk:purchase", function(type)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local MoneyQuantity = xPlayer.getInventoryItem('money').count
    print(type)

    if job == "kronickush" then
	    if MoneyQuantity >= 25 then
            xPlayer.removeInventoryItem('money', 100)
            xPlayer.addInventoryItem(type, 5)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Not enough monies'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You are not currently employed here'})
    end
end)

RegisterServerEvent('kk:hire')
AddEventHandler("kk:hire", function(TargetID)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local xTarget = ESX.GetPlayerFromId(TargetID)

    if job == "kronickush" then
	    xTarget.setJob('kronickush', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You are not currently employed here'})
    end
end)

local isOpen = false

RegisterServerEvent('kk:openmsg')
AddEventHandler('kk:openmsg', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    if job == "kronickush" then
        if not isOpen then
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
                args = { "^*[^2Kronic Kush^0] The Kronic Kush Dispensary is now open, come on down to legion sqaure to purchase some of our finest goods!" }
            });	
            isOpen = true
        else
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
                args = { "^*[^2Kronic Kush^0] The Kronic Kush Dispensary is now closed" }
            });
            isOpen = false
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You are not currently employed here'})
    end
end)