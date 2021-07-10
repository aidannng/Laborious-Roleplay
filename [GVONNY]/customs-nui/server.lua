ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterServerEvent("search")
AddEventHandler("search", function()
    local src = source
    MySQL.Async.fetchAll("SELECT plate FROM bbvehicles", {} ,function(result)
        if(#result > 0) then
            results = result[1].plate .. ","
            for x=2,#result do 
                results = results .. result[x].plate .. ","
            end
            TriggerClientEvent('addplates', src, results)
        else
            print("no results")
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No results' })
        end
    end)
end)