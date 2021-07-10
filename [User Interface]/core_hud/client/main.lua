local hunger = 0
local thirst = 0
local stress = 0
local voiceRadius = 50
local istalking = false

local voiceToggled = false
local UIHidden = false
local UIRadar = false

RegisterNetEvent("core_hud:BigBoiStart")
AddEventHandler("core_hud:BigBoiStart", function()
    Citizen.CreateThread(
        function()
            DisplayHud(true)
            Citizen.Wait(10)
            RequestStreamedTextureDict("circlemap", false)
            while not HasStreamedTextureDictLoaded("circlemap") do
                Wait(10)
            end
            
            AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

            SetMinimapClipType(1)
            SetMinimapComponentPosition("minimap", "L", "B", 0.025, -0.03, 0.153, Config.MapZoom)
            SetMinimapComponentPosition("minimap_mask", "L", "B", 0.135, 0.12, 0.093, 0.164)
            SetMinimapComponentPosition("minimap_blur", "L", "B", 0.012, 0.022, 0.256, 0.337)

            local minimap = RequestScaleformMovie("minimap")

            SetRadarBigmapEnabled(true, false)
            Citizen.Wait(10)
            SetRadarBigmapEnabled(false, false)

            Citizen.Wait(10)

            SendNUIMessage(
                {
                    type = "Init",
                    healthIcon = Config.HealthIcon,
                    armorIcon = Config.ArmorIcon,
                    foodIcon = Config.FoodIcon,
                    thirstIcon = Config.ThirstIcon,
                    fourthIcon = Config.FourthIcon,
                    showid = Config.DisplayId,
                    showstress = Config.DisplayStress,
                    showvoice = Config.DisplayVoice
                }
            )

            while true do
                Wait(0)
                BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
                ScaleformMovieMethodAddParamInt(3)
                EndScaleformMovieMethod()

                if Config.DisplayVoice then
                  local netTalk = NetworkIsPlayerTalking(PlayerId()) or talking
                
                    if netTalk  ~= voiceToggled then
              
                    SendNUIMessage(
                        {
                            type = "toggleTalking",
                            talking = netTalk
                        }
                    )
                    voiceToggled = netTalk
                    end
                end
            end
        end
    )

        
    

    
end)

RegisterNetEvent("core_hud:HideOldShit")
AddEventHandler("core_hud:HideOldShit", function()
Citizen.CreateThread
    (function()
	    while true do
		Citizen.Wait(0)
            HideHudComponentThisFrame(3) -- CASH
            HideHudComponentThisFrame(4) -- MP CASH
            HideHudComponentThisFrame(2) -- weapon icon
            HideHudComponentThisFrame(9) -- STREET NAME
            HideHudComponentThisFrame(7) -- Area NAME
            HideHudComponentThisFrame(8) -- Vehicle Class
            HideHudComponentThisFrame(6) -- Vehicle Name
	    end
    end)
end)

RegisterNetEvent("core_hud:StatusUpdate")
AddEventHandler("core_hud:StatusUpdate", function()
    Citizen.CreateThread(
        function()
            while true do
                Citizen.Wait(Config.StatusUpdateInterval)

                GetStatus(
                    function(result)
                        hunger = result[1]
                        thirst = result[2]
                        stress = result[3]
                    end    
                )
            end 
        end
    )

end)  

RegisterNetEvent("core_hud:StartInfo")
AddEventHandler("core_hud:StartInfo", function()
    Citizen.CreateThread(
        function()
            while true do


                Citizen.Wait(Config.VitalsUpdateInterval)
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(ped)
                local health = GetEntityHealth(ped) - 100
                local armor = GetPedArmour(ped)
                local serverid = GetPlayerServerId(PlayerId())
                local pauseMenu = IsPauseMenuActive()

                SendNUIMessage(
                    {
                        type = "changeStatus",
                        health = health,
                        armor = armor,
                        food = hunger,
                        thirst = thirst,
                        id = serverid,
                        stress = stress,
                        voice = voiceRadius
                    }
                )
                if pauseMenu and not UIHidden then
                      SendNUIMessage(
                            {
                                type = "hideUI"
                            }
                        )
                     UIHidden = true
                elseif UIHidden and not pauseMenu then
                     SendNUIMessage(
                            {
                                type = "showUI"
                            }
                        )
                    UIHidden = false
                end

                if not Config.AlwaysDisplayRadar then
                    if vehicle ~= 0 and UIRadar then
                        SendNUIMessage(
                            {
                                type = "openMapUI"
                            }
                        )
                        DisplayRadar(true)
                        UIRadar = false
                    elseif not UIRadar and vehicle == 0 then
                        SendNUIMessage(
                            {
                                type = "closeMapUI"
                            }
                        )
                        UIRadar = true
                        DisplayRadar(false)
                    end
                else
                    DisplayRadar(true)
                end

            end
        end        
    )

end) 

AddEventHandler('playerSpawned', function()
    TriggerEvent("core_hud:BigBoiStart")
    Citizen.Wait(100)
    TriggerEvent("core_hud:HideOldShit")
    Citizen.Wait(100)
    TriggerEvent("core_hud:StatusUpdate")
    Citizen.Wait(100)
    TriggerEvent("core_hud:StartInfo")
end)

RegisterCommand("fixHud", function()
    TriggerEvent("core_hud:BigBoiStart")
    TriggerEvent("core_hud:HideOldShit")
    TriggerEvent("core_hud:StatusUpdate")
    TriggerEvent("core_hud:StartInfo")
end)

--EXPORTS

exports(
    "setTalking",
    function(talking)
        istalking = talking
    end
)

exports(
    "setVoiceRange",
    function(percent)
        voiceRadius = percent
    end
)