ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local pending = 0

RegisterServerEvent('payPay')
AddEventHandler('payPay',function(orderamount,ordernote)
end)

RegisterServerEvent('testpay')
AddEventHandler('testpay',function(orderamount,ordernote)
end)

RegisterServerEvent('makemoneyshot')
AddEventHandler('makemoneyshot',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local pattycount = xPlayer.getInventoryItem('patty').count
    local buncount = xPlayer.getInventoryItem('bun').count
    local lettucecount = xPlayer.getInventoryItem('lettuce').count

    if pattycount >= 3 then
        if buncount >= 2 then
            if lettucecount >= 3 then
                xPlayer.addInventoryItem('moneyshot', 1)
                xPlayer.removeInventoryItem('patty', 3)
                xPlayer.removeInventoryItem('bun', 2)
                xPlayer.removeInventoryItem('lettuce', 3)
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made Money Shot!', length = 5000})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
    end
end)

--makeburger

RegisterServerEvent('makeburger')
AddEventHandler('makeburger',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local meatcount = xPlayer.getInventoryItem('meat').count

    if meatcount >= 3 then
        xPlayer.addInventoryItem('patty', 1)
        xPlayer.removeInventoryItem('meat', 3)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made a Beef Patty!', length = 5000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You need more Meat!', length = 5000})
    end
end)

--veggieburger

RegisterServerEvent('veggieburger')
AddEventHandler('veggieburger',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local fakemeatcount = xPlayer.getInventoryItem('fakemeat').count

    if fakemeatcount >= 4 then
        xPlayer.addInventoryItem('veggieburger', 1) --/giveitem 4 veggieburger 1
        xPlayer.removeInventoryItem('fakemeat', 4)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made a Veggie Patty!', length = 5000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You need more Fake Meat!', length = 5000})
    end
end)

--makemeatfree

RegisterServerEvent('makemeatfree')
AddEventHandler('makemeatfree',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local meatfreecount = xPlayer.getInventoryItem('veggieburger').count
    local buncount = xPlayer.getInventoryItem('bun').count
    local lettucecount = xPlayer.getInventoryItem('lettuce').count

    if meatfreecount >= 3 then
        if buncount >= 2 then
            if lettucecount >= 6 then
                xPlayer.removeInventoryItem('veggieburger', 3)
                xPlayer.removeInventoryItem('bun', 2)
                xPlayer.removeInventoryItem('lettuce', 6)
                xPlayer.addInventoryItem('meatfree', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made a Veggie Burger!', length = 5000})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
    end
end)

--makebleeder

RegisterServerEvent('makebleeder')
AddEventHandler('makebleeder',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local meatcount = xPlayer.getInventoryItem('patty').count
    local buncount = xPlayer.getInventoryItem('bun').count
    local lettucecount = xPlayer.getInventoryItem('lettuce').count

    if meatcount >= 3 then
        if buncount >= 2 then
            if lettucecount >= 2 then
                xPlayer.removeInventoryItem('patty', 3)
                xPlayer.removeInventoryItem('bun', 2)
                xPlayer.removeInventoryItem('lettuce', 2)
                xPlayer.addInventoryItem('bleeder', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made Bleeder Burger!', length = 5000})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
    end
end)

RegisterServerEvent('maketorpedo')
AddEventHandler('maketorpedo',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local meatcount = xPlayer.getInventoryItem('patty').count
    local buncount = xPlayer.getInventoryItem('bun').count
    local lettucecount = xPlayer.getInventoryItem('lettuce').count

    if meatcount >= 4 then
        if buncount >= 2 then
            if lettucecount >= 2 then
                xPlayer.removeInventoryItem('patty', 4)
                xPlayer.removeInventoryItem('bun', 2)
                xPlayer.removeInventoryItem('lettuce', 2)
                xPlayer.addInventoryItem('torpedo', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made Torpedo Burger!', length = 5000})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
    end
end)

RegisterServerEvent('makeheart')
AddEventHandler('makeheart',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local meatcount = xPlayer.getInventoryItem('patty').count
    local buncount = xPlayer.getInventoryItem('bun').count
    local lettucecount = xPlayer.getInventoryItem('lettuce').count

    if meatcount >= 8 then
        if buncount >= 2 then
            if lettucecount >= 2 then
                xPlayer.removeInventoryItem('patty', 8)
                xPlayer.removeInventoryItem('bun', 3)
                xPlayer.removeInventoryItem('lettuce', 3)
                xPlayer.addInventoryItem('heartstopper', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made a Heart Stopper!', length = 5000})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'Insufficient Ingredients to Craft!', length = 5000})
    end
end)

--makesprunk

RegisterServerEvent('makesprunk')
AddEventHandler('makesprunk',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local cupcount = xPlayer.getInventoryItem('bscup').count

    if cupcount >= 1 then
        xPlayer.removeInventoryItem('bscup', 8)
        xPlayer.addInventoryItem('sprunk', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made a Sprunk!', length = 5000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You need a F*%$ING CUP!', length = 5000})
    end
end)

RegisterServerEvent('makeecola')
AddEventHandler('makeecola',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local cupcount = xPlayer.getInventoryItem('bscup').count

    if cupcount >= 1 then
        xPlayer.removeInventoryItem('bscup', 1)
        xPlayer.addInventoryItem('ecola', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made a ECola!', length = 5000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You need a F*%$ING CUP!', length = 5000})
    end
end)

--grabbscup


RegisterServerEvent('grabbscup')
AddEventHandler('grabbscup',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('bscup', 1)
end)--makefries


RegisterServerEvent('makefries')
AddEventHandler('makefries',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local potcount = xPlayer.getInventoryItem('potato').count

    if potcount >= 5 then
        xPlayer.removeInventoryItem('potato', 5)
        xPlayer.addInventoryItem('bsfries', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'inform', text = 'Successfully made a batch of Fries', length = 5000})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You need more fooking potatoes m8!', length = 5000})
    end
end)

RegisterServerEvent('chargecondom')
AddEventHandler('chargecondom',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 1 then
        xPlayer.addInventoryItem('condom', 1)
        xPlayer.removeInventoryItem('money', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You need more cash!', length = 5000})
    end
end)

RegisterServerEvent('chargeburger')
AddEventHandler('chargeburger',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 30 then
        xPlayer.addInventoryItem('burger', 1)
        xPlayer.removeInventoryItem('money', 30)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You need more cash!', length = 5000})
    end
end)

RegisterServerEvent('chargeecola')
AddEventHandler('chargeecola',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getInventoryItem('money').count

    if money >= 45 then
        xPlayer.addInventoryItem('ecola', 1)
        xPlayer.removeInventoryItem('money', 45)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You need more cash!', length = 5000})
    end
end)


RegisterServerEvent('staszek-receipts:registerReceipt')
AddEventHandler("staszek-receipts:registerReceipt", function(TargetID, amount)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(TargetID)
    local fine = ESX.Math.Round(amount)
    local tax = math.random(5, 20)
    local taxmoney = fine - tax

	if xTarget ~= nil then
        xTarget.removeMoney(fine)
		--TriggerClientEvent('esx:showNotification', xTarget.source, 'You have been billed for $'..fine)
        --exports['mythic_notify']:SendAlert('inform', 'You have been billed for $'..fine)
        TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'inform', text = 'You have been billed for $'..fine, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
		--TriggerClientEvent('esx:showNotification', xPlayer.source, 'You have successfully wrote a bill for $'..fine)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You have successfully wrote a bill for $'..fine, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
        xTarget.addMoney(taxmoney)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You recieved $'..taxmoney..' with $'..tax..' Tax', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)


RegisterServerEvent('giveweaponlicense')
AddEventHandler("giveweaponlicense", function(ID)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(ID)

	if xTarget ~= nil then
        xTarget.removeMoney(500)
		--TriggerClientEvent('esx:showNotification', xTarget.source, 'You have been billed for $'..fine)
        --exports['mythic_notify']:SendAlert('inform', 'You have been billed for $'..fine)
        TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'inform', text = 'You have been billed for $500', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
		--TriggerClientEvent('esx:showNotification', xPlayer.source, 'You have successfully wrote a bill for $'..fine)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You have successfully wrote a bill for $500', style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
        TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'inform', text = "You recieved a Weapon's License", style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
	end
end)