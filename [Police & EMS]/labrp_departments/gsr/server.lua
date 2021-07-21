RegisterNetEvent("gsr:doTest")
AddEventHandler("gsr:doTest", function(target)
	local src = source
	TriggerClientEvent('gsr:requestGSR', target, src)	
	TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'inform', text = "You are being GSR Tested", length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
end)

RegisterNetEvent("gsr:returnGSR")
AddEventHandler("gsr:returnGSR", function(shotRecently, policeId)
	local src = source
	local result = 'Negative'
	if shotRecently then result = 'Positive'; end
	--TriggerClientEvent('notify', policeId, "The GSR Test has returned "..result)
	TriggerClientEvent('mythic_notify:client:SendAlert', policeId, { type = 'inform', text = "The GSR Test has returned "..result, length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
end)

RegisterNetEvent("search:notif")
AddEventHandler("search:notif", function(target)
	TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'inform', text = "You're being searched", length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
end)

RegisterNetEvent("rob:notif")
AddEventHandler("rob:notif", function(target)
	TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'inform', text = "You're being robbed!", length = 4500, style = { ['background-color'] = '#05b5f9', ['color'] = '#FFFFFF' } })
end)