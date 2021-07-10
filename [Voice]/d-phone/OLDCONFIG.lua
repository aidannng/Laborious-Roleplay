Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config                            = {}

Config.Locale             = 'en'

-- https://docs.fivem.net/docs/game-references/controls/
Config.Openkey = 4234234
Config.AcceptCall = 20
Config.EndCall = 73

-- If you dont want to use an second key then simple set it to nil
Config.SecondKey = 3423423

Config.NeedItem = true

-- Phone open command
Config.Command = false
Config.CommandText = "phone"


Config.CustomNotification = false

-- Exports Config
Config.MumbleVoipFolderName = "mumble-voip"
Config.PMAVOICEFolderName = "pma-voice"
Config.SaltychatFolderName = 'saltychat'


-- Voice Chat [only 1 can be true]
Config.TokoVoip = false
Config.PMAVoice = false
Config.MumbleVoip = false
Config.SaltyChat = false

-- Wallpaper
Config.backgroundurl = "https://aidan.iodine.gg/hgc6b.png"
Config.darkbackgroundurl = "https://cdn.discordapp.com/attachments/717040110641741894/788435064475353098/wallpaper.png"

--[[
Phone Numer
Nummer will be like [prefix-number]
The number will be randomly generated between the lower and higher number
]] 

Config.Prefix = true
-- Ignore this if Prefix = false
Config.LowerPrefix = 100
Config.HigherPrefix = 999

Config.LowerNumber = 1000
Config.HigherNumber = 9999



-- These Jobs have access to the blocked channels 
Config.Access = {
    {
        frequenz = 1,
        job = "police",
        joblabel = "LSPD"
    },
    {
        frequenz = 1,
        job = "ambulance",
        joblabel = "Ambulance"
    },

    {
        frequenz = 2,
        job = "police",
        joblabel = "LSPD"
    },
    {
        frequenz = 3,
        job = "ambulance",
        joblabel = "Ambulance"
    },
    {
        frequenz = 4,
        job = "ambulance",
        joblabel = "Ambulance"
    },
    {
        frequenz = 422,
        job = "ambulance",
        joblabel = "Ambulance"
    },
}

-- If you're server is slow, make this higher
Config.FirstTimeSQL = 1000
Config.MysqlWaitingTime = 500
Config.UserDataWaitingTime = 500
Config.RecentMessagesWait = 100
Config.RecentBusinessMessagesWait = 100

-- ESX Events DONT TOUCH THIS IF YOU DONT EXACTLY KNOW WHAT THESE DOES
Config.esxgetSharedObjectevent = 'esx:getSharedObject'
Config.esxprefix = "esx:"
Config.esxprefix2 = "esx_"

Config.Debug = false