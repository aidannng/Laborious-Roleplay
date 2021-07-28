local polarAngleDeg = 0
local azimuthAngleDeg = 90

-- I recommend you to dont remove the version part, to always be sure you have the latest release
local watermark = [[  
	~b~   _       _                               _ 
	~b~  /_\   __| |_   ____ _ _ __   ___ ___  __| |
	~b~ //_\\ / _` \ \ / / _` | '_ \ / __/ _ \/ _` |
	~b~/  _  \ (_| |\ V / (_| | | | | (_|  __/ (_| |
	~b~\_/ \_/\__,_| \_/ \__,_|_| |_|\___\___|\__,_|
	~g~	   __                 _        _       
	~g~	  / _\_ __   ___  ___| |_ __ _| |_ ___ 
	~g~	  \ \| '_ \ / _ \/ __| __/ _` | __/ _ \
	~g~	  _\ \ |_) |  __/ (__| || (_| | ||  __/
	~g~	  \__/ .__/ \___|\___|\__\__,_|\__\___|
	~g~	     |_|                               
	
	~b~Current Version ~s~: %s
	~g~Latest  Version ~s~: %s
	%s
	~g~Discord Support : ~s~https://discord.com/invite/Mgyg2nVRhC
	~s~Scripted by ~b~Ali Exacute#2588
	]]

convertTable = {
	{
		gta   = '~s~',
		fivem = '^0'
	},
	{
		gta   = '~r~',
		fivem = '^1'
	},
	{
		gta   = '~g~',
		fivem = '^2'
	},
	{
		gta   = '~y~',
		fivem = '^3'
	},
	{
		gta   = '~b~',
		fivem = '^4'
	},
	{
		gta   = '~HUD_COLOUR_BLUELIGHT~',
		fivem = '^5'
	},
	{
		gta   = '~p~',
		fivem = '^6'
	},
	{
		gta   = '~w~',
		fivem = '^7'
	},
	{
		gta   = '~o~',
		fivem = '^8'
	},
	{
		gta   = '~c~',
		fivem = '^9'
	},
	{
		gta   = '~u~',
		fivem = '^10'
	}
	
}

--- Convert color from one type to another
---@param message string message to be converted
---@param patternFrom string pattern to be replaced with patternTo : gta | fivem
---@param patternTo string pattern to get replaced with patternFrom : gta | fivem
function convertColor(message, patternFrom, patternTo)
	if message then
		local constMessage = message
		if patternFrom then
			for i=1, #convertTable do
				local colorsMetaData = convertTable[i]
				-- look for GTA pattern   ~r~
				if string.find(message, colorsMetaData[patternFrom]) then
					message = string.gsub(message, colorsMetaData[patternFrom], colorsMetaData[patternTo] or '')
				end
				-- look for Fivem pattern with escape or it will not work	^1
				if string.find(message, '%'..colorsMetaData[patternFrom]) then
					message = string.gsub(message, '%'..colorsMetaData[patternFrom], colorsMetaData[patternTo] or '')
				end
			end
		end
	end
	return message
end

function dprint(message, force, log)
	if Config.debugMode or force then
		Citizen.Trace(convertColor("^4["..GetCurrentResourceName().."]: ^0"..tostring(message).."~s~\n", "gta", 'fivem'))
		if log then
			logMessage = "NULL"
			if IsDuplicityVersion() then
				logMessage = "["..GetCurrentResourceName().."] (serverside log): "..tostring(message).."\n"
			else
				logMessage = "["..GetCurrentResourceName().."] (client log : #"..GetPlayerServerId(PlayerId()).."): "..tostring(message).."\n"
			end
			log(logMessage)
		end
	end
end

if IsDuplicityVersion() then

	function showNotification(playerId, message)
		if not playerId or playerId and playerId == 0 then
			dprint(message, true)
		else
			TriggerClientEvent("AdvancedSpectate:client:showNotification",playerId , message)
		end
	end

	function log(message)
        if message then
            local botProfilePicture = Config.discordLog.botProfilePicture or nil
            local botName = "Advanced Spectate"
            local embeds = {
                    {
                        ["title"] = "",
                        ["description"] = convertColor(message, 'fivem', "gta"),
                        ["color"] = 2640854,
                        ["footer"] = {
                            ["text"] = GetCurrentResourceName()
                        },
                    }
                }
            PerformHttpRequest(Config.discordLog.webhook, function(err, text, headers) end, 'POST', json.encode({username = botName, embeds = embeds, avatar_url = botProfilePicture}), { ['Content-Type'] = 'application/json' })
        end
    end

    RegisterNetEvent("AdvancedSpectate:server:log")
    AddEventHandler("AdvancedSpectate:server:log", function(message)
        log(message)
	end)

	-- check version
	local metaData = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
	local currentVersion = '1.0.0'
	if metaData then
		currentVersion = metaData:sub(1, -1)
	end
	local cVer, _ = currentVersion:gsub('%.', '')
	local gVer = 0
	PerformHttpRequest('https://raw.githubusercontent.com/ali-exacute/VerCheck/master/AdvancedSpectate.txt',function(error, result, headers)
		local githubVer = 'Unavaiable'
		if result then
        	githubVer = result:sub(1, -2)
			gVer = githubVer:gsub('%.', '')
		end
        
		local verInfo = '~g~You are running the latest version\n'
		if gVer == 0 then
			verInfo = '~y~No information about latest stable version could be find\nScript will still work as normal'
		elseif tonumber(cVer) > tonumber(gVer) then
			verInfo = '~r~You are running an beta version\n Script could be unstable and or have some unfinished functions'
		elseif tonumber(cVer) < tonumber(gVer) then
			verInfo = '~r~THERE IS NEW UPDATE AVAILABLE !\n ~s~Open a ticket on discord for new update'
		end

		local text = watermark:format(currentVersion, githubVer, verInfo)
    	dprint(text, true)
	end,'GET')
	
else
	function showNotification(message)
		if Config.notificationType.GTA then

			AddTextEntry('AdvancedSpectate:ATE:notification', convertColor(message, 'fivem', "gta"))
			BeginTextCommandThefeedPost('AdvancedSpectate:ATE:notification')

			EndTextCommandThefeedPostTicker(true, true)
		end
		if Config.notificationType.chat then
			TriggerEvent('chatMessage', "Advanced Spectate ", {155,0,0}, convertColor(message, "gta",'fivem'))
		end
	end
	
	RegisterNetEvent("AdvancedSpectate:client:showNotification")
  	AddEventHandler("AdvancedSpectate:client:showNotification", function(message)
   	   showNotification(message)
	end)

	function log(message)
		TriggerServerEvent("AdvancedSpectate:server:log", message)
	end

	function showHelpNotification(message)
		AddTextEntry('AdvancedSpectate:ATE:SHN', message)
		DisplayHelpTextThisFrame('AdvancedSpectate:ATE:SHN', false)
	end

	function calculateMouseRotation(xMagnitude, yMagnitude, mouseSensivity)

		polarAngleDeg = polarAngleDeg + xMagnitude * (mouseSensivity * 2)
        if polarAngleDeg >= 360 then polarAngleDeg = 0 end

        if invertMouse then
            azimuthAngleDeg = azimuthAngleDeg + yMagnitude * (mouseSensivity * 2)
        else
            azimuthAngleDeg = azimuthAngleDeg - yMagnitude * (mouseSensivity * 2)
        end
        if azimuthAngleDeg < 40 then azimuthAngleDeg = 40 end
        if azimuthAngleDeg > 110 then azimuthAngleDeg = 110 end

		return polarAngleDeg, azimuthAngleDeg
	end

end

function SecondsToClock(seconds)
	local seconds = tonumber(seconds)
  
	if seconds <= 0 then
		return "00:00:00"
	else
		hours = string.format("%02.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
		return hours..":"..mins..":"..secs
	end
end

function _lang(str_code, tbl)
	
	local firstStep = Config.languagePack[str_code]
	if firstStep then
		secondStep = Config.languagePack[str_code][Config.language]
		if secondStep and secondStep ~= "" then
			text = secondStep
		elseif Config.languagePack[str_code]['en'] then
			text = Config.languagePack[str_code]['en']
		else
			text = "Translation for ["..str_code.."] not found, neither [en] translation..."
		end
	else
		text = "Translation for ["..str_code.."] not found!"
	end
	local finalText, _ = string.gsub(text, "%$%a+", tbl or {})

	return finalText
end