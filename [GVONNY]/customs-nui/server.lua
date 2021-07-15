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

    if(job == "mechanic" and jobgrade > 1) then
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

RegisterServerEvent("lsccreatebill")
AddEventHandler("lsccreatebill", function(luckynumber, price, termlength)
    print("creating bill")
    local src = source
    local creator = ESX.GetPlayerFromId(src)
    local ower = ESX.GetPlayerFromId(luckynumber)

    if(ower ~= nil) then
        if(tonumber(termlength) > 0) then
            local downpayment = math.floor(tonumber(price) *.50);
            price = price - downpayment
    
            local cash = math.floor(tonumber(ower.getInventoryItem('money').count))
    
            if(cash >= downpayment) then
                local termamount = price / termlength
    
                MySQL.Async.execute("INSERT INTO billing (identifier, sender, target_type, target, label, amount, term_length, term_amount, term_payment, has_paid, term_days_left, days_overdue) VALUES (@ower, @biller, 'society', 'society_mechanic', 'Repair/Upgrade', @price, @termlength, @termamount, '0', @haspaid, '28', '0')",{
                    ['@ower'] = ower.identifier,
                    ['@biller'] = creator.identifier,
                    ['@price'] = price,
                    ['@termlength'] = termlength,
                    ['@haspaid'] = false,
                    ['@termamount'] = termamount,
                })
    
                ower.removeInventoryItem('money', downpayment)
    
                MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_mechanic'", {}, function(result)
                    local balance = result[1].money
                    balance = balance + downpayment
    
                    MySQL.Async.execute("UPDATE addon_account_data SET money = @money WHERE account_name = 'society_mechanic'", {['@money'] = balance})
                end)

                TriggerClientEvent("lsc:refreshbilling", src)

                --[[PerformHttpRequest(discord_webhook.url, 
                function(err, text, header) end, 
                'POST', 
                json.encode({username = "LABRP | PDM Logs", content = "**" .. creator.getName() .. "**(".. creator.identifier .. ") has made a new bill for **" .. ower.getName() .. "**(" .. ower.identifier .. ") for a total of **$" .. price .. "** ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) ]]            
            else
                TriggerClientEvent("lsc:billerror", src, "Customer has insufficient funds")
            end
        else
            local cash = math.floor(tonumber(ower.getInventoryItem('money').count))

            if(cash >= tonumber(price)) then
                ower.removeInventoryItem('money', tonumber(price))

                MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_mechanic'", {}, function(result)
                    local balance = result[1].money
                    balance = balance + tonumber(price)
    
                    MySQL.Async.execute("UPDATE addon_account_data SET money = @money WHERE account_name = 'society_mechanic'", {['@money'] = balance})
                end)
            else
                TriggerClientEvent("lsc:billerror", src, "Customer has insufficient funds")
            end
        end
    else
        TriggerClientEvent("lsc:billerror", src, "Lucky number is not in city")
    end
end)

RegisterServerEvent("getlscbills")
AddEventHandler("getlscbills", function()
    print("getting lsc bills")
    local src = source
    MySQL.Async.fetchAll("SELECT ower.firstname, ower.lastname, creator.firstname as employeefirstname, creator.lastname as employeelastname, billing.amount, billing.term_length, billing.days_overdue FROM users ower, billing, users creator  WHERE target = 'society_mechanic' and billing.identifier = ower.identifier AND billing.sender = creator.identifier AND billing.amount > 0",{}, function(bills)
        if(bills ~= nil and #bills>0) then
            for x=1,#bills,1 do

                local firstname = bills[x].firstname
                local lastname = bills[x].lastname
                local employeefirstname = bills[x].employeefirstname
                local employeelastname = bills[x].employeelastname
                local amount = bills[x].amount
                local termlength = bills[x].term_length
                local daysoverdue = bills[x].days_overdue

                TriggerClientEvent("lsc:addtobillinglist", src, firstname, lastname, employeefirstname, employeelastname, amount, termlength, daysoverdue)
            end
        end
    end)
end)