fx_version 'adamant'
game 'gta5'

dependencies 'vrp'

ui_page 'html/ui.html'
files {
    'html/ui.html',
    'html/ui.css',
    'html/ui.js',
    'html/fonts/big_noodle_titling-webfont.woff',
    'html/fonts/big_noodle_titling-webfont.woff2',
    'html/fonts/pricedown.ttf',
    'mpheist3/shop_tattoo.meta',
    'mpheist3/mpheist3_overlays.xml',
    'mpvinewood/shop_tattoo.meta',
    'mpvinewood/mpvinewood_overlays.xml',
}
 
server_scripts{
    "@vrp/lib/utils.lua",
    "nyo_tattoo_cfg.lua",
    "nyo_tattoo_sv.lua"
}

client_script {
    "@vrp/lib/utils.lua",
    "nyo_tattoo_cl.lua"
}

data_file 'TATTOO_SHOP_DLC_FILE' 'mpheist3/shop_tattoo.meta'
data_file 'PED_OVERLAY_FILE' 'mpheist3/mpheist3_overlays.xml'
data_file 'TATTOO_SHOP_DLC_FILE' 'mpvinewood/shop_tattoo.meta'
data_file 'PED_OVERLAY_FILE' 'mpvinewood/mpvinewood_overlays.xml'



