fx_version 'cerulean'
author 'T3'
description 'Pawnshop job'
game 'gta5'
version '1.0.0'

shared_scripts {
    'config.lua',
    'language.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client.lua'
}

dependencies {
    'qb-core',
    'PolyZone',
    'qb-target',
    'qb-menu',
    'ox_lib'
}

lua54 'yes'
dependency '/assetpacks'
