local open = false
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


RegisterNetEvent('labrp_identification:showIDCard')
AddEventHandler('labrp_identification:showIDCard', function(item, wait, cb)
    local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
    TriggerServerEvent('labrp_identification:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId(-1)), metadata) 
    local player, distance = ESX.Game.GetClosestPlayer()
    
    if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('labrp_identification:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), metadata)
    else
        ESX.ShowNotification('No players nearby')
    end
end)

RegisterCommand("GimmieID", function(source)
    TriggerServerEvent("labrp_issueID")
end) 

RegisterNetEvent('labrp_identification:open')
AddEventHandler('labrp_identification:open', function( data, metadata, type )
	open = true
    SendNUIMessage({
        action = "open",
        array  = data,
        metadata = metadata,
        type   = type,
        mugshot = metadata.mugshoturl,
    })
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

--[[ RegisterCommand('issueidcard', function(source, args, rawCommand)
    exports['mugshot']:getMugshotUrl(PlayerPedId(), function(url)
        TriggerServerEvent('labrp_issueID',source,url)
    end)
    
end, false) ]]