Config = {}
Config.ReceiveInCash = true -- If its in true, you'll recieve it on cash (wallet), false it will become on bank.
Config.UseEsExtendedType = true -- IF true, enable the trigger so you can place it in your es_extended, false it will disable it

Config.Blips = {
    {title="Cityhall", colour=5, id=525, x = -552.86126708984, y = -191.00524902344, z = 37.219673156738},
}

--	Your Notification System
RegisterNetEvent('brinn_paycheck:notification')
AddEventHandler('brinn_paycheck:notification', function(msg,type)
    exports['mythic_notify']:SendAlert(type, msg) 
end)
