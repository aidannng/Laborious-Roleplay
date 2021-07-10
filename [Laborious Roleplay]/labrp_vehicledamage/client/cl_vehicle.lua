
local DMGAmount = 910.0 
local unluck = 930.0
local NiceOne = 250.0


IsValidVehicle = function(veh)
    local model = GetEntityModel( veh )

    if ( IsThisModelACar( model ) or IsThisModelABike( model ) or IsThisModelAQuadbike( model ) ) then  
        return true 
    else 
        return false 
    end 
end 

RandomNumber = function()
    Citizen.Wait(2099)
    return math.random(1,50)
end

local bitch = 25
 
breakit = function(currentVehicle)
    SetVehicleEngineOn( currentVehicle, false, true )
      SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
      SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
      SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
      SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
end


BeginDmg = function(currentVehicle)
    SetVehicleEngineHealth( currentVehicle, 300.0 )
end


LowBro = function(currentVehicle)
    SetVehicleEngineHealth( currentVehicle, 0.0 )
    breakit(currentVehicle)
end

unluckBro = function(currentVehicle)
    SetVehicleEngineHealth( currentVehicle, 0.0 )
    breakit(currentVehicle)
end


Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(1000)
        local playerPed = GetPlayerPed( -1 )
        local currentVehicle = GetVehiclePedIsIn(playerPed, false)
        local damage = GetVehicleEngineHealth( currentVehicle )

        if damage < DMGAmount and damage > 400.0 and IsValidVehicle(currentVehicle) then
            BeginDmg(currentVehicle)
        elseif damage < NiceOne and IsValidVehicle(currentVehicle) then
            LowBro(currentVehicle)
        elseif damage < unluck and damage > 300.0 and IsValidVehicle(currentVehicle) then
            if bitch == RandomNumber() then
                unluckBro(currentVehicle)
            end
        end
    end
end)





--[[------------------------------------------------------------------------
    Vehicle Fix
------------------------------------------------------------------------]]--
RegisterNetEvent( 'veh:fixVehicle' )
AddEventHandler( 'veh:fixVehicle', function() 
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                local timer = 50000
                local finished = exports["cn-taskbar"]:taskBar(timer,"Completing Task")

                if finished == 100 then
                    SetVehicleEngineHealth( vehicle, 1000 )
                    SetVehicleEngineOn( vehicle, true, true )
                    SetVehicleFixed( vehicle )
                end
            end  
        end 
    end 
end )


-- Air Control
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            local roll = GetEntityRoll(veh)
            -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(veh) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end
            if (roll > 75.0 or roll < -75.0) then
                DisableControlAction(2,59,true)
                DisableControlAction(2,60,true)
            end
        end
    end
end)