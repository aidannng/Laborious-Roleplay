Instances = {}

CreateThread(function()
    while not ESX do
        Wait(500)
    end

    local taken_positions = {}
    for k, v in pairs(Spawnpoints) do
        taken_positions[k] = false
    end
    
    find_spawn = function()
        for k, v in pairs(taken_positions) do
            if v == false then
                taken_positions[k] = true
                return k
            end
        end
    
        return false
    end
    
    RegisterNetEvent("loaf_motels:enter_room")
    AddEventHandler("loaf_motels:enter_room", function(motel, room, id, raid)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        MySQL.Async.fetchAll('SELECT `jail_time` FROM `users` WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if result[1] and result[1].jail_time > 0 then
                print("you're in jail")
            else
                for instance, data in pairs(Instances) do
                    if data then
                        for i, guest in pairs(data.users) do
                            if guest == src then
                                return TriggerClientEvent("esx:showNotification", Strings["already_inside"])
                            end
                        end
                    end
                end

                local instance_name = ("motel_%s:room_%s:id_%s"):format(motel, room, id)
                TriggerEvent("getKeys", src, function(keys)
                    if keys then
                        local has_key, should_enter = false, false
            
                        for k, v in pairs(keys) do
                            if v.key_id == instance_name then
                                has_key = true
                            end
                        end

                        if raid and xPlayer and Config.Policeraid.Enabled then
                            for k, v in pairs(Config.Policeraid.Jobs) do
                                if v.job == xPlayer.job.name and xPlayer.job.grade >= v.grade then
                                    has_key = true
                                end
                            end
                        end
            
                        if not has_key then
                            if GlobalState[instance_name] then
                                should_enter = true
                            else
                                return TriggerClientEvent("esx:showNotification", src, Strings["no_key"])
                            end
                        else
                            should_enter = true
                        end
            
                        if should_enter then
                            if Instances[instance_name] then
                                for k, v in pairs(Instances[instance_name].users) do
                                    if v == src then
                                        return TriggerClientEvent("esx:showNotification", Strings["already_inside"])
                                    end
                                end
                                table.insert(Instances[instance_name].users, src)
                                TriggerClientEvent("loaf_motel:spawn_motel", src, Instances[instance_name])
                            else
                                MySQL.Async.fetchAll("SELECT `interior`, `identifier` FROM `loaf_motel` WHERE `motel`=@motel AND `room`=@room AND `id`=@id", {
                                    ["@motel"] = motel,
                                    ["@room"] = room,
                                    ["@id"] = id
                                }, function(result)
                                    if result and result[1] then
                                        local spawn = find_spawn()
                                        if spawn then
                                            Instances[instance_name] = {
                                                location = Spawnpoints[spawn],
                                                locationid = spawn,
                                                motel = motel,
                                                room = room,
                                                id = id,
                                                interior = result[1].interior,
                                                users = {src},
                                                instance = instance_name,
                                                identifier = result[1].identifier
                                            }
                                            TriggerClientEvent("loaf_motel:spawn_motel", src, Instances[instance_name])
                                        end
                                    end
                                end)
                            end
                        else
                            TriggerClientEvent("esx:showNotification", src, Strings["door_locked"])
                        end
                    end
                end)
            end
        end)
    end)
    
    RegisterNetEvent("loaf_motel:toggle_lock")
    AddEventHandler("loaf_motel:toggle_lock", function(instance)
        local src = source
    
        if Instances[instance] then
            for k, v in pairs(Instances[instance].users) do
                if v == src then
                    GlobalState[instance] = not GlobalState[instance]
                    break
                end
            end
        elseif type(instance) == "table" then
            TriggerEvent("getKeys", src, function(keys)
                if keys then
                    local has_key = false
    
                    for k, v in pairs(keys) do
                        if v.key_id == instance.key_id then
                            has_key = true
                        end
                    end
    
                    if has_key then
                        GlobalState[instance.key_id] = not GlobalState[instance.key_id]
                    end
                end
            end)
        end
    end)
    
    RegisterNetEvent("loaf_motel:leave")
    AddEventHandler("loaf_motel:leave", function(instance)
        local src = source
        if Instances[instance] then
            for i, player in pairs(Instances[instance].users) do
                if player == src then
                    table.remove(Instances[instance].users, i)
                    if #Instances[instance].users <= 0 then
                        taken_positions[Instances[instance].locationid] = false
                        Instances[instance] = nil
                        break
                    end
                end
            end
        end
    end)
    
    AddEventHandler("playerDropped", function()
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        for instance, data in pairs(Instances) do
            if data then
                for i, player in pairs(data.users) do
                    if player == src then
                        table.remove(Instances[instance].users, i)
                        if #Instances[instance].users <= 0 then
                            taken_positions[data.locationid] = false
                            GlobalState[instance] = nil
                            Instances[instance] = nil
                        end
    
                        if xPlayer and xPlayer.identifier then
                            Wait(30000)
                            local pos = {}
                            if Config.Motels[data.motel] and Config.Motels[data.motel].Rooms[data.room] then
                                local coords = Config.Motels[data.motel].Rooms[data.room]
                                pos.x = tonumber(string.format("%.2f", coords.x))
                                pos.y = tonumber(string.format("%.2f", coords.y))
                                pos.z = tonumber(string.format("%.2f", coords.z))
                                pos.heading = tonumber(string.format("%.2f", coords.w))
    
                                MySQL.Async.execute("UPDATE `users` SET `position`=@pos WHERE `identifier`=@identifier", {
                                    ["@pos"] = json.encode(pos),
                                    ["@identifier"] = xPlayer.identifier
                                })
                            end
                        end
                    end
                end
            end
        end
    end)
end)