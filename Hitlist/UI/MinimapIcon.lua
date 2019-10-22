local _, _addon = ...;
local L = _addon:GetLocalization();

local frame = CreateFrame("Button", "HLUI_MinimapIcon", UIParent);

frame:SetClampedToScreen(true);
frame:SetMovable(true);
frame:EnableMouse(true);
frame:RegisterForDrag("LeftButton");
frame:RegisterForClicks("LeftButtonUp", "RightButtonUp");
frame:SetWidth(31);
frame:SetHeight(31);
frame:SetHighlightTexture([[Interface\Minimap\UI-Minimap-ZoomButton-Highlight]]);
frame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, 0);
frame.borderTex = frame:CreateTexture(nil, 'OVERLAY');
frame.borderTex:SetWidth(53);
frame.borderTex:SetHeight(53);
frame.borderTex:SetTexture([[Interface\Minimap\MiniMap-TrackingBorder]]);
frame.borderTex:SetPoint("TOPLEFT", 0,0);
frame.icon = frame:CreateTexture(nil, "BACKGROUND");
frame.icon:SetWidth(20);
frame.icon:SetHeight(20);
frame.icon:SetTexture([[Interface\AddOns\Hitlist\img\logoskull]]);
frame.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95);
frame.icon:SetPoint("CENTER",0,1);

-- Open hitlist on click
frame:SetScript("OnClick", function(self)
    _addon:MainUI_OpenList();
end)

-- Tooltip
frame:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT", 3, -10);
	GameTooltip:SetText(L["UI_MMB_OPEN"]);
	GameTooltip:Show();
end)
frame:SetScript("OnLeave", function(self)
	GameTooltip:Hide();
end)

--- Snap icon to minimap
-- @param refX The x coordinate of the reference point
-- @param refY The y coordinate of the reference point
local function SnapPosition(refX, refY)
	local distTarget = (Minimap:GetWidth()/2 + frame:GetWidth()/2 - 5);
	local mmX, mmY = Minimap:GetCenter();
	local angle = math.atan2( refY-mmY, refX-mmX );
	frame:ClearAllPoints();
	frame:SetPoint("CENTER", Minimap, "CENTER", (math.cos(angle) * distTarget), (math.sin(angle) * distTarget));
end

frame:SetScript("OnDragStart", function(self)
	if Hitlist_settings.snapToMinimap then
		self:SetScript("OnUpdate", function()
            local uiScale, cx, cy = UIParent:GetEffectiveScale(), GetCursorPosition();
            SnapPosition(cx/uiScale, cy/uiScale);
        end);
	end
	self:StartMoving();
end)

frame:SetScript("OnDragStop", function(self) 
	self:SetScript("OnUpdate", nil);
	self:StopMovingOrSizing();
end)

--- Reset to original position on minimap
function frame:Reset()
	self:ClearAllPoints();
    self:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, 0);
end

--- Snap to minimap from current position
function frame:SnapToMinimap()
	local x, y = self:GetCenter();
	SnapPosition(x, y);
end