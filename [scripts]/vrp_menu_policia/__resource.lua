client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"


description "vRP barbershop"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
ui_page {
	"html/index.html"
}
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',  
    'html/jquery-ui.css',  
	'html/reset.css',
}
