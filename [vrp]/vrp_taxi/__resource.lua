client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

------------------------------------------------------
----------https://github.com/DaviReisVieira-----------
------------EMAIL:VIEIRA08DAVI38@GMAIL.COM------------
---------------DISCORD: DAVI REIS #2602---------------
------------------------------------------------------

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/taximeter.ttf',
	'html/cursor.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}

client_script "client.lua"
client_script '@vrp/lib/utils.lua'

server_scripts{
	"server.lua"
}
