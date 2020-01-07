local MyAddonName, MyAddonTable = ...

MyAddonTable.Gear = {}
local this = MyAddonTable.Gear
local Table = MyAddonTable.Utility.Table
local Chat = MyAddonTable.Utility.Chat

--[[
Gear are the items equipped on a character that are actually removed from your other storage - so everything except ammo.
One complication are the equipped bag-slots both on character and bank. if they change, BAG_UPDATE_DELAYED is fired, not PLAYER_EQUIPMENT_CHANGED
what we will do is the following: We will keep the Gear, CharacterBagSlots and BankBagSlots in separate arrays and update each individually
when appropriate - we then rebuild the actual Gear and BankGear tables from those three individual tables in ISC_Storage.
]]

this.Events = {}

function this:UpdateStorage()
	--Chat:Debug("Updating gear storage!")
	
	local MyContainer = self.Stored
	Table:Clear(MyContainer)
	
	for _, GearSlot in ipairs(self.Slots) do
		local ItemID = GetInventoryItemID("player", GearSlot)
		if(ItemID ~= nil) then
			MyContainer[ItemID] = (MyContainer[ItemID] or 0) + 1
		end
	end
	
	return
end

function this:Init(StoredContent)

	StoredContent.Gear	= StoredContent.Gear or {}
	self.Stored			= StoredContent.Gear

	--create slotID table
	self.Slots =
	{
		[1] = GetInventorySlotInfo("HEADSLOT"),
		[2] = GetInventorySlotInfo("NECKSLOT"),
		[3] = GetInventorySlotInfo("SHOULDERSLOT"),
		[4] = GetInventorySlotInfo("SHIRTSLOT"),
		[5] = GetInventorySlotInfo("CHESTSLOT"),
		[6] = GetInventorySlotInfo("WAISTSLOT"),
		[7] = GetInventorySlotInfo("LEGSSLOT"),
		[8] = GetInventorySlotInfo("FEETSLOT"),
		[9] = GetInventorySlotInfo("WRISTSLOT"),
		[10] = GetInventorySlotInfo("HANDSSLOT"),
		[11] = GetInventorySlotInfo("FINGER0SLOT"),
		[12] = GetInventorySlotInfo("FINGER1SLOT"),
		[13] = GetInventorySlotInfo("TRINKET0SLOT"),
		[14] = GetInventorySlotInfo("TRINKET1SLOT"),
		[15] = GetInventorySlotInfo("BACKSLOT"),
		[16] = GetInventorySlotInfo("MAINHANDSLOT"),
		[17] = GetInventorySlotInfo("SECONDARYHANDSLOT"),
		[18] = GetInventorySlotInfo("RANGEDSLOT"),
		[19] = GetInventorySlotInfo("TABARDSLOT")
	}
	
	local MySlots = self.Slots
	
	for i = 1, NUM_BAG_SLOTS do
		local SlotID = ContainerIDToInventoryID(i)
		if(MySlots[SlotID] ~= nil) then
			Chat:Error("SlotID collision while storing BagSlots!")
		else
			MySlots[SlotID] = SlotID
		end
	end
	
	--this:UpdateGear() --the update is done on a later event, gear data may not yet be ready when creating these tables.
	
	return
end

function this.Events:PlayerEquipmentChanged()

	this:UpdateStorage()

	return
end

function this.Events:BagUpdateDelayed()

	this:UpdateStorage()
	
	return
end
