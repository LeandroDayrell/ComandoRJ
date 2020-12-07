fx_version 'bodacious'
game 'gta5'

author 'AZTËC™#0001'
description '! KyRinGa#7172'
version '1.0.0'

client_scripts {
    '@vrp/lib/utils.lua',
    'client/main.lua',
    'client/lock.lua',
    'client/entities.lua',
    'client/utils.lua',
    'config.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'server/main.lua',
    'config.lua'
}

ui_page 'client/html/index.html'

files {
    'client/html/index.html',
    'client/html/css/*.css',
    'client/html/img/*.png',
    'client/html/img/*.jpg',
    'client/html/img/*.svg',
    'client/html/js/*.js'
}