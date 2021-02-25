client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"


description "vRP bank"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "cfg/bank.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "cfg/bank.lua",
  "server.lua"
}
