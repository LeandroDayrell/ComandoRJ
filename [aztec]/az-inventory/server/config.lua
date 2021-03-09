--[[ az-inventory:config ]]--

vAZ.config = {}

vAZ.config.debug = false
vAZ.config.notAllowed = {
    'wcard'
}

vAZ.config.logs = true
vAZ.config.webhooks = {
    avatar = 'https://cdn.discordapp.com/avatars/265927810307194880/06e73fe629d06c0c4a77164e740961d6.png?size=1024',
    links = {
        player = {
            name = 'Players',
            url = 'https://discord.com/api/webhooks/817413030681116723/zgeJ7AAl3uGYnSfx58904il8NHnDX2PS81_1i2iIxZUsCn-UcA9IldYFrix8dMTEaHhc'
        },
        inspect = {
            name = 'Inspect',
            url = 'https://discord.com/api/webhooks/817413215230361660/8VeHnJrBgyuRXqK8biKLT6DnhKZ6_i658CXJSylvS5jj3g9SQUVLGDiXrhfviVeV3ZU0'
        },
        vehicle = {
            name = 'Vehicles',
            url = 'https://discord.com/api/webhooks/817413171270123600/ccKKP2y9VE1kVpLixf4YWh3c-HKg8YOGTD01xfbpucsS-jNNd2izcyYNTQ35LE0APn9s'
        },
        home = {
            name = 'Homes',
            url = 'https://discord.com/api/webhooks/817413118942642197/ndWwdy5QeZBakUK6XbdYwJCOJgnJYamDvJvEQpFTmSKLdAvHmjxjumR9uZMQ9a9plcir'
        },
        items = {
            name = 'Items',
            url = 'https://discord.com/api/webhooks/817413073840242738/ROjIF3kgDzd4aJ1ULhYqUFuhoCHyJMcFUdXnCqG7qRChk_AAx6Q3nl4EuioUhVSCsx-E'
        }
    }
}

vAZ.config.vaults = {
    -- LEGAL
    ["HOSPITAL"] = {
        weight = 5000,
        permission = "paramedico.permissao",
        webhook = "https://discord.com/api/webhooks/817413984176570399/ABIV_9R6aD1tGCZ0l1iqn8TUPXzPgg31xZE5EElPEdgKkqs81nuOLryKmkUNp_Bg0J2v"
    },
    --[[
    ["UNIMED"] = {
        weight = 5000,
        permission = "paramedico.permissao",
        webhook = ""
    },
    ["AD"] = {
        weight = 5000,
        permission = "paramedico.permissao",
        webhook = ""
    },
    ["RIO EXPRESS"] = {
        weight = 5000,
        permission = "paramedico.permissao",
        webhook = ""
    },
    ]]--
    -- ILEGAL
    ["BORDEL"] = {
        weight = 1500,
        permission = "bau.bordel",
        webhook = "https://discord.com/api/webhooks/817414020906614805/EvqtO1cqZoZom3QAXnrgNGjSjUN5aaFM9X6qSa-U7h3tf2MpKIzOJfgtPV9Wh_2cs2WW"
    },
    ["ADA"] = {
        weight = 1500,
        permission = "bau.ada",
        webhook = "https://discord.com/api/webhooks/817414065000677387/4jIzZ2c50_x5IOn4XHQKY8QvxBef0Md0jzZ52589rVeraWVRBNnmWiEE8PGLUwu4C3fd"
    },
    ["TCP"] = {
        weight = 1500,
        permission = "bau.tcp",
        webhook = "https://discord.com/api/webhooks/817414110601936956/r7qB0nHzSemb-4gwyQTjcV6wKkr5WhyWcdF2LnErh8n7OUhnVnwbnf8kg5DfO0DeZcM6"
    },
    ["CV"] = {
        weight = 1500,
        permission = "bau.cv",
        webhook = "https://discord.com/api/webhooks/817414166527606826/IPQ7OsJ3S-gNVH4pUUZ6-1YoFz9ftHIIjc_0HrZPFCD23A9oDfqXEO-jAy3JsGFam5Jy"
    },
    ["PCC"] = {
        weight = 1500,
        permission = "bau.pcc",
        webhook = "https://discord.com/api/webhooks/817414211055124512/UqGeLSQpDY0KmTJPWnf15347hD20jJxT8lWwfSZgoWT-NQGV0qjl1Qg2tsASmWGp_ysp"
    },
    ["DK"] = {
        weight = 1500,
        permission = "bau.dk",
        webhook = "https://discord.com/api/webhooks/817414276691656706/JsAERK5fwIy7aEYNTKj2TJrdXPx62a4UnoNcM_0c66bo1jIr2Whr0atO7Up3euIIQpx4"
    },
    ["MC"] = {
        weight = 1500,
        permission = "bau.mc",
        webhook = "https://discord.com/api/webhooks/817414318777827379/Eie8HhOomzekbzTkQtwkf8CauLnbZ2tTLySaJDVBZvjEB-SUhsBuOZkdw4YdnWWCN9h5"
    },
    ["COSA NOSTRA"] = {
        weight = 1500,
        permission = "bau.cosanostra",
        webhook = "https://discord.com/api/webhooks/817414355435782175/lInXQ8RQg5KFjCIctmB-DlorZO0WNKWhJZT8hTEGYh0k3n9s_1xzh_CYLkQ_dwmAp3Ry"
    },
    ["MILICIA"] = {
        weight = 1500,
        permission = "bau.milicia",
        webhook = "https://discord.com/api/webhooks/817414402668101652/pPetCPND-CDZuD3j8LxQtrd1rFCVX6s8uhFytgqhbF9VIHBr6AqG-1S5KCze2LwwAahP"
    },
    ["YAKUZA"] = {
        weight = 1500,
        permission = "bau.yakuza",
        webhook = "https://discord.com/api/webhooks/817414436008361985/OIMdHybXbG9X-gXowU--D3nWnJYv4wgnlHwIM5VpklT76w7j4FTJaswn--lSRnVBFzMD"
    },
    --[[
    ["FDN"] = {
        weight = 700,
        permission = "bau.fdn",
        webhook = ""
    },
    ["BD"] = {
        weight = 700,
        permission = "bau.bd",
        webhook = ""
    },
    ]]--
    
    -- POLICIA
    ["POLICIA PMRJ"] = {
        weight = 1200,
        permission = "bau.pm",
        webhook = "https://discord.com/api/webhooks/817414509152305192/XGQMRJpi3OGIVVPiVyx1dd_P9ANd9ylq5CGvSdxh_adShHFDKmDISvgGjS24tyWKNqS-"
    },    
    ["POLICIA PC"] = {
        weight = 2000,
        permission = "bau.pc",
        webhook = ""
    },
    ["POLICIA PF"] = {
        weight = 1200,
        permission = "bau.pf",
        webhook = ""
    },
    ["POLICIA PRF"] = {
        weight = 1200,
        permission = "bau.prf",
        webhook = ""
    },
    ["BOPE"] = {
        weight = 1200,
        permission = "bau.bope",
        webhook = "https://discord.com/api/webhooks/817414575661645904/EfIRZO6-Cvae0ElWo7hp4SmZKBm5hgW1-VSDLp1EBHDtYz50_kIlIScNsgZfQ__5mQyL"
    }
}