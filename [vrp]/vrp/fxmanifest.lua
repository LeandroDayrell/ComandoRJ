client_script "lib/lib.lua"

fx_version 'bodacious'
game 'gta5'

ui_page "gui/index.html"

server_scripts { 
	"lib/utils.lua",
	"base.lua",
	"queue.lua",
	"modules/gui.lua",
	"modules/group.lua",
	"modules/player_state.lua",
	"modules/business.lua",
	"modules/map.lua",
	"modules/money.lua",
	"modules/inventory.lua",
	"modules/identity.lua",
	"modules/survival.lua",
	"modules/home.lua",
	--"modules/home_components.lua",
	"modules/aptitude.lua",
	"modules/basic_items.lua",
	"modules/basic_skinshop.lua",
	"modules/cloakroom.lua",
	--"modules/item_transformer.lua",
}

client_scripts {
	"lib/utils.lua",
	"client/base.lua",
	"client/basic_garage.lua",
	"client/iplloader.lua",
	"client/gui.lua",
	"client/player_state.lua",
	"client/survival.lua",
	"client/map.lua",
	"client/notify.lua",
	"client/identity.lua",
	"client/police.lua"
}

files {
	"loading/index.html",
	"loading/*.jpg",
	"loading/*.css",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Luaseq.lua",
	"lib/Tools.lua",
	"gui/*.html",
	"gui/*.css",
	"gui/*.js",
	"gui/*.ttf"
}

loadscreen "loading/index.html"

server_export "AddPriority"
server_export "RemovePriority"