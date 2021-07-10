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
  
  --------Disable ALL Emergency--------------------------
  Citizen.CreateThread(function()
	  for i = 1, 25 do
		  Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	  end
end)

  --------AI DENSITY--------------------------
Citizen.CreateThread(function()
	local densityMultiplier = 1.0
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
		Citizen.Wait(1000)
	end

    ExpandWorldLimits(-9000.0, -11000.0, 30.0)
    ExpandWorldLimits(10000.0, 12000.0, 30.0)
end)

