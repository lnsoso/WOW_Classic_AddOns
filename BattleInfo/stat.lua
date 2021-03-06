local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local BattleZoneHelper = ADDONSELF.BattleZoneHelper

local f = CreateFrame("Frame", nil, HonorFrame)
f:SetBackdrop({ 
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileEdge = true,
    tileSize = 16,
    edgeSize = 24,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },    
})
f:SetWidth(230)
f:SetHeight(190)
-- f:SetBackdropColor(0, 0, 0)
f:SetPoint("TOPLEFT", HonorFrame, "TOPRIGHT" , -30, -15)

local loc = 50
local function nextloc()
    loc = loc - 50
    return loc
end

local labels = {}

local function DrawStat(bgid)

    local p = CreateFrame("Frame", nil, f)
    p:SetBackdrop({ 
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 16,
    })    
    p:SetPoint("TOPLEFT", f, 15, -15 + nextloc())
    p:SetWidth(200)
    p:SetHeight(60)

    -- p:SetScript("OnMouseUp", function()
    --     DEFAULT_CHAT_FRAME.editBox:SetText(DEFAULT_CHAT_FRAME.editBox:GetText() .. BattleZoneHelper.BGID_MAPNAME_MAP[bgid] .. " " .. labels[bgid]:GetText())
    --     DEFAULT_CHAT_FRAME.editBox:Show()
    -- end)

    do
        local t = p:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t:SetText(BattleZoneHelper.BGID_MAPNAME_MAP[bgid])
        t:SetPoint("TOPLEFT", p, 10, -10)
    end

    do
        local t = p:CreateFontString(nil, "ARTWORK", "GameFontWhite")
        t:SetPoint("TOPLEFT", p, 20, -30)
        labels[bgid] = t
    end
end

local function UpdateStatLabels()

    for bgid, l in pairs(labels) do
        local stat = BatteInfoStat[bgid]
        local win = stat.win or 0 
        local total = stat.total or 0

        local rate = ""
        if total > 0 then
            rate = "= " .. NORMAL_FONT_COLOR:WrapTextInColorCode((math.floor(win / total * 10000) / 100) .. "%")
        end
        l:SetText(L["Win rate"] .. ": " .. string.format("%s/%s %s", GREEN_FONT_COLOR:WrapTextInColorCode(win), YELLOW_FONT_COLOR:WrapTextInColorCode(total), rate))
    end
end


local FACTION_HORDE = 0
local FACTION_ALLIANCE = 1

local function PlayerFaction() 
    local factionGroup = UnitFactionGroup("player");
    if ( factionGroup == "Alliance" ) then
        return FACTION_ALLIANCE
    else
        return FACTION_HORDE
    end
end

local scorerecorded = false
RegEvent("PLAYER_ENTERING_WORLD", function()
    scorerecorded = false
end)

RegEvent("UPDATE_BATTLEFIELD_STATUS", function()
    if scorerecorded then
        return
    end

    local battlefieldWinner = GetBattlefieldWinner()

    if battlefieldWinner then
        local battleGroundID = BattleZoneHelper.MAPNAME_BGID_MAP[GetRealZoneText()]
        local win = battlefieldWinner == PlayerFaction()
        if battleGroundID then
            BatteInfoStat[battleGroundID].win = BatteInfoStat[battleGroundID].win or 0
            BatteInfoStat[battleGroundID].total = BatteInfoStat[battleGroundID].total or 0
            
            BatteInfoStat[battleGroundID].total = BatteInfoStat[battleGroundID].total + 1

            if win then
                BatteInfoStat[battleGroundID].win = BatteInfoStat[battleGroundID].win + 1
            end

            scorerecorded = true

            -- print(BatteInfoStat[battleGroundID].win)
            -- print(BatteInfoStat[battleGroundID].total)
        end
        
        UpdateStatLabels()
    end
end)

RegEvent("ADDON_LOADED", function()
    BatteInfoStat = BatteInfoStat or {}

    for _, id in pairs(BattleZoneHelper.MAPNAME_BGID_MAP) do
        BatteInfoStat[id] = BatteInfoStat[id] or {
            start = time(),
        }

        DrawStat(id)
    end

    UpdateStatLabels()
    
end)
