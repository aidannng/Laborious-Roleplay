---@diagnostic disable: undefined-global
local pma = exports["pma-voice"]
local notify = exports['mythic_notify']
local currentChannel = 0
local hasRadio = false

local ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end
end)

function SetDisplay(s) 
    SetNuiFocus(s, s)
    SendNUIMessage({type="display", status=s})
end

--[[ RegisterCommand("radio", function()
    if not hasRadio then return end
    SetDisplay(true)
end, false)
RegisterKeyMapping("radio", "Open or close the radio", "keyboard", Config.DefaultOpenKey)
 ]]

RegisterNetEvent("radio:use")
AddEventHandler("radio:use", function()
    if not hasRadio then return end
    SetDisplay(true)
end)


RegisterNUICallback('close', function()
    SetDisplay(false)
end)

RegisterNUICallback('joinChannel', function(data)
    local channel = tonumber(data.channel)
	local PlayerData = ESX.GetPlayerData(_source)
    local restricted = {}
	
	if channel > 200 then
		notify:SendAlert("error", "Channels above 200 are encrypted.")
		return
	end
	
    for i,v in pairs(Config.jobChannels) do
        if channel >= v.min and channel <= v.max then
            table.insert(restricted, v)
        end
    end

    if #restricted > 0 then
        notify:SendAlert("inform", "Attempting to connect to encrypted channel "..channel..".")
        for i,v in pairs(restricted) do
            if PlayerData.job.name == v.job and channel >= v.min and channel <= v.max then
                pma:setRadioChannel(channel)
                notify:SendAlert("success", "Connected to encrypted channel "..channel..".")
                currentChannel = channel
                break
            elseif i == #restricted then
                notify:SendAlert("error", "Failed to connect to encrypted channel "..channel..".")
                break
            end
        end
    else
        pma:setRadioChannel(channel)
        notify:SendAlert("inform", "Connected to channel "..channel..".")
        currentChannel = channel
    end
end)

RegisterNUICallback('leaveChannel', function()
    pma:setRadioChannel(0)
    currentChannel = 0

    notify:SendAlert("inform", "Radio turned off.")
end)

RegisterNUICallback('setVolume', function(data)
    for i,v in pairs(GetActivePlayers()) do
        pma:setRadioVolume(data.volume)
    end
end)

pma:setRadioVolume(0.99)
RegisterNetEvent("radioCount")
AddEventHandler("radioCount", function(count)
    if hasRadio and count ~= 0 or not hasRadio and count == 0 then return end
	
	if count == 0 then
	    pma:setVoiceProperty("radioEnabled", false)
        pma:setRadioChannel(0)
		hasRadio = false
    else
	    pma:setVoiceProperty("radioEnabled", true)
        pma:setRadioChannel(currentChannel)
		hasRadio = true
    end
end)

CreateThread(function()
	while true do
		Wait(1000)
		TriggerServerEvent('getRadioCount', GetPlayerServerId(PlayerId()))
	end
end)

Citizen.CreateThread(function()
	local radioInUse = false
	while true do
		if IsControlJustPressed(PlayerPedId(), 137) and currentChannel > 0 then
			radioInUse = true
		
			local dict = "random@arrests"
			local anim = "generic_radio_enter"
			
			RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Wait(1)
            end
				
			TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 2.0, -1, 50, 2.0, false, false, false)
		end
		if not IsControlPressed(PlayerPedId(), 137) and radioInUse then
			ClearPedTasks(PlayerPedId())
			radioInUse = false
		end
		Wait(0)
	end
end)