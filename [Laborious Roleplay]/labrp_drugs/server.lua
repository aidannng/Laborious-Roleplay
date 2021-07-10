ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("kaves_drugs:checkItem", function(source, cb, itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(itemname).count >= count then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("kaves_drugs:checkItemAll", function(source, cb, itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
	local count = xPlayer.getInventoryItem(itemname).count
    if xPlayer.getInventoryItem(itemname).count > 0 then
        cb(true, count)
    else
        cb(false)
    end
end)

RegisterServerEvent("kaves_drugs:removeItem")
AddEventHandler("kaves_drugs:removeItem", function(itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(itemname, count)
end)

RegisterServerEvent("kaves_drugs:removeItemAll")
AddEventHandler("kaves_drugs:removeItemAll", function(itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getInventoryItem(itemname).count
    xPlayer.removeInventoryItem(itemname, count)
end)

RegisterServerEvent("kaves_drugs:giveMoney")
AddEventHandler("kaves_drugs:giveMoney", function(count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if Config.BlackMoney then
            xPlayer.addAccountMoney('black_money', count)
        else
            xPlayer.addMoney(count)
        end
    end
end)

RegisterServerEvent("kaves_drugs:giveBlackMoney2")
AddEventHandler("kaves_drugs:giveBlackMoney2", function(count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addAccountMoney('black_money', count)
    end
end)

RegisterServerEvent("kaves_drugs:giveBlackMoney")
AddEventHandler("kaves_drugs:giveBlackMoney", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = math.random(100, 200)
    if xPlayer then
        xPlayer.addAccountMoney('black_money', count)
    end
end)

RegisterServerEvent("kaves_drugs:giveItem")
AddEventHandler("kaves_drugs:giveItem", function(itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
	if itemname == "sorted_money" then
		xPlayer.addInventoryItem(itemname, count)
		return
	end
    if xPlayer.getInventoryItem(itemname).count < 100 then
        xPlayer.addInventoryItem(itemname, count)
    else
        xPlayer.showNotification("You are too heavy!")
    end
end)

ESX.RegisterServerCallback("kaves_drugs:checkCanCarryItem", function(source, cb, itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(itemname).count < 100 then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("kaves_drugs:checkBlackMoney", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackcount = xPlayer.getAccount('black_money').money
    if blackcount > 0 then
        cb(blackcount)
    else
        cb(false)
    end
end)

RegisterServerEvent("kaves_drugs:removeBlackMoney")
AddEventHandler("kaves_drugs:removeBlackMoney", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getAccount('black_money').money
    if xPlayer then
        xPlayer.removeAccountMoney('black_money', count)
    end
end)

RegisterServerEvent("kaves_drugs:addMoney")
AddEventHandler("kaves_drugs:addMoney", function(count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addMoney(count)
    end
end)