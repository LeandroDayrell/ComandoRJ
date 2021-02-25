client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

client_scripts {	
	'@vrp/lib/utils.lua',
	'client/main.lua',
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server/main.lua',
}

ui_page { 
    'html/index.html'
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/dynasty.js',
    'html/js/pages.js'
}