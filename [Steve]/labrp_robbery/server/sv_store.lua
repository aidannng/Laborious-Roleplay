ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local discord_webhook = {url = "https://discord.com/api/webhooks/865718213193891871/vnDi-Sy9-FCuyutnb2DbF-DZYHE1eluEebOHaL1u9ihbuqk6nkqXzhi1jim7uftMh9OZ",image = "https://i.iodine.gg/i5fba.png"}
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
    local xPlayer =  ESX.GetPlayerFromId(source)
    local gold = xPlayer.getInventoryItem('gold').count
    local g6card = xPlayer.getInventoryItem('g6card').count
    local count = math.random(1,100)

    if count >= 70 then
        xPlayer.addInventoryItem('black_money', math.random(35000,42500))
        xPlayer.addInventoryItem('gold', 5)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You recieved 5 gold bars and dirty money!', length = 4500,})
    else
        xPlayer.addInventoryItem('black_money', math.random(35000,42500))
        xPlayer.addInventoryItem('g6card', 1)
        xPlayer.addInventoryItem('gold', 5)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You found a Groupe 6 Card, Gold Bars and Dirty Money!', length = 4500,})
    end
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
