ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pdduty:onoff')
AddEventHandler('pdduty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    
    if job == 'police' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went off duty!'})
    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went on duty!'})
    end

end)

RegisterServerEvent('bgduty:onoff')
AddEventHandler('bgduty:onoff', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'burgershot' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went off duty!'})
    elseif job == 'offburgershot' then
        xPlayer.setJob('burgershot', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went on duty!'})
    end
end)

RegisterServerEvent('emsduty:onoff')
AddEventHandler('emsduty:onoff', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'ambulance' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went off duty!'})
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went on duty!'})
    end
end)

RegisterServerEvent('towduty:onoff')
AddEventHandler('towduty:onoff', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'tow' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went off duty!'})
    elseif job == 'offtow' then
        xPlayer.setJob('tow', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went on duty!'})
    end
end) --mechduty:onoff

RegisterServerEvent('mechduty:onoff')
AddEventHandler('mechduty:onoff', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'mechanic' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went off duty!'})
    elseif job == 'offtow' then
        xPlayer.setJob('mechanic', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You went on duty!'})
    end
end)

