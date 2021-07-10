RegisterServerEvent('d-phone:server:fire')
AddEventHandler('d-phone:server:fire', function(source, id, unemployed2 )
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(id)
    local grade = 0
    if zPlayer then
            Wait(100)
            zPlayer.setJob("unemployed", 0)
            TriggerClientEvent("d-notification", _source, _U("successfired"), 5000, "orange")
            TriggerClientEvent("d-notification", zPlayer.source, _U("gotfired"), 5000, "orange")
    else
         TriggerClientEvent("d-notification", _source, _U("personoffline"), 5000, "red")
    end
end)

-- ESX 1.1
TriggerEvent('es:addGroupCommand', 'sca', 'user', function(p, args, user)
    TriggerClientEvent("d-phone:client:acceptsharecontact", p)
end)

TriggerEvent('es:addGroupCommand', 'scd', 'user', function(p, args, user)
    TriggerClientEvent("d-phone:client:declinesharecontact", p)
end)

TriggerEvent('es:addGroupCommand', 'reloaddata', 'user', function(p, args, user)
    TriggerEvent("d-phone:server:reloaduserdata", p)
end)

-- ESX 1.2
--[[
ESX.RegisterCommand('sca', 'user', function(xPlayer, args, showError)
    TriggerClientEvent("d-phone:client:acceptsharecontact", xPlayer.source)
  end)
  
  ESX.RegisterCommand('scd', 'user', function(xPlayer, args, showError)
    TriggerClientEvent("d-phone:client:declinesharecontact", xPlayer.source)
  end)
  ]]

  function getPhoneRandomNumber()
    local numBase0 = math.random(Config.LowerPrefix, Config.HigherPrefix)
    local numBase1 = math.random(Config.LowerNumber, Config.HigherNumber)
    local num
    if Config.Prefix == true then
        num = string.format(numBase0.. ""..numBase1)
    else
        num = string.format(numBase1)
    end
	return num
end

function getRandomCardNumber()
    local numBase0 = math.random(1000000000000000, 9999999999999999)
    local num = string.format(numBase0)

	return num
end


RegisterCommand(Config.CommandText, function(source, args, raw)
    if Config.Command == true then
        TriggerClientEvent('d-phone:client:openphone', source)
    end
  end)

--   Advertisement
RegisterServerEvent('d-phone:server:advertisement:newad')
AddEventHandler('d-phone:server:advertisement:newad', function(source, clientsource, name, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local Data = UserData[clientsource]
    local number = Data.phone_number
    local date = os.date("%d") .. "."  .. os.date("%m")
    local time = os.date("%H") .. ':' .. os.date("%M")
    local id = 0
    if advertisement ~= nil then
        for i,v in pairs(advertisement) do
            id = v.id
            break
        end
    end
    Wait(10)
    table.insert(advertisement,
        {
            id = (id + 1),
            name = name,
            number = number,
            message = message,
            date = date,
            time = time
        }
    )
    table.sort(advertisement, function(a,b) return a.id > b.id end)
    
    TriggerEvent("d-phone:server:advertisement:refresh", _source)
    MySQL.Async.execute("INSERT INTO `phone_advertisement` (`name`, `number`, `message`, `date`, `time`) VALUES (@name, @number, @message, @date, @time)",
        {['@name'] = name, 
        ['@number'] = number,
        ['@message'] = message,
        ['@date'] = date,
        ['@time'] = time,
    })
end)