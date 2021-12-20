client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version "adamant"
game "gta5" 

client_scripts {
   "client-side/*.lua"
}

files {
	"web-side/*",
	"web-side/**/*"
}

ui_page "web-side/index.html"
              