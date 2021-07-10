resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

author "barbaroNNs Scripts"
description 'https://discord.gg/VptvW6N6xy'
version '1.8.1'

client_scripts {
    'client/functions.lua',
    'client/client.lua',
    'client/nui.lua',
    'client/keys.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/functions.lua',
    'server/server.lua',
    'server/keys.lua',
}

ui_page 'html/index.html'
file 'html/index.html'