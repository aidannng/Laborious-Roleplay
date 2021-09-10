fx_version 'adamant'

game 'gta5'

version '1.2.0'


server_scripts {
	'server/server.lua'
}

client_scripts {
	'client/client.lua',
	'config.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
}