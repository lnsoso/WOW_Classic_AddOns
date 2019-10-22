local _, _addon = ...;
local DEFAULT_Y_OFFSET = 275;
local L = _addon:GetLocalization();

local frame = CreateFrame("Frame", "HLUI_TargetNotification", UIParent);

frame:SetSize(130, 110);
frame:SetPoint("CENTER", 0, DEFAULT_Y_OFFSET);
frame:SetClampedToScreen(true);
frame:SetMovable(true);
frame:EnableMouse(true);
frame:RegisterForDrag("LeftButton");
frame:SetScript("OnDragStart", frame.StartMoving);
frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
frame:SetFrameStrata("MEDIUM");
frame:Hide();

frame.artworkTexture = frame:CreateTexture(nil, "ARTWORK");
frame.artworkTexture:SetPoint("CENTER", frame, "CENTER", 0, 0);
frame.artworkTexture:SetTexture ([[Interface\AddOns\Hitlist\img\frametex]]);
frame.artworkTexture:SetSize(256, 128);

frame.label = frame:CreateFontString(nil, nil, 'GameFontDisable');
frame.label:SetText(L["UI_TARGETDISP_TARGET_FOUND"]);
frame.label:SetFont("Fonts\\ARHei.TTF", 11, "OUTLINE");
frame.label:SetPoint("CENTER", frame, "CENTER", 0, -10);

frame.targetName = frame:CreateFontString(nil, nil, 'GameFontRedLarge');
frame.targetName = frame:CreateFontString(nil, nil, 'GameFontRedLarge');
frame.targetName:SetFont("Fonts\\ARHei.TTF", 22, "OUTLINE");
frame.targetName:SetPoint("CENTER", frame, "CENTER", 0, -29);

frame.combatTooltip = CreateFrame("Frame", nil, frame);
frame.combatTooltip:SetSize(140, 40);
frame.combatTooltip:SetPoint("CENTER", frame, "CENTER", 0, -22);

frame.targetButton = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate");
frame.targetButton:SetAttribute("type1", "macro");
frame.targetButton:SetPoint("CENTER", 0, 0);
frame.targetButton:SetSize(140, 40);
frame.targetButton:Hide();
frame.targetButton:SetFrameStrata("MEDIUM");
frame.targetButton:SetFrameLevel(284);
frame.targetButton:RegisterForClicks("AnyUp");

-- Tooltips
frame.combatTooltip:SetScript("OnEnter", function(self) 
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
    GameTooltip:SetText(L["UI_TARGETDISP_TARGETING_LOCKED"]);
	GameTooltip:Show();
end);

frame.combatTooltip:SetScript("OnLeave", function() 
    GameTooltip:Hide(); 
end);

frame.targetButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
	if InCombatLockdown() then
        GameTooltip:SetText(L["UI_TARGETDISP_TT_TARGET"]);
    else
        GameTooltip:SetText(L["UI_TARGETDISP_TT_TARGET_HIDE"]);
    end
    GameTooltip:Show();
end);

frame.targetButton:SetScript("OnLeave", function() 
    GameTooltip:Hide(); 
end);

--- Reset to default position
function frame:Reset() 
    self:ClearAllPoints();
    self:SetPoint("CENTER", 0, DEFAULT_Y_OFFSET);
end