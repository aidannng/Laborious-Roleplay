
--TELEPORT
key_to_teleport = 38

positions = {
    --[[
    {{Teleport1 X, Teleport1 Y, Teleport1 Z, Teleport1 Heading}, {Teleport2 X, Teleport 2Y, Teleport 2Z, Teleport2 Heading}, {Red, Green, Blue}, "Text for Teleport"}
    ]]
    {{1086.514, -2399.987, 30.56042, 0}, {1004.479, -2992.378, -39.65271, 358},{255,0,0}, "NT Test"}, -- Outside the Sheriff's Station
	--{{1086.00, 215.0, -50.00, 312}, {964.2912597, 58.9096641, 111.65295562744, 52},{255,0,0}, "penthouse"},
}
local pos = GetEntityCoords(ped)
local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1086.514, -2399.987, 30.56042, true)
local dist2 = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1004.479, -2992.378, -39.65271, true)


local player = GetPlayerPed(-1)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
		local player = GetPlayerPed(-1)
		if dist < 1.8 and dist > 2 then
			exports['cd_drawtextui']:ShowInteraction('show', 'green', "[E] Enter NT HQ")
			if IsControlJustReleased(1, key_to_teleport) then
				DoScreenFadeOut(500)
				Wait(500)
				SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
				SetEntityHeading(player, loc2.heading)
				DoScreenFadeIn(500)
				enterCasino(false)
				Citizen.Wait(1)
				enterCasino(true)
				scanned = true
				scanwait = 200
			end
		end
	end
end)


  
