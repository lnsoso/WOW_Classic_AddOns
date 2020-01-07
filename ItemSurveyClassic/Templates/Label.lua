local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
Labels are FontStrings. They can only be created as children of other frames. Added fields:
- FontStringTemplate 	(default: "GameFontNormal")
- LabelAnchor			(default: "TOPLEFT")
- LabelPosX				(default: 0)
- LabelPosY				(default: 0)
- LabelText				(default: "Label")
]]

local super = Templates.Frame
Templates.Label = super:new()
local this = Templates.Label

function this:Create(ParentFrameObject)

	self.FrameType		= "FontString"
	self.FrameParent	= ParentFrameObject.Frame
	self.FrameTemplate	= self.FrameTemplate or "GameFontNormal"
	
	self.Frame = ParentFrameObject.Frame:CreateFontString(
		self.FrameName,
		self.FrameLayer,
		self.FrameTemplate)
		
	self.Frame:SetText(self.LabelText or "Label")
	
	self.LabelAnchor	= self.LabelAnchor or "TOPLEFT"
	self.LabelPosX		= self.LabelPosX or 0
	self.LabelPosY		= self.LabelPosY or 0
		
	self:UpdateLabelPosition()
end

function this:UpdateLabelPosition()
	self.Frame:ClearAllPoints()
	self.Frame:SetPoint(self.LabelAnchor, self.LabelPosX, self.LabelPosY)
end
