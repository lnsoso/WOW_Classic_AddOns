local _, _addon = ...;

local stealthSpells = {
    [GetSpellInfo(9913)] = true, -- Prowl 3
    [GetSpellInfo(1787)] = true,  -- Stealth 4
    [GetSpellInfo(11392)] = true, -- Invisibility Potion spell
    [GetSpellInfo(3680)] = true, -- Lesser Invisibility Potion spell
};

local classSpells = {
    [GetSpellInfo(10)] = {class = "MAGE", lvl = 20}, -- Blizzard (1)
    [GetSpellInfo(17)] = {class = "PRIEST", lvl = 6}, -- Power Word: Shield (1)
    [GetSpellInfo(53)] = {class = "ROGUE", lvl = 4}, -- Backstab (1)
    [GetSpellInfo(71)] = {class = "WARRIOR", lvl = 10}, -- Defensive Stance
    [GetSpellInfo(72)] = {class = "WARRIOR", lvl = 12}, -- Shield Bash (1)
    [GetSpellInfo(75)] = {class = "HUNTER", lvl = 1}, -- Auto Shot (1)
    [GetSpellInfo(78)] = {class = "WARRIOR", lvl = 1}, -- Heroic Strike (1)
    [GetSpellInfo(99)] = {class = "DRUID", lvl = 10}, -- Demoralizing Roar (1)
    [GetSpellInfo(100)] = {class = "WARRIOR", lvl = 4}, -- Charge (1)
    [GetSpellInfo(116)] = {class = "MAGE", lvl = 4}, -- Frostbolt (1)
    [GetSpellInfo(118)] = {class = "MAGE", lvl = 8}, -- Polymorph (1)
    [GetSpellInfo(120)] = {class = "MAGE", lvl = 26}, -- Cone of Cold (1)
    [GetSpellInfo(122)] = {class = "MAGE", lvl = 10}, -- Frost Nova (1)
    [GetSpellInfo(126)] = {class = "WARLOCK", lvl = 22}, -- Eye of Kilrogg (Summon)
    [GetSpellInfo(130)] = {class = "MAGE", lvl = 12}, -- Slow Fall
    [GetSpellInfo(131)] = {class = "SHAMAN", lvl = 22}, -- Water Breathing
    [GetSpellInfo(132)] = {class = "WARLOCK", lvl = 26}, -- Detect Lesser Invisibility
    [GetSpellInfo(133)] = {class = "MAGE", lvl = 1}, -- Fireball (1)
    [GetSpellInfo(136)] = {class = "HUNTER", lvl = 12}, -- Mend Pet (1)
    [GetSpellInfo(139)] = {class = "PRIEST", lvl = 8}, -- Renew (1)
    [GetSpellInfo(168)] = {class = "MAGE", lvl = 1}, -- Frost Armor (1)
    [GetSpellInfo(172)] = {class = "WARLOCK", lvl = 4}, -- Corruption (1)
    [GetSpellInfo(324)] = {class = "SHAMAN", lvl = 8}, -- Lightning Shield (1)
    [GetSpellInfo(331)] = {class = "SHAMAN", lvl = 1}, -- Healing Wave (1)
    [GetSpellInfo(339)] = {class = "DRUID", lvl = 8}, -- Entangling Roots (1)
    [GetSpellInfo(348)] = {class = "WARLOCK", lvl = 1}, -- Immolate (1)
    [GetSpellInfo(355)] = {class = "WARRIOR", lvl = 10}, -- Taunt
    [GetSpellInfo(370)] = {class = "SHAMAN", lvl = 12}, -- Purge (1)
    [GetSpellInfo(403)] = {class = "SHAMAN", lvl = 1}, -- Lightning Bolt (1)
    [GetSpellInfo(408)] = {class = "ROGUE", lvl = 30}, -- Kidney Shot (1)
    [GetSpellInfo(421)] = {class = "SHAMAN", lvl = 32}, -- Chain Lightning (1)
    [GetSpellInfo(453)] = {class = "PRIEST", lvl = 20}, -- Mind Soothe (1)
    [GetSpellInfo(465)] = {class = "PALADIN", lvl = 1}, -- Devotion Aura (1)
    [GetSpellInfo(467)] = {class = "DRUID", lvl = 6}, -- Thorns (1)
    [GetSpellInfo(475)] = {class = "MAGE", lvl = 18}, -- Remove Lesser Curse
    [GetSpellInfo(498)] = {class = "PALADIN", lvl = 6}, -- Divine Protection (1)
    [GetSpellInfo(526)] = {class = "SHAMAN", lvl = 16}, -- Cure Poison
    [GetSpellInfo(527)] = {class = "PRIEST", lvl = 18}, -- Dispel Magic (1)
    [GetSpellInfo(528)] = {class = "PRIEST", lvl = 14}, -- Cure Disease
    [GetSpellInfo(543)] = {class = "MAGE", lvl = 20}, -- Fire Ward (1)
    [GetSpellInfo(546)] = {class = "SHAMAN", lvl = 28}, -- Water Walking
    [GetSpellInfo(552)] = {class = "PRIEST", lvl = 32}, -- Abolish Disease
    [GetSpellInfo(556)] = {class = "SHAMAN", lvl = 30}, -- Astral Recall
    [GetSpellInfo(585)] = {class = "PRIEST", lvl = 1}, -- Smite (1)
    [GetSpellInfo(586)] = {class = "PRIEST", lvl = 8}, -- Fade (1)
    [GetSpellInfo(587)] = {class = "MAGE", lvl = 6}, -- Conjure Food (1)
    [GetSpellInfo(588)] = {class = "PRIEST", lvl = 12}, -- Inner Fire (1)
    [GetSpellInfo(589)] = {class = "PRIEST", lvl = 4}, -- Shadow Word: Pain (1)
    [GetSpellInfo(596)] = {class = "PRIEST", lvl = 30}, -- Prayer of Healing (1)
    [GetSpellInfo(603)] = {class = "WARLOCK", lvl = 60}, -- Curse of Doom
    [GetSpellInfo(604)] = {class = "MAGE", lvl = 12}, -- Dampen Magic (1)
    [GetSpellInfo(605)] = {class = "PRIEST", lvl = 30}, -- Mind Control (1)
    [GetSpellInfo(633)] = {class = "PALADIN", lvl = 10}, -- Lay on Hands (1)
    [GetSpellInfo(635)] = {class = "PALADIN", lvl = 1}, -- Holy Light (1)
    [GetSpellInfo(642)] = {class = "PALADIN", lvl = 34}, -- Divine Shield (1)
    [GetSpellInfo(674)] = {class = "WARRIOR", lvl = 20}, -- Dual Wield (Passive)
    [GetSpellInfo(676)] = {class = "WARRIOR", lvl = 18}, -- Disarm
    [GetSpellInfo(686)] = {class = "WARLOCK", lvl = 1}, -- Shadow Bolt (1)
    [GetSpellInfo(687)] = {class = "WARLOCK", lvl = 1}, -- Demon Skin
    [GetSpellInfo(688)] = {class = "WARLOCK", lvl = 1}, -- Summon Imp (Summon)
    [GetSpellInfo(689)] = {class = "WARLOCK", lvl = 14}, -- Drain Life (1)
    [GetSpellInfo(691)] = {class = "WARLOCK", lvl = 30}, -- Summon Felhunter (Summon)
    [GetSpellInfo(693)] = {class = "WARLOCK", lvl = 18}, -- Create Soulstone (Minor)
    [GetSpellInfo(694)] = {class = "WARRIOR", lvl = 16}, -- Mocking Blow (1)
    [GetSpellInfo(697)] = {class = "WARLOCK", lvl = 10}, -- Summon Voidwalker (Summon)
    [GetSpellInfo(698)] = {class = "WARLOCK", lvl = 20}, -- Ritual of Summoning
    [GetSpellInfo(702)] = {class = "WARLOCK", lvl = 4}, -- Curse of Weakness (1)
    [GetSpellInfo(703)] = {class = "ROGUE", lvl = 14}, -- Garrote (1)
    [GetSpellInfo(704)] = {class = "WARLOCK", lvl = 14}, -- Curse of Recklessness (1)
    [GetSpellInfo(706)] = {class = "WARLOCK", lvl = 20}, -- Demon Armor (1)
    [GetSpellInfo(710)] = {class = "WARLOCK", lvl = 28}, -- Banish (1)
    [GetSpellInfo(712)] = {class = "WARLOCK", lvl = 20}, -- Summon Succubus (Summon)
    [GetSpellInfo(740)] = {class = "DRUID", lvl = 30}, -- Tranquility (1)
    [GetSpellInfo(750)] = {class = "WARRIOR", lvl = 40}, -- Plate Mail
    [GetSpellInfo(755)] = {class = "WARLOCK", lvl = 12}, -- Health Funnel (1)
    [GetSpellInfo(759)] = {class = "MAGE", lvl = 28}, -- Conjure Mana Agate
    [GetSpellInfo(768)] = {class = "DRUID", lvl = 20}, -- Cat Form (Shapeshift)
    [GetSpellInfo(770)] = {class = "DRUID", lvl = 18}, -- Faerie Fire (1)
    [GetSpellInfo(772)] = {class = "WARRIOR", lvl = 4}, -- Rend (1)
    [GetSpellInfo(774)] = {class = "DRUID", lvl = 4}, -- Rejuvenation (1)
    [GetSpellInfo(779)] = {class = "DRUID", lvl = 16}, -- Swipe (1)
    [GetSpellInfo(781)] = {class = "HUNTER", lvl = 20}, -- Disengage (1)
    [GetSpellInfo(783)] = {class = "DRUID", lvl = 30}, -- Travel Form (Shapeshift)
    [GetSpellInfo(845)] = {class = "WARRIOR", lvl = 20}, -- Cleave (1)
    [GetSpellInfo(853)] = {class = "PALADIN", lvl = 8}, -- Hammer of Justice (1)
    [GetSpellInfo(871)] = {class = "WARRIOR", lvl = 28}, -- Shield Wall
    [GetSpellInfo(879)] = {class = "PALADIN", lvl = 20}, -- Exorcism (1)
    [GetSpellInfo(883)] = {class = "HUNTER", lvl = 10}, -- Call Pet
    [GetSpellInfo(921)] = {class = "ROGUE", lvl = 4}, -- Pick Pocket
    [GetSpellInfo(976)] = {class = "PRIEST", lvl = 30}, -- Shadow Protection (1)
    [GetSpellInfo(980)] = {class = "WARLOCK", lvl = 8}, -- Curse of Agony (1)
    [GetSpellInfo(982)] = {class = "HUNTER", lvl = 10}, -- Revive Pet
    [GetSpellInfo(1002)] = {class = "HUNTER", lvl = 14}, -- Eyes of the Beast
    [GetSpellInfo(1008)] = {class = "MAGE", lvl = 18}, -- Amplify Magic (1)
    [GetSpellInfo(1022)] = {class = "PALADIN", lvl = 10}, -- Blessing of Protection (1)
    [GetSpellInfo(1038)] = {class = "PALADIN", lvl = 26}, -- Blessing of Salvation
    [GetSpellInfo(1044)] = {class = "PALADIN", lvl = 18}, -- Blessing of Freedom
    [GetSpellInfo(1064)] = {class = "SHAMAN", lvl = 40}, -- Chain Heal (1)
    [GetSpellInfo(1066)] = {class = "DRUID", lvl = 16}, -- Aquatic Form (Shapeshift)
    [GetSpellInfo(1079)] = {class = "DRUID", lvl = 20}, -- Rip (1)
    [GetSpellInfo(1082)] = {class = "DRUID", lvl = 20}, -- Claw (1)
    [GetSpellInfo(1098)] = {class = "WARLOCK", lvl = 30}, -- Enslave Demon (1)
    [GetSpellInfo(1120)] = {class = "WARLOCK", lvl = 10}, -- Drain Soul (1)
    [GetSpellInfo(1122)] = {class = "WARLOCK", lvl = 50}, -- Inferno (Summon)
    [GetSpellInfo(1126)] = {class = "DRUID", lvl = 1}, -- Mark of the Wild (1)
    [GetSpellInfo(1130)] = {class = "HUNTER", lvl = 6}, -- Hunter's Mark (1)
    [GetSpellInfo(1152)] = {class = "PALADIN", lvl = 8}, -- Purify
    [GetSpellInfo(1160)] = {class = "WARRIOR", lvl = 14}, -- Demoralizing Shout (1)
    [GetSpellInfo(1161)] = {class = "WARRIOR", lvl = 26}, -- Challenging Shout
    [GetSpellInfo(1243)] = {class = "PRIEST", lvl = 1}, -- Power Word: Fortitude (1)
    [GetSpellInfo(1449)] = {class = "MAGE", lvl = 14}, -- Arcane Explosion (1)
    [GetSpellInfo(1454)] = {class = "WARLOCK", lvl = 6}, -- Life Tap (1)
    [GetSpellInfo(1459)] = {class = "MAGE", lvl = 1}, -- Arcane Intellect (1)
    [GetSpellInfo(1462)] = {class = "HUNTER", lvl = 24}, -- Beast Lore
    [GetSpellInfo(1463)] = {class = "MAGE", lvl = 20}, -- Mana Shield (1)
    [GetSpellInfo(1464)] = {class = "WARRIOR", lvl = 30}, -- Slam (1)
    [GetSpellInfo(1490)] = {class = "WARLOCK", lvl = 32}, -- Curse of the Elements (1)
    [GetSpellInfo(1494)] = {class = "HUNTER", lvl = 1}, -- Track Beasts
    [GetSpellInfo(1495)] = {class = "HUNTER", lvl = 16}, -- Mongoose Bite (1)
    [GetSpellInfo(1499)] = {class = "HUNTER", lvl = 20}, -- Freezing Trap (1)
    [GetSpellInfo(1510)] = {class = "HUNTER", lvl = 40}, -- Volley (1)
    [GetSpellInfo(1513)] = {class = "HUNTER", lvl = 14}, -- Scare Beast (1)
    [GetSpellInfo(1515)] = {class = "HUNTER", lvl = 10}, -- Tame Beast
    [GetSpellInfo(1535)] = {class = "SHAMAN", lvl = 12}, -- Fire Nova Totem (1)
    [GetSpellInfo(1543)] = {class = "HUNTER", lvl = 32}, -- Flare
    [GetSpellInfo(1680)] = {class = "WARRIOR", lvl = 36}, -- Whirlwind
    [GetSpellInfo(1706)] = {class = "PRIEST", lvl = 34}, -- Levitate
    [GetSpellInfo(1714)] = {class = "WARLOCK", lvl = 26}, -- Curse of Tongues (1)
    [GetSpellInfo(1715)] = {class = "WARRIOR", lvl = 8}, -- Hamstring (1)
    [GetSpellInfo(1719)] = {class = "WARRIOR", lvl = 50}, -- Recklessness
    [GetSpellInfo(1725)] = {class = "ROGUE", lvl = 22}, -- Distract
    [GetSpellInfo(1752)] = {class = "ROGUE", lvl = 1}, -- Sinister Strike (1)
    [GetSpellInfo(1766)] = {class = "ROGUE", lvl = 12}, -- Kick (1)
    [GetSpellInfo(1776)] = {class = "ROGUE", lvl = 6}, -- Gouge (1)
    [GetSpellInfo(1784)] = {class = "ROGUE", lvl = 1}, -- Stealth (1)
    [GetSpellInfo(1804)] = {class = "ROGUE", lvl = 16}, -- Pick Lock
    [GetSpellInfo(1822)] = {class = "DRUID", lvl = 24}, -- Rake (1)
    [GetSpellInfo(1833)] = {class = "ROGUE", lvl = 26}, -- Cheap Shot
    [GetSpellInfo(1842)] = {class = "ROGUE", lvl = 30}, -- Disarm Trap
    [GetSpellInfo(1850)] = {class = "DRUID", lvl = 26}, -- Dash (1)
    [GetSpellInfo(1856)] = {class = "ROGUE", lvl = 22}, -- Vanish (1)
    [GetSpellInfo(1860)] = {class = "ROGUE", lvl = 40}, -- Safe Fall (Passive)
    [GetSpellInfo(1943)] = {class = "ROGUE", lvl = 20}, -- Rupture (1)
    [GetSpellInfo(1949)] = {class = "WARLOCK", lvl = 30}, -- Hellfire (1)
    [GetSpellInfo(1953)] = {class = "MAGE", lvl = 20}, -- Blink
    [GetSpellInfo(1966)] = {class = "ROGUE", lvl = 16}, -- Feint (1)
    [GetSpellInfo(1978)] = {class = "HUNTER", lvl = 4}, -- Serpent Sting (1)
    [GetSpellInfo(2006)] = {class = "PRIEST", lvl = 10}, -- Resurrection (1)
    [GetSpellInfo(2008)] = {class = "SHAMAN", lvl = 12}, -- Ancestral Spirit (1)
    [GetSpellInfo(2050)] = {class = "PRIEST", lvl = 1}, -- Lesser Heal (1)
    [GetSpellInfo(2054)] = {class = "PRIEST", lvl = 16}, -- Heal (1)
    [GetSpellInfo(2060)] = {class = "PRIEST", lvl = 40}, -- Greater Heal (1)
    [GetSpellInfo(2061)] = {class = "PRIEST", lvl = 20}, -- Flash Heal (1)
    [GetSpellInfo(2094)] = {class = "ROGUE", lvl = 34}, -- Blind
    [GetSpellInfo(2096)] = {class = "PRIEST", lvl = 22}, -- Mind Vision (1)
    [GetSpellInfo(2098)] = {class = "ROGUE", lvl = 1}, -- Eviscerate (1)
    [GetSpellInfo(2120)] = {class = "MAGE", lvl = 16}, -- Flamestrike (1)
    [GetSpellInfo(2136)] = {class = "MAGE", lvl = 6}, -- Fire Blast (1)
    [GetSpellInfo(2139)] = {class = "MAGE", lvl = 24}, -- Counterspell
    [GetSpellInfo(2362)] = {class = "WARLOCK", lvl = 36}, -- Create Spellstone
    [GetSpellInfo(2458)] = {class = "WARRIOR", lvl = 30}, -- Berserker Stance
    [GetSpellInfo(2457)] = {class = "WARRIOR", lvl = 1}, -- Battle Stance
    [GetSpellInfo(2484)] = {class = "SHAMAN", lvl = 6}, -- Earthbind Totem
    [GetSpellInfo(2565)] = {class = "WARRIOR", lvl = 16}, -- Shield Block
    [GetSpellInfo(2637)] = {class = "DRUID", lvl = 18}, -- Hibernate (1)
    [GetSpellInfo(2641)] = {class = "HUNTER", lvl = 10}, -- Dismiss Pet
    [GetSpellInfo(2643)] = {class = "HUNTER", lvl = 18}, -- Multi-Shot (1)
    [GetSpellInfo(2645)] = {class = "SHAMAN", lvl = 20}, -- Ghost Wolf
    [GetSpellInfo(2651)] = {class = "PRIEST", lvl = 20}, -- Elune's Grace (1)
    [GetSpellInfo(2652)] = {class = "PRIEST", lvl = 10}, -- Touch of Weakness (1)
    [GetSpellInfo(2687)] = {class = "WARRIOR", lvl = 10}, -- Bloodrage
    [GetSpellInfo(2782)] = {class = "DRUID", lvl = 24}, -- Remove Curse
    [GetSpellInfo(2812)] = {class = "PALADIN", lvl = 50}, -- Holy Wrath (1)
    [GetSpellInfo(2835)] = {class = "ROGUE", lvl = 30}, -- Deadly Poison (1)
    [GetSpellInfo(2836)] = {class = "ROGUE", lvl = 24}, -- Detect Traps (Passive)
    [GetSpellInfo(2842)] = {class = "ROGUE", lvl = 20}, -- Poisons
    [GetSpellInfo(2855)] = {class = "MAGE", lvl = 16}, -- Detect Magic
    [GetSpellInfo(2870)] = {class = "SHAMAN", lvl = 14}, -- Cure Disease
    [GetSpellInfo(2878)] = {class = "PALADIN", lvl = 24}, -- Turn Undead (1)
    [GetSpellInfo(2893)] = {class = "DRUID", lvl = 26}, -- Abolish Poison
    [GetSpellInfo(2908)] = {class = "DRUID", lvl = 22}, -- Soothe Animal (1)
    [GetSpellInfo(2912)] = {class = "DRUID", lvl = 20}, -- Starfire (1)
    [GetSpellInfo(2944)] = {class = "PRIEST", lvl = 20}, -- Devouring Plague (1)
    [GetSpellInfo(2948)] = {class = "MAGE", lvl = 22}, -- Scorch (1)
    [GetSpellInfo(2970)] = {class = "WARLOCK", lvl = 38}, -- Detect Invisibility
    [GetSpellInfo(2973)] = {class = "HUNTER", lvl = 1}, -- Raptor Strike (1)
    [GetSpellInfo(2974)] = {class = "HUNTER", lvl = 12}, -- Wing Clip (1)
    [GetSpellInfo(2983)] = {class = "ROGUE", lvl = 10}, -- Sprint (1)
    [GetSpellInfo(3034)] = {class = "HUNTER", lvl = 36}, -- Viper Sting (1)
    [GetSpellInfo(3043)] = {class = "HUNTER", lvl = 22}, -- Scorpid Sting (1)
    [GetSpellInfo(3044)] = {class = "HUNTER", lvl = 6}, -- Arcane Shot (1)
    [GetSpellInfo(3045)] = {class = "HUNTER", lvl = 26}, -- Rapid Fire
    [GetSpellInfo(3127)] = {class = "WARRIOR", lvl = 6}, -- Parry (Passive)
    [GetSpellInfo(3420)] = {class = "ROGUE", lvl = 20}, -- Crippling Poison (1)
    [GetSpellInfo(3552)] = {class = "MAGE", lvl = 38}, -- Conjure Mana Jade
    [GetSpellInfo(3561)] = {class = "MAGE", lvl = 20}, -- Teleport: Stormwind
    [GetSpellInfo(3562)] = {class = "MAGE", lvl = 20}, -- Teleport: Ironforge
    [GetSpellInfo(3563)] = {class = "MAGE", lvl = 20}, -- Teleport: Undercity
    [GetSpellInfo(3565)] = {class = "MAGE", lvl = 30}, -- Teleport: Darnassus
    [GetSpellInfo(3566)] = {class = "MAGE", lvl = 30}, -- Teleport: Thunder Bluff
    [GetSpellInfo(3567)] = {class = "MAGE", lvl = 20}, -- Teleport: Orgrimmar
    [GetSpellInfo(3599)] = {class = "SHAMAN", lvl = 10}, -- Searing Totem (1)
    [GetSpellInfo(4987)] = {class = "PALADIN", lvl = 42}, -- Cleanse
    [GetSpellInfo(5116)] = {class = "HUNTER", lvl = 8}, -- Concussive Shot
    [GetSpellInfo(5118)] = {class = "HUNTER", lvl = 20}, -- Aspect of the Cheetah
    [GetSpellInfo(5138)] = {class = "WARLOCK", lvl = 24}, -- Drain Mana (1)
    [GetSpellInfo(5143)] = {class = "MAGE", lvl = 8}, -- Arcane Missiles (1)
    [GetSpellInfo(5149)] = {class = "HUNTER", lvl = 10}, -- Beast Training
    [GetSpellInfo(5171)] = {class = "ROGUE", lvl = 10}, -- Slice and Dice (1)
    [GetSpellInfo(5176)] = {class = "DRUID", lvl = 1}, -- Wrath (1)
    [GetSpellInfo(5186)] = {class = "DRUID", lvl = 8}, -- Healing Touch 2
    [GetSpellInfo(5209)] = {class = "DRUID", lvl = 28}, -- Challenging Roar
    [GetSpellInfo(5211)] = {class = "DRUID", lvl = 14}, -- Bash (1)
    [GetSpellInfo(5215)] = {class = "DRUID", lvl = 20}, -- Prowl (1)
    [GetSpellInfo(5217)] = {class = "DRUID", lvl = 24}, -- Tiger's Fury (1)
    [GetSpellInfo(5221)] = {class = "DRUID", lvl = 22}, -- Shred (1)
    [GetSpellInfo(5225)] = {class = "DRUID", lvl = 32}, -- Track Humanoids
    [GetSpellInfo(5229)] = {class = "DRUID", lvl = 12}, -- Enrage
    [GetSpellInfo(5246)] = {class = "WARRIOR", lvl = 22}, -- Intimidating Shout
    [GetSpellInfo(5277)] = {class = "ROGUE", lvl = 8}, -- Evasion
    [GetSpellInfo(5308)] = {class = "WARRIOR", lvl = 24}, -- Execute (1)
    [GetSpellInfo(5384)] = {class = "HUNTER", lvl = 30}, -- Feign Death
    [GetSpellInfo(5394)] = {class = "SHAMAN", lvl = 20}, -- Healing Stream Totem (1)
    [GetSpellInfo(5484)] = {class = "WARLOCK", lvl = 40}, -- Howl of Terror (1)
    [GetSpellInfo(5487)] = {class = "DRUID", lvl = 10}, -- Bear Form (Shapeshift)
    [GetSpellInfo(5500)] = {class = "WARLOCK", lvl = 24}, -- Sense Demons
    [GetSpellInfo(5502)] = {class = "PALADIN", lvl = 20}, -- Sense Undead
    [GetSpellInfo(5504)] = {class = "MAGE", lvl = 4}, -- Conjure Water (1)
    [GetSpellInfo(5675)] = {class = "SHAMAN", lvl = 26}, -- Mana Spring Totem (1)
    [GetSpellInfo(5676)] = {class = "WARLOCK", lvl = 18}, -- Searing Pain (1)
    [GetSpellInfo(5697)] = {class = "WARLOCK", lvl = 16}, -- Unending Breath
    [GetSpellInfo(5699)] = {class = "WARLOCK", lvl = 34}, -- Create Healthstone
    [GetSpellInfo(5730)] = {class = "SHAMAN", lvl = 8}, -- Stoneclaw Totem (1)
    [GetSpellInfo(5740)] = {class = "WARLOCK", lvl = 20}, -- Rain of Fire (1)
    [GetSpellInfo(5763)] = {class = "ROGUE", lvl = 24}, -- Mind-numbing Poison (1)
    [GetSpellInfo(5782)] = {class = "WARLOCK", lvl = 8}, -- Fear (1)
    [GetSpellInfo(5784)] = {class = "WARLOCK", lvl = 40}, -- Summon Felsteed (Summon)
    [GetSpellInfo(6117)] = {class = "MAGE", lvl = 34}, -- Mage Armor (1)
    [GetSpellInfo(6143)] = {class = "MAGE", lvl = 22}, -- Frost Ward (1)
    [GetSpellInfo(6196)] = {class = "SHAMAN", lvl = 26}, -- Far Sight
    [GetSpellInfo(6197)] = {class = "HUNTER", lvl = 14}, -- Eagle Eye
    [GetSpellInfo(6201)] = {class = "WARLOCK", lvl = 10}, -- Create Healthstone (Minor)
    [GetSpellInfo(6202)] = {class = "WARLOCK", lvl = 22}, -- Create Healthstone (Lesser)
    [GetSpellInfo(6229)] = {class = "WARLOCK", lvl = 32}, -- Shadow Ward (1)
    [GetSpellInfo(6343)] = {class = "WARRIOR", lvl = 6}, -- Thunder Clap (1)
    [GetSpellInfo(6346)] = {class = "PRIEST", lvl = 20}, -- Fear Ward
    [GetSpellInfo(6353)] = {class = "WARLOCK", lvl = 48}, -- Soul Fire (1)
    [GetSpellInfo(6366)] = {class = "WARLOCK", lvl = 28}, -- Create Firestone (Lesser)
    [GetSpellInfo(6495)] = {class = "SHAMAN", lvl = 34}, -- Sentry Totem
    [GetSpellInfo(6510)] = {class = "ROGUE", lvl = 34}, -- Blinding Powder
    [GetSpellInfo(6552)] = {class = "WARRIOR", lvl = 38}, -- Pummel (1)
    [GetSpellInfo(6572)] = {class = "WARRIOR", lvl = 14}, -- Revenge (1)
    [GetSpellInfo(6673)] = {class = "WARRIOR", lvl = 1}, -- Battle Shout (1)
    [GetSpellInfo(6770)] = {class = "ROGUE", lvl = 10}, -- Sap (1)
    [GetSpellInfo(6785)] = {class = "DRUID", lvl = 32}, -- Ravage (1)
    [GetSpellInfo(6789)] = {class = "WARLOCK", lvl = 42}, -- Death Coil (1)
    [GetSpellInfo(6795)] = {class = "DRUID", lvl = 10}, -- Growl
    [GetSpellInfo(6807)] = {class = "DRUID", lvl = 10}, -- Maul (1)
    [GetSpellInfo(6940)] = {class = "PALADIN", lvl = 46}, -- Blessing of Sacrifice (1)
    [GetSpellInfo(6991)] = {class = "HUNTER", lvl = 10}, -- Feed Pet
    [GetSpellInfo(7294)] = {class = "PALADIN", lvl = 16}, -- Retribution Aura (1)
    [GetSpellInfo(7302)] = {class = "MAGE", lvl = 30}, -- Ice Armor (1)
    [GetSpellInfo(7328)] = {class = "PALADIN", lvl = 12}, -- Redemption (1)
    [GetSpellInfo(7384)] = {class = "WARRIOR", lvl = 12}, -- Overpower (1)
    [GetSpellInfo(7386)] = {class = "WARRIOR", lvl = 10}, -- Sunder Armor (1)
    [GetSpellInfo(8004)] = {class = "SHAMAN", lvl = 20}, -- Lesser Healing Wave (1)
    [GetSpellInfo(8017)] = {class = "SHAMAN", lvl = 1}, -- Rockbiter Weapon (1)
    [GetSpellInfo(8024)] = {class = "SHAMAN", lvl = 10}, -- Flametongue Weapon (1)
    [GetSpellInfo(8033)] = {class = "SHAMAN", lvl = 20}, -- Frostbrand Weapon (1)
    [GetSpellInfo(8042)] = {class = "SHAMAN", lvl = 4}, -- Earth Shock (1)
    [GetSpellInfo(8050)] = {class = "SHAMAN", lvl = 10}, -- Flame Shock (1)
    [GetSpellInfo(8056)] = {class = "SHAMAN", lvl = 20}, -- Frost Shock (1)
    [GetSpellInfo(8071)] = {class = "SHAMAN", lvl = 4}, -- Stoneskin Totem (1)
    [GetSpellInfo(8075)] = {class = "SHAMAN", lvl = 10}, -- Strength of Earth Totem (1)
    [GetSpellInfo(8092)] = {class = "PRIEST", lvl = 10}, -- Mind Blast (1)
    [GetSpellInfo(8122)] = {class = "PRIEST", lvl = 14}, -- Psychic Scream (1)
    [GetSpellInfo(8129)] = {class = "PRIEST", lvl = 24}, -- Mana Burn (1)
    [GetSpellInfo(8143)] = {class = "SHAMAN", lvl = 18}, -- Tremor Totem
    [GetSpellInfo(8166)] = {class = "SHAMAN", lvl = 22}, -- Poison Cleansing Totem
    [GetSpellInfo(8170)] = {class = "SHAMAN", lvl = 38}, -- Disease Cleansing Totem
    [GetSpellInfo(8177)] = {class = "SHAMAN", lvl = 30}, -- Grounding Totem
    [GetSpellInfo(8181)] = {class = "SHAMAN", lvl = 24}, -- Frost Resistance Totem (1)
    [GetSpellInfo(8184)] = {class = "SHAMAN", lvl = 28}, -- Fire Resistance Totem (1)
    [GetSpellInfo(8190)] = {class = "SHAMAN", lvl = 26}, -- Magma Totem (1)
    [GetSpellInfo(8227)] = {class = "SHAMAN", lvl = 28}, -- Flametongue Totem (1)
    [GetSpellInfo(8232)] = {class = "SHAMAN", lvl = 30}, -- Windfury Weapon (1)
    [GetSpellInfo(8512)] = {class = "SHAMAN", lvl = 32}, -- Windfury Totem (1)
    [GetSpellInfo(8647)] = {class = "ROGUE", lvl = 14}, -- Expose Armor (1)
    [GetSpellInfo(8676)] = {class = "ROGUE", lvl = 18}, -- Ambush (1)
    [GetSpellInfo(8737)] = {class = "SHAMAN", lvl = 40}, -- Mail
    [GetSpellInfo(8835)] = {class = "SHAMAN", lvl = 42}, -- Grace of Air Totem (1)
    [GetSpellInfo(8921)] = {class = "DRUID", lvl = 4}, -- Moonfire (1)
    [GetSpellInfo(8936)] = {class = "DRUID", lvl = 12}, -- Regrowth (1)
    [GetSpellInfo(8946)] = {class = "DRUID", lvl = 14}, -- Cure Poison
    [GetSpellInfo(8998)] = {class = "DRUID", lvl = 28}, -- Cower (1)
    [GetSpellInfo(9005)] = {class = "DRUID", lvl = 36}, -- Pounce (1)
    [GetSpellInfo(9035)] = {class = "PRIEST", lvl = 10}, -- Hex of Weakness (1)
    [GetSpellInfo(9484)] = {class = "PRIEST", lvl = 20}, -- Shackle Undead (1)
    [GetSpellInfo(9634)] = {class = "DRUID", lvl = 40}, -- Dire Bear Form (Shapeshift)
    [GetSpellInfo(10053)] = {class = "MAGE", lvl = 48}, -- Conjure Mana Citrine
    [GetSpellInfo(10054)] = {class = "MAGE", lvl = 58}, -- Conjure Mana Ruby
    [GetSpellInfo(10059)] = {class = "MAGE", lvl = 40}, -- Portal: Stormwind
    [GetSpellInfo(10595)] = {class = "SHAMAN", lvl = 30}, -- Nature Resistance Totem (1)
    [GetSpellInfo(10797)] = {class = "PRIEST", lvl = 10}, -- Starshards (1)
    [GetSpellInfo(11129)] = {class = "MAGE", lvl = 40}, -- Combustion
    [GetSpellInfo(11416)] = {class = "MAGE", lvl = 40}, -- Portal: Ironforge
    [GetSpellInfo(11417)] = {class = "MAGE", lvl = 40}, -- Portal: Orgrimmar
    [GetSpellInfo(11418)] = {class = "MAGE", lvl = 40}, -- Portal: Undercity
    [GetSpellInfo(11419)] = {class = "MAGE", lvl = 50}, -- Portal: Darnassus
    [GetSpellInfo(11420)] = {class = "MAGE", lvl = 50}, -- Portal: Thunder Bluff
    [GetSpellInfo(11426)] = {class = "MAGE", lvl = 40}, -- Ice Barrier (1)
    [GetSpellInfo(11729)] = {class = "WARLOCK", lvl = 46}, -- Create Healthstone (Greater)
    [GetSpellInfo(11730)] = {class = "WARLOCK", lvl = 58}, -- Create Healthstone (Major)
    [GetSpellInfo(11743)] = {class = "WARLOCK", lvl = 50}, -- Detect Greater Invisibility
    [GetSpellInfo(12051)] = {class = "MAGE", lvl = 20}, -- Evocation
    [GetSpellInfo(13159)] = {class = "HUNTER", lvl = 40}, -- Aspect of the Pack
    [GetSpellInfo(13161)] = {class = "HUNTER", lvl = 30}, -- Aspect of the Beast
    [GetSpellInfo(13163)] = {class = "HUNTER", lvl = 4}, -- Aspect of the Monkey
    [GetSpellInfo(13165)] = {class = "HUNTER", lvl = 10}, -- Aspect of the Hawk (1)
    [GetSpellInfo(13220)] = {class = "ROGUE", lvl = 32}, -- Wound Poison (1)
    [GetSpellInfo(13795)] = {class = "HUNTER", lvl = 16}, -- Immolation Trap (1)
    [GetSpellInfo(13809)] = {class = "HUNTER", lvl = 28}, -- Frost Trap
    [GetSpellInfo(13813)] = {class = "HUNTER", lvl = 34}, -- Explosive Trap (1)
    [GetSpellInfo(13819)] = {class = "PALADIN", lvl = 40}, -- Summon Warhorse (Summon)
    [GetSpellInfo(13896)] = {class = "PRIEST", lvl = 20}, -- Feedback (1)
    [GetSpellInfo(13908)] = {class = "PRIEST", lvl = 10}, -- Desperate Prayer (1)
    [GetSpellInfo(14914)] = {class = "PRIEST", lvl = 20}, -- Holy Fire (1)
    [GetSpellInfo(15107)] = {class = "SHAMAN", lvl = 36}, -- Windwall Totem (1)
    [GetSpellInfo(16914)] = {class = "DRUID", lvl = 40}, -- Hurricane (1)
    [GetSpellInfo(17727)] = {class = "WARLOCK", lvl = 48}, -- Create Spellstone (Greater)
    [GetSpellInfo(17728)] = {class = "WARLOCK", lvl = 60}, -- Create Spellstone (Major)
    [GetSpellInfo(17862)] = {class = "WARLOCK", lvl = 44}, -- Curse of Shadow (1)
    [GetSpellInfo(17951)] = {class = "WARLOCK", lvl = 36}, -- Create Firestone
    [GetSpellInfo(17952)] = {class = "WARLOCK", lvl = 46}, -- Create Firestone (Greater)
    [GetSpellInfo(17953)] = {class = "WARLOCK", lvl = 56}, -- Create Firestone (Major)
    [GetSpellInfo(18137)] = {class = "PRIEST", lvl = 20}, -- Shadowguard (1)
    [GetSpellInfo(18499)] = {class = "WARRIOR", lvl = 32}, -- Berserker Rage
    [GetSpellInfo(18540)] = {class = "WARLOCK", lvl = 60}, -- Ritual of Doom
    [GetSpellInfo(18960)] = {class = "DRUID", lvl = 10}, -- Teleport: Moonglade
    [GetSpellInfo(19740)] = {class = "PALADIN", lvl = 4}, -- Blessing of Might (1)
    [GetSpellInfo(19742)] = {class = "PALADIN", lvl = 14}, -- Blessing of Wisdom (1)
    [GetSpellInfo(19746)] = {class = "PALADIN", lvl = 22}, -- Concentration Aura
    [GetSpellInfo(19750)] = {class = "PALADIN", lvl = 20}, -- Flash of Light (1)
    [GetSpellInfo(19752)] = {class = "PALADIN", lvl = 30}, -- Divine Intervention
    [GetSpellInfo(19801)] = {class = "HUNTER", lvl = 60}, -- Tranquilizing Shot
    [GetSpellInfo(19876)] = {class = "PALADIN", lvl = 28}, -- Shadow Resistance Aura (1)
    [GetSpellInfo(19878)] = {class = "HUNTER", lvl = 32}, -- Track Demons
    [GetSpellInfo(19879)] = {class = "HUNTER", lvl = 50}, -- Track Dragonkin
    [GetSpellInfo(19880)] = {class = "HUNTER", lvl = 26}, -- Track Elementals
    [GetSpellInfo(19882)] = {class = "HUNTER", lvl = 40}, -- Track Giants
    [GetSpellInfo(19883)] = {class = "HUNTER", lvl = 10}, -- Track Humanoids
    [GetSpellInfo(19884)] = {class = "HUNTER", lvl = 18}, -- Track Undead
    [GetSpellInfo(19885)] = {class = "HUNTER", lvl = 24}, -- Track Hidden
    [GetSpellInfo(19888)] = {class = "PALADIN", lvl = 32}, -- Frost Resistance Aura (1)
    [GetSpellInfo(19891)] = {class = "PALADIN", lvl = 36}, -- Fire Resistance Aura (1)
    [GetSpellInfo(19977)] = {class = "PALADIN", lvl = 40}, -- Blessing of Light (1)
    [GetSpellInfo(20043)] = {class = "HUNTER", lvl = 46}, -- Aspect of the Wild (1)
    [GetSpellInfo(20164)] = {class = "PALADIN", lvl = 22}, -- Seal of Justice
    [GetSpellInfo(20165)] = {class = "PALADIN", lvl = 30}, -- Seal of Light (1)
    [GetSpellInfo(20166)] = {class = "PALADIN", lvl = 38}, -- Seal of Wisdom (1)
    [GetSpellInfo(20230)] = {class = "WARRIOR", lvl = 20}, -- Retaliation
    [GetSpellInfo(20252)] = {class = "WARRIOR", lvl = 30}, -- Intercept (1)
    [GetSpellInfo(20271)] = {class = "PALADIN", lvl = 4}, -- Judgement
    [GetSpellInfo(20484)] = {class = "DRUID", lvl = 20}, -- Rebirth (1)
    [GetSpellInfo(20608)] = {class = "SHAMAN", lvl = 30}, -- Reincarnation (Passive)
    [GetSpellInfo(20719)] = {class = "DRUID", lvl = 40}, -- Feline Grace (Passive)
    [GetSpellInfo(20736)] = {class = "HUNTER", lvl = 12}, -- Distracting Shot (1)
    [GetSpellInfo(20752)] = {class = "WARLOCK", lvl = 30}, -- Create Soulstone (Lesser)
    [GetSpellInfo(20755)] = {class = "WARLOCK", lvl = 40}, -- Create Soulstone
    [GetSpellInfo(20756)] = {class = "WARLOCK", lvl = 50}, -- Create Soulstone (Greater)
    [GetSpellInfo(20757)] = {class = "WARLOCK", lvl = 60}, -- Create Soulstone (Major)
    [GetSpellInfo(21082)] = {class = "PALADIN", lvl = 6}, -- Seal of the Crusader (1)
    [GetSpellInfo(21084)] = {class = "PALADIN", lvl = 1}, -- Seal of Righteousness (1)
    [GetSpellInfo(21169)] = {class = "SHAMAN", lvl = 30}, -- Reincarnation
    [GetSpellInfo(21562)] = {class = "PRIEST", lvl = 48}, -- Prayer of Fortitude (1)
    [GetSpellInfo(21849)] = {class = "DRUID", lvl = 50}, -- Gift of the Wild (1)
    [GetSpellInfo(22568)] = {class = "DRUID", lvl = 32}, -- Ferocious Bite (1)
    [GetSpellInfo(22812)] = {class = "DRUID", lvl = 44}, -- Barkskin
    [GetSpellInfo(22842)] = {class = "DRUID", lvl = 36}, -- Frenzied Regeneration (1)
    [GetSpellInfo(23028)] = {class = "MAGE", lvl = 56}, -- Arcane Brilliance (1)
    [GetSpellInfo(23161)] = {class = "WARLOCK", lvl = 60}, -- Summon Dreadsteed (Summon)
    [GetSpellInfo(23214)] = {class = "PALADIN", lvl = 60}, -- Summon Charger (Summon)
    [GetSpellInfo(24275)] = {class = "PALADIN", lvl = 44}, -- Hammer of Wrath (1)
    [GetSpellInfo(25780)] = {class = "PALADIN", lvl = 16}, -- Righteous Fury
    [GetSpellInfo(25782)] = {class = "PALADIN", lvl = 52}, -- Greater Blessing of Might (1)
    [GetSpellInfo(25890)] = {class = "PALADIN", lvl = 60}, -- Greater Blessing of Light (1)
    [GetSpellInfo(25894)] = {class = "PALADIN", lvl = 54}, -- Greater Blessing of Wisdom (1)
    [GetSpellInfo(25895)] = {class = "PALADIN", lvl = 60}, -- Greater Blessing of Salvation
    [GetSpellInfo(25898)] = {class = "PALADIN", lvl = 60}, -- Greater Blessing of Kings
    [GetSpellInfo(25899)] = {class = "PALADIN", lvl = 60}, -- Greater Blessing of Sanctuary (1)
    [GetSpellInfo(25908)] = {class = "SHAMAN", lvl = 50}, -- Tranquil Air Totem
    [GetSpellInfo(27681)] = {class = "PRIEST", lvl = 60}, -- Prayer of Spirit (1)
    [GetSpellInfo(27683)] = {class = "PRIEST", lvl = 56}, -- Prayer of Shadow Protection (1)
    [GetSpellInfo(28271)] = {class = "MAGE", lvl = 60}, -- Polymorph: Turtle
    [GetSpellInfo(28272)] = {class = "MAGE", lvl = 60}, -- Polymorph: Pig
    [GetSpellInfo(29166)] = {class = "DRUID", lvl = 40}, -- Innervate
};

--- Check if spell is a stealth spell
-- @param spellName The name of the spell
-- @return true if the spell is a known stealth spell
function _addon.IsStealthSpell(spellName)
    if stealthSpells[spellName] then 
        return true;
    end
    return false;
end

--- Get ID of stealth spell from name
-- @param spellName The name of the spell
-- @return the ID of the max rank, nil if name not known
function _addon.GetStealthSpellId(spellName)
    return stealthSpells[spellName];
end

--- Get class and level from spellName
-- @param spellName The name of the spell
-- @returns the class the spell belongs to, "UNKNOWN" if not found
-- @returns the level it is learned on, 0 if not found
function _addon.GetClassAndLevelFromSpellId(spellName)
    if classSpells[spellName] == nil then
        return "UNKNOWN", 0;
    end
    return classSpells[spellName].class, classSpells[spellName].lvl;
end