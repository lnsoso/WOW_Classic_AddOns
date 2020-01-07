local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
The most basic frame in WoW is the one that describes all the parameters to CreateFrame:
	self.FrameType (default: "Frame")
	self.FrameName (default: nil)
	self.FrameParent (default: nil)
	self.FrameTemplate (default: nil)
	self.FrameID (default: nil)
]]

local super = Templates.Base
Templates.Frame = super:new()
local this = Templates.Frame

function this:Create()
	if(self.Frame ~= nil) then
		MyAddonTable.Utility.Chat:Error("Trying to create existing frame.")
	end
	
	self.FrameType = self.FrameType or "Frame"
	
	self.Frame = CreateFrame(
		self.FrameType,
		self.FrameName,
		self.FrameParent,
		self.FrameTemplate,
		self.FrameID)
end
