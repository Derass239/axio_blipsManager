-----------------------------------------------
------ Axio Blips Manager by Derass#4974 ------
-----------------------------------------------

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author "Derass#4974"

description "Blips Managers"

version "1.0.0"

shared_scripts {
    '@ox_lib/init.lua'
}


client_scripts {
    'client.lua',
    'menu.lua',
}

files {
    'locales/*.json'
}