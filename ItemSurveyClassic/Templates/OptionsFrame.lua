local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
OptionsFrame adds:
- requires a name to be supplied to Create()
- adds the frame to Interface>Options using this name

 :Refresh()
 :Okay()
 :Cancel()
 :Default()
]]

local super = Templates.ParentFrame
Templates.OptionsFrame = super:new()
local this = Templates.OptionsFrame

function this:Create(Name, Parent)
	super.Create(self)
	
	self.Frame.name = Name
	
	if(Parent ~= nil) then
		self.Frame.parent = Parent.Frame.name
	end
		
	self.Frame.refresh = function()
		self:Refresh()
		return
	end
	
	self.Frame.okay = function()
		self:Okay()
		return
	end
	
	self.Frame.cancel = function()
		self:Cancel()
		return
	end
	
	self.Frame.default = function()
		self:Default()
		return
	end
	
	InterfaceOptions_AddCategory(self.Frame)
end

function this:Show()
	InterfaceOptionsFrame_OpenToCategory(self.Frame.name)
	InterfaceOptionsFrame_OpenToCategory(self.Frame.name)
	return
end

function this:Refresh()
	return
end

function this:Okay()
	return
end

function this:Cancel()
	return
end

function this:Default()
	return
end
