ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('trialisactive', function(source, cb, track, model)
    MySQL.Async.fetchAll("SELECT active FROM time_trial_setups WHERE track = @track AND model = @model", {['@track'] = track, ['@model'] = model}, function(result)
        if(result and #result>0) then
            local active = result[1].active

            if(active == 1) then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('gettriallaps', function(source, cb, track, model)
    MySQL.Async.fetchAll("SELECT laps, track, model FROM time_trial_setups WHERE track = @track AND model = @model", {['@track'] = track, ['@model'] = model}, function(result)
        if(result and #result>0) then
            cb(result[1].laps, result[1].track, result[1].model)
        else
            cb(0)
        end
    end)
end)