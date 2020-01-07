local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
ParentFrame adds:
- Children
	self.CreateChild(Frame)
		will set the parent of Frame and call Create() on it.
]]

local super = Templates.Frame
Templates.ParentFrame = super:new()
local this = Templates.ParentFrame

function this:CreateChild(FrameObject)
	if(self.Frame == nil) then
		MyAddonTable.Utility.Chat:Error("Trying to create child frame for non-existing parent!")
	end
		
	FrameObject.FrameParent = self.Frame
	FrameObject:Create()
end
