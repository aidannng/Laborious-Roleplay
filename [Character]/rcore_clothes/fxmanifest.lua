fx_version 'bodacious' 
games { 'gta5' }

author 'Isigar <info@rcore.cz>'
description 'rcore.cz new clothing'
version '1.5.7'

ui_page 'client/html/index.html'

files {
    'client/html/*.js',
    'client/html/*.css',
    'client/html/img/*.png',
    'client/html/index.html',
}

server_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'server/extend/*.lua',
    'server/run.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'client/lib/*.lua',
    'client/extend/*.lua',
    'client/run.lua',
    'client/command.lua'
}

shared_scripts {
    'config.lua',
    'common.lua',
    'validate.lua',
}

dependencies {
    'es_extended',
    'skinchanger',
    'esx_skin',
    'esx_datastore',
}












