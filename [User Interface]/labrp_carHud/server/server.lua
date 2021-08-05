RegisterServerEvent('trew_hud_ui:syncCarLights')
AddEventHandler('trew_hud_ui:syncCarLights', function(status)
	TriggerClientEvent('trew_hud_ui:syncCarLights', -1, source, status)
end)



RegisterServerEvent('notifyvoice:default')
AddEventHandler('notifyvoice:default', function()
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'normal', text = 'Voice Distance: Normal'})
end)

RegisterServerEvent('notifyvoice:whisper')
AddEventHandler('notifyvoice:whisper', function()
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'whisper', text = 'Voice Distance: Whisper'})
end)

RegisterServerEvent('notifyvoice:shout')
AddEventHandler('notifyvoice:shout', function()
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'shouting', text = 'Voice Distance: Shout'})
end)


