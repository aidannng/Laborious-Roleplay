ESX = nil

CreateThread(function()
    while not Config or not Config.ESX or not Config.ESX.server do
        Wait(250)
    end

    Wait(4000) -- this fixes weight?
    TriggerEvent(Config.ESX.server, function(esx) 
        ESX = esx 
    end)

    print("I AM STARTING")
    
    PayMoney = function(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            if xPlayer.getMoney() >= amount then
                xPlayer.removeMoney(amount)
                return true
            elseif xPlayer.getAccount("bank").money >= amount then
                xPlayer.removeAccountMoney("bank", amount)
                return true
            end
        end
    
        return false
    end
    
    RegisterNetEvent("loaf_motel:delete_outfit")
    AddEventHandler("loaf_motel:delete_outfit", function(outfit)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer and xPlayer.identifier then
            TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
                local dressing = store.get("dressing") or {}

                table.remove(dressing, outfit)
                store.set("dressing", dressing)
            end)
        end
    end)

    ESX.RegisterServerCallback("loaf_motel:getOutfits", function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
            local count  = store.count("dressing")
            local labels = {}
    
            for i = 1, count, 1 do
                table.insert(labels, store.get("dressing", i).label)
            end
    
            cb(labels)
        end)
    end)
    
    ESX.RegisterServerCallback("loaf_motel:getOutfit", function(source, cb, id)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
            local outfit = store.get("dressing", id)
            if outfit then
                cb(outfit.skin)
            else
                cb(false)
            end
        end)
    end)
    
    RegisterNetEvent("loaf_motel:swap_interior")
    AddEventHandler("loaf_motel:swap_interior", function(data, interior)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        if xPlayer and data and data.motel and data.room and data.id then
            local instance_name = ("motel_%s:room_%s:id_%s"):format(data.motel, data.room, data.id)
            if not Instances[instance_name] then
                MySQL.Async.fetchAll("SELECT `motel`, `room`, `interior`, `id`, `rentmoney` FROM `loaf_motel` WHERE `identifier`=@identifier", {
                    ["@identifier"] = xPlayer.identifier
                }, function(result)
                    if result and result[1] then
                        local motel_data = Config.Motels[data.motel]
                        if motel_data then
                            if motel_data.Rent then
                                local base_price = Config.Prices[motel_data.Interiors[interior]]
                                if base_price and Config.Prices[motel_data.Interiors[interior]] > Config.Prices[motel_data.Interiors[result[1].interior]] then
                                    if not PayMoney(src, base_price) then
                                        return TriggerClientEvent("esx:showNotification", src, Strings["no_money"])
                                    end
                                end
                            end

                            MySQL.Async.execute("UPDATE `loaf_motel` SET `interior`=@interior, `next_rent`=@rent WHERE `identifier`=@identifier", {
                                ["@interior"] = motel_data.Interiors[interior],
                                ["@rent"] = os.time() + (7 * 24 * 60 * 60),
                                ["@identifier"] = xPlayer.identifier
                            })

                            TriggerClientEvent("loaf_motel:set_owned", src, result[1].motel, result[1].room, motel_data.Interiors[interior], result[1].id, result[1].rentmoney, (7 * 24 * 60 * 60))
                        end
                    end
                end)
            else
                TriggerClientEvent("esx:showNotification", src, Strings["cant_change"])
            end
        end
    end)

    RegisterNetEvent("loaf_motels:copy_keys")
    AddEventHandler("loaf_motels:copy_keys", function(motel, room, id)
        local src = source
        local key = ("motel_%s:room_%s:id_%s"):format(motel, room, id)
        local xPlayer = ESX.GetPlayerFromId(src)
        TriggerEvent("getKeys", src, function(keys)
            if keys then
                local has_key, amount = false, 0
    
                for k, v in pairs(keys) do
                    if v.key_id == key then
                        has_key = true
                        amount = amount + 1
                    end
                end
    
                if amount >= 2 then
                    return TriggerClientEvent("esx:showNotification", src, Strings["max_key"])
                end
    
                if has_key then
                    TriggerEvent("generateKey", src, key, (Strings["key"]):format(Config.Motels[motel].Name, room, id), "server", "loaf_motel:toggle_lock")
                end
    
                if not has_key then
                    MySQL.Async.fetchAll("SELECT `motel`, `room`, `interior`, `id` FROM `loaf_motel` WHERE `identifier`=@identifier", {
                        ["@identifier"] = xPlayer.identifier
                    }, function(result)
                        if result and result[1] then
                            TriggerEvent("generateKey", src, key, (Strings["key"]):format(Config.Motels[result[1].motel].Name, result[1].room, result[1].id), "server", "loaf_motel:toggle_lock")
                        end
                    end)
                end
            end
        end)
    end)
    
    RegisterNetEvent("loaf_motel:request_data")
    AddEventHandler("loaf_motel:request_data", function()
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
    
        if xPlayer then
            MySQL.Async.fetchAll("SELECT `motel`, `room`, `interior`, `id`, `rentmoney`, `next_rent` FROM `loaf_motel` WHERE `identifier`=@identifier", {
                ["@identifier"] = xPlayer.identifier
            }, function(result)
                if result and result[1] then
                    TriggerClientEvent("loaf_motel:set_owned", src, result[1].motel, result[1].room, result[1].interior, result[1].id, result[1].rentmoney, result[1].next_rent - os.time())
                end
            end)
        end
    end)
    
    RegisterNetEvent("loaf_motel:sell")
    AddEventHandler("loaf_motel:sell", function(data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer and data and type(data) == "table" and data.motel and data.room and data.id then
            local instance_name = ("motel_%s:room_%s:id_%s"):format(data.motel, data.room, data.id)
            if not Instances[instance_name] or #Instances[instance_name].users == 0 then
                MySQL.Async.fetchScalar("SELECT `rentmoney` FROM `loaf_motel` WHERE `id`=@id AND `motel`=@motel AND `room`=@room AND `identifier`=@identifier", {
                    ["@id"] = data.id,
                    ["@motel"] = data.motel,
                    ["@room"] = data.room,
                    ["@identifier"] = xPlayer.identifier
                }, function(money)
                    if money then
                        if Config.Inventory == "modfreakz" then
                            exports["mf-inventory"]:deleteInventory(instance_name)
                        end

                        xPlayer.addMoney(money)
                        MySQL.Sync.execute("DELETE FROM `loaf_motel` WHERE `identifier`=@identifier", {
                            ["@identifier"] = xPlayer.identifier,
                        })
    
                        TriggerEvent("removeAllKeys", instance_name)
                        TriggerClientEvent("loaf_motel:set_owned", src, nil)
                    end
                end)
            else
                TriggerClientEvent("esx:showNotification", src, Strings["someone_in_room"])
            end
        end
    end)
    
    RegisterNetEvent("loaf_motel:purchase")
    AddEventHandler("loaf_motel:purchase", function(motel, room)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
    
        if xPlayer and motel and room and type(motel) == "number" and type(room) == "number" then
            local motel_data = Config.Motels[motel]
            if motel_data then
                if motel_data.Rent then
                    local base_price = Config.Prices[motel_data.Interiors[1]]
                    if base_price then
                        if not PayMoney(src, base_price) then
                            return TriggerClientEvent("esx:showNotification", src, Strings["no_money"])
                        end
                    end
                end
    
                MySQL.Async.fetchScalar("SELECT `motel`, `room` FROM `loaf_motel` WHERE `identifier`=@identifier", {
                    ["@identifier"] = xPlayer.identifier
                }, function(result)
                    if not result then
                        local found, id = false, math.random(1000, 9999)
    
                        while not found do
                            local ran = false
                            MySQL.Async.fetchScalar("SELECT `identifier` FROM `loaf_motel` WHERE `id`=@id AND `motel`=@motel AND `room`=@room", {
                                ["@id"] = id,
                                ["@motel"] = motel,
                                ["@room"] = room,
                            }, function(ident)
                                if not ident then 
                                    found = true 
                                else
                                    id = math.random(1000, 9999)
                                end
                                ran = true
                            end)
    
                            while not ran do
                                Wait(100)
                            end
                        end
    
                        MySQL.Async.execute("INSERT INTO `loaf_motel` (`identifier`, `id`, `motel`, `room`, `interior`, `next_rent`) VALUES (@identifier, @id, @motel, @room, @interior, @next_rent)", {
                            ["@identifier"] = xPlayer.identifier,
                            ["@id"] = id,
                            ["@motel"] = motel,
                            ["@room"] = room,
                            ["@interior"] = motel_data.Interiors[1],
                            ["@next_rent"] = os.time() + (7 * 24 * 60 * 60)
                        })
                        
                        TriggerClientEvent("loaf_motel:set_owned", src, motel, room, motel_data.Interiors[1], id, 0, (7 * 24 * 60 * 60))
                        TriggerEvent("generateKey", src, ("motel_%s:room_%s:id_%s"):format(motel, room, id), (Strings["key"]):format(Config.Motels[motel].Name, room, id), "server", "loaf_motel:toggle_lock")
                    else
                        TriggerClientEvent("esx:showNotification", src, Strings["already_own"])
                    end
                end)
            end
        end
    end)
end)