ESX = nil
local distancecheck = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local pendingmoney = 0


RegisterNetEvent('brinn_paycheck:SpawnPed')
AddEventHandler('brinn_paycheck:SpawnPed',function(model, coords, heading, animDict, animName)
	if distancecheck == false then
		RequestModel(GetHashKey(model))
		while not HasModelLoaded(GetHashKey(model)) do
			Citizen.Wait(1)
		end
		ped = CreatePed(5, GetHashKey(model), coords, heading, false, false)
		FreezeEntityPosition(ped, true) 
		SetEntityInvincible(ped, true) 
		SetBlockingOfNonTemporaryEvents(ped, true) 
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
end)



local bossMech = {
	`ig_vagspeak`,
}
exports['labrp_Eye']:AddTargetModel(bossMech, {
	options = {
		{
			event = "brinn_paycheck:Menu",
			icon = "fas fa-file-invoice",
			label = "Collect Paycheck",
		},
			
	},
	job = {"all"},
	distance = 3.5
})


RegisterNetEvent('brinn_paycheck:Menu')
AddEventHandler('brinn_paycheck:Menu',function()
	TriggerServerEvent('paycheck:getamount')
	exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = 1000,
        label = 'Getting Information',
        useWhileDead = true,
        canCancel = false,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        },
    })
	Citizen.Wait(1000)
	TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "City Hall",
            txt = ""
        },
		{
            id = 2,
            header = "Collect Paycheck",
            txt = "Money : $"..pendingmoney,
            params = {
                event = "withdraw:all",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('withdraw:all')
AddEventHandler('withdraw:all', function()
	TriggerServerEvent('brinn_paycheck:Payout')
end)

RegisterNetEvent('paycheck:pendingmoney')
AddEventHandler('paycheck:pendingmoney', function(newmoney)
	pendingmoney = newmoney
end)




