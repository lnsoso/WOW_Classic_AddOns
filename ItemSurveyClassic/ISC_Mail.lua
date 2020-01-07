local MyAddonName, MyAddonTable = ...

MyAddonTable.Mail = {}
local this = MyAddonTable.Mail
local Chat = MyAddonTable.Utility.Chat
local Table = MyAddonTable.Utility.Table

--[[
Mail is a stored copy of the in-game mailbox-inbox + manually added transit-items.
There is one Mail-Table per realm, it is updated/overwritten when the player visits a mailbox.

The MailQ is used to create the actual MailStorage (that only contains ItemID=ItemCount pairs) on demand.
We differentiate between GameUpdates to the MailQ and ManualUpdates. GameUpdates are caused by Hooks+Events (visiting a mailbox, auction buyout, auction cancellation, alt-mail, alt-mail-return) while
ManualUpdate is called whenever the addon needs to access a characters actual MailStorage.
Both Updates are performed by the same function!

GameUpdates are always applied immediatelly and flag the MailStorage of all involved characters as changed.
ManualUpdates are subject to a short CD so that the function cannot be called multiple times per frame. ManualUpdates will check the Transit/Return/DeleteTimes of mail and manually rearange the Q. If
changes are actually made, the Storage is flagged as changed.

When the addon requests a characters MailStorage it only recreates it if either it does not exist yet or if it was flagged as changed.

Only the MailQ is stored to file, the MailStorage is NOT. It is always recreated from the Q.

Optimisation:
Packages that are no longer needed in a MailQ are send back to self.UnusedPackages and later reused when an Update requires new Packages to be added.
Only if self.UnusedPackages has no more packages available new tables are created.
Whenever packages are removed from Mail, the container is actually swapped. The currently unused container is filled with the packages that shall remain
and swapped to the foreground, while the packages that should be deleted are shifted to UnusedPackages and the old MailContainer is swapped t the background.
]]

this.Events = {}
this.Hooks = {}

local TransitPeriod					= 60.0 * 60.0 --mail transit delay in seconds
local PlayerMailExpirationPeriod	= 31.0 * 24.0 * 60.0 * 60.0 --maximum time mail will remain in the inbox in seconds
local SystemMailExpirationPeriod	= 30.0 * 24.0 * 60.0 * 60.0 --maximum time mail will remain in the inbox in seconds
local WarningPeriod					= 4.0 * 24.0 * 60.0 * 60.0 --if warnings are requested, mail that will either return or delete in less than this amount of seconds will be called out
local MailUpdateCD					= 1

function this:WipeWarnings(RealmName)

	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	local Container = self.Warnings[RealmName]
	
	for _, CharacterWarnings in pairs(Container) do
		CharacterWarnings.ReturnSoon		= false
		CharacterWarnings.DeleteSoon		= false
		CharacterWarnings.ReturnLost		= false
		CharacterWarnings.DeleteLost		= false
		CharacterWarnings.TransitReceived	= false
		CharacterWarnings.ReturnReceived	= false
	end
	
	return
end

function this:WipeStorage(RealmName)

	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	local Container = self.Storage[RealmName]
	
	for _, CharacterStorage in pairs(Container) do
		Table:Clear(CharacterStorage.Inbox.Items)
		CharacterStorage.Inbox.Money = 0
		
		Table:Clear(CharacterStorage.Transit.Items)
		CharacterStorage.Transit.Money = 0
	end
	
	return
end

function this:PrintWarnings(RealmName)

	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	local Container = self.Warnings[RealmName]
	
	local MailSoonReturnWarning			= MyAddonTable.Options:GetSetting("MailSoonReturnWarning")
	local MailSoonDeleteWarning			= MyAddonTable.Options:GetSetting("MailSoonDeleteWarning")
	local MailLostReturnedWarning		= MyAddonTable.Options:GetSetting("MailLostReturnedWarning")
	local MailLostDeletedWarning		= MyAddonTable.Options:GetSetting("MailLostDeletedWarning")
	local MailReceivedTransitWarning	= MyAddonTable.Options:GetSetting("MailReceivedTransitWarning")
	local MailReceivedReturnWarning		= MyAddonTable.Options:GetSetting("MailReceivedReturnWarning")
	
	for CharacterName, CharacterWarnings in pairs(Container) do
		if((CharacterWarnings.ReturnSoon == true) and (MailSoonReturnWarning == true) and (self.FirstUpdate == true)) then
			Chat:AddonMessage(MyAddonTable.Storage:GetCharacterRealmIDString(CharacterName, RealmName)..Chat:Gray(" has mail about to expire soon!").." ("..Chat:Yellow("return")..")")
		end
		
		if((CharacterWarnings.DeleteSoon == true) and (MailSoonDeleteWarning == true) and (self.FirstUpdate == true)) then
			Chat:AddonMessage(MyAddonTable.Storage:GetCharacterRealmIDString(CharacterName, RealmName)..Chat:Gray(" has mail about to expire soon!").." ("..Chat:Red("delete")..")")
		end
		
		if((CharacterWarnings.ReturnLost == true) and (MailLostReturnedWarning == true)) then
			Chat:AddonMessage(MyAddonTable.Storage:GetCharacterRealmIDString(CharacterName, RealmName)..Chat:Gray(" has lost mail!").." ("..Chat:Yellow("return")..")")
		end
		
		if((CharacterWarnings.DeleteLost == true) and (MailLostDeletedWarning == true)) then
			Chat:AddonMessage(MyAddonTable.Storage:GetCharacterRealmIDString(CharacterName, RealmName)..Chat:Gray(" has lost mail!").." ("..Chat:Red("delete")..")")
		end
		
		if((CharacterWarnings.TransitReceived == true) and (MailReceivedTransitWarning == true)) then
			Chat:AddonMessage(MyAddonTable.Storage:GetCharacterRealmIDString(CharacterName, RealmName)..Chat:Gray(" has received mail!"))
		end
		
		if((CharacterWarnings.ReturnReceived == true) and (MailReceivedReturnWarning == true)) then
			Chat:AddonMessage(MyAddonTable.Storage:GetCharacterRealmIDString(CharacterName, RealmName)..Chat:Gray(" has received mail!"))
		end
	end
	
	self.FirstUpdate = false
	
	return
end

function this:RebuildStorage(RealmName)

	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	if(self.RMTChanged[RealmName] ~= true) then
		--print("DEBUG: Mail:RebuildStorage() skipped")
		return
	end
	
	local MyRealmData = self.Realms[RealmName]
	
	self:WipeStorage(RealmName)
	
	--print("DEBUG: Rebuilding Storage for Realm: "..RealmName)
	
	for _, Package in pairs(MyRealmData.Mail) do
		local Location = self.Storage[RealmName][Package.To].Transit
		if(Package.TransitTime == nil) then
			Location = self.Storage[RealmName][Package.To].Inbox
		end
		
		for ItemID, ItemCount in pairs(Package.Items) do
			Location.Items[ItemID] = (Location.Items[ItemID] or 0) + ItemCount
		end
			
		Location.Money = Location.Money + Package.Money
	end
	
	self.RMTChanged[RealmName] = false
	
	return
end

function this:SwapRMTBuffer(RealmName)

	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	local MyRealmData	= self.Realms[RealmName]
	local MyBuffer		= self.Buffer
	self.Buffer 		= MyRealmData.Mail
	MyRealmData.Mail	= MyBuffer
	
	return
end

function this:GetCleanBuffer()

	local MyBuffer	= self.Buffer
	Table:Clear(MyBuffer)
	
	return MyBuffer
end

function this:DiscardPackage(Package)
	
	local MyUnused	= self.UnusedPackages
	MyUnused[#MyUnused + 1] = Package
	
	return
end

function this:BufferPackage(Package)

	local MyBuffer	= self.Buffer
	MyBuffer[#MyBuffer + 1] = Package
	
	return
end

function this:EraseCharacter(RealmName, CharacterName)

	--erase all mail related to this character from the RMT
	
	--print("DEBUG: starting mail deletion for: \""..CharacterName.."-"..RealmName.."\"")
	
	local MyRMT		= self.Realms[RealmName].Mail
	local MyBuffer	= self:GetCleanBuffer()
	
	for _, Package in pairs(MyRMT) do
		
		if(Package.To == CharacterName) then
			--print("DEBUG: package with Target as receiver!")
			self:DiscardPackage(Package)
		else
			--print("DEBUG: package is kept!")
			self:BufferPackage(Package)
		end
	
	end

	if(#MyBuffer < #MyRMT) then
		--print("DEBUG: packages deleted from RMT: "..(#MyRMT - #MyBuffer))
		self:SwapRMTBuffer(RealmName)
		self.RMTChanged[RealmName] = true
	end
	
	return
end

function this:Update(RealmName, BypassCooldown)

	local CurrentTime = GetServerTime()
			
	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	if((BypassCooldown == true) or ((CurrentTime - self.LastUpdate[RealmName]) > MailUpdateCD)) then
		self.LastUpdate[RealmName] = CurrentTime
	else
		return
	end

	--print("DEBUG: Updating Mail for Realm: "..RealmName)
	
	self:WipeWarnings(RealmName)
	local MyRealmData		= self.Realms[RealmName]
	local RW				= self.Warnings[RealmName]
	local RMTC				= self.RMTChanged
	local MyBuffer			= self:GetCleanBuffer()
	
	for _, Package in pairs(MyRealmData.Mail) do
	
		--look at packages in transit
		if(Package.TransitTime ~= nil) then
			if(Package.TransitTime < CurrentTime) then
				RMTC[RealmName]	= true
				
				Package.ReturnTime	= Package.TransitTime + PlayerMailExpirationPeriod
				Package.TransitTime	= nil
				
				--test if the package actually remained here
				if(Package.ReturnTime > CurrentTime) then
					RW[Package.To].TransitReceived = true
				end
			end
		end

		--look at packages that might be returned
		if(Package.ReturnTime ~= nil) then
			if((Package.ReturnTime > CurrentTime) and ((Package.ReturnTime - CurrentTime) < WarningPeriod)) then
				RW[Package.To].ReturnSoon	= true
			end
			
			if(Package.ReturnTime < CurrentTime) then
				RMTC[RealmName]				= true
				RW[Package.To].ReturnLost	= true
				
				if(MyRealmData.Characters[Package.From] ~= nil) then --the character this package is returned to belongs to us!
					local ToCopy		= Package.To
					Package.To			= Package.From
					Package.From		= ToCopy
					Package.DeleteTime	= Package.ReturnTime + PlayerMailExpirationPeriod
					Package.ReturnTime	= nil
					
					--test if the package actually remained here
					if(Package.DeleteTime > CurrentTime) then
						RW[Package.To].ReturnReceived = true
					end
				else
					Package.KillMe = true --flag this package for deletion
				end
			end
		end
		
		--look at packages that might be deleted
		if(Package.DeleteTime ~= nil) then
			if((Package.DeleteTime > CurrentTime) and ((Package.DeleteTime - CurrentTime) < WarningPeriod)) then
				RW[Package.To].DeleteSoon	= true
			end
			
			if(Package.DeleteTime < CurrentTime) then
				RMTC[RealmName]				= true
				RW[Package.To].DeleteLost	= true
				
				Package.KillMe				= true
			end
		end
		
		if(Package.KillMe == true) then
			Package.KillMe = nil
			self:DiscardPackage(Package)
		else
			--fill Buffer with remaining packages
			self:BufferPackage(Package)
		end
	end
	
	--print("DEBUG: RMT Size before swap: "..#(self.Realms[RealmName].Mail))
	--print("DEBUG: RMT alias Size before swap: "..#(MyRealmData.Mail))
	--print("DEBUG: Buffer Size before swap: "..#(self.Buffer))
	
	--swap buffer and RMT
	self:SwapRMTBuffer(RealmName)
	
	--print("DEBUG: RMT Size after swap: "..#(self.Realms[RealmName].Mail))
	--print("DEBUG: RMT alias Size after swap: "..#(MyRealmData.Mail))
	--print("DEBUG: Buffer Size after swap: "..#(self.Buffer))
	
	self:PrintWarnings(RealmName)
	
	return
end

function this:Init(Realms)

	--init data for current realm+current character in the stored MailQ table
	local MyRealm						= MyAddonTable:GetCurrentRealmName()
	local MyCharacter					= MyAddonTable:GetCurrentCharacterName()
	
	--confirm stored data
	Realms[MyRealm].Characters[MyCharacter].Info.LastVisit.Mailbox = Realms[MyRealm].Characters[MyCharacter].Info.LastVisit.Mailbox or 0
	Realms[MyRealm].Mail				= Realms[MyRealm].Mail or {}
	self.Realms							= Realms
	
	--internal session data
	self.Buffer							= {} --used to swap RealmMailTable when packages are removed
	self.InboxBuffer					= {} --used when reading the inbox, mail is stored here before it is combined with the RMT
	self.UnusedPackages					= {} --used to store paclages for later reuse to save table creation
	self.LastUpdate						= {} --exists once per realm; used to store the timestamp of the last RealmMailTable udate; when a manual update is called too soon, the call is ignored
	self.RMTChanged						= {} --exists once per realm; if the RealmMailTable changes in a way that MailStorage could change as well, this flag needs to be set
	self.Storage						= {} --StorageTables for each character
	self.Warnings						= {} --exist once per character; contains flags like mail returning soon
	
	for RealmName, RealmData in pairs(Realms) do
		
		self.LastUpdate[RealmName]		= 0
		self.RMTChanged[RealmName]		= true
		self.Storage[RealmName]			= {}
		self.Warnings[RealmName]		= {}
		
		for CharacterName, CharacterData in pairs(RealmData.Characters) do
		
			self.Storage[RealmName][CharacterName]	=
			{
				Inbox =
				{
					Items = {},
					Money = 0
				},
				Transit =
				{
					Items = {},
					Money = 0
				}
			}
			self.Warnings[RealmName][CharacterName]	=
			{
				ReturnSoon		= false,
				DeleteSoon		= false,
				ReturnLost		= false,
				DeleteLost		= false,
				TransitReceived	= false,
				ReturnReceived	= false
			}
		end

		self.FirstUpdate = true
		self:Update(RealmName)
	end
	
	return
end

function this:GetInboxItems(RealmName, CharacterName)
	
	if(CharacterName == nil) then
		CharacterName = MyAddonTable:GetCurrentCharacterName()
	end
	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	self:Update(RealmName)
	self:RebuildStorage(RealmName)
	return self.Storage[RealmName][CharacterName].Inbox.Items
end

function this:GetInboxMoney(RealmName, CharacterName)

	if(CharacterName == nil) then
		CharacterName = MyAddonTable:GetCurrentCharacterName()
	end
	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	self:Update(RealmName)
	self:RebuildStorage(RealmName)
	return self.Storage[RealmName][CharacterName].Inbox.Money
end

function this:GetTransitItems(RealmName, CharacterName)
	
	if(CharacterName == nil) then
		CharacterName = MyAddonTable:GetCurrentCharacterName()
	end
	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	self:Update(RealmName)
	self:RebuildStorage(RealmName)
	return self.Storage[RealmName][CharacterName].Transit.Items
end

function this:GetTransitMoney(RealmName, CharacterName)
	
	if(CharacterName == nil) then
		CharacterName = MyAddonTable:GetCurrentCharacterName()
	end
	if(RealmName == nil) then
		RealmName = MyAddonTable:GetCurrentRealmName()
	end
	
	self:Update(RealmName)
	self:RebuildStorage(RealmName)
	return self.Storage[RealmName][CharacterName].Transit.Money
end

function this:GetUnusedPackage()
	local MyUnusedPackages = self.UnusedPackages
	local NewPackage
	if(#MyUnusedPackages == 0) then
		NewPackage =
		{
			From		= false,
			To			= false,
			Money		= 0,
			CODMoney	= 0,
			Items		= {}
		}
	else
		NewPackage = MyUnusedPackages[#MyUnusedPackages]
		NewPackage.From			= false
		NewPackage.To			= false
		NewPackage.Money		= 0
		NewPackage.CODMoney		= 0
		NewPackage.TransitTime	= nil
		NewPackage.ReturnTime	= nil
		NewPackage.DeleteTime	= nil
		Table:Clear(NewPackage.Items)
		MyUnusedPackages[#MyUnusedPackages] = nil
	end
	
	return NewPackage
end

function this.Events:MailInboxUpdate()
	--print("DEBUG: Updating Mail from mailbox!")
	
	local CurrentTime		= GetServerTime()
	local MyCharacter		= MyAddonTable:GetCurrentCharacterName()
	local MyRealm			= MyAddonTable:GetCurrentRealmName()
	local MyRealmData		= this.Realms[MyRealm]
	
	local RMTC				= this.RMTChanged
	
	
	local MyInboxBuffer		= this.InboxBuffer
	Table:Clear(MyInboxBuffer)
	
	--1: store all packages from the actual in-game mailbox - abort if data is not ready
	local _, NumPackages = GetInboxNumItems()
	for InboxIndex = 1, NumPackages do
		local _, _, Sender, _, Money, CODMoney, DaysLeft, NumItems, _, WasReturned, _, CanReply, _ = GetInboxHeaderInfo(InboxIndex)
		
		if(Sender == nil) then
			--this is a premature event sent before the data was actually loaded from the server
			return
		end
		
		--print("DEBUG: ", Sender, Money, DaysLeft, NumItems, WasReturned, CanReply)
		
		local Package		= this:GetUnusedPackage()
		Package.From		= Sender
		Package.To			= MyCharacter
		Package.Money		= Money
		Package.CODMoney	= CODMoney
		
		local ExpirationTime = CurrentTime + (DaysLeft * 24.0 * 60.0 * 60.0)
		if((WasReturned == true) or (CanReply == false)) then	--normal mail uses the WasReturned flag, AH mail (and other system mail) uses the CanReply flag
			Package.DeleteTime = ExpirationTime
		else
			Package.ReturnTime = ExpirationTime
		end
		--NumItems is either nil for no items or holds the number of items remaining in this mail. items do, however, NOT populate the lowest indices and can be at any index in the 1-12 range with lower indices being nil.
		if(NumItems ~= nil) then
			local Items = Package.Items
			for AttachIndex = 1, ATTACHMENTS_MAX_RECEIVE do
				local _, ItemID, _, ItemCount, _, _  = GetInboxItem(InboxIndex, AttachIndex)
				if((ItemID ~= nil) and (ItemCount > 0)) then
					Items[ItemID] = (Items[ItemID] or 0) + ItemCount
				end
			end
		end
		
		MyInboxBuffer[#MyInboxBuffer + 1] = Package
	end
	
	--print("DEBUG: Size of Inbox-Buffer after reading in mail: "..#MyInboxBuffer)
	
	--2: call an immediate RMT-Update to make sure all the mail is where it should be
	this:Update(MyRealm, true)
	
	local MyBuffer = this:GetCleanBuffer() --this local has to be assigned after Update() as Update() may have swapped the Buffer and the RMT
	
	--3: recombine RMT and inbox buffer, discarding all packages that should be in the current characters inbox from RMT
	for _, Package in pairs(MyRealmData.Mail) do
		if((Package.TransitTime == nil) and (Package.To == MyCharacter)) then
			this:DiscardPackage(Package)
		else
			this:BufferPackage(Package)
		end
	end
	for _, Package in pairs(MyInboxBuffer) do
		this:BufferPackage(Package)
	end
	
	--4: swap buffer and RMT
	--print("DEBUG: RMT Size before swap: "..#(this.Realms[MyRealm].Mail))
	--print("DEBUG: RMT alias Size before swap: "..#(MyRealmData.Mail))
	--print("DEBUG: Buffer Size before swap: "..#(this.Buffer))
	
	--swap buffer and RMT
	this:SwapRMTBuffer(MyRealm)
	
	--print("DEBUG: RMT Size after swap: "..#(this.Realms[MyRealm].Mail))
	--print("DEBUG: RMT alias Size after swap: "..#(MyRealmData.Mail))
	--print("DEBUG: Buffer Size after swap: "..#(this.Buffer))
	
	--5: store last visit
	MyRealmData.Characters[MyCharacter].Info.LastVisit.Mailbox = CurrentTime
	
	--6: flag MailQChanged
	RMTC[MyRealm] = true
	
	return
end

function this.Events:MailSendSuccess()
	--print("DEBUG: Sending off stored package!")
	local MyPackage = this.StoredOutboxPackage
	if(MyPackage == nil) then
		Chat:Error("Failed to find a package to send!")
		return
	end
	
	local MyRealm		= MyAddonTable:GetCurrentRealmName()
	local MyRealmData	= this.Realms[MyRealm]
	local MyRMT			= MyRealmData.Mail
	local MyUnused		= this.UnusedPackages
	
	--check if Target is one of our characters
	if(MyRealmData.Characters[MyPackage.To] ~= nil) then
		--print("DEBUG: Sending to Alt!")
		MyRMT[#MyRMT + 1] = MyPackage
		this.RMTChanged[MyRealm] = true
	else
		--if the package was sent to somebody else, we could keep the table but would have to completely clean it; pushing it into the unused Q will do exactly that with just a little overhead.
		this:DiscardPackage(MyPackage)
	end
	
	--make sure the next SendMail() call will ask for a new package table
	this.StoredOutboxPackage = nil
		
	return
end	

function this.Hooks:SendMail(Target, Subject, Body)
	--print("DEBUG: Trying to send mail")
	
	--this hook only stores the package the user is TRYING to send because the SendMail call can fail
	--we will send the stored package on event MAIL_SEND_SUCCESS
	
	local CurrentTime	= GetServerTime()
	local MyCharacter	= MyAddonTable:GetCurrentCharacterName()
	
	--if a previous attempt to send this package failed, we can simply overwrite the fields
	this.StoredOutboxPackage = this.StoredOutboxPackage or this:GetUnusedPackage()
	local MyPackage = this.StoredOutboxPackage
	
	MyPackage.From			= MyCharacter
	MyPackage.To			= Target
	MyPackage.Money			= GetSendMailMoney()
	MyPackage.CODMoney		= GetSendMailCOD()
	MyPackage.TransitTime	= CurrentTime + TransitPeriod
	
	local MyItems = MyPackage.Items
	Table:Clear(MyItems)
	
	for i = 1, ATTACHMENTS_MAX_SEND do
		if HasSendMailItem(i) then
			local _, ItemID, _, ItemCount, _ = GetSendMailItem(i)
			if((ItemID ~= nil) and (ItemCount > 0)) then
				MyItems[ItemID] = (MyItems[ItemID] or 0) + ItemCount
			end
		end
	end
	
	return
end

function this.Hooks:ReturnInboxItem(Index)
	--print("DEBUG: Returning Package!")
	
	local CurrentTime	= GetServerTime()
	local MyCharacter	= MyAddonTable:GetCurrentCharacterName()
	local MyRealm		= MyAddonTable:GetCurrentRealmName()
	local MyRealmData	= this.Realms[MyRealm]
	local MyRMT			= MyRealmData.Mail
	
	--Note: This hook will be immediatelly followed by MailInboxUpdate() - which will overwrite our own inbox anyway.
	local _, _, Sender, _, Money, CODMoney, _, NumItems, _, _, _, _, _ = GetInboxHeaderInfo(Index)
	
	--check if Target is one of our characters, if not, we are done
	if(MyRealmData.Characters[Sender] == nil) then
		return
	end
	
	local MyPackage			= this:GetUnusedPackage()
	MyPackage.From			= MyCharacter
	MyPackage.To			= Sender
	MyPackage.Money			= Money
	MyPackage.CODMoney		= CODMoney
	MyPackage.DeleteTime	= CurrentTime + PlayerMailExpirationPeriod

	local MyItems = MyPackage.Items
	
	if(NumItems ~= nil) then
		for AttachIndex = 1, ATTACHMENTS_MAX_RECEIVE do
			local _, ItemID, _, ItemCount, _, _  = GetInboxItem(Index, AttachIndex)
			if((ItemID ~= nil) and (ItemCount > 0)) then
				MyItems[ItemID] = (MyItems[ItemID] or 0) + ItemCount
			end
		end
	end
	
	MyRMT[#MyRMT + 1] = MyPackage
	this.RMTChanged[MyRealm] = true
	
	return
end

function this.Hooks:PlaceAuctionBid(Type, Index, Bid)
	--print("DEBUG: Adding AH Buyout Package!")
	
	local _, _, ItemCount, _, _, _, _, _, _, BuyoutPrice, _, _, _, _, _, _, ItemID, _ =  GetAuctionItemInfo(Type,Index)
	if(Bid ~= BuyoutPrice) then
		return
	end
	
	local CurrentTime		= GetServerTime()
	local MyCharacter		= MyAddonTable:GetCurrentCharacterName()
	local MyRealm			= MyAddonTable:GetCurrentRealmName()
	local MyRealmData		= this.Realms[MyRealm]
	local MyRMT				= MyRealmData.Mail
	
	local MyPackage			= this:GetUnusedPackage()
	MyPackage.From			= "[ISC_PH]AuctionHouse[ISC_PH]"
	MyPackage.To			= MyCharacter
	MyPackage.DeleteTime	= CurrentTime + SystemMailExpirationPeriod
	MyPackage.Items[ItemID]	= ItemCount
		
	MyRMT[#MyRMT + 1] = MyPackage
	this.RMTChanged[MyRealm] = true
	
	return
end

function this.Hooks:CancelAution(OwnedAuctionIndex)
	--print("DEBUG: cancelled aution with index: "..OwnedAuctionIndex)
	
	local _, _, ItemCount, _, _, _, _, _, _, _, _, _, _, _, _, _, ItemID, _ =  GetAuctionItemInfo("owner",OwnedAuctionIndex)
	
	local CurrentTime		= GetServerTime()
	local MyCharacter		= MyAddonTable:GetCurrentCharacterName()
	local MyRealm			= MyAddonTable:GetCurrentRealmName()
	local MyRealmData		= this.Realms[MyRealm]
	local MyRMT				= MyRealmData.Mail
	
	local MyPackage			= this:GetUnusedPackage()
	MyPackage.From			= "[ISC_PH]AuctionHouse[ISC_PH]"
	MyPackage.To			= MyCharacter
	MyPackage.DeleteTime	= CurrentTime + SystemMailExpirationPeriod
	MyPackage.Items[ItemID]	= ItemCount
		
	MyRMT[#MyRMT + 1] = MyPackage
	this.RMTChanged[MyRealm] = true
	
	return
end
