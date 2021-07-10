ESX = nil
TriggerEvent("esx:getSharedObject",function(obj)
    ESX = obj
end)


RegisterServerEvent('esxoxy:serverPay')
AddEventHandler('esxoxy:serverPay', function(money)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('black_money').money >= 1500 then
        xPlayer.removeAccountMoney('black_money', money)
        TriggerClientEvent("oxyrunesx:startOxyRun", source)
    else
       --xPlayer.showNotification("You dont have enough ~r~Dirty Money ~w~for this!") 
       TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You dont have enough Dirty Money for this!', length = 2500, style = { ['background-color'] = '#4287f5', ['color'] = '#ffffff' } })
    end
end)

RegisterServerEvent('esxoxy:moneyforPackage')
AddEventHandler('esxoxy:moneyforPackage', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = math.random(Config.MinAmount, Config.MaxAmount)
    xPlayer.addMoney(amount)

end)

