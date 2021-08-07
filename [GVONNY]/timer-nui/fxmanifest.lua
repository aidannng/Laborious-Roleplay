fx_version 'adamant'

game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/index.css',
	'html/index.js',
	'html/reset.css',
	'html/jquery-3.4.1.min.js',
	'html/img/*.png'
}

client_scripts {
	'nui.lua',
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua'
}

server_scripts{
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
} 

exports {
	'AddCircleZone',
	'AddBoxZone',
	'AddPolyZone'
}