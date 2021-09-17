ESX = nil
local PlayerData = {}
local refreshPed = false
local startSpawn, refreshJob = false, false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local blips2 = {
    -- Example {title="", colour=, id=, x=, y=, z=},
     {title="Recycle Center", colour=47, id=569, x = 746.822, y = -1399.622, z = 26.60071},
  }
Citizen.CreateThread(function()

    for _, info in pairs(blips2) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

--[ NPC Spawning -- ]

-- Spawn NPC if close by
Citizen.CreateThread(function()
    while true do
    Wait(1000)
        if refreshPed then
            if DoesEntityExist(buyPed) then
            exports['labrp_Eye']:AddEntityZone('buyPed', buyPed, {
            name="buyPed",
            debugPoly=false,
            useZ = true
              }, {
              options = {
                {
                event = "labrp-recycle:sendExhangeServer",
                icon = "fas fa-recycle",
                label = "Recycle Items",
                },
              },
                job = {"all"},
                distance = 1.5
              })
            refreshPed = false
            end
        end
    end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
      local pedCoords = GetEntityCoords(GetPlayerPed(-1))
      local dst2 = #(Config.pedLocation - pedCoords)
      if dst2 < 200 and startSpawn == false then
        TriggerEvent('labrp-recycle:spawnPed',Config.pedLocation, 180.0)
        startSpawn = true
        refreshPed = true
      end
      if dst2 >= 201  then
        if DoesEntityExist(buyPed) then
          DeletePed(buyPed)
        end
        startSpawn = false
      end
  end
end)

-- Spawn the actual NPC
RegisterNetEvent('labrp-recycle:spawnPed')
AddEventHandler('labrp-recycle:spawnPed',function(coords, heading)
  local hash = -294281201
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  buyPed = CreatePed(5, hash, coords, heading, false, false)
  FreezeEntityPosition(buyPed, true)
  SetEntityInvincible(buyPed, true)
  SetBlockingOfNonTemporaryEvents(buyPed, true)
  SetModelAsNoLongerNeeded(hash)
end)

-- Tell labrp_Eye to send server side

RegisterNetEvent('labrp-recycle:sendExhangeServer')
AddEventHandler('labrp-recycle:sendExhangeServer', function()
TriggerServerEvent('labrp-recycle:exhangeItems')
end)

-- [ End NPC Stuff ]