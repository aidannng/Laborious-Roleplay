local ESX = nil

CreateThread(function()
    local tries = 10
    while not ESX do
        Wait(100)
        TriggerEvent(Config.ESX, function(obj) ESX = obj
        end)
        tries = tries - 1
        if tries == 0 then
            print("You forgot to change ESX shared object in config, please do it now or the script wont work properly.")
            break
        end
    end
end)

function notify(text, style)
    ESX.ShowNotification(text)
end

function ShowHelpNotification(text)
    ESX.ShowHelpNotification(text)
end