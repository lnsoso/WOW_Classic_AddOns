local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
if this template is used to create a checkbox for a global savedvar it will automatically update
the data-field and optionally call an additional toggle-function

IMPORTANT: if CreateForSavedData() is used, all of the optional functions are called IN ADDITION
to updating the data-field!
]]

local super = Templates.ButtonFrame
Templates.UICheckButton = super:new()
local this = Templates.UICheckButton

function this:Create()

	self.FrameType		= self.FrameType or "CheckButton"
	self.FrameTemplate	= self.FrameTemplate or "UICheckButtonTemplate"
	self.ButtonSizeX	= self.ButtonSizeX or 30
	self.ButtonSizeY	= self.ButtonSizeY or 30
	self.FrameTooltipAnchor = "ANCHOR_RIGHT"

	super.Create(self)
	
	self.CheckButtonLabel		= self.CheckButtonLabel or self.ButtonText or "UICheckButton"
	if(self.CheckButtonSavedDataSetting ~= nil) then
		self.CheckButtonState = TTD2.Tools.SavedData:GetCharacterSetting(self.CheckButtonSavedDataSetting)
	end
	if(self.CheckButtonState == nil) then --allowed to overwrite the SavedDataSetting
		self.CheckButtonState = false
	end
	--self.CheckButtonToggleOnFunction
	--self.CheckButtonToggleOnObject
	--self.CheckButtonToggleOffFunction
	--self.CheckButtonToggleOffObject
	
	self.Frame.text:SetText(self.CheckButtonLabel) --CheckButton needs another syntax to set its label
	self.Frame:SetChecked(self.CheckButtonState)
end

function this:OnButtonClick(Frame, Button, Down)
	self.CheckButtonState = self.Frame:GetChecked()
	if(self.CheckButtonSavedDataSetting ~= nil) then
		TTD2.Tools.SavedData:SetCharacterSetting(self.CheckButtonSavedDataSetting, self.CheckButtonState)
	end
	
	super.OnButtonClick(self, Frame, Button, Down)
	
	if(self.CheckButtonState == true) then
		if(self:TryToCall(self.CheckButtonToggleOnFunction, self.CheckButtonToggleOnObject, Frame, Button, Down) == false) then
			self.Frame:SetChecked(false)
			self:OnButtonClick(Frame, Button, Down)
		end
	else
		self:TryToCall(self.CheckButtonToggleOffFunction, self.CheckButtonToggleOffObject, Frame, Button, Down)
	end
end
