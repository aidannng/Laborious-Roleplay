ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local discord_webhook = {url = "https://discord.com/api/webhooks/861474902493495317/oTnEfRLpSViVKPOTQQ8Rsas9dCUTKrgGrzJ7s7w3rnTAbc42wVQKrVUyf43ap71_WKvf",image = "https://i.iodine.gg/i5fba.png"}

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
    ExecuteCommand('blackout')
    TriggerClientEvent('chat:addMessage',-1 , {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(70, 130, 180,0.5); border-radius: 3px;">^*[LS Water & Power]: Power Outage at LS Water & Power!</div>',
    });

    PerformHttpRequest(discord_webhook.url, function(err, text, header) end, 'POST', 
	json.encode({username = "LABRP | Robbery Logs", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") has started a water & power blackout", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 


end)--[LS Water & Power]: Power Outage at LS Water & Power!

RegisterServerEvent('GiveSafeReward')
AddEventHandler('GiveSafeReward', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local moneypayout = math.random(12500, 18500)
    local jewels = math.random(1, 10)
    local jewelsamount = math.random(1, 4)
    local laptopchance = math.random(1, 10)

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

    if laptopchance >= 8 then 
        xPlayer.addInventoryItem('g6card', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got a Gruppe 6 Card', length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
    end


    xPlayer.addInventoryItem('black_money', moneypayout)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got $'..moneypayout, length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })


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




RegisterServerEvent('checkstorecops')
AddEventHandler('checkstorecops', function()
    local xPlayers = ESX.GetExtendedPlayers()
    local cops = 0
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end

    if cops >= 3 then
        TriggerClientEvent('doHack', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'System Currently Down!'})
    end
end)

RegisterServerEvent('checkhousecops')
AddEventHandler('checkhousecops', function()
    local xPlayers = ESX.GetExtendedPlayers()
    local cops = 0
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.job.name == 'police' and xPlayer.job.name == 'fbi' then
            cops = cops + 1
        end
    end

    if cops >= 2 then
        TriggerClientEvent('house:attempt', source)
    end
end)