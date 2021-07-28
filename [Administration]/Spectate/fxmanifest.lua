fx_version 'cerulean'

game 'gta5'
author 'Ali Exacute#2588'
discord 'https://discord.com/invite/Mgyg2nVRhC'
description 'Advanced Spectate Script'
version '1.0.0'

shared_scripts {
    'config.lua',
    'shared/translations.lua',
	'shared/utils.lua'
}

client_scripts {
    'client/warmenu.lua',
    'client/client.lua'
}

server_script 'server/server.lua'


export 'HavePermission' -- usage : exports.AdvancedSpectate:HavePermission() -- NOTE : will return a table of user permissions or false if player dont have any perms
export 'OpenMenu'       -- usage : exports.AdvancedSpectate:OpenMenu(forceOpen)       -- NOTE : will only work if player have permission to the menu | forceOpen can be true or false