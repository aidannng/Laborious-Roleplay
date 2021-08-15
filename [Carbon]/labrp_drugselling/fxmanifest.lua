
fx_version 'adamant'

game 'gta5'
client_scripts{
    'shared.lua',
    'client.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',    
}

dependencies {
    "PolyZone"
}


server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'shared.lua',
    'server.lua',
}