ESX = nil
onesyncState = {}
playersData = {}
playersWithPerms = {}
ESXTimeout = {}
waitSwitch = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

onesyncState.enabled = GetConvar('onesync_enabled', false) == 'true'
onesyncState.infinite = GetConvar('onesync_enableInfinity', false) == 'true'
onesyncState.beyond = GetConvar('onesync_enableBeyond', false) == 'true'

dprint(('Onesync : %s\nInfinite : %s\nBeyond : %s\nHotel ?.. sorry wrong place'):format(onesyncState.enabled, onesyncState.infinite, onesyncState.beyond))

function havePermission(playerId)
    local havePerm = false

    if Config.permissions['ALL'] then
        havePerm = Config.permissions['ALL']
    end

    if ESX then
        SetTimeout(5000, function()
            ESXTimeout[playerId] = true
        end)
        while not ESX.GetPlayerFromId(playerId) do
            Wait(10)
            if ESXTimeout[playerId] then
                ESXTimeout[playerId] = nil
                break
            end
        end
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            local xpGroup = xPlayer.group
            for rank, perms in pairs(Config.ESX_permissions) do
                if xpGroup == rank then
                    havePerm = perms
                    break
                end
            end

        end
    end

    local ids = GetPlayerIdentifiers(playerId)
    for i=1, #ids do
        local identifier = ids[i]
        if Config.permissions[identifier] then
            havePerm = Config.permissions[identifier]
            break
        end
    end

    return havePerm
end

RegisterNetEvent('AdvancedSpectate:serverCB:newPlayerData')
AddEventHandler('AdvancedSpectate:serverCB:newPlayerData', function()
    local source = source
    local permissions = havePermission(source)
    table.insert(playersData, {
        playerId = tonumber(source),
        playerName = GetPlayerName(source),
        joined = GetGameTimer(),
        permissions = permissions
    })
    if permissions then
        playersWithPerms[source] = permissions
    end
    TriggerClientEvent('AdvancedSpectate:clientCB:newPlayerData', source, onesyncState, playersData, permissions)
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    for i=1, #playersData do
        if playersData[i].playerId == source then
            table.remove(playersData, i)
            break
        end
    end

    if playersWithPerms[source] then
        playersWithPerms[source] = nil
    end

  end)

RegisterNetEvent('AdvancedSpectate:server:getPlayerData')
AddEventHandler('AdvancedSpectate:server:getPlayerData', function(playerId)
    local source = source
    local permission = playersWithPerms[source]
    if permission then

        local steam, license, discord, xbl, ip = "N/A", "N/A", "N/A", "N/A", "N/A"
        for _, identifier in pairs(GetPlayerIdentifiers(playerId)) do
            if identifier:find("steam:") then
                steam = identifier:gsub("steam:", "")
            elseif identifier:find("license:") then
                license = identifier:gsub("license:", "")
            elseif identifier:find("xbl:") then
                xbl = identifier:gsub("xbl:", "")
            elseif identifier:find("ip:") then
                if not permission.hideSensitiveInfo then    -- hide IP if player dont have permission
                    ip = identifier:gsub("ip:", "")
                end
            elseif identifier:find("discord:") then
                discord = identifier:gsub("discord:", "")
            end
        end

        local playerIds = {
            steam = steam,
            rockstar = license,
            xboxlive = xbl,
            ip = ip,
            discord = discord
        }

        TriggerClientEvent('AdvancedSpectate:clientCB:getPlayerData', source, GetEntityCoords(GetPlayerPed(playerId)), playerIds)
    else
        -- player dont have permission and is trying to get somebody informations
    end
end)

CreateThread( function()
    while true do
        if Config.onlyUpdatePermissions then
            for playerId, permissions in pairs(playersWithPerms) do
                TriggerClientEvent('AdvancedSpectate:clientCB:playerList', playerId, playersData)
            end
        else
            TriggerClientEvent('AdvancedSpectate:clientCB:playerList', -1, playersData)
        end
        Wait((Config.sendUpdatesInterval * 1000))
    end

end)

if ESX then

    ESX.RegisterServerCallback('AdvancedSpectate:ESXCB:getPlayerData', function(source, cb, playerId)
        if playersWithPerms[source] then

            local data = {}
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer then

                if xPlayer.bank then
                    data.bank = xPlayer.bank
                else
                    data.bank = xPlayer.getAccount('bank').money
                end
                if xPlayer.money then
                    data.money = xPlayer.money
                else
                    data.money = xPlayer.getAccount('money').money
                end

                data.inventory = xPlayer.inventory

                cb(data)
            else
                cb(false)
            end

        else
            -- player dont have permission and is trying to get somebody informations

        end

    end)

end