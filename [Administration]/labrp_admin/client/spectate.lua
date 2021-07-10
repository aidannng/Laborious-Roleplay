ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function GetPlayersButSkipMyself()
    local players = {}
    local ind = 1;
    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
			if i ~= PlayerId() then
				players[ind] = i;
				ind = ind + 1;
			end
		end
    end

    return players
end

function spectatePlayer(targetPed)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	
	if targetPed == playerPed then enable = false end

	if(enable)then
		--local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
		NetworkSetInSpectatorMode(true, targetPed)	
		SetEntityInvincible(GetPlayerPed(-1), true) 
		SetEntityVisible(GetPlayerPed(-1), false, 0)
		SetEveryoneIgnorePlayer(GetPlayerPed(-1), true)
		SetEntityCollision(GetPlayerPed(-1), false, false)
	else
		--local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
		NetworkSetInSpectatorMode(false, targetPed)
		SetEntityInvincible(GetPlayerPed(-1), false)
		SetEntityVisible(GetPlayerPed(-1), true, 0)
		SetEveryoneIgnorePlayer(GetPlayerPed(-1), false)
		SetEntityCollision(GetPlayerPed(-1), true, true)
	end
end
isSpectating = false;

local savedCoords = nil 
RegisterNetEvent('BT:Client:SpectateID')
AddEventHandler('BT:Client:SpectateID', function(id)
	-- Spectate the specified ID 
	if not isSpectating then 
		-- They were not spectating, give them cycle spectate, but start from specified ID 
		spectatedUserServerID = tonumber(id)
		local players = GetPlayersButSkipMyself()
		local found = false 
		for i = 1, #players do 
			local playerID = players[i] -- Their client side ID 
			if spectatedUserServerID == GetPlayerServerId(playerID) then 
				spectatedUserClientID = playerID
				found = true 
			end
		end
		if found then 
			-- SAVE THEIR LOCATION:
			savedCoords = GetEntityCoords(PlayerPedId())
			TriggerServerEvent('BadgerTools:Server:UserTag', false) -- Hide UserTag
			spectatePlayer(GetPlayerPed(spectatedUserClientID))
			--ShowNotification('~b~Spectating ~f~' .. GetPlayerName(spectatedUserClientID))
			--sendMsg('^5Spectating ^0' .. GetPlayerName(spectatedUserClientID))
			isSpectating = true 
		else 
			-- Send message, can't find that ID 
			--sendMsg('^1ERROR: Cannot find the user with that ID')
		end
	else
		-- They were spectating, just change the person they are spectating 
		local serverID = tonumber(id)
		local players = GetPlayersButSkipMyself()
		local found = false 
		for i = 1, #players do 
			local playerID = players[i] -- Their client side ID 
			if serverID == GetPlayerServerId(playerID) then 
				spectatedUserClientID = playerID
				spectatedUserServerID = serverID
				found = true 
			end
		end
		if found then 
			TriggerServerEvent('BadgerTools:Server:UserTag', false) -- Hide UserTag
			spectatePlayer(GetPlayerPed(spectatedUserClientID))
			--ShowNotification('~b~Spectating ~f~' .. GetPlayerName(spectatedUserClientID))
			--sendMsg('^5Spectating ^0' .. GetPlayerName(spectatedUserClientID))
			isSpectating = true 
		else 
			-- Send message, can't find that ID 
			--sendMsg('^1ERROR: Cannot find the user with that ID')
		end
	end 
end)

function GetPlayersCountButSkipMe()
    local count = 0
    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
			if GetPlayerPed(i) ~= GetPlayerPed(-1) then
				count = count + 1
			end
		end
    end
    return count
end

RegisterNetEvent('BT:Client:Spectate')
AddEventHandler('BT:Client:Spectate', function()
	-- Regular cycling spectate 
	if not isSpectating then 
		-- They are not spectating, spectate cycle start:
		if GetPlayersCountButSkipMe() >= 1 then 
			local players = GetPlayersButSkipMyself()
			spectatedUserClientID = players[1]
			spectatedUserServerID = GetPlayerServerId(spectatedUserClientID)
			isSpectating = true 
			-- SAVE THEIR LOCATION:
			savedCoords = GetEntityCoords(PlayerPedId()) 
			TriggerServerEvent('BadgerTools:Server:UserTag', false) -- Hide UserTag
			spectatePlayer(GetPlayerPed(spectatedUserClientID))
			--ShowNotification('~b~Spectating ~f~' .. GetPlayerName(spectatedUserClientID))
			--sendMsg('^5Spectating ^0' .. GetPlayerName(spectatedUserClientID))
		else
			--sendMsg('^1ERROR: Not enough players on to spectate') 
		end 
	else 
		-- They were spectating, stop their spectate 
		--ShowNotification("~g~Success: No longer spectating anyone!")
		spectatePlayer(GetPlayerPed(-1))
		--sendMsg('^2Success: No longer spectating anyone!')
		spectatedUserServerID = nil 
		spectatedUserClientID = nil 
		isSpectating = false 
		SetEntityCoords(GetPlayerPed(-1), savedCoords.x, savedCoords.y, savedCoords.z) -- Teleport them
		TriggerServerEvent('BadgerTools:Server:UserTag', true) -- Show UserTag
	end
end)