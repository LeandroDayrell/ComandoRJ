client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

client_script 'SaltyClient/SaltyClient.net.dll'
server_script 'SaltyServer/SaltyServer.net.dll'

ui_page 'NUI/SaltyWebSocket.html'

files {
    'NUI/SaltyWebSocket.html',
    'Newtonsoft.Json.dll',
}

exports {
    'SetPlayerAlive',
    'EstablishCall',
    'EndCall',
    'SetPlayerRadioSpeaker',
    'SetPlayerRadioChannel',
    'RemovePlayerRadioChannel',
    'SetRadioTowers'
}

VoiceEnabled 'true'
ServerUniqueIdentifier '1Im1qyywLBryCL+sMthFA4Tg35E='
RequiredUpdateBranch 'Stable'
MinimumPluginVersion '2.0.1'
SoundPack 'default'
IngameChannelId '14'
IngameChannelPassword 'crj2020'
SwissChannelIds '15,16'