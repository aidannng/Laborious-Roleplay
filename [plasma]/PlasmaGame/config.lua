

lang = "EN" --Language selector, be sur that the language is created bellow

trad = {}

HaveCTFMode = false

--You can add other language if you want, just Follow the ENG model : (And send it to us so we can add it for later release)

trad["EN"] = {
	["CreateLob"] = "Press ~INPUT_CONTEXT~ to create a Lobby.",
	["JoinLob"] = "Press ~INPUT_CONTEXT~ to join a Lobby.",
	["LeaveGame"] = "Press ~INPUT_CONTEXT~ to leave the game.",
	
	["InvalidSession"] = "Invalid session name !",
	["InvalidPseudo"] = "Invalid Pseudo !",
	["modeUnavailable"] = "This gamemode is not available at this shop!",
	["modeUnavailable2"] = "This gamemode is not available on this map!",
	["mapUnavailable"] = "This maps is not available at this shop !",
	["LobbyCreated"] = "Lobby created ! will be deleted in 3 minutes if not launched",
	
	["Lobby"] = "~b~Lobby",
	["JoinLobby1"] = "Join ",
	["JoinLobby2"] = "'s lobby",
	["JoinBlue"] = "Join Blue ",
	["JoinRed"] = "Join Red ",
	
	["StartGame"] = "Start the Game",
	["StartGameDesc"] = "Only creator can launch the game",
	
	["Round"] = "~g~Round : ",
	["RoundDesc"] = "Don't shoot your allies!",
	
	["Tie"] = "~y~Tie",
	["TieDesc"] = "Game Ended in a Tie..",
	["Win"] = "~g~Victory !",
	["WinDesc"] = "Winner Winner Chicken Dinner!",
	["Loose"] = "~r~Defeat!",
	["LooseDesc"] = "Back to the Range you go.",
	
	["Leave"] = "Left Game",
	["LeaveDesc"] = "Coward..",
	
	["RoundTie"] = "~y~Tie !",
	["RoundTieDesc"] = "Surprising.",
	["RoundWin"] = "~g~You win !",
	["RoundWinDesc"] = "Keep up the good work!",
	["RoundLoose"] = "~r~You loose !",
	["RoundLooseDesc"] = "FOCUS UP AND GET BACK IN THERE!",

}
	
trad["FR"] = {
	["CreateLob"] = "Appuyez sur ~INPUT_CONTEXT~ pour creer une Session.",
	["JoinLob"] = "Appuyez sur  ~INPUT_CONTEXT~ pour rejoindre une Session.",
	["LeaveGame"] = "Appuyez sur ~INPUT_CONTEXT~ pour quitter la partie.",
	
	["InvalidSession"] = "Nom de session Invalide.",
	["InvalidPseudo"] = "Pseudo Invalide.",
	["modeUnavailable"] = "This gamemode is not available at this shop !",
	["modeUnavailable2"] = "This gamemode is not available on this map !",
	["mapUnavailable"] = "This gamemode is not available at this shop !",
	["LobbyCreated"] = "Session créée ! Suppression dans 3 minutes si la partie n'est pas lancée.",
	
	["Lobby"] = "~b~Session",
	["JoinLobby1"] = "Rejoindre la session de ",
	["JoinLobby2"] = "",
	["JoinBlue"] = "Rejoindre les bleus ",
	["JoinRed"] = "Rejoindre les rouges ",
	
	["StartGame"] = "Lancer la partie",
	["StartGameDesc"] = "Seul le créateur peux lancer la partie",
	["Round"] = "~g~Manche : ",
	["RoundDesc"] = "Ne tire pas sur tes alliés !",
	
	["Tie"] = "~y~Egalité",
	["TieDesc"] = "Pas de chance : égalité",
	["Win"] = "~g~Victoire !",
	["WinDesc"] = "Tu es génial !",
	["Loose"] = "~r~Défaite !",
	["LooseDesc"] = "Looser !",
	
	["Leave"] = "Peureux !",
	["LeaveDesc"] = "La fuite n'est pas une solution.",
	
	["RoundTie"] = "~y~Egalité !",
	["RoundTieDesc"] = "Etonnant.",
	["RoundWin"] = "~g~Manche gagnée !",
	["RoundWinDesc"] = "Continue comme ca !",
	["RoundLoose"] = "~r~Manche perdu !",
	["RoundLooseDesc"] = "Réveille toi ! ",
}

-- You can modify this to use your own Notification system
function notification(msg,typeOfNotif)
	if typeOfNotif == "success" then
		SetNotificationTextEntry("STRING")
		AddTextComponentString("~g~"..msg)
		DrawNotification(true, false)
		
	elseif typeOfNotif == "info" then
		SetNotificationTextEntry("STRING")
		AddTextComponentString(msg)
		DrawNotification(true, false)
		
	elseif typeOfNotif == "error" then
		SetNotificationTextEntry("STRING")
		AddTextComponentString("~r~"..msg)
		DrawNotification(true, false)
	end
	
end




GunName = "WEAPON_PLASMAP" --The Gun used in game. You can have weird issue if you use classic GTA Weapon, I recommend to use modded ADDON (no replace) gun.
GunDamage = 2.0 -- The damage that the gun Deal. You have to put here the damage that the gun deal, its used to heal player after taking a shot.

Maps = {

	["Patoche"] = {
	["CTF"] = true, -- Is Capture the Flag available on this map ?
	["TDM"] = true, -- Is Team Death Match available on this map ?
	
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x=-1183.4421386719,y=-1251.1754150391,z=-81.970603942871},
	["redCoords"] = 	{x=-1120.9388427734,y=-1225.8797607422,z=-81.970520019531},
	["blueFlagCoords"] ={x=-1185.8768310547,y=-1256.5980224609,z=-79.736183166504,h=345.3586730957},
	["redFlagCoords"] = {x=-1118.5631103516,y=-1219.6202392578,z=-79.74577331543,h=75.650482177734},
	["mapRedOutCoords"] = {{x=-1121.7076416016,y=-1231.3385009766,z=-79.970596313477,h=176.43196105957}},
	["mapBlueOutCoords"] = {{x=-1183.0317382812,y=-1242.7570800781,z=-79.970611572266,h=2.2128314971924}},
	},
	
	-- ["MarcMLO"] = {
	-- ["CTF"] = true, -- Is Capture the Flag available on this map ?
	-- ["TDM"] = true, -- Is Team Death Match available on this map ?
	
	-- ["AvailableSpawnSize"] = 2.0,
	
	-- ["blueCoords"] = {x=587.72491455078,y=2753.2062988281,z=46.993984222412},
	-- ["redCoords"] = {x=594.78063964844,y=2753.9221191406,z=46.993988037109},
	-- ["blueFlagCoords"] = {x=579.14154052734,y=2745.5856933594,z=42.142532348633,h=3.0212199687958},
	-- ["redFlagCoords"] = {x=604.88806152344,y=2747.576171875,z=42.142490386963,h=7.2482562065125},
	
	-- ["mapRedOutCoords"] = {{x=595.02532958984,y=2757.8576660156,z=42.142501831055,h=354.65277099609}},
	-- -- ["mapBlueOutCoords"] = {x=-1121.7076416016,y=-1231.3385009766,z=-79.970596313477,h=176.43196105957},
	-- },


}
PaintBallShop = {
	["Laser Tag"] = {
		["Blip"] = {x=-1091.723,y=-1270.734,z=5.841797,sprite=546,scale=0.8,colour=1},
		["Create"] = {{x=-1095.1264648438,y=-1269.3354492188,z=5.8505229949951}},
		["Join"] = 	{
					{x=-1098.5012207031,y=-1270.7672119141,z=5.8445701599121},
					{x=-1087.3604736328,y=-1264.7006835938,z=5.8445706367493}
					},
		["Out"] = {x=-1098.0637207031,y=-1273.4953613281,z=4.8445663452148},
		["MapAvailable"] = {"Patoche"},
		["ModAvailable"] = {"TDM"},
	
	},

	-- ["Plasma 3000"] = {
	-- 	["Blip"] = {x=592.44219970703,y=2738.0383300781,z=42.024761199951,sprite=650,scale=0.8,colour=1},
	-- 	["Create"] = {{x=587.31140136719,y=2750.3107910156,z=42.142509460449}},
	-- 	["Join"] = 	{
	-- 				{x=595.14276123047,y=2756.3996582031,z=42.14253616333}
	-- 				},
	-- 	["Out"] = {x=595.32873535156,y=2753.048828125,z=42.142517089844,h=3.2232799530029},
	-- 	["MapAvailable"] = {"Patoche","MarcMLO"},
	-- 	["ModAvailable"] = {"CTF","TDM"},
	
	-- },
	

}

defaultOutCoords = {x=-1096.7523193359,y=-1274.1475830078,z=5.8445658683777,h=108.13357543945}
--If you want to modify the Player Outfit You can modify this : 
-- Model is the cloth, colorA is the color of the cloth for blue team, colorB is the color of the cloth for red team
--TenuFemme = {
--[3] = {model = 8, colorA = 0, colorB = 0}, 		-- Torso / Arms / Bras
--[4] = {model = 123, colorA = 2, colorB = 1}, 	-- Legs / Pants / Jambe
--[6] = {model = 96, colorA = 2, colorB = 1}, 	-- Feet / Shoes / Chaussure
--
--[7] = {model = 0, colorA = 0, colorB = 0}, 		--Accessories / Accessoires
--[8] = {model = 8, colorA = 0, colorB = 0}, 		--Undershirt / T-Shirt
--[11] = {model = 304, colorA = 2, colorB = 1} 	--Tops / Veste
--
--}
--
--TenuHomme = {
--[3] = {model = 7, colorA = 0, colorB = 0},		-- Torso / Arms / Bras
--[4] = {model = 120, colorA = 2, colorB = 1},    -- Legs / Pants / Jambe
--[6] = {model = 80, colorA = 3, colorB = 5},     -- Feet / Shoes / Chaussure
--                                                
--[7] = {model = 0, colorA = 0, colorB = 0},      --Accessories / Accessoires
--[8] = {model = 15, colorA = 0, colorB = 0},     --Undershirt / T-Shirt
--[11] = {model = 296, colorA = 2, colorB = 1},   --Tops / Veste
--}


TenuFemme = {
[3] = {model = 17, colorA = 0, colorB = 0},       -- Torso / Arms / Bras
[4] = {model = 98, colorA = 2, colorB = 1},      -- Legs / Pants / Jambe
[6] = {model = 71, colorA = 2, colorB = 1},      -- Feet / Shoes / Chaussure
                                                 
[7] = {model = 0, colorA = 0, colorB = 0},       --Accessories / Accessoires
[8] = {model = 8, colorA = 0, colorB = 0},       --Undershirt / T-Shirt
[11] = {model = 254, colorA = 2, colorB = 1}     --Tops / Veste
                                                 
}                                                
                                                 
TenuHomme = {                              
[3] = {model = 17, colorA = 0, colorB = 0},       -- Torso / Arms / Bras
[4] = {model = 77, colorA = 9, colorB = 1},      -- Legs / Pants / Jambe
[6] = {model = 7, colorA = 2, colorB = 1},      -- Feet / Shoes / Chaussure
                                                 
[7] = {model = 0, colorA = 0, colorB = 0},       --Accessories / Accessoires
[8] = {model = 15, colorA = 0, colorB = 0},      --Undershirt / T-Shirt
[11] = {model = 178, colorA = 9, colorB = 1},    --Tops / Veste
}
--Custom Mask :
useCustomMask = true

MaskFemme = {
[1]={model = 107, colorA = 7, colorB = 1},
[2]={model = 108, colorA = 0, colorB = 1}
}

MaskHomme = {
[1]={model = 108, colorA = 5, colorB = 1},
[2]={model = 0, colorA = 0, colorB = 1}
}