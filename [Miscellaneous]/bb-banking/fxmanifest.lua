fx_version 'adamant'
game 'gta5'

author 'barbaroNNs Scripts'
description 'https://discord.barbaronn.shop/'
version '1.0.5'

client_scripts {
    'locales/en.lua',
    
    'client/cconfig.lua',
    'client/cfuncs.lua',
    'client/cmain.lua'
}

server_scripts {
    'locales/en.lua',
    '@mysql-async/lib/MySQL.lua',

    'server/sconfig.lua',
    'server/sfuncs.lua',
    'server/smain.lua'
}

ui_page 'nui/index.html'
file 'nui/index.html'

server_exports {
    'RegisterNewAction'
}