client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

author ''
description ''
version ''

ui_page 'nui/ui.html'

client_script {
    '@vrp/lib/utils.lua',
    'client.lua',
}

server_script {
    '@vrp/lib/utils.lua',
    'server.lua'
}

files {
	'nui/ui.html',
	'nui/ui.js',
	'nui/ui.css',
	'nui/images/lojinha.png',
	'nui/images/ak103pack.png',
	'nui/images/algemas.png',
	'nui/images/bombaadesiva.png',
	'nui/images/c4.png',
	'nui/images/capuz.png',
	'nui/images/coletepack.png',
	'nui/images/fivesevenpack.png',
	'nui/images/mtarpack.png',
	'nui/images/municaoakpack.png',
	'nui/images/municaofamaspack.png',
	'nui/images/municaomusketpack.png',
	'nui/images/municaoparafalpack.png',
	'nui/images/municaopistolpack.png',
	'nui/images/municaopumppack.png',
	'nui/images/municaosigpack.png',
	'nui/images/municaosnspack.png',
	'nui/images/municaouzipack.png',
	'nui/images/musketpack.png',
	'nui/images/parafalpack.png',
	'nui/images/pendrive.png',
	'nui/images/pumpshotgunpack.png',
	'nui/images/sigpack.png',
	'nui/images/snspack.png',
	'nui/images/uzipack.png',
}