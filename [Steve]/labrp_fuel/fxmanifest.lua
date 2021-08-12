fx_version 'adamant'

game 'gta5'

version '1.0.3'


server_scripts {
	'server/server.lua'
}

client_scripts {
    'config.lua',
	'client/client.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
}