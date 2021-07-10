ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local discord_webhook = {url = "https://discord.com/api/webhooks/863176051592658964/kOOsOrCLfUNRJ5ivaydSOj3V5QecTj9R45Mk2sFS0WykaG-C28aId3RgkiWHRYE7BDtp",image = "https://i.iodine.gg/i5fba.png"}


RegisterCommand("report", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = tonumber(source)
    local theId = ESX.GetPlayerFromId(playerId)
    --local args = table.concat(args, " ")
   
    if (#args > 0) then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Your report has been submitted', })

            MySQL.Async.fetchScalar('SELECT COUNT(1) FROM labrp_reports', {}, function(result)
            local maxnumber = tonumber(result)+1

            local reportreason = ""
            for x=1,#args do
                reportreason = reportreason .. " " .. args[x]
            end

            MySQL.Async.execute("INSERT into labrp_reports (reportnumber, identifier, state, reason, closereason) VALUES (@reportnumber,@identifier,@state,@reason,@closereason)", {
                ['@reportnumber'] = maxnumber,
                ['@identifier'] = xPlayer.getIdentifier(),
                ['@state'] = "open", 
                ['@reason'] = reportreason,
                ['@closereason'] = ""
                })

                PerformHttpRequest(discord_webhook.url, 
				function(err, text, header) end, 
				'POST', 
				json.encode({username = "LABRP | Staff Logs", content = "`NEW REPORT:` **" .. xPlayer.getName() .. "**(" .. xPlayer.getIdentifier() .. ") The report ID is: **" .. maxnumber .. "**. The user's ID is: **" .. playerId .. "** The reason for the report was: **" .. reportreason .. "** ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

            end)
            if havePermission(xPlayer, {'juniormoderator', 'communityhelper'}) then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'A new report has been submitted. Please check the server report logs in the Discord for more information', length = 6000})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Please enter a reason for the report', })
    end
end)

RegisterCommand("openreports", function(source, args)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if havePermission(xPlayer, {'juniormoderator', 'communityhelper'}) then
            MySQL.Async.fetchAll("SELECT reportnumber,identifier,reason FROM labrp_reports WHERE state = @state ORDER BY reportnumber",{['@state'] = "open"},function(result)
                if(#result > 0) then
                    for x=1,#result do
                        local id = result[x].identifier
                        MySQL.Async.fetchAll("SELECT firstname,lastname FROM users WHERE identifier = @id",{['@id'] = id},function(result2)
                            TriggerClientEvent('chat:addMessage', xPlayer.source, {
                                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} <br> {1} </div>',
                                args = { "^*Report ID: (^4" .. result[x].reportnumber ..   "^0) | Report By:^4 " .. result2[1].firstname .. " " .. result2[1].lastname, "^0^*Reason: ^4" .. result[x].reason }
                            });
                        end)
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'There are no open reports' })
                end
            end)
        else
            TriggerClientEvent('chat:addMessage', xPlayer.source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} <br> {1} </div>',
                args = { "[^4LABRP] You do not have permission to execute that command" }
            });
        end
    end
end)

RegisterCommand("closereport", function(source, args, rawCommand)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if havePermission(xPlayer, {'juniormoderator', 'communityhelper'}) then
            local reportnumber = args[1]
            local closereason = ""
            for x=2,#args do
                closereason = closereason .. " " .. args[x]
            end
            MySQL.Async.fetchAll("SELECT state FROM labrp_reports WHERE reportnumber = @reportnumber", {['@reportnumber'] = reportnumber}, function(result)
                if(result[1].state ~= "closed") then
                    if (#args > 1) then
                        MySQL.Async.execute("UPDATE labrp_reports SET state = @state, closereason = @closereason WHERE reportnumber = @reportnumber", 
                        {
                            ['@reportnumber'] = reportnumber,
                            ['@state'] = "closed",
                            ['@closereason'] = closereason
                        })
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have closed report ' .. reportnumber })
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Please enter a close reason' })
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'This report is already closed' })
                end
            end)
        else
            TriggerClientEvent('chat:addMessage', xPlayer.source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} <br> {1} </div>',
                args = { "[^4LABRP] You do not have permission to execute that command" }
            });
        end
    end
end)