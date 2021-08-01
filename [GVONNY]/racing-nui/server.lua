ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

end)

RegisterServerEvent("racingcheckjob")
AddEventHandler("racingcheckjob", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if(xPlayer.job.name ~= 'mechanic') then
        TriggerClientEvent("racing:hideadminfunctions", src, true)
    else
        TriggerClientEvent("racing:hideadminfunctions", src, false)
    end
end)


RegisterServerEvent("racinggettrackinfo")
AddEventHandler("racinggettrackinfo", function(track)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT a.model, b.name FROM time_trial_setups a, vehicles b WHERE a.track = @track AND b.model = a.model", {['@track'] = track}, function(options)
        if(options and #options>0) then
            for x=1,#options,1 do
                local model = options[x].model
                local name = options[x].name
                TriggerClientEvent("racing:addtodropdown", src, model, name, track)
                TriggerClientEvent("racing:setupvehicletable", src, model, name, track)

                MySQL.Async.fetchAll("SELECT a.firstname, a.lastname, b.minutes, b.seconds, b.milliseconds FROM users a, time_trial_times b WHERE a.identifier = b.identifier AND b.track = @track AND b.model = @model ORDER BY minutes, seconds, milliseconds LIMIT 5", {['@identifier'] = identifier, ['@track'] = track, ['@model'] = model}, function(times)
                    if(times and #times>0) then
                        for y=1,#times,1 do
                            local firstname = times[y].firstname
                            local lastname = times[y].lastname
                            local minutes = times[y].minutes
                            local seconds = times[y].seconds
                            local milliseconds = times[y].milliseconds
                            TriggerClientEvent("racing:addtomodel", src, firstname, lastname, minutes, seconds, milliseconds, model, y)
                        end 
                    end
                end)
            end
        end
        if(xPlayer.job.name ~= 'mechanic') then
            TriggerClientEvent("racing:hideadminfunctions", src, true)
        else
            TriggerClientEvent("racing:hideadminfunctions", src, false)
        end
    end)
    
end)

RegisterServerEvent("createtrial")
AddEventHandler("createtrial", function(track, luckynumber, model, minutes, seconds, milliseconds)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(luckynumber)

    MySQL.Async.fetchAll("SELECT minutes, seconds, milliseconds FROM time_trial_times WHERE identifier = @identifier AND track = @track AND model = @model", {['@identifier'] = xPlayer.identifier, ['@track'] = track, ['@model'] = model}, function(results)
        if(results and #results>0) then
            local dbminutes = tonumber(results[1].minutes)
            local dbseconds = tonumber(results[1].seconds)
            local dbmilliseconds = tonumber(results[1].milliseconds)

            if(tonumber(minutes) < dbminutes) then
                MySQL.Async.execute("UPDATE time_trial_times SET minutes = @minutes, seconds = @seconds, milliseconds = @milliseconds WHERE identifier = @identifier AND track = @track", {
                    ['@minutes'] = minutes,
                    ['@seconds'] = seconds,
                    ['@milliseconds'] = milliseconds,
                    ['@identifier'] = xPlayer.identifier,
                    ['@track'] = track,
                })
            elseif(tonumber(minutes) == dbminutes) then
                if(tonumber(seconds) < dbseconds) then
                    MySQL.Async.execute("UPDATE time_trial_times SET seconds = @seconds, milliseconds = @milliseconds WHERE identifier = @identifier AND track = @track", {
                        ['@seconds'] = seconds,
                        ['@milliseconds'] = milliseconds,
                        ['@identifier'] = xPlayer.identifier,
                        ['@track'] = track,
                    })
                elseif(tonumber(seconds) == dbseconds) then
                    if(tonumber(milliseconds) < dbmilliseconds) then
                        MySQL.Async.execute("UPDATE time_trial_times SET milliseconds = @milliseconds WHERE identifier = @identifier AND track = @track", {
                            ['@milliseconds'] = milliseconds,
                            ['@identifier'] = xPlayer.identifier,
                            ['@track'] = track,
                        })
                    else
                        TriggerClientEvent("racing:error", src, track, "Time entered was not quicker than previous runs")
                    end
                else
                    TriggerClientEvent("racing:error", src, track, "Time entered was not quicker than previous runs")
                end
            else
                TriggerClientEvent("racing:error", src, track, "Time entered was not quicker than previous runs")
            end    
        else
            MySQL.Async.execute("INSERT INTO time_trial_times (identifier, track, model, minutes, seconds, milliseconds) VALUES(@identifier, @track, @model, @minutes, @seconds, @milliseconds)",{
                ['@identifier'] = xPlayer.identifier,
                ['@track'] = track,
                ['@model'] = model,
                ['@minutes'] = minutes,
                ['@seconds'] = seconds,
                ['@milliseconds'] = milliseconds,
            })
        end
    end)

    MySQL.Async.fetchAll("SELECT prizepool FROM time_trial_setups WHERE track = @track AND model = @model", {['@track'] = track, ['@model'] = model}, function(prize)
        if(prize and #prize>0) then
            local prizepool = tonumber(prize[1].prizepool)

            prizepool = prizepool + 500

            MySQL.Async.execute("UPDATE time_trial_setups SET prizepool = @prizepool WHERE track = @track AND model = @model", {['@prizepool'] = prizepool, ['@track'] = track, ['@model'] = model})
        end
    end)
end)

RegisterServerEvent("getactivetrials")
AddEventHandler("getactivetrials", function()
    print("got to server")
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT DISTINCT(track) FROM time_trial_setups", {}, function(tracks)
        print(tracks and #tracks>0)
        if(tracks and #tracks>0) then
            for x=1,#tracks,1 do
                local track = tracks[x].track
                TriggerClientEvent("racing:setuptracktable", src, track)

                MySQL.Async.fetchAll("SELECT a.model, b.name FROM time_trial_setups a, vehicles b WHERE a.track = @track AND b.model = a.model", {['@track'] = track}, function(options)
                    if(options and #options>0) then
                        for y=1,#options,1 do
                            local model = options[y].model
                            local name = options[y].name
                            print(model)
                            print(name)

                            TriggerClientEvent("racing:addmodeltotracktable", src, track, model, name)
                        end
                    end
                end)
            end
        end
    end)
end)