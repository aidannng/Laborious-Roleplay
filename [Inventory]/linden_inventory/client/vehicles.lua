-- 0	vehicle has no storage
-- 1	vehicle storage in the hood
Config.VehicleStorage = {
	[`jester`]=1, 
	[`adder`]=1, 
	[`osiris`]=0, 
	[`pfister811`]=0, 
	[`penetrator`]=0, 
	[`autarch`]=0, 
	[`bullet`]=0, 
	[`cheetah`]=0, 
	[`cyclone`]=0, 
	[`voltic`]=0, 
	[`reaper`]=1, 
	[`entityxf`]=0, 
	[`t20`]=0, 
	[`taipan`]=0, 
	[`tezeract`]=0, 
	[`torero`]=1, 
	[`turismor`]=0, 
	[`fmj`]=0, 
	[`infernus `]=0, 
	[`italigtb`]=1, 
	[`italigtb2`]=1, 
	[`nero2`]=0, 
	[`vacca`]=1, 
	[`vagner`]=0, 
	[`visione`]=0, 
	[`prototipo`]=0, 
	[`zentorno`]=0
}


-- slots, maxWeight; default weight is 8000 per slot
Config.Gloveboxes = {	
	[0] = {10, 10000}, -- compact
	[1] = {10, 10000}, -- sedan
	[2] = {10, 10000}, -- suv
	[3] = {10, 10000}, -- coupe
	[4] = {10, 10000}, -- muscle
	[5] = {10, 10000}, -- sports classic
	[6] = {10, 10000}, -- sports
	[7] = {10, 10000}, -- super
	[8] = {5, 5000}, -- motorcycle
	[9] = {10, 10000}, -- offroad
	[10] = {10, 10000}, -- industrial
	[11] = {10, 10000}, -- utility
	[12] = {10, 10000}, -- van
	[14] = {15, 248000}, -- boat
	[15] = {15, 248000}, -- helicopter
	[16] = {30, 408000}, -- plane
	[17] = {10, 88000}, -- service
	[18] = {10, 88000}, -- emergency
	[19] = {10, 88000}, -- military
	[20] = {10, 88000} -- commercial (trucks)
}

Config.Trunks = {
	[0] = {20, 60000}, -- compact
	[1] = {40, 80000}, -- sedan
	[2] = {50, 100000}, -- suv
	[3] = {30, 70000}, -- coupe
	[4] = {40, 70000}, -- muscle
	[5] = {30, 60000}, -- sports classic
	[6] = {30, 60000}, -- sports
	[7] = {20, 40000}, -- super
	[8] = {5,  10000},-- motorcycle
	[9] = {50, 150000}, -- offroad
	[10] = {50, 200000}, -- industrial
	[11] = {40, 328000}, -- utility
	[12] = {60, 300000}, -- van
	--[14] -- boat
	--[15] -- helicopter
	--[16] -- plane
	[17] = {40, 328000}, -- service
	[18] = {40, 328000}, -- emergency
	[19] = {40, 328000}, -- military
	[20] = {80, 600000} -- commercial
}
