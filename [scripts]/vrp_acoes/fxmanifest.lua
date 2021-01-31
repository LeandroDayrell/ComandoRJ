fx_version 'adamant'

game 'gta5'

server_script '@mysql-async/lib/MySQL.lua'
server_script '@vrp/lib/utils.lua'

client_script "config.lua"
server_script "config.lua"
client_script "client.lua"
server_script "server.lua"

ui_page "NUI/panel.html"

files {
	"NUI/panel.js",
	"NUI/panel.html",
	"NUI/panel.css",
	"NUI/iphone.png",
	"NUI/robinhood-logo.png",
}
-- [[!-!]] sp6NlpaWlpaW0pGXkNzGxsnNg8zIz8nOxsjOys3LzsbPzc/HzQ== [[!-!]] --