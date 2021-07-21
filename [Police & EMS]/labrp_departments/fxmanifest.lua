fx_version 'adamant'

game 'gta5'

-- POLICE
shared_script '@es_extended/imports.lua'
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'Policejob/locales/en.lua',
	'Policejob/config.lua',
	'Policejob/server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'Policejob/locales/en.lua',
	'Policejob/config.lua',
	'Policejob/client/main.lua',
	'Policejob/client/vehicle.lua'
}

-- CHECKIN
client_scripts {
    'Checkin/locales/en.lua',
    'Checkin/config.lua', 
	'Checkin/client.lua' 
} 
 
server_scripts { 
    'Checkin/locales/en.lua',
    'Checkin/config.lua',
	'Checkin/server.lua',
	'@mysql-async/lib/MySQL.lua'
} 

-- GSR
client_scripts {
    'gsr/client.lua'
}

server_scripts {
    'gsr/server.lua'
}

-- Lights & Sirens
client_scripts {
    'VehicleLights/client.lua'
}

server_scripts {
    'VehicleLights/server.lua'
}

-- wk_wars
files {
	"wkWars/nui/radar.html", 
	"wkWars/nui/radar.css", 
	"wkWars/nui/jquery-3.4.1.min.js", 
	"wkWars/nui/radar.js",
	"wkWars/nui/images/*.png",
	"wkWars/nui/images/plates/*.png",
	"wkWars/nui/fonts/*.ttf",
	"wkWars/nui/fonts/Segment7Standard.otf",
	"wkWars/nui/sounds/*.ogg"
}

ui_page "wkWars/nui/radar.html"

server_script "wkWars/sv_version_check.lua"
server_script "wkWars/sv_exports.lua"
server_export "wkWars/TogglePlateLock"

client_script "wkWars/config.lua"
client_script "wkWars/cl_utils.lua"
client_script "wkWars/cl_radar.lua"
client_script "wkWars/cl_plate_reader.lua"