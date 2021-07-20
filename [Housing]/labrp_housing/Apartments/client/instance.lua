RegisterNetEvent("loaf_motel:spawn_motel")
AddEventHandler("loaf_motel:spawn_motel", function(instance)
    local interior = Shells[instance.interior]
    if interior then
        local model = LoadModel(interior.Object)
        if model.loaded then
            local shell = CreateObject(model.model, instance.location, false, false, false)
            SetEntityHeading(shell, 0.0)
            FreezeEntityPosition(shell, true)

            local spawned_objects = {}
            for k, v in pairs(interior.DefaultFurniture) do
                local model = LoadModel(v.object)
                if model.loaded then
                    model = model.model
                    local object = CreateObject(model, instance.location.x + v.offset.x, instance.location.y + v.offset.y, instance.location.z + v.offset.z, false, false, false)
                    FreezeEntityPosition(object, true)
                    if type(v.offset) == "vector4" then
                        SetEntityHeading(object, v.offset.w)
                    else
                        SetEntityHeading(object, 0.0)
                    end
                    table.insert(spawned_objects, object)
                end
            end

            ESX.UI.Menu.CloseAll()

            DoScreenFadeOut(750)
            while not IsScreenFadedOut() do 
                Wait(0) 
            end
            Cache.ManageTimeAndWeather = true
            
            local door = GetOffsetFromEntityInWorldCoords(shell, interior.Offsets.Door)
            for i = 1, 25 do
                SetEntityCoords(Cache.self, door)
                Wait(50)
                ClearAreaOfPeds(instance.location.x, instance.location.y, instance.location.z, 100.0, 1)
            end
            while IsEntityWaitingForWorldCollision(Cache.self) do
                SetEntityCoords(Cache.self, door)
                Wait(50)
                ClearAreaOfPeds(instance.location.x, instance.location.y, instance.location.z, 100.0, 1)
            end
            DoScreenFadeIn(1500)
            ClearAreaOfPeds(instance.location.x, instance.location.y, instance.location.z, 100.0, 1)

            local storage = GetOffsetFromEntityInWorldCoords(shell, interior.Offsets.Storage)
            local wardrobe = GetOffsetFromEntityInWorldCoords(shell, interior.Offsets.Wardrobe)
            local changechar = GetOffsetFromEntityInWorldCoords(shell, interior.Offsets.Changechar)

            while Cache.ManageTimeAndWeather do
                Wait(100)
                if #(Cache.coords - door) >= 50.0 then
                    SetEntityCoords(Cache.self, door)
                end

                while #(Cache.coords - storage) <= 0.7 and not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_item_type") do
                    Wait(0)
                    DrawTxt3D(storage, Strings["open_storage"])

                    if IsControlJustReleased(0, Config.Options.Control) then
                        OpenStorage(instance.instance)
                    end
                end

                while #(Cache.coords - wardrobe) <= 0.7 do
                    Wait(0)
                    DrawTxt3D(wardrobe, Strings["open_wardrobe"])

                    if IsControlJustReleased(0, Config.Options.Control) then
                        TriggerEvent("rcore_clothes:openOutfits")
                    end
                end

                while #(Cache.coords - changechar) <= 0.7 do
                    Wait(0)
                    DrawTxt3D(changechar, Strings["open_Changechar"])

                    if IsControlJustReleased(0, Config.Options.Control) then
                        exports['mythic_notify']:SendAlert('error', 'This feauture is Work In progress and will work soon!') 
                        --TriggerEvent("multichar:changeChar")
                    end
                end

                while Cache.ManageTimeAndWeather and #(Cache.coords - door) <= 1.4 do
                    Wait(0)
                    DrawTxt3D(door + vector3(0.0, 0.0, 1.0), (Strings["manage_motel"]):format(GlobalState[instance.instance] and Strings["unlocked"] or Strings["locked"]))

                    if IsControlJustReleased(0, Config.Options.Control) then
                        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "manage_room", {
                            title = Config.Motels[instance.motel].Name,
                            align = Config.Options.Align,
                            elements = {
                                {label = Strings["toggle_lock"], value = "toggle_lock"},
                                {label = Strings["leave"], value = "exit"},
                            }
                        }, function(data, menu)
                            if data.current.value == "toggle_lock" then
                                TriggerServerEvent("loaf_motel:toggle_lock", instance.instance)
                            elseif data.current.value == "exit" then
                                Cache.ManageTimeAndWeather = false
                                menu.close()
                            end
                        end, function(data, menu)
                            menu.close()
                        end)
                    end
                end
            end

            TriggerServerEvent("loaf_motel:leave", instance.instance)

            DoScreenFadeOut(750)
            while not IsScreenFadedOut() do 
                Wait(0) 
            end

            Cache.ManageTimeAndWeather = false

            local door_coords = Config.Motels[instance.motel].Rooms[instance.room]
            for i = 1, 25 do
                SetEntityCoords(Cache.self, door_coords.xyz)
                Wait(50)
            end
            while IsEntityWaitingForWorldCollision(Cache.self) do
                SetEntityCoords(Cache.self, door_coords.xyz)
                Wait(50)
            end
            Wait(500)
            SetEntityHeading(Cache.self, door_coords.w)
            DoScreenFadeIn(1500)

            DeleteEntity(shell)
            for k, v in pairs(spawned_objects) do
                DeleteEntity(v)
            end
        end
    end
end)