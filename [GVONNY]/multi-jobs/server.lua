ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)

        --MySQL.Async.fetchAll("SELECT a.plate, a.x, a.y, a.z, a.rotation, b.model FROM pdm_showroom a, bbvehicles b WHERE a.plate = b.plate", {}, function(vehicles)
        --[[ MySQL.Async.fetchAll("SELECT slot_id FROM pdm_showroom", {}, function(vehicles)
            if(vehicles ~= nil and #vehicles > 0) then
                for x=1,#vehicles,1 do
                    MySQL.Async.execute("UPDATE pdm_shoroom SET plate = NULL WHERE slot_id = @slotid", {['@slotid'] = vehicles[x].slot_id})
                end
            end
        end) ]]
    end
end)

local discord_webhook = {url = "https://discord.com/api/webhooks/863790069059813406/RGXqIdef_TAWX8L1WxI04yFUc35-9cCrkx9-SQFf6vJNbSBildiYnJ0b85UTfJQXTdwK",image = "https://i.iodine.gg/i5fba.png"}

RegisterServerEvent("mechanicsignonoff")
AddEventHandler("mechanicsignonoff", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name

    if(job == "mechanic") then
        xPlayer.setJob("unemployed", 0)
        MySQL.Async.execute("UPDATE users SET job = 'unemployed', job_grade = 0 WHERE identifier = @identifier", {['@identifier'] = identifier})
    else
        MySQL.Async.fetchAll("SELECT job_grade FROM multi_job WHERE job = 'mechanic' AND identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(multi)
            if(multi and #multi>0) then
                local job_grade = multi[1].job_grade
                xPlayer.setJob("mechanic", job_grade)
                MySQL.Async.execute("UPDATE users SET job = 'mechanic', job_grade = @grade WHERE identifier = @identifier", {['@grade'] = job_grade, ['@identifier'] = identifier})
            else
                TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "You can not a hired mechanic", })
            end
        end)
    end
end)

RegisterServerEvent("pdmsignonoff")
AddEventHandler("pdmsignonoff", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name

    if(job == "cardealer") then
        xPlayer.setJob("unemployed", 0)
        MySQL.Async.execute("UPDATE users SET job = 'unemployed', job_grade = 0 WHERE identifier = @identifier", {['@identifier'] = identifier})
    else
        MySQL.Async.fetchAll("SELECT job_grade FROM multi_job WHERE job = 'cardealer' AND identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(multi)
            if(multi and #multi>0) then
                local job_grade = multi[1].job_grade
                xPlayer.setJob("cardealer", job_grade)
                MySQL.Async.execute("UPDATE users SET job = 'cardealer', job_grade = @grade WHERE identifier = @identifier", {['@grade'] = job_grade, ['@identifier'] = identifier})
            else
                TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "You can not a hired car dealer", })
            end
        end)
    end
end)

RegisterServerEvent("ballassignonoff")
AddEventHandler("ballassignonoff", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name

    if(job == "ballas") then
        xPlayer.setJob("unemployed", 0)
        MySQL.Async.execute("UPDATE users SET job = 'unemployed', job_grade = 0 WHERE identifier = @identifier", {['@identifier'] = identifier})
    else
        MySQL.Async.fetchAll("SELECT job_grade FROM multi_job WHERE job = 'ballas' AND identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(multi)
            if(multi and #multi>0) then
                local job_grade = multi[1].job_grade
                xPlayer.setJob("ballas", job_grade)
                MySQL.Async.execute("UPDATE users SET job = 'ballas', job_grade = @grade WHERE identifier = @identifier", {['@grade'] = job_grade, ['@identifier'] = identifier})
            else
                TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "You can not a member of the ballas", })
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