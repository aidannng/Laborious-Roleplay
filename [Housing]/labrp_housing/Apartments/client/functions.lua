ESX = nil
Cache = {}

CreateThread(function()
    while not Config or not Config.ESX or not Config.ESX.client do
        Wait(250)
    end

    while not ESX do
        Wait(500)
        TriggerEvent(Config.ESX.client, function(esx)
            ESX = esx
        end)
    end

    Wait(4000) -- wait for server ESX to load

    while not ESX.GetPlayerData() or not ESX.GetPlayerData().job or not ESX.GetPlayerData().job.name do
        Wait(500)
    end

    if Config.Policeraid.Enabled then
        Cache.ispolice = false

        for k, v in pairs(Config.Policeraid.Jobs) do
            if v.job == ESX.GetPlayerData().job.name and ESX.GetPlayerData().job.grade >= v.grade then
                Cache.ispolice = true
                break
            end
        end

        RegisterNetEvent("esx:setJob")
        AddEventHandler("esx:setJob", function(job)
            for k, v in pairs(Config.Policeraid.Jobs) do
                if v.job == job.name and job.grade >= v.grade then
                    Cache.ispolice = true
                    return
                end
            end

            Cache.ispolice = false
        end)
    end

    Cache.loaded = true

    Cache.room_markers = {}

    LoadBlips()
    
    for k, v in pairs(Config.Motels) do
        if Config.Markers.Enabled then
            CreateMarker(v.Location.xyz, Config.Markers.Colour)
        end

        for _, interior in pairs(v.Interiors) do
            if not Shells[interior] then
                table.remove(v.Interiors, _)
                print("Removed, not in config.")
            else
                local model = Shells[interior].Object
                if not IsModelInCdimage((type(model) == "number" and model or GetHashKey(model))) then
                    table.remove(v.Interiors, _)
                    print("Removed, not in cd image.")
                end
            end
        end
    end

    while true do
        for k, v in pairs(Config.Motels) do
            for x, y in pairs(v.Rooms) do
                if #(Cache.coords - y.xyz) > 100.0 then
                    if Cache.room_markers[("motel_%sroom_%s"):format(k, x)] then
                        DeleteCheckpoint(Cache.room_markers[("motel_%sroom_%s"):format(k, x)])
                        Cache.room_markers[("motel_%sroom_%s"):format(k, x)] = nil
                    end
                end
            end
        end

        for k, v in pairs(Config.Motels) do
            for x, y in pairs(v.Rooms) do
                if #(Cache.coords - y.xyz) <= 100.0 then
                    if not Cache.room_markers[("motel_%sroom_%s"):format(k, x)] then
                        if not Cache.owned or Cache.owned.motel ~= k or Cache.owned.room ~= x then
                            Cache.room_markers[("motel_%sroom_%s"):format(k, x)] = CreateMarker(y.xyz, Config.Markers.Colour)
                        end
                    end
                end
            end
        end

        Wait(5000)
    end
end)

LoadBlips = function()
    Cache.blips = Cache.blips or {}

    for k, v in pairs(Config.Motels) do
        if Config.Blips.Enabled then
            if Cache.blips["motel_" .. k] then -- if a blip for this motel exists
                RemoveBlip(Cache.blips["motel_" .. k]) -- remove it
            end
                
            -- create a blip for motel
            Cache.blips["motel_" .. k] = AddBlip(v.Location.xyz, Config.Blips.Sprite, (Cache.owned and Cache.owned.motel == k and Config.Blips.OwnedColour) or Config.Blips.Colour, v.Name, Config.Blips.Scale, 10)
        end
    end
end

CreateMarker = function(coords, rgba)
    coords = coords - vector3(0.0, 0.0, 1.0)
    local checkPoint = CreateCheckpoint(45, coords, coords, 0.3, rgba.r, rgba.g, rgba.b, rgba.a, 0)
    SetCheckpointCylinderHeight(checkPoint, 0.3, 0.3, 0.3)
    
    return checkPoint
end

HelpText = function(text, sound)
    AddTextEntry(GetCurrentResourceName(), text)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(0, 0, (sound == true), -1)
end

DrawTxt3D = function(coords, text, sound)
    if Config.Use3DText == false then
        return HelpText(text, sound)
    elseif Config.Use3DText == true then
        local str = text

        local start, stop = string.find(text, "~([^~]+)~")

        if start and start > 1 then
            start = start - 2
            stop = stop + 2
            str = ""
            str = str .. string.sub(text, 0, start) .. "   " .. string.sub(text, start+2, stop-2) .. string.sub(text, stop, #text)
        end

        AddTextEntry(GetCurrentResourceName(), str)
        BeginTextCommandDisplayHelp(GetCurrentResourceName())
        EndTextCommandDisplayHelp(2, false, false, -1)

        SetFloatingHelpTextWorldPosition(1, coords)
        SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    elseif Config.Use3DText == nil then
        SetDrawOrigin(coords)
        text = text:gsub("~INPUT_CONTEXT~", "~g~[~s~E~g~]~s~")
        local height = 0.03
        local _, count = string.gsub(text, "\n", "")
        height = height + 0.02 * count

        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(0.0, 0.0 - 0.01 * count)

        DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 350, height, 45, 45, 45, 150)

        ClearDrawOrigin()
    end
end

LoadModel = function(model)
    if type(model) == "string" then 
        model = GetHashKey(model) 
    elseif type(model) ~= "number" then
        return {loaded = false, model = model} 
    end

    local timer = GetGameTimer() + 20000 -- 20 seconds to load
    if not HasModelLoaded(model) and IsModelInCdimage(model) then
        RequestModel(model)
        while not HasModelLoaded(model) and timer >= GetGameTimer() do -- give it time to load
            Wait(50)
        end
    end

    if HasModelLoaded(model) then
        return {loaded = true, model = model}
    else
        return {loaded = false, model = model}
    end
end

AddBlip = function(coords, sprite, colour, label, scale, category)
    local blip = AddBlipForCoord(coords)
    if category then
        SetBlipCategory(blip, category)
    end
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, scale or 1.0)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)

    return blip
end

CreateThread(function()
    while true do
        Cache.self = PlayerPedId()
        Cache.coords = GetEntityCoords(Cache.self)

        Wait(250)
    end
end)

CreateThread(function()
    while true do
        if Cache.ManageTimeAndWeather then
            TriggerEvent("ToggleWeatherSync", false) -- toggles weather sync off (false). You will have to implement this event to your weather sync resource.

            SetRainFxIntensity(0.0) -- trying to remove puddles but this doesn't seem to do it
            while Cache.ManageTimeAndWeather do
                NetworkOverrideClockTime(17, 0, 0)
                ClearOverrideWeather()
                ClearWeatherTypePersist()
                SetWeatherTypePersist("EXTRASUNNY")
                SetWeatherTypeNow("EXTRASUNNY")
                SetWeatherTypeNowPersist("EXTRASUNNY")
                Wait(50)
            end

            TriggerEvent("ToggleWeatherSync", true) --  toggles weather sync on (true). You will have to implement this event to your weather sync resource.
        end
        Wait(3000)
    end
end)