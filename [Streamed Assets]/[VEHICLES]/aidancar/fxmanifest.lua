fx_version 'cerulean'
game 'gta5'

files {
  'vehiclelayouts.meta',
  'handling.meta',
  'vehicles.meta',
  'carcols.meta',
  'carvariations.meta',
  'audioconfig/m5cracklemod_game.dat151.rel',
	'audioconfig/m5cracklemod_sounds.dat54.rel',
	'sfx/dlc_m5cracklemod/m5cracklemod.awc',
	'sfx/dlc_m5cracklemod/m5cracklemod_npc.awc'
}

data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'AUDIO_GAMEDATA' 'audioconfig/m5cracklemod_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/m5cracklemod_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_m5cracklemod'




client_script 'vehicle_names.lua'
