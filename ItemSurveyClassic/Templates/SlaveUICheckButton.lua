local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
This is an extension of the normal checkbox which can be given a new option:
.MasterUICheckButton

If this field is set to another UICheckButton object, this object will hook the OnClick
function of the Master.
If the Master is not checked, this slave is also set to not checked AND disabled.
If the Master is checked, this slave is set to enabled.
]]

local super = Templates.UICheckButton
Templates.SlaveUICheckButton = super:new()
local this = Templates.SlaveUICheckButton

function this:Create()

	if(self.MasterUICheckButton == nil) then
		MyAddonTable.Utility.Tools.Chat:Error("trying to create Templates.SlaveUICheckButton without a master defined.")
	end
	
	self.ButtonPosX = self.ButtonPosX or (self.MasterUICheckButton.ButtonPosX + 25)

	super.Create(self)
	
	self:UpdateSlaveStatus()
	
	--store the previous slave (or Master itself, if it did not have a slave)
	self.PreviousSlaveFunction 	= self.MasterUICheckButton.PreviousSlaveFunction or self.MasterUICheckButton.OnButtonClick
	self.PreviousSlaveObject	= self.MasterUICheckButton.PreviousSlave or self.MasterUICheckButton
	
	--set the previous slave of the master to self
	self.MasterUICheckButton.PreviousSlave = self.HookedMasterClick
	self.MasterUICheckButton.PreviousSlave = self

	--register self for master and call previous slave before self
	self.MasterUICheckButton.Frame:SetScript("OnClick", function(Frame, Button, Down)
		self.PreviousSlaveFunction(self.PreviousSlaveObject, Frame, Button, Down)
		self:HookedMasterClick(Frame, Button, Down)
	end)
end

function this:UpdateSlaveStatus()
	--calling this function will make sure "this" checkbox is correctly disabled if the master is disabled, calling all of the underlying toggle-off code
	if(self.CheckButtonState == true and self.MasterUICheckButton.CheckButtonState == false) then
		self.Frame:SetChecked(false)
		self:OnButtonClick(Frame, Button, Down)
	end
end

function this:HookedMasterClick(Frame, Button, Down)
	self:OnButtonClick(Frame, Button, Down)
	self:UpdateSlaveStatus()
	self.Frame:SetEnabled(self.MasterUICheckButton.CheckButtonState)
end
