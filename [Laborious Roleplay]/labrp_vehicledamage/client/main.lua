ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('veh:repairing')
AddEventHandler('veh:repairing', function(itemName,source)
    local reapiring = false
	local playerped = PlayerPedId()
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)


	local Bigkit = false
	if itemName == 'advancedrepair' then
		Bigkit = true
	end

	if targetVehicle ~= 0 then

        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2['y']+0.5,0.0)
        local dist = #(vector3(moveto['x'],moveto['y'],moveto['z']) - GetEntityCoords(PlayerPedId()))
        local count = 1000

        while dist > 1.0 and count > 0 do
            dist = #(vector3(moveto['x'],moveto['y'],moveto['z']) - GetEntityCoords(PlayerPedId()))
            Citizen.Wait(1)
            count = count - 1
            DrawText3Ds(moveto['x'],moveto['y'],moveto['z'],'Move here to repair.')
        end

        if reapiring then return end
        reapiring = true

        if dist < 1.0 then
            TriggerEvent('AniRepair', targetVehicle)
            fixingvehicle = true

            local repairlength = 10000

            if Bigkit then
                repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 4) + 2000
            else
                repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 2) + 2000
            end

            TriggerEvent("mythic_progbar:client:progress", {
		        name = "repair",
		        duration = timer,
		        label = "Repairing Vehicle",
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
		            if Bigkit then
	                    repairFull(targetVehicle)
	                    SetVehicleFixed( targetVehicle )
	                else
	                	repairBase(targetVehicle)
		            end
		        end
		    end)
            ClearPedTasks(playerped)
        end
        fixingvehicle = false
    end
    reapiring = false
end)



repairBase = function(targetVehicle)
	SetVehicleEngineHealth(targetVehicle, 300.0)
    for i = 0, 5 do
        SetVehicleTyreFixed(targetVehicle, i) 
    end
end

repairFull = function(targetVehicle)
	SetVehicleEngineHealth(targetVehicle, 1000.0)
    SetVehicleBodyHealth(targetVehicle, 1000.0)
    for i = 0, 5 do
        SetVehicleTyreFixed(targetVehicle, i) 
    end
end

getVehicleInDirection = function(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

DrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
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


RegisterNetEvent('AniRepair')
AddEventHandler('AniRepair', function(veh)
    SetVehicleDoorOpen(veh, 4, 0, 0)
    RequestAnimDict('mini@repair')
    while not HasAnimDictLoaded('mini@repair') do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(PlayerPedId(), veh, 1.0)
    Citizen.Wait(1000)

    while fixingvehicle do
        local anim3 = IsEntityPlayingAnim(PlayerPedId(), 'mini@repair', 'fixing_a_player', 3)
        if not anim3 then
            TaskPlayAnim(PlayerPedId(), 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    SetVehicleDoorShut(veh, 4, 1, 1)
end)