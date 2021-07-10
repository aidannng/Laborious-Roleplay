ESX = nil
CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(250)
    end

    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end) 
        Wait(250) 
    end

    while ESX.GetPlayerData().job == nil do -- Wait for character (job) to load (support for kashacters, etc)
        Wait(250)
    end

    RegisterNetEvent("loaf_assignmotel:buyrandom")
    AddEventHandler("loaf_assignmotel:buyrandom", function()
        TriggerServerEvent("loaf_motel:purchase", Config.Motel, math.random(1, Config.Rooms))
    end)

    RegisterNetEvent("loaf_motel:set_owned")
    AddEventHandler("loaf_motel:set_owned", function(motel, room, interior, id, money, rent_due)
        Wait(1000)
        TriggerServerEvent("loaf_motels:enter_room", motel, room, id)
    end)

    TriggerServerEvent("loaf_assignmotel:loaded_character")
end)