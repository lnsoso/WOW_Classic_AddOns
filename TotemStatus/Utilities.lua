--[[
	Join 2 arrays into a new single array.
]]
local function Join(arr1, arr2)
	newArray = { }

	for _, value in pairs(arr1) do
		table.insert(newArray, value)
	end
	
	if (arr2 == nil) then return newArray end
	
	for _, value in pairs(arr2) do
		table.insert(newArray, value)
	end
	
	return newArray
end

--[[
	Join alll the provided arrays into 1. Any parameter past the first can be nil.
]]
local function JoinMany(arr1, arr2, arr3, arr4, arr5, arr6, arr7)
	return Join(Join(Join(Join(Join(Join(arr1, arr2), arr3), arr4), arr5), arr6), arr7)
end

--Each array contains all the aura spell IDs of all ranks for that totem
local FIRE_RES = { 8185, 10534, 10535 }
local FROST_RES = { 8182, 10476, 10477 }
local GRACE_OF_AIR = { 8836, 10626, 25360 }
local GROUNDING = { 8178 }
local NATURE_RES = { 10596, 10598, 10599 }
local STONESKIN = { 8072, 8156, 8157, 10403, 10404, 10405 }
local STRENGTH_OF_EARTH = { 8076, 8162, 8163, 10441, 25362 }
local WINDWALL = { 15108, 15109, 15110 }
local HEALING_STREAM = { 5672, 6371, 6372, 10460, 10461 }
local MANA_SPRING = { 5677, 10491, 10493, 10494 }
local MANA_TIDE = { 16191, 17355, 17360 }
local TRANQUIL_AIR = { 25909 }
local ALL_BENEFIT = JoinMany(FIRE_RES, FROST_RES, GROUNDING, NATURE_RES, WINDWALL, HEALING_STREAM, TRANQUIL_AIR)

--Defines which totems are considered useful to which classes
local ClassUsefulTotemAuras = 
{ 
	[1] = JoinMany(ALL_BENEFIT, GRACE_OF_AIR, STONESKIN, STRENGTH_OF_EARTH), --Warrior
	[3] = JoinMany(ALL_BENEFIT, GRACE_OF_AIR, MANA_SPRING, MANA_TIDE), --Hunter
	[4] = JoinMany(ALL_BENEFIT, GRACE_OF_AIR, STONESKIN, STRENGTH_OF_EARTH), --Rogue
	[5] = JoinMany(ALL_BENEFIT, MANA_SPRING, MANA_TIDE), --Priest
	[7] = JoinMany(ALL_BENEFIT, GRACE_OF_AIR, STONESKIN, STRENGTH_OF_EARTH, MANA_SPRING, MANA_TIDE), --Shaman
	[8] = JoinMany(ALL_BENEFIT, MANA_SPRING, MANA_TIDE), --Mage
	[9] = JoinMany(ALL_BENEFIT, MANA_SPRING, MANA_TIDE), --Warlock 
	[11] = JoinMany(ALL_BENEFIT, GRACE_OF_AIR, STONESKIN, STRENGTH_OF_EARTH, MANA_SPRING, MANA_TIDE) --Druid 
}

Totems = 
{
	[2484] = { TotemIndex = 1, AuraId = 0, Duration = 45 },		--Earthbind
	
	[1535] = { TotemIndex = 2, AuraId = 0, Duration = 5 },		--Fire Nova Rank 1
	[8498] = { TotemIndex = 2, AuraId = 0, Duration = 5 },		--Fire Nova Rank 2
	[8499] = { TotemIndex = 2, AuraId = 0, Duration = 5 },		--Fire Nova Rank 3
	[11314] = { TotemIndex = 2, AuraId = 0, Duration = 5 },		--Fire Nova Rank 4
	[11315] = { TotemIndex = 2, AuraId = 0, Duration = 5 },		--Fire Nova Rank 5
	
	[8190] = { TotemIndex = 2, AuraId = 0, Duration = 20 },		--Magma Rank 1
	[10585] = { TotemIndex = 2, AuraId = 0, Duration = 20 },	--Magma Rank 2
	[10586] = { TotemIndex = 2, AuraId = 0, Duration = 20 },	--Magma Rank 3
	[10587] = { TotemIndex = 2, AuraId = 0, Duration = 20 },	--Magma Rank 4
	
	[3599] = { TotemIndex = 2, AuraId = 0, Duration = 30 },		--Searing Rank 1
	[6363] = { TotemIndex = 2, AuraId = 0, Duration = 35 },		--Searing Rank 2
	[6364] = { TotemIndex = 2, AuraId = 0, Duration = 40 },		--Searing Rank 3
	[6365] = { TotemIndex = 2, AuraId = 0, Duration = 45 },		--Searing Rank 4
	[10437] = { TotemIndex = 2, AuraId = 0, Duration = 50 },	--Searing Rank 5
	[10438] = { TotemIndex = 2, AuraId = 0, Duration = 55 },	--Searing Rank 6
	
	[5730] = { TotemIndex = 1, AuraId = 0, Duration = 15 },		--Stoneclaw Rank 1
	[6390] = { TotemIndex = 1, AuraId = 0, Duration = 15 },		--Stoneclaw Rank 2
	[6391] = { TotemIndex = 1, AuraId = 0, Duration = 15 },		--Stoneclaw Rank 3
	[6392] = { TotemIndex = 1, AuraId = 0, Duration = 15 },		--Stoneclaw Rank 4
	[10427] = { TotemIndex = 1, AuraId = 0, Duration = 15 },	--Stoneclaw Rank 5
	[10428] = { TotemIndex = 1, AuraId = 0, Duration = 15 },	--Stoneclaw Rank 6
	
	[8184] = { TotemIndex = 3, AuraId = 8185, Duration = 120 },		--Fire Resistance Rank 1
	[10537] = { TotemIndex = 3, AuraId = 10534, Duration = 120 }, 	--Fire Resistance Rank 2
	[10538] = { TotemIndex = 3, AuraId = 10535, Duration = 120 }, 	--Fire Resistance Rank 3
	
	[8227] = { TotemIndex = 2, AuraId = 0, Duration = 120 },	--Flametongue Rank 1
	[8249] = { TotemIndex = 2, AuraId = 0, Duration = 120 },	--Flametongue Rank 2
	[10526] = { TotemIndex = 2, AuraId = 0, Duration = 120 },  	--Flametongue Rank 3
	[16387] = { TotemIndex = 2, AuraId = 0, Duration = 120 },  	--Flametongue Rank 4
	
	[8181] = { TotemIndex = 2, AuraId = 8182, Duration = 120 },		--Frost Resistance Rank 1
	[10478] = { TotemIndex = 2, AuraId = 10476, Duration = 120 },  	--Frost Resistance Rank 2
	[10479] = { TotemIndex = 2, AuraId = 10477, Duration = 120 },  	--Frost Resistance Rank 3
	
	[8835] = { TotemIndex = 4, AuraId = 8836, Duration = 120 },  	--Grace of Air Rank 1
	[10627] = { TotemIndex = 4, AuraId = 10626, Duration = 120 },  	--Grace of Air Rank 2
	[25359] = { TotemIndex = 4, AuraId = 25360, Duration = 120 },  	--Grace of Air Rank 3
	
	[8177] = { TotemIndex = 4, AuraId = 8178, Duration = 45 }, 		--Grounding
	
	[10595] = { TotemIndex = 4, AuraId = 10596, Duration = 120 },  	--Nature Resistance Rank 1
	[10600] = { TotemIndex = 4, AuraId = 10598, Duration = 120 },  	--Nature Resistance Rank 2
	[10601] = { TotemIndex = 4, AuraId = 10599, Duration = 120 },  	--Nature Resistance Rank 3
	
	[6495] = { TotemIndex = 4, AuraId = 0, Duration = 300 },  		--Sentry
	
	[8071] = { TotemIndex = 1, AuraId = 8072, Duration = 120 },  	--Stoneskin Rank 1
	[8154] = { TotemIndex = 1, AuraId = 8156, Duration = 120 },  	--Stoneskin Rank 2
	[8155] = { TotemIndex = 1, AuraId = 8157, Duration = 120 },  	--Stoneskin Rank 3
	[10406] = { TotemIndex = 1, AuraId = 10403, Duration = 120 },  	--Stoneskin Rank 4
	[10407] = { TotemIndex = 1, AuraId = 10404, Duration = 120 },  	--Stoneskin Rank 5
	[10408] = { TotemIndex = 1, AuraId = 10405, Duration = 120 },  	--Stoneskin Rank 6
	
	[8075] = { TotemIndex = 1, AuraId = 8076, Duration = 120 },  	--Strenth of Earth Rank 1
	[8160] = { TotemIndex = 1, AuraId = 8162, Duration = 120 },  	--Strenth of Earth Rank 2
	[8161] = { TotemIndex = 1, AuraId = 8163, Duration = 120 },  	--Strenth of Earth Rank 3
	[10442] = { TotemIndex = 1, AuraId = 10441, Duration = 120 },  	--Strenth of Earth Rank 4
	[25361] = { TotemIndex = 1, AuraId = 25362, Duration = 120 },  	--Strenth of Earth Rank 5

	[8512] = { TotemIndex = 4, AuraId = 0, Duration = 120 },  	--Windfury Rank 1
	[10613] = { TotemIndex = 4, AuraId = 0, Duration = 120 },  	--Windfury Rank 2
	[10614] = { TotemIndex = 4, AuraId = 0, Duration = 120 },  	--Windfury Rank 3
	
	[15107] = { TotemIndex = 4, AuraId = 15108, Duration = 120 },  	--Windwall Rank 1
	[15111] = { TotemIndex = 4, AuraId = 15109, Duration = 120 },  	--Windwall Rank 2
	[15112] = { TotemIndex = 4, AuraId = 15110, Duration = 120 },  	--Windwall Rank 3
	
	[8170] = { TotemIndex = 3, AuraId = 0, Duration = 120 },  	--Disease Cleansing
	
	[5394] = { TotemIndex = 3, AuraId = 5672, Duration = 60 },  	--Healing Stream Rank 1
	[6375] = { TotemIndex = 3, AuraId = 6371, Duration = 60 },  	--Healing Stream Rank 2
	[6377] = { TotemIndex = 3, AuraId = 6372, Duration = 60 },  	--Healing Stream Rank 3
	[10462] = { TotemIndex = 3, AuraId = 10460, Duration = 60 },  	--Healing Stream Rank 4
	[10463] = { TotemIndex = 3, AuraId = 10461, Duration = 60 },  	--Healing Stream Rank 5
	
	[5675] = { TotemIndex = 3, AuraId = 5677, Duration = 60 },  	--Mana Spring Rank 1
	[10495] = { TotemIndex = 3, AuraId = 10491, Duration = 60 },  	--Mana Spring Rank 2
	[10496] = { TotemIndex = 3, AuraId = 10493, Duration = 60 },  	--Mana Spring Rank 3
	[10497] = { TotemIndex = 3, AuraId = 10494, Duration = 60 },  	--Mana Spring Rank 4

	[16190] = { TotemIndex = 3, AuraId = 16191, Duration = 12 },  	--Mana Tide Rank 1
	[17354] = { TotemIndex = 3, AuraId = 17355, Duration = 12 },  	--Mana Tide Rank 2
	[17359] = { TotemIndex = 3, AuraId = 17360, Duration = 12 },  	--Mana Tide Rank 3
	
	[8166] = { TotemIndex = 3, AuraId = 0, Duration = 120 },  	--Poison Cleansing

	[25908] = { TotemIndex = 4, AuraId = 25909, Duration = 120 },  	--Tranquil Air
	
	[8143] = { TotemIndex = 1, AuraId = 0, Duration = 120 }  	--Tremor
}

--[[
	Determines if the totem aura with the given aura spell ID 
	is useful to the unit with the given unit ID.
]]
function IsAuraUsefulToUnit(unitId, spellId)
	a, b, classId = UnitClass(unitId)
	
	--find the useful auras for this class
	usefulAuras = ClassUsefulTotemAuras[classId]
	if (usefulAuras == nil) then return end
	
	--loop over all the values to see if it contains our spell ID
	for _, value in pairs(usefulAuras) do
		if value == spellId then return true end
	end
	
	return false
end

function GetSpellTotemIndex(spellId)
	if (Totems[spellId] == nil) then return nil end
	
	return Totems[spellId].TotemIndex
end

--[[
	Get the unit ID string used by the Blizzard API for the given unit index (1-5).
	1 = player, 2, 3, 4, 5 = party members
]]
function GetUnitId(unitIndex)
	if (unitIndex == 1) then return "player" end
	
	return "party" .. (unitIndex - 1)
end

--[[
	Determine if the unit with the given ID is affected with the given spell ID.
]]
function IsUnitAffected(unitId, spellId)
	for buffIndex = 1, 40 
	do
		--get the spell ID for this buff index
		a, b, c, d, e, f, g, h, i, unitSpellId = UnitAura(unitId, buffIndex, "HELPFUL")
		if (unitSpellId == spellId) then return true end
	end
	
	return false
end