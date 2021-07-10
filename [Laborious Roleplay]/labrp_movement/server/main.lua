
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(target)
	TriggerClientEvent("playerTackled", target)
end)


RegisterCommand('carry', function(source)
    TriggerClientEvent('carry:command', source)
end)

RegisterServerEvent('carry:sync')
AddEventHandler('carry:sync', function(target)
	TriggerClientEvent('carry:syncTarget', target, source)
	TriggerClientEvent('carry:syncMe', source)
end)

RegisterServerEvent('carry:stop')
AddEventHandler('carry:stop', function(target)
	TriggerClientEvent('carry:stop', target)
end)

RegisterServerEvent('escort:sync')
AddEventHandler('escort:sync', function(target)
	TriggerClientEvent('escort:syncTarget', target, source)
	TriggerClientEvent('escort:syncMe', source)
end)

RegisterServerEvent('escort:stop')
AddEventHandler('escort:stop', function(target)
	TriggerClientEvent('escort:stop', target)
end)

RegisterServerEvent('putinvehicle:sync')
AddEventHandler('putinvehicle:sync', function(target)
	TriggerClientEvent('putinvehicle:target', target)
end)