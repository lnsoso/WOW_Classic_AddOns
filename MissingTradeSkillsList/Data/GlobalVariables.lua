-------------------------------------------
-- Creates all global variables for DATA --
-------------------------------------------

-- Holds all the data filled by the data luas
MTSL_DATA = {
    -- Primary Professions (no skinning, herbalism because they don't have a tradeskillframe)
    ["Alchemy"] = {},
    ["Blacksmithing"] = {},
    ["Enchanting"] = {},		-- craft
    ["Engineering"] = {},
    ["Leatherworking"] = {},
    ["Mining"] = {},
    ["Tailoring"] = {},
    -- Secundary professions (no fishing because it doesn't have atradeskillframe)
    ["Cooking"] = {},
    ["First Aid"] = {},
    -- Rogue only
    ["Poisons"] = {},
    -- all game items/objects we need in 1 array
    ["Objects"] = {},
    ["NPCs"] = {},
    ["Quests"] = {},
    -- Each profession has 4 levels to learn (1-75, 75-150, 150-225, 225-300)
    ["AMOUNT_TRADESKILL_LEVELS"] = 4,
    -- Counters keeping track of total amount of skill (this includes AMOUNT_TRADESKILL_LEVELS)
    ["AMOUNT_SKILLS"] = {
        ["Tailoring"] = 230,
        ["Blacksmithing"] = 257,
        ["Alchemy"] = 115,
        ["Mining"] = 16,
        ["First Aid"] = 17,
        ["Cooking"] = 85,
        ["Engineering"] = 170,
        ["Leatherworking"] = 241,
        ["Poisons"] = 22,
        ["Enchanting"] = 155,
    },
    -- holds counters for how many skills can be learned up the current content phase (counted using DEV MODe of APP)
    ["AMOUNT_SKILLS_CURRENT_PHASE"] = {
        ["Tailoring"] = 203,
        ["Blacksmithing"] = 213,
        ["Alchemy"] = 109,
        ["Mining"] = 15,
        ["First Aid"] = 16,
        ["Cooking"] = 83,
        ["Engineering"] = 168,
        ["Leatherworking"] = 211,
        ["Poisons"] = 21,
        ["Enchanting"] = 130,
    },
    MIN_PATCH_LEVEL = 1,
    CURRENT_PATCH_LEVEL = 2,
    MAX_PATCH_LEVEL = 6,
}