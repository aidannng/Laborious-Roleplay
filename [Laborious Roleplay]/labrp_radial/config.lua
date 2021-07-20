ESX = nil
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if ESX ~= nil then
       
        else
            ESX = nil
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end
    end
end)


local countingJobs = {
    ['police'] = true,
    ['fbi'] = true
};

 
local isJudge = false
local fuck = exports["esx_ambulancejob"]:GetDeath()
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}



Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("bennys", vector3(-32.61098, -1053.244, 28.38684), 8.0, 8.0, {
        name="bennys",
        heading=70,
        debugPoly=false,
    })
end)

Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("pdm", vector3(-31.50329, -1096.721, 26.3648), 50.0, 50.0, {
        name="pdm",
        heading=70,
        debugPoly=false,
    })
end)--450.1846, -975.8373, 25.6908, 90.0

Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("pdVehExtras", vector3(450.1846, -975.8373, 25.6908), 10.0, 4.0, {
        name="pdVehExtras",
        heading=90.0,
        debugPoly=false,
    })
end)

Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("pdheli", vector3(449.3143, -981.1252, 43.6864), 5.0, 5.0, {
        name="pdheli",
        heading=90,
        debugPoly=false,
    })
end)

Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("returntowtruck", vector3(-209.0506, -1168.681, 23.02856), 12.0, 10.0, {
        name="returntowtruck",
        heading=90,
        debugPoly=false,
    })
end)

Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("impoundvehicle", vector3(-239.3407, -1183.78, 23.02856), 8.0, 4.0, {
        name="impoundvehicle",
        heading=90,
        debugPoly=false,
    })
end)

Citizen.CreateThread(function()
    exports["PolyZone"]:AddBoxZone("lscustomreturntruck", vector3(-366, -85.16044, 39.0022), 11.5, 6.0, {
        name="lscustomreturntruck",
        heading=70,
        debugPoly=false,
    })
end)

local bennysMenuEnable = false
local pdheliMenu = false
local returntowtruck = false
local impoundtow = false
local pdmbills = false
local lscustomtowtruck = false
local pdVehicleExtras = false

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "lscustomreturntruck" then
        lscustomtowtruck = true
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "lscustomreturntruck" then
        lscustomtowtruck = false
    end
end)

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "pdVehExtras" then
        pdVehicleExtras = true
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "pdVehExtras" then
        pdVehicleExtras = false
    end
end)

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "bennys" then
        bennysMenuEnable = true
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "bennys" then
        bennysMenuEnable = false
    end
end)

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "pdm" then
        pdmbills = true
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "pdm" then
        pdmbills = false
    end
end)

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "pdheli" then
        pdheliMenu = true
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "pdheli" then
        pdheliMenu = false
    end
end)

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "returntowtruck" then
        returntowtruck = true
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "returntowtruck" then
        returntowtruck = false
    end
end)--impoundtow

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "impoundvehicle" then
        impoundtow = true
    end
end)

AddEventHandler('bt-polyzone:exit', function(name)
    if name == "impoundvehicle" then
        impoundtow = false
    end
end)

 
rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = {"general:flipvehicle", "general:keysgive", "general:housekeys", "general:Rob", "general:checkvehicle", "general:wallet", "general:bills", "general:escort"} --escort:player
    },
    {
        id = "police-action",
        displayName = "Police Actions",
        icon = "#police-action",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
           if countingJobs[PlayerData.job.name] and not fuck then
                return true
            end
        end,
        subMenus = {"police:gsr", "police:impound", "police:mdt", "general:escort", "police:hardcuff", "police:softcuff", "police:search"}
    },
    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#police-vehicle",
        functionName = "vehcontrol:openExternal",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath()
             if not fuck and IsPedInAnyVehicle(PlayerPedId(), false) then
                 return true
             end
         end,
    },
    {
        id = "bennys",
        displayName = "Benny's",
        icon = "#police-vehicle",
        functionName = "lsc:openmenu",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath()
             if bennysMenuEnable == true then
                 return true
             end
         end,
    },
    {
        id = "lsscustomtruck",
        displayName = "Return Truck",
        icon = "#police-vehicle",
        functionName = "lsccustomtruck",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath() --return_lsc
             if not fuck and PlayerData.job.name == "mechanic" and lscustomtowtruck == true then
                 return true
             end
         end,
    },
    {
        id = "pdvehicleextras",
        displayName = "Vehicle/Extra's",
        icon = "#police-vehicle",
        functionName = "pdvehicleextras",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath() --return_lsc
             if not fuck and PlayerData.job.name == "police" and pdVehicleExtras == true then
                 return true
             end
         end,
    },
    {
        id = "pdhelipad",
        displayName = "Return Heli",
        icon = "#police-heli",
        functionName = "deleteHeli",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath()
            if countingJobs[PlayerData.job.name] and pdheliMenu == true then
                 return true
             end
         end,
    },
    {
        id = "pdmtablet",
        displayName = "PDM Tablet",
        icon = "#car",
        functionName = "pdm:menu",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath()
             if PlayerData.job.name == "cardealer" and pdmbills == true then
                 return true
             end
         end,
    },
    {
        id = "returntowtruck",
        displayName = "Return Tow Truck",
        icon = "#return-tow",
        functionName = "returntow",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath()
             if returntowtruck == true then
                 return true
             end
         end,
    },
    {
        id = "towimpound",
        displayName = "Impound Vehicle",
        icon = "#return-tow",
        functionName = "impoundvehicle",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath()
             if impoundtow == true and IsPedInAnyVehicle(PlayerPedId(), false) then
                 return true
             end
         end,
    },
    {
        id = "policeDead",
        displayName = "10-13A",
        icon = "#police-dead",
        functionName = "panicButton",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath()
            if countingJobs[PlayerData.job.name] and fuck then
               return true
            end
        end,
    },
    {
        id = "policeDead",
        displayName = "Send Distress",
        icon = "#police-dead",
        functionName = "panicButton",
        enableMenu = function()
        local ped = PlayerPedId()
            PlayerData = ESX.GetPlayerData()
            fuck = exports["esx_ambulancejob"]:GetDeath()
            if fuck then
               return true
            end
        end,
    },
    {
        id = "animations",
        displayName = "Walking Styles",
        icon = "#walking",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },
    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
--[[     {
        id = "judge-actions",
        displayName = "Judge Actions",
        icon = "#judge-actions",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory", "police:checkbank"}
    }, ]]
    {
        id = "judge-actions",
        displayName = "Mechanic Actions",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "mechanic" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:mech", "mechanic:repair", "mechanic:hood", "mechanic:menu" }
    },
}

newSubMenus = {    
    ['general:keysgive'] = {
        title = "Give Keys",
        icon = "#general-keys-give",
        functionName = "vehiclekeys:client:GiveKeys"
    },
    ['general:housekeys'] = {
        title = "Property Keys",
        icon = "#general-apart-givekey",
        functionName = "openKeysMenu"
    },
    ['general:wallet'] = {
        title = "Open Wallet",
        icon = "#general-wallet",
        functionName = "openWallet"
    },
    ['general:bills'] = {
        title = "View Bills",
        icon = "#general-wallet",
        functionName = "billing:getbills"
    },
    ['general:Rob'] = {
        title = "Rob Player",
        icon = "#rob-player",
        functionName = "robperson"
    },
    ['general:checkvehicle'] = {
        title = "Examine Vehicle",
        icon = "#general-check-vehicle",
        functionName = "local:inspect"
    },--escort:player
    ['general:escort'] = {
        title = "Escort",
        icon = "#general-put-in-veh",
        functionName = "escort:player"
    },
    ['general:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "putinvehicle:target"
    },
    ['general:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "police:unseat"
    },    
    ['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['aidan:vehnui'] = {
        title = "Doors",
        icon = "#general-emotes",
        functionName = "vehcontrol:openExternal"
    },  
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['mechanic:mech'] = {
        title = "Inspect Vehicle",
        icon = "#general-check-vehicle",
        functionName = "mechanic:inspect"
    },
    ['mechanic:repair'] = {
        title = "Repair",
        icon = "#police-vehicle",
        functionName = "vehcontrol:repair"
    },
    ['mechanic:hood'] = {
        title = "Hood",
        icon = "#police-vehicle",
        functionName = "mechanic:hood"
    },
   ['mechanic:menu'] = {
        title = "Customs Tablet",
        icon = "#general-check-vehicle",
        functionName = "mechanic:customs"
    },
    ['k9:spawn'] = {
        title = "Summon",
        icon = "#k9-spawn",
        functionName = "K9:Create"
    },
    ['k9:delete'] = {
        title = "Dismiss",
        icon = "#k9-dismiss",
        functionName = "K9:Delete"
    },
    ['k9:follow'] = {
        title = "Follow",
        icon = "#k9-follow",
        functionName = "K9:Follow"
    },
    ['k9:vehicle'] = {
        title = "Get in/out",
        icon = "#k9-vehicle",
        functionName = "K9:Vehicle"
    },
    ['k9:sit'] = {
        title = "Sit",
        icon = "#k9-sit",
        functionName = "K9:Sit"
    },
    ['k9:lay'] = {
        title = "Lay",
        icon = "#k9-lay",
        functionName = "K9:Lay"
    },
    ['k9:stand'] = {
        title = "Stand",
        icon = "#k9-stand",
        functionName = "K9:Stand"
    },
    ['k9:sniff'] = {
        title = "Sniff Person",
        icon = "#k9-sniff",
        functionName = "st:k9drugsniff"
    },
--[[     ['k9:sniffvehicle'] = {
        title = "Sniff Vehicle",
        icon = "#k9-sniff-vehicle",
        functionName = "sniffVehicle"
    }, ]]
--[[     ['k9:huntfind'] = {
        title = "Hunt nearest",
        icon = "#k9-huntfind",
        functionName = "K9:Huntfind"
    }, ]]
--[[     ['judge-raid:checkowner'] = {
        title = "Check Owner",
        icon = "#judge-raid-check-owner",
        functionName = "appartment:CheckOwner"
    },
    ['judge-raid:seizeall'] = {
        title = "Seize All Content",
        icon = "#judge-raid-seize-all",
        functionName = "appartment:SeizeAll"
    },
    ['judge-raid:takecash'] = {
        title = "Take Cash",
        icon = "#judge-raid-take-cash",
        functionName = "appartment:TakeCash"
    },
    ['judge-raid:takedm'] = {
        title = "Take Marked Bills",
        icon = "#judge-raid-take-dm",
        functionName = "appartment:TakeDM"
    }, ]]
    ['cuffs:cuff'] = {
        title = "Hard Cuff",
        icon = "#cuffs-cuff",
        functionName = "hardcuff"                    
    }, 
    ['cuffs:softcuff'] = {
        title = "Soft Cuff",
        icon = "#cuffs-cuff",
        functionName = "softcuff"
    },
    ['cuffs:uncuff'] = {
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        functionName = "releasecuff"
    },
--[[     ['cuffs:remmask'] = {
        title = "Remove Mask Hat",
        icon = "#cuffs-remove-mask",
        functionName = "police:remmask"
    }, ]]
    ['cuffs:checkinventory'] = {
        title = "Search Person",
        icon = "#cuffs-check-inventory",
        functionName = "searchsuspect"
    },
    ['cuffs:unseat'] = {
        title = "Unseat",
        icon = "#cuffs-unseat-player",
        functionName = "police:unseat"
    },
    ['cuffs:checkphone'] = {
        title = "Read Phone",
        icon = "#cuffs-check-phone",
        functionName = "police:checkPhone"
    },
    ['medic:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "st:emsRevive"
    },
    ['medic:heal'] = {
        title = "Treat Small Wounds",
        icon = "#medic-heal",
        functionName = "st:emssmallheal"
    },
    ['medic:bigheal'] = {
        title = "Treat Serious Wounds",
        icon = "#medic-heal",
        functionName = "st:emsbigheal"
    },
    ['medic:putinvehicle'] = {
        title = "Put in vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:seat"
    },
    ['medic:takeoutvehicle'] = {
        title = "Take out vehicle",
        icon = "#general-unseat-nearest",
        functionName = "police:unseat"
    },
    ['medic:drag'] = {
        title = "Drag",
        icon = "#general-escort",
        functionName = "police:escort"
    },
    ['medic:undrag'] = {
        title = "Undrag",
        icon = "#general-escort",
        functionName = "escort:player"
    },
    ['police:escort'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "escort:player"
    },
    ['police:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "st:pdrevive"
    },
    ['police:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:seat"
    },
    ['police:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "police:unseat"
    },
    ['police:impound'] = {
        title = "Impound",
        icon = "#police-vehicle",
        functionName = "police:menuimpound"
    },
    ['police:mdt'] = {
        title = "MDT",
        icon = "#judge-licenses-grant-business",
        functionName = "openmdt"
    },
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu"
    },
    ['police:checkbank'] = {
        title = "Check Bank",
        icon = "#police-check-bank",
        functionName = "police:checkBank"
    },
    ['police:checklicenses'] = {
        title = "Check Licenses",
        icon = "#police-check-licenses",
        functionName = "police:checkLicenses"
    },
--[[     ['police:removeweapons'] = {
        title = "Remove Weapons License",
        icon = "#police-action-remove-weapons",
        functionName = "police:removeWeapon"
    }, ]]
    ['police:gsr'] = {
        title = "GSR Test",
        icon = "#police-action-gsr",
        functionName = "gsr:test"
    },--hardcuff
    ['police:openmdt'] = {
        title = "MDT",
        icon = "#judge-licenses-grant-business",
        functionName = "openmdt"
    },
    ['police:hardcuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "hardcuff"
    },
    ['police:softcuff'] = {
        title = "Soft Cuff",
        icon = "#cuffs-cuff",
        functionName = "softcuff"
    },
    ['police:search'] = {
        title = "Search Person",
        icon = "#police-action-gsr",
        functionName = "police:searchperson"
    },
--[[     ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "startSpeedo"
    }, ]]
    ['police:runplate'] = {
        title = "Run Plate",
        icon = "#police-vehicle-plate",
        functionName = "st:mdtvehiclesearch"
    },
--[[     ['police:frisk'] = {
        title = "Frisk",
        icon = "#police-action-frisk",
        functionName = "police:frisk"
    }, ]]
    ['judge:grantDriver'] = {
        title = "Grant Drivers",
        icon = "#judge-licenses-grant-drivers",
        functionName = "police:grantDriver"
    }, 
    ['judge:grantBusiness'] = {
        title = "Grant Business",
        icon = "#judge-licenses-grant-business",
        functionName = "police:grantBusiness"
    },  
    ['judge:grantWeapon'] = {
        title = "Grant Weapon",
        icon = "#judge-licenses-grant-weapon",
        functionName = "police:grantWeapon"
    },
    ['judge:grantHouse'] = {
        title = "Grant House",
        icon = "#judge-licenses-grant-house",
        functionName = "police:grantHouse"
    },
    ['judge:grantBar'] = {
        title = "Grant BAR",
        icon = "#judge-licenses-grant-bar",
        functionName = "police:grantBar"
    },
    ['judge:grantDA'] = {
        title = "Grant DA",
        icon = "#judge-licenses-grant-da",
        functionName = "police:grantDA"
    },
    ['judge:removeDriver'] = {
        title = "Remove Drivers",
        icon = "#judge-licenses-remove-drivers",
        functionName = "police:removeDriver"
    },
    ['judge:removeBusiness'] = {
        title = "Remove Business",
        icon = "#judge-licenses-remove-business",
        functionName = "police:removeBusiness"
    },
    ['judge:removeWeapon'] = {
        title = "Remove Weapon",
        icon = "#judge-licenses-remove-weapon",
        functionName = "police:removeWeapon"
    },
    ['judge:removeHouse'] = {
        title = "Remove House",
        icon = "#judge-licenses-remove-house",
        functionName = "police:removeHouse"
    },
    ['judge:removeBar'] = {
        title = "Remove BAR",
        icon = "#judge-licenses-remove-bar",
        functionName = "police:removeBar"
    },
    ['judge:removeDA'] = {
        title = "Remove DA",
        icon = "#judge-licenses-remove-da",
        functionName = "police:removeDA"
    },
    ['judge:denyWeapon'] = {
        title = "Deny Weapon",
        icon = "#judge-licenses-deny-weapon",
        functionName = "police:denyWeapon"
    },
    ['judge:denyDriver'] = {
        title = "Deny Drivers",
        icon = "#judge-licenses-deny-drivers",
        functionName = "police:denyDriver"
    },
    ['judge:denyBusiness'] = {
        title = "Deny Business",
        icon = "#judge-licenses-deny-business",
        functionName = "police:denyBusiness"
    },
    ['judge:denyHouse'] = {
        title = "Deny House",
        icon = "#judge-licenses-deny-house",
        functionName = "police:denyHouse"
    },
    ['news:setCamera'] = {
        title = "Camera",
        icon = "#news-job-news-camera",
        functionName = "camera:setCamera"
    },
    ['news:setMicrophone'] = {
        title = "Microphone",
        icon = "#news-job-news-microphone",
        functionName = "camera:setMic"
    },
    ['news:setBoom'] = {
        title = "Microphone Boom",
        icon = "#news-job-news-boom",
        functionName = "camera:setBoom"
    },
    ['weed:currentStatusServer'] = {
        title = "Request Status",
        icon = "#weed-cultivation-request-status",
        functionName = "weed:currentStatusServer"
    },   
    ['weed:weedCrate'] = {
        title = "Remove A Crate",
        icon = "#weed-cultivation-remove-a-crate",
        functionName = "weed:weedCrate"
    },
    ['cocaine:currentStatusServer'] = {
        title = "Request Status",
        icon = "#meth-manufacturing-request-status",
        functionName = "cocaine:currentStatusServer"
    },
    ['cocaine:methCrate'] = {
        title = "Remove A Crate",
        icon = "#meth-manufacturing-remove-a-crate",
        functionName = "cocaine:methCrate"
    },
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    }
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("openWallet")
AddEventHandler("openWallet", function()
    ExecuteCommand("wallet")
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)


function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end


RegisterNetEvent('hardcuff')
AddEventHandler('hardcuff', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
end)

RegisterNetEvent('softcuff')
AddEventHandler('softcuff', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    TriggerServerEvent('esx_policejob:softcufff', GetPlayerServerId(closestPlayer))
end)

RegisterNetEvent('openmdt')
AddEventHandler('openmdt', function()
    ExecuteCommand('mdt')
end)--TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))


RegisterNetEvent('police:seat')
AddEventHandler('police:seat', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
end)

RegisterNetEvent('police:unseat')
AddEventHandler('police:unseat', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
end)

RegisterNetEvent('deleteHeli')
AddEventHandler('deleteHeli',function()
    local xPlayer = ESX.GetPlayerData()
    local heli = GetVehiclePedIsIn(PlayerPedId(),true)
    exports['mythic_notify']:SendAlert('inform', "You've returned a Helicopter")
    SetEntityAsMissionEntity(heli, true, true)
    TaskLeaveVehicle(PlayerPedId(), vheli, 0)
    Wait(2000)
    DeleteVehicle(heli) --refundbike
    TriggerServerEvent("refundpdheli")
end) --returntow


RegisterNetEvent('returntow')
AddEventHandler('returntow',function()
    local xPlayer = ESX.GetPlayerData()
    local heli = GetVehiclePedIsIn(PlayerPedId(),true)
    exports['mythic_notify']:SendAlert('inform', "You've returned your Tow Truck")
    SetEntityAsMissionEntity(heli, true, true)
    TaskLeaveVehicle(PlayerPedId(), vheli, 0)
    Wait(2000)
    DeleteVehicle(heli) --refundbike
    TriggerServerEvent("refundtowtruck")
end)

RegisterNetEvent("panicButton")
AddEventHandler("panicButton", function()
    TriggerEvent('alert_pddead')
end)

RegisterNetEvent("police:menuimpound")
AddEventHandler("police:menuimpound", function()
    exports['br-menu']:SetTitle("Impound Menu")
    exports['br-menu']:AddButton("Call for Impound" , "Calls nearby mechanics to impound this vehicle." ,'callforimpound' ,'' , 'menuone')
    exports['br-menu']:AddButton("Scuff Impound" , "Only use if necessary" ,'scuffimpound' ,'' , 'menuone')
end)

RegisterNetEvent("drag")
AddEventHandler("drag", function()
    TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
end)

RegisterNetEvent('robperson')
AddEventHandler('robperson', function()
    ExecuteCommand('steal')
end)

RegisterNetEvent('putinvehicle:steve')
AddEventHandler('putinvehicle:steve', function()
    TriggerEvent('putinvehicle:target')
end)

RegisterNetEvent('putinvehicle:steve')
AddEventHandler('putinvehicle:steve', function()
    TriggerEvent('putinvehicle:target')
end)

RegisterNetEvent('police:searchperson')
AddEventHandler('police:searchperson', function()
    exports['linden_inventory']:OpenTargetInventory()
end)

RegisterNetEvent('lsccustomtruck')
AddEventHandler('lsccustomtruck', function()
    TriggerEvent('return_lsc')
end)

RegisterNetEvent('pdvehicleextras')
AddEventHandler('pdvehicleextras', function()
    TriggerEvent('openpdextras')
end)