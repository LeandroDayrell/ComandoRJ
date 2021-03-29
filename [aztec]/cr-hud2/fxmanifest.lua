client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'

author 'AZTËC™#0001'
version '1.0.0'

client_scripts {
	'@vrp/lib/Utils.lua',
    'client/main.lua',
    'client/vehicle.lua'
}

ui_page 'client/html/index.html'
ui_page_preload 'yes'

files {
    'client/html/index.html',
    'client/html/assets/*.html',
    'client/html/assets/*.svg',
    'client/html/assets/*.png',
    'client/html/fonts/*.eot',
    'client/html/fonts/*.svg',
    'client/html/fonts/*.ttf',
    'client/html/fonts/*.woff',
    'client/html/fonts/*.woff2',
    'client/html/css/*.css',
    'client/html/js/*.js',
	}