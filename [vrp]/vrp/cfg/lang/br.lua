
-- define all language properties

local lang = {
  weapon = {
    pistol = "Pistola"
  },
  survival = {
    starving = "Morrendo de Fome",
    thirsty = "Morrendo de Sede"
  },
  money = {
    display = "<span class=\"symbol\"</span> {1} ",
    given = "~b~Enviar~w~ {1}$.",
    received = "~b~Recebido~w~ {1}$.",
    not_enough = "Dinheiro Insuficiente.",
    paid = "Pago {1}$.",
    give = {
      title = "💲Enviar dinheiro",
      description = "Enviar dinheiro ao jogador mais proximo de voce.",
      prompt = "Quantidade para enviar:"
    }
  },
  inventory = {
    title = "🎒Mochila",
    description = "Abrir o inventário.",
    iteminfo = "({1})<br /><br />{2}<br /><em>{3} kg</em>",
    info_weight = "Peso no Inventario {1}/{2} kg",
    give = {
      title = "Enviar",
      description = "Enviar itens ao jogador mais próximo.",
      prompt = "Quantidade que você quer enviar (max {1}):",
      given = "~b~Enviado~w~ {1} {2}.",
      received = "~b~Recebido~w~ {1} {2}.",
    },
    trash = {
      title = "🗑Lixo",
      description = "Destruir items.",
      prompt = "Quantidade que você quer destruir (max {1}):",
      done = "~b~Destruido~w~ {1} {2}."
    },
    missing = "~b~Falta~w~ {2} {1}.",
    full = "Inventário Cheio.",
    chest = {
      title = "Bau",
      already_opened = "Este Bau já foi Aberto por outra pessoa.",
      full = "Bau Cheio.",
      take = {
        title = "Pegar",
        prompt = "Quantidade para pegar (max {1}):"
      },
      put = {
        title = "Colocar",
        prompt = "Quantidade para Colocar (max {1}):"
      }
    }
  },
  emergency = {
    menu = {
      revive = {
        title = "💊Reanimar",
        description = "Reanimar o jogador mais próximo.",
        not_in_coma = "Não está em coma."
      }
    }
  },
  phone = {
    title = "📱Telefone",
    directory = {
      title = "📘Meus Contatos",
      description = "Abra a Lista de Contatos no seu Telefone.",
      add = {
        title = "> Add",
        prompt_number = "Digite o número de telefone para adicionar:",
        prompt_name = "Digite o nome do contato.",
        added = "Número adicionado."
      },
      sendsms = {
        title = "Enviar SMS",
        prompt = "Digite a mensagem (max {1} chars):",
        sent = " Enviado para n°{1}.",
		sentnoname = "SMS enviado para: #{1}.",
        not_sent = " n°{1} indisponível."
      },
      sendpos = {
        title = "Mandar Localização",
      },
      remove = {
      title = "Apagar"
      }
    },
    sms = {
      title = "📨Histórico de SMS",
      description = "Ver o seu históricos de SMS.",
      info = "<em>{1}</em><br /><br />{2}",
      notify = "SMS {1}: {2}"
    },
    smspos = {
      notify = "SMS-Localização  {1}"
    },
    service = {
      title = "💼Serviços",
      description = "Ligue para um serviço ou um número de emergência.",
      prompt = "Se necessário, insira uma mensagem para os serviço:",
      ask_call = "Chamada Recebida de {1} você deseja aceitar? <em>{2}</em>",
      taken = "Esta chamada já foi recebida."
    },
    announce = {
      title = "Anunciar",
      description = "Publique um anúncio visível para todos no servidor por alguns segundos.",
      item_desc = "{1} $<br /><br/>{2}",
      prompt = "Anunciar conteúdo (10-1000 caracteres): "
    }
  },
  emotes = {
    title = "😺Animações",
    clear = {
      title = "> Parar",
      description = "Parar todas as ações do personagem."
    }
  },
  home = {
    buy = {
      title = "Comprar",
      description = "Compra uma propriedade nesse local, O preço é {1} $.",
      bought = "Compra realizada com sucesso. Parabens pela Sua Nova Conquista (Propriedade Particular)",
      full = "O Lugar está cheio.",
      have_home = "Você já possui uma propriedade."
    },
    sell = {
      title = "Vender",
      description = "Vende suas propriedade por {1} $",
      sold = "Vendido.",
      no_home = "Voce não tem uma propriedade aqui."
    },
    intercom = {
      title = "Interfone",
      description = "Use o interfone visitar a casa de outro jogador.",
      prompt = "Numero:",
      not_available = "Não Disponivel.",
      refused = "Sua Entrada foi recusada.",
      prompt_who = "Diga quem você é:",
      asked = "Solicitando Entrada...",
      request = "Alguem está Tocando seu Interfone: <em>{1}</em>"
    },
    slot = {
      leave = {
        title = "Sair"
      },
      ejectall = {
        title = "Pedir que todos saiam",
        description = "Expulsar todos os visitantes na propriedade, incluindo você, e trancar a propriedade."
      }
    },
    wardrobe = {
      title = "Guarda Roupa",
      save = {
        title = "> Salvar",
        prompt = "Salvar nome:"
      }
    },
    gametable = {
      title = "Mesa de Jogos",
      bet = {
        title = "Iniciar Aposta",
        description = "Comece uma Aposta com jogadores perto de você, o vencedor será sorteado aleatoriamente",
        prompt = "Valor da Apósta:",
        request = "[APOSTA] Voce quer Apostar {1} Reais ?",
        started = "A Aposta Começou."
      }
    }
  },
  garage = {
    title = " {1}",
    owned = {
      title = "Veiculos Possuidos",
      description = "Veiculos que voce Possui."
    },
    buy = {
      title = "Comprar",
      description = "Comprar Veiculos.",
      info = "{1} $<br /><br />{2}"
    },
    sell = {
      title = "Vender",
      description = "Vender veiculos."
    },
    rent = {
      title = "Aluguel",
      description = "Alugue um veículo para a sessão (até você se desconectar)."
    },
    store = {
      title = "Guardar",
      description = "Coloque seu veiculo atual na garagem."
    }
  },
  vehicle = {
    title = "🔑Veiculo",
    no_owned_near = "Nenhum veiculo seu perto de voce.",
    trunk = {
      title = "Porta Malas",
      description = "Abra o porta malas do veiculo."
    },
  sellTP = {
    title = "Vender para alguem",
    description = "Vender para o jogador mais proximo."
    },
    detach_trailer = {
      title = "Desencaixar trailer",
      description = "Encaixar trailer."
    },
    detach_towtruck = {
      title = "Descartar Containers de caminhão",
      description = "Descarte Containers de reboque."
    },
    detach_cargobob = {
      title = "Desanexar cargabob",
      description = "Desanexar cargabob."
    },
	toggle_neon1 = {
      title = "Neon - on/off",
      description = "Ligue/desligue a luz de néon."
    },
    lock = {
      title = "Travar/Destravar",
      description = "Travar e Destravar o veiculo."
    },
    engine = {
      title = "Motor Ligar/Desligar",
      description = "Ligue ou Desligue o Motor do Carro."
    },
    asktrunk = {
      title = "🚗Solicitar Porta Malas",
      asked = "Solicitando...",
      request = "Você quer aceitar o pedido de acesso ?"
    },
    replace = {
      title = "Trocar veiculo",
      description = "Substituir o veiculo mais proximo de você."
    },
    repair = {
      title = "🔧Consertar Veiculo",
      description = "Consertar o veiculo mais perto de voce."
    }
  },
  gunshop = {
    title = "🔫Loja de Arma",
    prompt_ammo = "Quantidade de Munição para comprar para {1}:",
    info = "<em>Corpo: </em> {1} $<br /><em>Munição: </em> {2} $/u<br /><br />{3}"
  },
  gunshopdinheirosujo = {
    title = "🔫Loja de Arma ilegal ({1})",
    prompt_ammo = "Quantidade de munição para comprar para {1}:",
    info = "<em>Corpo: </em> {1} $<br /><em>munição: </em> {2} $/u<br /><br />{3}"
  },
  market = {
    title = "Mercado",
    prompt = "Quantidade {1} para comprar:",
    info = "{1} $<br /><br />{2}"
  },
  mercadonegro = {
    title = "Mercado Negro",
    prompt = "Quantidade {1} para comprar:",
    info = "{1} $<br /><br />{2}"
  },
  skinshop = {
    title = "Loja de Roupa"
  },
  desbugskins = {
    title = "Vestuário da policia"
    },
  mission = {
    blip = "Missão ({1}) {2}/{3}",
    display = "<span class=\"name\">{1}</span> <span class=\"step\">{2}/{3}</span><br /><br />{4}",
    cancel = {
      title = "✖️Cancelar Entrega"
    }
  },
  aptitude = {
    title = "📤 XP e Level",
    description = "Mostra suas Capacidades seu XP e Level.  <- Atenção para fechar Display so clickar Novamente",
    lose_exp = "XP {1}/{2} -{3} exp.",
    earn_exp = "XP {1}/{2} +{3} exp.",
    level_down = "XP {1}/{2} Level perdido ({3}). Atenção Voce perdeu Level :(",
    level_up = "XP {1}/{2} Level Upado ({3}). Parabens Voce Alcançõu um novo Level",
    display = {
      group = "{1}: ",
      aptitude = "{1} LVL {3} EXP {2}"
    }
  }
}

return lang
