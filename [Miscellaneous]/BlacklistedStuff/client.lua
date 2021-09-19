
------------------------------------------------------------------------------------------------- WEAPON DROPS -----------------------------------------------------------------------------------------------
function SetWeaponDrops()
	local handle, ped = FindFirstPed()
	local finished = false
	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end

function SetWeaponDrops()
	local handle, ped = FindFirstPed()
	local finished = false
	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end

------------------------------------------------------------------------------------------------- OTHER SCRIPT -----------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		DistantCopCarSirens(false)
		SetWeaponDrops()
		Citizen.Wait(400)
	end
    SetCreateRandomCops(false)
    SetCreateRandomCopsNotOnScenarios(false)
    SetCreateRandomCopsOnScenarios(false)
    SetScenarioTypeEnabled('WORLD_HUMAN_COP_IDLES', false)
    SetScenarioTypeEnabled('WORLD_VEHICLE_POLICE_BIKE', false)
    SetScenarioTypeEnabled('WORLD_VEHICLE_POLICE_CAR', false)
    SetScenarioTypeEnabled('WORLD_VEHICLE_POLICE_NEXT_TO_CAR', false)
    SetScenarioTypeEnabled('CODE_HUMAN_POLICE_CROWD_CONTROL', false)
    SetScenarioTypeEnabled('CODE_HUMAN_POLICE_INVESTIGATE', false)
    SetScenarioTypeEnabled('WORLD_VEHICLE_AMBULANCE', false)
    SetScenarioTypeEnabled('WORLD_VEHICLE_FIRE_TRUCK', false)
	for i = 1, 25 do
		EnableDispatchService(i, false)
		Citizen.Wait(1)
	end
end)

------------------------------------------------------------------------------------------------- EMERGENCY -----------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	  for i = 1, 25 do
		  Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	  end
end)

------------------------------------------------------------------------------------------------- AI DENSITY -----------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local densityMultiplier = 0.4
	while true do
		ClearAreaOfCops(GetEntityCoords(PlayerPedId()), 1000.0)
		SetVehicleDensityMultiplierThisFrame(densityMultiplier)
		SetPedDensityMultiplierThisFrame(densityMultiplier)
		SetRandomVehicleDensityMultiplierThisFrame(densityMultiplier)
		SetParkedVehicleDensityMultiplierThisFrame(densityMultiplier)
		SetScenarioPedDensityMultiplierThisFrame(densityMultiplier, densityMultiplier)
		SetRandomBoats(true)
		SetGarbageTrucks(true)

		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(13)
		Citizen.Wait(0)
	end

    ExpandWorldLimits(-9000.0, -11000.0, 30.0)
    ExpandWorldLimits(10000.0, 12000.0, 30.0)
end)

------------------------------------------------------------------------------------------------- OTHER SCRIPT -----------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    -- Other stuff normally here, stripped for the sake of only scenario stuff
    local SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
        "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes
    }
    local SCENARIO_GROUPS = {
        2017590552, -- LSIA planes
        2141866469, -- Sandy Shores planes
        1409640232, -- Grapeseed planes
        "ng_planes", -- Far up in the skies jets
    }
    local SUPPRESSED_MODELS = {
        "SHAMAL", -- They spawn on LSIA and try to take off
        "LUXOR", -- They spawn on LSIA and try to take off
        "LUXOR2", -- They spawn on LSIA and try to take off
        "JET", -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
        "LAZER", -- They spawn on Zancudo and try to take off
        "TITAN", -- They spawn on Zancudo and try to take off
        "BARRACKS", -- Regularily driving around the Zancudo airport surface
        "BARRACKS2", -- Regularily driving around the Zancudo airport surface
        "CRUSADER", -- Regularily driving around the Zancudo airport surface
        "RHINO", -- Regularily driving around the Zancudo airport surface
        "AIRTUG", -- Regularily spawns on the LSIA airport surface
        "RIPLEY", -- Regularily spawns on the LSIA airport surface
    }

    while true do
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        Wait(10000)
    end
end)
