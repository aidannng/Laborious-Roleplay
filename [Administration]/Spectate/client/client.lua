ESX, ESXTimeout = nil, false
localServerId = nil
ESXTimeout = false
waitingOnCallback = false
loopActive = false
onesyncState = {}
playersData = {}
searchedPlayers = {}
permissions = false
activeWeather = nil
lastWeatherType = nil
activeTime = nil
pervTime = nil
myLastPos = nil
inSpectate = false
targetIdentifiers = nil
targetCamera = nil

local radius = -3.5
local defaultMouseSensivity, defaultZoomSensivity, invertMouse = 25, 1, false
local mouseSensivity = GetResourceKvpInt('mouseSensivity') ~= 0 and GetResourceKvpInt('mouseSensivity') or 25
local zoomSensivity = GetResourceKvpInt('zoomSensivity') ~= 0 and GetResourceKvpInt('zoomSensivity') or 1 
local invertMouse = GetResourceKvpInt('invertMouse') == 1 and true or false 
local onStartupMS, onStartupZS, onStartupIM = mouseSensivity, zoomSensivity, invertMouse

AddTextEntry('AS_ATE_HOURS', 'Enter Hour')

Citizen.CreateThread(function()

    while not NetworkIsSessionStarted() do
        Wait(50)
    end

    SetTimeout(5000, function()
        ESXTimeout = true
    end)

    -- doesnt matter you have ESX or not , it will check and break the loop in 5 seconds (max) anyway
    while not ESX and not ESXTimeout do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(50)
    end

    TriggerServerEvent('AdvancedSpectate:serverCB:newPlayerData')

    localServerId = GetPlayerServerId(PlayerId())

end)

RegisterNetEvent('AdvancedSpectate:clientCB:newPlayerData')
AddEventHandler('AdvancedSpectate:clientCB:newPlayerData', function(OS_Info, PD, perms)
    onesyncState = OS_Info
    playersData = PD
    if perms then
        permissions = perms
    end

    if Config.EnableCommand then
        if permissions then -- only register this command for players with permissions
            RegisterCommand(Config.SpectateCommand, function(source, args, raw)
    
                local playerId = args[1] and tonumber(args[1])
                if playerId then
                    if playerId == localServerId then
                        showNotification(_lang('cant_self_spectate'))
                    else
                        if inSpectate and inSpectate == playerId then
                            showNotification(_lang('already_spectating'))
                        else
                            local pIndex = nil
                            for i=1, #playersData do
                                if playersData[i].playerId == playerId then
                                    pIndex = i
                                    break
                                end
                            end
                            if pIndex then
                                SpectatePlayer(playerId, pIndex)
                            else
                                showNotification(_lang('player_not_found', { ['$command'] = Config.SpectateCommand }))
                            end
                        end
                    end
                else
                    WarMenu.OpenMenu('main')
                end
    
            end)
        end
    end
    Wait(200)
    mainLoop()
end)

-- Main menu
WarMenu.CreateMenu('main', _lang('mainmenu_title'), _lang('mainmenu_subtitle'))

-- Sub menus
WarMenu.CreateSubMenu('players_menu', 'main', _lang('playersmenu_title'), _lang('playersmenu_subtitle'))
WarMenu.CreateSubMenu('searched_players', 'main', _lang('searchedmenu_title'), _lang('searchedmenu_subtitle'))
WarMenu.CreateSubMenu('player_info', 'main', _lang('infomenu_title'), _lang('infomenu_subtitle'))
WarMenu.CreateSubMenu('ESX_data', 'player_info', _lang('esxmenu_title'))
WarMenu.CreateSubMenu('setting', 'main', _lang('settingmenu_title'), _lang('settingmenu_subtitle'))
WarMenu.CreateSubMenu('change_weathertime', 'main', _lang('changeweathertimemenu_title'), _lang('changeweathertimemenu_subtitle'))
WarMenu.CreateSubMenu('change_weather', 'change_weathertime', _lang('changeweathermenu_title'))
WarMenu.CreateSubMenu('change_time', 'change_weathertime', _lang('changetimemenu_title'))

function mainLoop()
    if permissions then
        CreateThread(function()
            while true do
                if Config.EnableKeyToOpen then
                    if IsControlJustPressed(0, Config.keyToOpen) then
                        if WarMenu.IsAnyMenuOpened() then
                            WarMenu.CloseMenu()
                        else
                            WarMenu.OpenMenu('main')
                        end
                    end
                end

                if WarMenu.Begin('main') then

                    if permissions.onlinePlayers then
                        WarMenu.MenuButton(_lang('online_players'), 'players_menu', '→→→')
                    end

                    if permissions.searchPlayers then
                        local anyInput, inputText = WarMenu.InputButton(_lang('searchforplayers'), nil, nil, 10, 3, nil)
                        if anyInput and inputText then

                            searchedPlayers = {}
                            for i=1, #playersData do
                                if string.find(string.lower(playersData[i].playerName), string.lower(inputText)) then
                                    table.insert(searchedPlayers, {playerName = playersData[i].playerName, playerId = playersData[i].playerId, playerIndex = i })
                                end
                            
                            end
                            if #searchedPlayers > 0 then
                                WarMenu.OpenMenu('searched_players')
                            else
                                showNotification(_lang('no_search_found'))
                            end
                        end
                    end

                    if inSpectate then

                        if permissions.changeWeather or permissions.changeTime then
                            WarMenu.MenuButton(_lang('weathertime_button'), 'change_weathertime', '→→→')
                            if WarMenu.IsItemHovered() then
                                WarMenu.ToolTip(_lang('weathertime_button_tip'), nil, 0.05)
                            end
                        end

                        if permissions.playerInfo then
                            WarMenu.MenuButton(_lang('playerinfo_button'), 'player_info', '→→→')
                        end

                        local button = WarMenu.Button(_lang('exitspectate_button'))
                        if button == 'select' then
                            exitSpectate()
                        end

                    end

                    WarMenu.MenuButton(_lang('changesetting_button'), 'setting', '→→→')

                    WarMenu.End()

                end

                if WarMenu.Begin('players_menu') then

                    for i=1, #playersData do

                        local keyPressed = WarMenu.Button(playersData[i].playerName, playersData[i].playerId)
	        		    if WarMenu.IsItemHovered() then
	        		    	WarMenu.ToolTip(_lang('spectateplayer_button'))
	        		    end
                        if keyPressed == 'right' or keyPressed == 'select' then
                            if localServerId == playersData[i].playerId then
                                showNotification(_lang('cant_self_spectate'))
                            else
                                SpectatePlayer(playersData[i].playerId, i)
                            end
                        elseif keyPressed == 'left' then
                            WarMenu.GoBack()
                        end


                    end

                    WarMenu.End()
                end

                if WarMenu.Begin('searched_players') then

                    for i=1, #searchedPlayers do
                        local keyPressed = WarMenu.Button(searchedPlayers[i].playerName, searchedPlayers[i].playerId)
	        		    if WarMenu.IsItemHovered() then
	        		    	WarMenu.ToolTip(_lang('spectateplayer_button'))
	        		    end
                        if keyPressed == 'right' or keyPressed == 'select' then
                            if localServerId == searchedPlayers[i].playerId then
                                showNotification(_lang('cant_self_spectate'))
                            else
                                SpectatePlayer(searchedPlayers[i].playerId, searchedPlayers.playerIndex)
                            end
                        elseif keyPressed == 'left' then
                            WarMenu.GoBack()
                        end

                    end

                    WarMenu.End()
                end

                if WarMenu.Begin('player_info') then

                    if not inSpectate then
                        WarMenu.CloseMenu()
                    else

                        local targetClientId = GetPlayerFromServerId(inSpectate)
                        if targetClientId ~= -1 then
                            local targetPed = GetPlayerPed(targetClientId)
                            local playerData = playersData[inSpecIndex]

                            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                            if targetVehicle ~= 0 then

                                WarMenu.Button(_lang('vehicle_info_button'))
	        		            if WarMenu.IsItemHovered() then
                                    local vehModel = GetEntityModel(targetVehicle)
                                    local vehModelName = GetDisplayNameFromVehicleModel(vehModel)
                                    local vehModelLabel = GetLabelText(vehModelName) ~= 'NULL' and GetLabelText(vehModelName) or vehModelName
	        		            	WarMenu.ToolTip(_lang('vehicle_info_button_tip', { ['$vehName'] = vehModelLabel, ['$vehModel'] = vehModel, ['$vehBodyHealth'] = GetVehicleBodyHealth(targetVehicle), ['$vehEngineHealth'] = GetVehicleEngineHealth(targetVehicle) }), nil, 0.05)
	        		            end

                            end

                            WarMenu.Button(_lang('player_info_button'))
	        		        if WarMenu.IsItemHovered() then
	        		        	WarMenu.ToolTip( _lang('player_info_button_tip', { ['$playerName'] = playerData.playerName, ['$playerId'] = inSpectate, ['$playerClientId'] = targetClientId, ['$playerPed'] = targetPed, ['$sessionTime'] = SecondsToClock(math.floor(((GetNetworkTime() - playerData.joined) / 1000) + 0.5)) }) , nil, 0.05)
	        		        end

                            WarMenu.Button(_lang('player_ids_button'))
	        		        if WarMenu.IsItemHovered() then
                                WarMenu.ToolTip( _lang('player_ids_button_tip', { ['$steam'] = targetIdentifiers.steam, ['$ip'] = targetIdentifiers.ip, ['$discord'] = targetIdentifiers.discord, ['$rockstar'] = targetIdentifiers.rockstar, ['$xboxlive'] = targetIdentifiers.xboxlive }) , nil, 0.1)
	        		        end

                            if permissions.logToDiscord then
                                if WarMenu.Button(_lang('player_log_button'), '> > >') then
                                    log( _lang('player_log_button_message', { ['$loggerName'] = GetPlayerName(PlayerId()), ['$loggerId'] = localServerId, ['$playerName'] = playerData.playerName, ['$playerId'] = inSpectate, ['$steam'] = targetIdentifiers.steam, ['$ip'] = targetIdentifiers.ip, ['$discord'] = targetIdentifiers.discord, ['$rockstar'] = targetIdentifiers.rockstar, ['$xboxlive'] = targetIdentifiers.xboxlive }))
                                end
                                if WarMenu.IsItemHovered() then
                                    WarMenu.ToolTip(_lang('player_log_button_tip'))
                                end
                            end

                            if ESX then
                                local esxData = WarMenu.Button(_lang('player_esx_button'), '→→→')
                                if WarMenu.IsItemHovered() then
                                    WarMenu.ToolTip(_lang('player_esx_button_tip'))
                                end
                                if esxData == 'select' or esxData == 'right' then
                                    targetESXData = nil
                                    ESX.TriggerServerCallback('AdvancedSpectate:ESXCB:getPlayerData', function(playerData)
                                        targetESXData = playerData
                                        WarMenu.OpenMenu('ESX_data', true)
                                    end, inSpectate)
                                end
                            end


                            WarMenu.Button(_lang('player_health'), '~b~'..(GetEntityHealth(targetPed)-100)..' ~s~/ ~b~'..(GetEntityMaxHealth(targetPed)-100))

                            WarMenu.Button(_lang('player_armor'), '~b~'..GetPedArmour(targetPed)..' ~s~/ ~b~'..GetPlayerMaxArmour(targetClientId))

                            local antiRagdoll = _lang('false')
                            if not CanPedRagdoll(targetPed) and not IsPedInAnyVehicle(targetPed, false) and (GetPedParachuteState(targetPed) == -1 or GetPedParachuteState(targetPed) == 0) and not IsPedInParachuteFreeFall(targetPed) then
	        			        antiRagdoll = _lang('true')
                            end

                            WarMenu.Button(_lang('antiragdoll'), antiRagdoll)

                            WarMenu.Button(_lang('invincible'), (GetPlayerInvincible_2(targetClientId) and _lang('true') or _lang('false')))

                            WarMenu.Button(_lang('runningstate'), (IsPedJumping(targetPed) and _lang('jumping') or IsPedInAnyVehicle(targetPed) and _lang('inveh') or IsPedStill(targetPed) and _lang('standstill') or IsPedWalking(targetPed) and _lang('walking') or IsPedRunning(targetPed) and _lang('running') or IsPedSprinting(targetPed) and _lang('sprint')))

                            WarMenu.Button(_lang('playertalking'), (NetworkIsPlayerTalking(targetClientId) and _lang('talking') or _lang('not_talking')))

                            local targetCoords = GetEntityCoords(targetPed)
                            local targetHeading = GetEntityHeading(targetPed)
                            WarMenu.Button(_lang('coordinate'))
                            if WarMenu.IsItemHovered() then
                                WarMenu.ToolTip(_lang('coordinate_tip', { ['$x'] = targetCoords.x, ['$y'] = targetCoords.y, ['$z'] = targetCoords.z, ['$heading'] = targetHeading }), nil , 0.02)
                            end

                            WarMenu.End()

                        end
                    end
                end

                if WarMenu.Begin('setting') then

                
                    local mouseButton = WarMenu.Button(_lang('mouse_sens'), '← '..mouseSensivity..' →')
                    if mouseButton then
                        if mouseButton == 'left' then
                            if mouseSensivity - 1 > 0 then 
                                mouseSensivity = mouseSensivity - 1
                            end
                        elseif mouseButton == 'right' then
                            if mouseSensivity + 1 <= 50 then 
                                mouseSensivity = mouseSensivity + 1
                            end
                        end
                    end

                    local zoomButton = WarMenu.Button(_lang('mouse_zoom'), '← '..zoomSensivity..' →')
                    if zoomButton then
                        if zoomButton == 'left' then
                            if zoomSensivity - 1 > 0 then 
                                zoomSensivity = zoomSensivity - 1
                            end
                        elseif zoomButton == 'right' then
                            if zoomSensivity + 1 <= 15 then 
                                zoomSensivity = zoomSensivity + 1
                            end
                        end
                    end

                    WarMenu.CheckBox(_lang('mouse_invert'), invertMouse, function(checkBox)
                        invertMouse = not invertMouse
                    end)

                    if mouseSensivity ~= defaultMouseSensivity or zoomSensivity ~= defaultZoomSensivity then
                        local resetDefault = WarMenu.Button(_lang('reset_button'))
                        if WarMenu.IsItemHovered() then
                            WarMenu.ToolTip(_lang('reset_button_tip'))
                        end
                        if resetDefault == 'select' then
                            mouseSensivity = defaultMouseSensivity
                            zoomSensivity = defaultZoomSensivity
                            WarMenu.resetSelectedOption()
                        end
                    end

                    if changeDetected() then

                        local revert = WarMenu.Button(_lang('revert_button'))
                        if WarMenu.IsItemHovered() then
                            WarMenu.ToolTip(_lang('revert_button_tip'))
                        end
                        if revert == 'select' then
                            mouseSensivity = onStartupMS
                            zoomSensivity = onStartupZS
                            invertMouse = onStartupIM
                            WarMenu.resetSelectedOption()
                        end

                        local confirm = WarMenu.Button(_lang('save_button'))
                        if WarMenu.IsItemHovered() then
                            WarMenu.ToolTip(_lang('save_button_tip'))
                        end
                        if confirm == 'select' then
                            onStartupMS = mouseSensivity
                            onStartupZS = zoomSensivity
                            onStartupIM = invertMouse
                            SetResourceKvpInt('mouseSensivity', mouseSensivity)
                            SetResourceKvpInt('zoomSensivity', zoomSensivity)
                            SetResourceKvpInt('invertMouse', invertMouse == true and 1 or 0)
                            WarMenu.resetSelectedOption()
                        end
                    end

                    WarMenu.End()
                end

                if WarMenu.Begin('change_weathertime') then

                    WarMenu.MenuButton(_lang('changeweather_button'), 'change_weather', '→→→')

                    local anyInput, inputText = WarMenu.InputButton('Set Time (24h format)', 'AS_ATE_HOURS', nil, 2, nil, nil)
                    if anyInput and inputText then
                        local clockTime = tonumber(inputText)
                        if clockTime then
                            if clockTime < 0 or clockTime > 23 then
                                showNotification(_lang('outofrenege_time'))
                            else
                                activeTime = clockTime
                                pervTime = GetClockHours()
                            end
                        else
                            showNotification(_lang('outofrenege_time'))
                        end

                    end

                    if activeTime then
                        local disableTime = WarMenu.Button(_lang('disabletime'))
                        if disableTime  == 'select' or disableTime == 'right' then
                            showNotification(_lang('time_disabled'))
                            NetworkOverrideClockTime(pervTime, 0, 0)
                            activeTime = nil
                            pervTime = nil
                            WarMenu.resetSelectedOption()
                        elseif disableTime == 'left' then
                            WarMenu.GoBack()
                        end

                    end

                    if activeWeather then
                        local disableWeather = WarMenu.Button(_lang('disableweather'))
                        if disableWeather == 'select' or disableWeather == 'right' then

                            showNotification(_lang('weather_disabled'))
                            SetWeatherTypeNowPersist(lastWeatherType)
                            activeWeather = nil
                            lastWeatherType = nil
                            WarMenu.resetSelectedOption()
                        elseif disableWeather == 'left' then
                            WarMenu.GoBack()
                        end
                    end

                    WarMenu.End()
                end

                if WarMenu.Begin('change_weather') then

                    for weather, weatherHash in pairs(Config.AvailableWeatherTypes) do
                        
                        local rightIcon = nil
                        if weather == activeWeather then
                            weatherBtn = WarMenu.SpriteButton(string.lower(weather), 'commonmenu', 'shop_box_tick')
                        else
                            weatherBtn = WarMenu.Button(string.lower(weather))
                        end
                        if weatherBtn == 'select' or weatherBtn == 'right' then
                            if not activeWeather then
                                for weather2, weatherHash2 in pairs(Config.AvailableWeatherTypes) do
                                    if weatherHash2 == GetPrevWeatherTypeHashName() then
                                        lastWeatherType = weather2
                                    end
                                end
                            end
                            activeWeather = weather

                        elseif weatherBtn == 'left' then
                            WarMenu.GoBack()
                        end

                    end

                    WarMenu.End()
                end

                if WarMenu.Begin('ESX_data') then

                    if targetESXData then

                        WarMenu.Button(_lang('cash', { ['$cash'] = targetESXData.money }))
                        WarMenu.Button(_lang('bank', { ['$bank'] = targetESXData.bank }))

                        if targetESXData.inventory and #targetESXData.inventory > 0 then

                            WarMenu.Button(' ')
                            WarMenu.Button(_lang('inventory_info'))

                            for i=1, #targetESXData.inventory do
                                WarMenu.Button(targetESXData.inventory[i].label, '~b~'..targetESXData.inventory[i].count)
                            end

                        end

                    else
                        WarMenu.Button(_lang('no_playerdata'))
                    end

                    WarMenu.End()
                end


                Wait(1)
            end
        end)
    end
end


RegisterNetEvent('AdvancedSpectate:clientCB:playerList')
AddEventHandler('AdvancedSpectate:clientCB:playerList', function(playerList)
    playersData = playerList
end)

RegisterNetEvent("AdvancedSpectate:clientCB:getPlayerData")
AddEventHandler("AdvancedSpectate:clientCB:getPlayerData", function(coords, identifiers)
    playerCallbackedCoords = coords
    targetCallbackIdentifiers = identifiers
    waitingOnCallback = false
end)

function changeDetected()
    return mouseSensivity ~= onStartupMS or zoomSensivity ~= onStartupZS or invertMouse ~= onStartupIM
end

function getPlayerData(playerId, cb)

    local playerCoords = nil
    if onesyncState.infinite then
        TriggerServerEvent('AdvancedSpectate:server:getPlayerData', playerId)
        waitingOnCallback = true
        while waitingOnCallback do
            Wait(10)
        end
        Wait(100)
        playerCoords = playerCallbackedCoords
    else
        playerCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerId)))
    end

    cb(playerCoords, targetCallbackIdentifiers)
end


function SpectatePlayer(playerId, index)
    targetIdentifiers = nil
    local playerPed = PlayerPedId()

    if inSpectate and inSpectate == playerId then
        showNotification(_lang('already_spectating'))
    else

        if not inSpectate then
            myLastPos = GetEntityCoords(playerPed)
        end
        getPlayerData(playerId, function(coords, identifiers)
            targetIdentifiers = identifiers
            
            -- Transition
            local switchType = GetIdealPlayerSwitchType(myLastPos, coords)
            if switchType == 3 then
                switchType = 2
            end
            --DisplayRadar(false)
            SwitchOutPlayer(playerPed, 0, switchType)
            Wait(500)
            local teleported = false
            while GetPlayerSwitchState() ~= 5 and GetPlayerSwitchState() ~= 12 do
                Wait(50)
                if GetPlayerSwitchState() == 3 and not teleported then
                    teleported = true
                    SetEntityVisible(playerPed, false)
                    NetworkSetEntityInvisibleToNetwork(playerPed, true)
                    SetEntityInvincible(playerPed, true)
                    SetLocalPlayerInvisibleLocally(true)
                    SetEntityCoords(playerPed, coords.x, coords.y, coords.z + (Config.zOffset * 0.0), true, false, false, false)
                    SetEntityCollision(playerPed, false, false)
                    NetworkSetFriendlyFireOption(false)
                end
            end
            Wait(300)
            local targetClientId = GetPlayerFromServerId(playerId)
            if targetClientId ~= -1 then
                local targetPed = GetPlayerPed(targetClientId)
                if targetPed ~= 0 and targetPed ~= playerPed then
                    SetEntityVisible(playerPed, false)
                    NetworkSetEntityInvisibleToNetwork(playerPed, true)
                    SetLocalPlayerInvisibleLocally(true)
                    AttachEntityToEntity(playerPed, targetPed, 0, 0.0, -0.6, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, false)
                    SwitchInPlayer(targetPed)
                    while GetPlayerSwitchState() ~= 12 do
                        SetEntityVisible(playerPed, false)
                        Wait(50)
                    end

                    inSpectate = playerId
                    inSpecIndex = index
                    WarMenu.OpenMenu('main')
                    --DisplayRadar(true)
                    inSpectateLoop()
                end
            else
                showNotification(_lang('invalid_player'))
                exitSpectate()
            end
            if not inSpectate then
                showNotification(_lang('invalid_player'))
                SetEntityCoords(playerPed, myLastPos, true, false, false, false)
                StopPlayerSwitch()
                --DisplayRadar(true)
                SetEntityCollision(playerPed, true, true)
                SetEntityVisible(playerPed, true)
                NetworkSetEntityInvisibleToNetwork(playerPed, false)
                SetEntityInvincible(playerPed, false)
                NetworkSetFriendlyFireOption(true)
            end
        end)

    end

end

function exitSpectate()
    isExiting = true
    local playerPed = PlayerPedId()

    local switchType = GetIdealPlayerSwitchType(GetEntityCoords(playerPed), myLastPos)
    if switchType == 3 then
        switchType = 2
    end
    --DisplayRadar(false)
    SwitchOutPlayer(playerPed, 0, switchType)

    while GetPlayerSwitchState() ~= 5 and GetPlayerSwitchState() ~= 12 do
        Wait(10)
    end
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(targetCamera)
    targetCamera = nil

    DetachEntity(playerPed, true, true)
    SetEntityCoords(playerPed, myLastPos, true, false, false, false)
    SetEntityCollision(playerPed, true, true)
    SetEntityVisible(playerPed, true)
    NetworkSetEntityInvisibleToNetwork(playerPed, true)
    SetEntityInvincible(playerPed, false)
    SetLocalPlayerInvisibleLocally(false)
    NetworkSetFriendlyFireOption(true)

    SwitchInPlayer(playerPed)

    while GetPlayerSwitchState() ~= 12 do
        Wait(50)
    end

    inSpectate = false
    inSpecIndex = nil
    isExiting = false
    activeWeather = nil
    lastWeatherType = nil
    activeTime = nil
    pervTime = nil
    --DisplayRadar(true)
    WarMenu.OpenMenu('main')
    WarMenu.resetSelectedOption()   -- Reset it back to first index
end

-- https://github.com/esx-framework/esx-framework.github.io/blob/development/docs/es_extended2/client/functions/math/polar3dtoworld3d.md
local function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
    local polarAngleRad = polarAngleDeg * math.pi / 180.0
    local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0
    local pos = {
            x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
            y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
            z = entityPosition.z - radius * math.cos(azimuthAngleRad)
    }
    return pos
end

function inSpectateLoop()

    CreateThread( function()
        if not loopActive then
            
            loopActive = true
            while inSpectate do
                local playerPed = PlayerPedId()
                local targetClientId = GetPlayerFromServerId(inSpectate)
                local targetPed = GetPlayerPed(targetClientId)

                if isExiting then
                    break
                end

                DisableAllControlActions(0)
                EnableControlAction(0, 0, true)    -- V
                EnableControlAction(0, 1, true)    -- Mouse X Axis
                EnableControlAction(0, 2, true)    -- Mouse Y Axis
                EnableControlAction(0, 38, true)    -- E
                EnableControlAction(0, 177, true)   -- Backspace / ESC / RMB
                EnableControlAction(0, 202, true)   -- Backspace / ESC
                EnableControlAction(0, 200, true)   -- ESC
                EnableControlAction(0, 199, true)   -- Pause
                EnableControlAction(0, 187, true)   -- DOWN
                EnableControlAction(0, 188, true)   -- UP
                EnableControlAction(0, 189, true)   -- LEFT
                EnableControlAction(0, 190, true)   -- RIGHT
                EnableControlAction(0, 191, true)   -- SELECT
                EnableControlAction(0, 194, true)   -- BACK
                EnableControlAction(0, 249, true)   -- N    (PTT)
                EnableControlAction(0, 245, true)   -- T    (chat)

                DisableFirstPersonCamThisFrame()

                SetEntityVisible(playerPed, false)

                if IsDisabledControlJustPressed(0, Config.KeyWhileSpectating) then
                    OpenMenu(false)
                end

                local targetCoords = GetEntityCoords(targetPed)
                if targetCamera then
                    if IsDisabledControlPressed(2, 241) then radius = radius + (zoomSensivity / 10) end
                    if IsDisabledControlPressed(2, 242) then radius = radius - (zoomSensivity / 10) end
                    if radius > -2.0 then radius = -2.0 end
                    if radius < -12.0 then radius = -12.0 end

                    local xMagnitude = GetDisabledControlNormal(0, 1)
                    local yMagnitude = GetDisabledControlNormal(0, 2)

                    local polarAngleDeg, azimuthAngleDeg = calculateMouseRotation(xMagnitude, yMagnitude, mouseSensivity)
                    local nextCamLocation = polar3DToWorld3D(targetCoords, radius, polarAngleDeg, azimuthAngleDeg)
                    SetCamCoord(targetCamera, nextCamLocation.x, nextCamLocation.y, nextCamLocation.z)
                    PointCamAtEntity(targetCamera, targetPed)

                else

                    targetCamera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
                    SetCamCoord(targetCamera, targetCoords)
                    SetCamActive(targetCamera, true)

                    SetCamParams(targetCamera,
                    targetCoords,  -- coords
                    GetGameplayCamRot(0), -- rot
                    50.0, 1500, 1, 3, 1)

                    RenderScriptCams(true, true, 750, 1, 0)
                end

                if activeWeather then
                    if GetHashKey(activeWeather) ~= GetPrevWeatherTypeHashName() then
                        SetWeatherTypeNowPersist(activeWeather)
                    end
                end

                if activeTime then
                    if activeTime ~= GetClockHours() then
                        NetworkOverrideClockTime(activeTime, 0, 0)
                    end
                end

                Wait(3)

                if targetClientId == -1 then
                    showNotification(_lang('client_outofrange'))
                    exitSpectate()
                end
            end
            loopActive = false

        end

    end)

end

-- exports
function OpenMenu(force)
    if permissions then
        if WarMenu.IsAnyMenuOpened() then
            WarMenu.CloseMenu()
            if force then
                WarMenu.OpenMenu('main')
            end
        else
            WarMenu.OpenMenu('main')
        end
    end
end

function HavePermission()
    return permissions
end
