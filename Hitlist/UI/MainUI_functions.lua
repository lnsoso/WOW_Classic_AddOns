local _addonName, _addon = ...;
local L = _addon:GetLocalization();
local playerName = GetUnitName("player");
local realmName = GetRealmName();
local listItemHeight = HLUI_MainUI.scrollFrame.items[1]:GetHeight();
local listElementCount = #HLUI_MainUI.scrollFrame.items;
local maxElementCount = listElementCount;
local HEIGHT_NO_CONTENT = 71;

local sortedEntries = {};
local entryCount = 0;

----------------------------------------------------------------------------------------------------------------
-- Top bar button actions
----------------------------------------------------------------------------------------------------------------

-- Show dropdown when delete context button is clicked
HLUI_MainUI.deleteBtn:SetScript("OnClick", function(self) 
    ToggleDropDownMenu(1, nil, HLUI_MainUI.deleteBtn.menu, HLUI_MainUI.deleteBtn, 0, 0);
end);

--- Open nearby list
HLUI_MainUI.nearbyListBtn:SetScript("OnClick", function(self) 
    if not Hitlist_settings.nearbyListLocked or not InCombatLockdown() then
        _addon:NearbyList_Show();
    end
end);

--- Open settings menu
HLUI_MainUI.settingsBtn:SetScript("OnClick", function(self) 
    InterfaceOptionsFrame_OpenToCategory(_addonName);
    InterfaceOptionsFrame_OpenToCategory(_addonName);
end);

--- Open add subframe when plus is clicked
HLUI_MainUI.addBtn:SetScript("OnClick", function(self) 
    if HLUI_MainUI.addFrame:IsShown() then
        return;
    end
    _addon:MainUI_ShowAddForm();
end);


----------------------------------------------------------------------------------------------------------------
-- Content frame button actions
----------------------------------------------------------------------------------------------------------------

-- Delete all frame buttons
HLUI_MainUI.deleteAllFrame.okbutton:SetScript("OnClick", function(self) 
    _addon:ClearList();
    HLUI_MainUI:ShowContent("LIST");
end);
HLUI_MainUI.deleteAllFrame.backbutton:SetScript("OnClick", function(self) 
    HLUI_MainUI:ShowContent("LIST");
end);

-- Delete frame buttons
HLUI_MainUI.deleteFrame.okbutton:SetScript("OnClick", function(self)
    local name = HLUI_MainUI.deleteFrame.nameEdit:GetText();
    if name:len() < 3 then
        _addon:PrintError(L["UI_RMFORM_ERR_MISSING"]);
        return;
    end
    _addon:ClearForeignData(name);
    HLUI_MainUI:ShowContent("LIST");
end);
HLUI_MainUI.deleteFrame.backbutton:SetScript("OnClick", function(self) 
    HLUI_MainUI:ShowContent("LIST");
end);

-- Delete other frame buttons
HLUI_MainUI.deleteOtherFrame.okbutton:SetScript("OnClick", function(self) 
    _addon:ClearForeignData();
    HLUI_MainUI:ShowContent("LIST");
end);
HLUI_MainUI.deleteOtherFrame.backbutton:SetScript("OnClick", function(self) 
    HLUI_MainUI:ShowContent("LIST");
end);

-- Add frame buttons
HLUI_MainUI.addFrame.okbutton:SetScript ("OnClick", function (self)
	local nresult, name = _addon:FormatPlayerName(HLUI_MainUI.addFrame.nameEdit:GetText());
    local rresult, reason = _addon:FormatReason(HLUI_MainUI.addFrame.reasonEdit:GetText());

    if nresult == 2 then
        _addon:PrintError(L["UI_ADDFORM_ERR_NAME_INVALID"]);
		return;
    end

	if nresult ~= 0 then
		_addon:PrintError(L["UI_ADDFORM_ERR_NAME"]);
		return;
	end

	if rresult ~= 0 then
		_addon:PrintError(L["UI_ADDFORM_ERR_REASON"]);
		return;
	end
	
	_addon:AddToList(name, reason, playerName);
	HLUI_MainUI:ShowContent("LIST");
end);
HLUI_MainUI.addFrame.backbutton:SetScript ("OnClick", function (self)
	HLUI_MainUI:ShowContent("LIST");
end);


----------------------------------------------------------------------------------------------------------------
-- Control functions
----------------------------------------------------------------------------------------------------------------

--- Handle combat start for UI
function _addon:MainUI_CombatStart()
    if Hitlist_settings.nearbyListLocked then
        HLUI_MainUI.nearbyListBtn:GetNormalTexture():SetDesaturated(true);
        HLUI_MainUI.nearbyListBtn:SetHighlightTexture(nil);
    end
end

--- Handle combat end for UI
function _addon:MainUI_CombatEnd()
    if Hitlist_settings.nearbyListLocked then
        HLUI_MainUI.nearbyListBtn:GetNormalTexture():SetDesaturated(false);
        HLUI_MainUI.nearbyListBtn:SetHighlightTexture([[interface/icons/ability_tracking.blp]]);
    end
end

--- Show the add form
-- @param name A name to prefill (optional)
-- @param reason A reason to prefill (optional)
function _addon:MainUI_ShowAddForm(name, reason)
    if name == nil and HLUI_MainUI:IsShown() and HLUI_MainUI.addFrame:IsShown() then 
        return; 
    end
    
	local focus = 1;
	HLUI_MainUI.addFrame.reasonEdit:SetText("");
	HLUI_MainUI.addFrame.nameEdit:SetText("");
	if name ~= nil then
		HLUI_MainUI.addFrame.nameEdit:SetText(name);
		HLUI_MainUI.addFrame.nameEdit:SetCursorPosition(0);
		focus = 2;
	end
	if reason ~= nil then
		HLUI_MainUI.addFrame.reasonEdit:SetText(reason);
		HLUI_MainUI.addFrame.reasonEdit:SetCursorPosition(0);
		focus = 0;
	end
    
    HLUI_MainUI:Show();
    HLUI_MainUI:ShowContent("ADD");

	if focus == 1 then
		HLUI_MainUI.addFrame.nameEdit:SetFocus();
	elseif focus == 2 then
		HLUI_MainUI.addFrame.reasonEdit:SetFocus();
    end
end

--- Update scroll frame
local function UpdateScrollFrame()
    local scrollHeight = 0;
	if entryCount > 0 then
        scrollHeight = (entryCount - listElementCount) * listItemHeight;
        if scrollHeight < 0 then
            scrollHeight = 0;
        end
    end

    local maxRange = (entryCount - listElementCount) * listItemHeight;
    if maxRange < 0 then
        maxRange = 0;
    end

    HLUI_MainUI.scrollFrame.ScrollBar:SetMinMaxValues(0, maxRange);
    HLUI_MainUI.scrollFrame.ScrollBar:SetValueStep(listItemHeight);
    HLUI_MainUI.scrollFrame.ScrollBar:SetStepsPerPage(listElementCount-1);

    if HLUI_MainUI.scrollFrame.ScrollBar:GetValue() == 0 then
        HLUI_MainUI.scrollFrame.ScrollBar.ScrollUpButton:Disable();
    else
        HLUI_MainUI.scrollFrame.ScrollBar.ScrollUpButton:Enable();
    end

    if (HLUI_MainUI.scrollFrame.ScrollBar:GetValue() - scrollHeight) == 0 then
        HLUI_MainUI.scrollFrame.ScrollBar.ScrollDownButton:Disable();
    else
        HLUI_MainUI.scrollFrame.ScrollBar.ScrollDownButton:Enable();
    end	

    for line = 1, listElementCount, 1 do
      local offsetLine = line + (HLUI_MainUI.scrollFrame.offset or 0);
      local item = HLUI_MainUI.scrollFrame.items[line];
      if offsetLine <= entryCount then
		curtar = Hitlist_data[realmName].entries[sortedEntries[offsetLine]];
		item.targetName:SetText(sortedEntries[offsetLine]);
		item.info.reason = curtar.reason;
		item.info.addtime = curtar.added;
		if Hitlist_data[realmName].localNames[curtar.by] then
			item.by:SetText("");
			item.delb:Show();
		else
			item.by:SetText(curtar.by);
			item.delb:Hide();
        end
        item:Show();
      else
        item:Hide();
      end
    end
end

--- Recalculates height and shown item count
-- @param ignoreHeight If true will not resize and reanchor UI
local function RecalculateSize(ignoreHeight)
    local oldHeight = HLUI_MainUI:GetHeight();
    local showCount = math.floor((oldHeight - HEIGHT_NO_CONTENT + (listItemHeight/2 + 2)) / listItemHeight);

    if ignoreHeight ~= true then
        local newHeight = showCount * listItemHeight + HEIGHT_NO_CONTENT;

        HLUI_MainUI:SetHeight(newHeight);

        local point, relTo, relPoint, x, y = HLUI_MainUI:GetPoint(1);
        local yadjust = 0;

        if point == "CENTER" or point == "LEFT" or point == "RIGHT" then
            yadjust = (oldHeight - newHeight) / 2;
        elseif point == "BOTTOM" or point == "BOTTOMRIGHT" or point == "BOTTOMLEFT" then
            yadjust = oldHeight - newHeight;
        end

        HLUI_MainUI:ClearAllPoints();
        HLUI_MainUI:SetPoint(point, relTo, relPoint, x, y + yadjust);
    end

    for i = 1, maxElementCount, 1 do
        if i > showCount then
            HLUI_MainUI.scrollFrame.items[i]:Hide();
        end
    end

    listElementCount = showCount;
    UpdateScrollFrame();
end

--- Fill list from SV data
function _addon:MainUI_UpdateList()
	entryCount = 0;
	wipe(sortedEntries);
	for k in pairs(Hitlist_data[realmName].entries) do 
		table.insert(sortedEntries, k);
		entryCount = entryCount + 1;
	end
    table.sort(sortedEntries);
    UpdateScrollFrame();
end

--- Open the main list frame
function _addon:MainUI_OpenList()
    HLUI_MainUI:Show();
    HLUI_MainUI:ShowContent("LIST");
    RecalculateSize(true);
    UpdateScrollFrame();
end


----------------------------------------------------------------------------------------------------------------
-- Resize behaviour
----------------------------------------------------------------------------------------------------------------

-- Trigger update on scroll action
HLUI_MainUI.scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, listItemHeight, UpdateScrollFrame);
end);

HLUI_MainUI.resizeBtn:SetScript("OnMouseDown", function(self, button) 
    HLUI_MainUI:StartSizing("BOTTOMRIGHT"); 
end);

-- Resize snaps to full list items shown, updates list accordingly
HLUI_MainUI.resizeBtn:SetScript("OnMouseUp", function(self, button) 
    HLUI_MainUI:StopMovingOrSizing(); 
    RecalculateSize();
end);