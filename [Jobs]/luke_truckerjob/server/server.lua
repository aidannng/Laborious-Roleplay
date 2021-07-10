ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('luke_truckerjob:CheckLevel', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * FROM luke_truckerjob WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(data)
        if data[1] ~= nil then
            local level = data[1].level
            local progress = data[1].progress
            callback(level, progress)
        else
            MySQL.Async.execute('INSERT INTO luke_truckerjob (identifier, progress, level) VALUES (@identifier, 0, 1)', {
                ['@identifier'] = identifier
            }, function(affectedRows)
                callback(1, 0)
            end)
        end
    end)
end)

RegisterNetEvent('luke_truckerjob:FinishJob')
AddEventHandler('luke_truckerjob:FinishJob', function(pay)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    if Config.PaymentInCash then
        xPlayer.addMoney(pay)
    else
        xPlayer.addAccountMoney('bank', pay)
    end
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You were paid $'.. pay, })
    --xPlayer.showNotification('You were paid ~g~$'.. pay)

    progress = GetPlayerProgress(identifier)
    level = GetPlayerLevel(identifier)

    if Config.MultiplyProgressPerLevel then
        maxProgress = Config.MaxProgress * level
    else
        maxProgress = Config.MaxProgress
    end

    if progress + 1 <= maxProgress then
        MySQL.Sync.execute('UPDATE `luke_truckerjob` SET progress = progress + 1 WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        })
        progress = progress + 1
        if progress == maxProgress and level < Config.MaxLevel then
            MySQL.Sync.execute('UPDATE `luke_truckerjob` SET progress = 0, level = level + 1 WHERE identifier = @identifier', {
                ['@identifier'] = identifier
            })
            level = level + 1
            progress = 0
            if Config.MultiplyProgressPerLevel then
                maxProgress = Config.MaxProgress * level
            end
        end
    end

    TriggerClientEvent('luke_truckerjob:UpdateNUI', src, level, progress, maxProgress)
end)

function GetPlayerLevel(identifier)
    return MySQL.Sync.fetchScalar('SELECT `level` FROM `luke_truckerjob` WHERE `identifier` = @identifier', {
        ['@identifier'] = identifier
    })
end

function GetPlayerProgress(identifier)
    return MySQL.Sync.fetchScalar('SELECT `progress` FROM `luke_truckerjob` WHERE `identifier` = @identifier', {
        ['@identifier'] = identifier
    })
end