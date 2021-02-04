local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
config = {}

config.items = {
	["armas de fogo"] = {
		{ item = "wbody|WEAPON_PISTOL", quantidade = 1, compra = 70000 , descricao = "Pistola 1911, único armamento liberado para porte de arma civil.", img = "pistol" },
	},
	["armas brancas"] = {
		{ item = "wbody|WEAPON_KNIFE", quantidade = 1, compra = 2000, descricao = "Esta faca de lâmina de aço carbono 7 tem dois gumes com uma lombada serrilhada para fornecer capacidades aprimoradas de esfaqueamento e impulso", img = "knife" },
		{ item = "wbody|WEAPON_DAGGER", quantidade = 1, compra = 2000, descricao = "Você tem balançado o visual pirata chique por um tempo, mas nenhuma arma cruel para completar o visual? Pegue esta adaga com um punho bem guardado. ", img = "dagger" },
		{ item = "wbody|WEAPON_KNUCKLE", quantidade = 1, compra = 2000, descricao = "Perfeito para arrancar dentes de ouro, ou como um presente para o parceiro de troféu que tem tudo.", img = "knuckle" },
		--{ item = "wbody|WEAPON_MACHETE", quantidade = 1, compra = 2000, descricao = "O comércio de armas da América Ocidental na África Ocidental não envolve apenas doações. Redescubra a vida simples com este cutelo enferrujado.", img = "machete" },
		{ item = "wbody|WEAPON_SWITCHBLADE", quantidade = 1, compra = 2000, descricao = "Do bolso ao punho nas costelas do outro cara em menos de um segundo: facas dobráveis ​​nunca sairão de moda", img = "switchblade" },
		{ item = "wbody|WEAPON_WRENCH", quantidade = 1, compra = 2000, descricao = "O favorito perene dos sobreviventes apocalípticos e pais violentos de todo o mundo, aparentemente também funciona como algum tipo de ferramenta.", img = "wrench" },
		--{ item = "wbody|WEAPON_HAMMER", quantidade = 1, compra = 2000, descricao = "A robust, multi-purpose hammer with wooden handle and curved claw, this old classic still nails the competition.", img = "hammer" },
		--{ item = "wbody|WEAPON_GOLFCLUB", quantidade = 1, compra = 2000, descricao = "Comprimento padrão, clube de golfe de ferro médio com empunhadura de borracha para um jogo curto letal", img = "golfclub" },
		--{ item = "wbody|WEAPON_CROWBAR", quantidade = 1, compra = 2000, descricao = "Pé-de-cabra reforçado forjado em aço temperado de alta qualidade para aquela alavanca extra de que você precisa para realizar o trabalho", img = "crowbar" },
		{ item = "wbody|WEAPON_HATCHET", quantidade = 1, compra = 2000, descricao = "Um machado é uma ferramenta de corte, ferramenta essa originária do martelo, sendo um martelo que tem pelo menos uma das extremidades amoladas e própria para o corte.", img = "hatchet" },
		{ item = "wbody|WEAPON_BAT", quantidade = 1, compra = 1500, descricao = "Taco de beisebol de alumínio com alça de couro. Leve, mas poderoso, para todos os grandes rebatedores.", img = "bat" },
		--{ item = "wbody|WEAPON_BOTTLE", quantidade = 1, compra = 2000, descricao = "Não é inteligente e não é bonito, mas, na maioria das vezes, nem o cara vem até você com uma faca. Quando tudo mais falha, o trabalho é realizado.", img = "bottle" },
		{ item = "wbody|WEAPON_BATTLEAXE", quantidade = 1, compra = 1000, descricao = "Se é bom o suficiente para soldados medievais, guardas de fronteira modernos e mães agressivas do futebol, é bom o suficiente para você.", img = "battleaxe" },
		--{ item = "wbody|WEAPON_POOLCUE", quantidade = 1, compra = 2000, descricao = "Ah, não há som tão satisfatório quanto o crack de uma pausa perfeita, especialmente quando é a coluna do outro cara", img = "poolcue" },
		--{ item = "wbody|WEAPON_STONE_HATCHET", quantidade = 1, compra = 3000, descricao = "Tem retro, tem vintage e tem isso. Após 500 anos de desenvolvimento tecnológico e apocalipse espiritual, o chique pré-colombiano está de volta.", img = "stone_hatchet" },
	},
	["utilitarios"] = {
		{ item = "wbody|GADGET_PARACHUTE", quantidade = 1, compra = 1000, descricao = "", img = "paraquedas" },
		{ item = "wbody|WEAPON_FLASHLIGHT", quantidade = 1, compra = 2000, descricao = "", img = "flashlight" },
		{ item = "wammo|WEAPON_PISTOL", quantidade = 50, compra = 500 , descricao = "Caixa com 50 Munições", img = "ammo_m1911" },


	}
}	

config.itemNameList = false -- caso use vRP.itemNameList() para pegar o nome de algum item

function getItemName(item)
	if config.itemNameList then
		return vRP.itemNameList(item)
	end
	return vRP.getItemName(item)
end

for k in pairs(config.items) do
	for i in ipairs(config.items[k]) do
		config.items[k][i].name = getItemName(config.items[k][i].item)
	end
end



config.ammunations = {
	vec3(1692.62,3759.50,34.70),
	vec3(252.89,-49.25,69.94),
	vec3(843.28,-1034.02,28.19),
	vec3(-331.35,6083.45,31.45),
	vec3(-663.15,-934.92,21.82),
	vec3(-1305.18,-393.48,36.69),
	vec3(-1118.80,2698.22,18.55),
	vec3(2568.83,293.89,108.73),
	vec3(-3172.68,1087.10,20.83),
	vec3(21.32,-1106.44,29.79),
	vec3(811.19,-2157.67,29.61)
}

