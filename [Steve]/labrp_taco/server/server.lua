ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('labrp_taco:givereward')
AddEventHandler('labrp_taco:givereward', function()
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(math.random(1150, 1900))
    local dirty = xPlayer.getInventoryItem('black_money').count
    local packed = xPlayer.getInventoryItem('packagedweed').count
    local percent = math.random(75, 100)

    if(packed > 4) then
        xPlayer.removeInventoryItem('packagedweed', 5)
        xPlayer.addInventoryItem('black_money', math.random(1000, 1750))
    elseif dirty > 999 then
        xPlayer.removeInventoryItem("black_money", 1000)

        local lowten = math.random(5, 7)
        lowten = lowten * 10
        local lowone = math.random(0, 9)
        local lowpercent = lowten + lowone

        local highten = math.random(8, 10)
        if(highten == 10) then
            percent = 100
        else
            highten = highten * 10
            local highone = math.random(0, 9)
            local highpercent = highten + highone

            percent = math.random(lowpercent, highpercent)
        end

        xPlayer.addMoney(1000*(percent/100))
    end
end)