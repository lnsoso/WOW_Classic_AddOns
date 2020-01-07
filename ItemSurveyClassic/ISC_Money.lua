local MyAddonName, MyAddonTable = ...

MyAddonTable.Money = {}
local this = MyAddonTable.Money
this.Events = {}

--[[
Simple Update-Agent for ISC_Storage
]]

local Chat = MyAddonTable.Utility.Chat

function this:UpdateStorage()
	
	local MyContainer = self.Stored
	
	MyContainer.Money = GetMoney()
	
	return
end

function this:Init(StoredContent)

	self.Stored = StoredContent
	
	return
end

function this.Events:PlayerMoney()
	
	this:UpdateStorage()
	
	return
end
