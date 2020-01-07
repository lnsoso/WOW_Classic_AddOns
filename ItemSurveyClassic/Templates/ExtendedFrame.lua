local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
The extended frame adds common frame properties:
- Dragability
	self.IsFrameDragable 	(default: false)
	self.FrameDragButtons	(default: "LeftButton")
	self.OnFrameDragStart()
	self.OnFrameDragStop()
- Tooltip
	self.FrameTooltipText 	(if esists, will be used as the tooltip text)
	self.OnFrameEnter
	self.OnFrameLeave
- Children
	self.CreateChild(Frame)
		will set the parent of Frame and call Create() on it.
]]

local super = Templates.Frame
Templates.ExtendedFrame = super:new()
local this = Templates.ExtendedFrame

function this:OnFrameDragStart()
	self.Frame:StartMoving()
end

function this:OnFrameDragStop()
	self.Frame:StopMovingOrSizing()
end

function this:OnFrameEnter()
	GameTooltip:SetOwner(self.Frame, self.FrameTooltipAnchor)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(self.FrameTooltipText, nil, nil, nil, true)
	GameTooltip:Show()
end

function this:OnFrameLeave()
	GameTooltip:Hide()
end

function this:CreateChild(FrameObject)
	if(self.Frame == nil) then
		MyAddonTable.Utility.Chat:Error("Trying to create child frame for non-existing parent!")
	end
		
	FrameObject.FrameParent = self.Frame
	FrameObject:Create()
end

function this:Create()
	super.Create(self)
	
	self.FrameDragButtons = self.FrameDragButtons or "LeftButton"
	self.FrameTooltipAnchor = self.FrameTooltipAnchor or "ANCHOR_LEFT"
	
	if(self.IsFrameDragable == true) then
		self.Frame:SetMovable(true)
		self.Frame:EnableMouse(true)
		self.Frame:RegisterForDrag(self.FrameDragButtons)
		self.Frame:SetScript("OnDragStart", function()
			self:OnFrameDragStart()
			end)
		self.Frame:SetScript("OnDragStop", function()
			self:OnFrameDragStop()
			end)
	end
	
	if(self.FrameTooltipText ~= nil) then
		self.Frame:SetScript("OnEnter", function()
			self:OnFrameEnter()
			end)
		self.Frame:SetScript("OnLeave", function()
			self:OnFrameLeave()
			end)
	end
end

function this:Toggle(ShowFrame)
	if(self.Frame == nil) then
		if(ShowFrame == nil or ShowFrame == true) then
			self:Create()
		end
	else
		if(self.Frame:IsVisible() == false) then
			if(ShowFrame == nil or ShowFrame == true) then
				self.Frame:Show()
			end
		else
			if(ShowFrame == nil or ShowFrame == false) then
				self.Frame:Hide()
			end
		end
	end
end
