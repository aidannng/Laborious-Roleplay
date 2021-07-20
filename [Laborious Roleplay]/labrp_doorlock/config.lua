Config = {}
Config.ShowUnlockedText = true
Config.CheckVersion = false
Config.CheckVersionDelay = 60 -- Minutes

Config.DoorList = {

------------------------------------------
--	COMMUNITY MISSION ROW PD
--	https://www.gta5-mods.com/maps/community-mission-row-pd
------------------------------------------

}


-- Front PD Door
table.insert(Config.DoorList, {
	fixText = true,
	garage = false,
	objHeading = 0.0,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	lockpick = false,
	objCoords = vector3(440.5201, -977.6011, 30.82319),
	objHash = -1406685646,
	maxDistance = 1.0,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Police Door 2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	garage = false,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	locked = true,
	objCoords = vector3(440.5201, -986.2335, 30.82319),
	maxDistance = 1.0,
	slides = false,
	objHeading = 180.00001525879,
	objHash = -96679321,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Meeting Double Door Room
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	audioRemote = false,
	maxDistance = 2.5,
	slides = false,
	doors = {
		{objHash = -288803980, objHeading = 270.00003051758, objCoords = vector3(438.1971, -993.9113, 30.82319)},
		{objHash = -288803980, objHeading = 89.999977111816, objCoords = vector3(438.1971, -996.3167, 30.82319)}
 },
	authorizedJobs = { ['police']=0, ['fbi']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Outside Double Door
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	audioRemote = false,
	maxDistance = 2.5,
	slides = false,
	doors = {
		{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(440.7392, -998.7462, 30.8153)},
		{objHash = -1547307588, objHeading = 180.00001525879, objCoords = vector3(443.0618, -998.7462, 30.8153)}
 },
	authorizedJobs = { ['police']=0, ['fbi']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Police Door Reception
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	garage = false,
	lockpick = false,
	audioRemote = false,
	fixText = true,
	locked = true,
	objCoords = vector3(445.4067, -984.2014, 30.82319),
	maxDistance = 1.0,
	slides = false,
	objHeading = 89.999977111816,
	objHash = -1406685646,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})




-- Police Outside Double Door 2
table.insert(Config.DoorList, {
	slides = false,
	locked = true,
	maxDistance = 2.5,
	lockpick = false,
	doors = {
		{objHash = -1547307588, objHeading = 180.00001525879, objCoords = vector3(458.2087, -972.2543, 30.81531)},
		{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(455.8862, -972.2543, 30.81531)}
 },
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- POLICE LOCKERS
table.insert(Config.DoorList, {
	slides = false,
	objHash = 149284793,
	objCoords = vector3(458.0894, -995.5247, 30.82319),
	garage = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	locked = true,
	maxDistance = 1.0,
	objHeading = 225.02824401855,
	lockpick = false,
	fixText = true,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PD ARCHIVES ROOM
table.insert(Config.DoorList, {
	lockpick = false,
	objHash = -96679321,
	audioRemote = false,
	maxDistance = 1.0,
	garage = false,
	objHeading = 134.97177124023,
	fixText = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objCoords = vector3(452.2663, -995.5254, 30.82319),
	slides = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Dispatch Center
table.insert(Config.DoorList, {
	lockpick = false,
	objHash = -96679321,
	audioRemote = false,
	maxDistance = 1.0,
	garage = false,
	objHeading = 134.97177124023,
	fixText = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objCoords = vector3(448.9846, -995.5264, 35.10376),
	slides = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Training Room 1
table.insert(Config.DoorList, {
	lockpick = false,
	objHash = -1406685646,
	audioRemote = false,
	maxDistance = 1.0,
	garage = false,
	objHeading = 45.028198242188,
	fixText = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objCoords = vector3(448.9868, -990.2007, 35.10376),
	slides = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Training Room 2
table.insert(Config.DoorList, {
	lockpick = false,
	objHash = -96679321,
	audioRemote = false,
	maxDistance = 1.0,
	garage = false,
	objHeading = 134.97177124023,
	fixText = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objCoords = vector3(448.9868, -981.5785, 35.10376),
	slides = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Roof Access PD
table.insert(Config.DoorList, {
	lockpick = false,
	objHash = -692649124,
	audioRemote = false,
	maxDistance = 1.0,
	garage = false,
	objHeading = 89.999977111816,
	fixText = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objCoords = vector3(464.3086, -984.5284, 43.77124),
	slides = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Police Garage Door 1
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	garage = true,
	slides = 6.0,
	objHeading = 0.0,
	locked = true,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(452.3005, -1000.772, 26.69661),
	objHash = 2130672747,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PD GARAGE DOOR 2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	garage = true,
	slides = 6.0,
	objHeading = 0.0,
	locked = true,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(431.4119, -1000.772, 26.69661),
	objHash = 2130672747,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- BALLOT 1
table.insert(Config.DoorList, {
	locked = true,
	objHeading = 270.0,
	slides = true,
	maxDistance = 6.0,
	objCoords = vector3(410.0258, -1024.226, 29.22022),
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	fixText = false,
	objHash = -1868050792,
	lockpick = false,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- BALLOT 2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = true,
	locked = true,
	objHash = -1635161509,
	maxDistance = 6.0,
	audioRemote = false,
	lockpick = false,
	fixText = true,
	garage = false,
	objCoords = vector3(410.0258, -1024.22, 29.2202),
	objHeading = 270.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Police Garage Entrance Door/Entrance from garage to the building
table.insert(Config.DoorList, {
	objHash = 1830360419,
	lockpick = false,
	audioRemote = false,
	objCoords = vector3(464.1566, -997.5093, 26.3707),
	fixText = true,
	locked = true,
	garage = false,
	slides = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	maxDistance = 1.0,
	objHeading = 89.870010375977,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Door that says obey and server
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	audioRemote = false,
	slides = false,
	maxDistance = 2.5,
	locked = true,
	doors = {
		{objHash = -96679321, objHeading = 270.00003051758, objCoords = vector3(471.3753, -987.4374, 26.40548)},
		{objHash = -1406685646, objHeading = 270.00003051758, objCoords = vector3(471.3753, -985.0319, 26.40548)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Evidence Room
table.insert(Config.DoorList, {
	objHeading = 134.97177124023,
	maxDistance = 1.0,
	lockpick = false,
	garage = false,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objCoords = vector3(475.8323, -990.4839, 26.40548),
	slides = false,
	fixText = true,
	objHash = -692649124,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- INTERROGATION/OBERVATION/LINEUP/CELLS
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	audioRemote = false,
	slides = false,
	maxDistance = 2.5,
	locked = true,
	doors = {
		{objHash = 149284793, objHeading = 89.999977111816, objCoords = vector3(479.0624, -987.4376, 26.40548)},
		{objHash = 149284793, objHeading = 270.00003051758, objCoords = vector3(479.0624, -985.0323, 26.40548)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Observation 1
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	garage = false,
	objHeading = 270.00003051758,
	lockpick = false,
	maxDistance = 1.0,
	objCoords = vector3(482.6694, -983.9868, 26.40548),
	locked = true,
	fixText = true,
	slides = false,
	audioRemote = false,
	objHash = -1406685646,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- INTERROGATION 1
table.insert(Config.DoorList, {
	objHash = -1406685646,
	objCoords = vector3(482.6701, -987.5792, 26.40548),
	locked = true,
	fixText = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objHeading = 270.00003051758,
	lockpick = false,
	audioRemote = false,
	garage = false,
	maxDistance = 1.0,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- OBSERVATION 2
table.insert(Config.DoorList, {
	audioRemote = false,
	objHeading = 270.00003051758,
	objCoords = vector3(482.6699, -992.2991, 26.40548),
	lockpick = false,
	locked = true,
	objHash = -1406685646,
	garage = false,
	fixText = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	maxDistance = 1.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- INTERROGATION 2
table.insert(Config.DoorList, {
	fixText = false,
	slides = false,
	maxDistance = 1.0,
	objHash = -1406685646,
	objCoords = vector3(482.6703, -995.7285, 26.40548),
	lockpick = false,
	audioRemote = false,
	objHeading = 270.00003051758,
	locked = true,
	garage = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOUBLE DOOR TO CELLS
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	doors = {
		{objHash = 149284793, objHeading = 180.00001525879, objCoords = vector3(482.0686, -997.91, 26.4065)},
		{objHash = 149284793, objHeading = 0.0, objCoords = vector3(479.6638, -997.91, 26.4065)}
 },
	slides = false,
	maxDistance = 2.5,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LINEUP
table.insert(Config.DoorList, {
	fixText = true,
	slides = false,
	maxDistance = 1.0,
	objHash = -288803980,
	objCoords = vector3(479.06, -1003.173, 26.4065),
	lockpick = false,
	audioRemote = false,
	objHeading = 89.999977111816,
	locked = true,
	garage = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- CELL
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	objCoords = vector3(481.0084, -1004.118, 26.48005),
	objHash = -53345114,
	maxDistance = 1.0,
	fixText = false,
	objHeading = 180.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- CELLS
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	objCoords = vector3(484.1764, -1007.734, 26.48005),
	objHash = -53345114,
	maxDistance = 1.0,
	fixText = false,
	objHeading = 180.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- CELLS
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	objCoords = vector3(486.9131, -1012.189, 26.48005),
	objHash = -53345114,
	maxDistance = 1.0,
	fixText = false,
	objHeading = 0.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- CELLS
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	objCoords = vector3(483.9127, -1012.189, 26.48005),
	objHash = -53345114,
	maxDistance = 1.0,
	fixText = false,
	objHeading = 0.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- CELLS
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	objCoords = vector3(480.9128, -1012.189, 26.48005),
	objHash = -53345114,
	maxDistance = 1.0,
	fixText = false,
	objHeading = 0.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- CELLS
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	objCoords = vector3(477.9126, -1012.189, 26.48005),
	objHash = -53345114,
	maxDistance = 1.0,
	fixText = false,
	objHeading = 0.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- CELLS
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	objCoords = vector3(476.6157, -1008.875, 26.48005),
	objHash = -53345114,
	maxDistance = 1.0,
	fixText = false,
	objHeading = 270.13998413086,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Mugshot Room
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	objCoords = vector3(475.9539, -1010.819, 26.40639),
	objHash = -1406685646,
	maxDistance = 1.0,
	fixText = true,
	objHeading = 180.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Processing
table.insert(Config.DoorList, {
	audioRemote = false,
	maxDistance = 1.0,
	objCoords = vector3(475.9539, -1006.938, 26.40639),
	lockpick = false,
	objHeading = 180.00001525879,
	objHash = -288803980,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	fixText = true,
	slides = false,
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PROCESSING/MUGSHOT/CELLS/LINEUP
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.5,
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	doors = {
		{objHash = 149284793, objHeading = 270.19003295898, objCoords = vector3(471.3679, -1007.793, 26.40548)},
		{objHash = 149284793, objHeading = 89.999977111816, objCoords = vector3(471.3758, -1010.198, 26.40548)}
 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- DOUBLE DOOR IDK
table.insert(Config.DoorList, {
	lockpick = false,
	slides = false,
	audioRemote = false,
	maxDistance = 2.5,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	doors = {
		{objHash = -288803980, objHeading = 0.0, objCoords = vector3(467.5222, -1000.544, 26.40548)},
		{objHash = -288803980, objHeading = 180.00001525879, objCoords = vector3(469.9274, -1000.544, 26.40548)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOOR IDK TO GARAGE?
table.insert(Config.DoorList, {
	objHash = 1830360419,
	slides = false,
	maxDistance = 1.0,
	objCoords = vector3(464.1591, -974.6656, 26.3707),
	lockpick = false,
	audioRemote = false,
	fixText = true,
	garage = false,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objHeading = 269.79000854492,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- IDENTIFICATION
table.insert(Config.DoorList, {
	fixText = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	objCoords = vector3(478.2892, -997.9101, 26.40548),
	garage = false,
	lockpick = false,
	audioRemote = false,
	objHeading = 180.00001525879,
	maxDistance = 1.0,
	objHash = 149284793,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- MCD HALLWAY
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	audioRemote = false,
	maxDistance = 2.5,
	slides = false,
	locked = true,
	doors = {
		{objHash = -288803980, objHeading = 270.00003051758, objCoords = vector3(469.4406, -985.0313, 30.82319)},
		{objHash = -288803980, objHeading = 89.999977111816, objCoords = vector3(469.4406, -987.4377, 30.82319)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- RESTROOM
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	audioRemote = false,
	maxDistance = 2.5,
	slides = false,
	locked = true,
	doors = {
		{objHash = 149284793, objHeading = 180.00001525879, objCoords = vector3(475.3837, -984.3722, 30.82319)},
		{objHash = 149284793, objHeading = 0.0, objCoords = vector3(472.9781, -984.3722, 30.82319)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LAB
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	audioRemote = false,
	maxDistance = 2.5,
	slides = false,
	locked = true,
	doors = {
		{objHash = -1406685646, objHeading = 270.00003051758, objCoords = vector3(479.7534, -986.2151, 30.82319)},
		{objHash = -96679321, objHeading = 270.00003051758, objCoords = vector3(479.7534, -988.6204, 30.82319)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- BRIEFING ROOM
table.insert(Config.DoorList, {
	objHash = -1406685646,
	garage = false,
	maxDistance = 2.0,
	slides = false,
	fixText = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	lockpick = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(476.7512, -999.6307, 30.82319),
	objHeading = 89.999977111816,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ARMORY
table.insert(Config.DoorList, {
	objHash = -692649124,
	garage = false,
	maxDistance = 2.0,
	slides = false,
	fixText = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	lockpick = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(479.7507, -999.629, 30.78917),
	objHeading = 89.999977111816,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ARMORY2
table.insert(Config.DoorList, {
	objHash = -692649124,
	garage = false,
	maxDistance = 2.0,
	slides = false,
	fixText = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	lockpick = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(487.4378, -1000.189, 30.78697),
	objHeading = 181.28001403809,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- SHOOTING RANGE
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	audioRemote = false,
	maxDistance = 2.5,
	slides = false,
	locked = true,
	doors = {
		{objHash = -692649124, objHeading = 0.0, objCoords = vector3(485.6133, -1002.902, 30.78697)},
		{objHash = -692649124, objHeading = 180.00001525879, objCoords = vector3(488.0184, -1002.902, 30.78697)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


--BURGER SHOT -1475798232

table.insert(Config.DoorList, {
	objHash = -1475798232,
	garage = false,
	maxDistance = 1.5,
	slides = false,
	fixText = false,
	authorizedJobs = { ['burgershot']=0 },
	lockpick = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(-1184.892, -833.33770, 14.25113),
	objHeading = 124.44,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Mechanic Gate 2
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	slides = 6.0,
	audioRemote = false,
	objHash = 1542392972,
	lockpick = false,
	locked = true,
	objHeading = 70.001892089844,
	fixText = false,
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-356.137, -134.796, 38.01285),
	garage = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Mechanic Gate 3
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	slides = 6.0,
	audioRemote = false,
	objHash = 1542392972,
	lockpick = false,
	locked = true,
	objHeading = 69.999992370605,
	fixText = false,
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-349.7954, -117.2953, 38.02348),
	garage = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Mechanic Gate 4
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	slides = 6.0,
	audioRemote = false,
	objHash = 260701421,
	lockpick = false,
	locked = true,
	objHeading = 340.00003051758,
	fixText = false,
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-364.97, -102.1295, 38.00655),
	garage = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Mechanic Gate 5
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	slides = 6.0,
	audioRemote = false,
	objHash = 260701421,
	lockpick = false,
	locked = true,
	objHeading = 340.00003051758,
	fixText = false,
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-371.9531, -99.5879, 38.01236),
	garage = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Mechanic Gate 5
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	slides = true,
	audioRemote = false,
	objHash = 1157738230,
	lockpick = false,
	locked = true,
	objHeading = 119.57181549072,
	fixText = false,
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-341.7755, -166.5323, 38.01139),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big mechanic gate idk
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	slides = 6.0,
	audioRemote = false,
	objHash = 260701421,
	lockpick = false,
	locked = true,
	objHeading = 30.000005722046,
	fixText = false,
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-360.2168, -154.9366, 37.7263),
	garage = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Double door mechanic shop
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=3 },
	slides = false,
	audioRemote = false,
	doors = {
		{objHash = 1142444161, objHeading = 263.88201904297, objCoords = vector3(-334.6126, -154.3659, 43.59727)},
		{objHash = 1142444161, objHeading = 83.019134521484, objCoords = vector3(-334.879, -156.7008, 43.59879)}
 },
	lockpick = false,
	locked = true,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Single door in mech shop
table.insert(Config.DoorList, {
	objHash = 1142444161,
	slides = false,
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-334.9883, -162.2828, 43.59594),
	lockpick = false,
	audioRemote = false,
	garage = false,
	locked = true,
	objHeading = 95.0,
	fixText = false,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Mechanic Shop Toilet Door
table.insert(Config.DoorList, {
	objHash = 1249909928,
	slides = false,
	authorizedJobs = { ['mechanic']=3 },
	objCoords = vector3(-334.713, -165.1489, 43.6178),
	lockpick = false,
	audioRemote = false,
	garage = false,
	locked = true,
	objHeading = 275.0,
	fixText = false,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmoffice1
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 1.5,
	slides = false,
	objCoords = vector3(-30.99285, -1095.845, 26.47271),
	objHash = 839949760,
	fixText = false,
	audioRemote = false,
	lockpick = false,
	objHeading = 249.90069580078,
	authorizedJobs = { ['cardealer']=0 },
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmoffice2
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 1.5,
	slides = false,
	objCoords = vector3(-30.128, -1095.116, 26.52148),
	objHash = 839949760,
	fixText = false,
	audioRemote = false,
	lockpick = false,
	objHeading = 340.00003051758,
	authorizedJobs = { ['cardealer']=0 },
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmfront
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.5,
	lockpick = false,
	doors = {
		{objHash = 1417577297, objHeading = 340.00003051758, objCoords = vector3(-37.33911, -1108.87, 26.67302)},
		{objHash = 2059227086, objHeading = 340.00003051758, objCoords = vector3(-39.13832, -1108.215, 26.67302)}
 },
	audioRemote = false,
	authorizedJobs = { ['cardealer']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmfront2
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.5,
	lockpick = false,
	doors = {
		{objHash = 1417577297, objHeading = 250.11831665039, objCoords = vector3(-60.53619, -1094.734, 26.84931)},
		{objHash = 2059227086, objHeading = 250.11831665039, objCoords = vector3(-59.88613, -1092.936, 26.84324)}
 },
	audioRemote = false,
	authorizedJobs = { ['cardealer']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmstorage
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	slides = false,
	objCoords = vector3(-50.6489, -1088.378, 26.50094),
	objHash = 839949760,
	fixText = false,
	audioRemote = false,
	lockpick = false,
	objHeading = 340.00003051758,
	authorizedJobs = { ['cardealer']=0 },
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmgate
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 10.0,
	slides = true,
	objCoords = vector3(-54.77802, -1074.68, 27.12305),
	objHash = -250842784,
	fixText = false,
	audioRemote = false,
	lockpick = false,
	objHeading = 250.18887329102,
	authorizedJobs = { ['cardealer']=0 },
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmoffice3
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	slides = false,
	objCoords = vector3(-45.19558, -1102.269, 26.52148),
	objHash = 839949760,
	fixText = false,
	audioRemote = false,
	lockpick = false,
	objHeading = 340.00003051758,
	authorizedJobs = { ['cardealer']=0 },
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- pdmoffice3
table.insert(Config.DoorList, {
	lockpick = false,
	audioRemote = false,
	locked = true,
	objCoords = vector3(-29.19558, -1102.269, 26.52148),
	maxDistance = 2.0,
	garage = false,
	fixText = false,
	authorizedJobs = { ['cardealer']=0 },
	objHeading = 340.00003051758,
	objHash = 839949760,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmoffice1
table.insert(Config.DoorList, {
	lockpick = false,
	audioRemote = false,
	locked = true,
	objCoords = vector3(-30.99285, -1095.845, 26.47271),
	maxDistance = 2.0,
	garage = false,
	fixText = false,
	authorizedJobs = { ['cardealer']=0 },
	objHeading = 249.90069580078,
	objHash = 839949760,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- pdmoffice2
table.insert(Config.DoorList, {
	lockpick = false,
	audioRemote = false,
	locked = true,
	objCoords = vector3(-30.128, -1095.116, 26.52148),
	maxDistance = 2.0,
	garage = false,
	fixText = false,
	authorizedJobs = { ['cardealer']=0 },
	objHeading = 340.00003051758,
	objHash = 839949760,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Burgershot Front Doors
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['burgershot']=0 },
	doors = {
		{objHash = -1475798232, objHeading = 124.02835845947, objCoords = vector3(-1184.892, -883.3377, 14.25113)},
		{objHash = 1517256706, objHeading = 124.02835845947, objCoords = vector3(-1183.207, -885.8312, 14.25113)}
 },
	slides = false,
	locked = true,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Burgershot Side Door
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['burgershot']=0 },
	doors = {
		{objHash = -1475798232, objHeading = 214.02838134766, objCoords = vector3(-1199.033, -885.1699, 14.25259)},
		{objHash = 1517256706, objHeading = 214.02838134766, objCoords = vector3(-1196.54, -883.4852, 14.25259)}
 },
	slides = false,
	locked = true,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Burgershot Inside Kitchen Door
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	objHeading = 34.028408050537,
	objHash = -1253427798,
	authorizedJobs = { ['burgershot']=0 },
	lockpick = false,
	objCoords = vector3(-1200.971, -892.8766, 14.24888),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Burgershot back door
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	objHeading = 304.02841186523,
	objHash = -1877571861,
	authorizedJobs = { ['burgershot']=0 },
	lockpick = false,
	objCoords = vector3(-1199.296, -904.0258, 14.05047),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- BG Drive-through
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	objHeading = 171.02838134766,
	objHash = -1871759441,
	authorizedJobs = { ['burgershot']=0 },
	lockpick = false,
	objCoords = vector3(-1193.297, -906.9709, 12.996),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- VBPD Front Door
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	doors = {
		{objHash = 320433149, objHeading = 218.53837585449, objCoords = vector3(-1093.418, -811.2207, 19.4492)},
		{objHash = -1215222675, objHeading = 218.53837585449, objCoords = vector3(-1091.387, -809.6029, 19.4492)}
 },
	slides = false,
	locked = true,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- VBPD Downstairs Door
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	doors = {
		{objHash = -129553421, objHeading = 128.53834533691, objCoords = vector3(-1092.896, -821.8762, 19.44924)},
		{objHash = -129553421, objHeading = 308.5383605957, objCoords = vector3(-1091.276, -823.91, 19.44924)}
 },
	slides = false,
	locked = true,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- VBPD Downstairs Door #2
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	doors = {
		{objHash = -2023754432, objHeading = 38.538318634033, objCoords = vector3(-1097.118, -824.7554, 19.44924)},
		{objHash = -2023754432, objHeading = 218.53837585449, objCoords = vector3(-1095.084, -823.1354, 19.44924)}
 },
	slides = false,
	locked = true,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- VBPD Main Cells
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	objHeading = 308.53833007813,
	objHash = 631614199,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	lockpick = false,
	objCoords = vector3(-1082.229, -840.4345, 13.67436),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- VBPD Cells 1
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	objHeading = 218.53837585449,
	objHash = 631614199,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	lockpick = false,
	objCoords = vector3(-1085.315, -839.3597, 13.67436),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- VBPD Cells 2
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	objHeading = 38.538318634033,
	objHash = 631614199,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	lockpick = false,
	objCoords = vector3(-1087.857, -841.3845, 13.67436),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- VBPD Cells 3
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	maxDistance = 2.0,
	fixText = false,
	objHeading = 38.538318634033,
	objHash = 631614199,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	lockpick = false,
	objCoords = vector3(-1090.707, -843.6543, 13.67436),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LS Power Station
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	fixText = false,
	slides = false,
	lockpick = true,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	garage = false,
	objCoords = vector3(735.1982, 132.4122, 80.90654),
	objHeading = 60.000026702881,
	objHash = -1023447729,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ls power station 2

-- mafia
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = 1504256620, objHeading = 270.0, objCoords = vector3(1395.92, 1142.904, 114.7902)},
		{objHash = 262671971, objHeading = 89.999992370605, objCoords = vector3(1395.92, 1140.705, 114.7902)}
 },
	locked = true,
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['mafia']=0 },
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- mafia 2
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = -1032171637, objHeading = 179.99998474121, objCoords = vector3(1402.688, 1128.314, 114.4836)},
		{objHash = -52575179, objHeading = 179.99998474121, objCoords = vector3(1400.488, 1128.314, 114.4836)}
 },
	locked = true,
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['mafia']=0 },
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- mafia 2
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = -52575179, objHeading = 179.99998474121, objCoords = vector3(1398.289, 1128.314, 114.4836)},
		{objHash = -1032171637, objHeading = 179.99998474121, objCoords = vector3(1400.489, 1128.314, 114.4836)}
 },
	locked = true,
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['mafia']=0 },
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- mafia 2
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = -52575179, objHeading = 89.999992370605, objCoords = vector3(1409.292, 1146.254, 114.4869)},
		{objHash = -1032171637, objHeading = 89.999992370605, objCoords = vector3(1409.292, 1144.054, 114.4869)}
 },
	locked = true,
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['mafia']=0 },
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- mafia 2
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = -52575179, objHeading = 89.999992370605, objCoords = vector3(1409.292, 1148.454, 114.4869)},
		{objHash = -1032171637, objHeading = 89.999992370605, objCoords = vector3(1409.292, 1146.254, 114.4869)}
 },
	locked = true,
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['mafia']=0 },
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- mafia 2
table.insert(Config.DoorList, {
	slides = false,
	doors = {
		{objHash = -52575179, objHeading = 89.999992370605, objCoords = vector3(1409.292, 1150.654, 114.4869)},
		{objHash = -1032171637, objHeading = 89.999992370605, objCoords = vector3(1409.292, 1148.454, 114.4869)}
 },
	locked = true,
	audioRemote = false,
	lockpick = false,
	authorizedJobs = { ['mafia']=0 },
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})



-- Vault Door
table.insert(Config.DoorList, {
	objHeading = 340.00003051758,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objHash = -222270721,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = false,
	slides = false,
	garage = false,
	lockpick = false,
	objCoords = vector3(256.3116, 220.6579, 106.4296),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Vault Door 2
table.insert(Config.DoorList, {
	objHeading = 250.00004577637,
	locked = true,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objHash = 746855201,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = false,
	slides = false,
	garage = false,
	lockpick = false,
	objCoords = vector3(262.1981, 222.5188, 106.4296),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Lower Vault
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	maxDistance = 2.5,
	audioRemote = false,
	items = { 'vault_key' },
	slides = false,
	doors = {
		{objHash = -1887114592, objHeading = 250.00004577637, objCoords = vector3(273.1413, 230.5395, 96.68304)},
		{objHash = -1887114592, objHeading = 70.000007629395, objCoords = vector3(272.255, 228.0946, 96.68304)}
 },
	authorizedJobs = { ['police']=0, ['fbi']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PBFrontDesk
table.insert(Config.DoorList, {
	garage = false,
	slides = false,
	objCoords = vector3(313.4801, -595.4583, 43.43391),
	locked = true,
	audioRemote = false,
	fixText = false,
	objHeading = 249.98275756836,
	objHash = 854291622,
	maxDistance = 2.0,
	lockpick = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PBCloakRoom
table.insert(Config.DoorList, {
	garage = false,
	slides = false,
	objCoords = vector3(309.1337, -597.7515, 43.43391),
	locked = true,
	audioRemote = false,
	fixText = false,
	objHeading = 160.00003051758,
	objHash = 854291622,
	maxDistance = 2.0,
	lockpick = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PBMRI
table.insert(Config.DoorList, {
	garage = false,
	slides = false,
	objCoords = vector3(336.1628, -580.1403, 43.43391),
	locked = true,
	audioRemote = false,
	fixText = false,
	objHeading = 340.00003051758,
	objHash = 854291622,
	maxDistance = 2.0,
	lockpick = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PBAdmin
table.insert(Config.DoorList, {
	garage = false,
	slides = false,
	objCoords = vector3(339.005, -586.7034, 43.43391),
	locked = true,
	audioRemote = false,
	fixText = false,
	objHeading = 340.00003051758,
	objHash = 854291622,
	maxDistance = 2.0,
	lockpick = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PBDiagnostics
table.insert(Config.DoorList, {
	garage = false,
	slides = false,
	objCoords = vector3(340.7818, -581.8215, 43.43391),
	locked = true,
	audioRemote = false,
	fixText = false,
	objHeading = 340.00003051758,
	objHash = 854291622,
	maxDistance = 2.0,
	lockpick = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PBX-RAY
table.insert(Config.DoorList, {
	garage = false,
	slides = false,
	objCoords = vector3(346.7739, -584.0024, 43.43391),
	locked = true,
	audioRemote = false,
	fixText = false,
	objHeading = 340.00003051758,
	objHash = 854291622,
	maxDistance = 2.0,
	lockpick = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PB Ward B
table.insert(Config.DoorList, {
	doors = {
		{objHash = -434783486, objHeading = 249.98275756836, objCoords = vector3(349.3138, -586.326, 43.43391)},
		{objHash = -1700911976, objHeading = 249.98275756836, objCoords = vector3(348.4333, -588.745, 43.43391)}
 },
	slides = false,
	audioRemote = false,
	locked = true,
	maxDistance = 2.5,
	lockpick = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- PB Surgery
table.insert(Config.DoorList, {
	maxDistance = 2.5,
	slides = false,
	lockpick = false,
	authorizedJobs = { ['ambulance']=0 },
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(323.2375, -575.4294, 43.43391)},
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(325.6565, -576.3099, 43.43391)}
 },
	locked = true,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- PB Surgery 2
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	doors = {
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(320.2615, -574.3463, 43.43391)},
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(317.8426, -573.4659, 43.43391)}
 },
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PB Surgery3
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(312.0051, -571.3412, 43.43391)},
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(314.4241, -572.2216, 43.43391)}
 },
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PB Lab
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	garage = false,
	maxDistance = 2.0,
	objHash = 854291622,
	objCoords = vector3(307.1182, -569.569, 43.43391),
	fixText = false,
	slides = false,
	audioRemote = false,
	objHeading = 340.00003051758,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PB Low Reception
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	garage = false,
	maxDistance = 2.0,
	objHash = 854291622,
	objCoords = vector3(348.5467, -585.1584, 28.94709),
	fixText = false,
	slides = false,
	audioRemote = false,
	objHeading = 250.00610351563,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PB Low Garage
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	doors = {
		{objHash = -1700911976, objHeading = 70.006050109863, objCoords = vector3(339.3266, -587.6345, 28.94709)},
		{objHash = -434783486, objHeading = 70.006050109863, objCoords = vector3(338.4467, -590.053, 28.94709)}
 },
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LB Garage
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	garage = true,
	maxDistance = 6.0,
	objHash = -820650556,
	objCoords = vector3(337.2777, -564.432, 29.77529),
	fixText = false,
	slides = 6.0,
	audioRemote = false,
	objHeading = 160.00607299805,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LB Garage2
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	garage = false,
	maxDistance = 2.0,
	objHash = -820650556,
	objCoords = vector3(330.1349, -561.8331, 29.77529),
	fixText = false,
	slides = false,
	audioRemote = false,
	objHeading = 160.00605773926,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LB Low Garage Out
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	doors = {
		{objHash = -1421582160, objHeading = 25.005989074707, objCoords = vector3(321.0148, -559.9127, 28.94724)},
		{objHash = 1248599813, objHeading = 205.0061340332, objCoords = vector3(318.6656, -561.0086, 28.94724)}
 },
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Dogs shop garage door 1
table.insert(Config.DoorList, {
	slides = 6.0,
	objCoords = vector3(963.1593, -117.3219, 75.24942),
	objHeading = 43.01594543457,
	audioRemote = false,
	lockpick = false,
	garage = true,
	objHash = -822900180,
	authorizedJobs = { ['bigdogs']=0 },
	locked = true,
	fixText = false,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Dogs shop garage door 2
table.insert(Config.DoorList, {
	slides = 6.0,
	objCoords = vector3(968.7536, -112.1022, 75.24942),
	objHeading = 43.01594543457,
	audioRemote = false,
	lockpick = false,
	garage = true,
	objHash = -822900180,
	authorizedJobs = { ['bigdogs']=0 },
	locked = true,
	fixText = false,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Dogs main building garage tin 
table.insert(Config.DoorList, {
	maxDistance = 6.0,
	slides = 6.0,
	authorizedJobs = { ['bigdogs']=0 },
	lockpick = false,
	objHeading = 239.42889404297,
	audioRemote = false,
	fixText = false,
	objHash = -197537718,
	objCoords = vector3(982.3875, -125.371, 74.99313),
	locked = true,
	garage = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big dogs inside door ting
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	slides = false,
	authorizedJobs = { ['bigdogs']=0 },
	lockpick = false,
	objHeading = 149.2314453125,
	audioRemote = false,
	fixText = false,
	objHash = -710818483,
	objCoords = vector3(990.8673, -132.8908, 74.21125),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Dogs PRESIDENT ONLY
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	slides = false,
	authorizedJobs = { ['bigdogs']=8 },
	lockpick = false,
	objHeading = 42.65185546875,
	audioRemote = false,
	fixText = false,
	objHash = 190770132,
	objCoords = vector3(981.1505, -103.2552, 74.99358),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Dogs PRESIDENT ONLY
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	slides = false,
	authorizedJobs = { ['bigdogs']=8 },
	lockpick = false,
	objHeading = 222.65187072754,
	audioRemote = false,
	fixText = false,
	objHash = 747286790,
	objCoords = vector3(981.7266, -95.82788, 74.99499),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big Dogs garage
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	slides = false,
	authorizedJobs = { ['Aidan']=0 },
	lockpick = false,
	objHeading = 43.01594543457,
	audioRemote = false,
	fixText = false,
	objHash = 1335311341,
	objCoords = vector3(959.3823, -120.4512, 75.16158),
	locked = true,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Big DOgs main gate (road side)
table.insert(Config.DoorList, {
	maxDistance = 9.0,
	objCoords = vector3(956.4541, -137.8409, 73.57489),
	garage = true,
	objHash = -930593859,
	objHeading = 148.19989013672,
	lockpick = false,
	slides = 9.0,
	audioRemote = false,
	fixText = false,
	locked = true,
	authorizedJobs = { ['bigdogs']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Jail Upstairs
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -2109504629, objHeading = 119.93480682373, objCoords = vector3(1772.949, 2492.125, 50.58296)},
		{objHash = -2109504629, objHeading = 299.93487548828, objCoords = vector3(1771.651, 2494.379, 50.58325)}
 },
	authorizedJobs = { ['police']=0, ['fbi']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Jail Upstairs 2
table.insert(Config.DoorList, {
	objHash = -1033001619,
	lockpick = false,
	maxDistance = 2.0,
	objCoords = vector3(1782.758, 2498.295, 50.57922),
	objHeading = 299.93487548828,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	fixText = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Enter Jail Upstairs
table.insert(Config.DoorList, {
	objHash = 1373390714,
	lockpick = false,
	maxDistance = 2.0,
	objCoords = vector3(1781.066, 2510.157, 45.97366),
	objHeading = 119.93480682373,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	fixText = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Jail Hospital
table.insert(Config.DoorList, {
	objHash = -1033001619,
	lockpick = false,
	maxDistance = 2.0,
	objCoords = vector3(1770.73, 2506.435, 45.97371),
	objHeading = 29.93483543396,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	fixText = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Jail Hospital2
table.insert(Config.DoorList, {
	objHash = -1033001619,
	lockpick = false,
	maxDistance = 2.0,
	objCoords = vector3(1778.182, 2508.379, 45.97719),
	objHeading = 119.93480682373,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	fixText = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Jail Hub2
table.insert(Config.DoorList, {
	objHash = -1033001619,
	lockpick = false,
	maxDistance = 2.0,
	objCoords = vector3(1778.001, 2510.581, 45.97771),
	objHeading = 29.93483543396,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	fixText = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Jail Hub3
table.insert(Config.DoorList, {
	objHash = -1033001619,
	lockpick = false,
	maxDistance = 2.0,
	objCoords = vector3(1779.72, 2507.594, 45.97622),
	objHeading = 29.93483543396,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	fixText = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Jail Outside
table.insert(Config.DoorList, {
	objHash = -1156020871,
	lockpick = false,
	maxDistance = 2.0,
	objCoords = vector3(1797.761, 2596.565, 46.38731),
	objHeading = 179.99987792969,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	audioRemote = false,
	garage = false,
	fixText = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Jail Gate2
table.insert(Config.DoorList, {
	objHash = 741314661,
	lockpick = false,
	maxDistance = 6.0,
	objCoords = vector3(1818.543, 2604.813, 44.611),
	objHeading = 90.0,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = true,
	audioRemote = false,
	garage = false,
	fixText = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- WeaponDoor1
table.insert(Config.DoorList, {
	audioRemote = false,
	objHash = 464151082,
	lockpick = false,
	objCoords = vector3(1109.728, -2335.621, 31.53238),
	maxDistance = 2.0,
	slides = false,
	authorizedJobs = { ['notolerance']=0 },
	locked = true,
	fixText = false,
	garage = false,
	objHeading = 355.76727294922,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Weapon 2
table.insert(Config.DoorList, {
	audioRemote = false,
	objHash = 749848321,
	lockpick = false,
	objCoords = vector3(1108.821, -2331.443, 31.54484),
	maxDistance = 2.0,
	slides = false,
	authorizedJobs = { ['notolerance']=0 },
	locked = true,
	fixText = false,
	garage = false,
	objHeading = 355.76727294922,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Black Mafia Family
table.insert(Config.DoorList, {
	garage = false,
	slides = false,
	objHash = -1706440710,
	fixText = false,
	locked = true,
	lockpick = false,
	objHeading = 29.480123519897,
	maxDistance = 2.0,
	audioRemote = false,
	objCoords = vector3(-1350.554, -1064.086, 7.632546),
	authorizedJobs = { ['bmf']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prison
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 89.999977111816,
	locked = true,
	garage = false,
	objHash = -1437850419,
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	fixText = false,
	objCoords = vector3(1833.67, 2595.02, 46.16415),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prison
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 89.999977111816,
	locked = true,
	garage = false,
	objHash = -1437850419,
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	fixText = false,
	objCoords = vector3(1841.047, 2595.018, 46.16415),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prison
table.insert(Config.DoorList, {
	slides = false,
	objHeading = 179.99987792969,
	locked = true,
	garage = false,
	objHash = -1156020871,
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	fixText = false,
	objCoords = vector3(1798.09, 2591.687, 46.41784),
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Drug Door
table.insert(Config.DoorList, {
	objHash = 1427451548,
	objCoords = vector3(2849.57, 4449.917, 48.67156),
	lockpick = false,
	slides = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	audioRemote = false,
	fixText = false,
	maxDistance = 2.0,
	locked = true,
	garage = false,
	objHeading = 288.00006103516,
	items = { 'greenlaptop' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Drug Door 2
table.insert(Config.DoorList, {
	objHash = 1427451548,
	objCoords = vector3(1384.355, -2080.837, 52.84856),
	lockpick = false,
	slides = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	audioRemote = false,
	fixText = false,
	maxDistance = 2.0,
	locked = true,
	garage = false,
	objHeading = 220.00004577637,
	items = { 'greenlaptop' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM Garage Door
table.insert(Config.DoorList, {
	garage = true,
	locked = true,
	slides = 6.0,
	objHeading = 249.87759399414,
	objCoords = vector3(-30.25878, -1081.206, 27.34126),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 6.0,
	lockpick = false,
	audioRemote = false,
	objHash = 30769481,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM Gate 1
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	slides = true,
	objHeading = 69.04231262207,
	objCoords = vector3(-54.30577, -1072.079, 26.22492),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 6.0,
	lockpick = false,
	audioRemote = false,
	objHash = -1603817716,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM Roof Access
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	slides = false,
	objHeading = 339.98190307617,
	objCoords = vector3(-16.9447, -1088.15, 26.97222),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	objHash = -2023754432,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM Office Door
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['cardealer']=0 },
	locked = true,
	slides = false,
	audioRemote = false,
	doors = {
		{objHash = 100848840, objHeading = 339.98190307617, objCoords = vector3(-15.68395, -1096.12, 27.28802)},
		{objHash = -2050436002, objHeading = 339.98190307617, objCoords = vector3(-17.70018, -1095.386, 27.28802)}
 },
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM Office Door Outside
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	slides = false,
	objHeading = 340.2995300293,
	objCoords = vector3(-21.81986, -1109.336, 27.03891),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	objHash = 1901183774,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM Office Gate Access
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	slides = true,
	objHeading = 186.00743103027,
	objCoords = vector3(-24.3913, -1120.205, 25.94434),
	lockpick = false,
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 6.0,
	audioRemote = false,
	fixText = false,
	objHash = -1603817716,
	items = { 'cardealer' },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- MRPD Outside Gate
table.insert(Config.DoorList, {
	locked = true,
	objCoords = vector3(488.8948, -1017.212, 27.14935),
	objHeading = 90.0,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	objHash = -1603817716,
	maxDistance = 6.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	garage = false,
	slides = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- esb_door1
table.insert(Config.DoorList, {
	locked = true,
	objCoords = vector3(124.6301, -1956.901, 20.92242),
	objHeading = 230.29716491699,
	authorizedJobs = { ['ballas']=0 },
	objHash = -543490328,
	maxDistance = 2.0,
	lockpick = false,
	audioRemote = false,
	fixText = false,
	garage = false,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- esb_door2
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	locked = true,
	objHeading = 320.42886352539,
	objHash = 464151082,
	lockpick = false,
	objCoords = vector3(128.6862, -1951.554, 15.40429),
	garage = false,
	authorizedJobs = { ['ballas']=0 },
	fixText = false,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- esb_door3
table.insert(Config.DoorList, {
	audioRemote = false,
	slides = false,
	locked = true,
	objHeading = 320.66821289063,
	objHash = 124766329,
	lockpick = false,
	objCoords = vector3(125.4591, -1945.527, 15.40689),
	garage = false,
	authorizedJobs = { ['ballas']=6 },
	fixText = false,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- captainoffice
table.insert(Config.DoorList, {
	locked = true,
	slides = false,
	maxDistance = 2.0,
	garage = false,
	objHash = -96679321,
	authorizedJobs = { ['police']=7 },
	lockpick = false,
	objCoords = vector3(458.6543, -990.6498, 30.82319),
	objHeading = 270.00003051758,
	audioRemote = false,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- MRPD Double Dooor
table.insert(Config.DoorList, {
	lockpick = false,
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	slides = false,
	locked = true,
	audioRemote = false,
	maxDistance = 2.5,
	doors = {
		{objHash = -692649124, objHeading = 0.0, objCoords = vector3(467.3686, -1014.406, 26.48382)},
		{objHash = -692649124, objHeading = 180.00001525879, objCoords = vector3(469.7743, -1014.406, 26.48382)}
 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- FBI MAIN DOORS
table.insert(Config.DoorList, {
	doors = {
		{objHash = -90456267, objHeading = 84.050018310547, objCoords = vector3(105.7607, -746.646, 46.18266)},
		{objHash = -1517873911, objHeading = 78.216918945313, objCoords = vector3(106.3793, -742.6982, 46.18171)}
 },
	slides = false,
	authorizedJobs = { ['fbi']=0, ['police']=0 },
	maxDistance = 2.5,
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- FBI Inside Door #1
table.insert(Config.DoorList, {
	authorizedJobs = { ['fbi']=0, ['police']=0 },
	garage = false,
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	slides = false,
	objCoords = vector3(127.2092, -764.6935, 242.302),
	fixText = false,
	objHash = -1821777087,
	objHeading = 249.99995422363,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- FBI eletronics room
table.insert(Config.DoorList, {
	authorizedJobs = { ['fbi']=0 },
	garage = false,
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	slides = false,
	objCoords = vector3(118.3177, -733.7009, 242.3022),
	fixText = false,
	objHash = -1821777087,
	objHeading = 159.99993896484,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- FBI inside door 2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0, ['fbi']=0 },
	garage = false,
	locked = true,
	maxDistance = 2.0,
	lockpick = false,
	slides = false,
	objCoords = vector3(138.5112, -768.8054, 242.3022),
	fixText = false,
	objHash = -1821777087,
	objHeading = 249.99995422363,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- FBI Elevator
table.insert(Config.DoorList, {
	authorizedJobs = { ['fbi']=7 },
	audioRemote = false,
	slides = false,
	doors = {
		{objHash = -1225363909, objHeading = 339.85760498047, objCoords = vector3(137.7594, -763.9288, 44.75291)},
		{objHash = 1219957182, objHeading = 339.99993896484, objCoords = vector3(139.1689, -764.4418, 44.75182)}
 },
	maxDistance = 0.1,
	lockpick = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Front Door
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(355.6923, 301.0186, 104.2022),
	audioRemote = false,
	objHeading = 165.6577911377,
	objHash = -1989765534,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Second Entrance Door
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(343.6965, 290.1124, 95.95515),
	audioRemote = false,
	objHeading = 344.59246826172,
	objHash = -1989765534,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Bar Door
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(354.45, 273.7086, 94.35609),
	audioRemote = false,
	objHeading = 74.592529296875,
	objHash = 1695461688,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Bar Door 2
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(354.3084, 279.0399, 94.35609),
	audioRemote = false,
	objHeading = 344.59246826172,
	objHash = 1695461688,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy VIP Door
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(377.781, 267.7672, 95.13993),
	audioRemote = false,
	objHeading = 74.592529296875,
	objHash = -1555108147,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Glass VIP Door
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(384.9052, 269.4525, 95.15611),
	audioRemote = false,
	objHeading = 299.59240722656,
	objHash = -1119680854,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Glass Garage Door
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(393.9439, 274.6731, 95.1521),
	audioRemote = false,
	objHeading = 305.59243774414,
	objHash = -1119680854,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Second Side Garage Door
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(394.8011, 278.0572, 95.15611),
	audioRemote = false,
	objHeading = 254.59246826172,
	objHash = 1695461688,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Bottom Garage Door
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(380.1554, 266.635, 91.35513),
	audioRemote = false,
	objHeading = 344.59246826172,
	objHash = 1695461688,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Galaxy Dance Floor to Garage
table.insert(Config.DoorList, {
	locked = true,
	lockpick = false,
	authorizedJobs = { ['galaxy']=0 },
	slides = false,
	garage = false,
	objCoords = vector3(377.7338, 267.7802, 91.35513),
	audioRemote = false,
	objHeading = 74.592529296875,
	objHash = -1989765534,
	maxDistance = 2.0,
	fixText = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- KK Front Door
table.insert(Config.DoorList, {
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['kronickush']=0 },
	garage = false,
	fixText = false,
	objHeading = 270.00003051758,
	locked = true,
	objHash = -1594418936,
	maxDistance = 2.0,
	objCoords = vector3(376.502, -827.0119, 29.56538),
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- KK Door
table.insert(Config.DoorList, {
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['kronickush']=0 },
	garage = false,
	fixText = false,
	objHeading = 180.00003051758,
	locked = true,
	objHash = -538477509,
	maxDistance = 2.0,
	objCoords = vector3(381.4216, -825.1628, 29.45322),
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- KK Door2
table.insert(Config.DoorList, {
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['kronickush']=0 },
	garage = false,
	fixText = false,
	objHeading = 180.00001525879,
	locked = true,
	objHash = -311575617,
	maxDistance = 2.0,
	objCoords = vector3(375.8304, -821.0286, 29.44885),
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- KK Door3
table.insert(Config.DoorList, {
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['kronickush']=0 },
	garage = false,
	fixText = false,
	objHeading = 89.999977111816,
	locked = true,
	objHash = -311575617,
	maxDistance = 2.0,
	objCoords = vector3(376.8353, -817.5457, 29.44885),
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})