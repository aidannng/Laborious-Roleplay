fx_version 'bodacious'
game 'gta5'

author 'plasma'
description 'Galaxy Nightclub Scripts'
version '1.0.0'

-- MAIN NIGHTCLUB FRAMEWORK
client_script 'client.lua'
server_script 'server.lua'

-- DJ SOUND
client_scripts {
	'@NativeUI/NativeUI.lua',
	'myDj/config.lua',
	'myDj/client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'myDj/config.lua',
	'myDj/server.lua',
}

ui_page 'myDj/html/index.html'

files {
    'myDj/html/index.html',
	
	'myDj/html/css/style.css',
	'myDj/html/css/fontawesome.css',
	
	'myDj/html/img/*.png',
	
	'myDj/html/js/script.js',
	'myDj/html/js/jquery-3.5.1.min.js',

	'myDj/html/webfonts/Icons/fa-brands-400.eot',
	'myDj/html/webfonts/Icons/fa-brands-400.svg',
	'myDj/html/webfonts/Icons/fa-brands-400.tff',
	'myDj/html/webfonts/Icons/fa-brands-400.woff',
	'myDj/html/webfonts/Icons/fa-brands-400.woff2',
  
	'myDj/html/webfonts/Icons/fa-regular-400.eot',
	'myDj/html/webfonts/Icons/fa-regular-400.svg',
	'myDj/html/webfonts/Icons/fa-regular-400.tff',
	'myDj/html/webfonts/Icons/fa-regular-400.woff',
	'myDj/html/webfonts/Icons/fa-regular-400.woff2',
  
	'myDj/html/webfonts/Icons/fa-solid-900.eot',
	'myDj/html/webfonts/Icons/fa-solid-900.svg',
	'myDj/html/webfonts/Icons/fa-solid-900.tff',
	'myDj/html/webfonts/Icons/fa-solid-900.woff',
	'myDj/html/webfonts/Icons/fa-solid-900.woff2',
}