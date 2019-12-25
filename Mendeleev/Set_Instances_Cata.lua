	local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
	local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
	local L = LibStub("AceLocale-3.0"):GetLocale("Mendeleev")
	
	local showDropRate = function (v)
		v = tonumber(v)
		return v and (" (%.1f%%)"):format(v / 10) or ""
	end

--~ 	table.insert(MENDELEEV_SETS, {
--~ 		name = BZ["<INSTANCE>"],
--~ 		setindex = "InstanceLoot.<INSTANCE>",
--~ 		colour = "|cffB0C4DE",
--~ 		header = BZ["<INSTANCE>"],
--~ 		useval = showDropRate,
--~ 		quality = 3,
--~ 		sets = {
--~ 			["InstanceLoot.<INSTANCE>.<BOSS>"] = BB["<BOSS>"],
--~ 			["InstanceLoot.<INSTANCE>.<BOSS>"] = BB["<BOSS>"],
--~ 		},
--~ 	})

	table.insert(MENDELEEV_SETS, {
		name = BZ["Throne of the Tides"],
		setindex = "InstanceLoot.Throne of the Tides",
		colour = "|cffB0C4DE",
		header = BZ["Throne of the Tides"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Throne of the Tides.Lady Naz'jar"] = BB["Lady Naz'jar"],
			["InstanceLoot.Throne of the Tides.Commander Ulthok"] = BB["Commander Ulthok"],
			["InstanceLoot.Throne of the Tides.Mindbender Ghur'sha"] = BB["Mindbender Ghur'sha"],
			["InstanceLoot.Throne of the Tides.Ozumat"] = BB["Ozumat"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Throne of the Tides"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Throne of the Tides",
		colour = "|cffB0C4DE",
		header = BZ["Throne of the Tides"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Throne of the Tides.Lady Naz'jar"] = BB["Lady Naz'jar"],
			["InstanceLootHeroic.Throne of the Tides.Commander Ulthok"] = BB["Commander Ulthok"],
			["InstanceLootHeroic.Throne of the Tides.Mindbender Ghur'sha"] = BB["Mindbender Ghur'sha"],
			["InstanceLootHeroic.Throne of the Tides.Ozumat"] = BB["Ozumat"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["Blackrock Caverns"],
		setindex = "InstanceLoot.Blackrock Caverns",
		colour = "|cffB0C4DE",
		header = BZ["Blackrock Caverns"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Blackrock Caverns.Rom'ogg Bonecrusher"] = BB["Rom'ogg Bonecrusher"],
			["InstanceLoot.Blackrock Caverns.Corla, Herald of Twilight"] = BB["Corla, Herald of Twilight"],
			["InstanceLoot.Blackrock Caverns.Karsh Steelbender"] = BB["Karsh Steelbender"],
			["InstanceLoot.Blackrock Caverns.Beauty"] = BB["Beauty"],
			["InstanceLoot.Blackrock Caverns.Ascendant Lord Obsidius"] = BB["Ascendant Lord Obsidius"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Blackrock Caverns"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Blackrock Caverns",
		colour = "|cffB0C4DE",
		header = BZ["Blackrock Caverns"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Blackrock Caverns.Rom'ogg Bonecrusher"] = BB["Rom'ogg Bonecrusher"],
			["InstanceLootHeroic.Blackrock Caverns.Corla, Herald of Twilight"] = BB["Corla, Herald of Twilight"],
			["InstanceLootHeroic.Blackrock Caverns.Karsh Steelbender"] = BB["Karsh Steelbender"],
			["InstanceLootHeroic.Blackrock Caverns.Beauty"] = BB["Beauty"],
			["InstanceLootHeroic.Blackrock Caverns.Ascendant Lord Obsidius"] = BB["Ascendant Lord Obsidius"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["Grim Batol"],
		setindex = "InstanceLoot.Grim Batol",
		colour = "|cffB0C4DE",
		header = BZ["Grim Batol"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Grim Batol.General Umbriss"] = BB["General Umbriss"],
			["InstanceLoot.Grim Batol.Forgemaster Throngus"] = BB["Forgemaster Throngus"],
			["InstanceLoot.Grim Batol.Drahga Shadowburner"] = BB["Drahga Shadowburner"],
			["InstanceLoot.Grim Batol.Erudax"] = BB["Erudax"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Grim Batol"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Grim Batol",
		colour = "|cffB0C4DE",
		header = BZ["Grim Batol"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Grim Batol.General Umbriss"] = BB["General Umbriss"],
			["InstanceLootHeroic.Grim Batol.Forgemaster Throngus"] = BB["Forgemaster Throngus"],
			["InstanceLootHeroic.Grim Batol.Drahga Shadowburner"] = BB["Drahga Shadowburner"],
			["InstanceLootHeroic.Grim Batol.Erudax"] = BB["Erudax"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["Halls of Origination"],
		setindex = "InstanceLoot.Halls of Origination",
		colour = "|cffB0C4DE",
		header = BZ["Halls of Origination"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Halls of Origination.Temple Guardian Anhuur"] = BB["Temple Guardian Anhuur"],
			["InstanceLoot.Halls of Origination.Earthrager Ptah"] = BB["Earthrager Ptah"],
			["InstanceLoot.Halls of Origination.Anraphet"] = BB["Anraphet"],
			["InstanceLoot.Halls of Origination.Isiset"] = BB["Isiset"],
			["InstanceLoot.Halls of Origination.Ammunae"] = BB["Ammunae"],
			["InstanceLoot.Halls of Origination.Setesh"] = BB["Setesh"],
			["InstanceLoot.Halls of Origination.Rajh"] = BB["Rajh"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Halls of Origination"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Halls of Origination",
		colour = "|cffB0C4DE",
		header = BZ["Halls of Origination"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Halls of Origination.Temple Guardian Anhuur"] = BB["Temple Guardian Anhuur"],
			["InstanceLootHeroic.Halls of Origination.Earthrager Ptah"] = BB["Earthrager Ptah"],
			["InstanceLootHeroic.Halls of Origination.Anraphet"] = BB["Anraphet"],
			["InstanceLootHeroic.Halls of Origination.Isiset"] = BB["Isiset"],
			["InstanceLootHeroic.Halls of Origination.Ammunae"] = BB["Ammunae"],
			["InstanceLootHeroic.Halls of Origination.Setesh"] = BB["Setesh"],
			["InstanceLootHeroic.Halls of Origination.Rajh"] = BB["Rajh"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["Lost City of the Tol'vir"],
		setindex = "InstanceLoot.Lost City of the Tol'vir",
		colour = "|cffB0C4DE",
		header = BZ["Lost City of the Tol'vir"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Lost City of the Tol'vir.General Husam"] = BB["General Husam"],
			["InstanceLoot.Lost City of the Tol'vir.High Prophet Barim"] = BB["High Prophet Barim"],
			["InstanceLoot.Lost City of the Tol'vir.Lockmaw"] = BB["Lockmaw"],
			["InstanceLoot.Lost City of the Tol'vir.Augh"] = "Augh", -- delete once dataminer gets fixed!
			["InstanceLoot.Lost City of the Tol'vir.Siamat"] = BB["Siamat, Lord of South Wind"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Lost City of the Tol'vir"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Lost City of the Tol'vir",
		colour = "|cffB0C4DE",
		header = BZ["Lost City of the Tol'vir"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Lost City of the Tol'vir.General Husam"] = BB["General Husam"],
			["InstanceLootHeroic.Lost City of the Tol'vir.High Prophet Barim"] = BB["High Prophet Barim"],
			["InstanceLootHeroic.Lost City of the Tol'vir.Augh"] = BB["Augh"],
			["InstanceLootHeroic.Lost City of the Tol'vir.Siamat"] = BB["Siamat, Lord of South Wind"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["The Stonecore"],
		setindex = "InstanceLoot.The Stonecore",
		colour = "|cffB0C4DE",
		header = BZ["The Stonecore"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.The Stonecore.Corborus"] = BB["Corborus"],
			["InstanceLoot.The Stonecore.Slabhide"] = BB["Slabhide"],
			["InstanceLoot.The Stonecore.Ozruk"] = BB["Ozruk"],
			["InstanceLoot.The Stonecore.High Priestess Azil"] = BB["High Priestess Azil"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["The Stonecore"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.The Stonecore",
		colour = "|cffB0C4DE",
		header = BZ["The Stonecore"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.The Stonecore.Corborus"] = BB["Corborus"],
			["InstanceLootHeroic.The Stonecore.Slabhide"] = BB["Slabhide"],
			["InstanceLootHeroic.The Stonecore.Ozruk"] = BB["Ozruk"],
			["InstanceLootHeroic.The Stonecore.High Priestess Azil"] = BB["High Priestess Azil"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["The Vortex Pinnacle"],
		setindex = "InstanceLoot.The Vortex Pinnacle",
		colour = "|cffB0C4DE",
		header = BZ["The Vortex Pinnacle"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.The Vortex Pinnacle.Grand Vizier Ertan"] = BB["Grand Vizier Ertan"],
			["InstanceLoot.The Vortex Pinnacle.Altairus"] = BB["Altairus"],
			["InstanceLoot.The Vortex Pinnacle.Asaad"] = BB["Asaad"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["The Vortex Pinnacle"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.The Vortex Pinnacle",
		colour = "|cffB0C4DE",
		header = BZ["The Vortex Pinnacle"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.The Vortex Pinnacle.Grand Vizier Ertan"] = BB["Grand Vizier Ertan"],
			["InstanceLootHeroic.The Vortex Pinnacle.Altairus"] = BB["Altairus"],
			["InstanceLootHeroic.The Vortex Pinnacle.Asaad"] = BB["Asaad"],
		},
	})]]

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Shadowfang Keep"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Shadowfang Keep",
		colour = "|cffB0C4DE",
		header = BZ["Shadowfang Keep"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Shadowfang Keep.Baron Ashbury"] = BB["Baron Ashbury"],
			["InstanceLootHeroic.Shadowfang Keep.Baron Silverlaine"] = BB["Baron Silverlaine"],
			["InstanceLootHeroic.Shadowfang Keep.Commander Springvale"] = BB["Commander Springvale"],
			["InstanceLootHeroic.Shadowfang Keep.Lord Walden"] = BB["Lord Walden"],
			["InstanceLootHeroic.Shadowfang Keep.Lord Godfrey"] = BB["Lord Godfrey"],
		},
	})]]

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["The Deadmines"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.The Deadmines",
		colour = "|cffB0C4DE",
		header = BZ["The Deadmines"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.The Deadmines.Glubtok"] = BB["Glubtok"],
			["InstanceLootHeroic.The Deadmines.Helix Gearbreaker"] = BB["Helix Gearbreaker"],
			["InstanceLootHeroic.The Deadmines.Foe Reaper 5000"] = BB["Foe Reaper 5000"],
			["InstanceLootHeroic.The Deadmines.Admiral Ripsnarl"] = BB["Admiral Ripsnarl"],
			["InstanceLootHeroic.The Deadmines.\"Captain\" Cookie"] = BB["\"Captain\" Cookie"],
			["InstanceLootHeroic.The Deadmines.Vanessa VanCleef"] = BB["Vanessa VanCleef"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["Baradin Hold"],
		setindex = "InstanceLoot.Baradin Hold",
		colour = "|cffB0C4DE",
		header = BZ["Baradin Hold"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Baradin Hold.Argaloth"] = BB["Argaloth"],
		},
	})

-- let's see what the dataminer is up for
	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Baradin Hold"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Baradin Hold",
		colour = "|cffB0C4DE",
		header = BZ["Baradin Hold"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Baradin Hold.Argaloth"] = BB["Argaloth"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["Blackwing Descent"],
		setindex = "InstanceLoot.Blackwing Descent",
		colour = "|cffB0C4DE",
		header = BZ["Blackwing Descent"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Blackwing Descent.Magmaw"] = BB["Magmaw"],
			["InstanceLoot.Blackwing Descent.Omnotron Defense System"] = BB["Omnotron Defense System"],
			["InstanceLoot.Blackwing Descent.Maloriak"] = BB["Maloriak"],
			["InstanceLoot.Blackwing Descent.Atramedes"] = BB["Atramedes"],
			["InstanceLoot.Blackwing Descent.Chimaeron"] = BB["Chimaeron"],
			["InstanceLoot.Blackwing Descent.Nefarian"] = BB["Nefarian"],
			["InstanceLoot.Blackwing Descent.Trash Mobs"] = L["Trash Mobs"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Blackwing Descent"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Blackwing Descent",
		colour = "|cffB0C4DE",
		header = BZ["Blackwing Descent"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Blackwing Descent.Magmaw"] = BB["Magmaw"],
			["InstanceLootHeroic.Blackwing Descent.Omnotron Defense System"] = BB["Omnotron Defense System"],
			["InstanceLootHeroic.Blackwing Descent.Maloriak"] = BB["Maloriak"],
			["InstanceLootHeroic.Blackwing Descent.Atramedes"] = BB["Atramedes"],
			["InstanceLootHeroic.Blackwing Descent.Chimaeron"] = BB["Chimaeron"],
			["InstanceLootHeroic.Blackwing Descent.Nefarian"] = BB["Nefarian"],
			["InstanceLootHeroic.Blackwing Descent.Trash Mobs"] = L["Trash Mobs"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["The Bastion of Twilight"],
		setindex = "InstanceLoot.The Bastion of Twilight",
		colour = "|cffB0C4DE",
		header = BZ["The Bastion of Twilight"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.The Bastion of Twilight.Halfus Wyrmbreaker"] = BB["Halfus Wyrmbreaker"],
			["InstanceLoot.The Bastion of Twilight.Valiona & Theralion"] = BB["Valiona and Theralion"],
			["InstanceLoot.The Bastion of Twilight.Twilight Ascendant Council"] = BB["Ascendant Council"],
			["InstanceLoot.The Bastion of Twilight.Cho'gall"] = BB["Cho'gall"],
			["InstanceLoot.The Bastion of Twilight.Sinestra"] = BB["Sinestra"], -- delete once dataminer gets fixed!
			["InstanceLoot.The Bastion of Twilight.Trash Mobs"] = L["Trash Mobs"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["The Bastion of Twilight"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.The Bastion of Twilight",
		colour = "|cffB0C4DE",
		header = BZ["The Bastion of Twilight"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.The Bastion of Twilight.Halfus Wyrmbreaker"] = BB["Halfus Wyrmbreaker"],
			["InstanceLootHeroic.The Bastion of Twilight.Valiona & Theralion"] = BB["Valiona and Theralion"],
			["InstanceLootHeroic.The Bastion of Twilight.Twilight Ascendant Council"] = BB["Ascendant Council"],
			["InstanceLootHeroic.The Bastion of Twilight.Cho'gall"] = BB["Cho'gall"],
			["InstanceLootHeroic.The Bastion of Twilight.Sinestra"] = BB["Sinestra"],
			["InstanceLootHeroic.The Bastion of Twilight.Trash Mobs"] = L["Trash Mobs"],
		},
	})]]

	table.insert(MENDELEEV_SETS, {
		name = BZ["Throne of the Four Winds"],
		setindex = "InstanceLoot.Throne of the Four Winds",
		colour = "|cffB0C4DE",
		header = BZ["Throne of the Four Winds"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Throne of the Four Winds.Conclave of Wind"] = BB["Conclave of Wind"],
			["InstanceLoot.Throne of the Four Winds.Al'Akir"] = BB["Al'Akir"],
		},
	})

	--[[table.insert(MENDELEEV_SETS, {
		name = BZ["Throne of the Four Winds"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Throne of the Four Winds",
		colour = "|cffB0C4DE",
		header = BZ["Throne of the Four Winds"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Throne of the Four Winds.Conclave of Wind"] = BB["Conclave of Wind"],
			["InstanceLootHeroic.Throne of the Four Winds.Al'Akir"] = BB["Al'Akir"],
		},
	})]]

