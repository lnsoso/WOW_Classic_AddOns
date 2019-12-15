local name, sm = ...;
local L = LibStub("AceLocale-3.0"):GetLocale("SpeedyMount");

local mounts = {
    -- neutral
    L["Swift Razzashi Raptor"],
    L["Swift Zulian Tiger"],
    L["Deathcharger"],
    L["Winterspring Frostsaber"],

    -- pvp
    L["Stormpike Battle Charger"],
    L["Frostwolf Howler"],

    -- class
    L["Summon Felsteed"],
    L["Summon Dreadsteed"],
    L["Summon Warhorse"],
    L["Summon Charger"],

    -- human
    L["Brown Horse"],
    L["Chestnut Mare"],
    L["Pinto Horse"],
    L["Black Stallion"],
    L["Swift Brown Steed"],
    L["Swift Palomino"],
    L["Swift White Steed"],

    -- night elf
    L["Spotted Frostsaber"],
    L["Striped Frostsaber"],
    L["Striped Nightsaber"],
    L["Swift Frostsaber"],
    L["Swift Mistsaber"],
    L["Swift Stormsaber"],

    -- gnome
    L["Blue Mechanostrider"],
    L["Green Mechanostrider"],
    L["Red Mechanostrider"],
    L["Unpainted Mechanostrider"],
    L["Swift Green Mechanostrider"],
    L["Swift White Mechanostrider"],
    L["Swift Yellow Mechanostrider"],

    -- dwarf
    L["Brown Ram"],
    L["Gray Ram"],
    L["White Ram"],
    L["Swift Brown Ram"],
    L["Swift Gray Ram"],
    L["Swift White Ram"],

    -- orc
    L["Brown Wolf"],
    L["Dire Wolf"],
    L["Large Timber Wolf"],
    L["Swift Brown Wolf"],
    L["Swift Gray Wolf"],
    L["Swift Timber Wolf"],

     -- tauren
    L["Brown Kodo"],
    L["Gray Kodo"],
    L["Great Brown Kodo"],
    L["Great Gray Kodo"],
    L["Great White Kodo"],

     -- troll
    L["Emerald Raptor"],
    L["Turquoise Raptor"],
    L["Violet Raptor"],
    L["Swift Blue Raptor"],
    L["Swift Olive Raptor"],
    L["Swift Orange Raptor"],

    -- undead
    L["Blue Skeletal Horse"],
    L["Brown Skeletal Horse"],
    L["Red Skeletal Horse"],
    L["Green Skeletal Warhorse"],
    L["Purple Skeletal Warhorse"]
}

function GetMounts()
    return mounts;
end

sm.GetMounts = GetMounts;