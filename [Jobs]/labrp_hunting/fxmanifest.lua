fx_version "bodacious"

author "Rio358, thelindat, DRKM43"
description "Hunting activity independant of any outside influence, see animal, murder animal, profit."
version "1.0.0.3"

game "gta5"

dependencies {
  'PolyZone',
  'labrp_Eye',
  'mythic_progbar',
  'mythic_notify',
--'utk_stress',
}

server_scripts {
  'server/main.lua'
}

client_scripts {
  'client/main.lua',
  'client/config.lua'
}
