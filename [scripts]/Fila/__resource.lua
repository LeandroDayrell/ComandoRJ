client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script "@vrp/lib/utils.lua"
client_script "client/client.lua"
server_script "server/server.lua"

server_export "AddPriority"
server_export "RemovePriority"