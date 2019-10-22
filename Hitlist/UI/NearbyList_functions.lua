local _addonName, _addon = ...;
local L = _addon:GetLocalization();
local MAX_INACTIVE_TIME = 25;
local TEMP_WHITELIST_DURATION = 600;

local CLASS_COLORS = {
    ["DRUID"] = {1.00, 0.49, 0.04},
    ["HUNTER"] = {0.67, 0.83, 0.45},
    ["MAGE"] = {0.25, 0.78, 0.92},
    ["PALADIN"] = {0.96, 0.55, 0.73},
    ["PRIEST"] = {1.00, 1.00, 1.00},
    ["ROGUE"] = {1.00, 0.96, 0.41},
    ["SHAMAN"] = {0.00, 0.44, 0.87},
    ["WARLOCK"] = {0.53, 0.53, 0.93},
    ["WARRIOR"] = {0.78, 0.61, 0.43},
    ["UNKNOWN"] = {0.66, 0.66, 0.66},
}

local realmName = GetRealmName();
local itemHeight = HLUI_NearbyList.listElements[1]:GetHeight();
local maxItems = #HLUI_NearbyList.listElements;
local trackedNames = {};
local trackedData = {};
local tempWhitelist = {};
local timeSinceLastUpdate = 0;

--- Do all secure updates
local function UpdateSecure()
    _addon:PrintDebug("NL update secure");
    for i = #trackedData+1, maxItems, 1 do
        HLUI_NearbyList.listElements[i]:Hide();
    end

    local macrotext;
    for _, v in pairs(HLUI_NearbyList.listElements) do
        if v:IsShown() then
            macrotext = ("/target %s"):format(v.targetName:GetText());
            v.secureButton:SetAttribute("macrotext1", macrotext);
            if not v.secureButton:IsShown() then
                v.secureButton:SetParent(v);
                v.secureButton:SetAllPoints(v);
                v.secureButton:Show();
            end
        elseif v.secureButton:IsShown() then
            v.secureButton:ClearAllPoints();
            v.secureButton:SetParent(UIParent);
            v.secureButton:Hide();
        end
    end
end

--- Fill text and color for item from trackedData entry data
-- @param item The list frame item to fill
-- @param class The uppercase unlocalized class
-- @param name The name to show
-- @param level The level number
-- @param timeActive The last activity time for the visual timer
local function FillItemData(item, class, name, level, timeActive)
    if level == 0 then
        level = "??";
    elseif level < 60 then 
        level = level .. "+"; 
    end

    item:SetBackdropColor(CLASS_COLORS[class][1], CLASS_COLORS[class][2], CLASS_COLORS[class][3], 1.0);
    item.targetName:SetText(name);
    item.targetLevel:SetText(level);
    item.targetClass:SetText(LOCALIZED_CLASS_NAMES_MALE[class]);
    item.timer:SetHeight( (itemHeight - 2) * (1 - ((time() - timeActive) / MAX_INACTIVE_TIME)) );
end

--- Update UI list with trackedData entries
local function RefreshList()
    _addon:PrintDebug("NL refresh");

    local item;
    for k, v in ipairs(trackedData) do
        item = HLUI_NearbyList.listElements[k];
        FillItemData(item, v.c, v.n, v.l, v.t);
        if not item:IsShown() then 
            item:Show(); 
        end
    end

    if not InCombatLockdown() then 
        UpdateSecure(); 
    end
end

--- Update single list item at position
local function RefreshSingle(pos)
    _addon:PrintDebug("NL refresh single " .. pos);
    local item = HLUI_NearbyList.listElements[pos];
    FillItemData(item, trackedData[pos].c, trackedData[pos].n, trackedData[pos].l, trackedData[pos].t);
    
    if not item:IsShown() then 
        item:Show();
    end

    if not InCombatLockdown() then  
        item.secureButton:SetAttribute("macrotext1", "/target " .. item.targetName:GetText());
        if not item.secureButton:IsShown() then
            item.secureButton:SetParent(item);
            item.secureButton:SetAllPoints(item);
            item.secureButton:Show();
        end
    end
end

--- Update timers, remove inactive targets from list and refresh it if needed out of combat
local function UpdateList(self, diff)
    timeSinceLastUpdate = timeSinceLastUpdate + diff;
    if timeSinceLastUpdate < 1 then 
        return; 
    end
    timeSinceLastUpdate = 0;

    local currentTime = time();

    for k, v in ipairs(trackedData) do
        local dtq = 1 - ((currentTime - v.t) / MAX_INACTIVE_TIME);
        if dtq > 0 then
            HLUI_NearbyList.listElements[k].timer:SetHeight((itemHeight - 2) * dtq);
        else
            HLUI_NearbyList.listElements[k].timer:SetHeight(1);
        end
    end

    if not InCombatLockdown() then 
        local oldLen = #trackedData;
        local delCount = 0;

        for i = 1, oldLen, 1 do
            if currentTime - trackedData[i].t > MAX_INACTIVE_TIME then
                _addon:PrintDebug("NL cleaning " .. trackedData[i].n);
                trackedNames[trackedData[i].n] = nil;
                trackedData[i] = nil;
                delCount = delCount + 1;
            elseif delCount > 0 then
                trackedData[i-delCount] = trackedData[i];
                trackedData[i] = nil;
                trackedNames[trackedData[i-delCount].n] = i-delCount;
            end
        end

        if delCount > 0 then 
            RefreshList();
        end

        if delCount == oldLen then 
            _addon:PrintDebug("NL stop update");
            HLUI_NearbyList:SetScript("OnUpdate", nil);
        end
    end
end

--- Button action for secure buttons
-- @param self The secure button object
-- @param button The pressed mouse button
local function SecureButtonAction(self, button)
    if button ~= "RightButton" or InCombatLockdown() then 
        return;
    end

    local name = self:GetParent().targetName:GetText();
    local pos = trackedNames[name];

    if pos ~= nil then
        if IsShiftKeyDown() then
            Hitlist_data[realmName].nearbyWhitelist[name] = true;
        else
            tempWhitelist[name] = time();
        end

        table.remove(trackedData, pos);
        trackedNames[name] = nil;

        for k,v in pairs(trackedNames) do
            if v > pos then
                trackedNames[k] = v - 1;
            end
        end

        RefreshList();
    end
end

-- Add secure button click hooks
for i = 1, maxItems, 1 do
    HLUI_NearbyList.listElements[i].secureButton:HookScript("OnClick", SecureButtonAction);
end

-- Toggle lock button
HLUI_NearbyList.lockButton:SetScript("OnClick", function(self) 
    Hitlist_settings.nearbyListLocked = not Hitlist_settings.nearbyListLocked;
    HLUI_NearbyList:SetLocked(Hitlist_settings.nearbyListLocked);
end);

-- Close frame button
HLUI_NearbyList.closeButton:SetScript("OnClick", function(self) 
    HLUI_NearbyList:Hide();
    Hitlist_settings.nearbyListShown = false;
    -- clear list to prevent any problems with combat
    wipe(trackedNames);
    wipe(trackedData);
    RefreshList();
end);

--- Hide buttons in combat
function _addon:NearbyList_CombatStart()
    HLUI_NearbyList.closeButton:Hide();
    HLUI_NearbyList.lockButton:Hide();
end

--- Show buttons and update secure buttons
function _addon:NearbyList_CombatEnd()
    if #trackedData > 0 then
        UpdateSecure();
    end
    HLUI_NearbyList.closeButton:Show();
    HLUI_NearbyList.lockButton:Show();
    --SetLocked(Hitlist_settings.nearbyListLocked);
end

--- Init from SV settings
function _addon:NearbyList_Init()
    HLUI_NearbyList:SetLocked(Hitlist_settings.nearbyListLocked, true);
    if Hitlist_settings.nearbyListShown then 
        HLUI_NearbyList:Show(); 
    end
end

--- Add target to the nearby enemy list
-- @param name The target name
-- @param class The unlocalized uppercase target class
-- @param level The expected level of the target
function _addon.NearbyList_AddEnemy(name, class, level)
    if not HLUI_NearbyList:IsShown() or Hitlist_data[realmName].nearbyWhitelist[name] ~= nil then 
        return; 
    end

    if tempWhitelist[name] ~= nil then
        if tempWhitelist[name] + TEMP_WHITELIST_DURATION > time() then
            return;
        end
        tempWhitelist[name] = nil;
    end

    if trackedNames[name] ~= nil then
        trackedData[trackedNames[name]].t = time();
        local changed = false;

        if level > trackedData[trackedNames[name]].l then
            trackedData[trackedNames[name]].l = level;
            changed = true;
        end

        if class ~= trackedData[trackedNames[name]].c and class ~= "UNKNOWN" then
            trackedData[trackedNames[name]].c = class;
            changed = true;
        end

        if changed then
            RefreshSingle(trackedNames[name]);
        end

        return;
    end
    
    local curSize = #trackedData;
    if curSize >= Hitlist_settings.nearbyListMaxShow or curSize >= maxItems then 
        return; 
    end

    table.insert(trackedData, {n = name, c = class, l = level, t = time()});
    trackedNames[name] = #trackedData;
    RefreshSingle(trackedNames[name]);
    HLUI_NearbyList:SetScript("OnUpdate", UpdateList);
end

--- Show the nearby hostile list, also unlocks it
function _addon:NearbyList_Show()
    HLUI_NearbyList:Show();
    Hitlist_settings.nearbyListShown = true;
    Hitlist_settings.nearbyListLocked = false;
    if not InCombatLockdown() then 
        HLUI_NearbyList:SetLocked(false);
    end
end

--- Output some fake stuff
function _addon:NearbyList_Test()
    _addon:NearbyList_Show();
    local count = 1;
    local classes = {"DRUID", "HUNTER", "MAGE", "UNKNOWN", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR"};
    for i = 1, Hitlist_settings.nearbyListMaxShow, 1 do
        local level = math.random(1, 60);
        if count == 4 then
            level = 0;
        end
        _addon.NearbyList_AddEnemy("Testhostile"..i, classes[count], level);
        if count == 10 then 
            count = 1; 
        else
            count = count + 1;
        end
    end
end