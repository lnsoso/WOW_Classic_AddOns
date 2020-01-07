local MyAddonName, MyAddonTable = ...

MyAddonTable.CurrentNameTable = {}
local this = MyAddonTable.CurrentNameTable

--[[
The CurrentNameTable (=CNT) holds "[ItemID] = { LocalisedName, Link }" data for all Items actually in possession on the current realm upon the Update() call.

To implement it, we will use a superset SessionNameTable (=SNT) which holds the information of all items ever in possession at any time during the current play session.

When asking for the CNT, we will update Storage and try to fill in the data using the SNT. If the SNT does not contain the ItemID, we will ask the server for it and return
by callback.
]]

function this:ItemInfoCallback(ItemInfo)

	self.SNT[ItemInfo:GetItemID()].Name = ItemInfo:GetItemName()
	self.SNT[ItemInfo:GetItemID()].Link = ItemInfo:GetItemLink()
	self.MissingNames = self.MissingNames - 1
	
	if(self.MissingNames == 0) then
		self.CBFunction(self.Data)
	end

	return
end

function this:Create(CBFunction)
	self.SNT = self.SNT or {}
	self.MissingNames = 0
	
	self.CBFunction = CBFunction
	
	local RealmCharacterItems = MyAddonTable.Storage:GetAllOwnedItems()
	
	self.Data = {}
	
	for CharacterName, CharacterContainers in pairs(RealmCharacterItems) do
		for StorageType, StorageData in pairs(CharacterContainers) do
			for ItemID, ItemCount in pairs(StorageData) do
				if self.Data[ItemID] == nil and ItemCount > 0 then
					--this ItemID is missing from the CNT
					
					if self.SNT[ItemID] == nil then
						--the item is missing from the SNT as well, we will have to query the server for it
						self.MissingNames = self.MissingNames + 1
						
						--create an empty placeholder in the SNT for the missing item
						self.SNT[ItemID] = { ["Name"] = false, ["Link"] = false }
					end
					
					--add the SNT field of this item to the CNT, no matter if empty or not
					self.Data[ItemID] = self.SNT[ItemID]
				end
			end
		end
	end

	if self.MissingNames == 0 then
		--if no names were missing we can return immediately!
		self.CBFunction(self.Data)
		return
	end
	
	local MyItem = MyAddonTable.Utility.Item
	
	--if data was missing we will have to fill it in
	for ItemID, ItemData in pairs(self.SNT) do
		if ItemData["Name"] == false then
			--print("asking for ItemID: "..ItemID)
			MyItem:GetItemInfoByID(ItemID, function(ItemInfo)
				self:ItemInfoCallback(ItemInfo)
				return
			end)
		end
	end
	
	return
end
