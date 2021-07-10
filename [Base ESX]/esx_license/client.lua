Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/addweaponlicense', 'Gives someone a weapon license', {{ name="ID", help="ID Of the player you want to give a weapon license to"}})
end)