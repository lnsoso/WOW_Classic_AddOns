local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

local Chat = MyAddonTable.Utility.Chat

--[[
Allows for managed CheckButtons to be added directly to the frame with a single method call. each of these CheckButtons contains:
- a checkbox frame
- a table+label saved-var connection

when Refresh() is called all of the CheckButtons are set to match the state of table[label].
when Okay() is called the current state of the checkbox is saved to table[label].
when Default() is called, table[label] is set back to default and then Refresh() is called.

By setting the IsSlave argument to true the new CheckButton will be created as a slave to the previously added one.
]]

local super = Templates.OptionsFrame
MyAddonTable.OptionsFrame = super:new()
local this = MyAddonTable.OptionsFrame

function this:AddOptionsCheckButton(TableSRC, LabelSRC, PosX, PosY, LabelText, TooltipText, IsSlave)

	if((TableSRC == nil) or (LabelSRC == nil) or (TableSRC[LabelSRC] == nil)) then
		Chat:Error("Source data for UICheckButton was invalid.")
	end
	
	self.CheckButtons = self.CheckButtons or {}

	self.CheckButtons[#self.CheckButtons + 1] =
	{
		TableSRC	= TableSRC,
		LabelSRC	= LabelSRC
	}
	
	local MyCheckButton = self.CheckButtons[#self.CheckButtons]
	
	if((#self.CheckButtons) >= 2 and (IsSlave == true)) then
		MyCheckButton.Frame						= Templates.SlaveUICheckButton:new()
		MyCheckButton.Frame.MasterUICheckButton	= self.CheckButtons[#self.CheckButtons - 1].Frame
	else
		MyCheckButton.Frame						= Templates.UICheckButton:new()
	end
	
	MyCheckButton.Frame.CheckButtonState	= MyCheckButton.TableSRC[MyCheckButton.LabelSRC]
	MyCheckButton.Frame.ButtonPosX			= PosX
	MyCheckButton.Frame.ButtonPosY			= PosY
	MyCheckButton.Frame.CheckButtonLabel	= LabelText
	MyCheckButton.Frame.FrameTooltipText	= TooltipText
	
	self:CreateChild(MyCheckButton.Frame)
	
	return MyCheckButton.Frame
end

function this:Refresh()
	
	--print("internal refresh"..self.Frame.name)
	
	if(self.CheckButtons == nil) then
		return
	end
	
	for _, CheckButton in pairs(self.CheckButtons) do
		CheckButton.Frame.Frame:SetChecked(CheckButton.TableSRC[CheckButton.LabelSRC])
	end
	
	return
end

function this:Okay()

	--print("internal okay"..self.Frame.name)
	
	if(self.CheckButtons == nil) then
		return
	end
	
	for _, CheckButton in pairs(self.CheckButtons) do
		CheckButton.TableSRC[CheckButton.LabelSRC] = CheckButton.Frame.Frame:GetChecked()
	end
	
	return
end

function this:Default()

	--print("Default() called for ISC_OptionsFrame. This method has to be overloaded!")
	return
end
