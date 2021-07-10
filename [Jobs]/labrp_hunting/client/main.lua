
ESX                             = nil

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

local animal = {
	`a_c_deer`,
	`a_c_boar`,
	`a_c_coyote`,
	`a_c_mtlion`,
	`a_c_pig`,
	`a_c_rabbit_01`,
	`a_c_rat`,
	`a_c_cow`,
	`a_c_cat`,
	`a_c_chickenhawk`,
	`a_c_chimp`,
	`a_c_chop`,
	`a_c_cormorant`,
	`a_c_crow`,
	`a_c_dolphin`,
	`a_c_fish`,
	`a_c_hen`,
	`a_c_humpback`,
	`a_c_husky`,
	`a_c_killerwhale`,
	`a_c_pigeon`,
	`a_c_poodle`,
	`a_c_pug`,
	`a_c_retriever`,
	`a_c_rhesus`,
	`a_c_rottweiler`,
	`a_c_seagull`,
	`a_c_sharkhammer`,
	`a_c_sharktiger`,
	`a_c_shepherd`,
	`a_c_stingray`,
	`a_c_westy`,
}

-- Aminauls
exports['labrp_Eye']:AddTargetModel(animal, {
	options = {
		{
			event = "hunting:butcherCreature",
			icon = "fas fa-cut",
			label = "Butcher Animal",
		},
	},
	job = {"all"},
	distance = 3.5
})

exports['labrp_Eye']:AddBoxZone("Paleto hunting-seller", vector3(-679.1, 5839.9, 17.3), 0.8, 0.8, {
	name= "Paleto hunting-seller",
	heading= 33.75,
	debugPoly= false,
	minZ= 17.3,
	maxZ= 17.5
}, {
	options = {
	{
	event = 'hunting:SellMeat',
	icon = "fas fa-shopping-basket",
	label = "Sell your Meat",
	},
	{
	event = 'hunting:SellLeather',
	icon = "fas fa-shopping-basket",
	label = "Sell your Leather",
	},
},
	job = {"all"},
	distance = 2.5
})
 --`a_c_cow`,`a_c_deer`,`a_c_boar`,`a_c_coyote`,`a_c_mtlion`,`a_c_pig`,`a_c_rabbit_01`,`a_c_rat`,`a_c_cat`,`a_c_chickenhawk`,`a_c_chimp`,`a_c_chop`,`a_c_cormorant`,`a_c_crow`,`a_c_dolphin`,`a_c_fish`,`a_c_hen`,`a_c_humpback`,`a_c_husky`,`a_c_killerwhale`,`a_c_pigeon`,`a_c_poodle`,`a_c_pug`,`a_c_retriever`,`a_c_rhesus`,`a_c_rottweiler`,`a_c_seagull`,`a_c_sharkhammer`,`a_c_sharktiger`,`a_c_shepherd`,`a_c_stingray`,`a_c_westy` <- all model hashes, If needbe you can probably attach these their own events, messy but workable.

RegisterNetEvent("hunting:butcherCreature")
AddEventHandler("hunting:butcherCreature", function()
	local dead = false
	local plyCoords = GetEntityCoords(PlayerPedId())
	local closestAnimal, closestDistance = ESX.Game.GetClosestPed(plyCoords)
	local animal = `a_c_cow`,`a_c_deer`,`a_c_boar`,`a_c_coyote`,`a_c_mtlion`,`a_c_pig`,`a_c_rabbit_01`,`a_c_rat`,`a_c_cat`,`a_c_chickenhawk`,`a_c_chimp`,`a_c_chop`,`a_c_cormorant`,`a_c_crow`,`a_c_dolphin`,`a_c_fish`,`a_c_hen`,`a_c_humpback`,`a_c_husky`,`a_c_killerwhale`,`a_c_pigeon`,`a_c_poodle`,`a_c_pug`,`a_c_retriever`,`a_c_rhesus`,`a_c_rottweiler`,`a_c_seagull`,`a_c_sharkhammer`,`a_c_sharktiger`,`a_c_shepherd`,`a_c_stingray`,`a_c_westy` --dunno why but this seems to make it all work?
	if closestAnimal ~= -1 and closestDistance <= 3.0 then
		if GetPedType(closestAnimal) == 28 and GetEntityHealth(closestAnimal) == 0 and GetPedSourceOfDeath(closestAnimal) == PlayerPedId() then
			dead = true
			while not NetworkHasControlOfEntity(closestAnimal) and attempt < 10 and DoesEntityExist(closestAnimal) do -- Network handling contributed via thelindat
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(closestAnimal)
				attempt = attempt + 1
			end
			 if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE') then
				if DoesEntityExist(closestAnimal) and NetworkHasControlOfEntity(closestAnimal) then
					local netid = NetworkGetNetworkIdFromEntity(closestAnimal)
					SetNetworkIdCanMigrate(netid, false)
					--print(netid)
					-- harvest this sonofa thnx thelindat
					TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
					TriggerEvent("mythic_progbar:client:progress", { -- MUCHO IMPORTANTE FOR THE TARGETING SYSTEM TO PREVENT TRIGGER SPAM DO NOT REMOVE UNLESS YOU ARE TRYINNA PATCH THAT ISH YOURSELF
						name = "skinning",
						duration = 7500,
						label = "Skinning Animal",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = false,
							disableCarMovement = false,
							disableMouse = false,
							disableCombat = false,
						},
						animation = {
							animDict = "anim@gangops@facility@servers@bodysearch@",
							anim = "player_search"
						},
					}, function(status)
						if not status then
							ClearPedTasksImmediately(PlayerPedId())
							local AnimalWeight = math.random(200) / 10
							exports['mythic_notify']:SendAlert('inform', 'You have slaughtered an animal yielding a total of ' ..AnimalWeight.. 'kg of meat and leather.', 6500)
							isButchering = false
							TriggerServerEvent('hunting:rewardShit', AnimalWeight) -- Thnx Qalle!
							Citizen.Wait(150)
							TriggerServerEvent('hunting:SkinIt')
							SetEntityAsMissionEntity(closestAnimal, true, true)
							SetEntityAsNoLongerNeeded(closestAnimal)
							DeleteEntity(closestAnimal)
							if config.stress then
								if math.random(1,10) < 6 then
									exports['utk_stress']:AddStress('instant', 10000)
								end
							end
						end
					end)
				end
			 else
			 	exports['mythic_notify']:SendAlert('inform', 'This is the wrong tool for that activity, use a knife.', 3000)
			 end
		elseif dead == false or GetPedCauseOfDeath(closestAnimal) ~= PlayerPedId() or netid == nil then
			exports['mythic_notify']:SendAlert('inform', 'This animal is not dead or this is not your kill.', 3000)
			dead = false
		end
	end
end)




-- Thanx u DRKM43 you beautiful bastard for this ped spawning handler 
local spawnedPeds = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		for k,v in pairs(Config.PedList) do
			local playerCoords = GetEntityCoords(PlayerPedId())
			local distance = #(playerCoords - v.coords.xyz)
			if distance < Config.DistanceSpawn and not spawnedPeds[k] then
				local spawnedPed = NearPed(v.model, v.coords, v.gender, v.animDict, v.animName, v.scenario)
				spawnedPeds[k] = { spawnedPed = spawnedPed }
			end
			if distance >= Config.DistanceSpawn and spawnedPeds[k] then
				if Config.FadeIn then
					for i = 255, 0, -51 do
						Citizen.Wait(50)
						SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
					end
				end
				DeletePed(spawnedPeds[k].spawnedPed)
				spawnedPeds[k] = nil
			end
		end
	end
end)

function NearPed(model, coords, gender, animDict, animName, scenario)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(50)
	end
	if Config.MinusOne then
		spawnedPed = CreatePed(Config.GenderNumbers[gender], model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
	else
		spawnedPed = CreatePed(Config.GenderNumbers[gender], model, coords.x, coords.y, coords.z, coords.w, false, true)
	end
	SetEntityAlpha(spawnedPed, 0, false)
	if Config.Frozen then
		FreezeEntityPosition(spawnedPed, true)
	end
	if Config.Invincible then
		SetEntityInvincible(spawnedPed, true)
	end
	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(spawnedPed, true)
	end
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(50)
		end
		TaskPlayAnim(spawnedPed, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
    if scenario then
        TaskStartScenarioInPlace(spawnedPed, scenario, 0, true)
    end
	if Config.FadeIn then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(spawnedPed, i, false)
		end
	end
	return spawnedPed
end

local model ={
	`cs_hunter` --if wishing to use a different model place the model hash or modelID here.
}

exports['labrp_Eye']:AddTargetModel(model, {
	options = {
		{
			event = "hunting:SellMeat",
			icon = "fas fa-shopping-basket",
			label = "Sell Meats",
		},
		{
			event = "hunting:SellLeather",
			icon = "fas fa-shopping-basket",
			label = "Sell Leathers",
		},
	},
	job = {"all"},
	distance = 3.0
})

RegisterNetEvent('hunting:SellLeather')
AddEventHandler('hunting:SellLeather', function()
	local coords = GetEntityCoords(PlayerPedId())
	local seller = vector3(-678.1,5838.5,17.31) -- or config this bitch w/e you'll need to adjust the bt-target location to sell, or add items to however you deal with the like.
	if #(coords - seller) < 5 then -- if you trust your clients you can remove this.
	TriggerServerEvent('hunting:sellLeather')
	else
		exports['mythic_notify']:SendAlert('error', 'You have nothing to sell!') -- if your mythic_notify does not have the SendAlert export, replace with any of the others i.e DoShortHudText, DoLongHudText, etc.
	end
end)

RegisterNetEvent('hunting:SellMeat')
AddEventHandler('hunting:SellMeat', function()
	local coords = GetEntityCoords(PlayerPedId())
	local seller = vector3(-678.1,5838.5,17.31) -- or config this bitch w/e you'll need to adjust the bt-target location to sell, or add items to however you deal with the like.
	if #(coords - seller) < 5 then
	TriggerServerEvent('hunting:sellMeat')
	else
		exports['mythic_notify']:SendAlert('error', 'You have nothing to sell!')
	end
end)

Citizen.CreateThread(function()
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
end)

function LoadAnimDict(dict)
     while (not HasAnimDictLoaded(dict)) do
         RequestAnimDict(dict)
         Citizen.Wait(10)
     end    
end




local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	-- Postes de polices
	{title="Hunting Area", colour=43, id=141, x=-1425.5, y=3663.7, z=316.5},
  }

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

--{title="Hunting Area", colour=6, id=9, x=-445.202, y=6014.36, z=31.7164},
---1425.5, 3663.7, 316.5

