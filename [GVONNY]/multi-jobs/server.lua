ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local discord_webhook = {url = "https://discord.com/api/webhooks/863790069059813406/RGXqIdef_TAWX8L1WxI04yFUc35-9cCrkx9-SQFf6vJNbSBildiYnJ0b85UTfJQXTdwK",image = "https://i.iodine.gg/i5fba.png"}

RegisterServerEvent("jobsignonoff")
AddEventHandler("jobsignonoff", function(name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name

    if(job == name) then
        xPlayer.setJob("unemployed", 0)
        MySQL.Async.execute("UPDATE users SET job = 'unemployed', job_grade = 0 WHERE identifier = @identifier", {['@identifier'] = identifier})
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'You are now off duty', style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
    else
        MySQL.Async.fetchAll("SELECT job, job_grade FROM multi_job WHERE job = @job AND identifier = @identifier", {['@job'] = name, ['@identifier'] = xPlayer.identifier}, function(multi)
            if(multi and #multi>0) then
                local job_grade = multi[1].job_grade
                xPlayer.setJob(name, job_grade)
                MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @grade WHERE identifier = @identifier", {['@job'] = name, ['@grade'] = job_grade, ['@identifier'] = identifier})
                TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'You are now on duty', style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
            else
                TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "You can not an member of this organization", })
            end
        end)
    end
end)

RegisterServerEvent("bossmenuhiremultijob")
AddEventHandler("bossmenuhiremultijob", function(luckyNumber, job)
    local xPlayer = ESX.GetPlayerFromId(luckyNumber)
    MySQL.Async.execute("INSERT INTO multi_job (identifier, job, job_grade) VALUES(@identifier, @job, 0)", {['@identifier'] = xPlayer.identifier, ['@job'] = job})
end)

RegisterServerEvent("bossmenufiremultijob")
AddEventHandler("bossmenufiremultijob", function(identifier, job)
    print(identifier)
    MySQL.Async.execute("DELETE FROM multi_job WHERE identifier = @identifier AND job = @job", {['@identifier'] = identifier, ['@job'] = job})
end)

RegisterServerEvent("bossmenusetmultijobrank")
AddEventHandler("bossmenusetmultijobrank", function(identifier, job, grade)
    MySQL.Async.execute("UPDATE multi_job SET job_grade = @grade WHERE identifier = @identifier AND job = @job", {['@identifier'] = identifier, ['@job'] = job, ['@grade'] = grade})
end)