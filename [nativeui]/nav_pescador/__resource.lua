client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/ui.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"nui/ui.html",
	"nui/ui.js",
	"nui/ui.css",
	"nui/corvina.png",
	"nui/dourado.png",
	"nui/lambari.png",
	"nui/pacu.png",
	"nui/pintado.png",
	"nui/pirarucu.png",
	"nui/salmao.png",
	"nui/tilapia.png",
	"nui/tucunare.png",
	"nui/graos.png",
	"nui/diamante.png",
	"nui/ouro.png",
	"nui/ferro.png",
	"nui/bronze.png",
	"nui/esmeralda.png",
	"nui/rubi.png",
	"nui/perolatratada.png",
}