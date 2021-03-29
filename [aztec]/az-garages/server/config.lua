vAZ.config = {}

vAZ.config.fines = true
vAZ.config.fare = true
vAZ.config.stolen = 0.01
vAZ.config.seized = 0.02
vAZ.config.ipva = 0.02

vAZ.config.garages = {}
vAZ.config.garages.service = {
     [1] = {
        permission = 'pmerj.permissao',
        vehicles = {
            "corollarj",
            "r1250rj",
            "xtz",
            "focusrj",
            "urusrj",
            "frontierrj",
            "hiluxpolicia",
            "jeepprf",
            "bmwm8prf",
            "amarokprf",
            "q8pc",
            "jeeppc",
            "pranger",
            "pbus",
            "policet",
            "amarokrj"
        }
    },
    [2] = {
        permission = 'pmerj.permissao',
        vehicles = {
            "predator"
        }
    },
    [3] = {
        permission = 'pmerj.permissao',
        vehicles = {
            "polmav",
            "swift"
        }
    },
    [4] = {
        permission = 'paramedico.permissao',
        vehicles = {
            "mercambulancia",
		    "fordambulancia",
		    "wheelchair",
		    "hiluxpolicia",
		    "ambulance",
		    "jeepsamu"
        }
    },
    [5] = {
        permission = 'weazel.permissao',
        vehicles = {
            "rumpo",
        }
    },
    [6] = {
        permission = 'paramedico.permissao',
        vehicles = {
            "samumav",
        }
    },
    [7] = {  
        permission = 'mecanico.permissao',
        vehicles = {
            "flatbed",
            "slamtruck",
            "flatbed3",
        }
    },
    [8] = {
        permission = 'taxista.permissao',
        vehicles = {
            "taxi"
        }
    },
    [9] = {
        permission = 'bope.permissao',
        vehicles = {
            "amarokbope",
            "frontierbope",
            "caveiraobope",
            "riot"
        }
    },
    [10] = {
        permission = 'motoclub.permissao',
        vehicles = {
            "deathbike",
            "hexer",
            "sanctus",
            "gargoyle"
        }
    },
    [11] = {
        permission = 'weazel.permissao',
        vehicles = {
            "frogger"
        }
    },
    [12] = {
        permission = 'dkfarm.permissao',
        vehicles = {
            "buccanner2",
            "faction2",
            "faction3",
            "moonbeam2",
            "sabregt2",
            "voodoo",
		    "chino2"
        }
    },
   
    [13] = {
        vehicles = {
            "boxville2",
            "tribike3"
        }
    },
    [14] = {
        vehicles = {
            "trash",
            "trash2"
        }
    },
    [15] = {
        vehicles = {
            "phantom",
		    "packer"
        }
    },
    [16] = {
		permission = 'pescador.garagem',
        vehicles = {
            "dinghy"
        }
    },
    [17] = {
        vehicles = {
            "dinghy"
        }
    },
    [18] = {
		permission = 'pescador.garagem',
        vehicles = {
            "dinghy"
        }
    },
    [19] = {
        vehicles = {
            "dinghy"
        }
    },
    [20] = {
        vehicles = {
            "bus"
        }
    },
	[21] = {
        vehicles = {
            "seashark3",
        }
    },
	[22] = {
        vehicles = {
            "avisa",
        }
    },
	[23] = {
        vehicles = {
            "rebel",
        }
    }
}

vAZ.config.garages.rental = {
    [1] = {
        price = 100,
        vehicles = {
            'scorcher',
            'tribike',
            'tribike2',
            'tribike3',
            'fixter',
            'cruiser',
            'bmx'
        }
    },
    [2] = {
        price = 100,
        vehicles = {
            'scorcher',
            'tribike',
            'tribike2',
            'tribike3',
            'fixter',
            'cruiser',
            'bmx'
        }
    },
    [3] = {
        price = 100,
        vehicles = {
            'scorcher',
            'tribike',
            'tribike2',
            'tribike3',
            'fixter',
            'cruiser',
            'bmx'
        }
    },
    [4] = {
        price = 100,
        vehicles = {
            'tractor2',
            'rebel'
        }
    }
}

vAZ.config.garages.private = {}

vAZ.config.garages.personal = {
    price = 100,
    max = 5
}

vAZ.config.garages.home = {
    price = 100,
    max = 5
}

vAZ.getServerGarage = function(type, id)
    if vAZ.config.garages[type] then
        if type == 'home' then
            return vAZ.config.garages.home
        elseif type == 'personal' then
            return vAZ.config.garages.personal
        elseif vAZ.config.garages[type][id] then
            return vAZ.config.garages[type][id]
        end
    end
    return nil
end