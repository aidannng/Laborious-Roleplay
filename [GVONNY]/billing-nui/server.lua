ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local discord_webhook = {url = "https://discord.com/api/webhooks/861524224330301472/0kJenGNe8fK_k8Vl-1IL6j6__xwSVUbRYIJjlGiVemWuthfI14qMRXMhnCb1_XNtJf4l",image = "https://i.iodine.gg/i5fba.png"}

RegisterServerEvent("getmybills")
AddEventHandler("getmybills", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    MySQL.Async.fetchAll("SELECT a.id, a.identifier, a.sender, a.target_type, a.target, a.label, a.amount, a.term_length, a.term_days_left, a.term_amount, a.days_overdue, b.firstname, b.lastname FROM billing a, users b WHERE a.identifier = @identifier AND a.sender = b.identifier AND a.amount > 0", {['@identifier'] = xPlayer.identifier} ,function(result)
        if(#result > 0) then
            for x=1,#result,1 do 
                local billid = result[x].id
                local sender = result[x].sender
                local label = result[x].label
                local amount = result[x].amount
                local target = result[x].target
                local firstname = result[x].firstname
                local lastname = result[x].lastname
                local termlength = result[x].term_length
                local termamount = result[x].term_amount
                local termdaysleft = math.ceil(tonumber(result[x].term_days_left) / 2)
                local daysoverdue= math.ceil(tonumber(result[x].days_overdue) / 2)

                TriggerClientEvent('billing:createbillingrow', src, billid, sender, label, amount, firstname, lastname, target, termlength, termamount, termdaysleft, daysoverdue)
            end
        end
    end)
end)

RegisterServerEvent("updatebill")
AddEventHandler("updatebill", function(billID, billAmount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    MySQL.Async.fetchAll("SELECT id, identifier, sender, amount, target, term_length, term_amount, term_payment FROM billing WHERE id = @id AND identifier = @identifier", {['@id'] = billID, ['@identifier'] = xPlayer.identifier} ,function(result)
        if(#result > 0) then
            local accounts = xPlayer.getAccounts()
            for x=1,#accounts do
                local name = accounts[x].name
                if(name == 'bank') then
                    local balance = tonumber(accounts[x].money)
                    print(balance)

                    if(balance >= tonumber(billAmount)) then
                        xPlayer.removeAccountMoney(name, tonumber(billAmount))

                        local target = result[1].target 
                        if(target == 'society_cardealer') then
                            MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_cardealer'", {}, function(result)
                                local balance = result[1].money
                                balance = balance + billAmount
                
                                MySQL.Async.execute("UPDATE addon_account_data SET money = @money WHERE account_name = 'society_cardealer'", {['@money'] = balance})
                            end)
                        else
                            local xPlayers = ESX.GetPlayers()
                            for i=1, #xPlayers, 1 do
                                local player = ESX.GetPlayerFromId(xPlayers[i])
                                if(player.identifier == result[1].sender) then
                                    player.addAccountMoney('bank', tonumber(billAmount))                
                                end
                            end
                        end

                        local newamount = result[1].amount - billAmount
                        local currenttermamount = result[1].term_amount
                        local currenttermlength = result[1].term_length
                        local currenttermpayment = result[1].term_payment

                        if(tonumber(currenttermamount) == tonumber(billAmount)) then
                            currenttermlength = currenttermlength - 1
                            if(currenttermamount - billAmount >= 0) then
                                if(currenttermlength == 0) then
                                    currenttermamount = newamount
                                else
                                    currenttermamount = newamount / currenttermlength
                                end
                            else
                                currenttermamount = 0
                            end


                            MySQL.Async.execute("UPDATE billing SET amount = @amount, term_length = @termlength, term_amount = @termamount, term_days_left = '14', days_overdue = '0', term_payment = '0' WHERE id = @id", {['@amount'] = newamount, ['@id'] = billID, ['@termlength'] = currenttermlength, ['@termamount'] = currenttermamount})
                        else
                            currenttermamount = currenttermamount - billAmount
                            currenttermpayment = currenttermpayment + billAmount


                            MySQL.Async.execute("UPDATE billing SET amount = @amount, term_length = @termlength, term_amount = @termamount, term_payment = @termpayment WHERE id = @id", {['@amount'] = newamount, ['@id'] = billID, ['@termlength'] = currenttermlength, ['@termamount'] = currenttermamount, ['@termpayment'] = currenttermpayment})
                        end
                        PerformHttpRequest(discord_webhook.url, function(err, text, header) end, 'POST', json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "**(" .. xPlayer.identifier .. ") has payed **$" .. billAmount .. "** of their bill from **" .. result[1].sender .. "** with a total of **$" .. newamount .. "** remaining",avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'})             
                    else
                        TriggerClientEvent("billing:error", src, "Not enough funds.")
                    end
                end
            end
            TriggerClientEvent("billing:refreshui", src)
        end
    end)
end)