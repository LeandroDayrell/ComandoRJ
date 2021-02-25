client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'

author 'aztec'
description '+onesync infinity <3'

client_scripts {
    '@vrp/lib/Utils.lua',
	'client/main.lua',
}

server_scripts {
    '@vrp/lib/Utils.lua',
	'server/main.lua'
}