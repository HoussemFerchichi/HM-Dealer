fx_version 'cerulean'
game 'gta5'

description 'Dealer Script By @Houssem'
version '1.0.0'
author 'houssem'

shared_scripts {
    'config.lua'
}

server_script {
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
}
client_scripts {
    'client.lua'
}
ui_page 'html/index.html'

files{
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/images/*.png',
    'html/images/bg.jpg',
}
lua54 'yes'