ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local discord_webhook = {url = "https://discord.com/api/webhooks/861474902493495317/oTnEfRLpSViVKPOTQQ8Rsas9dCUTKrgGrzJ7s7w3rnTAbc42wVQKrVUyf43ap71_WKvf",image = "https://i.iodine.gg/i5fba.png"}
local cooldown = false

ESX.RegisterServerCallback('labrp_store:checkrequired', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetExtendedPlayers()
    local cops = 0

    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' then
            cops = cops + 1
        end
    end

    local quantity = xPlayer.getInventoryItem('advancedlockpick').count

    if cops >= 3 and quantity > 0 and not cooldown then
        cb(true)
        PerformHttpRequest(discord_webhook.url, function(err, text, header) end, 'POST', 
        json.encode({username = "LABRP | Robbery Logs", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") has started a Store Robbery", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    else
        cb(false)
    end
end)

RegisterServerEvent('labrp_store:cooldown')
AddEventHandler('labrp_store:cooldown', function()
    cooldown = true
    local timer = 15 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            cooldown = false
        end
    end
end)

RegisterServerEvent('labrp_store:givereward')
AddEventHandler('labrp_store:givereward', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local moneypayout = math.random(12500, 18500)
    local jewels = math.random(1, 10)
    local jewelsamount = math.random(1, 4)
    local g6chance = math.random(1, 10)

    if jewels >= 8 then
        xPlayer.addInventoryItem('10ct_gold_chain', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got a 10 CT Gold Chain', length = 4500,})
    elseif jewels >= 6 and jewels <= 7 then --jewelsamount
        xPlayer.addInventoryItem('5ct_gold_chain', jewelsamount)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got '..jewelsamount..'x 5 CT Gold Chains', length = 4500,})
    else
        xPlayer.addInventoryItem('2ct_gold_chain', jewelsamount)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got '..jewelsamount..'x 2 CT Gold Chains', length = 4500,})
    end

    if g6chance >= 8 then 
        xPlayer.addInventoryItem('g6card', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got a Gruppe 6 Card', length = 4500,})
    end

    xPlayer.addInventoryItem('black_money', moneypayout)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got $'..moneypayout, length = 4500,})
end)

RegisterServerEvent('labrp_store:removeLockpick')
AddEventHandler('labrp_store:removeLockpick', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('advancedlockpick', 1)
end)

local Registers = {}

ESX.RegisterServerCallback('labrp_store:checkRegister', function(source, cb, register)
    if not CheckRegister(register) then
        cb(true)
        RegisterCooldown(register)
    else
        cb(false)
    end
end)

RegisterServerEvent('labrp_store:TableInsertRegister')
AddEventHandler('labrp_store:TableInsertRegister', function(register)
    table.insert(Registers, register)
end)

function CheckRegister(register)
    for k, v in ipairs(Registers) do
        if v == register then
            return true
        end
    end
    return false
end

function RegisterCooldown(register)
    local timer = 15 * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            for i = 1, #Registers do
                if Registers[i] == register then
                    table.remove(Registers, i)
                end
            end
        end
    end
end

RegisterServerEvent('labrp_store:RegisterReward')
AddEventHandler('labrp_store:RegisterReward', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local random = math.random(1000, 2500)
    xPlayer.addInventoryItem('black_money', random)
end)
