local MyAddonName, MyAddonTable = ...

MyAddonTable.Tooltip = {}
local this = MyAddonTable.Tooltip
local Chat = MyAddonTable.Utility.Chat
local Table = MyAddonTable.Utility.Table

--[[
]]

this.Hooks = {}
this.SurveyUpdateCD = 1

local TooltipRegions = {}

function this:AddTooltipLine(Tooltip, Text, FontObject)

	if((Tooltip == nil) or (Text == nil)) then
		return
	end
	
	Tooltip:AddLine(Text)
	
	if(FontObject == nil) then
		return
	end
	
	local MyFontString = false
	
	Table:Clear(TooltipRegions)
	TooltipRegions = {Tooltip:GetRegions()}
	
	for _, Region in pairs(TooltipRegions) do
		if((Region ~= nil) and (Region:GetObjectType() == "FontString") and (Region:GetText() ~= nil)) then
			MyFontString = Region
		end
	end
	
	MyFontString:SetFontObject(FontObject)
	
	return
end

function this:AddTooltipDoubleLine(Tooltip, TextLeft, TextRight, FontObjectLeft, FontObjectRight)

	if((Tooltip == nil) or ((TextLeft == nil) and (TextRight == nil))) then
		return
	end
	
	Tooltip:AddDoubleLine(TextLeft, TextRight)
	
	if((FontObjectLeft == nil) and (FontObjectRight == nil)) then
		return
	end
	
	local MyFontStringLeft = false
	local MyFontStringRight = false
	
	Table:Clear(TooltipRegions)
	TooltipRegions = {Tooltip:GetRegions()}
	
	for _, Region in pairs(TooltipRegions) do
		if((Region ~= nil) and (Region:GetObjectType() == "FontString") and (Region:GetText() ~= nil)) then
			if(MyFontStringRight ~= false) then
				MyFontStringLeft = MyFontStringRight --store the previous last string as Left except for the first found string
			end
			MyFontStringRight = Region
		end
	end
	
	MyFontStringLeft:SetFontObject(FontObjectLeft)
	MyFontStringRight:SetFontObject(FontObjectRight)

	return
end

function this:TooltipToItemObject(Tooltip)
	--try to get the item in the "official" way first (does not work for the enchanting window!)
	local _, ItemLink = Tooltip:GetItem()
	if not ItemLink then return end --even the defunct CraftWindows return a non-nil ItemLink

	--this is the "default" case for all tooltips not created in CraftingFrames
	local MyItem = Item:CreateFromItemLink(ItemLink)
	if MyItem and MyItem:GetItemID() then return MyItem end
	
	--at this point we assume a CraftingFrame to be open
	if not GetCraftDisplaySkillLine() then return end

	--first, get the item-name from the tooltip
	local ParsedName = ""
	if not _G["GameTooltipTextLeft1"] or not _G["GameTooltipTextLeft1"].GetText then return end
	
	ParsedName = _G["GameTooltipTextLeft1"]:GetText()
	
	--we know that the item must be one of the reagents of the current craft. lets get them all and compare them by name!
	local CurrentCraft = GetCraftSelectionIndex()
	local NumReagents = GetCraftNumReagents(CurrentCraft)
	for i = 1, NumReagents do
		local ReagentName = GetCraftReagentInfo(CurrentCraft, i)
		if(ReagentName == ParsedName) then
			--we found the correct item!
			ItemLink = GetCraftReagentItemLink(CurrentCraft, i)
			MyItem:Clear()
			MyItem = Item:CreateFromItemLink(ItemLink)
			return MyItem
		end
	end
	
	--could not find matching reagent
	return
end

function this:AddItemTooltipInfo(Tooltip, ItemSurvey)

	if not ItemSurvey then return end
	
	--print("adding survey")
	
	--character survey listing
	local AddingFirstLine = true
	local TooltipNoSeparateContainers	= MyAddonTable.Options:GetSetting("TooltipNoSeparateContainers")
	for i = 1, 10 do
		local Line = ItemSurvey.CharacterLines[i]
		if(Line.Name ~= false) then
			if(AddingFirstLine == true) then
				--add a spacing line before the first character of the list
				self:AddTooltipLine(Tooltip, " ", "GameTooltipTextSmall")
				AddingFirstLine = false
			end
			if(TooltipNoSeparateContainers == true) then
				self:AddTooltipLine(Tooltip, Line.Name..": "..Line.Content, "GameTooltipTextSmall")
			else	
				self:AddTooltipDoubleLine(Tooltip, Line.Name, Line.Content, "GameTooltipTextSmall", "GameTooltipTextSmall")
			end
		end
	end
	
	--Total
	if(ItemSurvey.TotalString ~= nil) then
		if(AddingFirstLine == true) then
			--add a spacing line before the first character of the list
			self:AddTooltipLine(Tooltip, " ", "GameTooltipTextSmall")
			AddingFirstLine = false
		end
		self:AddTooltipLine(Tooltip, ItemSurvey.TotalString, "GameTooltipTextSmall")
	end
	
	--ItemID + iLvL
	if((ItemSurvey.ItemIDString ~= "") or (ItemSurvey.ItemLevelString ~= "")) then
		--only add line if one value is actually present
		self:AddTooltipLine(Tooltip, " ", "GameTooltipTextSmall")
		self:AddTooltipDoubleLine(Tooltip,ItemSurvey.ItemIDString,ItemSurvey.ItemLevelString, "GameTooltipTextSmall", "GameTooltipTextSmall")
	end
	
	--add VendorSellValue
	if(ItemSurvey.VendorSellValue ~= nil) then
		SetTooltipMoney(Tooltip, ItemSurvey.VendorSellValue, "STATIC", SELL_PRICE .. ":")
	end
	
	return
end

function this.Hooks:AddTooltipInfo(Tooltip, Firstcall)

	if not Tooltip then Tooltip = GameTooltip end
	local MyItem = this:TooltipToItemObject(Tooltip)

	if(MyItem == nil) then
		return
	end
	
	local ItemID = MyItem:GetItemID()
	local CurrentTime = GetServerTime()
	
	--[[
	self.ReusedTooltip = self.ReusedTooltip or
	{
		ItemID			= 0,
		Timestamp		= 0,
		CharacterLines	= {}
	}
	local MyTooltip = self.ReusedTooltip
	--]]
	
	--print(Firstcall)
	
	--if(MyAddonTable.Professions:IsRecipeItemID(ItemID) == true) then
		--print("recipe detected!")
		if(Firstcall == true) then
			--this is the second call, add the tooltipinfo of the actual recipe
			
			if((self.ReusedTooltip == nil) or (self.ReusedTooltip.ItemID ~= ItemID) or ((CurrentTime - self.ReusedTooltip.Timestamp) > this.SurveyUpdateCD)) then
				self.ReusedTooltip = MyAddonTable.Storage:CreateItemSurvey(MyItem, self.ReusedTooltip)
			end
			
			this:AddItemTooltipInfo(Tooltip, self.ReusedTooltip)
				
		else
			--this is the first call for a new recipe; add tooltip for embedded item and store Link
			--print("skipping first tooltip-call for recipe!")
			
			--local CraftedItemID = MyAddonTable.Professions:GetCraftedItemID(ItemID)
			
			--if(CraftedItemID ~= nil) then
				--local CraftedItem = Item:CreateFromItemID(CraftedItemID)
				
				--if((self.CraftedItemSurvey == nil) or (self.CraftedItemSurvey.ItemID ~= CraftedItemID) or ((CurrentTime - self.CraftedItemSurvey.Timestamp) > this.SurveyUpdateCD)) then
					--self.CraftedItemSurvey = this:CreateItemSurvey(CraftedItem)
				--end
				--this:AddItemTooltipInfo(Tooltip, self.CraftedItemSurvey)
			--end
			
		end
	--else
		--this is not a recipe item, just add the tooltip
		
		--if((self.GenericItemSurvey == nil) or (self.GenericItemSurvey.ItemID ~= ItemID) or ((CurrentTime - self.GenericItemSurvey.Timestamp) > this.SurveyUpdateCD)) then
			--self.GenericItemSurvey = this:CreateItemSurvey(MyItem)
		--end
		--this:AddItemTooltipInfo(Tooltip, self.GenericItemSurvey)
	--end
	
	return
end
