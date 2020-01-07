local MyAddonName, MyAddonTable = ...

MyAddonTable.Utility = MyAddonTable.Utility or {}
local Utility = MyAddonTable.Utility

--[[
]]

Utility.Spell = {}
local this = Utility.Spell

function this.GetSpellInfoByID(SpellID, CBFunction)

	local MySpell = Spell:CreateFromSpellID(SpellID)
	if(MySpell:IsSpellDataCached() == true) then
		CBFunction(MySpell)
	else
		MySpell:ContinueOnSpellLoad(function()
			CBFunction(MySpell)
			return
		end)
	end
	
	return
end
