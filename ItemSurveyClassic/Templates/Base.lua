local MyAddonName, MyAddonTable = ...

MyAddonTable.Templates = MyAddonTable.Templates or {}
local Templates = MyAddonTable.Templates

--[[
all the base does is provide the new() constructor.
]]

Templates.Base = {}
local this = Templates.Base

function this:new(o)
	o = o or {}
	o.this = o
	setmetatable(o, self)
	self.__index = self
	return o
end
