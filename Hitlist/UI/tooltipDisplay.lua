local _, _addon = ...;
local realmName = GetRealmName();
local L = _addon:GetLocalization();

-- Add reason if target is on list
GameTooltip:SetScript("OnTooltipSetUnit", function(self)
    local data = Hitlist_data[realmName].entries[self:GetUnit()];
    if data == nil then 
        return; 
    end
	self:AddLine(L["UI_TT_PLAYER_ON_LIST"], 1, 0.2, 0.2);
    self:AddLine(data.reason, 1, 0.75, 0.3, true);
    
    local byName = data.by;
    if Hitlist_data[realmName].localNames[byName] ~= nil then
        byName = L["UI_TT_YOU"];
    end
    self:AddLine(L["UI_TT_ADDED_BY"]:format(byName, _addon:HumanTimeDiff(time() - data.added)), 0.75, 0.75, 0.75, true);
end);