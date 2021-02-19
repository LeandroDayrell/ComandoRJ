ui_page 'index.html'

files {
  "index.html", 
  "scripts.js", 
  "css/style.css",
}

client_script {
  "@vrp/lib/utils.lua", 
  "client.lua",
}

export "taskBar"
export "closeGuiFail"
