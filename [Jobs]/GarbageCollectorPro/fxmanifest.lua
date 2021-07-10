fx_version 'bodacious'
games { 'gta5' }

author 'Codineer Digital'
description 'Garbage Collector Pro - Being a garbage man: more fun than ever before!'
version '1.1'

files {
	'font.json',
	'Newtonsoft.Json.dll',
	'GarbageCollectorProShared.dll',
	'CodineerVerification.dll',
	'*.json',
	'index.html',
	'MenuAPI.dll',
	'assets/css/styles.min.css',
	'assets/bootstrap/css/bootstrap.min.css',
	'assets/bootstrap/js/bootstrap.min.js',
	'assets/js/script.min.js',
	'assets/js/jquery-ui.min.js',
	'assets/fonts/font-awesome.min.css',
	'assets/fonts/FontAwesome.otf',
	'assets/fonts/fontawesome-webfont.eot',
	'assets/fonts/fontawesome-webfont.svg',
	'assets/fonts/fontawesome-webfont.ttf',
	'assets/fonts/fontawesome-webfont.woff',
	'assets/fonts/fontawesome-webfont.woff2'
}

ui_page 'index.html'


client_scripts {
	'GarbageCollectorPro.net.dll'
}

server_scripts {
	'GarbageCollectorProServer.net.dll'
}