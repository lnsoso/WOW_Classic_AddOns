local _, _addon = ...;
local L = _addon:GetLocalization();
local ITEM_HEIGHT = 22;
local HEADER_HEIGHT = 25;
local FRAME_WIDTH = 225;
local MAX_ITEMS = 15;
local DEFAULT_X_OFFSET = -275;

local frame = CreateFrame("Frame", "HLUI_NearbyList", UIParent);

frame:SetPoint("CENTER", DEFAULT_X_OFFSET, 0);
frame:SetFrameStrata("MEDIUM");
frame:SetWidth(FRAME_WIDTH);
frame:SetHeight(HEADER_HEIGHT);
frame:SetClampedToScreen(true);
frame:SetMaxResize(FRAME_WIDTH, 800);
frame:SetMinResize(FRAME_WIDTH, 200);
frame:SetMovable(true);
frame:EnableMouse(true);
frame:RegisterForDrag("LeftButton");
frame:SetScript("OnDragStart", frame.StartMoving);
frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
frame:Hide();

frame.header = CreateFrame("Frame", nil, frame);
frame.header:SetPoint("TOPLEFT", 0, 0);
frame.header:SetPoint("TOPRIGHT", 0, 0);
frame.header:SetHeight(HEADER_HEIGHT);
frame.header.title = frame.header:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.header.title:SetPoint("CENTER", 0, 0);
frame.header.title:SetText(L["NBL_TITLE"]);
frame.header:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"});
frame.header:SetBackdropColor(0,0,0,1);

frame.closeButton = CreateFrame("Button", nil, frame.header);
frame.closeButton:SetWidth(12);
frame.closeButton:SetHeight(12);
frame.closeButton:SetPoint("RIGHT", -5, 0);
frame.closeButton:SetNormalTexture([[Interface\AddOns\Hitlist\img\iclose]]);
frame.closeButton:SetHighlightTexture([[Interface\AddOns\Hitlist\img\iclose]]);

frame.lockButton = CreateFrame("Button", nil, frame.header);
frame.lockButton:SetWidth(12);
frame.lockButton:SetHeight(12);
frame.lockButton:SetPoint("RIGHT", frame.closeButton, "LEFT", -5, 0);
frame.lockButton:SetNormalTexture([[Interface\AddOns\Hitlist\img\ilock]]);
frame.lockButton:SetHighlightTexture([[Interface\AddOns\Hitlist\img\ilock]]);

--- Show tooltip for list elements
local function ListTooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
	GameTooltip:SetText(L["UI_TARGETDISP_TARGETING_LOCKED"]);
	GameTooltip:Show();
end

--- Shows tooltip for secure buttons
local function SecureTooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
    if InCombatLockdown() then
        GameTooltip:SetText(L["UI_TARGETDISP_TT_TARGET"]);
    else
        GameTooltip:SetText(L["UI_NBL_TT_TARGET_WL"]);
    end
    GameTooltip:Show();
end

local function HideTooltip()
    GameTooltip:Hide();
end

frame.listElements = {};

-- Can't create on demand because of secure buttons, click action bugs if I do
for i = 1, MAX_ITEMS, 1 do
    local item = CreateFrame("Frame", nil, frame);
	item:SetHeight(ITEM_HEIGHT);
	item:SetBackdrop({bgFile = [[Interface\AddOns\Hitlist\img\bar]]});
    
    item:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, -ITEM_HEIGHT * (i-1));
	item:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0, -ITEM_HEIGHT * (i-1));

    item.targetName = item:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	item.targetName:SetPoint("LEFT", 10, 0);
    item.targetLevel = item:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
    item.targetLevel:SetPoint("LEFT", 110, 0);
    item.targetClass = item:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
    item.targetClass:SetPoint("LEFT", 140, 0);
    item.targetClass:SetTextColor(0.85,0.85,0.85,1);
    item.targetClass:SetFont("Fonts\\ARHei.TTF", 10);

    item.secureButton = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate");
    item.secureButton:SetAttribute("type1", "macro");
    item.secureButton:RegisterForClicks("AnyUp");
    item.secureButton:SetFrameStrata("MEDIUM");
    item.secureButton:SetFrameLevel(284);

    item.timer = CreateFrame("Frame", nil, item);
    item.timer:SetBackdrop({bgFile = [[Interface/Tooltips/UI-Tooltip-Background]]});
    item.timer:SetBackdropColor(0,1,0,1);
    item.timer:SetPoint("BOTTOMRIGHT", 0, 1);
    item.timer:SetWidth(10);
    item.timer:SetHeight(ITEM_HEIGHT-2);

    item:SetScript("OnEnter", ListTooltip);
    item:SetScript("OnLeave", HideTooltip);
    item.secureButton:SetScript("OnEnter", SecureTooltip);
    item.secureButton:SetScript("OnLeave", HideTooltip);

    item:Hide();
    item.secureButton:Hide();

    frame.listElements[i] = item;
end

frame.isCurrentlyLocked = false;

--- Set frame lock state
-- Hides frame by setting height and hiding header, can't actually hide frame because secure buttons.
-- @param locked Is the frame locked
-- @param ignoreAnchor If true then don't adjust anchor
function frame:SetLocked(locked, ignoreAnchor)
    if locked == self.isCurrentlyLocked then
        return;
    end
    self.isCurrentlyLocked = locked;

    if locked then
        self:RegisterForDrag(nil);
        self.closeButton:Hide();
        self.header:SetBackdropColor(0,0,0,0.35);
        self:SetHeight(1);
        self.header:Hide();
    else
        self:RegisterForDrag("LeftButton");
        self.closeButton:Show();
        self.header:SetBackdropColor(0,0,0,1);
        self:SetHeight(HEADER_HEIGHT);
        self.header:Show();
    end

    if not ignoreAnchor then
        local point, relTo, relPoint, x, y = self:GetPoint(1);
        local yadjust = 0;
        if point == "CENTER" or point == "LEFT" or point == "RIGHT" then
            yadjust = (HEADER_HEIGHT - 1) / 2;
        elseif point == "BOTTOM" or point == "BOTTOMRIGHT" or point == "BOTTOMLEFT" then
            yadjust = (HEADER_HEIGHT - 1);
        end
        if not locked then
            yadjust = -yadjust;
        end
        self:ClearAllPoints();
        self:SetPoint(point, relTo, relPoint, x, y + yadjust);
    end
end

--- Reset to default position
function frame:Reset() 
    self:ClearAllPoints();
    self:SetPoint("CENTER", DEFAULT_X_OFFSET, 0);
end