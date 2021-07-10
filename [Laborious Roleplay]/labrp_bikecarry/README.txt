Add the following to bt-target

Citizen.CreateThread(function()

local bike = {
    `bmx`,
    `cruiser`,
    `scorcher`,
    `fixter`,
    `tribike`,
    `tribike2`,
    `tribike3,
}
AddTargetModel(bike, {
    options = {
        {
            event = "pickup:bike",
            icon = "fas fa-bicycle",
            label = "Pickup Bike",
        },
    },
    job = {"all"},
    distance = 2.5
})

end)