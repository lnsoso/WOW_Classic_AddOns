local MyAddonName, MyAddonTable = ...

MyAddonTable.Keyring = {}
local this = MyAddonTable.Keyring
local Table = MyAddonTable.Utility.Table

--[[
Simple Update-Agent for ISC_Storage
]]

this.Events = {}

function this:UpdateStorage()

	local MyContainer = self.Stored
	Table:Clear(MyContainer)
	
	local NumSlots = GetContainerNumSlots(KEYRING_CONTAINER)
	for SlotID = 1, NumSlots do
		local _, ItemCount, _, _, _, _, _, _, _, ItemID = GetContainerItemInfo(KEYRING_CONTAINER, SlotID)
		if((ItemID ~= nil) and (ItemCount > 0)) then
			MyContainer[ItemID] = (MyContainer[ItemID] or 0) + ItemCount
		end
	end

	return
end

function this:Init(StoredContent)

	StoredContent.Keyring	= StoredContent.Keyring or {}
	self.Stored				= StoredContent.Keyring
	
	return
end

function this.Events:BagUpdateDelayed()

	this:UpdateStorage()
	
	return
end
