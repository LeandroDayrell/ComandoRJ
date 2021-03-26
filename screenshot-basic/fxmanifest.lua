client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'

game 'gta5'

client_script 'dist/client.js'
server_script 'dist/server.js'

dependency 'yarn'
dependency 'webpack'

webpack_config 'client.config.js'
webpack_config 'server.config.js'
webpack_config 'ui.config.js'

files {
    'dist/ui.html'
}

ui_page 'dist/ui.html'
