ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
	end
end)


local holding, npcfound, areafound, resume, cancelcorner = false, false, false, false, false
local radius = 0
local areacoord, id = nil, nil

local npcModels = {
    "a_f_y_hipster_02",
    "a_f_y_vinewood_02",
    "a_m_m_hillbilly_02",
    "a_m_o_soucent_02",
    "a_m_o_tramp_01",

}


RegisterCommand("corner", function(source, args)
    local playerPed = PlayerPedId()
    if not IsPedInAnyVehicle(playerPed) and not IsPedInAnyBoat(playerPed) and not IsPedInAnyHeli(playerPed) and not IsPedInAnyPlane(playerPed) then
        if not holding then
            if args[1] == nil then
                exports['mythic_notify']:SendAlert('error', 'Quantity cannot be empty') 
            elseif tonumber(args[1]) < 1 then
                exports['mythic_notify']:SendAlert('error', 'You cannot enter negative numbers') 
            elseif tonumber(args[1]) > 5 then
                exports['mythic_notify']:SendAlert('error', 'You can only sell 5 pairs at a time') 
            else
                holding = true
                itemCount = args[1]
                TriggerEvent("kaves_drugs:StartCorner")
            end
        else
            exports['mythic_notify']:SendAlert('error', 'You are already cornering now')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'you cannot hold a corner in any vehicle')
    end
end)

RegisterCommand("kosetutiptal", function()
    DeleteEntity(npcPED)
    holding = false
    areafound = false
    areacoord = nil
    npcfound = false
    id = 0
    radius = 0
    npcPED = nil
    cancelcorner = true
end)


Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoord = GetEntityCoords(playerPed)
        if holding then
            sleep = 1
            for k,v in pairs(Config.Corners) do
                local dst = #(playerCoord - v.coord)
                if dst < v.radius then
                    areacoord = v.coord
                    areafound = true
                    id = k
                    radius = v.radius
                   -- print(areacoord, areafound, id, radius)
                end
            end
            if areafound then
                if not npcfound then
                    randomItem = Config.Corners[id].items[math.random(1, #Config.Corners[id].items)]
                    randomMoney = math.random(Config.Corners[id].minMoney, Config.Corners[id].maxMoney)
                    itemname = Config.ItemsName[randomItem]
                    local randomModel = npcModels[math.random(1, #npcModels)]
                    local hash = GetHashKey(randomModel)
                    local coord = Config.Corners[id].spawnpoints[math.random(1, #Config.Corners[id].spawnpoints)]
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do Citizen.Wait(10) end
                    npcPED = CreatePed(4, hash, coord.x, coord.y, coord.z, false, false)
                    Citizen.Wait(math.random(5000,8000))
                    exports['mythic_notify']:SendAlert('inform', 'Customer found, moving towards you.')
                    TaskGoToEntity(npcPED, playerPed, -1, 3.0, 1.0, 1073741824, 0)
                    --AddBlipForCoord(coord.x, coord.y, coord.z, 0, 0)
                    npcfound = true
                end
                playerCoord = GetEntityCoords(playerPed)
                pedCoord = GetEntityCoords(npcPED)
                pedst = #(playerCoord - pedCoord)
              --  print(pedst, npcPED, pedCoord)
                if pedst <= 3 then
                    resume = true
                    FreezeEntityPosition(npcPED, true)
                    DrawText3Ds(pedCoord.x, pedCoord.y, pedCoord.z+1.0, 0.40, "~g~[E]~w~ Sell "..itemCount.."x "..itemname.. " $".. randomMoney.." ~r~[H]~w~ Hire")
                else
                    FreezeEntityPosition(npcPED, false)
                    if resume then
                        TaskGoToEntity(npcPED, playerPed, -1, 3.0, 1.0, 1073741824, 0)
                        resume = false
                    end
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You cannnot hold a corner here')
                holding = false
                areafound = false
                areacoord = nil
                npcfound = false
                id = 0
                radius = 0
                cancelcorner = true
            end
        end
        if areafound then
            local pedDistance = #(playerCoord - areacoord)
            if pedDistance > radius then
                exports['mythic_notify']:SendAlert('error', 'Corner canceled because you walked away from the zone')
                holding = false
                areafound = false
                areacoord = nil
                npcfound = false
                id = 0
                radius = 0
                DeleteEntity(npcPED)
                npcPED = nil
            end
        end
        if HasEntityBeenDamagedByAnyPed(npcPED) then
            exports['mythic_notify']:SendAlert('inform', 'He does not want to take anything from you for battering the buyer! You are looking for new customers.')
            newPed = npcPED
            FreezeEntityPosition(newPed, false)
            TaskWanderStandard(newPed, 1, 10)
            npcPED = nil
            npcfound = false
            Citizen.Wait(15000)
            DeleteEntity(newPed)
            newPed = nil
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent("kaves_drugs:StartCorner")
AddEventHandler("kaves_drugs:StartCorner", function()
    while true do
        local playerPed = PlayerPedId()
		if npcfound then
			if IsControlJustPressed(0, 74) and pedst <= 2 then
				newPed = npcPED
				FreezeEntityPosition(newPed, false)
				TaskWanderStandard(newPed, 1, 10)
                exports['mythic_notify']:SendAlert('inform', 'You are looking for new customers')
				npcPED = nil
				npcfound = false
				Citizen.Wait(15000)
				DeleteEntity(newPed)
				newPed = nil
			elseif IsControlJustPressed(0, 38) and pedst <= 2 then
				ESX.TriggerServerCallback("kaves_drugs:checkItem", function(output) 
					if output then
						npcheading = GetEntityHeading(npcPED)
						SetEntityHeading(playerPed, npcheading+180)
						animasyon(playerPed, "mp_common", "givetake1_a")
						animasyon(npcPED, "mp_common", "givetake1_a")
						TriggerServerEvent("kaves_drugs:removeItem", randomItem, itemCount)
						TriggerServerEvent("kaves_drugs:giveMoney", randomMoney)
						Citizen.Wait(1000)
						newPed = npcPED
						FreezeEntityPosition(newPed, false)
						TaskWanderStandard(newPed, 1, 10)
						npcPED = nil
						npcfound = false
						Citizen.Wait(15000)
						DeleteEntity(newPed)
						newPed = nil
					else
						animasyon(playerPed, "gestures@m@standing@casual", "gesture_damn")
						newPed = npcPED
						FreezeEntityPosition(newPed, false)
						TaskWanderStandard(newPed, 1, 10)
                        exports['mythic_notify']:SendAlert('inform', 'The customer did not like you because you did not have the goods...')
						npcPED = nil
						npcfound = false
						Citizen.Wait(15000)
						DeleteEntity(newPed)
						newPed = nil
					end
				end, randomItem, tonumber(itemCount))
			end
			if cancelcorner then
				cancelcorner = false
				break
			end
		end
        Citizen.Wait(1)
    end
end)

function DrawText3Ds(x, y, z, scale, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    -- local scale = 0.35
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 490
        --DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
    end
end

function animasyon(ped, dict, anim)
	ESX.Streaming.RequestAnimDict(dict, function()
		TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 0, 0, 0, 0, 0)
	end)
end

function dt(table, nb)
    if nb == nil then
        nb = 0
    end

    if type(table) == 'table' then
        local s = ''
        for i = 1, nb + 1, 1 do
            s = s .. "    "
        end

        s = '{\n'
        for k,v in pairs(table) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            for i = 1, nb, 1 do
                s = s .. "    "
            end
            s = s .. '['..k..'] = ' .. dt(v, nb + 1) .. ',\n'
        end

        for i = 1, nb, 1 do
            s = s .. "    "
        end

        return s .. '}'
    else
        return tostring(table)
    end
end