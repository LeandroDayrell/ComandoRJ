--[[ az-inventory:config ]]--

vAZ.config = {}

vAZ.config.debug = false
vAZ.config.notAllowed = {
    'wcard'
}

vAZ.config.logs = false
vAZ.config.webhooks = {
    avatar = 'https://cdn.discordapp.com/avatars/265927810307194880/06e73fe629d06c0c4a77164e740961d6.png?size=1024',
    links = {
        player = {
            name = 'Players',
            url = ''
        },
        inspect = {
            name = 'Inspect',
            url = ''
        },
        vehicle = {
            name = 'Vehicles',
            url = ''
        },
        home = {
            name = 'Homes',
            url = ''
        },
        items = {
            name = 'Items',
            url = ''
        }
    }
}

vAZ.config.vaults = {
    -- LEGAL
    ["HOSPITAL"] = {
        weight = 5000,
        permission = "paramedico.permissao",
        webhook = ""
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
        weight = 1200,
        permission = "bau.bordel",
        webhook = ""
    },
    ["ADA"] = {
        weight = 700,
        permission = "bau.ada",
        webhook = ""
    },
    ["TCP"] = {
        weight = 700,
        permission = "bau.tcp",
        webhook = ""
    },
    ["CV"] = {
        weight = 700,
        permission = "bau.cv",
        webhook = ""
    },
    ["PCC"] = {
        weight = 700,
        permission = "bau.pcc",
        webhook = ""
    },
    ["DK"] = {
        weight = 700,
        permission = "bau.dk",
        webhook = ""
    },
    ["MC"] = {
        weight = 700,
        permission = "bau.mc",
        webhook = ""
    },
    ["COSA NOSTRA"] = {
        weight = 700,
        permission = "bau.cosanostra",
        webhook = ""
    },
    ["MILICIA"] = {
        weight = 700,
        permission = "bau.milicia",
        webhook = ""
    },
    ["YAKUZA"] = {
        weight = 700,
        permission = "bau.yakuza",
        webhook = ""
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
        webhook = ""
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
        webhook = ""
    }
}