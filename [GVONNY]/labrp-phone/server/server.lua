ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('labrp-phone:get:user-phone-number', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(user)
        if(user and #user > 0) then
            cb(user)
        end
    end)
end)

--##########################
--###      CONTACTS      ###
--##########################

ESX.RegisterServerCallback('labrp-phone:get:user-group', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT `group` FROM `users` WHERE `identifier` = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(group)
        if(group and #group > 0) then
            cb(group[1].group)
        end
    end)
end)

RegisterServerEvent("labrp-phone:add:contact")
AddEventHandler("labrp-phone:add:contact", function(name, number)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.execute("INSERT INTO phone_contacts (identifier, name, number, favorite) VALUES (@identifier, @name, @number, @favorite)",{
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name,
        ['@number'] = number,
        ['@favorite'] = false,
    })
end)

ESX.RegisterServerCallback('labrp-phone:get:contacts', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT name, number, favorite FROM phone_contacts WHERE identifier = @identifier ORDER BY favorite desc, name", {
        ['@identifier'] = xPlayer.identifier
    }, function(contacts)
        if(contacts and #contacts > 0) then
            cb(contacts)
        end
    end)
end)

RegisterServerEvent("labrp-phone:favorite:contact", function(number, favorite)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.execute("UPDATE phone_contacts SET favorite = @favorite WHERE identifier = @identifier AND number = @number",{
        ['@favorite'] = favorite,
        ['@identifier'] = xPlayer.identifier,
        ['@number'] = number,
    })
end)

RegisterServerEvent("labrp-phone:delete:contact", function(number)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.execute("DELETE FROM phone_contacts WHERE identifier = @identifier AND number = @number", {
        ['@identifier'] = xPlayer.identifier,
        ['@number'] = number,
    })
end)

RegisterServerEvent("labrp-phone:add:share-contact", function(number, name, id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local target = ESX.GetPlayerFromId(id)

    if(target ~= nil) then
        MySQL.Async.execute("INSERT INTO phone_contacts (identifier, name, number, favorite) VALUES (@identifier, @name, @number, @favorite)", {
            ['@identifier'] = target.identifier,
            ['@number'] = number,
            ['@name'] = name,
            ['@favorite'] = false
        })

        local text = 'Contact '..name..' added'
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Contact shared', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
        TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = text, style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })    
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Player not found' })
    end
end)

--##########################
--###      VEHICLES      ###
--##########################

ESX.RegisterServerCallback('labrp-phone:get:vehicles', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT a.name, b.garage, b.plate FROM vehicles a, owned_vehicles b WHERE a.model = b.model AND b.owner = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(vehicles)
        if(vehicles and #vehicles > 0) then
            cb(vehicles)
        end
    end)
end)

--##########################
--###      MESSAGES      ###
--##########################

RegisterServerEvent("labrp-phone:get:messages")
AddEventHandler("labrp-phone:get:messages", function(number)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT receiver, MAX(id) as maxid, isRead, message FROM phone_messages WHERE sender = @number AND senderDeleted = @false GROUP BY receiver UNION SELECT sender, MAX(id) as maxid, isRead, message FROM phone_messages WHERE receiver = @number AND receiverDeleted = @false GROUP BY sender ORDER BY maxid DESC", {
        ['@number'] = number,
        ['@false'] = false,
    }, function(results)
        if(results and #results>0) then
            for x=1,#results,1 do
                local duplicate = false
                for y=1,x-1,1 do
                    if(results[y].receiver == results[x].receiver) then
                        duplicate = true
                    end
                end
                if(not duplicate) then
                    MySQL.Async.fetchAll("SELECT name, number FROM phone_contacts WHERE identifier = @identifier AND number = @unique", {
                        ['@unique'] = results[x].receiver,
                        ['@identifier'] = xPlayer.identifier,
                    }, function(contact)
                        if(contact and #contact>0) then
                            TriggerClientEvent("labrp-phone:add-to:messages-list", src, contact[1].name, contact[1].number, true, x, results[x].isRead, results[x].message)
                        else
                            TriggerClientEvent("labrp-phone:add-to:messages-list", src, results[x].receiver, results[x].receiver, false, x, results[x].isRead, results[x].message)
                        end
                    end)
                end
                Citizen.Wait(3)
            end
        end
    end)
end)

ESX.RegisterServerCallback('labrp-phone:get:message-texts', function(source, cb, mynumber, number)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT sender, message FROM phone_messages WHERE (sender = @mynumber AND receiver = @receiver AND senderDeleted = @false) OR (sender = @receiver AND receiver = @mynumber AND receiverDeleted = @false) ORDER BY id", {
        ['@mynumber'] = mynumber,
        ['@receiver'] = number,
        ['@false'] = false,
    }, function(messages)
        if(messages and #messages>0) then
            MySQL.Async.execute("UPDATE phone_messages SET isRead = @true WHERE receiver = @mynumber AND sender = @number",{
                ['@true'] = true,
                ['@mynumber'] = mynumber,
                ['@number'] = number,
            })
            cb(messages)
        end
    end)
end)

RegisterServerEvent("labrp-phone:send:text-message")
AddEventHandler("labrp-phone:send:text-message", function(sender, receiver, message)
    --print("sending text")
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.execute("INSERT INTO `phone_messages` (`sender`, `receiver`, `message`, `isRead`, `senderDeleted`, `receiverDeleted`) VALUES (@sender, @receiver, @message, @false, @false, @false)",{
        ['@sender'] = sender,
        ['@receiver'] = receiver,
        ['@message'] = message,
        ['@false'] = false
    });

    MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @receiver",{
        ['@receiver'] = receiver,
    }, function(user)
        if(user and #user>0) then
            MySQL.Async.execute("INSERT INTO `phone_notifications` (`identifier`, `from`, `app`, `text`) VALUES (@identifier, @from, @app, @text)", {
                ['@identifier'] = user[1].identifier,
                ['@from'] = xPlayer.identifier,
                ['@app'] = 'messages',
                ['@text'] = 'New text message'
            })

            local target = ESX.GetPlayerFromIdentifier(user[1].identifier)
            if(target ~= nil) then
                TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = 'New text message', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
            end
            --TriggerClientEvent("labrp-phone:open", target.source)
        end
    end)
end)

RegisterServerEvent("labrp-phone:delete:message-history")
AddEventHandler("labrp-phone:delete:message-history", function(mynumber, receiver)
    MySQL.Async.fetchAll("UPDATE phone_messages SET senderDeleted = @true WHERE sender = @mynumber AND receiver = @receiver",{
        ['@true'] = true,
        ['@mynumber'] = mynumber,
        ['@receiver'] = receiver,
    })

    MySQL.Async.fetchAll("UPDATE phone_messages SET receiverDeleted = @true WHERE receiver = @mynumber AND sender = @receiver",{
        ['@true'] = true,
        ['@mynumber'] = mynumber,
        ['@receiver'] = receiver,
    })
end)

--##########################
--###        PHONE       ###
--##########################

ESX.RegisterServerCallback('labrp-phone:check:is-contact', function(source, cb, number)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT name FROM phone_contacts WHERE identifier = @identifier AND number = @number", {
        ['@number'] = number,
        ['@identifier'] = xPlayer.identifier
    }, function(contact)
        if(contact and #contact > 0) then
            cb(contact[1].name)
        else
            cb(number)
        end
    end)
end)

ESX.RegisterServerCallback('labrp-phone:get:src-from-number', function(source, cb, number)
    MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @number",{
        ['@number'] = number,
    }, function(user)
        if(user and #user>0) then
            local target = ESX.GetPlayerFromIdentifier(user[1].identifier)
            if(target ~= nil) then
                cb(target.source)
            end
        end
    end)
end)

RegisterServerEvent("labrp-phone:open:start-call")
AddEventHandler("labrp-phone:open:start-call", function(number, caller)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    --print("caller: "..caller)
    --print("receiver: "..number)

    --print("starting call")
    MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @number",{
        ['@number'] = number,
    }, function(user)
        if(user and #user>0) then
            --print("found users")
            local target = ESX.GetPlayerFromIdentifier(user[1].identifier)
            if(target ~= nil) then
                --print("target exists")

                local name = nil
                MySQL.Async.fetchAll("SELECT name FROM phone_contacts WHERE identifier = @identifier AND number = @number", {
                    ['@identifier'] = target.identifier,
                    ['@number'] = caller
                }, function(contact)
                    if(contact and #contact>0) then
                        name = contact[1].name
                    else
                        name = caller
                    end                    
                end)

                MySQL.Async.fetchAll("SELECT isCalling FROM phone_calls WHERE isCalling = @true AND (receiver = @number OR caller = @number) ORDER BY id DESC",{
                    ['@number'] = number,
                    ['@true'] = true,
                }, function(call)
                    if(call and #call>0) then
                        local active = call[1].isCalling
                        --print(not active)
                        if(active) then
                            --print("user in call already")
                        local text = 'Incoming call: '..name
                            TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = text, style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

                            MySQL.Async.execute("INSERT INTO phone_calls (receiver, caller, time, isCalling, accepted, callActive, wasUnavailable) VALUES (@number, @caller, @time, @true, @false, @false, @true)", {
                                ['@number'] = number,
                                ['@caller'] = caller,
                                ['@time'] = 0,
                                ['@false'] = false,
                                ['@true'] = true,
                            })
                            TriggerClientEvent("labrp-phone:update:change-calling", src, true)
                        end
                    else
                        --print("user is available")
                        local text = 'Incoming call: '..name
                        TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = text, style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

                        TriggerClientEvent("labrp-phone:open:app", target.source, "incoming-call")
                        TriggerClientEvent("labrp-phone:update:caller-name", target.source, caller)
                        TriggerClientEvent("labrp-phone:update:change-calling", src, true)

                        MySQL.Async.execute("INSERT INTO phone_calls (receiver, caller, time, isCalling, accepted, callActive, wasUnavailable) VALUES (@number, @caller, @time, @true, @false, @false, @false)", {
                            ['@number'] = number,
                            ['@caller'] = caller,
                            ['@time'] = 0,
                            ['@false'] = false,
                            ["@true"] = true,
                        })
                    end
                end)
            else
                --print("target not in server")
                MySQL.Async.execute("INSERT INTO phone_calls (receiver, caller, time, isCalling, accepted, callActive, wasUnavailable) VALUES (@number, @caller, @time, @true, @false, @false, @true)", {
                    ['@number'] = number,
                    ['@caller'] = caller,
                    ['@time'] = 0,
                    ['@false'] = false,
                    ['@true']= true,
                })
                TriggerClientEvent("labrp-phone:update:change-calling", src, true)
            end
        else
            --print("target is not a user")
            MySQL.Async.execute("INSERT INTO phone_calls (receiver, caller, time, isCalling, accepted, callActive, wasUnavailable) VALUES (@number, @caller, @time, @true, @false, @false, @true)", {
                ['@number'] = number,
                ['@caller'] = caller,
                ['@time'] = 0,
                ['@false'] = false,
                ["@true"] = true,
            })
            TriggerClientEvent("labrp-phone:update:change-calling", src, true)
        end
    end)
end)

RegisterServerEvent("labrp-phone:update:call-accepted")
AddEventHandler("labrp-phone:update:call-accepted", function(number, caller)
    --print(number)
    --print(caller)
    MySQL.Async.fetchAll("SELECT MAX(id) as id FROM phone_calls WHERE isCalling = @true AND (receiver = @caller AND caller = @number)",{
        ['@true'] = true,
        ['@number'] = number,
        ['@caller'] = caller,
    }, function(call)
        if(call and #call>0) then
            MySQL.Async.execute("UPDATE phone_calls SET accepted = @true, callActive = @true WHERE receiver = @number AND caller = @caller AND id = @id", {
                ['@number'] = caller,
                ['@caller'] = number,
                ['@true'] = true,
                ['@false'] = false,
                ['@id'] = call[1].id
            })
        end
    end)
    

    MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @number",{
        ['@number'] = number,
    }, function(user)
        if(user and #user>0) then
            local target = ESX.GetPlayerFromIdentifier(user[1].identifier)
            TriggerClientEvent("labrp-phone:open:app", target.source, "call-connected")
            TriggerClientEvent("labrp-phone:update:caller-name", target.source, caller)
            TriggerClientEvent("labrp-phone:update:change-calling", target.source, false)
            TriggerClientEvent("labrp-phone:lockscreen-timer", target.source, false)
        end
    end)
end)

RegisterServerEvent("labrp-phone:server:end-call")
AddEventHandler("labrp-phone:server:end-call", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    TriggerClientEvent("labrp-phone:update:change-calling", src, false)
    TriggerClientEvent("labrp-phone:client:end-call", src, src)

    MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(user)
        if(user and #user>0) then
            MySQL.Async.fetchAll("SELECT id, receiver, caller FROM phone_calls WHERE isCalling = @true AND (receiver = @number OR caller = @number) ORDER BY id", {
                ['@true'] = true,
                ['@false'] = false,
                ['@number'] = user[1].phone_number,
            }, function(call)
                if(call and #call>0) then
                    --print("updating call")
                    --print(call[1].id)
                    MySQL.Async.execute("UPDATE phone_calls SET callActive = @false, isCalling = @false WHERE id = @id",{
                        ['@false'] = false,
                        ['@id'] = call[1].id,
                    })

                    if(call[1].receiver == user[1].phone_number) then
                        MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @number",{
                            ['@number'] = call[1].caller,
                        }, function(user)
                            if(user and #user>0) then
                                local target = ESX.GetPlayerFromIdentifier(user[1].identifier)
                                if(target ~= nil) then
                                    TriggerClientEvent("labrp-phone:client:end-call", target.source, target.source)
                                    TriggerClientEvent("labrp-phone:lockscreen-timer", target.source, false)
                                end
                            end
                        end)
                    else
                        MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @number",{
                            ['@number'] = call[1].receiver,
                        }, function(user)
                            if(user and #user>0) then
                                local target = ESX.GetPlayerFromIdentifier(user[1].identifier)
                                if(target ~= nil) then
                                    TriggerClientEvent("labrp-phone:client:end-call", target.source, target.source)
                                    TriggerClientEvent("labrp-phone:lockscreen-timer", target.source, false)
                                end
                            end
                        end)
                    end
                else
                    MySQL.Async.execute("UPDATE phone_calls SET isCalling = @false WHERE receiver = @number OR caller = @number",{
                        ['@number'] = user[1].phone_number,
                        ['@false'] = false,
                    })
                end
            end)
        end
    end)
end)

RegisterServerEvent("labrp-phone:update:call-to-inactive")
AddEventHandler("labrp-phone:update:call-to-inactive", function(number)
    --print("setting call inactive")
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT caller, receiver, caller FROM phone_calls WHERE receiver = @number OR caller = @number ORDER BY id DESC LIMIT 1",{
        ['@true'] = true,
        ['@number'] = number
    }, function(call)
        if(call and #call>0) then
            MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @receiver",{
                ['@receiver'] = call[1].receiver
            }, function(user)
                if(user and #user>0) then
                    MySQL.Async.fetchAll("SELECT name FROM phone_contacts WHERE identifier = @identifier AND number = @caller",{
                        ['@identifier'] = user[1].identifier,
                        ['@caller'] = call[1].caller
                    }, function(contact)
                        local text = 'Missed call from '..call[1].caller
                        if(contact and #contact>0) then
                            text = 'Missed call from '..contact[1].name
                        end
                        MySQL.Async.execute("INSERT INTO `phone_notifications` (`identifier`, `from`, `app`, `text`) VALUES (@identifier, @from, @app, @text)",{
                            ['@identifier'] = user[1].identifier,
                            ['@from'] = xPlayer.identifier,
                            ['@app'] = 'phone',
                            ['@text'] = text,
                        })
                        local target = ESX.GetPlayerFromIdentifier(user[1].identifier)
                        if(target ~= nil) then
                            TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = 'Missed call', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
                        end
                        
                        MySQL.Async.execute("UPDATE phone_calls SET callActive = @false, isCalling = @false, wasUnavailable = @true WHERE isCalling = @true AND (receiver = @number OR caller = @number)",{
                            ['@number'] = number,
                            ['@false'] = false,
                            ['@true'] = true
                        })
                    end)
                end
            end)
        end
    end)
end)

ESX.RegisterServerCallback("labrp-phone:get:call-history", function(source, cb, number)
    MySQL.Async.fetchAll("SELECT caller, receiver, accepted FROM phone_calls WHERE caller = @number OR receiver = @number ORDER BY id DESC",{
        ['@number'] = number,
    }, function(calls)
        if(calls and #calls>0) then
            cb(calls)
        end
    end)
end)

ESX.RegisterServerCallback("labrp-phone:get:favorite-contacts", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT name, number FROM phone_contacts WHERE identifier = @identifier AND favorite = @true ORDER BY name",{
        ['@identifier'] = xPlayer.identifier,
        ['@true'] = true,
    }, function(contacts)
        if(contacts and #contacts>0) then
            cb(contacts)
        end
    end)
end)

--##########################
--###        INFO        ###
--##########################

ESX.RegisterServerCallback('labrp-phone:get:licenses', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT a.type, b.label FROM user_licenses a, licenses b WHERE a.owner = @identifier AND a.type = b.type",{
        ['@identifier'] = xPlayer.identifier,
    }, function(licenses)
        if(licenses and #licenses>0) then
            cb(licenses)
        end
    end)
end)

ESX.RegisterServerCallback('labrp-phone:get:bank-accounts', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local grade = xPlayer.job.grade
    local accounts = {}

    local getAccounts = xPlayer.getAccounts()
    for x=1,#getAccounts do
        if(getAccounts[x].name == "bank") then
            table.insert(accounts, {account = "checking", balance = getAccounts[x].money})
        end
    end

    MySQL.Async.fetchAll("SELECT ibanNumber FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(user)
        if(user and #user>0) then
            MySQL.Async.fetchAll("SELECT amount FROM bbanking_accounts WHERE identifier = @iban AND type = @type", {
                ['@iban'] = user[1].ibanNumber,
                ['@type'] = "saving",
            }, function(savings)
                if(savings and #savings>0) then
                    table.insert(accounts, {account = "savings", balance = savings[1].amount})
                end
            end)
        end
    end)

    Wait(50)

    MySQL.Async.fetchAll("SELECT MAX(a.grade) as grade, b.amount FROM job_grades a, jobs b WHERE a.job_name = @job AND a.job_name = b.name", {
        ['@job'] = xPlayer.job.name
    }, function(job)
        if(job and #job>0) then
            if(job[1].grade == grade) then
                table.insert(accounts, {account = "business", balance = job[1].amount})
            end
        end
    end)

    Wait(100)
    cb(accounts)
end)

ESX.RegisterServerCallback('labrp-phone:get:paycheck', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT collectmoney FROM users WHERE identifier = @identifier",{
        ['@identifier'] = xPlayer.identifier,
    }, function(paycheck)
        if(paycheck and #paycheck>0) then
            cb(paycheck[1].collectmoney)
        end
    end)
end)

--##########################
--###       TWITTER      ###
--##########################

RegisterServerEvent("labrp-phone:add:tweet")
AddEventHandler("labrp-phone:add:tweet", function(tweet)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(user)
        local handle = string.lower(user[1].firstname)..'_'..string.lower(user[1].lastname)

        MySQL.Async.execute("INSERT INTO tweets (identifier, handle, text) VALUES (@identifier, @handle, @text)", {
            ['@identifier'] = xPlayer.identifier,
            ['@handle'] = handle,
            ['@text'] = tweet,
        })

        TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'inform', text = 'New tweet', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
    end)
end)

ESX.RegisterServerCallback('labrp-phone:get:tweets', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT id, identifier, handle, text, likes FROM tweets ORDER BY id DESC",{
    },function(tweets)
        if(tweets and #tweets>0) then
            cb(tweets)
        end
    end)
end)

ESX.RegisterServerCallback("labrp-phone:get:if-tweet-liked", function(source, cb, id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT identifier FROM twitter_likes WHERE identifier = @identifier AND tweet_id = @id", {
        ['@identifier'] = xPlayer.identifier,
        ['@id'] = id
    }, function(liked)
        if(liked and #liked>0) then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent("labrp-phone:like:tweet")
AddEventHandler("labrp-phone:like:tweet", function(liked, tweet)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if(liked) then
        MySQL.Async.execute("INSERT INTO twitter_likes (tweet_id, identifier) VALUES (@id, @identifier)", {
            ['@id'] = tweet,
            ['@identifier'] = xPlayer.identifier
        })
    else
        MySQL.Async.execute("DELETE FROM twitter_likes WHERE tweet_id = @id AND identifier = @identifier", {
            ['@id'] = tweet,
            ['@identifier'] = xPlayer.identifier
        })
    end

    MySQL.Async.fetchAll("SELECT identifier, likes FROM tweets WHERE id = @id",{
        ['@id'] = tweet
    }, function(post)
        if(post and #post>0) then
            local total = post[1].likes
            if(liked) then
                total = total + 1
            else
                total = total - 1
            end

            MySQL.Async.execute("UPDATE tweets SET likes = @total WHERE id = @id", {
                ['@total'] = total,
                ['@id'] = tweet
            })

            if(liked and xPlayer.identifier ~= post[1].identifier) then
                MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier",{
                    ['@identifier'] = xPlayer.identifier
                }, function(user)
                    if(user and #user>0) then
                        local username = "@"..string.lower(user[1].firstname).."_"..string.lower(user[1].lastname)
                        MySQL.Async.execute("INSERT INTO `phone_notifications` (`identifier`, `from`, `app`, `text`) VALUES (@identifier, @from, @app, @text)",{
                            ['@identifier'] = post[1].identifier,
                            ['@from'] = xPlayer.identifier,
                            ['@app'] = "twitter",
                            ['@text'] = username.." liked your tweet",
                        })
                        local target = ESX.GetPlayerFromIdentifier(post[1].identifier)
                        TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = 'Someone liked your tweet', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

                        --TriggerClientEvent("labrp-phone:open", post[1].identifier)
                    end
                end)
            end
        end
    end)
end)

RegisterServerEvent("labrp-phone:delete:tweet")
AddEventHandler("labrp-phone:delete:tweet", function(tweet)
    MySQL.Async.execute("DELETE FROM tweets WHERE id = @id", {
        ['@id'] = tweet
    })

    MySQL.Async.execute("DELETE FROM twitter_likes WHERE tweet_id = @id",{
        ['@id'] = tweet
    })
end)

--##########################
--###    YELLOW PAGES    ###
--##########################

RegisterServerEvent("labrp-phone:add:yellow-pages-ad")
AddEventHandler("labrp-phone:add:yellow-pages-ad", function(text, number)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(user)
        if(user and #user>0) then
            local name = user[1].firstname..' '..user[1].lastname
            MySQL.Async.execute("INSERT INTO phone_advertisement (identifier, name, number, message) VALUES (@identifier, @name, @number, @message)", {
                ['@identifier'] = xPlayer.identifier,
                ['@name'] = name,
                ['@number'] = number,
                ['@message'] = text,
            })
        end
    end)
end)

ESX.RegisterServerCallback('labrp-phone:get:yellow-pages', function(source, cb)
    MySQL.Async.fetchAll("SELECT id, name, number, message FROM phone_advertisement ORDER BY id DESC", {},
    function(ads)
        if(ads and #ads>0) then
            cb(ads)
        end
    end)
end)

RegisterServerEvent("labrp-phone:delete:yellow-pages-ad")
AddEventHandler("labrp-phone:delete:yellow-pages-ad", function(ad)
    MySQL.Async.execute("DELETE FROM phone_advertisement WHERE id = @id", {
        ['@id'] = ad
    })
end)

ESX.RegisterServerCallback("labrp-phone:get:if-own-yellow-page", function(source, cb, id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT identifier FROM phone_advertisement WHERE id = @id",{
        ['@id'] = id
    }, function(ad)
        if(ad and #ad>0) then
            if(ad[1].identifier == xPlayer.identifier) then
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)

--##########################
--###         PING       ###
--##########################

RegisterServerEvent("labrp-phone:server:ping-player")
AddEventHandler("labrp-phone:server:ping-player", function(id, x, y)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local target = ESX.GetPlayerFromId(id)
    if(target ~= nil) then
        MySQL.Async.execute("INSERT INTO `phone_notifications` (`identifier`, `from`, `app`, `text`, `ping_x`, `ping_y`) VALUES (@identifier, @from, @app, @text, @pingx, @pingy)",{
            ['@identifier'] = target.identifier,
            ['@from'] = xPlayer.identifier,
            ['@app'] = "ping",
            ['@text'] = "Click to accept ping",
            ['@pingx'] = x,
            ['@pingy'] = y,
        })
        --TriggerClientEvent("labrp-phone:open", target.source)
        TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = 'Ping received', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Ping sent', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

    end
end)

RegisterServerEvent("labrp-phone:server:ping-contact")
AddEventHandler("labrp-phone:server:ping-contact", function(number, x, y)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @number",{
        ['@number'] = number,
    }, function(user)
        if(user and #user>0) then
            local target = ESX.GetPlayerFromIdentifier(user[1].identifier)
            if(target ~= nil) then
                MySQL.Async.execute("INSERT INTO `phone_notifications` (`identifier`, `from`, `app`, `text`, `ping_x`, `ping_y`) VALUES (@identifier, @from, @app, @text, @pingx, @pingy)",{
                    ['@identifier'] = target.identifier,
                    ['@from'] = xPlayer.identifier,
                    ['@app'] = "ping",
                    ['@text'] = "Click to accept ping",
                    ['@pingx'] = x,
                    ['@pingy'] = y,
                })
                --TriggerClientEvent("labrp-phone:open", target.source)
                TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = 'Ping received', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

                TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Ping sent', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

            end
        end
    end)
end)

RegisterServerEvent("labrp-phone:server:accept-ping")
AddEventHandler("labrp-phone:server:accept-ping", function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT ping_x, ping_y FROM phone_notifications WHERE id = @id",{
        ['@id'] = id
    }, function(ping)
        if(ping and #ping>0) then
            TriggerClientEvent("labrp-phone:client:ping-player", src, ping[1].ping_x, ping[1].ping_y)

            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Ping Accepted', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

            MySQL.Async.execute("DELETE FROM phone_notifications WHERE id = @id",{
                ['@id'] = id
            })
        end
    end)
end)

--##########################
--###         BOSS       ###
--##########################

ESX.RegisterServerCallback("labrp-phone:check:if-boss", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if(xPlayer.job.name ~= "unemployed") then
        MySQL.Async.fetchAll("SELECT label, job_name, grade FROM job_grades WHERE job_name = @job ORDER BY grade DESC LIMIT 1",{
            ['@job'] = xPlayer.job.name,
        }, function(grade)
            if(grade and #grade>0) then
                if(xPlayer.job.grade == grade[1].grade) then
                    cb(grade)
                else
                    cb(nil)
                end
            end
        end)
    else
        cb(nil)
    end
end)

ESX.RegisterServerCallback("labrp-phone:get:boss-menu-grades", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT job_name, grade, name, label FROM job_grades WHERE job_name = @name ORDER BY grade DESC", {
        ['@name'] = xPlayer.job.name
    }, function(grades)
        if(grades and #grades>0) then
            cb(grades)
        end
    end)
end)

ESX.RegisterServerCallback("labrp-phone:get:boss-menu-employees", function(source, cb, job, grade)
    MySQL.Async.fetchAll("SELECT identifier, firstname, lastname, job_grade FROM users WHERE job = @job AND job_grade = @grade ORDER BY firstname",{
        ['@job'] = job,
        ['@grade'] = grade,
    }, function(employees)
        if(employees and #employees>0) then
            cb(employees)
        end
    end)
end)

RegisterServerEvent("labrp-phone:update:boss-menu-promote")
AddEventHandler("labrp-phone:update:boss-menu-promote", function(identifier, grade, job)
    local target = ESX.GetPlayerFromIdentifier(identifier)
    if(target ~= nil and target.job.name == job) then
        target.setJob(job, grade)
        
        MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @grade WHERE identifier = @identifier",{
            ['@job'] = job,
            ['@grade'] = grade,
            ['@identifier'] = identifier,
        })
    end

    MySQL.Async.execute("UPDATE multi_job SET job_grade = @grade WHERE identifier = @identifier AND job = @job", {
        ['@job'] = job,
        ['@grade'] = grade,
        ['@identifier'] = target.identifier,
    })
end)

RegisterServerEvent("labrp-phone:update:boss-menu-fire")
AddEventHandler("labrp-phone:update:boss-menu-fire", function(identifier, job)
    local target = ESX.GetPlayerFromIdentifier(identifier)
    if(target ~= nil and target.job.name == job) then
        target.setJob('unemployed', 0)

        MySQL.Async.execute("UPDATE users SET job = 'unemployed', job_grade = @grade WHERE identifier = @identifier",{
            ['@identifier'] = identifier,
            ['@grade'] = 0,
        })
    end

    MySQL.Async.execute("DELETE FROM multi_job WHERE identifier = @identifier AND job = @job", {
        ['@identifier'] = target.identifier,
        ['@job'] = job,
    })
end)

RegisterServerEvent("labrp-phone:update:boss-menu-hire")
AddEventHandler("labrp-phone:update:boss-menu-hire", function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local target = ESX.GetPlayerFromId(id)

    if(target ~= nil) then
        target.setJob(xPlayer.job.name, 0)

        MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @grade WHERE identifier = @identifier",{
            ['@identifier'] = target.identifier,
            ['@job'] = xPlayer.job.name,
            ['@grade'] = 0,
        })
    
        MySQL.Async.fetchAll("SELECT id FROM multi_job WHERE identifier = @identifier AND job = @job", {
            ['@identifier'] = target.identifier,
            ['@job'] = xPlayer.job.name,
        },function(exists)
            if(#exists==0) then
                MySQL.Async.execute("INSERT INTO multi_job (identifier, job, job_grade) VALUES (@identifier, @job, @grade)", {
                    ['@identifier'] = target.identifier,
                    ['@job'] = xPlayer.job.name,
                    ['@grade'] = 0,
                })
            end
        end)
    end
end)

--##########################
--###    NOTIFICATIONS   ###
--##########################

ESX.RegisterServerCallback("labrp-phone:get:notifications", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT DISTINCT app FROM phone_notifications WHERE identifier = @identifier",{
        ['@identifier'] = xPlayer.identifier
    }, function(apps)
        if(apps and #apps>0) then
            cb(apps)
        end
    end)
end)

ESX.RegisterServerCallback("labrp-phone:get:app-notifications", function(source, cb, app)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT a.id, a.text, b.firstname, b.lastname, b.phone_number FROM phone_notifications a, users b WHERE a.app = @app AND a.identifier = @identifier AND a.from = b.identifier",{
        ['@identifier'] = xPlayer.identifier,
        ['@app'] = app
    }, function(notifications)
        if(notifications and #notifications>0) then
            cb(notifications)
        end
    end)
end)

RegisterServerEvent("labrp-phone:delete:notification")
AddEventHandler("labrp-phone:delete:notification", function(id)
    MySQL.Async.execute("DELETE FROM phone_notifications WHERE id = @id",{
        ['@id'] = id
    })
end)

RegisterServerEvent("labrp-phone:remove:notifications")
AddEventHandler("labrp-phone:remove:notifications", function(app)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.execute("DELETE FROM phone_notifications WHERE identifier = @identifier AND app = @app", {
        ['@identifier'] = xPlayer.identifier,
        ['@app'] = app
    })
end)

--##########################
--###      MULTI JOB     ###
--##########################

ESX.RegisterServerCallback("labrp-phone:get:current-player-job", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if(xPlayer ~= nil) then
        cb(xPlayer.job.name)
    end
end)

ESX.RegisterServerCallback("labrp-phone:get:multi-jobs", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT a.job, a.job_grade, b.label as job_label, c.label as grade_label FROM multi_job a, jobs b, job_grades c WHERE a.identifier = @identifier AND a.job = b.name AND a.job = c.job_name AND a.job_grade = c.grade ORDER BY b.label",{
        ['@identifier'] = xPlayer.identifier
    }, function(jobs)
        if(jobs and #jobs>0) then
            cb(jobs)
        end
    end)
end)

RegisterServerEvent("labrp-phone:set:job-unemployed")
AddEventHandler("labrp-phone:set:job-unemployed", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.setJob("unemployed", 0)

    MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @grade WHERE identifier = @identifier",{
        ['@job'] = "unemployed",
        ['@grade'] = 0,
        ['@identifier'] = xPlayer.identifier,
    })
end)

RegisterServerEvent("labrp-phone:set:multi-job")
AddEventHandler("labrp-phone:set:multi-job", function(job, grade)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.setJob(job, grade)

    MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @grade WHERE identifier = @identifier",{
        ['@job'] = job,
        ['@grade'] = grade,
        ['@identifier'] = xPlayer.identifier,
    })
end)

--##########################
--###        NOTES       ###
--##########################

RegisterServerEvent("labrp-phone:add:note", function(title, text)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.execute("INSERT INTO phone_notes (identifier, title, text) VALUES (@identifier, @title, @text)",{
        ['@identifier'] = xPlayer.identifier,
        ['@title'] = title,
        ["@text"] = text,
    })
end)

ESX.RegisterServerCallback("labrp-phone:get:notes", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT id, title, text FROM phone_notes WHERE identifier = @identifier ORDER BY id DESC", {
        ['@identifier'] = xPlayer.identifier
    }, function(notes)
        if(notes and #notes>0) then
            cb(notes)
        end
    end)
end)

ESX.RegisterServerCallback("labrp-phone:get:note", function(source, cb, id)
    MySQL.Async.fetchAll("SELECT id, title, text FROM phone_notes WHERE id = @id", {
        ['@id'] = id
    }, function(note)
        if(note and #note>0) then
            cb(note)
        end
    end)
end)

RegisterServerEvent("labrp-phone:update:note", function(id, text)
    MySQL.Async.execute("UPDATE phone_notes SET text = @text WHERE id = @id",{
        ['@id'] = id,
        ["@text"] = text,
    })
end)

RegisterServerEvent("labrp-phone:delete:note", function(id)
    MySQL.Async.execute("DELETE FROM phone_notes WHERE id = @id",{
        ['@id'] = id,
    })
end)

RegisterServerEvent("labrp-phone:add:share-note", function(noteid, id)
    local target = ESX.GetPlayerFromId(id)

    if(target ~= nil) then
        MySQL.Async.fetchAll("SELECT title, text FROM phone_notes WHERE id = @id",{
            ['@id'] = noteid
        }, function(note)
            if(note and #note>0) then
                MySQL.Async.execute("INSERT INTO phone_notes (identifier, title, text) VALUES (@identifier, @title, @text)", {
                    ['@identifier'] = target.identifier,
                    ['@title'] = note[1].title,
                    ['@text'] = note[1].text
                })
                TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Note shared', style = { ['border-left-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

            end
        end)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Nobody nearby' })

    end
end)