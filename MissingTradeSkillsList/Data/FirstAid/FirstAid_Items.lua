--------------------------------------
-- Items First Aid
--------------------------------------
MTSL_DATA["First Aid"]["items"] = {
	{
		["name"] = {
			["German"] = "Handbuch: Starkes Gegengift",
			["Spanish"] = "Manual: antídoto fuerte",
			["Chinese"] = "手册：强力抗毒药剂",
			["Korean"] = "처방전: 강한 해독제",
			["French"] = "Manuel : Sérum anti-venin supérieur",
			["Portuguese"] = "Manual: Antipeçonha Forte",
			["Mexican"] = "Manual: contraveneno fuerte",
			["Russian"] = "Учебник: сильное противоядие",
			["English"] = "Manual: Strong Anti-Venom",
		},
		["drops"] = {
			["mobs_range"] = {
				["min_xp_level"] = 20,
				["max_xp_level"] = 35,
			},
		},
		["id"] = 6454,
		["phase"] = 1,
		["quality"] = "uncommon",
	}, -- [1]
	{
		["vendors"] = {
			["price"] = 10000,
			["sources"] = {
				2805, -- [1]
				13476, -- [2]
			},
		},
		["phase"] = 1,
		["name"] = {
			["German"] = "Erste Hilfe für Experten - Verbinden, aber richtig",
			["Spanish"] = "Primeros auxilios para expertos: Entre vendas",
			["Chinese"] = "中级急救教材 - 绷带缚体",
			["Korean"] = "고급 응급치료서",
			["French"] = "Expert en premiers soins - Sous les pansements",
			["Portuguese"] = "Socorrista Perito - Enfaixado",
			["Mexican"] = "Primeros auxilios para expertos: Entre vendas",
			["Russian"] = "Умелец первой помощи: снимая покровы",
			["English"] = "Expert First Aid - Under Wraps",
		},
		["id"] = 16084,
		["quality"] = "common",
	}, -- [2]
	{
		["vendors"] = {
			["price"] = 2200,
			["sources"] = {
				2805, -- [1]
				13476, -- [2]
			},
		},
		["phase"] = 1,
		["name"] = {
			["German"] = "Handbuch: Schwerer Seidenverband",
			["Spanish"] = "Manual: venda de seda pesada",
			["Chinese"] = "手册：厚丝质绷带",
			["Korean"] = "처방전: 두꺼운 비단 붕대",
			["French"] = "Manuel : Bandage épais en soie",
			["Portuguese"] = "Manual: Bandagem Grossa de Seda",
			["Mexican"] = "Manual: venda de seda gruesa",
			["Russian"] = "Учебник: плотные шелковые бинты",
			["English"] = "Manual: Heavy Silk Bandage",
		},
		["id"] = 16112,
		["quality"] = "common",
	}, -- [3]
	{
		["vendors"] = {
			["price"] = 5000,
			["sources"] = {
				2805, -- [1]
				13476, -- [2]
			},
		},
		["phase"] = 1,
		["name"] = {
			["German"] = "Handbuch: Magiestoffverband",
			["Spanish"] = "Manual: venda de paño mágico",
			["Chinese"] = "手册：魔纹绷带",
			["Korean"] = "처방전: 마법 붕대",
			["French"] = "Manuel : Bandage en tisse-mage",
			["Portuguese"] = "Manual: Bandagem de Magitrama",
			["Mexican"] = "Manual: venda de tejido mágico",
			["Russian"] = "Учебник: бинты из магической ткани",
			["English"] = "Manual: Mageweave Bandage",
		},
		["id"] = 16113,
		["quality"] = "common",
	}, -- [4]
	{
		["vendors"] = {
			["price"] = 100000,
			["sources"] = {
				10856, -- [1]
				10857, -- [2]
				11536, -- [3]
			},
		},
		["phase"] = 3,
		["name"] = {
			["German"] = "Formel: Mächtiges Gegengift",
			["Spanish"] = "Fórmula: antídoto potente",
			["Chinese"] = "配方：特效抗毒药剂",
			["Korean"] = "처방전: 강력한 해독제",
			["French"] = "Formule : Anti-venin puissant",
			["Portuguese"] = "Fórmula: Antipeçonha Poderoso",
			["Mexican"] = "Fórmula: contraveneno potente",
			["Russian"] = "Формула: мощное противоядие",
			["English"] = "Formula: Powerful Anti-Venom",
		},
		["id"] = 19442,
		["quality"] = "common",
		["reputation"] = {
			["faction_id"] = 529,
			["level_id"] = 6,
		},
	}, -- [5]
}