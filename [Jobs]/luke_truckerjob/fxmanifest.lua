fx_version 'cerulean'

game 'gta5'

author 'Luke - https://github.com/LukeWasTakenn'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    'config.lua',
    'client/client.lua'
}

server_scripts {
    '@mysql-async/lib/mysql.lua',
    'config.lua',
    'server/server.lua'
}

files {
    'html/index.html',
    'html/js/*.js',
    'html/css/*.css',
    'html/webfonts/*.ttf',
}