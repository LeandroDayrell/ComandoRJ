local cfg = {}

-- define each group with a set of permissions
-- _config property:
--- title (optional): group display name
--- gtype (optional): used to have only one group with the same gtype per player (example: a job gtype to only have one job)
--- onspawn (optional): function(player) (called when the player spawn with the group)
--- onjoin (optional): function(player) (called when the player join the group)
--- onleave (optional): function(player) (called when the player leave the group)
--- (you have direct access to vRP and vRPclient, the tunnel to client, in the config callbacks)

cfg.groups = {

 ["FundadorCMDRJ20"] = {
	"admin.permissao",
	"fix.permissao",
	"dv.permissao",
	"blips.permissao",
	"god.permissao",
	"ac.permissao",
	"adminskin.permissao",
	"wl.permissao",
	"kick.permissao",
	"ban.permissao",
	"unban.permissao",
	"money.permissao",
	"reset.permissao",
	"noclip.permissao",
	"ticket.permissao",
	"tp.permissao",
	"adminanimacao.permissao",
	"spawncar.permissao",
	"msg.permissao",
	-- Administração
	"player.group.add",
    "player.group.remove",
    "player.givemoney",
    "player.giveitem",
	"admin.spawnveh",
	"admin.godmode",
	"admin.tickets",
    "admin.announce",
    "player.list",
	"admin.crun",
	"admin.blips",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
	"admin.sprites",
	"admin.srun",
    "player.noclip",
	"admin.tptowaypoint",
	"admin.deleteveh",
    "player.custom_emote",
    "player.custom_sound",
    "player.display_custom",
    "player.coords",
    "player.tptome",
    "player.tpto",
	-- Salario
	"Administrador.permissao",
	"admin.ajuda",
	"player.blips",
	"player.spec",
	"player.noclip",
	"player.secret",
	"player.wall",
	"mqcu.permissao",
	},
 
	["god"] = {
	"god.permissao",
	},
	
	["dv"] = {
	"dv.permissao",
	},
	
	["meautorizado"] = {
	"me.permissao",
	},
 
 --== ADMINISTRAÇÃO ==--
  ["AdmCMDRJ"] = {
	"admin.permissao",
	"fix.permissao",
	"dv.permissao",
	--"blips.permissao",
	"god.permissao",
	"ac.permissao",
	"adminskin.permissao",
	"wl.permissao",
	"kick.permissao",
	"ban.permissao",
	"unban.permissao",
	"noclip.permissao",
	"ticket.permissao",
	"tp.permissao",
	"msg.permissao",
	-- Administração
	"player.group.add",
    "player.group.remove",
    "player.givemoney",
    "player.giveitem",
	"admin.spawnveh",
	"admin.godmode",
	"admin.tickets",
    "admin.announce",
    "player.list",
	"admin.crun",
	--"admin.blips",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
	"admin.sprites",
	"admin.srun",
    "player.noclip",
	"admin.tptowaypoint",
	"admin.deleteveh",
    "player.custom_emote",
    "player.custom_sound",
    "player.display_custom",
    "player.coords",
    "player.tptome",
    "player.tpto",
	"spawncar.permissao",
	"adminanimacao.permissao",
	-- Salario
	"Administrador.permissao",
	"admin.ajuda",
	"player.blips",
	"player.spec",
	"player.noclip",
	"player.secret",
	"player.wall",
	"mqcu.permissao",
	},
	["BlipsCMDRJ"] = {
	"blips.permissao"
	},
	["ModeradorCMDRJ"] = {
	"player.group.add",
	"admin.tptowaypoint",
	"player.coords",
    "player.group.remove",
	"fix.permissao",
	"ac.permissao",
	"dv.permissao",
	"god.permissao",
	"admin.permissao",
	"ticket.permissao",
	"wl.permissao",
	"kick.permissao",
	"ban.permissao",
	"unban.permissao",
	"noclip.permissao",
	"tp.permissao",
	"msg.permissao",
	-- Salario
	"Moderador.permissao",
	"player.group.add",
    "player.group.remove",
	"admin.ajuda",
	"player.blips",
	"player.spec",
	"player.noclip",
	"player.secret",
	--"player.wall",
	"mqcu.permissao",
	},
	["SuporteCMDRJ"] = {
	"ticket.permissao",
	"fix.permissao",
	"ac.permissao",
	"dv.permissao",
	"wl.permissao",
	"kick.permissao",
	"player.blips",
	"player.spec",
	"player.noclip",
	--"player.secret",
	--"player.wall",
	"mqcu.permissao",

	-- Salario
	"Suporte.permissao",
	"admin.ajuda",
	},
	["aprovadorwl"] = {
	"wl.permissao",
	"ac.permissao",
	"Suporte.permissao",
	-- Salario
	"AprovadorWL.permissao",
	"admin.ajuda",
	},
	
	["StreamerCMDRJ1"] = {
    "god.permissao",
    "noclip.permissao",
	"adminskin.permissao",
    "admin.spawnveh",
    "admin.godmode",
	"ac.permissao",
	"dv.permissao",
	"tp.permissao",
    "player.noclip",
    "admin.tptowaypoint",
    "admin.deleteveh",
    "player.custom_emote",
    "player.tptome",
    "player.tpto",
	},
	
  ["user"] = {
    "player.phone",
    "player.calladmin",
	"player.loot",
	"player.menu",
	"player.fixhaircut",
	"player.mask",
	"player.userlist",
	"mobile.charge",
	"mobile.pay",
	"store.money",
	"store.bodyarmor",
	"store.weapons",
	"bikezin.permissao",
	"playerzin.permissao",
    "police.askid",
    "police.seizable",
	"coma.skipper",
	"coma.caller",
	-- Salario
	"Player.permissao"
  },
  
  ["ADMZIN"] = {
	"admin.permissao",
	"fix.permissao",
	"polparcarregar.permissao",
	"dv.permissao",
	--"policia.permissao",
	--"blips.permissao",
	"god.permissao",
	"ac.permissao",
	"adminskin.permissao",
	"wl.permissao",
	"kick.permissao",
	"ban.permissao",
	"unban.permissao",
	"money.permissao",
	"noclip.permissao",
	"ticket.permissao",
	"tp.permissao",
	"spawncar.permissao",
	"msg.permissao",
	-- Administração
	"player.group.add",
    "player.group.remove",
    "player.givemoney",
    "player.giveitem",
	"admin.spawnveh",
	"admin.godmode",
	"admin.tickets",
    "admin.announce",
    "player.list",
	"admin.crun",
	--"admin.blips",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
	"admin.sprites",
	"admin.srun",
    "player.noclip",
	"admin.tptowaypoint",
	"admin.deleteveh",
    "player.custom_emote",
    "player.custom_sound",
    "player.display_custom",
    "player.coords",
    "player.tptome",
    "player.tpto",
	-- Salario
	"Administrador.permissao"
	
  },
  
  --== PMERJ ==--
["CMD PMERJ"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"coronelpm.paycheck",
	"policiaradio.permissao",
	"policiachat.permissao",
	"policia.permissao",
	"pm3.whitelisted",
	"polparcarregar.permissao",
	"portas.policia",
	"operacao.permissao",
	"polpar1.permissao",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissaoComandante",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"policiachamado.permissao",
	"cmdgeral.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	-- Salario
	"CmdGeral.permissao",
	"bau.pm"
	
  },

  ["[PMRJ] - Recruta"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"polparcarregar.permissao",
	"policiapatrulhamento.permissao",
	"mission.policia",
	"coronelpm.paycheck",
	"policia.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"policiachat.permissao",
	"pmerj.permissaoRecruta",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
	"policiaradio.permissao",
    "police.check",
    "police.service",
	"operacao.permissao",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
	"polpar1.permissao",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"policiachamado.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"Recruta.permissao"
  },

  ["[PMRJ] - Soldado"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"coronelpm.paycheck",
	"policia.permissao",
	"policiachat.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"policiapatrulhamento.permissao",
	"naotoma.multa",
	-----------------
	"player.blips",
	"pmerj.permissaoSoldado",
	"polparcarregar.permissao",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"policiachamado.permissao",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
	"operacao.permissao",
    "police.putinveh",
    "police.getoutveh",
	"polpar1.permissao",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"policiaradio.permissao",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"Soldado.permissao"
  },

  ["[PMRJ] - Cabo"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"policiachat.permissao",
	"coronelpm.paycheck",
	"policiapatrulhamento.permissao",
	"policia.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissaoCabo",
	"polpar.permissao",
    "police.menu",
	"polparcarregar.permissao",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
	"polpar1.permissao",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
	"operacao.permissao",
    "police.seize.weapons",
    "police.seize.items",
	"policiachamado.permissao",
	"police.asklc",
    "police.announce",
	"policiaradio.permissao",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"Cabo.permissao"
  },

  ["[PMRJ] - 3° Sargento"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"polparcarregar.permissao",
	"policiachat.permissao",
	"coronelpm.paycheck",
	"policiapatrulhamento.permissao",
	"policia.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissao3Sargento",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
	"polpar1.permissao",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"policiachamado.permissao",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	"operacao.permissao",
	"policiaradio.permissao",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"3Sargento.permissao"
  },
  
  ["[PMRJ] - 2° Sargento"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"polparcarregar.permissao",
	"mission.policia",
	"policiachat.permissao",
	"coronelpm.paycheck",
	"policiapatrulhamento.permissao",
	"policia.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissao2Sargento",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
	"operacao.permissao",
	"policiaradio.permissao",
    "police.drag",
    "police.putinveh",
	"policiachamado.permissao",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"polpar1.permissao",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"2Sargento.permissao"
  },
  
  ["[PMRJ] - 1° Sargento"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"polparcarregar.permissao",
	"policiachat.permissao",
	"coronelpm.paycheck",
	"policia.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissao1Sargento",
	"polpar.permissao",
	"policiapatrulhamento.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"operacao.permissao",
	"police.fine",
	"policiachamado.permissao",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
	"polpar1.permissao",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"policiaradio.permissao",
	"pmerj.permissao",
	-- Salario
	"1Sargento.permissao"
  },

  ["[PMRJ] - Subtenente"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"coronelpm.paycheck",
	"policiachat.permissao",
	"policiapatrulhamento.permissao",
	"policia.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissaoSubTenente",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"polpar1.permissao",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"polparcarregar.permissao",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
	"operacao.permissao",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	"policiachamado.permissao",
	"policiaradio.permissao",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	"bau.pm",
	-- Salario
	"SubTenente.permissao"
  },

  ["[PMRJ] - 2° Tenente"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"policiachat.permissao",
	"coronelpm.paycheck",
	"policia.permissao",
	"policiapatrulhamento.permissao",
	"polparcarregar.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissao2Tenente",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"policiachamado.permissao",
	"police.bmunjail",
	"polpar1.permissao",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
	"bau.pm",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
	"operacao.permissao",
    "-police.seizable",
	"policiaradio.permissao",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"2Tenente.permissao"
  },

  ["[PMRJ] - 1° Tenente"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"policiapatrulhamento.permissao",
	"pm3.cloakroom",
	"mission.policia",
	"policiachat.permissao",
	"polparcarregar.permissao",
	"coronelpm.paycheck",
	"policia.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"bau.pm",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissao1Tenente",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"polpar1.permissao",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
	"policiachamado.permissao",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	"operacao.permissao",
	"policiaradio.permissao",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"1Tenente.permissao"
  },

  ["[PMRJ] - Capitão"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"policiapatrulhamento.permissao",
	"bau.pm",
	"coronelpm.paycheck",
	"policia.permissao",
	"policiachat.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissaoCapitao",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"polparcarregar.permissao",
	"police.jail",
	"police.bmjail",
	"operacao.permissao",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
	"policiachamado.permissao",
    "police.announce",
    "-police.seizable",
	"polpar1.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaradio.permissao",
	-- Salario
	"Capitao.permissao"
  },

  ["[PMRJ] - Major"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"polparcarregar.permissao",
	"pm3.cloakroom",
	"mission.policia",
	"coronelpm.paycheck",
	"policia.permissao",
	"policiapatrulhamento.permissao",
	"pm3.whitelisted",
	"bau.pm",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissaoMajor",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"policiachat.permissao",
	"police.bmunjail",
	"operacao.permissao",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"policiaradio.permissao",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- NOVOS
	"polpar1.permissao",
	"pmcar.permissao",
	"pmheli.permissao",
	"policiachamado.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"Major.permissao"
  },

  ["[PMRJ] - Tenente Coronel"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"coronelpm.paycheck",
	"bau.pm",
	"policia.permissao",
	"policiapatrulhamento.permissao",
	"policiachat.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"polparcarregar.permissao",
	"pmerj.permissaoTenenteCoronel",
	"polpar.permissao",
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"operacao.permissao",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"policiachamado.permissao",
	"polpar1.permissao",
	"helipmerj.permissao",
	"policiaradio.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"TenenteCoronel.permissao"
  },
  
  ["[PMRJ] - Coronel"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"coronelpm.paycheck",
	"policia.permissao",
	"policiapatrulhamento.permissao",
	"policiaradio.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"polpar1.permissao",
	"policiachat.permissao",
	"bau.pm",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
	"pmerj.permissaoCoronel",
	"polparcarregar.permissao",
	"polpar.permissao",
    "police.menu",
	"policiachamado.permissao",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"operacao.permissao",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"pmerj.permissao",
	"helipmerj.permissao",
	"policiaheli.permissao",
	"pmerj.permissao",
	-- Salario
	"Coronel.permissao"
  },
  
  ["AdminFRP"] = {
		_config = {
			title = "À Paisana ADMIN",
			gtype = "cargoll"
		},
		"paisanafrp.permissao"
	},
  ["PaisanaPMERJRecruta"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjRecruta.permissao",
		"policiachat.permissao",
		"player.blips",
	},
	["PaisanaPMERJSoldado"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjSoldado.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJCabo"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjCabo.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJ3Sargento"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerj3Sargento.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJ2Sargento"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerj2Sargento.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJ1Sargento"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerj1Sargento.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJSubTenente"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjSubTenente.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJ2Tenente"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerj2Tenente.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJ1Tenente"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerj1Tenente.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJCapitao"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjCapitao.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJMajor"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjMajor.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJTenenteCoronel"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjTenenteCoronel.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJCoronel"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjCoronel.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaPMERJComandante"] = {
		_config = {
			title = "À Paisana PMESP",
			gtype = "cargo"
		},
		"paisanapoliciapmerjComandante.permissao",
		"player.blips",
		"policiachat.permissao"
	},

----------------------------------------- RECOM PMERJ --------------------------------------------- 
 
  ["[PMRJ] - Recom"] = {
    _config = {
      gtype = "job",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"operacao.permissao",
	"pm3.cloakroom",
	"mission.policia",
	"bau.pm",
	"coronelpm.paycheck",
	"policia.permissao",
	"polparcarregar.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"naotoma.multa",
    "police.menu",
	"police.spikes",
    "police.pc",
	"policiachat.permissao",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"policiachamado.permissao",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"recom.permissao",
	"helipmerj.permissao",
	"recom.permissao",
	-- Salario
	"Recom.permissao",
	"player.blips",
  },

----------------------------------------- CHOQUE PMERJ --------------------------------------------- 
 
  ["[PMRJ] - BPCHQ"] = {
    _config = {
      gtype = "job",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"mission.policia",
	"polparcarregar.permissao",
	"coronelpm.paycheck",
	"policia.permissao",
	"operacao.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"police.assalto",
	"policiachat.permissao",
	"naotoma.multa",
	"bau.pm",
	"policiachamado.permissao",
	-----------------
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- NOVOS
	"pmcar.permissao",
	"pmheli.permissao",
	"bpchq.permissao",
	"helipmerj.permissao",
	-- Salario
	"Choque.permissao",
	"pmerj.permissao",
	"player.blips",
  },

----------------------------------------- BOPE ---------------------------------------------
  ["[PMRJ] - BOPE"] = {
    _config = {
      gtype = "job",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"mission.policia",
	"coronelpm.paycheck",
	"bau.bope",
	"policia.permissao",
	"pm3.whitelisted",
	"portas.policia",
	"policiaradio2.permissao",
	"operacao.permissao",
	"police.assalto",
	"polparcarregar.permissao",
	"naotoma.multa",
	-----------------
    "police.menu",
	"police.spikes",
	"policiachat.permissao",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
	"policiachamado.permissao",
    "-police.seizable",
	-- NOVOS
	"bope.permissao",
	"bopecar.permissao",
	"bope.permissaotoogle",
	-- NOVOS 2
	"pmcar.permissao",
	"pm3.arsenal",
	"pm3.garagem",
	"pm3.cloakroom",
	"bau.pm",
	"pmheli.permissao",
	"helipmerj.permissao",
	"pmerj.permissao",
	"player.blips",
  }, 
 

----------------------------------------- Policia Rodoviaria ---------------------------------------------  
 
  ["[PRF] - Policial Rodoviario"] = {
    _config = {
      gtype = "cargo",
      onjoin = function(player) vRPclient._setCop(player,true) end,
      onspawn = function(player) vRPclient._setCop(player,true) end,
      onleave = function(player) vRPclient._setCop(player,false) end
    },
	"prf.arsenal",
	"prf.garagem",
	"prf.cloakroom",
	"mission.policia",
	"diretorgeral.paycheck",
	"prf.whitelisted",
	"polparcarregar.permissao",
	"policiaprf.permissao",
	"polpar1.permissao",
	"polpar.permissao",
	"policiaradio.permissao",
	"operacao.permissao",
	"portas.policia",
	"policiachat.permissao",
	"police.assalto",
	"naotoma.multa",
	"player.blips",
	-----------------
    "police.menu",
	"policiapatrulhamentoprf.permissao",
	"police.spikes",
    "police.pc",
	"bau.prf",
	"prf.permissao",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
	"prftoogle.permissao",
	"policia.permissao",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  
  ["PaisanaPRF"] = {
		_config = {
			title = "À Paisana PRF",
			gtype = "cargo"
		},
		"paisanaprf.permissao",
		"player.blips",
		"policiachat.permissao"
	},
  
----------------------------------------- SAMU --------------------------------------------- 
  ["[SOCORRISTA] - SAMU"] = {
    _config = { gtype = "cargo" },
	"emergency.garagem",
	"emergency.arsenal",
	"emergency.cloakroom",
	"polparcarregar.permissao",
	"polpar1.permissao",
	"samuradio.permissao",
	"socorrista.paycheck",
	"mission.SAMU",
	"policiachat.permissao",
	"ems1.whitelisted",
	"samu.permissao",
	"naotoma.multa",
	"player.blips",
	-----------------
    "emergency.revive",
    "emergency.shop",
    "emergency.service",
	"paramedico.permissao",
	"reviver.permissao",
	-- Salario
	"SocorristaSAMU.permissao",
	"socorristasamutoogle.permissao"
  },
  ["[TÉCNICO DE ENFERMAGEM] - SAMU"] = {
    _config = { gtype = "cargo" },
	"emergency.garagem",
	"emergency.arsenal",
	"emergency.cloakroom",
	"mission.SAMU",
	"samuradio.permissao",
	"polparcarregar.permissao",
	"polpar1.permissao",
	"policiachat.permissao",
	"paramedico.paycheck",
	"ems2.whitelisted",
	"naotoma.multa",
	"player.blips",
	-----------------
    "emergency.revive",
    "emergency.shop",
	"samu.permissao",
    "emergency.service",
	"paramedico.permissao",
	"reviver.permissao",
	-- Salario
	"TecSAMU.permissao",
	"enfermagemsamutoogle.permissao"
  },
  ["[ENFERMEIRO] - SAMU"] = {
    _config = { gtype = "cargo" },
	"emergency.garagem",
	"emergency.arsenal",
	"emergency.cloakroom",
	"mission.SAMU",
	"policiachat.permissao",
	"samu.permissao",
	"medico.paycheck",
	"ems3.whitelisted",
	"naotoma.multa",
	"player.blips",
	-----------------
	"polpar1.permissao",
    "emergency.revive",
    "emergency.shop",
    "emergency.service",
	"polparcarregar.permissao",
	"paramedico.permissao",
	"reviver.permissao",
	"samuradio.permissao",
	-- Salario
	"EnfermeiroSAMU.permissao",
	"enfermeirosamutoogle.permissao"
  },
  ["[MÉDICO(A)] - SAMU"] = {
    _config = { gtype = "cargo" },
	"emergency.garagem",
	"emergency.arsenal",
	"emergency.cloakroom",
	"mission.SAMU",
	"doutor.paycheck",
	"policiachat.permissao",
	"ems4.whitelisted",
	"naotoma.multa",
	"polparcarregar.permissao",
	"player.blips",
	-----------------
    "emergency.revive",
    "emergency.shop",
	"samu.permissao",
    "emergency.service",
	"paramedico.permissao",
	"samuradio.permissao",
	"reviver.permissao",
	-- Salario
	"MedicoSAMU.permissao",
	"medicosamutoogle.permissao"
  },
  ["[COORDENADOR] - SAMU"] = {
    _config = { gtype = "cargo" },
	"emergency.garagem",
	"emergency.arsenal",
	"emergency.cloakroom",
	"mission.SAMU",
	"medicochefe.paycheck",
	"polpar1.permissao",
	"ems4.whitelisted",
	"polparcarregar.permissao",
	"naotoma.multa",
	"player.blips",
	-----------------
    "emergency.revive",
	"contratar.samu",
    "emergency.shop",
	"policiachat.permissao",
    "emergency.service",
	"paramedico.permissao",
	"samuradio.permissao",
	"samu.permissao",
	"reviver.permissao",
	-- Salario
	"CoordenadorSAMU.permissao",
	"coordenadorsamutoogle.permissao"
  },
  ["[CHEFE] - SAMU"] = {
    _config = { gtype = "cargo" },
	"emergency.garagem",
	"emergency.arsenal",
	"emergency.cloakroom",
	"mission.SAMU",
	"policiachat.permissao",
	"polpar1.permissao",
	"contratar.samu",
	"contratar.samucoord",
	"chefesamu.paycheck",
	"ems5.whitelisted",
	"naotoma.multa",
	"player.blips",
	"samuradio.permissao",
	-----------------
    "emergency.revive",
    "emergency.shop",
    "emergency.service",
	"paramedico.permissao",
	"reviver.permissao",
	"polparcarregar.permissao",
	"samu.permissao",
	-- Salario
	"ChefeSAMU.permissao",
	"chefesamutoogle.permissao"
  },
  
	["PaisanaSAMUChefe"] = {
		_config = {
			title = "À Paisana Samu",
			gtype = "cargo"
		},
		"paisanachefesamu.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaSAMUCoordenador"] = {
		_config = {
			title = "À Paisana Samu",
			gtype = "cargo"
		},
		"paisanacoordenadorsamu.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaSAMUMedico"] = {
		_config = {
			title = "À Paisana Samu",
			gtype = "cargo"
		},
		"paisanamedicosamu.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaSAMUEnfermeiro"] = {
		_config = {
			title = "À Paisana Samu",
			gtype = "cargo"
		},
		"paisanaenfermeirosamu.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaSAMUEnfermagem"] = {
		_config = {
			title = "À Paisana Samu",
			gtype = "cargo"
		},
		"paisanaenfermagemsamu.permissao",
		"player.blips",
		"policiachat.permissao"
	},
	["PaisanaSAMUSocorrista"] = {
		_config = {
			title = "À Paisana Samu",
			gtype = "cargo"
		},
		"paisanasocorristasamu.permissao",
		"player.blips",
		"policiachat.permissao"
	},
  
----------------------------------------- ILEGAL --------------------------------------------- 
  
  ["[AZUL] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro do ~r~AZUL") end
    },
	"fac.armas",
	-----------------
	"contratar.pcc",
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"build.gun.pcc",   -- ITEM TRANSFORME
	-----------------
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"pccfarm.permissao",
	"bau.pcc",
  },
  ["[AZUL] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro do ~r~AZUL") end
    },
	"fac.armas",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"build.gun.pcc",   -- ITEM TRANSFORME
	-----------------
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"pccfarm.permissao",
	"bau.pcc",
  },
  ["[AZUL] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro do ~r~AZUL") end
    },
	"fac.armas",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.pcc",   -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"pccfarm.permissao",
  },
  ["[VERMELHO] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um lider do ~r~VERMELHO") end
    },
	"fac.armas",
	-----------------
	"contratar.cv",
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"bau.cv",
	-----------------
	"comando.vermelho.cocaina.farm", -- teste de farm antigo
	"build.gun.cv", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"cvfarm.permissao",
  },  
  ["[VERMELHO] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um gerente do ~r~VERMELHO") end
    },
	"fac.armas",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"bau.cv",
	-----------------
	"build.gun.cv", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"cvfarm.permissao",
  },  
  ["[VERMELHO] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro do ~r~VERMELHO") end
    },
	"fac.armas",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.cv", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"cvfarm.permissao",
  },  
  ["[VERDE] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um lider do ~r~VERDE") end
    },
	"fac.armas",
	-----------------
	"contratar.tcp",
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.tcp", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"build.gun.cv",
	"tcpfarm.permissao",
	"bau.tcp",
  },  
  ["[VERDE] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um gerente do ~r~VERDE") end
    },
	"fac.armas",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.tcp", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"tcpfarm.permissao",
	"bau.tcp",
  },  
  ["[VERDE] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro do ~r~VERDE") end
    },
	"fac.armas",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.tcp", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"tcpfarm.permissao",
  },  
  ["[LARANJA] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um lider da ~r~LARANJA") end
    },
	"fac.armas",
	-----------------
	"contratar.ada",
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.ada", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"adafarm.permissao",
	"adaarma.permissao",
	"bau.ada",
  },  
  ["[LARANJA] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um gerente da ~r~LARANJA") end
    },
	"fac.armas",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.ada", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"adafarm.permissao",
	"adaarma.permissao",
	"bau.ada",
  },  
  ["[LARANJA] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro da ~r~LARANJA") end
    },
	"fac.armas",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.ada", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
	"adaarma.permissao",
    "police.getoutveh",
    "police.check",
	"adafarm.permissao",
  },
  ["[MILICIA] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um ~y~miliciano") end
    },
    "mlc.garagem",
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"contratar.milicia",
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"shotgun.permissao",
	"fiveseven.permissao",
	"mtar.permissao",
	"asig.permissao",
	"auzi.permissao",
	"aak103.permissao",
	-----------------
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"miliciarmas.permissao",
	"miliciaentrada.permissao",
	"miliciafarm.permissao",
	"bau.milicia",
	"milicia.permissao",
  },  
  ["[MILICIA] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um ~y~miliciano") end
    },
    "mlc.garagem",
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"shotgun.permissao",
	"fiveseven.permissao",
	"mtar.permissao",
	"asig.permissao",
	"auzi.permissao",
	"aak103.permissao",
	-----------------
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"miliciarmas.permissao",
	"miliciaentrada.permissao",
	"miliciafarm.permissao",
	"bau.milicia",
	"milicia.permissao",
  },  
  ["[MILICIA] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um ~y~miliciano") end
    },
	"mlc.garagem",
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"shotgun.permissao",
	"fiveseven.permissao",
	"mtar.permissao",
	"asig.permissao",
	"auzi.permissao",
	"aak103.permissao",
	-----------------
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"merryweather.permissao",
	"miliciaentrada.permissao",
	"miliciafarm.permissao",
	"milicia.permissao",
  },
  ---------- UNKTEC
  ["[UNKTEC] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um lider do ~r~UNKTEC") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"contratar.bordel",
	"hacker.service",
	"contrabandista.service",
	"bordel.permissao",
	"tartaruga.service",
	"bau.bordel",
	"bordelnav.permissao",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
	"bordel.permissao",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
  },
  ["[UNKTEC] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um Gerente do ~r~UNKTEC") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"bordelnav.permissao",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"bordel.permissao",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"bau.bordel",
	"bordel.permissao",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
  },
  ["[UNKTEC] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um Membro do ~r~UNKTEC") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"bordel.permissao",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
  },
  ----------- NEWS
  ["[MAFIA] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um lider da ~r~Mafia") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"contratar.mafia",
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"mtar.permissao",
	"shotgun.permissao",
	"uzi.permissao",
	"asig.permissao",
	"afiveseven.permissao",
	"aak103.permissao",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"mafiafarm.permissao",
	"mafiaarmas.permissao",
	"bau.cosanostra",
	"mafia.permissao",
  },
  ["[MAFIA] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um gerente da ~r~Mafia") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"mtar.permissao",
	"shotgun.permissao",
	"uzi.permissao",
	"asig.permissao",
	"afiveseven.permissao",
	"aak103.permissao",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"mafiafarm.permissao",
	"mafiaarmas.permissao",
	"bau.cosanostra",
	"mafia.permissao",
  },
  ["[MAFIA] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro da ~r~Mafia") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"mtar.permissao",
	"shotgun.permissao",
	"uzi.permissao",
	"asig.permissao",
	"afiveseven.permissao",
	"aak103.permissao",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"mafiafarm.permissao",
	"mafiaarmas.permissao",
	"mafia.permissao",
  },
  ["[YAKUZA] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um lider da ~r~Yakuza") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"lavar.dinheiro",
	"cocaina.service",
	"maconha.service",
	"sig.permissao",
	"ak.permissao",
	"fiveseven.permissao",
	"2colete.permissao",
	"apump.permissao",
	"auzi.permissao",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"yakuzafarm.permissao",
	"yakuzaentrada.permissao",
	"yakuzaarmas.permissao",
	"yakuzaliderentrada.permissao",
	"bau.yakuza",
	"yakuza.permissao",
  },  
  ["[YAKUZA] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um gerente da ~r~Yakuza") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"yakuzaliderentrada.permissao",
	"metanfetamina.service",
	"cocaina.service",
	"lavar.dinheiro",
	"maconha.service",
	"sig.permissao",
	"ak.permissao",
	"fiveseven.permissao",
	"2colete.permissao",
	"apump.permissao",
	"auzi.permissao",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"yakuzafarm.permissao",
	"yakuzaentrada.permissao",
	"bau.yakuza",
	"yakuzaarmas.permissao",
	"yakuza.permissao",
  },  
  ["[YAKUZA] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro da ~r~Yakuza") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"sig.permissao",
	"ak.permissao",
	"fiveseven.permissao",
	"2colete.permissao",
	"apump.permissao",
	"auzi.permissao",
	-----------------
	"build.gun.yakuza", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"yakuzafarm.permissao",
	"yakuzaentrada.permissao",
	"yakuzaarmas.permissao",
	"yakuza.permissao",
  },  
  
  -- DRIFT KING
  ["[LR] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um lider da ~r~DK") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"contratar.dk",
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"dkfarm.permissao",
	"driftking.permissao",
	"lavar.dinheiro",
	"metanfetamina.service",
	"cocaina.service",
	"bau.dk",
	"maconha.service",
	"afiveseven.permissao",
	-----------------
	"build.gun.motoclub", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check"
  },  
  ["[LR] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um Gerente da ~r~DK") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"driftking.permissao",
	"lavar.dinheiro",
	"dkfarm.permissao",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"afiveseven.permissao",
	-----------------
	"build.gun.motoclub", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
	"bau.dk",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check"
  },
  ["[LR] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro da ~r~DK") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"dkfarm.permissao",
	"driftking.permissao",
	"lavar.dinheiro",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"afiveseven.permissao",
	-----------------
	"build.gun.motoclub", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check"
  },
  
  ["[MOTOCLUBE] - Lider"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um lider do ~r~MC") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"contratar.mc",
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"lavar.dinheiro",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"sig.permissao",
	"uzi.permissao",
	"ak.permissao",
	"2colete.permissao",
	"amtar.permissao",
	-----------------
	"build.gun.motoclub", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"build.gun.cv",
	"motoclub.permissao",
	"entrada.permissao",
	"motoclub.permissao",
	"motoclubliderentrada.permissao",
	"bau.mc",
	"mcfarm.permissao",
  },  
  ["[MOTOCLUBE] - Gerente"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um gerente do ~r~MC") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"sig.permissao",
	"uzi.permissao",
	"ak.permissao",
	"2colete.permissao",
	"amtar.permissao",
	-----------------
	"build.gun.motoclub", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
	"lavar.dinheiro",
    "police.getoutveh",
    "police.check",
	"motoclub.permissao",
	"entrada.permissao",
	"motoclubliderentrada.permissao",
	"bau.mc",
	"mcfarm.permissao",
  },  
  ["[MOTOCLUBE] - Membro"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"Você é um membro do ~r~MC") end
    },
	"fac.armas",
	"mercadonegro.permissao",
	-----------------
	"hacker.service",
	"contrabandista.service",
	"tartaruga.service",
	"metanfetamina.service",
	"cocaina.service",
	"maconha.service",
	"sig.permissao",
	"uzi.permissao",
	"ak.permissao",
	"2colete.permissao",
	"amtar.permissao",
	-----------------
	"build.gun.motoclub", -- ITEM TRANSFORME
	"police.menu",
	"police.bmcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
	"motoclub.permissao",
	"entrada.permissao",
	"motoclub.permissao",
  },  

----------------------------------------- EMPREGOS LEGAIS --------------------------------------------- 
  
  ["Taxi"] = {
	_config = { gtype = "cargo" },
    "taxi.service",
	"taxi.garagem",
	"taxista.permissao",
    "taxi.paycheck",
    "mission.UBER.passenger"
  },
  
  ["UBER"] = {
    _config = { gtype = "cargo" },
    "UBER.service",
	"UBER.paycheck",
	"mission.UBER.passenger",
	"uber.permissao",
	"taxista.permissao"
  },
  
  ["[SR] - Dono"] = {
    _config = { gtype = "cargo" },
	"mecanico.permissao",
    "mecanico.service",
	"mecanico.kit",
	"mecanico.garagem",
	"mecanico.cloakroom",
	"vehicle.repair",
    "vehicle.replace",
	"mission.mecanico",
	"srdono.permissao",
	"bennyscar.permissao",
	"player.blips",
	"bennystoogle.permissao"
  },
    ["[SR] - Gerente"] = {
    _config = { gtype = "cargo" },
	"mecanico.permissao",
    "mecanico.service",
	"mecanico.kit",
	"mecanico.garagem",
	"mecanico.cloakroom",
	"vehicle.repair",
    "vehicle.replace",
	"mission.mecanico",
	"srgerente.permissao",
	"bennyscar.permissao",
	"player.blips",
	"bennystoogle.permissao"
  },
    ["[SR] - Mecanico"] = {
    _config = { gtype = "cargo" },
	"mecanico.permissao",
    "mecanico.service",
	"mecanico.kit",
	"mecanico.garagem",
	"mecanico.cloakroom",
	"vehicle.repair",
    "vehicle.replace",
	"mission.mecanico",
	"srmecanico.permissao",
	"bennyscar.permissao",
	"player.blips",
	"bennystoogle.permissao"
  },
    ["[SR] - Aux Mecanico"] = {
    _config = { gtype = "cargo" },
	"mecanico.permissao",
    "mecanico.service",
	"mecanico.kit",
	"mecanico.garagem",
	"mecanico.cloakroom",
	"vehicle.repair",
    "vehicle.replace",
	"mission.mecanico",
	"srauxmecanico.permissao",
	"bennyscar.permissao",
	"player.blips",
	"bennystoogle.permissao"
  },
  ["PaisanaSR"] = {
		_config = {
			title = "À Paisana Bennys",
			gtype = "cargo"
		},
		"paisanabennys.permissao",
		"player.blips",
	},
  
  ["Pescador"] = {
    _config = { gtype = "job" },
	"pescador.service",
	"pescador.garagem",
	"pescador.paycheck",
  },
  
  ["Leiteiro"] = {
	_config = { gtype = "job" },
    "leiteiro.service",
	"leiteiro.paycheck",
  },
    
  ["Entregador iFood"] = {
    _config = { gtype = "job" },
	"mission.entregador",
	"entregador.cloakroom",
    "entregador.service",
	"entregador.garagem",
	"entregador.paycheck",
  },
    
  ["Minerador de Diamante"] = {
	_config = { gtype = "job" },
    "diamante.service",
	"diamante.paycheck",
  },
  
  ["Minerador de Ouro"] = {
	_config = { gtype = "job" },
    "ouro.service",
	"ouro.paycheck",
  },
  
  ["Minerador de Cobre"] = {
	_config = { gtype = "job" },
    "cobre.service",
	"cobre.paycheck",
  },
  
  ["Caminhoneiro"] = {
	_config = { gtype = "job" },
    "caminhoneiro.service",
	"caminhoneiro.paycheck",
  },

----------------------------------------- Jornalista --------------------------------------------- 
   ["Jornalista"] = {
    _config = { gtype = "cargo"},
    "jornal.garagem",
	"jornal.service",
	"jornal.cloakroom",
    "jornalista.paycheck",
	"jornal.whitelisted",
	"weazel.permissao",
	"Jornalista.permissao"
  },
  ["Redator"] = {
    _config = { gtype = "cargo"},
	"jornal.garagem",
	"jornal.service",
	"jornal.cloakroom",
    "reporter.paycheck",
	"jornal.whitelisted",
	"weazel.permissao",
	"Reporter.permissao"
  },
  ["Diretor do Jornal"] = {
    _config = { gtype = "cargo"},
	"jornal.garagem",
	"jornal.service",
	"jornal.cloakroom",
    "diretorjornal.paycheck",
	"jornal.whitelisted",
	"weazel.permissao",
	"DiretorJornal.permissao"
  },
  
----------------------------------------- Advocacia --------------------------------------------- 
  
  ["Advogado"] = {
    _config = { 
		gtype = "job",
		onspawn = function(player) vRPclient._notify(player,"À serviço da lei como ~b~Advogado.") end
	},
	"advogado.vehicle",
	"advogado.service",
	"advogado.oab",
	"advogado.permissao",
	"advogado.cloakroom",
	"advogado.paycheck",
	"adv.whitelisted",
	"Advogado.permissao"
  },
  ["ADVOGADO"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"À serviço da lei como ~b~ADVOGADO.") end
	},
	"advogado.vehicle",
	"advogado.service",
	"advogado.oab",
	"advogado.permissao",
	"advogado.cloakroom",
	"advogado.paycheck",
	"adv.whitelisted",
	"Advogadopagamento.permissao",
	"Advogado.permissao"
  },
  ["Presidente da OAB"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"À serviço da lei como ~b~ Presidente da OAB.") end
	},
	"advogado.vehicle",
	"advogado.service",
	"advogado.oab",
	"advogado.permissao",
	"advogado.cloakroom",
	"advogado.paycheck",
	"adv.whitelisted",
	"Advogado.permissao",
	"PresidenteDaOAB.permissao"
  },
  ["Promotor de Justiça"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"À serviço da lei como ~b~Promotor de Justiça.") end
	},
	"advogado.garagem",
	"advogado.service",
	"advogado.oab",
	"advogado.cloakroom",
	"promotorj.paycheck",
	"adv.whitelisted",
	"PromotorDaJustica.permissao"
  },
  
  ["Juiz"] = {
    _config = { 
		gtype = "cargo",
		onspawn = function(player) vRPclient._notify(player,"À serviço da lei como ~b~Juiz.") end
	},
	"advogado.garagem",
	"advogado.service",
	"advogado.oab",
	"advogado.cloakroom",
	"juiz.paycheck",
	"adv.whitelisted",
	-----------------
    "police.menu",
	"police.spikes",
    "police.pc",
	"police.freeze",
	"police.jail",
	"police.bmjail",
	"police.bmfine",
	"police.bmunjail",
	"police.bmcuff",
	"police.fine",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
	"police.asklc",
    "police.announce",
    "-police.seizable",
	-- Salario
	"Juiz.permissao"
  },

  ["Desempregado"] = {
    _config = { 
		gtype = "job",
		onspawn = function(player) vRPclient._notify(player,"~b~Desempregado ~w~arrume um Emprego.") end
	},
    "desempregado.permissao"
  },
  
----------------------------------------- Empregos Ilegais --------------------------------------------- 

  ["Traficante de Maconha"] = {
    _config = { 
		gtype = "job",
		onspawn = function(player) vRPclient._notify(player,"Traficantede Maconha, cuidado com proerd") end	
	},
    "maconha.service",
  },
  
  ["Traficante de Cocaína"] = {
    _config = { 
		gtype = "job",
		onspawn = function(player) vRPclient._notify(player,"Cuidado para não se tornar o Fabio Assunção") end
	},
	"cocaina.service",
  },
  
  ["Traficante de Metanfetamina"] = {
    _config = { gtype = "job" },
	"metanfetamina.service",
  },

  ["Traficante de Tartaruga"] = {
	_config = { gtype = "job" },
    "tartaruga.service",
  },
  
  ["Hacker"] = {
    _config = { 
		gtype = "job",
		onspawn = function(player) vRPclient.notify(player,{"Ae parça, já que tu é hacker, instala minha impressora?."}) end	},
	"mission.hacker",
	"hacker.service",
	"hacker.hack"
  },
  
  
----------------------------------------- VIPS --------------------------------------------- 
  
  ["VIP Bronze"] = {
    _config = {
      gtype = "vip",
    },
    "vip.permissao",
	"bronze.permissao",
	"color.weapon",
  },
  ["VIP Prata"] = {
    _config = {
      gtype = "vip",
    },
    "vipp.permissao",
	"prata.permissao",
	"color.weapon",
  }, 
  ["VIP Ouro"] = {
    _config = {
      gtype = "vip",
    },
    "vippp.permissao",
	"ouro.permissao",
	"color.weapon",
  }, 
  ["VIP Diamante"] = {
    _config = {
      gtype = "vip",
    },
    "vipppp.permissao",
	"diamante.permissao",
	"color.weapon",
  },
   ["VIP Platina"] = {
    _config = {
      gtype = "vip",
    },
    "vipppp.permissao",
	"platina.permissao",
	"color.weapon",
  },
   ["VIP Mafioso"] = {
    _config = {
      gtype = "vip",
    },
    "vipppp.permissao",
	"mafioso.permissao",
	"mafioso5.permissao",
	"lavagem.vip",
	"color.weapon",
  },
  ["VIP Supremo"] = {
    _config = {
      gtype = "vip",
    },
    "vippppp.permissao",
	"supremo.permissao",
	"lavagem.vip",
	"color.weapon",
  },
  ["VIP Magnata"] = {
    _config = {
      gtype = "vip",
    },
    "vippppppp.permissao",
	"magnata.permissao",
	"lavagem.vip",
	"color.weapon",
  },
  ["VIP Empresarial"] = {
    _config = {
      gtype = "vip",
    },
	"lavagem.vip",
	"color.weapon",
  },
  
  --== Sets ==--
  --== Sets ==--
  --== Sets ==--
}

-- groups are added dynamically using the API or the menu, but you can add group when an user join here
cfg.users = {
  [1] = { -- give superadmin and admin group to the first created user on the database
    "PC-superadmin",
    "PC-admin"
  }
}

-- group selectors
-- _config
--- x,y,z, blipid, blipcolor, permissions (optional)

cfg.selectors = {
  ["Agência de Empregos"] = {
    _config = {x = -268.363739013672, y = -957.255126953125, z = 31.22313880920410, blipid = 351, blipcolor = 47},
	"UBER",
	"Entregador iFood",
	"Pescador",
	"Leiteiro",
	"Minerador de Diamante",
	"Minerador de Ouro",
	"Minerador de Cobre",
	"Caminhoneiro",
    "Desempregado"
  },
  ["Empregos Ilegais"] = {
    _config = {x = 707.324462890625, y = -966.986511230469, z = 30.4128551483154, blipid = 351, blipcolor = 49},
	"Traficante de Maconha",
	"Traficante de Cocaína",
	"Traficante de Metanfetamina",
	"Traficante de Tartaruga",
	"Contrabandista de Armas",
	"Ladrão de carros",
	"Hacker",
  },
}

return cfg

