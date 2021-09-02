ESX = nil

local PlayerJob
local userRep = 0
local canSell = true
local soldto = {}
local ped
local pedID

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerJob = ESX.GetPlayerData().job
    Wait(100)
    ESX.TriggerServerCallback("gl-drugselling:getUserRep", function(reputation)
        userRep = reputation
    end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerJob = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer

end)


Citizen.CreateThread(function()

    local allgangs = {
        `g_f_y_ballas_01`,
        `g_m_y_ballaeast_01`,
        `g_m_y_ballaorig_01`,
        `g_m_y_ballasout_01`,
        `g_f_y_families_01`,
        `g_m_y_famca_01`,
        `g_m_y_famdnf_01`,
        `g_m_y_famfor_01`,
        `g_f_y_vagos_01`,
        `g_m_y_mexgoon_01`,
        `g_m_y_mexgoon_02`,
        `g_m_y_mexgoon_03`,        
    }

    exports['labrp_Eye']:AddTargetModel(allgangs, {
        options = {
            {
                event = "gl-drugselling:checksellcops",
                icon = "fas fa-hand-paper",
                label = "Sell Drugs",
            },

        },
        job = {"all"},
        distance = 2.5
    })
end)

-- Updating the users reputation client side after a sale, and triggering the sale animations

RegisterNetEvent('gl-drugselling:updateUserRep')
AddEventHandler('gl-drugselling:updateUserRep',function(addRep)
    userRep = userRep + addRep
    local player = GetPlayerPed(-1)
        SetEntityAsMissionEntity(ped)
        ClearPedTasks(ped)
        TaskTurnPedToFaceEntity(ped,player,10000)                               
        playerAnim()
        Wait(2000)
        giveAnim()
        Wait(5000)
        SetEntityAsMissionEntity(ped)
        SetPedAsNoLongerNeeded(ped)
        FreezeEntityPosition(ped,false)
end)

-- Notify the police of a drug sale
RegisterNetEvent('gl-drugselling:notifyPolice')
AddEventHandler('gl-drugselling:notifyPolice',function()
    local coords = GetEntityCoords(PlayerPedId())
    exports['core_dispatch']:addCall('10-17', "Suspicious Activity", {
        {icon="fa-cannabis", info="Possible Drug Sales"}
        }, {coords.x, coords.y, coords.z}, "police", 10000, 514, 1)
end)

-- Functions for things
function GetCurrentStreetName()
    local pedCoords = GetEntityCoords(PlayerPedId())

    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(pedCoords["x"], pedCoords["y"], pedCoords["z"], currentStreetHash, intersectStreetHash)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

    return currentStreetName
end

-- Called to add Ped ID to a table to prevent reselling
function addToSet(set, key)
    set[key] = true
end

-- Called to check if the Ped ID exists in the set table
function tableHasKey(table,key)
    return table[key] ~= nil
end

-- End Functions

-- Ignore the name, this is the event called to check if you're able to sell drugs 
RegisterNetEvent('gl-drugselling:checksellcops')
AddEventHandler('gl-drugselling:checksellcops',function()
    TriggerServerEvent('checksellcops')
end)

RegisterNetEvent('gl-drugselling:checkBallaSell')
AddEventHandler('gl-drugselling:checkBallaSell',function()
if userRep == 0 then
    ESX.TriggerServerCallback("gl-drugselling:getUserRep", function(reputation)
        userRep = reputation
    end)
end

ped = GetPedInFront()
pedID = PedToNet(ped)
local alreadySold = tableHasKey(soldto,pedID)
if alreadySold then
exports['mythic_notify']:SendAlert('error', "Im not intrested.", 8500) 
else
    local CallDaPolice = math.random(1, 8)
    if CallDaPolice == 8 then
        TriggerEvent('gl-drugselling:notifyPolice')
    end
    if not IsPedDeadOrDying(ped) then
        addToSet(soldto,pedID)
        local drug = math.random(1,#Config.DrugList)
            if userRep > Config.MaxReputation then
                TriggerServerEvent('gl-drugselling:checkDrugs',drug,Config.MaxReputation)
            else
                TriggerServerEvent('gl-drugselling:checkDrugs',drug,userRep)
            end
    end  
end  


end)

-- More Functions 
-- TO load the animation libraries
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

--Triggers animation for the player
function playerAnim()
    loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

-- Triggers the animation for the ped
function giveAnim()
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( ped, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

-- Used to grab the ID of the Ped infront of the player
function GetPedInFront()
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
    local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
    local _, _, _, _, ped = GetShapeTestResult(rayHandle)
    return ped
end

-- End Functions


-- I call this in my Jail script whenever someone goes to Jail, but added it here for you to do what you wish with.
RegisterNetEvent('gl-drugselling:removeRep')
AddEventHandler('gl-drugselling:removeRep',function()
local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
if closestPlayer == -1 or closestDistance > 3.0 then

else
TriggerServerEvent('gl-drugselling:removeReputation',GetPlayerServerId(closestPlayer))
end
end)

--TO REMOVE REP CLIENT SIDE, Use something like this in your Jail Script
--[[
local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
if closestPlayer == -1 or closestDistance > 3.0 then

else
TriggerServerEvent('gl-drugselling:removeReputation',GetPlayerServerId(closestPlayer))
end
]]
