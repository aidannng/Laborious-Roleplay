fx_version "adamant"
game "gta5"

shared_script "config/*.lua"
client_script "client/*.lua"
server_script {
    "@mysql-async/lib/MySQL.lua",
    "server/*.lua"
}

-- Motel script by Loaf Scripts#7785