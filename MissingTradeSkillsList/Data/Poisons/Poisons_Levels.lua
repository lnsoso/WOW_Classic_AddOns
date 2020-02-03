--------------------
-- Levels Poisons --
--------------------
-- Player starts at lvl 20 with max 100 skill poisons and gains max 5 skill / XP level gained
-- Max poisons skill is then at lvl 60 : 100 + 40 * 5 = 300
--------------------

MTSL_DATA["Poisons"]["levels"] = {
	{
		["quests"] = {
			2360,
			3401,
		},
		["name"] = {
			["German"] = MTSLUI_LOCALES_PROFESSIONS["German"]["Poisons"],
			["Spanish"] = MTSLUI_LOCALES_PROFESSIONS["Spanish"]["Poisons"],
			["Russian"] = MTSLUI_LOCALES_PROFESSIONS["Russian"]["Poisons"],
			["Portuguese"] = MTSLUI_LOCALES_PROFESSIONS["Portuguese"]["Poisons"],
			["French"] = MTSLUI_LOCALES_PROFESSIONS["French"]["Poisons"],
			["English"] = MTSLUI_LOCALES_PROFESSIONS["English"]["Poisons"],
			["Korean"] = MTSLUI_LOCALES_PROFESSIONS["Korean"]["Poisons"],
			["Chinese"] = MTSLUI_LOCALES_PROFESSIONS["Chinese"]["Poisons"],
			["Mexican"] = MTSLUI_LOCALES_PROFESSIONS["Mexican"]["Poisons"],
		},
		["min_skill"] = 0,
		["id"] = 2842,
		["max_skill"] = 300,
		["rank"] = 1,
	},
}