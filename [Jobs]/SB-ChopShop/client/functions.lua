ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

local multipler = 5


GetChopList = function(source)
	if ChopRandom == 1 then
		TriggerEvent('chat:addMessage', {
		template = '<div class="chat-message system">^*Available Chop List:^r  {0}  |  {1}  |  {2}  |  {3}  |  {4}</div>',
		args = { Config.ChopLow[1], Config.ChopLow[2], Config.ChopLow[3], Config.ChopLow[4], Config.ChopLow[5], }
		});
	elseif ChopRandom == 2 then
		TriggerEvent('chat:addMessage', {
		template = '<div class="chat-message system">^*Available Chop List:^r  {0}  |  {1}  |  {2}  |  {3}  |  {4}</div>',
		args = { Config.ChopMed[1], Config.ChopMed[2], Config.ChopMed[3], Config.ChopMed[4], Config.ChopMed[5], }
		});
	elseif ChopRandom == 3 then
		TriggerEvent('chat:addMessage', {
		template = '<div class="chat-message system">^*Available Chop List:^r  {0}  |  {1}  |  {2}  |  {3}  |  {4}</div>',
		args = { Config.ChopHigh[1], Config.ChopHigh[2], Config.ChopHigh[3], Config.ChopHigh[4], Config.ChopHigh[5], }
		});
	elseif ChopRandom == 4 then
		TriggerEvent('chat:addMessage', {
		template = '<div class="chat-message system">^*Available Chop List:^r  {0}  |  {1}  |  {2}  |  {3}  |  {4}</div>',
		args = { Config.ChopExtreme[1], Config.ChopExtreme[2], Config.ChopExtreme[3], Config.ChopExtreme[4], Config.ChopExtreme[5], }
		});
	end
end

deleteCar = function( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end
 


AllowChop = function(hash, source)
	local veh = vehicle
	if ChopRandom == 1 then
		if hash == GetHashKey(Config.ChopLow[1]) or hash == GetHashKey(Config.ChopLow[2]) or hash == GetHashKey(Config.ChopLow[3]) or hash == GetHashKey(Config.ChopLow[4]) or hash == GetHashKey(Config.ChopLow[5]) then
			local class = 1
			local timer = class * 1000 * multipler
			    TriggerEvent("mythic_progbar:client:progress", {
		        name = "Chop",
		        duration = timer,
		        label = "Chopping Vehicle",
		        useWhileDead = false,
		        canCancel = true,
		        controlDisables = {
		            disableMovement = true,
		            disableCarMovement = true,
		            disableMouse = false,
		            disableCombat = true,
		        },
		    }, function(status)
		        if not status then
		            TriggerEvent('CheckDist', class)
		        end
		    end)

		end
	elseif ChopRandom == 2 then
		if hash == GetHashKey(Config.ChopMed[1]) or hash == GetHashKey(Config.ChopMed[2]) or hash == GetHashKey(Config.ChopMed[3]) or hash == GetHashKey(Config.ChopMed[4]) or hash == GetHashKey(Config.ChopMed[5]) then
			local class = 2
			local timer = class * 1000 * multipler
			TriggerEvent("mythic_progbar:client:progress", {
		        name = "Chop",
		        duration = timer,
		        label = "Chopping Vehicle",
		        useWhileDead = false,
		        canCancel = true,
		        controlDisables = {
		            disableMovement = true,
		            disableCarMovement = true,
		            disableMouse = false,
		            disableCombat = true,
		        },
		    }, function(status)
		        if not status then
		            TriggerEvent('CheckDist', class)
		        end
		    end)
		end
	elseif ChopRandom == 3 then
		if hash == GetHashKey(Config.ChopHigh[1]) or hash == GetHashKey(Config.ChopHigh[2]) or hash == GetHashKey(Config.ChopHigh[3]) or hash == GetHashKey(Config.ChopHigh[4]) or hash == GetHashKey(Config.ChopHigh[5]) then
			local class = 3
			local timer = class * 1000 * multipler
			TriggerEvent("mythic_progbar:client:progress", {
		        name = "Chop",
		        duration = timer,
		        label = "Chopping Vehicle",
		        useWhileDead = false,
		        canCancel = true,
		        controlDisables = {
		            disableMovement = true,
		            disableCarMovement = true,
		            disableMouse = false,
		            disableCombat = true,
		        },
		    }, function(status)
		        if not status then
		            TriggerEvent('CheckDist', class)
		        end
		    end)
		end
	elseif ChopRandom == 4 then
		if hash == GetHashKey(Config.ChopExtreme[1]) or hash == GetHashKey(Config.ChopExtreme[2]) or hash == GetHashKey(Config.ChopExtreme[3]) or hash == GetHashKey(Config.ChopExtreme[4]) or hash == GetHashKey(Config.ChopExtreme[5]) then
			local class = 4
			local timer = class * 1000 * multipler
			TriggerEvent("mythic_progbar:client:progress", {
		        name = "Chop",
		        duration = timer,
		        label = "Chopping Vehicle",
		        useWhileDead = false,
		        canCancel = true,
		        controlDisables = {
		            disableMovement = true,
		            disableCarMovement = true,
		            disableMouse = false,
		            disableCombat = true,
		        },
		    }, function(status)
		        if not status then
		            TriggerEvent('CheckDist', class)
		        end
		    end)
		end
	end
end


DrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end