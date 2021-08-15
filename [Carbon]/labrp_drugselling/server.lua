ESX = nil

TriggerEvent("esx:getSharedObject",function(obj)
    ESX = obj
end)

function getReputation(identifier)
    return tonumber(
        MySQL.Sync.fetchScalar(
            "SELECT `drugrep` FROM users WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )
    )
end

function giveReputation(identifier, reputation)
    MySQL.Async.execute(
        "UPDATE `users` SET `drugrep`= `drugrep` + @reputation WHERE `identifier` = @identifier",
        {["@reputation"] = reputation, ["@identifier"] = identifier},
        function()
        end)
end

function removeReputation(identifier)
    MySQL.Async.execute(
        "UPDATE `users` SET `drugrep`= @reputation WHERE `identifier` = @identifier",
        {["@reputation"] = 0, ["@identifier"] = identifier},
        function()
        end)
end

RegisterServerEvent("gl-drugselling::giveReputation")
AddEventHandler("gl-drugselling:giveReputation", function(identifier, reputation)
    giveReputation(identifier, reputation)
end)

RegisterServerEvent("gl-drugselling:removeReputation")
AddEventHandler("gl-drugselling:removeReputation", function(targetID)
	local xPlayer = ESX.GetPlayerFromId(targetID)
    removeReputation(xPlayer.identifier)
end)


ESX.RegisterServerCallback("gl-drugselling:getUserRep", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(getReputation(xPlayer.identifier))
end)

RegisterServerEvent('checksellcops')
AddEventHandler('checksellcops', function()
    local xPlayers = ESX.GetExtendedPlayers()
    local cops = 0
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end

    if cops >= 2 then
        TriggerClientEvent('gl-drugselling:checkBallaSell', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Im currently not intrested!'})
    end
end)

-- The main juice, triggered from the client this will check all drugs against your config 
-- and see if you have the one requested by the ped
RegisterServerEvent('gl-drugselling:checkDrugs')
AddEventHandler('gl-drugselling:checkDrugs',function(drug, reputation, amount)
   	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local hasDrugs = true
    local count = math.random(1,Config.MaxAmountSold)
    local price = Config.DrugList[drug].Price
            if xPlayer.getInventoryItem(Config.DrugList[drug].Name).count < count then
            	hasDrugs = false
            end

			if hasDrugs then
                	addRep = math.random(Config.MinRepIncrease,Config.MaxRepIncrease)
                	TriggerClientEvent('gl-drugselling:updateUserRep',source,addRep)
                	Wait(5000)
                	xPlayer.removeInventoryItem(Config.DrugList[drug].Name, count)
                	money = math.floor(count * price + (reputation * 0.2))
                	--money = math.floor( (count * Config.Drugs[drug].BasePrice + reputation / 2) )
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You have sold ' .. count .. ' ' .. Config.DrugList[drug].Name .. ' for $' .. money, length = 10000 })	
                	xPlayer.addMoney(money)
	            	giveReputation(xPlayer.identifier, addRep)	
            end
end)
