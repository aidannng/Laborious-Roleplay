ESX = exports['es_extended']:getSharedObject()

if not IsDuplicityVersion() then -- Only register this event for the client
	AddEventHandler('esx:setPlayerData', function(key, val)
		if GetInvokingResource() == 'es_extended' then
			ESX.PlayerData[key] = val
			if OnPlayerData ~= nil then OnPlayerData(key, val) end
		end
	end)
end

ESX.SetPlayerData = function(key, val)
    local current = ESX.PlayerData[key]
    ESX.PlayerData[key] = val
    if key ~= 'inventory' and key ~= 'loadout' then
        if type(val) == 'table' or val ~= current then
            TriggerEvent('esx:setPlayerData', key, val, current)
        end
    end
end

local Intervals = {}
local CreateInterval = function(name, interval, action, clear)
	local self = {interval = interval}
	CreateThread(function()
		local name, action, clear = name, action, clear
		repeat
			action()
			Citizen.Wait(self.interval)
		until self.interval == -1
		if clear then clear() end
		Intervals[name] = nil
	end)
	return self
end

SetInterval = function(name, interval, action, clear)
	if Intervals[name] and interval then Intervals[name].interval = interval
	else
		Intervals[name] = CreateInterval(name, interval, action, clear)
	end
end

ClearInterval = function(name)
	Intervals[name].interval = -1
end