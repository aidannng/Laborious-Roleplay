--[[
	TESTING PURPOSES
	
	function dump(o)
    if type(o) == 'table' then
       local s = '{ \n'
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ',\n'
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

RegisterCommand("giveitem", function(source, args, rawCommand)    -- /clearinventory       clears inventory
	if source ~= 0 then
		print(dump(args))
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			local tarPlayer = ESX.GetPlayerFromId(args[1])
			if tarPlayer ~= nil then
				tarPlayer.addInventoryItem(args[2], args[3], args[4])
			end
		end
	end
end, false)

]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onTimer       = {}
local savedCoords   = {}
local warnedPlayers = {}
local deadPlayers   = {}
local discord_webhook = {url = "https://discord.com/api/webhooks/861474902493495317/oTnEfRLpSViVKPOTQQ8Rsas9dCUTKrgGrzJ7s7w3rnTAbc42wVQKrVUyf43ap71_WKvf",image = "https://i.iodine.gg/i5fba.png"}
local staff_chat_webhook = {url = "https://discord.com/api/webhooks/861483050163241000/EbZLmO0D_mkSSdJ4y03B5xkpnUKr1spXdo8P45Me5-zEiWd1c_RWumolxBLGIVG6nURJ",image = "https://i.iodine.gg/i5fba.png"}
------------------------------------------------------------------------------------------------------------------------------------------------
function dump(o)
    if type(o) == 'table' then
       local s = '{ \n'
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ',\n'
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

RegisterCommand("openinv", function(source, args, rawCommand)    -- /openinv       opens user's inventory
	if source ~= 0 then
		print(dump(args))
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
			local tarPlayer = ESX.GetPlayerFromId(args[1])
			local targetId = tonumber(args[1])
			local xTarget = ESX.GetPlayerFromId(targetId)
			if tarPlayer ~= nil then
				TriggerEvent('linden_inventory:openTargetInventory', args[1])
				print("does this bitch work")
				print(" args1:" .. args[1], " xTarget.Source:", targetId, " " )
			else
				print("else statement")
			end
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("admin", function(source, args, rawCommand)	-- /admin		displays user rank
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
			args = { "^*[^4LABRP^0] Your rank: ^4" .. xPlayer.getGroup() }
		});	
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sc", function(source, args, rawCommand)	-- /sc command for staff chat
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			if args[1] then
				local message = string.sub(rawCommand, 3)
				local xAll = ESX.GetPlayers()
				local xPlayer = ESX.GetPlayerFromId(source)

				PerformHttpRequest(staff_chat_webhook.url, 
				function(err, text, header) end, 
				'POST', 
				json.encode({username = "LABRP | Staff Logs", content = "`STAFF CHAT:` **" .. xPlayer.getName() .. "** »" .. message, avatar_url=staff_chat_webhook.image }), {['Content-Type'] = 'application/json'}) 

				for i=1, #xAll, 1 do
					local xTarget = ESX.GetPlayerFromId(xAll[i])
					if havePermission(xTarget) then			
						TriggerClientEvent('chat:addMessage',xTarget.source , {
							template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255,0,0,0.2); border-radius: 3px;">{0} <br> {1} </div>',
							args = { "^*[^4LABRP^0] Staff Chat", "^4 " .. xPlayer.getName() .. " ^0» " .. message}
						});								
					end
				end
			else
				--TriggerClientEvent('chatMessage', xPlayer.source, _U('invalid_input', 'AdminChat'))
			end
		end
	end
end, false)
------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpm", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
			TriggerClientEvent("labrp_admin:tpm", xPlayer.source)
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("coords", function(source, args, rawCommand)	-- /coords		print exact ped location in console/F8
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			print(GetEntityCoords(GetPlayerPed(source)))
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce", function(source, args, rawCommand)	-- /announce		creates a server announcement
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if args[1] then
			local message = string.sub(rawCommand, 10)
			if xPlayer then
				if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
					TriggerClientEvent('chat:addMessage',-1 , {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255,0,0,0.5); border-radius: 3px;">{0} <br> {1} </div>',
						args = { "^*[^4LABORIOUS ROLEPLAY^0] ANNOUNCEMENT^0 ", "» " .. message}
					});
					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has made an announcement saying: **".. args[1] .. "**", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

				end
			end
		else
    		TriggerClientEvent('chat:addMessage', xPlayer.source, _U('invalid_input', 'ANNOUNCMENT'))
	 	end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("bring", function(source, args, rawCommand)	-- /bring		brings player to admin
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
	    	if args[1] and tonumber(args[1]) then
	      		local targetId = tonumber(args[1])
	      		local xTarget = ESX.GetPlayerFromId(targetId)
	      		if xTarget then
	        		local targetCoords = xTarget.getCoords()
	        		local playerCoords = xPlayer.getCoords()
	        		savedCoords[targetId] = targetCoords
	        		xTarget.setCoords(playerCoords)

					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has bought **".. xTarget.getName() .. "**(" .. xTarget.identifier .. ") to their location", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 


					TriggerClientEvent('chat:addMessage', xTarget.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',  
						args = { "^*[^4LABRP^0] You have been bought to ^4" .. xPlayer.getName() }
					});
					
					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
						args = { "^*[^4LABRP^0] You have teleported ^4ID " .. args[1] .. "^0 to your location" }
					});
					
	      		else
					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
						args = { "^*[^4LABRP^0] That ID is not online" }
					});
	      		end
	    	else
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
					args = { "^*[^4LABRP^0] Make sure to format the command properly. ^4/bring <ID>" }
				});
	    	end
	  	end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("bringback", function(source, args, rawCommand)	-- /bringback [ID] will teleport player back where he was before /bring
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			local playerCoords = savedCoords[targetId]
        			if playerCoords then
          			xTarget.setCoords(playerCoords)

					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
						args = { "^*[^4LABRP^0] You have returned ^4ID " .. targetId .. "^0 to their original location" }
					});

 
					TriggerClientEvent('chat:addMessage', xTarget.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
						args = { "^*[^4LABRP^0] You have been returned to your original location" }
					});
          			savedCoords[targetId] = nil
        		else
					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
						args = { "^*[^4LABRP^0] There is no where to return this player" }
					});
        			end
      			else
					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
						args = { "^*[^4LABRP^0] That ID is not online" }
					});
	      		end
	    	else
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
					args = { "^*[^4LABRP^0] Make sure to format the command properly. ^4/bringback <ID>" }
				});
    		end
  		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("goto", function(source, args, rawCommand)	-- /goto		teleport admin to player
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			local targetCoords = xTarget.getCoords()
        			local playerCoords = xPlayer.getCoords()
        			savedCoords[source] = playerCoords
        			xPlayer.setCoords(targetCoords)
					
					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has teleported to **".. xTarget.getName() .. "**(" .. xTarget.identifier .. ") ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
  

					TriggerClientEvent('chat:addMessage', xTarget.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',  
						args = { "^*[^4LABRP^0] ^4" .. xPlayer.getName() .. "^0 has teleported to you" }
					});
					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',  
						args = { "^*[^4LABRP^0] You have teleported to ^4ID " .. args[1] .. "" }
					});
				else
					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
						args = { "^*[^4LABRP^0] That ID is not online" }
					});
	      		end
	    	else
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
					args = { "^*[^4LABRP^0] Make sure to format the command properly. ^4/goto <ID>" }
				});
	    	end
  		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("goback", function(source, args, rawCommand)	-- /goback    will teleport you back where you was befor /goto
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
			PerformHttpRequest(discord_webhook.url, 
			function(err, text, header) end, 
			'POST', 
			json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has gone back to their original location", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

	    	local playerCoords = savedCoords[source]
	    	if playerCoords then
	      		xPlayer.setCoords(playerCoords)
				  TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
					args = { "^*[^4LABRP^0] You have been teleported to your previous location" }
				});
	      		savedCoords[source] = nil
	    	else
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
					args = { "^*[^4LABRP^0] There is no where you can be teleported back to" }
				});
	    	end
	  	end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("noclip", function(source, args, rawCommand)	-- /noclip     enables/disables no clip
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
	    	TriggerClientEvent("labrp_admin:noclip", xPlayer.source)
	  	end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kill", function(source, args, rawCommand)	-- /kill [ID]
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
			if args[1] and tonumber(args[1]) then
				local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
					TriggerClientEvent("labrp_admin:killPlayer", xTarget.source)
        			TriggerClientEvent("chat:addMessage", xPlayer.source, _U('kill_admin', targetId))
					TriggerClientEvent('chat:addMessage', xTarget.source, _U('kill_by_admin', xPlayer.getName()))
					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has killed **".. xTarget.getName() .. "**(" .. xTarget.identifier .. ") ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

      			else
        			TriggerClientEvent("chat:addMessage", xPlayer.source, _U('not_online', 'KILL'))
      			end
    		else
      			TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalid_input', 'KILL'))
    		end
  		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("freeze", function(source, args, rawCommand)	-- /freeze [ID]
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			TriggerClientEvent("labrp_admin:freezePlayer", xTarget.source, 'freeze')
					TriggerClientEvent("chat:addMessage", xPlayer.source, _U('freeze_admin', args[1]))
					TriggerClientEvent("chat:addMessage", xTarget.source, _U('freeze_player', xPlayer.getName()))
					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has frozen **".. xTarget.getName() .. "**(" .. xTarget.identifier .. ") ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

      			else
        			TriggerClientEvent("chat:addMessage", xPlayer.source, _U('not_online', 'FREEZE'))
      			end
    		else
		      	TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalid_input', 'FREEZE'))
    		end
  		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unfreeze", function(source, args, rawCommand)	-- /unfreeze [ID]
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			TriggerClientEvent("labrp_admin:freezePlayer", xTarget.source, 'unfreeze')
					TriggerClientEvent("chat:addMessage", xPlayer.source, _U('unfreeze_admin', args[1]))
					TriggerClientEvent("chat:addMessage", xTarget.source, _U('unfreeze_player', xPlayer.getName()))
					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has unfrozen **".. xTarget.getName() .. "**(" .. xTarget.identifier .. ") ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

      			else
        			TriggerClientEvent("chat:addMessage", xPlayer.source, _U('not_online', 'UNFREEZE'))
      			end
    		else
      			TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalid_input', 'UNFREEZE'))
    		end
  		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("reviveall", function(source, args, rawCommand)	-- reviveall (can be used from console)
	canRevive = false
	if source == 0 then
		canRevive = true
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
			canRevive = true
			PerformHttpRequest(discord_webhook.url, 
			function(err, text, header) end, 
			'POST', 
			json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has revived all players", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

		end
	end
	if canRevive then
		for i,data in pairs(deadPlayers) do
			TriggerClientEvent('esx_ambulancejob:revive', i)
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearall", function(source, args, rawCommand)	-- /clearall		clears everyones chat
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
			TriggerClientEvent('chat:client:ClearChat', -1)
			PerformHttpRequest(discord_webhook.url, 
			function(err, text, header) end, 
			'POST', 
			json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has cleared the chat", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("saveall", function(source, args, rawCommand)	-- /saveall		saves all characters
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
			ESX.SavePlayers(cb)
			PerformHttpRequest(discord_webhook.url, 
			function(err, text, header) end, 
			'POST', 
			json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has saved all characters", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

		end
	end
end, false)


------------------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand("car", function(source, args, rawCommand)    -- /car        spawns a vehicle
	 if source ~= 0 then
		 local xPlayer = ESX.GetPlayerFromId(source)
		 if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
			xPlayer.triggerEvent('esx:spawnVehicle', args[1])
			PerformHttpRequest(discord_webhook.url, 
			function(err, text, header) end, 
			'POST', 
			json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has spawned in the vehicle model **".. args[1] .. "** ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

		 end
	 end
 end, false)

 ------------------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand("keys", function(source, args, rawCommand)    -- /keys        gives keys to vehicle
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
		if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
			xPlayer.triggerEvent("vehiclekeys:client:SetOwner", plate, vehicle) 
			TriggerClientEvent('vehiclekeys:client:ToggleEngine', source)
			
			PerformHttpRequest(discord_webhook.url, 
			function(err, text, header) end, 
			'POST', 
			json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has given them selves the keys to a vehicle **", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
		end
	end
end, false)

 ------------------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand("dv", function(source, args, rawCommand)    -- /dv        deletes a vehicle
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper'}) then
			xPlayer.triggerEvent('esx:deleteVehicle', args[1])
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setgroup", function(source, args, rawCommand)    -- /setgroup        sets user group
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if havePermission(xPlayer, {'developer', 'headadmin', 'senioradmin', 'generaladmin', 'junioradmin', 'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
            local tarPlayer = ESX.GetPlayerFromId(args[1])
			local targetId = tonumber(args[1])
			local xTarget = ESX.GetPlayerFromId(targetId)
            if tarPlayer ~= nil then
                tarPlayer.setGroup(args[2])
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',  
					args = { "^*[^4LABRP^0] You have set ^4ID " .. args[1] .. "'s^0 group to ^4" .. args[2] .. " " }
				});
				TriggerClientEvent('chat:addMessage', xTarget.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',  
					args = { "^*[^4LABRP^0] ^4" .. xPlayer.getName() .. "^0 has set your rank to ^4" .. args[2] .. " " }
				});
				PerformHttpRequest(discord_webhook.url, 
				function(err, text, header) end, 
				'POST', 
				json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has set **".. tarPlayer.getName() .. "'s**(" ..tarPlayer.identifier .. ") admin rank to **" .. args[2] .. "**", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

            end
        end
    end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setjob", function(source, args, rawCommand)    -- /setjob        sets user job
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if havePermission(xPlayer, {'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
        	if ESX.DoesJobExist(args[2], args[3]) then
            	local tarPlayer = ESX.GetPlayerFromId(args[1])
           	 if tarPlayer ~= nil then
             	   tarPlayer.setJob(args[2], args[3])
					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has set **".. tarPlayer.getName() .. "'s**(" ..tarPlayer.identifier .. ") job to **" .. args[2] .. "** with the job grade **" .. args[3] .. "** ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
	
           	 end
			end
        end
    end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("revive", function(source, args, rawCommand)    -- /revive        revives a player
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
			local tarPlayer = ESX.GetPlayerFromId(args[1])
			if tarPlayer ~= nil then
				tarPlayer.triggerEvent('esx_ambulancejob:revive')
				PerformHttpRequest(discord_webhook.url, 
				function(err, text, header) end, 
				'POST', 
				json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has revived **".. tarPlayer.getName() .. "**(" ..tarPlayer.identifier .. ")", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

			end
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("heal", function(source, args, rawCommand)    -- /heal        heals a player
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'juniormoderator', 'communityhelper', 'staff'}) then
			local tarPlayer = ESX.GetPlayerFromId(args[1])
			local targetId = tonumber(args[1])
			local xTarget = ESX.GetPlayerFromId(targetId)
			if tarPlayer ~= nil then
				tarPlayer.triggerEvent('esx_basicneeds:healPlayer')

				TriggerClientEvent('chat:addMessage', xTarget.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',  
					args = { "^*[^4LABRP^0] You have been healed by ^4" .. xPlayer.getName() }
				});
				
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
					args = { "^*[^4LABRP^0] You have healed ID ^4" .. args[1] }
				});
				PerformHttpRequest(discord_webhook.url, 
				function(err, text, header) end, 
				'POST', 
				json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has healed **".. tarPlayer.getName() .. "**(" ..tarPlayer.identifier .. ")", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 


			end
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinventory", function(source, args, rawCommand)    -- /clearinventory       clears inventory
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer, {'junioradmin', 'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
			local tarPlayer = ESX.GetPlayerFromId(args[1])
			if tarPlayer ~= nil then
				TriggerEvent('linden_inventory:clearPlayerInventory', args[1])
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 69, 95, 0.5); border-radius: 3px;">{0} </div>',
					args = { "^*[^4LABRP^0] You have cleared ID^4 " .. args[1] .. "'s ^0inventory" }
				});
				PerformHttpRequest(discord_webhook.url, 
				function(err, text, header) end, 
				'POST', 
				json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has cleared **".. tarPlayer.getName() .. "'s**(" ..tarPlayer.identifier .. ") inventory", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

			end
		end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("giveitem", function(source, args, rawCommand)    -- /giveitem       /giveitem <ID> <item> <Amount> <SOmething else i forgot>
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)

		if havePermission(xPlayer, {'junioradmin', 'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
			local tarPlayer = ESX.GetPlayerFromId(args[1])

			if tarPlayer then
				tarPlayer.addInventoryItem(args[2], tonumber(args[3]), args[4])
				PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has given **".. tarPlayer.getName() .. "**(" ..tarPlayer.identifier .. ") the item **x" .. args[3] .. " ".. args[2] .. " **" , avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
			end
		end
	end
end, false) 

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setmoney", function(source, args, rawCommand)    -- /setmoney       sets account money
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)

        if havePermission(xPlayer, {'generaladmin', 'junioradmin', 'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
            local tarPlayer = ESX.GetPlayerFromId(args[1])

            if tarPlayer then
                local getAccount = tarPlayer.getAccount(args[2])

                if getAccount then
                    tarPlayer.setAccountMoney(args[2], tonumber(args[3]))

					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has set **$".. args[3] .. "** on the account: **" .. args[2] .. "** for player:** " .. tarPlayer.getName() .. "**(" ..tarPlayer.identifier .. ")", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
                else
                    TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalidaccount'))
                end
            else
                TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalidplayer'))
            end
        end
    end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("removemoney", function(source, args, rawCommand)    -- /removemoney       removes account money
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)

        if havePermission(xPlayer, {'generaladmin', 'junioradmin', 'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
            local tarPlayer = ESX.GetPlayerFromId(args[1])

            if tarPlayer then
                local getAccount = tarPlayer.getAccount(args[2])

                if getAccount then
                    tarPlayer.removeAccountMoney(args[2], tonumber(args[3]))

					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has removed **$".. args[3] .. "** from the account: **" .. args[2] .. "** from player:** " .. tarPlayer.getName() .. "**(" ..tarPlayer.identifier .. ")", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
                else
                    TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalidaccount'))
                end
            else
                TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalidplayer'))
            end
        end
    end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addmoney", function(source, args, rawCommand)    -- /addmoney       adds onto account money
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)

        if havePermission(xPlayer, {'generaladmin', 'junioradmin', 'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
            local tarPlayer = ESX.GetPlayerFromId(args[1])

            if tarPlayer then
                local getAccount = tarPlayer.getAccount(args[2])

                if getAccount then
                    tarPlayer.addAccountMoney(args[2], tonumber(args[3]))

					PerformHttpRequest(discord_webhook.url, 
					function(err, text, header) end, 
					'POST', 
					json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "** has added **$".. args[3] .. "** to the account: **" .. args[2] .. "** to player:** " .. tarPlayer.getName() .. "**(" ..tarPlayer.identifier .. ")", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

                else
                    TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalidaccount'))
                end
            else
                TriggerClientEvent("chat:addMessage", xPlayer.source, _U('invalidplayer'))
            end
        end
    end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setcoords", function(source, args, rawCommand)	-- /noclip     enables/disables no clip
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
		  if havePermission(xPlayer, {'headadmin', 'senioradmin', 'generaladmin', 'junioradmin', 'generalmoderator', 'juniormoderator', 'communityhelper', 'staff'}) then
			xPlayer.setCoords({x = tonumber(args[1]), y = tonumber(args[2]), z = tonumber(args[3])})
	  	end
	end
end, false)

------------------------------------------------------------------------------------------------------------------------------------------------
ESX.RegisterServerCallback('labrp_admin:CheckForPerms', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if havePermission(xPlayer, {'juniormoderator', 'communityhelper'}) then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('labrp_admin:changeCharhttp')
AddEventHandler('labrp_admin:changeCharhttp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    PerformHttpRequest(discord_webhook.url, 
    function(err, text, header) end, 
    'POST', 
    json.encode({username = "LABRP | Staff Logs", content = "**" .. xPlayer.getName() .. "**(" .. xPlayer.getIdentifier() .. ") has changed character", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
end)




------------ functions and events ------------
RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = data
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	-- empty tables when player no longer online
	if onTimer[playerId] then
		onTimer[playerId] = nil
	end
    if savedCoords[playerId] then
    	savedCoords[playerId] = nil
    end
	if warnedPlayers[playerId] then
		warnedPlayers[playerId] = nil
	end
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
	end
end)

function havePermission(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[labrp_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Config.adminRanks) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end