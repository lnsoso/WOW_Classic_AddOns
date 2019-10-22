local _, _addon = ...;
local nameCached = nil;

--- Set button macro and make it "visible"
-- @param name Name to set for targeting
local function ActivateTargetButton(name)
    _addon:PrintDebug("activate tn secure button");
	HLUI_TargetNotification.targetButton:SetAttribute("macrotext1", "/target "..name);
	HLUI_TargetNotification.targetButton:ClearAllPoints();
	HLUI_TargetNotification.targetButton:SetPoint("CENTER", HLUI_TargetNotification, "CENTER", 0, -22);
	HLUI_TargetNotification.targetButton:Show();
end

--- Set target display target
-- @param name The name of the target
-- @returns true if successfully set, false if target display already used
function _addon:TargetNotification_SetTarget(name)
    if HLUI_TargetNotification:IsShown() then 
        return false;
    end

    HLUI_TargetNotification.targetName:SetText(name);
    HLUI_TargetNotification:Show();
    
    if not InCombatLockdown() then 
        ActivateTargetButton(name);
    else
        nameCached = name;
    end

    return true;
end

--- Activate secure button if needed
function _addon:TargetNotification_CombatEnded()
    if nameCached ~= nil then
        ActivateTargetButton(nameCached);
        nameCached = nil;
    end
end

HLUI_TargetNotification.targetButton:HookScript("OnClick", function (self, button)
	if button ~= "RightButton" or InCombatLockdown() then 
		return;
    end

    HLUI_TargetNotification.targetButton:ClearAllPoints();
    HLUI_TargetNotification.targetButton:SetPoint("CENTER", UIParent, 0, 0);
    HLUI_TargetNotification.targetButton:Hide();
    HLUI_TargetNotification:Hide();
end);