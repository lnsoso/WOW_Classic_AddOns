local function CreateTextFrame(parentFrame, x, y, frameAnchor, textAnchor, textSize)
	local frame = CreateFrame("FRAME", nil, parentFrame)
	frame:SetPoint(frameAnchor, parentFrame, x, y)
	frame:SetWidth(39.375)
	frame:SetHeight(20)
		
	local fontString = frame:CreateFontString()
	fontString:SetPoint(textAnchor)
	fontString:SetFont("Fonts\\FRIZQT__.TTF", textSize, "OUTLINE")
	
	return fontString
end

local function CreateSubFrame(parentFrame, x)
	local frame = CreateFrame("Button", nil, parentFrame, "ActionButtonTemplate")
	frame:SetPoint("LEFT", parentFrame, "LEFT", x, 2) 

	local texture = frame:CreateTexture(nil, "OVERLAY")
	texture:SetAllPoints(frame)

	frame.texture = texture
	frame:SetFrameStrata("BACKGROUND")
	frame:SetWidth(36)
	frame:SetHeight(36)
	
	return texture
end

local function Image(x)
	return CreateSubFrame(mainFrame, x)
end

local function Timer(x)
	return CreateTextFrame(mainFrame, x, -3, "TOPLEFT", "LEFT", 11);
end

local function Count(x)
	return CreateTextFrame(mainFrame, x, 5, "BOTTOMLEFT", "CENTER", 14);
end

--create the main frame
mainFrame = CreateFrame("FRAME", nil, UIParent)
mainFrame:SetFrameStrata("BACKGROUND")
mainFrame:SetWidth(175)
mainFrame:SetHeight(85)

UIElements = 
{ 
	[1] = { Image = Image(10), Timer = Timer(10), Count = Count(10) }, 
	[2] = { Image = Image(50), Timer = Timer(50), Count = Count(50) }, 
	[3] = { Image = Image(90), Timer = Timer(90), Count = Count(90) }, 
	[4] = { Image = Image(130), Timer = Timer(130), Count = Count(130) } 
}

function SaveMainFrameLocation()
	a, b, c, x, y = mainFrame:GetPoint()
	MainFrameX = x
	MainFrameY = y

	mainFrame:StopMovingOrSizing()
end

--set the vars/events necessary to be able to move the frame and save its location
mainFrame:SetMovable(true)
mainFrame:EnableMouse(true)
mainFrame:SetUserPlaced(true);
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
mainFrame:SetScript("OnDragStop", SaveMainFrameLocation)

local function AddonLoaded()
	RestoreMainFrameLocation()
	UpdateTotemData()
end

--[[
	Updates totem timers and affected count at a certain interval.
]]
local _timeSinceLastUpdate = 0
local function OnUpdate(self, elapsed)
	--update time since last update and return if enough time hasn't elapsed
    _timeSinceLastUpdate = _timeSinceLastUpdate + elapsed
    if (_timeSinceLastUpdate < 1) then return end

	UpdateTotemData()
	_timeSinceLastUpdate = 0
end

function mainFrame:OnEvent(eventName, arg1, arg2, arg3)
	if eventName == "ADDON_LOADED" then AddonLoaded() end
	if eventName == "ZONE_CHANGED_NEW_AREA" then ZoneChanged() end
	if eventName == "PLAYER_TOTEM_UPDATE" then PlayerTotemUpdate(arg1) end
	if eventName == "UNIT_SPELLCAST_SUCCEEDED" then SpellCastSucceeded(arg3) end
end

--register events and handler
mainFrame:RegisterEvent("ADDON_LOADED")
mainFrame:RegisterEvent("PLAYER_TOTEM_UPDATE")
mainFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
mainFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
mainFrame:SetScript("OnUpdate", OnUpdate) 
mainFrame:SetScript("OnEvent", mainFrame.OnEvent);

function RestoreMainFrameLocation()
	--set defaults location if the addon has not been loaded before
	if MainFrameX == nil or MainFrameY == nil then
		mainFrame:SetPoint("CENTER", 0, 0)
		return
	end

	--set frame location
	mainFrame:SetPoint("TOPLEFT", MainFrameX, MainFrameY)
end

mainFrame.texture = mainFrame:CreateTexture(nil, "LOW")
mainFrame.texture:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMLEFT", 3, 3);
mainFrame.texture:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", 3, 3);
mainFrame.texture:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 3, -3);
mainFrame.texture:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -3, -3);

mainFrame:SetBackdrop({ 
  bgFile = nil, edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
  tile = true, tileSize = 12, edgeSize = 12, insets = { 4, 4, 4, 4 }
});
mainFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
bgColor = BackgroundColor
mainFrame.texture:SetColorTexture(bgColor.Red, bgColor.Green, bgColor.Blue, bgColor.Alpha)
  
mainFrame:Show()