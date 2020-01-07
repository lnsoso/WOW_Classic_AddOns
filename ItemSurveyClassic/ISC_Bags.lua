local MyAddonName, MyAddonTable = ...

MyAddonTable.Bags = {}
local this = MyAddonTable.Bags
local Table = MyAddonTable.Utility.Table

--[[
Simple Update-Agent for ISC_Storage
]]

this.Events = {}

function this:UpdateStorage()

	local MyContainer = self.Stored
	Table:Clear(MyContainer)
	
	--get the items from our character bags
	for BagID = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local NumSlots = GetContainerNumSlots(BagID)
		for SlotID = 1, NumSlots do
			local _, ItemCount, _, _, _, _, _, _, _, ItemID = GetContainerItemInfo(BagID, SlotID)
			if((ItemID ~= nil) and (ItemCount > 0)) then
				MyContainer[ItemID] = (MyContainer[ItemID] or 0) + ItemCount
			end
		end
	end

	return
end

function this:Init(StoredContent)

	StoredContent.Bags	= StoredContent.Bags or {}
	self.Stored			= StoredContent.Bags
	
	return
end

function this.Events:BagUpdateDelayed()

	this:UpdateStorage()
	
	return
end
