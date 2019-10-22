local mod	= DBM:NewMod("WarnForLootmaster", "RaidLeadTools")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190910230438")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:AddBoolOption("Enabled", false)

do
	local GetLootMaster = GetLootMaster

	function mod:OnInitialize()
		DBM:RegisterCallback("pull", function()
			if not mod.Options.Enabled then
				return
			end
			if GetLootMaster() ~= "master" then
				mod:AddMsg(L.WarningNoLootMaster)
			end
		end)
	end
end
