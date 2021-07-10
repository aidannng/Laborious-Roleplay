fx_version 'cerulean'
game 'gta5'
author 'aidanohart'
description 'LABRP Admin System'
version '1.0'

shared_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_script {
    'client/client.lua',
    'client/spectate.lua'

}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua',
    'server/reports.lua',
    'server/Sspectate.lua',
    'server/logs.lua',
    'server/extraCommands.lua'

    }

ui_page {
    'ui/index.html'
    }
    
files {
    'ui/index.html',
    'ui/style.css',
    'ui/main.js'
    }
