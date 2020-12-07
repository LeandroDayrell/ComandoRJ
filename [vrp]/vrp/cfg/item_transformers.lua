
local cfg = {}

-- define static item transformers
-- see https://github.com/ImagicTheCat/vRP to understand the item transformer concept/definition

cfg.item_transformers = {

 ---------------------------------- FACÇÃO ADA ----------------------------------
     {   -- Oficina de armas
    name="Oficina de armas", -- menu name
    permissions = {"adafarm.permissao"}, -- you can add permissions
    r=0,g=200,b=0, -- color
    max_units=500,
    units_per_minute=50,
    x=1509.376953125,y=-1703.3171386719,z=90.99227142334, 
	-- 1509.376953125,-1703.3171386719,90.99227142334
    radius=5.0, height=1.5, -- area
    recipes = {
    ["FN Five Seven"] = { -- action name
    description="Construir FN Five Seven.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 1,
		}, -- items taken per unit
     products={ -- items given per unit
    ["wbody|WEAPON_PISTOL_MK2"] = 1
        }
      },
	["Bala FN Five Seven"] = { -- action name
    description="Construir Bala De FN Five Seven (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
	["polvora"] = 1,
		}, -- items taken per unit
    products={ -- items given per unit
	["wammo|WEAPON_PISTOL_MK2"] = 1
        }
      },
	["Advanced Rifle"] = { -- action name
    description="Construir Advanced Rifle.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["canoestendido_parts"] = 1,
	["carregador_parts"] = 6,
	["ferrolho_parts"] = 6,
		}, -- items taken per unit
    products={ -- items given per unit
	["wbody|WEAPON_ADVANCEDRIFLE"] = 1
        }
      },
	["Bala Advanced Rifle"] = { -- action name
    description="Construir Bala De Advanced Rifle (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
	["polvora"] = 1,
		}, -- items taken per unit
    products={ -- items given per unit
	["wammo|WEAPON_ADVANCEDRIFLE"] = 1
        }
      }
    }
  },
    ---------------------------------- FACÇÃO TCP ----------------------------------
     {   -- Oficina de armas
    name="Oficina de armas", -- menu name
    permissions = {"tcpfarm.permissao"}, -- you can add permissions
    r=0,g=200,b=0, -- color
    max_units=500,
    units_per_minute=50,
    x=797.99810791016,y=1144.1541748047,z=324.57702636719, 
	-- 797.99810791016,1144.1541748047,324.57702636719
    radius=5.0, height=1.5, -- area
    recipes = {
    ["FN Five Seven"] = { -- action name
    description="Construir FN Five Seven.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 1,
		}, -- items taken per unit
     products={ -- items given per unit
    ["wbody|WEAPON_COMBATPISTOL"] = 1
        }
      },
	["Bala FN Five Seven"] = { -- action name
    description="Construir Bala De FN Five Seven (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
	["polvora"] = 1,
		}, -- items taken per unit
    products={ -- items given per unit
	["wammo|WEAPON_COMBATPISTOL"] = 1
        }
      },
    ["Mini SMG"] = { -- action name
    description="Construir MINI SMG", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 4,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 2,
		}, -- items taken per unit
    products={ -- items given per unit
	["wbody|WEAPON_MINISMG"] = 1
        }
      },
	["Bala Mini Smg"] = { -- action name
    description="Construir Bala De MiniSMG (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
	["polvora"] = 1,
		}, -- items taken per unit
    products={ -- items given per unit
	["wammo|WEAPON_MINISMG"] = 1
        }
      }
    }
  },
  ---------------------------------- FACÇÃO CV - COMANDO VERMELHO ----------------------------------
     {   -- Oficina de armas
    name="Oficina de armas", -- menu name
    permissions = {"cvfarm.permissao"}, -- you can add permissions
    r=0,g=200,b=0, -- color
    max_units=500,
    units_per_minute=50,
    x=-858.60632324219,y=587.95196533203,z=103.08406829834, 
	-- -858.60632324219,587.95196533203,103.08406829834
    radius=5.0, height=1.5, -- area
    recipes = {
    ["FN Five Seven"] = { -- action name
    description="Construir FN Five Seven.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 1,
		}, -- items taken per unit
     products={ -- items given per unit
    ["wbody|WEAPON_COMBATPISTOL"] = 1
        }
      },
	["Bala FN Five Seven"] = { -- action name
    description="Construir Bala De FN Five Seven (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_COMBATPISTOL"] = 1
        }
      },
    ["Assault SMG"] = { -- action name
    description="Construir Assault SMG", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["canoestendido_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 2,
		}, -- items taken per unit
    products={ -- items given per unit
	["wbody|WEAPON_ASSAULTSMG"] = 1
        }
      },
	["Bala ASSAULT SMG"] = { -- action name
    description="Construir Bala De AssaultSMG (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_ASSAULTSMG"] = 1
        }
      }
    }
  },
    ---------------------------------- FACÇÃO PCC - TERCEIRO COMANDO PURO ----------------------------------
     {   -- Oficina de armas
    name="Oficina de armas", -- menu name
    permissions = {"pccfarm.permissao"}, -- you can add permissions
    r=0,g=200,b=0, -- color
    max_units=500,
    units_per_minute=50,
    x=55.346046447754,y=3719.9165039063,z=39.885620117188, 
	-- 55.346046447754,3719.9165039063,39.885620117188
    radius=5.0, height=1.5, -- area
    recipes = {
    ["FN Five Seven"] = { -- action name
    description="Construir FN Five Seven.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 1,
		}, -- items taken per unit
     products={ -- items given per unit
    ["wbody|WEAPON_COMBATPISTOL"] = 1
        }
      },
	["Bala FN Five Seven"] = { -- action name
    description="Construir Bala De FN Five Seven (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_COMBATPISTOL"] = 1
        }
      },
    ["Micro SMG"] = { -- action name
    description="Construir Assault SMG", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 3,
	["carregador_parts"] = 2,
	["ferrolho_parts"] = 2,
		}, -- items taken per unit
    products={ -- items given per unit
	["wbody|WEAPON_MICROSMG"] = 1
        }
      },
	["Bala MicroSMG"] = { -- action name
    description="Construir Bala De MicroSMG (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_MICROSMG"] = 1
        }
      },
    }
  },
  ---------------------------------- FACÇÃO MC - MOTO CLUBE ----------------------------------
     {   -- Oficina de armas
    name="Oficina de armas", -- menu name
    permissions = {"motoclub.permissao"}, -- you can add permissions
    r=0,g=200,b=0, -- color
    max_units=500,
    units_per_minute=50,
    x=889.47900390625,y=-2109.2907714844,z=35.591674804688, 
	-- 889.47900390625,-2109.2907714844,35.591674804688
    radius=5.0, height=1.5, -- area
    recipes = {
    ["FN Five Seven"] = { -- action name
    description="Construir FN Five Seven.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 1,
		}, -- items taken per unit
     products={ -- items given per unit
    ["wbody|WEAPON_COMBATPISTOL"] = 1
        }
      },
	["Bala FN Five Seven"] = { -- action name
    description="Construir Bala De FN Five Seven (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_COMBATPISTOL"] = 1
        }
      },
    ["Colete"] = { -- action name
    description="Construir Fireworks.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["dinheirosujo_money"] = 20000
		}, -- items taken per unit
    products={ -- items given per unit
    ["body_armor"] = 1
        }
    },
    ["SMG"] = { -- action name
    description="Construir SMG", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["canoestendido_parts"] = 1,
	["carregador_parts"] = 2,
	["ferrolho_parts"] = 2,
		}, -- items taken per unit
    products={ -- items given per unit
	["wbody|WEAPON_SMG"] = 1
        }
      },
	["Bala SMG"] = { -- action name
    description="Construir Bala De SMG (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_SMG"] = 1
        }
      }
    }
  },
  ---------------------------------- FACÇÃO YAKUZA - DRIFT KING ----------------------------------
     {   -- Oficina de armas
    name="Oficina de armas", -- menu name
    permissions = {"yakuza.permissao"}, -- you can add permissions
    r=0,g=200,b=0, -- color
    max_units=500,
    units_per_minute=50,
    x=-886.99041748047,y=-1444.0910644531,z=7.5268058776855, 
	-- -886.99041748047,-1444.0910644531,7.5268058776855
    radius=5.0, height=1.5, -- area
    recipes = {
    ["FN Five Seven"] = { -- action name
    description="Construir FN Five Seven.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 1,
		}, -- items taken per unit
     products={ -- items given per unit
    ["wbody|WEAPON_COMBATPISTOL"] = 1
        }
      },
	["Bala FN Five Seven"] = { -- action name
    description="Construir Bala De FN Five Seven (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_COMBATPISTOL"] = 1
        }
      },
    ["MINI SMG"] = { -- action name
    description="Construir MINI SMG", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 4,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 2,
		}, -- items taken per unit
    products={ -- items given per unit
	["wbody|WEAPON_MINISMG"] = 1
        }
      },
	["Bala MINI SMG"] = { -- action name
    description="Construir Bala De MINISMG (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_MINISMG"] = 1
        }
      }
    }
  },
  ---------------------------------- FACÇÃO MAFIA ----------------------------------
   {   -- Oficina de armas
    name="Oficina de armas fdn", -- menu name
    permissions = {"mafia.permissao"}, -- you can add permissions
    r=0,g=200,b=0, -- color
    max_units=500,
    units_per_minute=50,
    x=-2675.8386230469,y=1335.72265625,z=140.88143920898, 
 --	 -2675.8386230469,1335.72265625,140.88143920898
    radius=5.0, height=1.5, -- area
    recipes = {
    ["FN Five Seven"] = { -- action name
    description="Construir FN Five Seven.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 1,
		}, -- items taken per unit
     products={ -- items given per unit
    ["wbody|WEAPON_COMBATPISTOL"] = 1
        }
      },
	["Bala FN Five Seven"] = { -- action name
    description="Construir Bala De FN Five Seven (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_COMBATPISTOL"] = 1
        }
      },
    ["AK-47"] = { -- action name
    description="Construir AK-47 ", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["canoestendido_parts"] = 2,
	["cano_parts"]=2,
	["carregador_parts"] = 2,
	["ferrolho_parts"] = 2,
		}, -- items taken per unit
    products={ -- items given per unit
	["wbody|WEAPON_ASSAULTRIFLE"] = 1
        }
      },
	["Bala AK-47"] = { -- action name
    description="Construir Bala De AK-47 (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_ASSAULTRIFLE"] = 1
        }
      }
    }
  },
  ---------------------------------- FACÇÃO MILICIA ----------------------------------
     {   -- Oficina de armas
    name="Oficina de armas", -- menu name
    permissions = {"milicia.permissao"}, -- you can add permissions
    r=0,g=200,b=0, -- color
    max_units=500,
    units_per_minute=50,
    x=486.34066772461,y=3030.3310546875,z=45.248672485352, 
	--  486.34066772461,3030.3310546875,45.248672485352
    radius=5.0, height=1.5, -- area
    recipes = {
    ["FN Five Seven"] = { -- action name
    description="Construir FN Five Seven.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["cano_parts"] = 2,
	["carregador_parts"] = 1,
	["ferrolho_parts"] = 1,
		}, -- items taken per unit
     products={ -- items given per unit
    ["wbody|WEAPON_COMBATPISTOL"] = 1
        }
      },
	["Bala FN Five Seven"] = { -- action name
    description="Construir Bala De FN Five Seven (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_COMBATPISTOL"] = 1
        }
      },
    ["AK-47"] = { -- action name
    description="Construir AK-47 ", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["canoestendido_parts"] = 2,
	["cano_parts"]=2,
	["carregador_parts"] = 2,
	["ferrolho_parts"] = 2,
		}, -- items taken per unit
    products={ -- items given per unit
	["wbody|WEAPON_ASSAULTRIFLE"] = 1
        }
      },
	["Bala AK-47"] = { -- action name
    description="Construir Bala De AK-47 (1 Polvora e 1 Capsula).", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["capsula"] = 1,
    ["polvora"] = 1,
        }, -- items taken per unit
    products={ -- items given per unit
    ["wammo|WEAPON_ASSAULTRIFLE"] = 1
        }
      }
    }
  },
}

-- define transformers randomly placed on the map
cfg.hidden_transformers = {
  ["Lavagem 20%"] = {
    def = {
    name="Lavagem 20%", -- menu name
    r=255,g=125,b=0, 
    max_units=10000,
    units_per_minute=10000,
    radius=2, height=1.0, -- area
    recipes = {
    ["Lavar Dinheiro"] = { -- action name
    description="Lavar dinheirosujo_money.", -- action description
    in_money=0, -- money taken per unit
    out_money=0, -- money earned per unit
    reagents={
    ["dinheirosujo_money"] = 0
    }, -- items taken per unit
    products={}, -- items given per unit
    aptitudes={} -- optional
        }
      }
    },
    positions = {
    --{24.844825744629,7644.005859375,19.034078598022}
    }
  }
}

-- time in minutes before hidden transformers are relocated (min is 5 minutes)
cfg.hidden_transformer_duration = 5*24*60 -- 5 days

-- configure the information reseller (can sell hidden transformers positions)
cfg.informer = {
    infos = {
    ["Lavagem 20%"] = 0
  },
    positions = {
    --{1297.0148925781,-3349.7238769531,5.9015917778015}
  },
    interval = 12222, -- interval in minutes for the reseller respawn
    duration = 10, -- duration in minutes of the spawned reseller
    blipid = 133,
    blipcolor = 2
}

return cfg