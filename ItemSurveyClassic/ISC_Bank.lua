local MyAddonName, MyAddonTable = ...

MyAddonTable.Bank = {}
local this = MyAddonTable.Bank
local Table = MyAddonTable.Utility.Table

--[[
This module is a simple update agent for ISC_Storage
]]

this.Events = {}

function this:IsBankFrameOpen()
	
	--check if bank is open
	local _, OpenFlag = GetContainerNumFreeSlots(BANK_CONTAINER)	--this API returns a second value only if the bankframe is open
	if(OpenFlag == nil) then
		return false
	end
	
	return true
end

function this:UpdateStorage(InitialUpdate)

	--test if bankframe is open
	if(self:IsBankFrameOpen() == false) then
		return
	end
	
	--store update timestamp
	self.CharacterInfo.LastVisit.Bank = GetServerTime()
	
	--load items
	local MyItems = self.Stored.Items
	Table:Clear(MyItems)
	
	--main bank tab
	local NumSlots = GetContainerNumSlots(BANK_CONTAINER)
	for SlotID = 1, NumSlots do
		local _, ItemCount, _, _, _, _, _, _, _, ItemID = GetContainerItemInfo(BANK_CONTAINER, SlotID)
		if((ItemID ~= nil) and (ItemCount > 0)) then
			MyItems[ItemID] = (MyItems[ItemID] or 0) + ItemCount
		end
	end
	
	--bank bags
	for BagID = NUM_BAG_SLOTS + 1, (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) do
		NumSlots = GetContainerNumSlots(BagID)
		for SlotID = 1, NumSlots do
			local _, ItemCount, _, _, _, _, _, _, _, ItemID = GetContainerItemInfo(BagID, SlotID)
			if((ItemID ~= nil) and (ItemCount > 0)) then
				MyItems[ItemID] = (MyItems[ItemID] or 0) + ItemCount
			end
		end
	end
	
	--load eqipped bank bags	
	local MyBags = self.Stored.EquippedBags
	Table:Clear(MyBags)
	
	for i = 1, GetNumBankSlots() do
		local SlotID = ContainerIDToInventoryID(i + NUM_BAG_SLOTS)
		local ItemID = GetInventoryItemID("player", SlotID)
		if(ItemID ~= nil) then
			MyBags[ItemID] = (MyBags[ItemID] or 0) + 1
		end
	end
	
	return
end 

function this:Init(StoredContent, CharacterInfo)

	StoredContent.Bank = StoredContent.Bank or
	{
		Items			= {},
		EquippedBags	= {}
	}
	
	CharacterInfo.LastVisit.Bank = CharacterInfo.LastVisit.Bank or 0
	
	self.Stored			= StoredContent.Bank
	self.CharacterInfo	= CharacterInfo

	MyAddonTable.EventHandlers:FlagBankUpdate()

	return
end

function this.Events:BagUpdateDelayed()

	this:UpdateStorage()
	
	return
end

function this.Events:BankframeOpened()
	
	this:UpdateStorage()

	return
end

function this.Events:PlayerbankslotsChanged()
	
	this:UpdateStorage()
	
	return
end
