fx_version 'adamant'
game 'gta5'
author 'abandoncaptian'
description 'abandons script'
version '1.0'

shared_script 'config.lua'

client_script {
    'client.lua',
    'nui.lua'
}

ui_page "html/index.html"
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css'
}