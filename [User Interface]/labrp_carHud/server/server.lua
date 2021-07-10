RegisterServerEvent('trew_hud_ui:syncCarLights')
AddEventHandler('trew_hud_ui:syncCarLights', function(status)
	TriggerClientEvent('trew_hud_ui:syncCarLights', -1, source, status)
end)



RegisterServerEvent('notifyvoice:default')
AddEventHandler('notifyvoice:default', function()
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Voice Distance: Normal', length = 4500, style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
end)

RegisterServerEvent('notifyvoice:whisper')
AddEventHandler('notifyvoice:whisper', function()
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Voice Distance: Whisper', length = 4500, style = { ['background-color'] = '#ffb700', ['color'] = '#FFFFFF' } })
end)

RegisterServerEvent('notifyvoice:shout')
AddEventHandler('notifyvoice:shout', function()
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Voice Distance: Shout', length = 4500, style = { ['background-color'] = '#ff0000', ['color'] = '#FFFFFF' } })
end)


