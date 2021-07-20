fx_version 'adamant'
game 'gta5'

client_scripts {
	'Interiors/client/main.lua', -- INTERIORS
	'Interiors/client/shells.lua', -- INTERIORS
	'Interiors/client/furnished.lua', -- INTERIORS
	'AssignMotel/client/functions.lua',
	'AssignMotel/client/instance.lua',
	'AssignMotel/client/purchase.lua',
	'AssignMotel/client/rooms.lua',
	'AssignMotel/client/storage.lua',
	'AssignMotel/client.lua',
	'Keysystem/client/*.lua',
	'Apartments/client/*.lua'
}
 
shared_script {
	'AssignMotel/config/config.lua',
	'AssignMotel/config/shells.lua',
	'AssignMotel/config/spawnpoints.lua',
	'AssignMotel/config/translation.lua',
	'AssignMotel/config.lua',
	'Keysystem/config.lua',
	'Apartments/config/*.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'AssignMotel/server/instances.lua',
	'AssignMotel/server/rent.lua',
    'AssignMotel/server/server.lua',
    'AssignMotel/server/storage.lua',
	'AssignMotel/server.lua',
	'Keysystem/server/*.lua',
	'Apartments/server/*.lua'
}

files {
	'playerhouse_hotel/playerhouse_hotel.ytyp',-- INTERIORS
	'stream/playerhouse_hotel/playerhouse_hotel.ytyp',-- INTERIORS
	'stream/playerhouse_tier3/playerhouse_tier3.ytyp',-- INTERIORS
}

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_20.ytyp'-- INTERIORS
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_hotel/playerhouse_hotel.ytyp'-- INTERIORS
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier1/playerhouse_tier1.ytyp'-- INTERIORS
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier3/playerhouse_tier3.ytyp'-- INTERIORS

exports {
	'DespawnInterior',-- INTERIORS
	'CreateMotel',-- INTERIORS
	'CreateTier1House',-- INTERIORS
	'CreateTier2House',-- INTERIORS
	'CreateTier3House',-- INTERIORS

	'CreateTier1HouseFurnished',-- INTERIORS
}