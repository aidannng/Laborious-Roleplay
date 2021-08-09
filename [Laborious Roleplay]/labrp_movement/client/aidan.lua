local isHandsup = false
local isCrouched = false

Citizen.CreateThread(function()
  RequestAnimDict('missminuteman_1ig_2')
    while not HasAnimDictLoaded('missminuteman_1ig_2') do
        Citizen.Wait(50)
    end
 while true do
    Citizen.Wait(10)
  end
end)

Citizen.CreateThread(function()
  RequestAnimSet('move_ped_crouched')
  while not HasAnimSetLoaded('move_ped_crouched') do
    Citizen.Wait(50)
  end

  while true do
    Citizen.Wait(10)
    DisableControlAction(0, 36, true)
  end
end)

RegisterCommand('handsup', function()
  if isDead then
    exports['mythic_notify']:SendAlert('error', "You're dead m8!")
  else
    if isHandsup then
      ClearPedTasks(PlayerPedId())
      isHandsup = false
    else
      if not IsInAnimation then
        isHandsup = true
        TaskPlayAnim(PlayerPedId(), "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
      else
        EmoteCancel()
      end
    end
  end
end)

RegisterCommand('crouch', function()
  if not IsPauseMenuActive() and not IsEntityDead(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), true) then
    if isCrouched then
      ResetPedMovementClipset(PlayerPedId(), 0)
      isCrouched = false
    else
      SetPedMovementClipset(PlayerPedId(), 'move_ped_crouched', 0.25)
      isCrouched = true
    end
  end
end)

RegisterKeyMapping('handsup', 'Put Your Hands Up', 'keyboard', 'X')
RegisterKeyMapping('crouch', 'Toggle Crouch', 'keyboard', 'C')