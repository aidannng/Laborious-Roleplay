ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



   local dumpsterItems = {
    [1] = {chance = 3, id = 0, name = 'Cash', quantity = math.random(1, 400)}, -- really common
    [2] = {chance = 10, id = 'WEAPON_PISTOL', name = 'Pistol', quantity = 1}, -- rare
    [3] = {chance = 5, id = 'kkjoint', name = 'Kronic Kush Joint', quantity = 1}, -- rare
    [4] = {chance = 4, id = '2ct_gold_chain', name = '2CT Gold Chain (P)', quantity = 1}, -- rare
    [5] = {chance = 5, id = '5ct_gold_chain', name = '5CT Gold Chain (P)', quantity = 1}, -- rare
    [6] = {chance = 6, id = '8ct_gold_chain', name = '8CT Gold Chain (P)', quantity = 1}, -- rare
    [7] = {chance = 8, id = '10ct_gold_chain', name = '10CT Gold Chain (P)', quantity = 1}, -- rare
    [8] = {chance = 8, id = 'advancedlockpick', name = 'Advanced Lockpick', quantity = 1}, -- rare
    [9] = {chance = 3, id = 'sunglasses', name = 'Oakley Sunglasses (P)', quantity = 1}, -- rare
    [10] = {chance = 4, id = 'gameboy', name = 'Gameboy (P)', quantity = 1}, -- rare
    [11] = {chance = 3, id = 'casio_watch', name = 'Casio Watch (P)', quantity = 1}, -- rare
    [12] = {chance = 3, id = 'nokia_phone', name = 'Nokia Phone (P)', quantity = 1}, -- rare
    [13] = {chance = 5, id = 'samsung_s8', name = 'Samsung S8 (P)', quantity = 1}, -- rare
    [14] = {chance = 5, id = 'apple_iphone', name = 'Apple iPhone (P)', quantity = 1}, -- rare
    [15] = {chance = 4, id = 'steel', name = 'Steel', quantity = 1}, -- rare
    [16] = {chance = 2, id = 'scrap_metal', name = 'Scrap Metal', quantity = 1}, -- rare
    [17] = {chance = 2, id = 'rubber', name = 'Rubber', quantity = 1}, -- rare
    [18] = {chance = 2, id = 'rolling_paper', name = 'Rolling Paper', quantity = 1}, -- rare
    [19] = {chance = 3, id = 'glass', name = 'Glass', quantity = 1}, -- rare
    [20] = {chance = 5, id = 'battery', name = 'Battery', quantity = 1}, -- rare
    [21] = {chance = 7, id = 'white_pearl', name = 'White Pearl (P)', quantity = 1}, -- rare
    [22] = {chance = 8, id = 'electronics', name = 'Electronics (P)', quantity = 1}, -- rare
}


RegisterServerEvent('dumpster:givereward')
AddEventHandler('dumpster:givereward', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = ESX.GetPlayerFromId(source)
 local gotID = {}


 for i=1, math.random(1, 2) do
  item = dumpsterItems[math.random(1, #dumpsterItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addMoney(item.quantity)
   elseif not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addInventoryItem(item.id, item.quantity)
   end
  end
 end
end)






-- PARKING METER SMASH -

RegisterServerEvent('payparkingmeter')
AddEventHandler('payparkingmeter', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    foundmoney = math.random(0,50)
    xPlayer.addMoney(foundmoney)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You found $'..foundmoney, })
end)

RegisterServerEvent('parkingmeter:starttimer')
AddEventHandler('parkingmeter:starttimer', function(meter)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('meter:removemeter', source, meter)
        end
    end
end)




-- SIGN SCRAP -- payscrapsign

RegisterServerEvent('payscrapsign')
AddEventHandler('payscrapsign', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = math.random(1, 3)
    xPlayer.addInventoryItem('scrapmetal', quantity)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You received '..quantity..' Scrap Metal', })
end)




