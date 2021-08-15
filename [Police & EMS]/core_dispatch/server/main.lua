ESX = nil

Id = 0

Units = {}
Calls = {}
callSigns = {}
UnitStatus = {}

Names = {}

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

MySQL.ready(
    function()
        MySQL.Async.fetchAll(
            "SELECT identifier,firstname,lastname FROM users WHERE 1",
            {},
            function(info)
                for _, v in ipairs(info) do
                    Names[v.identifier] = {firstname = v.firstname, lastname = v.lastname}
                end
            end
        )
    end
)

RegisterServerEvent("core_dispatch:playerStatus")
AddEventHandler("core_dispatch:playerStatus", function(status)
    local src = source

    if status.carPlate ~= "" then
        Units[src] = {plate = status.carPlate, type = status.type, job = status.job, netId = status.netId}
    else
        Units[src] = {plate = math.random(1111,9999), type = 22, job = status.job, netId = status.netId}
    end
end)

RegisterServerEvent("core_dispatch:removePlayer")
AddEventHandler("core_dispatch:removePlayer", function()
    local src = source

    Units[src] = nil
end)

RegisterServerEvent("core_dispatch:removeCall")
AddEventHandler("core_dispatch:removeCall", function(id)
    local src = source

    if #Calls[tonumber(id)].respondingUnits == 0 then
        Calls[tonumber(id)] = nil
        TriggerClientEvent("core_dispatch:removeCallClient", -1, id, src)
    else
        TriggerClientEvent('core_dispatch:SendTextMessage', src, Config.Text['active_units_error'])
    end
end)

RegisterServerEvent("core_dispatch:unitResponding")
AddEventHandler("core_dispatch:unitResponding", function(id, job)
    local src = source
   
    if Calls[tonumber(id)] ~= nil then
        table.insert(Calls[tonumber(id)].respondingUnits, {unit = src, type = job})
        TriggerClientEvent("core_dispatch:acceptCallClient", src, id, src)

    else
       TriggerClientEvent('core_dispatch:SendTextMessage', src, Config.Text['cant_accept_call'])
    end
end)

RegisterServerEvent("core_dispatch:changeStatus")
AddEventHandler("core_dispatch:changeStatus", function(userid, status)
    UnitStatus[tostring(userid)] = status
   
end)

RegisterServerEvent("core_dispatch:unitDismissed")
AddEventHandler("core_dispatch:unitDismissed", function(id)
    local src = source
    local count = 1

    for _, v in ipairs(Calls[tonumber(id)].respondingUnits) do
        if v.unit == src then
            table.remove(Calls[tonumber(id)].respondingUnits, count)
        end
        count = count + 1
    end
end)

RegisterServerEvent("core_dispatch:forwardCall")
AddEventHandler("core_dispatch:forwardCall", function(id, job)
    local add = true
    for _, v in ipairs(Calls[tonumber(id)].job) do
        if v == job then
            add = false
        end
    end

    if add then
        table.insert(Calls[tonumber(id)].job, job)

        TriggerClientEvent("core_dispatch:callAdded", -1, tonumber(id), Calls[tonumber(id)], job, 5000)
    end
end)

RegisterServerEvent("core_dispatch:addMessage")
AddEventHandler("core_dispatch:addMessage", function(message, location, job, cooldown, sprite, color)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).getIdentifier()
        local phone =
            MySQL.Sync.fetchScalar(
            "SELECT phone_number FROM users WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )
    Calls[Id] = {
        code = "",
        title = "",
        extraInfo = {},
        respondingUnits = {},
        coords = location,
        job = {job},
        phone = phone,
        message = message,
        type = "message",
        caller = src,
        id = Id
    }

    TriggerClientEvent("core_dispatch:callAdded", -1, Id, Calls[Id], job, cooldown or 5000, sprite or 11, color or 5)

    Id = Id + 1
end)

RegisterServerEvent("core_dispatch:addCall")
AddEventHandler("core_dispatch:addCall", function(code, title, info, location, job, cooldown, sprite, color)
    Calls[Id] = {
        code = code,
        title = title,
        extraInfo = info,
        respondingUnits = {},
        coords = location,
        job = {job},
        type = "call",
        id = Id
    }

    TriggerClientEvent("core_dispatch:callAdded", -1, Id, Calls[Id], job, cooldown or 3500, sprite or 11, color or 5)

    Id = Id + 1
end)


RegisterServerEvent("core_dispatch:changeCallSign")
AddEventHandler("core_dispatch:changeCallSign", function(callsign)
        local src = source
        if string.len(callsign) <= 4 then
        local Player = ESX.GetPlayerFromId(src)
        Player.set("callsign", callsign)
        callSigns[src] = callsign
        TriggerClientEvent('core_dispatch:SendTextMessage', src, Config.Text['callsign_changed'])
    else
  TriggerClientEvent('core_dispatch:SendTextMessage', src, Config.Text['callsign_char_long'])
    end
end)


RegisterServerEvent("core_dispatch:arrivalNotice")
AddEventHandler("core_dispatch:arrivalNotice", function(caller)
    if caller ~= nil then
        TriggerClientEvent("core_dispatch:arrivalNoticeClient", caller)
    end
end)

RegisterCommand("callsign", function(source, args, rawCommand)

      local src = source
    local Player = ESX.GetPlayerFromId(src)

    if Player.getJob().name == Config.JobOne.job or Player.getJob().name == Config.JobTwo.job or Player.getJob().name == Config.JobThree.job then
    if string.len(args[1]) <= 4 then
      
        local Player = ESX.GetPlayerFromId(src)
        Player.set("callsign", args[1])
        callSigns[src] = args[1]
        TriggerClientEvent('core_dispatch:SendTextMessage', src, Config.Text['callsign_changed'])
    else
        TriggerClientEvent('core_dispatch:SendTextMessage', src, Config.Text['callsign_char_long'])
    end
else
 TriggerClientEvent('core_dispatch:SendTextMessage', src, Config.Text['no_permission'])
end


end)



RegisterServerEvent("core_dispatch:setCallSign")
AddEventHandler("core_dispatch:setCallSign", function(callsign)
    local src = source
    callSigns[src] = callsign
end)

ESX.RegisterServerCallback("core_dispatch:getPersonalInfo", function(source, cb)
    local identifier = ESX.GetPlayerFromId(source).getIdentifier()
    local firstname = Names[identifier].firstname
    local lastname = Names[identifier].lastname
    cb(firstname, lastname)

end)

ESX.RegisterServerCallback("core_dispatch:getInfo", function(source, cb)
    local generated = {}

    for k, v in pairs(Units) do
        if ESX.GetPlayerFromId(k) then
           local identifier = ESX.GetPlayerFromId(k).getIdentifier()
            local firstname = Names[identifier].firstname
             local lastname = Names[identifier].lastname
            local job = ESX.GetPlayerFromId(source).job.name

            if generated[v.plate] == nil then

                generated[v.plate] = {
                    type = Config.Icons[v.type],
                    units = {{id = k, name = firstname .. " " .. lastname, job = job}},
                    job = v.job -- not sure why this is still neede leaving
                }
            else
                table.insert(generated[v.plate].units, {id = k, name = firstname .. " " .. lastname, job = job})
            end
        end
    end
    cb(generated, Calls, UnitStatus, callSigns)
end)

ESX.RegisterServerCallback("core_dispatch:getUnits", function(source, cb)
    local generated = {}

    for k, v in pairs(Units) do
        if ESX.GetPlayerFromId(source) then
           local identifier = ESX.GetPlayerFromId(source).getIdentifier()
            local firstname = Names[identifier].firstname
             local lastname = Names[identifier].lastname

            generated[k] = {netId = v.netId, firstname = firstname, lastname = lastname, type = v.type, job = v.job}
        end
    end
    cb(generated)
end)