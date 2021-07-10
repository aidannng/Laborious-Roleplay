-- Client Side Job Check
ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- Code

local radioMenu = false
local isLoggedIn = false

function enableRadio(enable)
  if enable then
    SetNuiFocus(enable, enable)
    PhonePlayIn()
    SendNUIMessage({
      type = "open",
    })
    radioMenu = enable
  end
end

RegisterNetEvent('esx:Client:OnPlayerLoaded')
AddEventHandler('esx:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('esx:Client:OnPlayerUnload')
AddEventHandler('esx:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)


RegisterNUICallback('joinRadio', function(data, cb)
  local _source = source
  -- local PlayerData = ESX.Functions.GetPlayerData()
  local playerName = GetPlayerName(PlayerId())

  -- if tonumber(data.channel) <= Config.MaxFrequency then
    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
      if tonumber(data.channel) <= Config.RestrictedChannels then
        if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'doctor') then
          exports["mumble-voip"]:SetRadioChannel(0)
          exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
          exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)
 
          if SplitStr(data.channel, ".")[2] ~= nil and SplitStr(data.channel, ".")[2] ~= "" then 
          else
          end
        else
        end
      end

      if tonumber(data.channel) > Config.RestrictedChannels then
        exports["mumble-voip"]:SetRadioChannel(0)
        exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
        exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)
        if SplitStr(data.channel, ".")[2] ~= nil and SplitStr(data.channel, ".")[2] ~= "" then 
          exports['mythic_notify']:SendAlert('inform', 'You have joined the radio channel ' .. data.channel .. '.00 Mhz') 
        else
          exports['mythic_notify']:SendAlert('inform', 'You have joined the radio channel ' .. data.channel .. '.00 Mhz') 
        end
      end
    else
      if SplitStr(data.channel, ".")[2] ~= nil and SplitStr(data.channel, ".")[2] ~= "" then 
        exports['mythic_notify']:SendAlert('inform', 'You have joined the radio channel ' .. data.channel .. '.00 Mhz') 
      else
        exports['mythic_notify']:SendAlert('inform', 'You have joined the radio channel ' .. data.channel .. '.00 Mhz') 
      end
    end
  --else
    --exports['mythic_notify']:SendAlert('error', 'This is an encrypted radio channel!') 
  --end
  cb('ok')
end)

RegisterNUICallback('leaveRadio', function(data, cb)
  local playerName = GetPlayerName(PlayerId())
  -- local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
  -- if getPlayerRadioChannel == "nil" then
  --   -- exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
  -- else
    exports["mumble-voip"]:SetRadioChannel(0)
    exports["mumble-voip"]:SetMumbleProperty("radioEnabled", false)
    if SplitStr(getPlayerRadioChannel, ".")[2] ~= nil and SplitStr(getPlayerRadioChannel, ".")[2] ~= "" then 
      -- exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    else
      -- exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    end
    
  -- end
  cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
  SetNuiFocus(false, false)
  radioMenu = false
  PhonePlayOut()
  cb('ok')
end)

RegisterNetEvent('radio:use')
AddEventHandler('radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('radio:onRadioDrop')
AddEventHandler('radio:onRadioDrop', function()
  local playerName = GetPlayerName(PlayerId())
  -- local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

  -- if getPlayerRadioChannel ~= "nil" then
    exports["mumble-voip"]:SetRadioChannel(0)
    -- exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
  -- end
end)

function SplitStr(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

local Radio = {

	Prop = `prop_cs_hand_radio`,
	Bone = 28422,
	Offset = vector3(0.0, 0.0, 0.0),
	Rotation = vector3(0.0, 0.0, 0.0),
	Dictionary = {
		"cellphone@",
		"cellphone@in_car@ds",
		"cellphone@str",
		"random@arrests",
	},
	Animation = {
		"cellphone_text_in",
		"cellphone_text_out",
		"cellphone_call_listen_a",
		"generic_radio_chatter",
	},
	Clicks = true, -- Radio clicks
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait( 0 )
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped )  then
			if not IsPauseMenuActive() then 
				loadAnimDict( "random@arrests" )
				if IsControlJustReleased( 0, 137 ) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
				else
					if IsControlJustPressed( 0, 137 )  and not IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						SetEnableHandcuffs(ped, true)
					elseif IsControlJustPressed( 0, 137 )  and IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						SetEnableHandcuffs(ped, true)
					end 
					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "generic_radio_enter", 3) then
						DisableActions(ped)
					elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "radio_chatter", 3) then
						DisableActions(ped)
					end
				end
			end 
		end 
	end
end )

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end