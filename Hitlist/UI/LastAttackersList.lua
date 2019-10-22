local _, _addon = ...;
local L = _addon:GetLocalization();
local DEFAULT_X_OFFSET = 275;
local TEMPLATE_BASE_HEIGHT = 34;
local TEMPLATE_HEAD_HEIGHT = 26;
local LIST_ITEM_HEIGHT = 33;
local LIST_ITEM_HEIGHT_SINGLE = 50;
local MAX_ITEMS = 5;

local frame = CreateFrame("Frame", "HLUI_LastAttackers", UIParent, "UIPanelDialogTemplate");

frame:SetPoint("CENTER", DEFAULT_X_OFFSET, 0);
frame:SetFrameStrata("DIALOG");
frame:SetWidth(160);
frame:SetHeight(LIST_ITEM_HEIGHT * MAX_ITEMS + TEMPLATE_BASE_HEIGHT);
frame:SetClampedToScreen(true);
frame:SetMovable(true);
frame:EnableMouse(true);
frame:RegisterForDrag("LeftButton");
frame:SetScript("OnDragStart", frame.StartMoving);
frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
frame.Title:SetText(L["UI_KILLERLIST_TITLE"]);
frame.headTexture = frame:CreateTexture(nil, "ARTWORK");
frame.headTexture:SetPoint("BOTTOM", frame, "TOP", 0, -5);
frame.headTexture:SetTexture ([[Interface\AddOns\Hitlist\img\latop]]);
frame.headTexture:SetSize(256, 64);
frame:Hide();

frame.listItems = {};

for i = 1, MAX_ITEMS, 1 do
    local item = CreateFrame("Frame", nil, frame);

    item:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, (-TEMPLATE_HEAD_HEIGHT - (i-1) * LIST_ITEM_HEIGHT));
    item:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -6, (-TEMPLATE_HEAD_HEIGHT - (i-1) * LIST_ITEM_HEIGHT));
    item:SetHeight(LIST_ITEM_HEIGHT);
    item:SetBackdrop({bgFile = [[Interface\AddOns\Hitlist\img\bar]]});
    item:SetBackdropColor(0.2,0.2,0.2,0.8);
    
    item.targetName = item:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	item.targetName:SetPoint("LEFT", 15, 0);

	item.addButton = CreateFrame("Button", nil, item);
	item.addButton:SetWidth(16);
	item.addButton:SetHeight(16);
	item.addButton:SetPoint("RIGHT", item, "RIGHT", -15, 0);
	item.addButton:SetNormalTexture([[Interface\AddOns\Hitlist\img\iplus]]);
	item.addButton:SetHighlightTexture([[Interface\AddOns\Hitlist\img\iplus]]);
	item.addButton:SetScript ("OnClick", function (self)
		_addon:MainUI_ShowAddForm(self:GetParent().targetName:GetText());
    end)
    
    frame.listItems[i] = item;
end


--- Reset frame to default position
function frame:Reset()
    self:ClearAllPoints();
    self:SetPoint("CENTER", DEFAULT_X_OFFSET, 0);
end

--- Show the last attacker list
-- @param nameArray Array containing names
function frame:ShowList(nameArray)
    local lastElementPos = 0;

	for k, name in ipairs(nameArray) do
		self.listItems[k].targetName:SetText(name);
        self.listItems[k]:Show();
        lastElementPos = lastElementPos + 1;
        if lastElementPos == MAX_ITEMS then
            break;
        end
    end

    for i = lastElementPos + 1, MAX_ITEMS, 1 do
        self.listItems[i]:Hide();
    end

    if lastElementPos == 1 then
        self:SetHeight(LIST_ITEM_HEIGHT_SINGLE + TEMPLATE_BASE_HEIGHT);
        self.listItems[1]:SetHeight(LIST_ITEM_HEIGHT_SINGLE);
    else
        self:SetHeight(lastElementPos * LIST_ITEM_HEIGHT + TEMPLATE_BASE_HEIGHT);
        self.listItems[1]:SetHeight(LIST_ITEM_HEIGHT);
    end

	self:Show();
end