ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("repairkit", function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do
    Citizen.Wait(0)
    xPlayer = ESX.GetPlayerFromId(source)
  end
  if xPlayer.getInventoryItem("repairkit").count > 0 then
    if math.random(100) > 90 then
      xPlayer.removeInventoryItem("repairkit", 1)
    end
    local itemName = "repairkit"
    TriggerClientEvent("veh:repairing", source, itemName)
  end
end)

ESX.RegisterUsableItem("advancedrepair", function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do
    Citizen.Wait(0)
    xPlayer = ESX.GetPlayerFromId(source)
  end
  if xPlayer.getInventoryItem("advancedrepair").count > 0 then
    if math.random(100) > 60 then
      xPlayer.removeInventoryItem("advancedrepair", 1)
    end
    local itemName = "advancedrepair"
    TriggerClientEvent("veh:repairing", source, itemName)
  end
end)




