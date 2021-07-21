fx_version 'cerulean'

game 'gta5'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/EntityZone.lua',
    'Mail/config.lua',
    'Mail/client/client.lua',
}

server_scripts {
    'Mail/config.lua',
    'Mail/server/version_check.lua',
    'Mail/server/server.lua',
}
