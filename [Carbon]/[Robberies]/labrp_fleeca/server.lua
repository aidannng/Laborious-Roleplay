ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('checkadvancedlockpick')
AddEventHandler('checkadvancedlockpick', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local lockpickcount = xPlayer.getInventoryItem('advancedlockpick').count

    if lockpickcount >= 1 then
        TriggerClientEvent('startHack', source)
    else
        TriggerClientEvent('nolockpick', source)
    end
end)

RegisterServerEvent('powerblackout')
AddEventHandler('powerblackout', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('blackout', -1)
    TriggerClientEvent('chat:addMessage',-1 , {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(70, 130, 180,0.5); border-radius: 3px;">^*[LS Water & Power]: Power Outage at LS Water & Power!</div>',
    });
end)--[LS Water & Power]: Power Outage at LS Water & Power!

RegisterServerEvent('GiveSafeReward')
AddEventHandler('GiveSafeReward', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local moneypayout = math.random(1000, 5000)
    local jewels = math.random(1, 10)
    local jewelsamount = math.random(1, 4)
    local laptopchance = math.random(1, 100000)

    if jewels >= 8 then
        xPlayer.addInventoryItem('10ct_gold_chain', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got a 10 CT Gold Chain', length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
    elseif jewels >= 6 and jewels <= 7 then --jewelsamount
        xPlayer.addInventoryItem('5ct_gold_chain', jewelsamount)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got '..jewelsamount..'x 5 CT Gold Chains', length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
    else
        xPlayer.addInventoryItem('2ct_gold_chain', jewelsamount)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got '..jewelsamount..'x 2 CT Gold Chains', length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
    end

    xPlayer.addInventoryItem('money', moneypayout)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got $'..moneypayout, length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })

    if laptopchance >= 99999 then
        xPlayer.addInventoryItem('greenlaptop', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You found a Green Laptop', length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
    end

end)

RegisterServerEvent('TakeLockPPick')
AddEventHandler('TakeLockPPick', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('advancedlockpick', 1)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Lockpick Bent out of shape', length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
end)--TriggerClientEvent("utk_fh:openDoor_c", -1


RegisterServerEvent('openfleecadoor')
AddEventHandler('openfleecadoor', function()
    TriggerClientEvent("fleeca:openvaultdoor", -1)
end)--TriggerClientEvent("utk_fh:openDoor_c", -1

RegisterServerEvent('closefleecadoor')
AddEventHandler('closefleecadoor', function()
    TriggerClientEvent("fleeca:closevaultdoor", -1)
end)--TriggerClientEvent("utk_fh:openDoor_c", -1


RegisterNetEvent('fleecaReward')
AddEventHandler('fleecaReward', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local fleecapayout = math.random(750, 1200)
    local losecash = math.random(5000, 8500)

    xPlayer.addInventoryItem('black_money', fleecapayout)

end)


RegisterServerEvent('deleteboomboxitem')
AddEventHandler('deleteboomboxitem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('boombox', 1)
end)