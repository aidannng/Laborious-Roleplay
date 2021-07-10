ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("labrp_admin:killPlayer")
AddEventHandler("labrp_admin:killPlayer", function()
  SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("labrp_admin:freezePlayer")
AddEventHandler("labrp_admin:freezePlayer", function(input)
    local player = PlayerId()
	local ped = PlayerPedId()
    if input == 'freeze' then
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
    elseif input == 'unfreeze' then
        SetEntityCollision(ped, true)
	    FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    end
end)

RegisterCommand("changechar", function()
	ESX.TriggerServerCallback('labrp_admin:CheckForPerms', function(data)
		if data then
			TriggerEvent("multichar:changeChar")
			TriggerServerEvent("labrp_admin:changeCharhttp")
		else
			print('no item')
		end
	end, "juniormoderator', 'communityhelper")
end, false)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
local noclip = false
RegisterNetEvent("labrp_admin:noclip")
AddEventHandler("labrp_admin:noclip", function(input)
    local player = PlayerId()
	local ped = PlayerPedId
	
    local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(PlayerPedId(), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent('chat:addMessage', {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
		args = { "^*[^4LABRP^0] Noclip has been ^4" .. msg }
	});
	end)
	
	local heading = 0
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(noclip)then
			SetEntityCoordsNoOffset(PlayerPedId(), noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

			if(IsControlPressed(1, 34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
			end

			if(IsControlPressed(1, 32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1, 27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 1.0)
			end

			if(IsControlPressed(1, 173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -1.0)
			end
		else
			Citizen.Wait(200)
		end
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("labrp_admin:tpm")
AddEventHandler("labrp_admin:tpm", function()
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                break
            end

            Citizen.Wait(5)
        end
        TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
			args = { "^*[^4LABRP^0] You have teleported to your waypoint" }
		});
    else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
			args = { "^*[^4LABRP^0] Set a waypoint before you want to teleport somewhere.." }
		});
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE STUFF

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/admin', 'Displays user rank')
	TriggerEvent('chat:addSuggestion', '/tpm', 'Teleports you to waypoint marked on the map')
	TriggerEvent('chat:addSuggestion', '/coords', 'Prints coordinates to console and user client')
	TriggerEvent('chat:addSuggestion', '/announce', 'Creates an announcement in game', {{ name="Mesasage", help="This is what will be displayed when writing announcement"}})
	TriggerEvent('chat:addSuggestion', '/bring', 'Teleports a player to you', {{ name="ID", help="Insert Player ID that should be teleported to you"}})
	TriggerEvent('chat:addSuggestion', '/bringback', 'Teleports player you bought back to their original location', {{ name="ID", help="Insert Player ID that should be teleported back to original location"}})
	TriggerEvent('chat:addSuggestion', '/goto', 'Teleports you to a player', {{ name="ID", help="Insert Player ID that you should be teleported to"}})
	TriggerEvent('chat:addSuggestion', '/goback', 'Teleports you back to original location', {{ name="ID", help="Insert Player ID that should be teleported back to original location"}})
	TriggerEvent('chat:addSuggestion', '/heal', 'Heals a player', {{ name="ID", help="Insert Player ID that should be healed"}})
	TriggerEvent('chat:addSuggestion', '/noclip', 'Enables/Disabled Noclip')
	TriggerEvent('chat:addSuggestion', '/kill', 'Kills a player', {{ name="ID", help="Insert Player ID that should be killed"}})
	TriggerEvent('chat:addSuggestion', '/freeze', 'Freezes a player in their location', {{ name="ID", help="Insert Player ID that should be frozen"}})
	TriggerEvent('chat:addSuggestion', '/unfreeze', 'Unfreezes a player in their location', {{ name="ID", help="Insert Player ID that should be unfrozen"}})
	TriggerEvent('chat:addSuggestion', '/reviveall', 'Revives all players online that are dead')
	TriggerEvent('chat:addSuggestion', '/clearall', 'Clears every client-sided chat on the server')
	TriggerEvent('chat:addSuggestion', '/saveall', 'Saves all online characters to the database')
	TriggerEvent('chat:addSuggestion', '/car', 'Spawns a vehicle', {{ name="Model", help="Insert Vehicle Model"}})
	TriggerEvent('chat:addSuggestion', '/dv', 'Deletes vehicles in selected proximty', {{ name="Distance", help="Insert distance in which vehicles should be deleted."}})
	TriggerEvent('chat:addSuggestion', '/setgroup', 'Sets user group', {{ name="ID", help="Set Player ID" },{ name="Group", help="Name of group player should be added in" }})	
	TriggerEvent('chat:addSuggestion', '/setjob', 'Sets user job and garde', {{ name="ID", help="Set Player ID" },{ name="Job", help="Name of Job" },{ name="Grade", help="Number Of Grade. Example: 11 LSPD Chief" }})	
	TriggerEvent('chat:addSuggestion', '/revive', 'Revives a player', {{ name="ID", help="Insert Player ID that should be revived"}})
	TriggerEvent('chat:addSuggestion', '/clearinventory', 'Clear a players inventory', {{ name="ID", help="Insert Player ID that should have their inventory cleared"}})
	TriggerEvent('chat:addSuggestion', '/giveitem', 'Gives a player an item', {{ name="ID", help="Set Player ID" },{ name="Item", help="Name of Item" },{ name="Amount", help="Amount of x item you want to give the player" }})	
	TriggerEvent('chat:addSuggestion', '/setmoney', 'Replaces the amount of money a user has', {{ name="ID", help="Set Player ID" },{ name="Account", help="Could either be: money, bank or black which is dirty money." },{ name="Amount", help="Amount of money you want to replace the balance with" }})	
	TriggerEvent('chat:addSuggestion', '/removemoney', 'Removes the amount of money a user has', {{ name="ID", help="Set Player ID" },{ name="Account", help="Could either be: money, bank or black which is dirty money." },{ name="Amount", help="Amount of money you want to remove from the existing balance" }})	
	TriggerEvent('chat:addSuggestion', '/addmoney', 'Adds onto the existing amount of money a user has', {{ name="ID", help="Set Player ID" },{ name="Account", help="Could either be: money, bank or black which is dirty money." },{ name="Amount", help="Amount of money you want to add onto the existing balance" }})	
	TriggerEvent('chat:addSuggestion', '/report', 'Creates a report that gets sent to the staff', {{ name="Reason", help="Please write a detailed reason on your report to go to out staff"}})
	TriggerEvent('chat:addSuggestion', '/openreports', 'Displays all open reports')
	TriggerEvent('chat:addSuggestion', '/911', 'Creates a 911 Call', {{ name="Reason", help="Please write a detailed reason on your 911 call"}})
	TriggerEvent('chat:addSuggestion', '/911a', 'Creates an anonymous 911 Call', {{ name="Reason", help="Please write a detailed reason on your anonymous 911 call"}})
	TriggerEvent('chat:addSuggestion', '/closereport', 'Closes open reports', {{ name="ID", help="Report ID" },{ name="Reason", help="Close Reason" }})	
	TriggerEvent('chat:addSuggestion', '/transfervehicle', 'Transfers vehicle to someone else', {{ name="ID", help="Players ID you want to give the vehicle to" },{ name="Plate", help="The plate of the vehicle you want to transfer" }})	
	TriggerEvent('chat:addSuggestion', '/openinv', 'Opens a players inventory', {{ name="ID", help="Insert Player ID that should have their inventory opened"}})

end)

RegisterCommand("changeskin", function()
	TriggerEvent('esx_skin:openSaveableMenu')
end)

RegisterCommand("saveskin", function()
	TriggerEvent('esx_skin:requestSaveSkin')
end)
