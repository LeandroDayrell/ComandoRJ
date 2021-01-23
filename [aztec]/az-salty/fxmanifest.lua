fx_version 'bodacious'
game 'gta5'

author 'AZTËC™#0001'
description 'build: 0.1'

client_scripts {
	'@vrp/lib/utils.lua',
    'client/main.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server/main.lua'
}

ui_page 'client/html/index.html'
ui_page_preload 'yes'

files {
	'client/html/index.html',
	'client/html/js/*',
	'client/html/css/*',
	'client/html/fonts/*'
}

dependencies {
    'vrp',
    'saltychat',
} 