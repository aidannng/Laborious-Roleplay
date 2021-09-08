Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

    TriggerEvent("labrp_garage:resetVehicles")
end)

ESX.RegisterServerCallback('luke_vehiclegarage:GetVehicles', function(source, callback, type, garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.job.name
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `type` = @type AND `garage` = @garage', {
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

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `type` = @type AND `garage` = @garage', {
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

ESX.RegisterServerCallback('luke_vehiclegarage:GetImpound', function(source, callback, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `garage` = @garage', {
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

RegisterNetEvent('luke_vehiclegarage:ChangeStored')
AddEventHandler('luke_vehiclegarage:ChangeStored', function(plate, stored, garage)
    local xPlayer = ESX.GetPlayerFromId(source)


    local plate = ESX.Math.Trim(plate)


    MySQL.Async.execute('UPDATE `owned_vehicles` SET `stored` = @stored, `garage` = NULL WHERE `plate` = @plate', {
        ['@stored'] = 0,
        ['@plate'] = plate,
    }, function(rowsChanged)
    end)
end)

RegisterNetEvent('luke_vehiclegarage:StoreVehicle')
AddEventHandler('luke_vehiclegarage:StoreVehicle', function(plate, garage)
    local xPlayer = ESX.GetPlayerFromId(source)


    local plate = ESX.Math.Trim(plate)


    MySQL.Async.execute('UPDATE `owned_vehicles` SET `stored` = @stored, `garage` = @garage WHERE `plate` = @plate', {
        ['@stored'] = 1,
        ['@plate'] = plate,
        ['@garage'] = garage
    }, function(rowsChanged)
    end)
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

RegisterNetEvent('luke_vehiclegarage:PayImpound')
AddEventHandler('luke_vehiclegarage:PayImpound', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getInventoryItem('money').count >= amount then
            xPlayer.removeMoney(amount)
        elseif xPlayer.getAccount('bank').money >= amount then
            xPlayer.removeAccountMoney('bank', amount)
        else
            return TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You don't have enough money in your bank"})
        end
    end
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


RegisterNetEvent('labrp_garage:resetVehicles')
AddEventHandler('labrp_garage:resetVehicles', function()
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `stored` = @stored, `garage` = @garage WHERE `garage` IS NULL', {
        ['@garage'] = "Impound",
        ['@stored'] = true,
    })
end)

ESX.RegisterServerCallback('luke_vehiclegarage:GetJobImpound', function(source, callback, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.job.name
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner` = @job AND `type` = @type AND `garage` = @garage', {
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