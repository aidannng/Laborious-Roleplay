fx_version "adamant"

game "gta5"

-- client_scripts {
--     "meth.lua",
--     "config.lua",
-- 	"cocain.lua",
--     "weed.lua",
--     --"cornerholding.lua",
--     "laundry.lua",
-- }

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "meth.lua",
    "config.lua",
	"cocain.lua",
    "weed.lua"
}

server_scripts {
    "server.lua",
    "config.lua",
}