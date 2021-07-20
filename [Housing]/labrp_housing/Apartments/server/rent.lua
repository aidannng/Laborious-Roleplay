CreateThread(function()
    while not ESX do
        Wait(500)
    end

    RegisterNetEvent("loaf_motel:deposit_rent")
    AddEventHandler("loaf_motel:deposit_rent", function(amount)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer and amount and type(amount) == "number" and amount > 0 then
            MySQL.Async.fetchAll("SELECT `motel`, `room`, `interior`, `id`, `rentmoney`, `next_rent` FROM `loaf_motel` WHERE `identifier`=@identifier", {
                ["@identifier"] = xPlayer.identifier
            }, function(result)
                if result and result[1] and result[1].rentmoney then
                    if PayMoney(src, amount) then
                        MySQL.Async.execute("UPDATE `loaf_motel` SET `rentmoney`=@rent WHERE `identifier`=@identifier", {
                            ["@rent"] = result[1].rentmoney + amount,
                            ["@identifier"] = xPlayer.identifier
                        })

                        TriggerClientEvent("loaf_motel:set_owned", src, result[1].motel, result[1].room, result[1].interior, result[1].id, result[1].rentmoney + amount, result[1].next_rent - os.time())
                    end
                end
            end)
        end
    end)

    CreateThread(function()
        while true do
            local time = os.time()

            MySQL.Async.fetchAll("SELECT * FROM `loaf_motel` WHERE `next_rent` <= @time", {
                ["@time"] = os.time()
            }, function(data)
                for k, v in pairs(data) do
                    local cfg = Config.Motels[v.motel]
                    if cfg and cfg.Rent then
                        local rent = Config.Prices[v.interior]
                        if rent > v.rentmoney then
                            MySQL.Sync.execute("DELETE FROM `loaf_motel` WHERE `identifier`=@identifier", {
                                ["@identifier"] = v.identifier,
                            })
                            for i, player in pairs(ESX.GetPlayers()) do
                                local xPlayer = ESX.GetPlayerFromId(player) 
                                if xPlayer.identifier == v.identifier then
                                    TriggerClientEvent("loaf_motel:set_owned", player, nil)
                                    TriggerClientEvent("esx:showNotification", player, Strings["rent_overdue"])
                                    TriggerEvent("removeAllKeys", ("motel_%s:room_%s:id_%s"):format(v.motel, v.room, v.id))
                                    exports["mf-inventory"]:deleteInventory(("motel_%s:room_%s:id_%s"):format(v.motel, v.room, v.id))
                                    break
                                end
                            end
                        else
                            v.rentmoney = v.rentmoney - rent
                            v.next_rent = os.time() + (7 * 24 * 60 * 60)
                        
                            MySQL.Async.execute("UPDATE `loaf_motel` SET `rentmoney`=@rentmoney, `next_rent`=@next_rent WHERE `identifier`=@identifier", {
                                ["@rentmoney"] = v.rentmoney,
                                ["@next_rent"] = v.next_rent,
                                ["@identifier"] = v.identifier
                            })

                            for i, player in pairs(ESX.GetPlayers()) do
                                local xPlayer = ESX.GetPlayerFromId(player) 
                                if xPlayer.identifier == v.identifier then
                                    TriggerClientEvent("loaf_motel:set_owned", player, v.motel, v.room, v.interior, v.id, v.rentmoney, v.next_rent - os.time())
                                    break
                                end
                            end
                        end
                    end
                end
            end)

            Wait(60 * 60 * 1000) -- every hour
        end
    end)
end)