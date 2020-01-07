LT_ItemQuery = {}
LT_TempItems = {}
LT_TempItemsShown = {}

LT_DeltaTime = 0.1
LT_LastTime = 0.0

function LT_ChanceDropDownInit()
	local elements = {0, 1, 2, 5, 15}

	for k, v in pairs(elements) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = v .. "%"
		info.value = v
		info.func = function(self, arg1, arg2, checked)
			if not (checked == 1) then
				UIDropDownMenu_SetSelectedValue(LT_ChanceDropDown, self.value)
			end
		end
		
		UIDropDownMenu_AddButton(info)
		if ((UIDropDownMenu_GetSelectedValue(LT_ChanceDropDown) == nil) and (info.value == 1)) then
			UIDropDownMenu_SetSelectedValue(LT_ChanceDropDown, info.value)
		end
	end
end

function LT_QualityDropDownInit()
	local elements = {"|cFF9D9D9DPoor", "|cFFFFFFFFCommon", "|cFF1EFF00Uncommon", "|cFF0070DDRare", "|cFFA335EEEpic", "|cFFFF8000Legendary"}
	local elements2 = {0, 1, 2, 3, 4, 5}

	for k, v in pairs(elements) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = v
		info.value = elements2[k]
		info.func = function(self, arg1, arg2, checked)
			if not (checked == 1) then
				UIDropDownMenu_SetSelectedValue(LT_QualityDropDown, self.value)
			end
		end
		
		UIDropDownMenu_AddButton(info)
		if (UIDropDownMenu_GetSelectedValue(LT_QualityDropDown) == nil) then
			UIDropDownMenu_SetSelectedValue(LT_QualityDropDown, info.value)
		end
	end
end

function LT_TypeDropDownInit()
	local elements = {"All", "Consumable", "Container", "Weapon", "Armor", "Trade Goods", "Recipe", "Quest"}

	for k, v in pairs(elements) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = v
		info.value = v
		info.func = function(self, arg1, arg2, checked)
			if not (checked == 1) then
				UIDropDownMenu_SetSelectedValue(LT_TypeDropDown, self.value)
			end
		end
		
		UIDropDownMenu_AddButton(info)
		if (UIDropDownMenu_GetSelectedValue(LT_TypeDropDown) == nil) then
			UIDropDownMenu_SetSelectedValue(LT_TypeDropDown, info.value)
		end
	end
end

function LT_TakeFromQuery(itemID, success)
	for k, v in pairs(LT_ItemQuery) do
		local currentID = v["itemID"]
		local currentChance = v["itemChance"]
		if (currentID == itemID) then
			local itemName, itemLink, itemRarity, _, _, itemType, _, _, _, itemIcon, _, _, _, _, _, _, _ = GetItemInfo(itemID)
			LT_TempItems[k] = {["itemID"] = currentID, ["itemChance"] = currentChance, ["itemName"] = itemLink, ["itemLink"] = itemLink, ["itemRarity"] = itemRarity, ["itemType"] = itemType, ["itemIcon"] = itemIcon}
		end
	end
end

function LT_UpdateLootBox(self, elapsed)
	LT_LastTime = LT_LastTime + elapsed
	
	if (LT_LastTime > LT_DeltaTime) then
		LT_LastTime = 0;
		LT_TempItemsShown = {}

		local selectedChance = UIDropDownMenu_GetSelectedValue(LT_ChanceDropDown)
		local selectedQuality = UIDropDownMenu_GetSelectedValue(LT_QualityDropDown)
		local selectedType = UIDropDownMenu_GetSelectedValue(LT_TypeDropDown)
		for k, v in pairs(LT_TempItems) do
			if ((v["itemChance"] >= selectedChance) and (v["itemRarity"] >= selectedQuality)) then
				if ((selectedType == "All") or (v["itemType"] == selectedType)) then
					table.insert(LT_TempItemsShown, v)
				end
			end
		end

		
		for i = 1, 100, 1 do
			if not (LT_TempItemsShown[i] == nil) then
				_G["LT_ItemFrame" .. i]:SetShown(true)
				_G["LT_ItemFrame" .. i].icon:SetTexture(LT_TempItemsShown[i]["itemIcon"])
				_G["LT_ItemFrame" .. i].index:SetText("" .. "[" .. i .. "]")
				_G["LT_ItemFrame" .. i].name:SetText(LT_TempItemsShown[i]["itemName"])
				_G["LT_ItemFrame" .. i].chance:SetText(LT_TempItemsShown[i]["itemChance"] .. "%")
				_G["LT_ItemFrame" .. i].itemLink = LT_TempItemsShown[i]["itemLink"]
			else
				_G["LT_ItemFrame" .. i]:SetShown(false)
			end
		end
	end
end

function LT_OnTargetChange(unitType, npcID)
	LT_ItemQuery = {}
	LT_TempItems = {}
	
	if not(unitType == "Creature") or (LT_Data[npcID] == nil) then
		return
	end
	if (IsControlKeyDown()) then
		local scale,x,y=LT_LootBox:GetEffectiveScale(), GetCursorPosition();
		LT_LootBox:SetPoint("TopLeft", nil, "BottomLeft", (x + 100)/scale, (y - 25)/scale)
		LT_LootBox:SetShown(true)
	end
	
	for i = 1, #LT_Data[npcID], 2 do
		local itemID = LT_Data[npcID][i]
		local itemChance = LT_Data[npcID][i + 1]
		LT_LootBoxTitle:SetText("ID:" .. npcID .. "  Found:" .. (#LT_Data[npcID] / 2))
		
		if (GetItemInfo(itemID) == nil) then
			LT_ItemQuery[(i + 1) / 2] = {["itemID"] = itemID, ["itemChance"] = itemChance}
		else
			local itemName, itemLink, itemRarity, _, _, itemType, _, _, _, itemIcon, _, _, _, _, _, _, _ = GetItemInfo(itemID)
			LT_TempItems[(i + 1) / 2] = {["itemID"] = itemID, ["itemChance"] = itemChance, ["itemName"] = itemLink, ["itemLink"] = itemLink, ["itemRarity"] = itemRarity, ["itemType"] = itemType, ["itemIcon"] = itemIcon}
		end
	end
end