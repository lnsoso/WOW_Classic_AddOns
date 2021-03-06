-- -------------------------------------------------------------------------- --
-- BattlegroundTargets - talents                                              --
-- -------------------------------------------------------------------------- --

local TLT, _, prg = {}, ...
prg.TLT = TLT

local DAMAGER = 3
local HEALER  = 1
local TANK    = 2
local locale = GetLocale()

if locale == "esES" then

	TLT.PRIEST      = {spec = {{role = HEALER,  specID = 257, specName = "Sagrada", icon = [[Interface\Icons\Spell_Holy_GuardianSpirit]]}}}
	TLT.DRUID       = {spec = {{role = TANK,    specID = 104, specName = "Guardiana", icon = [[Interface\Icons\Ability_Racial_BearForm]]}}}
	TLT.PALADIN     = {spec = {{role = HEALER,  specID =  65, specName = "Sagrada", icon = [[Interface\Icons\Spell_Holy_HolyBolt]]}}}

elseif locale == "esMX" then

	TLT.PRIEST      = {spec = {{role = HEALER,  specID = 257, specName = "Sagrada", icon = [[Interface\Icons\Spell_Holy_GuardianSpirit]]}}}
	TLT.DRUID       = {spec = {{role = TANK,    specID = 104, specName = "Guardiana", icon = [[Interface\Icons\Ability_Racial_BearForm]]}}}
	TLT.PALADIN     = {spec = {{role = HEALER,  specID =  65, specName = "Sagrada", icon = [[Interface\Icons\Spell_Holy_HolyBolt]]}}}

elseif locale == "frFR" then

	TLT.PALADIN     = {spec = {{role = DAMAGER, specID =  70, specName = "Retribution", icon = [[Interface\Icons\Spell_Holy_AuraOfLight]]}}}

elseif locale == "ruRU" then

end