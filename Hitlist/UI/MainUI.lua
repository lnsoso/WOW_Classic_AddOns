local _addonName, _addon = ...;
local L = _addon:GetLocalization();
local LIST_ITEM_HEIGHT = 27;
local LIST_FRAME_WIDTH = 255;
local MAX_ITEMS = 14;
local MIN_ITEMS = 9;
local HEIGHT_NO_CONTENT = 71;
local DEFAULT_HEIGHT = MIN_ITEMS*LIST_ITEM_HEIGHT + HEIGHT_NO_CONTENT;
local playerName = GetUnitName("player");
local realmName = GetRealmName();

local frame = CreateFrame("Frame", "HLUI_MainUI", UIParent, "ButtonFrameTemplate");
frame:SetPoint("CENTER", 0, 0);
frame:SetFrameStrata("HIGH");
frame:SetWidth(LIST_FRAME_WIDTH);
frame:SetHeight(DEFAULT_HEIGHT);
frame:SetResizable(true);
frame:SetClampedToScreen(true);
frame:SetMaxResize(LIST_FRAME_WIDTH, MAX_ITEMS*LIST_ITEM_HEIGHT + HEIGHT_NO_CONTENT);
frame:SetMinResize(LIST_FRAME_WIDTH, MIN_ITEMS*LIST_ITEM_HEIGHT + HEIGHT_NO_CONTENT);
frame:SetMovable(true);
frame:EnableMouse(true);
frame.TitleText:SetText(_addonName);
frame.portrait:SetTexture([[Interface\AddOns\Hitlist\img\logoskull]]);
frame:Hide();

ButtonFrameTemplate_HideButtonBar(frame);

-- Add drag area
frame.dragBar = CreateFrame("Frame", nil, frame);
frame.dragBar:SetPoint("TOPLEFT");
frame.dragBar:SetPoint("BOTTOMRIGHT", frame.CloseButton, "TOPLEFT", 0, -40);
frame.dragBar:SetScript("OnMouseDown", function(self)
    self:GetParent():StartMoving();
end);
frame.dragBar:SetScript("OnMouseUp", function(self)
    self:GetParent():StopMovingOrSizing();
end);

-- Delete button for delete context menu
frame.deleteBtn = CreateFrame("Button", nil, frame);
frame.deleteBtn:SetSize(18, 18);
frame.deleteBtn:SetPoint("TOPRIGHT", -15, -35);
frame.deleteBtn:SetNormalTexture([[interface/buttons/ui-guildbutton-publicnote-up]]);
frame.deleteBtn:SetHighlightTexture([[interface/buttons/ui-guildbutton-publicnote-up]]);
frame.deleteBtn.menu = CreateFrame("Frame", nil, frame.deleteBtn, "UIDropDownMenuTemplate");

-- Add button for switching to add content
frame.addBtn = CreateFrame("Button", nil, frame);
frame.addBtn:SetSize(15, 15);
frame.addBtn:SetPoint("RIGHT", frame.deleteBtn, "LEFT", -10, 0);
frame.addBtn:SetNormalTexture([[Interface\AddOns\Hitlist\img\iplus]]);
frame.addBtn:SetHighlightTexture([[Interface\AddOns\Hitlist\img\iplus]]);

-- Nearby list show/unlock button
frame.nearbyListBtn = CreateFrame("Button", nil, frame);
frame.nearbyListBtn:SetSize(18, 18);
frame.nearbyListBtn:SetPoint("TOPLEFT", 70, -35);
frame.nearbyListBtn:SetNormalTexture([[interface/icons/ability_tracking.blp]]);
frame.nearbyListBtn:SetHighlightTexture([[interface/icons/ability_tracking.blp]]);

-- Settings button
frame.settingsBtn = CreateFrame("Button", nil, frame);
frame.settingsBtn:SetSize(18, 18);
frame.settingsBtn:SetPoint("LEFT", frame.nearbyListBtn, "RIGHT", 10, 0);
frame.settingsBtn:SetNormalTexture([[interface/scenarios/scenarioicon-interact.blp]]);
frame.settingsBtn:SetHighlightTexture([[interface/scenarios/scenarioicon-interact.blp]]);

-- Resize knob
frame.resizeBtn = CreateFrame("Button", nil, frame);
frame.resizeBtn:SetSize(64, 18);
frame.resizeBtn:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", -3, 1);
frame.resizeBtn:SetNormalTexture([[Interface\AddOns\Hitlist\img\grabber_s]]);
frame.resizeBtn:SetHighlightTexture([[Interface\AddOns\Hitlist\img\grabber]]);


----------------------------------------------------------------------------------------------------------------
-- Content frames
----------------------------------------------------------------------------------------------------------------

-- Content frame with scroll list of targets
frame.scrollFrame = CreateFrame("ScrollFrame", "HitlistListUIScroll", frame.Inset, "FauxScrollFrameTemplate");
frame.scrollFrame:SetPoint("TOPLEFT", 3, -3);
frame.scrollFrame:SetPoint("BOTTOMRIGHT", -3, 3);
frame.scrollFrame.ScrollBar:ClearAllPoints();
frame.scrollFrame.ScrollBar:SetPoint("TOPRIGHT", -1, -18);
frame.scrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", -1, 16);

frame.scrollFrame.ScrollBarTop = frame.scrollFrame:CreateTexture(nil, "BACKGROUND");
frame.scrollFrame.ScrollBarTop:SetPoint("TOPRIGHT", 6, 2);
frame.scrollFrame.ScrollBarTop:SetTexture ([[Interface\PaperDollInfoFrame\UI-Character-ScrollBar]]);
frame.scrollFrame.ScrollBarTop:SetSize(31, 256);
frame.scrollFrame.ScrollBarTop:SetTexCoord(0, 0.484375, 0, 1);

frame.scrollFrame.ScrollBarBottom = frame.scrollFrame:CreateTexture(nil, "BACKGROUND");
frame.scrollFrame.ScrollBarBottom:SetPoint("BOTTOMRIGHT", 6, -2);
frame.scrollFrame.ScrollBarBottom:SetTexture ([[Interface\PaperDollInfoFrame\UI-Character-ScrollBar]]);
frame.scrollFrame.ScrollBarBottom:SetSize(31, 106);
frame.scrollFrame.ScrollBarBottom:SetTexCoord(0.515625, 1, 0, 0.4140625);

frame.scrollFrame.ScrollBarMiddle = frame.scrollFrame:CreateTexture(nil, "BACKGROUND");
frame.scrollFrame.ScrollBarMiddle:SetPoint("BOTTOM", frame.scrollFrame.ScrollBarBottom, "TOP", 0, 0);
frame.scrollFrame.ScrollBarMiddle:SetPoint("TOP", frame.scrollFrame.ScrollBarTop, "BOTTOM", 0, 0);
frame.scrollFrame.ScrollBarMiddle:SetTexture ([[Interface\PaperDollInfoFrame\UI-Character-ScrollBar]]);
frame.scrollFrame.ScrollBarMiddle:SetSize(31, 60);
frame.scrollFrame.ScrollBarMiddle:SetTexCoord(0, 0.484375, 0.75, 1);

frame.scrollFrame:SetClipsChildren(true);

--- Make a basic content frame
-- @param name The object name
-- @param title The title to show
local function MakeSubFrame(name, title)
    local sframe = CreateFrame("Frame", name, frame.Inset);
    sframe:SetPoint("TOPLEFT", 0, 0);
    sframe:SetPoint("BOTTOMRIGHT", 0, 0);
    sframe:Hide();
    sframe.title = sframe:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2");
    sframe.title:SetPoint("TOPLEFT", 20, -15);
    sframe.title:SetPoint("TOPRIGHT", -20, -15);
    sframe.title:SetText(title);
    return sframe;
end

--- Make an editbox
-- @param parent The parent frame
-- @param maxLen Maxmimum input length
-- @param height (optional)
-- @param isMultiline (optional)
local function MakeEditBox(parent, maxLen, height, isMultiline)
    local edit = CreateFrame("EditBox", nil, parent);
    edit:SetMaxLetters(maxLen);
    edit:SetAutoFocus(false);
    if height then
        edit:SetHeight(height);
    end
    edit:SetFont("Fonts\\ARHei.TTF", 11);
    edit:SetJustifyH("LEFT");
    edit:SetJustifyV("CENTER");
    edit:SetTextInsets(7,7,7,7);
    edit:SetBackdrop({
        bgFile = [[Interface\Buttons\WHITE8x8]],
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        edgeSize = 14,
        insets = {left = 3, right = 3, top = 3, bottom = 3},
    });
    edit:SetBackdropColor(0, 0, 0);
    edit:SetBackdropBorderColor(0.3, 0.3, 0.3);
    if isMultiline then
        edit:SetSpacing(3);
        edit:SetMultiLine(true);
    end
    edit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
    edit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
    edit:SetScript("OnEditFocusLost", function(self) EditBox_ClearHighlight(self); end);

    return edit;
end

-- Content frame with add form
do
    local addFrame = MakeSubFrame("HitlistListUIAdd", L["UI_ADDFORM_TITLE"]);
    local nameLabel = addFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    nameLabel:SetPoint("TOPLEFT", addFrame.title, "BOTTOMLEFT", 0, -16);
    nameLabel:SetPoint("TOPRIGHT", addFrame.title, "BOTTOMRIGHT", 0, -16);
    nameLabel:SetText(L["UI_ADDFORM_NAME"]);
    nameLabel:SetJustifyH("LEFT");
    addFrame.nameEdit = MakeEditBox(addFrame, 12, 27, false);
    addFrame.nameEdit:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 0, -4);
    addFrame.nameEdit:SetPoint("TOPRIGHT", nameLabel, "BOTTOMRIGHT", 0, -4);
    
    local reasonLabel = addFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    reasonLabel:SetPoint("TOPLEFT", addFrame.nameEdit, "BOTTOMLEFT", 0, -10);
    reasonLabel:SetPoint("TOPRIGHT", addFrame.nameEdit, "BOTTOMRIGHT", 0, -10);
    reasonLabel:SetText(L["UI_ADDFORM_REASON"]);
    reasonLabel:SetJustifyH("LEFT");
    addFrame.reasonEdit = MakeEditBox(addFrame, 99, nil, true);
    addFrame.reasonEdit:SetPoint("TOPLEFT", reasonLabel, "BOTTOMLEFT", 0, -4);
    addFrame.reasonEdit:SetPoint("BOTTOMRIGHT", reasonLabel, "BOTTOMRIGHT", 0, -95);
    
    addFrame.okbutton = CreateFrame("Button", nil, addFrame, "OptionsButtonTemplate");
    addFrame.okbutton:SetText(L["UI_ADDFORM_ADD_BUTTON"]);
    addFrame.okbutton:SetPoint("TOPLEFT", addFrame.reasonEdit, "BOTTOMLEFT", 0, -10);
    addFrame.okbutton:SetWidth(125);
    addFrame.backbutton = CreateFrame("Button", nil, addFrame, "OptionsButtonTemplate");
    addFrame.backbutton:SetText(L["UI_BACK"]);
    addFrame.backbutton:SetPoint("TOPRIGHT", addFrame.reasonEdit, "BOTTOMRIGHT", 0, -10);
    addFrame.backbutton:SetWidth(75);

    frame.addFrame = addFrame;
end

frame.addFrame.nameEdit:SetScript("OnTabPressed", function(self) 
    self:ClearFocus();
    frame.addFrame.reasonEdit:SetFocus(); 
end);

frame.addFrame.reasonEdit:SetScript("OnTabPressed", function(self) 
    self:ClearFocus();
    frame.addFrame.nameEdit:SetFocus(); 
end);

-- Content frame with delete all form
do
    local deleteAllFrame = MakeSubFrame("HitlistListUIRmAll", L["UI_RMALL_TITLE"]);
    local desc = deleteAllFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    desc:SetPoint("TOPLEFT", deleteAllFrame.title, "BOTTOMLEFT", 0, -16);
    desc:SetPoint("TOPRIGHT", deleteAllFrame.title, "BOTTOMRIGHT", 0, -16);
    desc:SetText(L["UI_RMALL_DESC"]);
    desc:SetJustifyH("LEFT");
    desc:SetJustifyV("CENTER");
    deleteAllFrame.okbutton = CreateFrame("Button", nil, deleteAllFrame, "OptionsButtonTemplate");
    deleteAllFrame.okbutton:SetText(L["UI_RMALL_REMOVE"]);
    deleteAllFrame.okbutton:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -10);
    deleteAllFrame.okbutton:SetWidth(125);
    deleteAllFrame.backbutton = CreateFrame("Button", nil, deleteAllFrame, "OptionsButtonTemplate");
    deleteAllFrame.backbutton:SetText(L["UI_CANCEL"]);
    deleteAllFrame.backbutton:SetPoint("TOPRIGHT", desc, "BOTTOMRIGHT", 0, -10);
    deleteAllFrame.backbutton:SetWidth(75);

    frame.deleteAllFrame = deleteAllFrame;
end

-- Content frame with delete other form
do
    local deleteOtherFrame = MakeSubFrame("HitlistListUIRmOther", L["UI_RMOTHER_TITLE"]);
    local desc = deleteOtherFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    desc:SetPoint("TOPLEFT", deleteOtherFrame.title, "BOTTOMLEFT", 0, -16);
    desc:SetPoint("TOPRIGHT", deleteOtherFrame.title, "BOTTOMRIGHT", 0, -16);
    desc:SetText(L["UI_RMOTHER_DESC"]);
    desc:SetJustifyH("LEFT");
    desc:SetJustifyV("CENTER");
    deleteOtherFrame.okbutton = CreateFrame("Button", nil, deleteOtherFrame, "OptionsButtonTemplate");
    deleteOtherFrame.okbutton:SetText(L["UI_RMFORM_REMOVE"]);
    deleteOtherFrame.okbutton:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -10);
    deleteOtherFrame.okbutton:SetWidth(125);
    deleteOtherFrame.backbutton = CreateFrame("Button", nil, deleteOtherFrame, "OptionsButtonTemplate");
    deleteOtherFrame.backbutton:SetText(L["UI_CANCEL"]);
    deleteOtherFrame.backbutton:SetPoint("TOPRIGHT", desc, "BOTTOMRIGHT", 0, -10);
    deleteOtherFrame.backbutton:SetWidth(75);

    frame.deleteOtherFrame = deleteOtherFrame;
end

-- Content frame with delete form
do
    local deleteFrame = MakeSubFrame("HitlistListUIRm", L["UI_RMFORM_TITLE"]);
    local desc = deleteFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    desc:SetPoint("TOPLEFT", deleteFrame.title, "BOTTOMLEFT", 0, -16);
    desc:SetPoint("TOPRIGHT", deleteFrame.title, "BOTTOMRIGHT", 0, -16);
    desc:SetText(L["UI_RMFORM_DESC"]);
    desc:SetJustifyH("LEFT");
    desc:SetJustifyV("CENTER");
    local editRow = CreateFrame("Frame", nil, deleteFrame);
    editRow:SetHeight(27);
    editRow:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -10);
    editRow:SetPoint("TOPRIGHT", desc, "BOTTOMRIGHT", 0, -10);
    local nameLabel = editRow:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    nameLabel:SetPoint("LEFT", editRow, 0, 0);
    nameLabel:SetText(L["UI_ADDFORM_NAME"]);
    deleteFrame.nameEdit = MakeEditBox(deleteFrame, 12);
    deleteFrame.nameEdit:SetPoint("TOPLEFT", editRow, 50, 0);
    deleteFrame.nameEdit:SetPoint("BOTTOMRIGHT", editRow, 0, 0);
    deleteFrame.okbutton = CreateFrame("Button", nil, deleteFrame, "OptionsButtonTemplate");
    deleteFrame.okbutton:SetText(L["UI_RMFORM_REMOVE"]);
    deleteFrame.okbutton:SetPoint("TOPLEFT", editRow, "BOTTOMLEFT", 0, -10);
    deleteFrame.okbutton:SetWidth(125);
    deleteFrame.backbutton = CreateFrame("Button", nil, deleteFrame, "OptionsButtonTemplate");
    deleteFrame.backbutton:SetText(L["UI_CANCEL"]);
    deleteFrame.backbutton:SetPoint("TOPRIGHT", editRow, "BOTTOMRIGHT", 0, -10);
    deleteFrame.backbutton:SetWidth(75);

    frame.deleteFrame = deleteFrame;
end


----------------------------------------------------------------------------------------------------------------
-- List items for scroll frame
----------------------------------------------------------------------------------------------------------------

frame.scrollFrame.items = {};

-- Create a list element
for i = 1, MAX_ITEMS, 1 do	
	local item = CreateFrame("Frame", nil, frame.scrollFrame);
	item:SetHeight(LIST_ITEM_HEIGHT);
	item:SetPoint("TOPLEFT", 0, -LIST_ITEM_HEIGHT * (i-1));
    item:SetPoint("TOPRIGHT", -23, -LIST_ITEM_HEIGHT * (i-1));
    item:SetBackdrop({bgFile = [[Interface\AddOns\Hitlist\img\bar]]});
    item:SetBackdropColor(0.2,0.2,0.2,0.8);
	
	item.targetName = item:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	item.targetName:SetPoint("LEFT", 10, 0);
	
	item.info = CreateFrame("Button", nil, item);
	item.info.reason = "";
	item.info.addtime = 0;
	item.info:SetWidth(14);
	item.info:SetHeight(14);
	item.info:SetPoint("LEFT", item, "LEFT", 115, 0);
	item.info:SetNormalTexture([[Interface\AddOns\Hitlist\img\iinfo]]);
	item.info:SetHighlightTexture([[Interface\AddOns\Hitlist\img\iinfo]]);
	
	item.by = item:CreateFontString(nil, "OVERLAY", "GameFontDisableTiny");
	item.by:SetPoint("LEFT", item.info, "RIGHT", 10, 0);
	
	item.delb = CreateFrame("Button", nil, item);
	item.delb:SetWidth(10);
	item.delb:SetHeight(10);
	item.delb:SetPoint("RIGHT", item, "RIGHT", -10, 0);
	item.delb:SetNormalTexture([[Interface\AddOns\Hitlist\img\iclose]]);
	item.delb:SetHighlightTexture([[Interface\AddOns\Hitlist\img\iclose]]);
	
	item.delb:SetScript("OnClick", function(self)
		_addon:RemoveFromList(self:GetParent().targetName:GetText(), playerName);
	end)
	
	item.info:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
		GameTooltip:SetText(self.reason, 1, 1, 0.8, 1, true);
		GameTooltip:AddLine(L["UI_LIST_ADDED"]:format(_addon:HumanTimeDiff(time() - self.addtime)), 0.7, 0.7, 0.5);
		GameTooltip:Show();
    end)
    
	item.info:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	
	frame.scrollFrame.items[i] = item;
end


----------------------------------------------------------------------------------------------------------------
-- Frame functions
----------------------------------------------------------------------------------------------------------------

--- Reset position and size
function frame:Reset()
    self:ClearAllPoints();
    self:SetPoint("CENTER", 0, 0);
    self:SetHeight(DEFAULT_HEIGHT);
end;

--- Switch displayed content
-- @param name Which frame to show, "LIST", "ADD", "RM" , "RMALL", "RMOTHER", defaults to "LIST"
function frame:ShowContent(name)
    if name == "ADD" then
        self.deleteFrame:Hide();
        self.scrollFrame:Hide();
        self.deleteAllFrame:Hide();
        self.deleteOtherFrame:Hide();
        self.addFrame:Show();
        return;
    end

    if name == "RM" then
        self.scrollFrame:Hide();
        self.deleteAllFrame:Hide();
        self.deleteOtherFrame:Hide();
        self.addFrame:Hide();
        self.deleteFrame:Show();
        return;
    end

    if name == "RMALL" then
        self.deleteFrame:Hide();
        self.scrollFrame:Hide();
        self.deleteOtherFrame:Hide();
        self.addFrame:Hide();
        self.deleteAllFrame:Show();
        return;
    end

    if name == "RMOTHER" then
        self.deleteFrame:Hide();
        self.scrollFrame:Hide();
        self.deleteAllFrame:Hide();
        self.addFrame:Hide();
        self.deleteOtherFrame:Show();
        return;
    end

    self.deleteFrame:Hide();
    self.deleteAllFrame:Hide();
    self.deleteOtherFrame:Hide();
    self.addFrame:Hide();
    self.scrollFrame:Show();
end


----------------------------------------------------------------------------------------------------------------
-- Button tooltips
----------------------------------------------------------------------------------------------------------------

local function ShowButtonToolTip(owner, text)
	GameTooltip:SetOwner(owner, "ANCHOR_TOPLEFT");
	GameTooltip:SetText(text);
	GameTooltip:Show();
end

local function HideTooltip()
    GameTooltip:Hide();
end

frame.nearbyListBtn:SetScript("OnEnter", function(self) 
    if Hitlist_settings.nearbyListLocked then
        if not InCombatLockdown() then
            ShowButtonToolTip(self, L["UI_LIST_BUTTON_NEARBY_UNLOCK"]);
        else
            ShowButtonToolTip(self, L["UI_LIST_BUTTON_NEARBY_UNLOCK_COMBAT"]);
        end
        return;
    end
    ShowButtonToolTip(self, L["UI_LIST_BUTTON_NEARBY_SHOW"]); 
end);
frame.nearbyListBtn:SetScript("OnLeave", HideTooltip);
frame.settingsBtn:SetScript("OnEnter", function(self) ShowButtonToolTip(self, L["UI_LIST_BUTTON_SETTINGS"]); end);
frame.settingsBtn:SetScript("OnLeave", HideTooltip);
frame.addBtn:SetScript("OnEnter", function(self) ShowButtonToolTip(self, L["UI_LIST_BUTTON_ADD"]); end);
frame.addBtn:SetScript("OnLeave", HideTooltip);
frame.deleteBtn:SetScript("OnEnter", function(self) ShowButtonToolTip(self, L["UI_LIST_BUTTON_DELETE"]); end);
frame.deleteBtn:SetScript("OnLeave", HideTooltip);


----------------------------------------------------------------------------------------------------------------
-- Delete context menu
----------------------------------------------------------------------------------------------------------------

UIDropDownMenu_Initialize(frame.deleteBtn.menu, function(self, level, menuList) 
    local info = UIDropDownMenu_CreateInfo();
    info.menuList = false;
    info.padding = 0;
    info.isNotRadio = true;
    info.notCheckable = true;
    info.text = L["UI_LIST_DELMEN_TITLE"];
    info.isTitle = true;
    UIDropDownMenu_AddButton(info);

    info.isTitle = false;
    info.disabled = false;
    info.func = function(self, arg1, arg2, checked)
        if arg1 == 1 then
            frame:ShowContent("RMALL");
            return;
        end
    
        if arg1 == 2 then
            frame:ShowContent("RMOTHER");
            return;
        end
    
        if arg1 == 3 then
            frame:ShowContent("RM");
            return;
        end
    end;

    info.text = L["UI_LIST_DELMEN_DELALL"];
    info.arg1 = 1;
    UIDropDownMenu_AddButton(info);

    info.text = L["UI_LIST_DELMEN_DELALLREC"];
    info.arg1 = 2;
    UIDropDownMenu_AddButton(info);

    info.text = L["UI_LIST_DELMEN_DELSPECIFIC"];
    info.arg1 = 3;
    UIDropDownMenu_AddButton(info);
end, "MENU");