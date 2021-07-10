CreateThread(function()
    while not Cache.loaded do
        Wait(0)
    end

    TriggerServerEvent("loaf_motel:request_data")

    while true do
        Wait(1000)
        
        for motel, motel_data in pairs(Config.Motels) do
            while #(Cache.coords - motel_data.Location.xyz) <= 100.0 do
                for k, v in pairs(motel_data.Rooms) do
                    while #(Cache.coords - v.xyz) <= 1.0 do
                        Wait(0)

                        local txt = (Strings["room"]):format(k)
                        if Cache.owned and Cache.owned.motel == motel and Cache.owned.room == k then
                            local id = ("motel_%s:room_%s:id_%s"):format(motel, k, Cache.owned.id)
                            txt = txt .. "\n" .. (GlobalState[id] and Strings["unlocked"] or Strings["locked"])
                        end
                        
                        DrawTxt3D(v.xyz, txt, false)
                        if IsControlJustReleased(0, Config.Options.Control) then
                            ESX.UI.Menu.CloseAll()

                            local owns = (Cache.owned and Cache.owned.motel == motel and Cache.owned.room == k)
                            local elements = {}
                            if owns then
                                table.insert(elements, {
                                    label = (Strings["your_room"]):format(Cache.owned.id),
                                    value = "owned_room"
                                })

                                table.insert(elements, {
                                    label = Strings["copy_keys"],
                                    value = "copy_keys"
                                })
                            end

                            table.insert(elements, {
                                label = Strings["enter_a_room"],
                                value = "enter_room"
                            })

                            if Cache.ispolice then
                                table.insert(elements, {
                                    label = Strings["raid_a_room"],
                                    value = "raid_room"
                                })
                            end

                            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "enter_a_room", {
                                title = motel_data.Name,
                                align = Config.Options.Align,
                                elements = elements
                            }, function(data, menu)
                                if data.current.value == "owned_room" then
                                    local owned = Cache.owned
                                    TriggerServerEvent("loaf_motels:enter_room", owned.motel, owned.room, owned.id)
                                elseif data.current.value == "copy_keys" then
                                    local owned = Cache.owned
                                    TriggerServerEvent("loaf_motels:copy_keys", owned.motel, owned.room, owned.id)
                                elseif data.current.value == "enter_room" or data.current.value == "raid_room" then
                                    ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "room_enter", {
                                        title = Strings["room_id"]
                                    }, function(data2, menu2)
                                        local id = tonumber(data2.value)
                                        if id and id >= 1000 and id <= 9999 then
                                            menu2.close()
                                            menu.close()
                                            if data.current.value == "enter_room" then
                                                TriggerServerEvent("loaf_motels:enter_room", motel, k, id)
                                            else
                                                TriggerServerEvent("loaf_motels:enter_room", motel, k, id, true)
                                            end
                                        else
                                            ESX.ShowNotification(Strings["invalid_id"])
                                        end
                                    end, function(data2, menu2)
                                        menu2.close()
                                    end)
                                end
                            end, function(data, menu)
                                menu.close()
                            end)

                            while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "enter_a_room") do
                                Wait(250)
                                if #(Cache.coords - v.xyz) > 1.0 then
                                    ESX.UI.Menu.CloseAll()
                                end
                            end
                        end
                    end
                end

                Wait(250)
            end
        end
    end
end)

RegisterNetEvent("loaf_motel:set_owned")
AddEventHandler("loaf_motel:set_owned", function(motel, room, interior, id, money, rent_due)
    if motel then
        Cache.owned = {
            motel = motel,
            room = room,
            interior = Shells[interior],
            interiorid = interior,
            id = id,
            money = money,
            rent_due = rent_due
        }

        if Cache.room_markers[("motel_%sroom_%s"):format(motel, room)] then
            DeleteCheckpoint(Cache.room_markers[("motel_%sroom_%s"):format(motel, room)])
            Cache.room_markers[("motel_%sroom_%s"):format(motel, room)] = nil 
        end
        CreateMarker(Config.Motels[motel].Rooms[room].xyz, Config.Markers.Owned)

        LoadBlips()
    else
        Cache.owned = nil
    end
end)