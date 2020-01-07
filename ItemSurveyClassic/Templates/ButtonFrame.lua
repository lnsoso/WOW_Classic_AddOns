local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
sets a default size and easy overloadable method as OnClick()
the OnClick() is actually quite flexible and allows a method call on an object to be set by...
self.ButtonScriptFunction
self.ButtonScriptObject
...without overloading the OnScript method.

IMPORTANT: If you use the above fields instead of overloading OnButtonClick() completely, note that
the called method will be handed the 3 default parameters of OnClick (Frame, Button, Down).
This can lead to unexpected behaviour if you try to call methods with optional parameters and don't
expect the button to pass on these three extra parameters.
You can surpress the passing of the default parameters by setting...
self.ButtonScriptNoDefaultParameters = true
]]

local super = Templates.ExtendedFrame
Templates.ButtonFrame = super:new()
local this = Templates.ButtonFrame

function this:Create()

	self.FrameType = self.FrameType or "Button"

	super.Create(self)
	
	self.ButtonAnchor	= self.ButtonAnchor or "TOPLEFT"
	self.ButtonPosX		= self.ButtonPosX or 0
	self.ButtonPosY		= self.ButtonPosY or 0
	self.ButtonSizeX	= self.ButtonSizeX or 250
	self.ButtonSizeY	= self.ButtonSizeY or 50
	
	--self.ButtonScriptFunction
	--self.ButtonScriptObject
	if(self.ButtonScriptNoDefaultParameters == nil) then
		self.ButtonScriptNoDefaultParameters = false
	end
	
	self.Frame:SetSize(self.ButtonSizeX, self.ButtonSizeY)
	self.Frame:SetScript("OnClick", function(Frame, Button, Down)
		self:OnButtonClick(Frame, Button, Down)
	end)
	self:UpdateButtonPosition()
end

function this:UpdateButtonPosition()
	self.Frame:ClearAllPoints()
	self.Frame:SetPoint(self.ButtonAnchor, self.ButtonPosX, self.ButtonPosY)
end

function this:UpdateButtonParent()
	self.Frame:SetParent(self.FrameParent)
	self:UpdateButtonPosition()
end

function this:TryToCall(Function, Object, Frame, Button, Down)
	if(Function ~= nil) then
		if(Object ~= nil) then
			if(self.ButtonScriptNoDefaultParameters == true) then
				return Function(Object)
			else
				return Function(Object, Frame, Button, Down)
			end
		else
			if(self.ButtonScriptNoDefaultParameters == true) then
				return Function()
			else
				return Function(Frame, Button, Down)
			end
		end
	end
end
			

function this:OnButtonClick(Frame, Button, Down)
	self:TryToCall(self.ButtonScriptFunction, self.ButtonScriptObject, Frame, Button, Down)
end
