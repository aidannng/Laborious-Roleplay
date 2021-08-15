Config = {

	Sprite = { -- Vehicle blip sprite by class
		[0] = 225,
		[1] = 225,
		[2] = 225,
		[3] = 225,
		[4] = 225,
		[5] = 225,
		[6] = 225,
		[7] = 225,
		[8] = 226,
		[9] = 225,
		[10] = 67,
		[11] = 67,
		[12] = 67,
		[13] = 226,
		[14] = 410,
		[15] = 422,
		[16] = 423,
		[17] = 225,
		[18] = 225,
		[19] = 225,
		[20] = 67,
		[22] = 1
	},

	Icons = { -- Vehicle icon by class
		[0] = 'fa-car',
		[1] = 'fa-car',
		[2] = 'fa-car',
		[3] = 'fa-car',
		[4] = 'fa-car',
		[5] = 'fa-car',
		[6] = 'fa-car',
		[7] = 'fa-car',
		[8] = 'fa-motorcycle',
		[9] = 'fa-car',
		[10] = 'fa-truck',
		[11] = 'fa-truck',
		[12] = 'fa-truck',
		[13] = 'fa-bicycle',
		[14] = 'fa-ship',
		[15] = 'fa-helicopter',
		[16] = 'fa-plane',
		[17] = 'fa-car',
		[18] = 'fa-car',
		[19] = 'fa-car',
		[20] = 'fa-truck',
		[22] = 'fa-running'
	},

	OpenMenuKey = 'F10', -- Key to open the dispatch menu (Leave blank if you dont need a key)

	EnableUnitArrivalNotice = true, -- Give player notice that the unit is arriving to them! (Triggered when any unit accepts the call)


	callCommandSprite = 280, -- Blip sprite when player calls using command
	callCommandColor = 57, -- Blip color when player calls using command

	EnableMapBlipsForUnits = true, -- Shows units in their vehicles on the map
	AddCallBlips = true, -- Adds blips for calls that disappear over time
	CallBlipDisappearInterval = 500, -- The higher value longer they will stay on the map

	EnableShootingAlerts = true, -- Alerts when citizens shoot in shooting zones
	ShootingZones = { -- Zones where citizens shooting gives police an alert
		{coords = vector3(-20.188398361206,6629.5073242188,30.817811965942), radius = 200.0},
		{coords = vector3(-73.95164, -826.8923, 40.56921), radius = 10000.0},
		{coords = vector3(146.6374, 560.2813, 187.8535), radius = 10000.0},
		{coords = vector3(-1580.334, -570.1187, 116.3092), radius = 10000.0},
		{coords = vector3(-912.2374, -482.7033, 36.62634), radius = 10000.0},
		{coords = vector3(-1185.073, -2768.822, 14.3678), radius = 10000.0},
		{coords = vector3(-1362.672, -781.3055, 19.65857), radius = 10000.0},
		{coords = vector3(-1209.059, 459.9165, 91.86011), radius = 10000.0},
		{coords = vector3(-347.4462, 327.4945, 108.7435), radius = 10000.0},
		{coords = vector3(1011.943, -485.3275, 61.39563), radius = 10000.0},
		{coords = vector3(965.3802, 253.6879, 80.41907), radius = 10000.0},
		{coords = vector3(594.5802, 729.9429, 185.3597), radius = 10000.0},
		{coords = vector3(462.5538, -1902.686, 25.43811), radius = 10000.0},
		{coords = vector3(45.04616, -1748.36, 29.53259), radius = 10000.0},
		{coords = vector3(1010.453, -2326.932, 30.4762), radius = 10000.0},
		{coords = vector3(979.6616, -3088.483, 5.892334), radius = 10000.0},
		{coords = vector3(535.7407, -3133.635, -1.117188), radius = 10000.0},
		{coords = vector3(233.222, -3051.402, 5.942871), radius = 10000.0},
		{coords = vector3(-197.3407, -2658.316, 5.959717), radius = 10000.0},
		{coords = vector3(-46.35165, -1818.224, 26.41541), radius = 10000.0},
		{coords = vector3(-141.1648, -638.0835, 38.74951), radius = 10000.0},
		{coords = vector3(-2090.717, 107.8813, 155.5187), radius = 10000.0},
	}, 

	-- You can have 3 jobs that can interact with the dispatch and 
	-- canRequestLocalBackup - This is for requesting backup/help from same job as yours
	-- canRequestOtherJobBackup - This is for requesting backup/help from other jobs too
	-- forwardCall - This will allow you to forward your jobs call to other jobs
	-- callCommand - Command to make a call in dispatch (You can also use triggers and make phone funcionallity or smth)
	-- color - This is the color of units! this is a css class if you dont know what are you doing dont change
	-- label - Label of the job
	JobOne = {job = 'police', canRequestLocalBackup = true, canRequestOtherJobBackup = true, forwardCall = true, canRemoveCall = true, callCommand = "911", color = "blueunit", label = "Police", blipColor = 26 },
	JobTwo = {job = 'ambulance', canRequestLocalBackup = true, canRequestOtherJobBackup = true, forwardCall = true, canRemoveCall = true, callCommand = "911", color = "redunit", label = "EMS",  blipColor = 1 },
	JobThree = {job = 'mechanic', canRequestLocalBackup = true, canRequestOtherJobBackup = true, forwardCall = true, canRemoveCall = true, callCommand = "511", color = "grayunit", label = "Mech",  blipColor = 39 },


	Text = {

	['call_removed'] = 'Call was removed',
	['backup_requested'] = 'Backup requested',
	['call_forwarded'] = 'Call forwarded',
	['someone_is_reacting'] = 'Unit is arriving to your location!',
	['offduty'] = 'Offduty is not set up!',
	['alerts_turned_off'] = 'Alerts turned off!',
	['alerts_turned_on'] = 'Alerts turned on!',
	['phone_number_copied'] = 'Phone number copied',
	['unit_blips_turned_on'] = 'Units are now shown',
	['unit_blips_turned_off'] = 'Units are now hidden',
	['call_blips_turned_on'] = 'Call blips shown',
	['call_blips_turned_off'] = 'Call blips hidden',
	['callsign_changed'] = 'Call sign changed',
	['no_permission'] = 'You dont have permissions!',
	['callsign_char_long'] = 'Too many characters! 3 Max',
	['accepted'] = 'Accepted',
	['active_units_error'] = 'Cannot remove call with active units',
	['cant_accept_call'] = 'Cant accept call because it was removed'

}
}

-- Function called when you press power off button
function ToggleDuty() 
	SendTextMessage(Config.Text['offduty'])
end

-- Only change if you know what are you doing!
function SendTextMessage(msg)
	
	-- SetNotificationTextEntry('STRING')
	-- AddTextComponentString(msg)
	-- DrawNotification(0,1)

	--EXAMPLE USED IN VIDEO
	exports['mythic_notify']:SendAlert('inform', msg)
end