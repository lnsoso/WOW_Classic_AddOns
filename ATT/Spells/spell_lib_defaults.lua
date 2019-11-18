local _, ATTdefault = ...

 ATTdefault.defaultAbilities = {
	["GENERAL"] = {
		["ALL"] = {	-- All specs
		{5579, 300}, -- Immune Root/Snare/Stun
		{23273, 300}, -- Immune Charm/Fear/Polymorph
		},
	},
	["DRUID"] = {
		["ALL"] = {	-- All specs
			{29166, 360}, -- Innervate
		},
	},
	["HUNTER"] = {
		["ALL"] = {	-- All specs
			{14311, 30}, 	-- Freezing Trap
		},
	},
	["MAGE"] = 	{
		["ALL"] = {	-- All specs
			{2139, 24}, -- Counterspell
			{45438, 300}, -- Ice Block
		},
	},
	["PALADIN"] = {
		["ALL"] = {	-- All specs
			{10308, 60}, 	-- Hammer of Justice
			{1044, 25}, 	-- Hand of Freedom
		},
	},
	["PRIEST"] = {
		["ALL"] = {	-- All specs	
		{10890, 24}, -- Psychic Scream
		},
	},
	["ROGUE"] = {
		["ALL"] = {	-- All specs
			{1766, 10}, 	-- Kick
			{2094, 60},   -- Blind
		},
	},
	["SHAMAN"] = {
		["ALL"] = {	-- All specs
			{10497, 60}, 	-- Mana Spring Totem
		},
	},
	["WARLOCK"] = {
		["ALL"] = {	-- All specs
			{19647, 24}, 	-- Spell Lock
			{17925, 120}, 	-- Death Coil
		},
	},
	["WARRIOR"] = {
		["ALL"] = {	-- All specs
			{6552, 15}, 	-- Pummel
			{47996, 15}, 	-- Intercept

		},
	},
}