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
AddEventHandler("createtrial", function(track, model, laps)
    MySQL.Async.execute("INSERT INTO time_trial_setups (track, model, prizepool, active, laps) VALUES (@track, @model, 0, 0, @laps)", {['@track'] = track, ['@model'] = model, ['@laps'] = laps})
end)

RegisterServerEvent("createtrialtime")
AddEventHandler("createtrialtime", function(track, model, minutes, seconds, milliseconds)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT minutes, seconds, milliseconds FROM time_trial_times WHERE identifier = @identifier AND track = @track AND model = @model", {['@identifier'] = xPlayer.identifier, ['@track'] = track, ['@model'] = model}, function(results)
        if(results and #results>0) then
            local dbminutes = tonumber(results[1].minutes)
            local dbseconds = tonumber(results[1].seconds)
            local dbmilliseconds = tonumber(results[1].milliseconds)

            if(tonumber(minutes) < dbminutes) then
                MySQL.Async.execute("UPDATE time_trial_times SET minutes = @minutes, seconds = @seconds, milliseconds = @milliseconds WHERE identifier = @identifier AND track = @track AND model = @model", {
                    ['@minutes'] = minutes,
                    ['@seconds'] = seconds,
                    ['@milliseconds'] = milliseconds,
                    ['@identifier'] = xPlayer.identifier,
                    ['@track'] = track,
                    ['@model'] = model,
                })
            elseif(tonumber(minutes) == dbminutes) then
                if(tonumber(seconds) < dbseconds) then
                    MySQL.Async.execute("UPDATE time_trial_times SET seconds = @seconds, milliseconds = @milliseconds WHERE identifier = @identifier AND track = @track AND model = @model", {
                        ['@seconds'] = seconds,
                        ['@milliseconds'] = milliseconds,
                        ['@identifier'] = xPlayer.identifier,
                        ['@track'] = track,
                        ['@model'] = model,
                    })
                elseif(tonumber(seconds) == dbseconds) then
                    if(tonumber(milliseconds) < dbmilliseconds) then
                        MySQL.Async.execute("UPDATE time_trial_times SET milliseconds = @milliseconds WHERE identifier = @identifier AND track = @track AND model = @model", {
                            ['@milliseconds'] = milliseconds,
                            ['@identifier'] = xPlayer.identifier,
                            ['@track'] = track,
                            ['@model'] = model,
                        })
                    end
                end
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
end)

RegisterServerEvent("getactivetrials")
AddEventHandler("getactivetrials", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)

    Citizen.Wait(100)
    MySQL.Async.fetchAll("SELECT DISTINCT(track) FROM time_trial_setups", {}, function(tracks)
        if(tracks and #tracks>0) then
            for x=1,#tracks,1 do
                local track = tracks[x].track
                TriggerClientEvent("racing:setuptracktable", src, track)
                TriggerClientEvent("racing:addtotrackdropdown", src, track)

                MySQL.Async.fetchAll("SELECT a.model, a.prizepool, a.active, a.laps, b.name FROM time_trial_setups a, vehicles b WHERE a.track = @track AND b.model = a.model", {['@track'] = track}, function(options)
                    if(options and #options>0) then
                        for y=1,#options,1 do
                            local model = options[y].model
                            local name = options[y].name
                            local prizepool = options[y].prizepool
                            local active = options[y].active
                            local laps = options[y].laps

                            TriggerClientEvent("racing:addmodeltotracktable", src, track, model, name, prizepool, active, laps)
                        end
                    end
                end)
            end
            MySQL.Async.fetchAll("SELECT model, name FROM vehicles ORDER BY name", {}, function(vehicles)
                if(vehicles and #vehicles>0) then
                    for x=1,#vehicles,1 do
                        local model = vehicles[x].model
                        local name = vehicles[x].name
        
                        TriggerClientEvent("racing:addtovehicledropdown", src, model, name)
                    end
                end
            end)
        end
    end)
end)

RegisterServerEvent("activatetrial")
AddEventHandler("activatetrial", function(track, model)
    MySQL.Async.fetchAll("SELECT prizepool FROM time_trial_setups WHERE track = @track AND model = @model", {['@track'] = track, ['@model'] = model}, function(prize)
        if(prize and #prize>0) then
            local prizepool = tonumber(prize[1].prizepool)

            prizepool = prizepool + 500

            MySQL.Async.execute("UPDATE time_trial_setups SET prizepool = @prizepool, active = 1 WHERE track = @track AND model = @model", {['@prizepool'] = prizepool, ['@track'] = track, ['@model'] = model})
        end
    end)
end)

RegisterServerEvent("deactivatetrial")
AddEventHandler("deactivatetrial", function(track, model)
    MySQL.Async.execute("UPDATE time_trial_setups SET active = 0 WHERE track = @track AND model = @model", {['@track'] = track, ['@model'] = model})   
end)

RegisterServerEvent("deletetrial")
AddEventHandler("deletetrial", function(track, model)
    MySQL.Async.execute("DELETE FROM time_trial_setups WHERE track = @track AND model = @model", {['@track'] = track, ['@model'] = model})
    MySQL.Async.execute("DELETE FROM time_trial_times WHERE track = @track AND model = @model", {['@track'] = track, ['@model'] = model})
end)