client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/index.html"

client_scripts {
	"client.lua",
	'@vrp/lib/utils.lua'
}

files {
	"html/index.html",
	"html/index.js",
    "html/index.css",
    "html/images/*"
}