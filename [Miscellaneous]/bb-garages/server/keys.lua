local VehicleList = {}

ESX.RegisterServerCallback('vehiclekeys:CheckHasKey', function(source, cb, plate, vehicle)
    local Player =  ESX.GetPlayerFromId(source)
    cb(CheckOwner(plate, Player.getIdentifier(), vehicle))
end)

ESX.RegisterServerCallback('vehiclekeys:server:hasitem', function(source, cb, item)
    local ply = ESX.GetPlayerFromId(source)
    itemcount = ply.getInventoryItem(item).count
    if itemcount > 0 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('vehiclekeys:server:SetVehicleOwner')
AddEventHandler('vehiclekeys:server:SetVehicleOwner', function(plate, vehicle)
    local src = source
    local Player =  ESX.GetPlayerFromId(src)
    if VehicleList ~= nil then
        if DoesPlateExist(plate, vehicle) then
            for k, val in pairs(VehicleList) do
                if val.plate == plate then
                    table.insert(VehicleList[k].owners, Player.getIdentifier())
                end
            end
        else
            local vehicleId = #VehicleList+1
            VehicleList[vehicleId] = {
                plate = plate, 
                vehicle = vehicle,
                owners = {},
            }
            VehicleList[vehicleId].owners[1] = Player.getIdentifier()
        end
    else
        local vehicleId = #VehicleList+1
        VehicleList[vehicleId] = {
            plate = plate, 
            vehicle = vehicle,
            owners = {},
        }
        VehicleList[vehicleId].owners[1] = Player.getIdentifier()
    end
end)

RegisterServerEvent('vehiclekeys:server:GiveVehicleKeys')
AddEventHandler('vehiclekeys:server:GiveVehicleKeys', function(plate, target)
    local src = source
    local Player =  ESX.GetPlayerFromId(src)
    if CheckOwner(plate, Player.getIdentifier()) then
        if  ESX.GetPlayerFromId(target) ~= nil then
            TriggerClientEvent('vehiclekeys:client:SetOwner', target, plate)
            TriggerClientEvent(Config['settings']['notification'], src, "You just gave keys to your vehicles!")
            TriggerClientEvent(Config['settings']['notification'], target, "You just received keys to a vehicle!")
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
        end
    else
        TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "You have no keys to this vehicle!")
    end
end)

function DoesPlateExist(plate, vehicle)
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if val.vehicle == vehicle then
                return true
            end
        end
    end
    return false
end

function CheckOwner(plate, identifier, vehicle)
    local retval = false
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if (val.vehicle ~= nil and val.vehicle == vehicle) or val.plate == plate then
                for key, owner in pairs(VehicleList[k].owners) do
                    if owner == identifier then
                        retval = true
                    end
                end
            end
        end
    end
    return retval
end

