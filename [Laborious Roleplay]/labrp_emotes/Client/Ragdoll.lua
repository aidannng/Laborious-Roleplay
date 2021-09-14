local isInRagdoll = false


RegisterCommand('ragdoll', function()
    if not isInRagdoll and IsPedOnFoot(PlayerPedId()) then
      isInRagdoll = true
      repeat
        SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
        Citizen.Wait(10)
      until not isInRagdoll
    else
      isInRagdoll = false
    end
    
end)

TriggerEvent("chat:removeSuggestion", "/ragdoll")

-- Keybind
RegisterKeyMapping('ragdoll', 'Ragdoll Player', 'keyboard', 'u')

