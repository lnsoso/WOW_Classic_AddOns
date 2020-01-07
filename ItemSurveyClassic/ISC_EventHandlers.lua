local MyAddonName, MyAddonTable = ...

MyAddonTable.EventHandlers = {}
local this = MyAddonTable.EventHandlers

--BAG_UPDATE_DELAYED is fired whenever changes in either the character bags or bank bags occured and are finished; also fired for equipping/removing the actual bag-items to the slots (both character and bank)
function this:BAG_UPDATE_DELAYED()
	MyAddonTable.Bags.Events:BagUpdateDelayed()
	MyAddonTable.Keyring.Events:BagUpdateDelayed()
	MyAddonTable.Gear.Events:BagUpdateDelayed()
	MyAddonTable.Bank.Events:BagUpdateDelayed()
end

--PLAYER_EQUIPMENT_CHANGED is fired when the equipped gear changes
function this:PLAYER_EQUIPMENT_CHANGED()
	MyAddonTable.Gear.Events:PlayerEquipmentChanged()
end

--BANKFRAME_OPENED is fired when the player opens the bank frame
function this:BANKFRAME_OPENED()
	--this event is only handled once to make sure there is bank-data. afterwards the change-events will handle the job
	MyAddonTable.Bank.Events:BankframeOpened()
	self.EventFrame:UnregisterEvent("BANKFRAME_OPENED")
end

--PLAYERBANKSLOTS_CHANGED is fired when the content of the main bank change, it is NOT called for the bank-bags; see BAG_UPDATE_DELAYED for this
function this:PLAYERBANKSLOTS_CHANGED()	
	MyAddonTable.Bank.Events:PlayerbankslotsChanged()
end

--MAIL_INBOX_UPDATE is fired whenever the player opens his mail for the first time or mail status changes; this function may actually be called many times in a row and maybe we will have to throttle it in the future
function this:MAIL_INBOX_UPDATE()
	MyAddonTable.Mail.Events:MailInboxUpdate()
end

--MAIL_SEND_SUCCESS is fired when the player successfully sends mail; we use this event to send off the package we stored with the SendMail() hook
function this:MAIL_SEND_SUCCESS()
	MyAddonTable.Mail.Events:MailSendSuccess()
end

function this:PLAYER_MONEY()
	MyAddonTable.Money.Events:PlayerMoney()
	return
end

function this:SKILL_LINES_CHANGED()
	MyAddonTable.Professions.Events:SkillLinesChanged()
	return
end

function this:NEW_RECIPE_LEARNED(SpellID)
	MyAddonTable.Professions.Events:NewRecipeLearned(SpellID)
	return
end

function this:PLAYER_LOGOUT()
	MyAddonTable.Storage.Events:PlayerLogout()
	return
end

function this:FlagBankUpdate()
	self.EventFrame:RegisterEvent("BANKFRAME_OPENED")
	return
end

--PLAYER_LOGIN is fired after login/reload and most of the client API should be available at this time
function this:PLAYER_LOGIN()

	MyAddonTable:Init()

	--bags events
	self.EventFrame:RegisterEvent("BAG_UPDATE_DELAYED")

	--gear events
	self.EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	
	--mail events+hooks
	self.EventFrame:RegisterEvent("MAIL_INBOX_UPDATE")
	self.EventFrame:RegisterEvent("MAIL_SEND_SUCCESS")
	hooksecurefunc("SendMail", function(Target, Subject, Body)
		MyAddonTable.Mail.Hooks:SendMail(Target, Subject, Body)
		return
	end)
	hooksecurefunc("ReturnInboxItem", function(Index)
		MyAddonTable.Mail.Hooks:ReturnInboxItem(Index)
		return
	end)
	hooksecurefunc("PlaceAuctionBid", function(Type, Index, Bid)
		MyAddonTable.Mail.Hooks:PlaceAuctionBid(Type, Index, Bid)
		return
	end)
	hooksecurefunc("CancelAuction", function(OwnedAuctionIndex)
		MyAddonTable.Mail.Hooks:CancelAution(OwnedAuctionIndex)
		return
	end)
	
	--bank events
	self.EventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")

	--gold events
	self.EventFrame:RegisterEvent("PLAYER_MONEY")
	
	--Profession events
	--self.EventFrame:RegisterEvent("SKILL_LINES_CHANGED")
	--self.EventFrame:RegisterEvent("NEW_RECIPE_LEARNED")
	
	--tooltip hooks
	self.GameTooltipFirstShow = true
	self.ItemRefTooltipFirstShow = true
	
	--hook the tooltip being shown when the mouse actually enters an item frame on your screen
	GameTooltip:HookScript("OnTooltipSetItem", function(Tooltip)
		--print("GameTooltip:OnTooltipSetItem")
		--if(self.GameTooltipFirstShow == true) then
			MyAddonTable.Tooltip.Hooks:AddTooltipInfo(Tooltip, self.GameTooltipFirstShow)
			self.GameTooltipFirstShow = false
		--end
	end)
	
	--hook the tooltip being shown when the mouse actually enters an item frame on your screen
	ItemRefTooltip:HookScript("OnTooltipSetItem", function(Tooltip)
		--print("GameTooltip:OnTooltipSetItem")
		--if(self.ItemRefTooltipFirstShow == true) then
			MyAddonTable.Tooltip.Hooks:AddTooltipInfo(Tooltip, self.ItemRefTooltipFirstShow)
			self.ItemRefTooltipFirstShow = false
		--end
	end)
		
	--hook tooltip-clear to ensure that our additional lines are only added once; required for most crafting recipes
	GameTooltip:HookScript("OnTooltipCleared", function()
		--print("GameTooltip:OnTooltipCleared")
		self.GameTooltipFirstShow = true
	end)
	--hook tooltip-clear to ensure that our additional lines are only added once; required for most crafting recipes
	ItemRefTooltip:HookScript("OnTooltipCleared", function()
		--print("ItemRefTooltip:OnTooltipCleared")
		self.ItemRefTooltipFirstShow = true
	end)
	
	
	self.EventFrame:RegisterEvent("PLAYER_LOGOUT")
	
	--we only need this event once, so unregister it
    self.EventFrame:UnregisterEvent("PLAYER_LOGIN")
    self.PLAYER_LOGIN = nil
	
	return
end

function this:PLAYER_ENTERING_WORLD()

	MyAddonTable.Storage:DataInit()
    self.EventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self.PLAYER_ENTERING_WORLD = nil
	
	return
end

function this:Init()
	self.EventFrame = CreateFrame("Frame")
	self.EventFrame:SetScript("OnEvent", function(Frame, Event, ...)
		this[Event](self, ...) --just a syntax alias for self:func(...)
		return
	end)	
	self.EventFrame:RegisterEvent("PLAYER_LOGIN")
	self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	return
end
