----------------------------
-- By K3rhos & DoluTattoo --
----------------------------


-- Coords for the first elevator prop (doesnt need heading)
local elevatorBaseX = -325.0417
local elevatorBaseY = -139.0945
local elevatorBaseZ = 39.0022
----

-- Coords for the second elevator prop
local elevator2BaseX = -321.2703
local elevator2BaseY = -128.7429
local elevator2BaseZ = 39.0022
local elevator2BaseHeading = 270.0
-----

-- Coords for the third elevator prop
local elevator2BaseX = -319.2791
local elevator2BaseY = -128.7429
local elevator2BaseZ = 39.0022
local elevator2BaseHeading = 270.0
-----

-- Coords for the fourth elevator prop
local elevator2BaseX = -313.622
local elevator2BaseY = -108.1187
local elevator2BaseZ = 39.0022
local elevator2BaseHeading = 270.0

function createObject(model, x, y, z)
	RequestModel(model)
	while (not HasModelLoaded(model)) do
		Citizen.Wait(0)
	end
	return CreateObject(model, x, y, z, true, true, false)
end

function spawnProp(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevatorProp = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevatorProp)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevatorProp, 0xFFFF)
		SetEntityCollision(elevatorProp, true, true)
		FreezeEntityPosition(elevatorProp, true)
		SetEntityCoords(elevatorProp, x, y, z, false, false, false, false) -- Patch un bug pour certains props.

		la_nacelle_estelle_la = true -- la nacelle est là
	end
end

function spawnProp2(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevator2Prop = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevator2Prop)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevator2Prop, 0xFFFF)
		SetEntityCollision(elevator2Prop, true, true)
		FreezeEntityPosition(elevator2Prop, true)
		SetEntityCoords(elevator2Prop, x, y, z, false, false, false, false) -- Patch un bug pour certains props.
		SetEntityHeading(elevator2Prop, elevator2BaseHeading)

		la_nacelle_estelle_la = true -- la nacelle est là
	end
end

function spawnProp3(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevator3Prop = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevator2Prop)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevator3Prop, 0xFFFF)
		SetEntityCollision(elevator3Prop, true, true)
		FreezeEntityPosition(elevator3Prop, true)
		SetEntityCoords(elevator3Prop, x, y, z, false, false, false, false) -- Patch un bug pour certains props.
		SetEntityHeading(elevator3Prop, elevator3BaseHeading)

		la_nacelle_estelle_la = true -- la nacelle est là
	end
end

function spawnProp4(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevator4Prop = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevator2Prop)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevator4Prop, 0xFFFF)
		SetEntityCollision(elevator4Prop, true, true)
		FreezeEntityPosition(elevator4Prop, true)
		SetEntityCoords(elevator4Prop, x, y, z, false, false, false, false) -- Patch un bug pour certains props.
		SetEntityHeading(elevator4Prop, elevator4BaseHeading)

		la_nacelle_estelle_la = true -- la nacelle est là
	end
end