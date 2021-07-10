Config = {

--BLIPS FOR JOB CENTERS
BlipCenterSprite = 181,
BlipCenterColor = 3,
BlipCenterText = 'City Hall',

MarkerSprite = 27,
MarkerColor = {66, 135, 245},
MarkerSize = 1.1,

LocationsJobCenters = { -- If you want you can setup locations to change jobs (Leave without entiries if you dont want locations) (ADDS 0.02 MS)
	{coords = vector3(-543.7846, -204, 38.21021), blip = true}
},

--Boss menu locations
BossMenuLocations = {
	{coords = vector3(463.2527, -985.5428, 30.71204), job = "police", label = "LSPD"},
	{coords = vector3(-339.033, -157.6615, 44.57947), job = "mechanic", label = "LS Customs"},
	{coords = vector3(-22.28571, -1101.732, 26.36487), job = "cardealer", label = "PDM"},
	{coords = vector3(1398.066, 1153.055, 114.3209), job = "mafia", label = "Mafia"},
	{coords = vector3(990.1055, -136.3648, 74.06665), job = "bigdogs", label = "Big Dogs"},
	{coords = vector3(-1351.886, -1054.932, 3.853516), job = "bmf", label = "Black Mafia Family"}
},



--Boss menu users by grade name and their permissions
-- NOTE BY AIDAN PLEASE READ >> In the database some ranks need a unique name if there is a supde. For example mechanic & pdm both have ceo so in database name one mechceo and the other pdmceo
-- NOTE BY AIDAN PLEASE READ >> In the database some ranks need a unique name if there is a supde. For example mechanic & pdm both have ceo so in database name one mechceo and the other pdmceo
-- NOTE BY AIDAN PLEASE READ >> In the database some ranks need a unique name if there is a supde. For example mechanic & pdm both have ceo so in database name one mechceo and the other pdmceo
BossMenuUsers = {

	['mechceo'] = {canWithdraw = true, canDeposit = true, canHire = true, canRank = true, canFire = true, canBonus = true},
	['mechowner'] = {canWithdraw = true, canDeposit = true, canHire = true, canRank = true, canFire = true, canBonus = true},
	['pdmowner'] = {canWithdraw = true, canDeposit = true, canHire = true, canRank = true, canFire = true, canBonus = true},
	['mafiaboss'] = {canWithdraw = true, canDeposit = true, canHire = true, canRank = true, canFire = true, canBonus = true},
	['bigdogspresident'] = {canWithdraw = true, canDeposit = true, canHire = true, canRank = true, canFire = true, canBonus = true},
	['chief'] = {canWithdraw = true, canDeposit = true, canHire = true, canRank = true, canFire = true, canBonus = true},
	['asstchief'] = {canWithdraw = false, canDeposit = false, canHire = true, canRank = true, canFire = true, canBonus = false},
	['bmfboss'] = {canWithdraw = true, canDeposit = true, canHire = true, canRank = true, canFire = true, canBonus = true},
},


DefaultJobsInJobCenter = { -- Jobs that can be added by going to the job center. For icons use https://fontawesome.com/

    {job = 'unemployed', label = "Unemployed", icon = "fas fa-bed", description = "I mean, who said you had to work?"},
	--{job = 'miner', label = "Miner", icon = "fas fa-gem", description = "You mine materials and then you can sell them!"},
	--{job = 'slaughterer', label = "Butcher", icon = "fas fa-drumstick-bite", description = "You butcher animals and sell the packaged meat!!"},
	{job = 'garbage', label = "Garbage", icon = "fas fa-trash", description = "You collect garbage & clean the streets of Los Santos!"},
	{job = 'busdriver', label = "Bus Driver", icon = "fas fa-bus", description = "Drive your own custom bus routes around the city!"},
	{job = 'tow', label = "Tow", icon = "fas fa-wrench", description = "Tow some vehicles parked illegally"},
	{job = 'trucker', label = "Trucking", icon = "fas fa-truck", description = "You drive your Truck statewide and deliver items!"},
	{job = 'mail', label = "Mail Delivery", icon = "fas fa-mail-bulk", description = "Be a helpful citizen and deliver mail around the county!"},
},


Text = {

	['open_jobcenter_ui_hologram'] = '[~b~E~w~] Open Job Center',
	['promoted'] = 'You have been promoted',
	['promoted_other'] = 'You have been promoted in another job!',
	['fired'] = 'You have been fired',
	['fired_other'] = 'You have been fired',
	['hired'] = 'You have been hired',
	['bossmenu_hologram'] = '[~b~E~w~] Open Boss Menu',
	['action_success'] = 'Action successful',
	['action_unsuccessful'] = 'Action unsuccessful',
	['cant_access_bossmenu'] = 'You cant access boss menu',
	['insufficent_balance'] = 'Insufficent balance',
	['bonus_given'] = 'Bonus has been given!',
	['bonus_recieved'] = 'You recieved a bonus! +$'

}
	

}

function SendTextMessage(msg)

	exports['mythic_notify']:SendAlert('inform', msg)

end
