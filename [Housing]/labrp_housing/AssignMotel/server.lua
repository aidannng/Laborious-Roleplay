ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterNetEvent("loaf_assignmotel:loaded_character")
AddEventHandler("loaf_assignmotel:loaded_character", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.identifier then
        MySQL.Async.fetchScalar("SELECT `got_motel` FROM `users` WHERE `identifier`=@identifier", {["@identifier"] = xPlayer.identifier}, function(hasmotel)
            if not hasmotel then
                MySQL.Async.fetchScalar("SELECT `identifier` FROM `loaf_motel` WHERE `identifier`=@identifier", {["@identifier"] = xPlayer.identifier}, function(hasbought)
                    if not hasbought then
                        TriggerClientEvent("loaf_assignmotel:buyrandom", xPlayer.source)
                        xPlayer.addInventoryItem(identification, 1)
                        xPlayer.addInventoryItem(money, 500)
                        MySQL.Async.execute("UPDATE `users` SET `got_motel`=1 WHERE `identifier`=@identifier", {["@identifier"] = xPlayer.identifier})
                    else
                        print("don't assign")
                    end
                end)
            else
                print("don't assign2")
            end
        end)
    end
end)