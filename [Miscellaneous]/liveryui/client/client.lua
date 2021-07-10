    
local opened = false
 ESX = nil

 
 Citizen.CreateThread(function()
     while ESX == nil do
         TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
         Citizen.Wait(0)
     end
 end)

 
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    local PlayerData = ESX.GetPlayerData()
	PlayerData.job = job
end)



CreateThread(function()
    RegisterCommand("clothMenu", OpenClothUi)
    RegisterKeyMapping("clothMenu", "Livery  Menu", "keyboard", "R")
end)

OpenClothUi = function()
    if not opened then
        local PlayerData = ESX.GetPlayerData()
        -- print('2')
        if PlayerData.job.name == "police" and IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) and GetVehicleBodyHealth(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) >= 1000 then
            
    
         SendNUIMessage({action = 'showui'})
            SetNuiFocus(true, true)
            SendNUIMessage({action = 'showMenu'})
            opened = true
        else
            
        end
    else

    -- print('31')
    if SendNUIMessage({action = 'hideui'}) then
        SetNuiFocus(false, false)
        opened = false
    end
end
end


RegisterNUICallback('CloseMenu:NuiCallback', function(data)

    if data.data then
        opened = false
        SetNuiFocus(false, false)
    end
end)




RegisterNUICallback('livery:0', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleMod(vehicle, 48 , 0)
else
    ESX.ShowNotification('U are not in car')
end
end)

RegisterNUICallback('livery:1', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleMod(vehicle, 48 , 1)
else
   ESX.ShowNotification('U are not in car')
end
end)
RegisterNUICallback('livery:2', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleMod(vehicle, 48 , 2)
else
   ESX.ShowNotification('U are not in car')
end
end)

RegisterNUICallback('livery:3', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleMod(vehicle, 48 , 3)
else
   ESX.ShowNotification('U are not in car')
end
end)

RegisterNUICallback('livery:-1', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleMod(vehicle, 48 , -1)
else
   ESX.ShowNotification('U are not in car')
end
end)


RegisterNUICallback('extra:1', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 1, 0)
else
   ESX.ShowNotification('U are not in car')
end
end)


RegisterNUICallback('extra:2', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 2, 0)
else
   ESX.ShowNotification('U are not in car')
end
end)
RegisterNUICallback('extra:3', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 3, 0)
else
   ESX.ShowNotification('U are not in car')
end
end)
RegisterNUICallback('extra:4', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 4, 0)
else
   ESX.ShowNotification('U are not in car')
end
end)
RegisterNUICallback('extra:5', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 5, 0)
else
   ESX.ShowNotification('U are not in car')
end
end)
RegisterNUICallback('extra:6', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 6, 0)
else
   ESX.ShowNotification('U are not in car')
end
end)
RegisterNUICallback('extra:7', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 7, 0)
else
   ESX.ShowNotification('U are not in car')
end
end)
RegisterNUICallback('extra:8', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 8, 0)
else
   ESX.ShowNotification('U are not in car')
end
end)


RegisterNUICallback('extra:-1', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 1, 1)
else
   ESX.ShowNotification('U are not in car')
end
end)

RegisterNUICallback('extra:-2', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 2, 1)
else
   ESX.ShowNotification('U are not in car')
end
end)



RegisterNUICallback('extra:-3', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 3, 1)
else
   ESX.ShowNotification('U are not in car')
end
end)


RegisterNUICallback('extra:-4', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 4, 1)
else
   ESX.ShowNotification('U are not in car')
end
end)

RegisterNUICallback('extra:-5', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 5, 1)
else
   ESX.ShowNotification('U are not in car')
end
end)

RegisterNUICallback('extra:-6', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 6, 1)
else
   ESX.ShowNotification('U are not in car')
end
end)

RegisterNUICallback('extra:-7', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 7, 1)
else
    ESX.ShowNotification('U are not in car')
end
end)

RegisterNUICallback('extra:-8', function (data)
    local src = source
    local player = GetPlayerPed()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed())

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
--   local player = GetPlayerPed(src)
 if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
    SetVehicleExtra(vehicle , 8, 1)
else
    ESX.ShowNotification('U are not in car')
end
end)
