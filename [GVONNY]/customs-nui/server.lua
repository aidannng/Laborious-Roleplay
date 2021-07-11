ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterServerEvent("buymaterial")
AddEventHandler("buymaterial", function(part, price, amount)
    print(part)
    print(price)
    print(amount)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name
    local jobgrade = tonumber(xPlayer.job.grade)

    if(job == "mechanic" and jobgrade > 2) then
        local total = tonumber(price) * tonumber(amount)

        MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_mechanic'", {} ,function(balance)
            if(balance ~= nil and #balance > 0) then
                local balance  = balance[1].money

                if(balance >= total) then
                    xPlayer.addInventoryItem(part, tonumber(amount))
                    balance = balance - total

                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Items purchased', style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
                    MySQL.Async.execute("UPDATE addon_account_data SET money = @money WHERE account_name = 'society_mechanic'", {['@money'] = balance})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = "Not enough money in account", })
                end


                TriggerClientEvent('addplates', src, results)
            end
        end)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'You can not buy materials' })
    end
end)