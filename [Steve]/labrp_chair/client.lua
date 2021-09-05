attachedProp = 0
attachedProp2 = 0

function attachAProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp2()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end

function attachAProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent 
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end

function removeAttachedProp()
	DeleteEntity(attachedProp)
	attachedProp = 0
end

function loadModel(modelName)
    RequestModel(GetHashKey(modelName))
    while not HasModelLoaded(GetHashKey(modelName)) do
        RequestModel(GetHashKey(modelName))
        Citizen.Wait(1)
    end
end
 

function removeAttachedProp2()
	DeleteEntity(attachedProp2)
	attachedProp2 = 0
end
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end



RegisterNetEvent('labrp-chairs:UseChair1')
AddEventHandler('labrp-chairs:UseChair1', function()
	greenchair()
end)

RegisterNetEvent('labrp-chairs:UseChair2')
AddEventHandler('labrp-chairs:UseChair2', function()
	pladchair()
end)



function greenchair()
	if not haschairalready then
		if IsPedInAnyVehicle(PlayerPedId(-1)) then
			exports['mythic_notify']:SendAlert('error', 'Unable to use item in Vehicle!') 
		else
			haschairalready = true
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local animDict = "timetable@ron@ig_3_couch"
			local animation = "base"
			attachAProp("prop_skid_chair_01", 0, 0, 0.0, -0.22, 3.4, 0.4, 180.0, 0.0, false, false, false, false, 2, true)
			loadAnimDict(animDict)
			local animLength = GetAnimDuration(animDict, animation)
			TaskPlayAnim(PlayerPedId(), animDict, animation, 1.0, 4.0, animLength, 1, 0, 0, 0, 0)
		end
	else
		haschairalready = false
		FreezeEntityPosition(PlayerPedId(),false)
		removeAttachedProp()
		removeAttachedProp2()
		ClearPedTasks(PlayerPedId())
	end
end

function pladchair()
	if not haschairalready then
		if IsPedInAnyVehicle(PlayerPedId(-1)) then
			exports['mythic_notify']:SendAlert('error', 'Unable to use item in Vehicle!') 
		else
			haschairalready = true
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local animDict = "timetable@ron@ig_3_couch"
			local animation = "base"
			attachAProp("hei_prop_hei_skid_chair", 0, 0, 0.0, -0.22, 3.4, 0.4, 180.0, 0.0, false, false, false, false, 2, true)
			loadAnimDict(animDict)
			local animLength = GetAnimDuration(animDict, animation)
			TaskPlayAnim(PlayerPedId(), animDict, animation, 1.0, 4.0, animLength, 1, 0, 0, 0, 0)
		end
	else
		haschairalready = false
		FreezeEntityPosition(PlayerPedId(),false)
		removeAttachedProp()
		removeAttachedProp2()
		ClearPedTasks(PlayerPedId())
	end
end

RegisterCommand('clearprop', function()
	FreezeEntityPosition(PlayerPedId(),false)
	removeAttachedProp()
	removeAttachedProp2()
end)


RegisterNetEvent('use:stopsign')
AddEventHandler('use:stopsign', function()
	stopsign()
end)


function stopsign()
	if not hasstopsign then
		if IsPedInAnyVehicle(PlayerPedId(-1)) then
			exports['mythic_notify']:SendAlert('error', 'Unable to use item in Vehicle!') 
		else
			hasstopsign = true
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local animDict = "random@hitch_lift"
			local animation = "idle_f"
			local stopsignprop = attachAProp("prop_sign_road_01a", 28422, 0, -1.2, 0.0, 15.0, 90.0, 90.0, 0.0, false, false, false, false, 2, true)
			loadAnimDict(animDict)
			local animLength = GetAnimDuration(animDict, animation)
			TaskPlayAnim(GetPlayerPed(-1), animDict, animation, 2.0, 2.0, animLength, 51, 0, false, false, false)
		end
	else
		hasstopsign = false
		ClearPedTasks(PlayerPedId())
		removeAttachedProp()
	end
end


RegisterNetEvent('labrp_phone:anim')
AddEventHandler('labrp_phone:anim', function()
	if not hasphoneout then
		hasphoneout = true
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local animDict = "cellphone@"
		local animation = "cellphone_text_read_base"


		local phoneprop = attachAProp("prop_npc_phone_02", 28422, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		loadAnimDict(animDict)
		local animLength = GetAnimDuration(animDict, animation)
		TaskPlayAnim(GetPlayerPed(-1), animDict, animation, 2.0, 2.0, animLength, 51, 0, false, false, false)
	else
		hasphoneout = false
		ClearPedTasks(PlayerPedId())
		removeAttachedProp()
	end
end)
