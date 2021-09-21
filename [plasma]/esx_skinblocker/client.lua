local PlayerData = {}
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

local removeTop = {['tshirt_1'] = 57}
local removeHat = {['helmet_1'] = -1}
local removeTorso = {['torso_1'] = 53}
local removeEars = {['ears_1'] = -1}

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5000)
		TriggerEvent('skinchanger:getSkin', function(skin)
            -- if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' then
            -- 	if skin.tshirt_1 == 129 then
			-- 		TriggerEvent('skinchanger:loadClothes', skin, removeTop)
            --         exports['mythic_notify']:SendAlert('error', 'You cannot wear police equipment')
            --     end                              
            -- end
            if skin.helmet_1 == 52 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 53 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 54 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 55 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 56 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 57 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 71 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 73 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 74 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 75 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 76 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 77 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 78 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 79 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 82 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 83 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 84 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 89 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 90 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 91 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 92 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 93 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 94 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 96 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 97 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 115 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 116 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 119 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 120 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 121 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 122 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 123 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 129 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 130 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 131 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 132 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 148 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
            if skin.helmet_1 == 154 then
			    TriggerEvent('skinchanger:loadClothes', skin, removeHat)
                exports['mythic_notify']:SendAlert('error', 'You cannot wear Bullet-Resistant Helmets.')
            end
		end)
	end
end)