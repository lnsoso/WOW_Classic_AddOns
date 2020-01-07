local MyAddonName, MyAddonTable = ...

local Chat = MyAddonTable.Utility.Chat

--[[
this module is the central information provider for the tooltip. The EventHandler passes events on to the ditributed information-collectors:
- ISC_Money
- ISC_Bags
- ISC_Gear
- ISC_Bank
- ISC RealmMailQ
- ISC_Professions
(- ISC_ClassSkillBooks)
(- ISC_QuestStartingItems)

The collectors react to events and store data about the current character (and ONLY the current character!) in their own internal tables. They are responsible for
updating these tables and provide methods/functions to access them or handle general requests concerning their objectives.

NOTE: ISC_RealmMailQ has to operate on data concerning all characters on the realm by definition.

When the tooltip requests information about characters, it does so using ISC_Storage ONLY. This module is responsible for getting the right (and up to date) information from the
individual collectors and put them into a table that the tooltip can use efficiently without too much further filtering. The tooltip should NOT need to use the management
functions of any individual collector. It should simply display the data provided in the table by ISC_Storage.

ISC_Storage should also implement safegurads to make sure the informaton is not updated too frequently or in cases where it is obviously not needed.

Upon PLAYER_LOGOUT ISC_Storage writes all of the necessary data into the Account SavedVariables.

---

The main responsibility of this module is to provide the "GetSurveyData(ItemID)" method. The table returned by this method must contain all current Realm-Data in a format suitable
for survey construction. Currently this means:

1. Table of Characters[StorageType][ItemID] = ItemCount
	Used for the basic list
2. RecipeInfo
	If the Item is a Recipe, this table contains Information about the other characters on the realm in relation to it.

]]

MyAddonTable.Storage = {}
local this = MyAddonTable.Storage
this.Events = {}

local LastVisitWarningPeriod = 31.0 * 24.0 * 60.0 * 60.0 --31 days in seconds

function this:ListRealmMoney(RealmName)

	if((RealmName == nil) or (RealmName == "")) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	local RealmData = self.AllRealms[RealmName]
	
	if(RealmData == nil) then
		Chat:Error("Unknown realm: \""..Chat:Purple(RealmName).."\"")
		return
	end
	
	local RealmMoney = 0
	local RealmTransit = 0
	
	Chat:AddonMessage(Chat:Gray("Listing money for realm: \"")..Chat:Purple(RealmName)..Chat:Gray("\""))
	for CharacterName, CharacterData in pairs(RealmData.Characters) do
		local Money = CharacterData.Storage.Money + MyAddonTable.Mail:GetInboxMoney(RealmName, CharacterName)
		local Transit = MyAddonTable.Mail:GetTransitMoney(RealmName, CharacterName)
		
		local MoneyString = CharacterData.Info.NameCC..Chat:Gray(": ")..Chat:Orange(GetCoinTextureString(Money + Transit))
		if(Transit > 0) then
			MoneyString = MoneyString..Chat:Gray(" = ")..Chat:Green(GetCoinTextureString(Money))..Chat:Gray(" + ")..Chat:Red(GetCoinTextureString(Transit))
		end
		print(MoneyString)
		
		RealmMoney		= RealmMoney + Money
		RealmTransit	= RealmTransit + Transit
	end
	
	local MoneyString = Chat:Gray("Total: ")..Chat:Orange(GetCoinTextureString(RealmMoney+RealmTransit))
	if(RealmTransit > 0) then
		MoneyString = MoneyString..Chat:Gray(" = ")..Chat:Green(GetCoinTextureString(RealmMoney))..Chat:Gray(" + ")..Chat:Red(GetCoinTextureString(RealmTransit))
	end
	print(Chat:Gray("---"))
	print(MoneyString)
	
	return
end

function this:GetCharacterRealmIDString(CharacterName, RealmName)

	if(	(self.AllRealms ~= nil) and
		(self.AllRealms[RealmName] ~= nil) and
		(self.AllRealms[RealmName].Characters ~= nil) and
		(self.AllRealms[RealmName].Characters[CharacterName] ~= nil) and
		(self.AllRealms[RealmName].Characters[CharacterName].Info ~= nil) and
		(self.AllRealms[RealmName].Characters[CharacterName].Info.FullNameCC ~= nil)) then
		return self.AllRealms[RealmName].Characters[CharacterName].Info.FullNameCC
	end
	
	return
end
	

function this:CheckVersion(RequiredVersion)

	if(ItemSurveyClassic_AccountData ~= nil) then
		if((ItemSurveyClassic_AccountData.Version ~= nil) and (ItemSurveyClassic_AccountData.Version >= RequiredVersion)) then
			--Version current
			return
		else
			Chat:AddonMessage("Upgrading to Version "..Chat:Green(RequiredVersion).." or later required a data reset.\nPlease login on all of the characters you want to see surveyed in Tooltips and visit their mail & bank.\nSorry for the inconvenience.")
		end
	end
	
	--reset data
	ItemSurveyClassic_AccountData = {}
	ItemSurveyClassic_AccountData.Version = RequiredVersion
	
	return
end

function this:EraseAllData()

	self.AccountData.Realms = nil
	
	self:Init()
	self:DataInit()
	
	Chat:AddonMessage(Chat:Gray("Erased all data."))
	
	return
end

function this:EraseCharacter(RealmName, CharacterName)

	local Realms = self.AllRealms
	if(Realms[RealmName] == nil) then
		Chat:Error(Chat:Gray("Invalid Realm: \"")..RealmName..Chat:Gray("\""))
		return
	end
	
	local Characters = Realms[RealmName].Characters
	if(Characters[CharacterName] == nil) then
		Chat:Error("Invalid Character: \""..CharacterName.."\"")
		return
	end
	
	MyAddonTable.Mail:EraseCharacter(RealmName, CharacterName)
	Characters[CharacterName] = nil
	
	self:Init()
	self:DataInit()
	
	local ErasedCharacter = Chat:GetColorCodedFullName(Characters[CharacterName].Info)
	
	Chat:AddonMessage(Chat:Gray("Erased character: ")..ErasedCharacter)
	
	return
end

function this:CheckLastVisit()

	local CurrentTime = GetServerTime()

	for RealmName, RealmData in pairs(self.AllRealms) do
		for CharacterName, CharacterData in pairs(RealmData.Characters) do
			local CharacterInfo = CharacterData.Info
			
			for StorageName, StorageData in pairs(CharacterInfo.LastVisit) do
				local LastLoginWarning = MyAddonTable.Options:GetSetting("LastLoginWarning")
				local LastMailboxWarning = MyAddonTable.Options:GetSetting("LastMailboxWarning")
				local LastBankWarning = MyAddonTable.Options:GetSetting("LastBankWarning")
				
				if((StorageName == "Login") and (LastLoginWarning == true)) then
					if((CurrentTime - CharacterInfo.LastVisit.Login) > LastVisitWarningPeriod) then
						Chat:AddonMessage(CharacterInfo.FullNameCC..Chat:Gray(" has not been ")..Chat:Yellow("logged in")..Chat:Gray(" for a very long time. If this character no longer exists, use \"")..Chat:Green("/isc EraseCharacter "..CharacterName.."-"..RealmName)..Chat:Gray("\" to delete it from ISC's SavedVariables."))
					end
				elseif((StorageName == "Mailbox") and (LastMailboxWarning == true)) then
					if(StorageData == 0) then
						Chat:AddonMessage(CharacterInfo.FullNameCC..Chat:Gray(" has never visited a ")..Chat:Yellow(StorageName)..Chat:Gray("."))
					elseif((CurrentTime - StorageData) > LastVisitWarningPeriod) then
						Chat:AddonMessage(CharacterInfo.FullNameCC..Chat:Gray(" has not visited a ")..Chat:Yellow(StorageName)..Chat:Gray(" in a very long time"))
					end
				elseif((StorageName == "Bank") and (LastBankWarning == true)) then
					if(StorageData == 0) then
						Chat:AddonMessage(CharacterInfo.FullNameCC..Chat:Gray(" has never visited a ")..Chat:Yellow(StorageName)..Chat:Gray("."))
					elseif((CurrentTime - StorageData) > LastVisitWarningPeriod) then
						Chat:AddonMessage(CharacterInfo.FullNameCC..Chat:Gray(" has not visited a ")..Chat:Yellow(StorageName)..Chat:Gray(" in a very long time"))
					end
				end
			end
		end
	end
	
	return
end

function this:Init()
	
	this:CheckVersion(1.71)
	
	self.AccountData				= ItemSurveyClassic_AccountData
	
	MyAddonTable.Options:Init(self.AccountData)
	
	self.AccountData.Realms			= self.AccountData.Realms or {}
	self.AllRealms					= self.AccountData.Realms
	
	local MyRealm = MyAddonTable:GetCurrentRealmName()
	
	self.AllRealms[MyRealm]			= self.AllRealms[MyRealm] or {}
	self.Realm						= self.AllRealms[MyRealm]
	
	self.Realm.Characters			= self.Realm.Characters or {}
	self.AllCharacters				= self.Realm.Characters
	
	local MyCharacter = MyAddonTable:GetCurrentCharacterName()
	
	self.AllCharacters[MyCharacter]	= self.AllCharacters[MyCharacter] or {}
	self.Character					= self.AllCharacters[MyCharacter]
	
	self.Character.Info				= MyAddonTable:GetCharacterInfo(self.Character)
	self.CharacterInfo				= self.Character.Info
	
	self.Character.Storage			= self.Character.Storage or {}
	self.CharacterStorage			= self.Character.Storage
	
	--init character data tables
	local MyStorage	= self.CharacterStorage
	
	MyAddonTable.Money:Init(MyStorage)
	MyAddonTable.Bags:Init(MyStorage)
	MyAddonTable.Keyring:Init(MyStorage)
	MyAddonTable.Gear:Init(MyStorage)
	MyAddonTable.Bank:Init(MyStorage, self.CharacterInfo)
	
	MyAddonTable.Mail:Init(self.AllRealms) --init with existing data if available
	
	--init some tables used by CreateItemSurvey
	self.SurveyContainers = self.SurveyContainers or
	{
		[1] = { Label = "Bags",		Container = false },
		[2] = { Label = "Keyring",	Container = false },
		[3] = { Label = "Gear",		Container = false },
		[4] = { Label = "Bank",		Container = false },
		[5] = { Label = "BankGear", Container = false },
		[6] = { Label = "Inbox",	Container = false },
		[7] = { Label = "Transit",	Container = false }
	}
	
	self:CheckLastVisit()

	return	
end

function this:DataInit()

	--called to init data which is only reliably available after PLAYER_ENTERING_WORLD
	MyAddonTable.Money:UpdateStorage()
	MyAddonTable.Bags:UpdateStorage()
	MyAddonTable.Keyring:UpdateStorage()
	MyAddonTable.Gear:UpdateStorage()	
	
	return
end

function this.Events:PlayerLogout()

	--this:Update()
	--this:StoreProfessions()
	return
end












function this:CreateItemSurvey(ItemObject, ItemSurvey)

	--print("creating new ItemSurvey!")
	local MyRealm = MyAddonTable:GetCurrentRealmName()
	
	if((ItemObject == nil) or (ItemObject:IsItemEmpty() == true) or (ItemObject:IsItemDataCached() == false)) then
		--print("aborting CreateItemSurvey(): ItemData not ready!")
		return
	end
	
	local ItemID = ItemObject:GetItemID()
	if not ItemID then return end
	local ItemLevel = ItemObject:GetCurrentItemLevel()
	if not ItemLevel then return end
	
	local DelimiterLength = string.len(Chat:White(", "))+1
	local RealmTotal = 0
	local RealmTransitTotal = 0
	
	if(ItemSurvey == nil) then
		ItemSurvey =
		{
			CharacterLines	= {},
			ItemID			= ItemID,
			Timestamp		= GetServerTime()
		}
		
		for i = 1, 10 do
			ItemSurvey.CharacterLines[i] = { Name = false, Content = false }
		end
	else
		ItemSurvey.ItemID		= ItemID
		ItemSurvey.Timestamp	= GetServerTime()
		
		for i = 1, 10 do
			ItemSurvey.CharacterLines[i].Name		= false
			ItemSurvey.CharacterLines[i].Content	= false
		end
	end
	
	local RealmData = self.Realm
	
	local TooltipNoSeparateContainers	= MyAddonTable.Options:GetSetting("TooltipNoSeparateContainers")
	local CharacterIndex = 1
	for CharacterName, CharacterData in pairs(RealmData.Characters) do
		--[[
		we have to check the following locations for item:
		1. Bags
		2. Keyring
		3. Gear
		4. Bank
		5. BankBags
		5. MailInbox
		6. MailTransit
		--]]
		
		local MyContainers = self.SurveyContainers
		MyContainers[1].Container = CharacterData.Storage.Bags
		MyContainers[2].Container = CharacterData.Storage.Keyring
		MyContainers[3].Container = CharacterData.Storage.Gear
		MyContainers[4].Container = CharacterData.Storage.Bank.Items
		MyContainers[5].Container = CharacterData.Storage.Bank.EquippedBags
		MyContainers[6].Container = MyAddonTable.Mail:GetInboxItems(MyRealm, CharacterName)
		MyContainers[7].Container = MyAddonTable.Mail:GetTransitItems(MyRealm, CharacterName)
		
		local Count = 0
		local TransitCount = (MyContainers[7].Container[ItemID] or 0)
		
		local ContainerString = ""
		for i = 1, 6 do
			local Container = MyContainers[i].Container
			local Label 	= MyContainers[i].Label
			--print("DEBUG: ", CharacterName, Label)
			
			if((Container[ItemID] or 0) > 0) then	--exists and > 0
				Count = Count + Container[ItemID]
				ContainerString = ContainerString..Chat:Yellow(Label..": ")..Chat:Green(Container[ItemID])..Chat:White(", ")
			end
		end
		
		if(TransitCount > 0) then
			ContainerString = ContainerString..Chat:Yellow(MyContainers[7].Label..": ")..Chat:Red(MyContainers[7].Container[ItemID])
		else
			ContainerString = string.sub(ContainerString, 1, -DelimiterLength) --shave off the final ", " (color-coded!)
		end
		
		if((Count > 0) or (TransitCount > 0)) then --anything to add?
			local SurveyString = ""
			
			if(TooltipNoSeparateContainers == true) then
				if(TransitCount == 0) then
					SurveyString = Chat:Green(Count+TransitCount)
				else
					SurveyString = Chat:Red(Count+TransitCount)
				end		
			else
				if(TransitCount == 0) then
					SurveyString = Chat:Orange(Count+TransitCount)..Chat:White(" (")..ContainerString..Chat:White(")")
				else
					SurveyString = Chat:Orange(Count+TransitCount)..Chat:White(" = ")..Chat:Green(Count).." + "..Chat:Red(TransitCount)..Chat:White(" (")..ContainerString..Chat:White(")")
				end
			end
		
			ItemSurvey.CharacterLines[CharacterIndex].Name		= CharacterData.Info.NameCC
			ItemSurvey.CharacterLines[CharacterIndex].Content	= SurveyString
			CharacterIndex = CharacterIndex + 1
		end
		
		RealmTotal = RealmTotal + Count
		RealmTransitTotal = RealmTransitTotal + TransitCount
	end
	
	--total string
	local TooltipDisableListingForUniqueItems	= MyAddonTable.Options:GetSetting("TooltipDisableListingForUniqueItems")
	if((RealmTotal + RealmTransitTotal) == 0) then
		ItemSurvey.TotalString = nil
	elseif(((RealmTotal + RealmTransitTotal) == 1) and (TooltipDisableListingForUniqueItems == true)) then			
		ItemSurvey.TotalString = nil
	else
		ItemSurvey.TotalString = Chat:Yellow("Total: ")..Chat:Orange(RealmTotal + RealmTransitTotal)
		if(RealmTransitTotal > 0) then
			ItemSurvey.TotalString = ItemSurvey.TotalString..Chat:White(" = ")..Chat:Green(RealmTotal)..Chat:White(" + ")..Chat:Red(RealmTransitTotal)
		end
	end
	
	--ItemID + iLvL
	local TooltipShowItemID			= MyAddonTable.Options:GetSetting("TooltipShowItemID")
	local TooltipShowItemLvL		= MyAddonTable.Options:GetSetting("TooltipShowItemLvL")
	
	if(TooltipShowItemID == true) then
		ItemSurvey.ItemIDString = Chat:Yellow("ItemID: ")..Chat:Green(ItemID)
	else
		ItemSurvey.ItemIDString = "" --since these are on a double-line we cannot use "nil" for the, it would only create more trouble in Tooltip
	end
	
	if(TooltipShowItemLvL == true) then
		ItemSurvey.ItemLevelString = Chat:Yellow("iLvL: ")..Chat:Green(ItemLevel)
	else
		ItemSurvey.ItemLevelString = ""
	end
	
	--calculate vendor sell value
	local TooltipShowVendorValue	= MyAddonTable.Options:GetSetting("TooltipShowVendorValue")
	
	if(TooltipShowVendorValue == true) then
		local _, _, _, _, _, _, _, MaxStackCount, _, _, SellPrice = GetItemInfo(ItemID)
		if((SellPrice ~= nil) and (SellPrice > 0)) then
			local Count = 1
			if(MaxStackCount > 1) then
				local ItemFrame = GetMouseFocus()
				if((ItemFrame ~= nil) and (ItemFrame.count ~= nil) and (type(ItemFrame.count) == "number")) then
					Count = ItemFrame.count
				end
			end
			
			ItemSurvey.VendorSellValue = SellPrice * Count
		else
			ItemSurvey.VendorSellValue = nil
		end
	else
		ItemSurvey.VendorSellValue = nil
	end
	
	return ItemSurvey
end


function this:GetAllOwnedItems()

	local MyRealm	= MyAddonTable:GetCurrentRealmName()
	local AllItems	= {}
	
	for CharacterName, CharacterData in pairs(self.AllCharacters) do
	
		AllItems[CharacterName] = 
		{
			Bags		= CharacterData.Storage.Bags,
			Keyring		= CharacterData.Storage.Keyring,
			Gear		= CharacterData.Storage.Gear,
			Bank		= CharacterData.Storage.Bank.Items,
			BankBags	= CharacterData.Storage.Bank.EquippedBags,
			Inbox		= MyAddonTable.Mail:GetInboxItems(MyRealm, CharacterName),
			Transit		= MyAddonTable.Mail:GetTransitItems(MyRealm, CharacterName)
		}
	end
	
	return AllItems
end
