Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

    TriggerEvent("labrp_garage:resetVehicles")
    TriggerEvent("labrp_garage:SeizedVehicleTimer")
end)

ESX.RegisterServerCallback('luke_vehiclegarage:GetVehicles', function(source, callback, type, garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.job.name
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `type` = @type AND `garage` = @garage AND `seized` IS NULL', {
        ['@identifier'] = identifier,
        ['@type'] = type,
        ['@garage'] = garage,
    }, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local veh = json.decode(v.vehicle)
                local health = json.decode(v.health)
                table.insert(vehicles, {plate = v.plate, vehicle = veh, stored = v.stored, health = health})
            end
            callback(vehicles)
        else
            callback(nil)
        end
    end)
end)

ESX.RegisterServerCallback('luke_vehiclegarage:GetJobVehicles', function(source, callback, type, garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.job.name
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `type` = @type AND `garage` = @garage AND `seized` IS NULL', {
        ['@identifier'] = job,
        ['@type'] = type,
        ['@garage'] = garage
    }, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local veh = json.decode(v.vehicle)
                local health = json.decode(v.health)
                table.insert(vehicles, {plate = v.plate, vehicle = veh, stored = v.stored, health = health})
            end
            callback(vehicles)
        else
            callback(nil)
        end
    end)
end)

ESX.RegisterServerCallback('luke_vehiclegarage:GetSeized', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.job.name
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `seized` IS NOT NULL', {
        ['@identifier'] = identifier,
    }, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local veh = json.decode(v.vehicle)
                local health = json.decode(v.health)
                table.insert(vehicles, {plate = v.plate, vehicle = veh, seized = v.seized, health = health})
            end
            callback(vehicles, job)
        else
            callback(nil)
        end
    end)
end)

ESX.RegisterServerCallback('luke_vehiclegarage:GetPoliceSeized', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.job.name
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `seized` IS NOT NULL', {}, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local veh = json.decode(v.vehicle)
                local health = json.decode(v.health)
                table.insert(vehicles, {plate = v.plate, vehicle = veh, seized = v.seized, health = health})
            end
            callback(vehicles)
        else
            callback(nil)
        end
    end)
end)

ESX.RegisterServerCallback('luke_vehiclegarage:GetImpound', function(source, callback, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `type` = @type AND `garage` = @garage AND `seized` IS NULL', {
        ['@identifier'] = identifier,
        ['@type'] = type,
        ['@garage'] = "Impound",
    }, function(results)
        if results[1] ~= nil then
            for k, v in pairs(results) do
                local veh = json.decode(v.vehicle)
                local health = json.decode(v.health)
                table.insert(vehicles, {plate = v.plate, vehicle = veh, health = health})
            end
            callback(vehicles)
        else
            callback(nil)
        end
    end)
end)

ESX.RegisterServerCallback('luke_vehiclegarage:GetJobImpound', function(source, callback, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.job.name
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @job AND `type` = @type AND `garage` = @garage AND `seized` IS NULL', {
        ['@job'] = job,
        ['@type'] = type,
        ['@garage'] = "Impound",
    }, function(results)
        if results[1] ~= nil then
            for k, v in pairs(results) do
                local veh = json.decode(v.vehicle)
                local health = json.decode(v.health)
                table.insert(vehicles, {plate = v.plate, vehicle = veh, health = health})
            end
            callback(vehicles)
        else
            callback(nil)
        end
    end)
end)

ESX.RegisterServerCallback('luke_vehiclegarage:CheckOwnership', function(source, callback, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    local job = xPlayer.job.name

    local plate = ESX.Math.Trim(plate)

    MySQL.Async.fetchAll('SELECT `owner` FROM `owned_vehicles` WHERE `owner` = @owner OR `owner` = @job AND `plate` = @plate', {
        ['@owner'] = identifier,
        ['@plate'] = plate,
        ['@job'] = job
    }, function(result)
        if result then
            callback(true)
        else
            callback(false)
        end
    end)
end)

ESX.RegisterServerCallback('luke_vehiclegarage:CheckJobOwnership', function(source, callback, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.job.name

    local plate = ESX.Math.Trim(plate)

    MySQL.Async.fetchScalar('SELECT 1 FROM `owned_vehicles` WHERE `owner` = @owner AND `plate` = @plate', {
        ['@owner'] = job,
        ['@plate'] = plate
    }, function(result)
        if result then
            callback(true)
        else
            callback(false)
        end
    end)
end)

RegisterNetEvent('luke_vehiclegarage:ChangeStored')
AddEventHandler('luke_vehiclegarage:ChangeStored', function(plate, stored, garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    local plate = ESX.Math.Trim(plate)

    if stored then
        MySQL.Async.execute('UPDATE `owned_vehicles` SET `stored` = @stored, `garage` = @garage WHERE `plate` = @plate', {
            ['@stored'] = stored,
            ['@plate'] = plate,
            ['@garage'] = garage
        })
    else
        MySQL.Async.execute('UPDATE `owned_vehicles` SET `stored` = @stored, `garage` = NULL WHERE `plate` = @plate', {
            ['@stored'] = stored,
            ['@plate'] = plate
        })
    end
end)

RegisterNetEvent('luke_vehiclegarage:SaveVehicle')
AddEventHandler('luke_vehiclegarage:SaveVehicle', function(vehicle, health, plate)
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle, `health` = @health WHERE `plate` = @plate', {
        ['@health'] = json.encode(health),
        ['@vehicle'] = json.encode(vehicle),
        ['@plate'] = plate
    }, function(rowsChanged)
        
    end)
end)

RegisterNetEvent('labrp_garage:resetVehicles')
AddEventHandler('labrp_garage:resetVehicles', function()
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `stored` = @stored, `garage` = @garage WHERE `garage` IS NULL', {
        ['@garage'] = "Impound",
        ['@stored'] = true,
    })
end)

RegisterNetEvent('labrp_garage:SeizedVehicleTimer')
AddEventHandler('labrp_garage:SeizedVehicleTimer', function()
    MySQL.Async.fetchAll('SELECT plate, seized FROM `owned_vehicles` WHERE `seized` IS NOT NULL AND `seized` > 0', {}, function(result)
        if result[1] ~= nil then
            for x=1, #result, 1 do
                local seized = result[x].seized - 8
                MySQL.Async.execute('UPDATE `owned_vehicles` SET `seized` = @seized WHERE `plate` = @plate', {
                  ['@plate'] = result[x].plate,
                  ['@seized'] = seized
                })
            end
        end
    end)
end)

RegisterNetEvent('luke_vehiclegarage:PayImpound')
AddEventHandler('luke_vehiclegarage:PayImpound', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bank = xPlayer.getAccount('bank').money
    if xPlayer then
        if Config.PayInCash then
            if xPlayer.getMoney() >= amount then
                xPlayer.removeMoney(amount)
            elseif bank >= amount then
                xPlayer.removeAccountMoney('bank', amount)
            else
                return TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You don\'t have enough money on you.', })
            end
        end
    end
end)


RegisterNetEvent('luke_vehiclegarage:SetOwner')
AddEventHandler('luke_vehiclegarage:SetOwner', function(plate, vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `type`, `stored`) VALUES (@owner, @plate, @vehicle, @type, @stored)', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate,
        ['@vehicle'] = json.encode(vehicle),
        ['@type'] = 'car',
        ['@stored'] = false
    }, function(rowChanged)
    end)
end)


ESX.RegisterServerCallback('luke_vehiclegarage:ShareStatus', function(source, callback, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    local job = xPlayer.job.name

    local plate = ESX.Math.Trim(plate)

    MySQL.Async.fetchAll('SELECT `owner` FROM `owned_vehicles` WHERE `plate` = @plate', {
        ['@plate'] = plate,
    }, function(result)
        if result[1].owner ~= job then
            callback(false)
        else
            callback(true)
        end
    end)
end)

RegisterNetEvent('luke_vehiclegarage:SwitchOwnerShip')
AddEventHandler('luke_vehiclegarage:SwitchOwnerShip', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('UPDATE `owned_vehicles` SET `owner` = @identifier WHERE `plate` = @plate', {
        ['@identifier'] = identifier,
        ['@plate'] = plate
    })
end)

RegisterNetEvent('luke_vehiclegarage:SwitchOwnerShip')
AddEventHandler('luke_vehiclegarage:SwitchOwnerShip', function(TargetID, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = TargetID
    local plate = plate

    MySQL.Async.execute('UPDATE `owned_vehicles` SET `owner` = @identifier WHERE `plate` = @plate', {
        ['@identifier'] = identifier,
        ['@plate'] = plate
    })
end)

ESX.RegisterServerCallback('luke_vehiclegarage:SpawnVehicle', function(source, callback, model, coords, heading)
    if type(model) == 'string' then model = GetHashKey(model) end
    Citizen.CreateThread(function()
        entity = CreateVehicle(model, coords, heading, true, true)
        while not DoesEntityExist(entity) do Wait(20) end
        netid = NetworkGetNetworkIdFromEntity(entity)
        callback(netid)
    end)
end)

RegisterNetEvent('luke_vehiclegarage:SetFreeSeize')
AddEventHandler('luke_vehiclegarage:SetFreeSeize', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('UPDATE `owned_vehicles` SET `seized` = NULL, `garage` = @garage, `stored` = @stored WHERE `plate` = @plate', {
        ['@identifier'] = identifier,
        ['@plate'] = plate,
        ['@garage'] = "Impound",
        ['@stored'] = 1,
        ['@seized'] = 0
    })
end)


