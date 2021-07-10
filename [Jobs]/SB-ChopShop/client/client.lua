ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Notes: Use ChopRandom for function of math random
Citizen.CreateThread( function()
	while true do
		ChopRandom = math.random(1,4)
		Citizen.Wait(1800000)
	end
	-- body
end)

local ChopLocation = vector3(1204.378, -3116.822, 5.263062)
local source = GetPlayerPed( -1 )


Citizen.CreateThread(function()
    local chopPos = vector3(ChopLocation['x'],ChopLocation['y'],ChopLocation['z'])
    while true do
        local ped = GetPlayerPed( -1 )
        local sleep = 200
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distCheck =  #(vector3(ChopLocation['x'],ChopLocation['y'],ChopLocation['z']) - playerCoords)
        if distCheck <= 50 then
            sleep = 20
            if distCheck > 5.1 and distCheck < 8.1 then 
                exports['cd_drawtextui']:HideInteraction()
            
            elseif distCheck <= 5 and IsPedInAnyVehicle(ped, false) then
                sleep = 5
                --DrawText3Ds(ChopLocation['x'],ChopLocation['y'],ChopLocation['z'],'[E] To Chop Vehicle')
                --TriggerEvent('cd_drawtextui:ShowUI', 'show', '<strong>[E]</strong> To Chop Vehicle', 'red')
                exports['cd_drawtextui']:ShowInteraction('show', 'green', "[E] To Chop Vehicle")
                if IsControlJustPressed(0, 38) then
                    local car = GetVehiclePedIsIn(ped, false)
                    local hash = GetEntityModel(car)
                    AllowChop(hash)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)


RegisterNetEvent('CheckDist')
AddEventHandler('CheckDist', function(class)
	local ChopLocation = vector3(1204.378, -3116.822, 5.263062)
	local playerCoords = GetEntityCoords(PlayerPedId())
	local dist = #(vector3(ChopLocation['x'],ChopLocation['y'],ChopLocation['z']) - playerCoords)
	if dist < 2 then
		if class == 1 then 
			TriggerServerEvent('SB-ChopLow', source)
			TriggerEvent('Delete')
		elseif class == 2 then
			TriggerServerEvent('SB-ChopMed', source)
			TriggerEvent('Delete')
		elseif class  == 3 then
			TriggerServerEvent('SB-ChopHigh', source)
			TriggerEvent('Delete')
		elseif class == 4 then 
			TriggerServerEvent('SB-ChopExtreme', source)
			TriggerEvent('Delete')
		end
	end
end)


RegisterNetEvent('SB-GetList')
AddEventHandler('SB-GetList', function()
	GetChopList(source)
end)


RegisterNetEvent('Delete')
AddEventHandler('Delete', function()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)
    if IsPedSittingInAnyVehicle(ped)  then 
        SetEntityAsMissionEntity(vehicle, true, true)
        deleteCar(vehicle)
    end 
end)



Citizen.CreateThread(function()
    local chopshop = {
        `s_m_y_dealer_01`,
        }
        exports["labrp_Eye"]:AddTargetModel(chopshop, {
        options = {
        {
            event = "SB-GetList",
            icon = "fas fa-clipboard-list",
            label = "Get Chop List",
        },
        },
        job = {"all"},
        distance = 2.5
    }) 
end)