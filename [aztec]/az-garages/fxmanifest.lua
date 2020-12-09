fx_version 'bodacious'
game 'gta5'

client_scripts {
    '@vrp/lib/utils.lua',
    'client/main.lua',
    'client/lock.lua',
    'client/utils.lua',
    'client/entities.lua',
    'client/config.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'server/main.lua',
    'server/plate.lua',
    'server/lock.lua',
    'server/config.lua',
}

ui_page 'client/html/index.html'
ui_page_preload 'yes'

files {
    'client/html/*',
    'client/html/js/*',
    'client/html/img/*',
    'client/html/css/*',
}