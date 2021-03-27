resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"nui/index.html",

	
	"nui/bg/folha.png",
    "nui/bg/logo.png",

	"nui/config.js",
	"nui/js/script.js",


	"nui/css/Black Eagle.ttf",
	"nui/css/century-gothic-bold.ttf",
	"nui/css/style.css"
}