local _, core = ...;
local _G = _G;
local MonDKP = core.MonDKP;
local L = core.L;

local menu = {}
local curfilterName = L["NOFILTER"];

local menuFrame = CreateFrame("Frame", "MonDKPDeleteLootMenuFrame", UIParent, "UIDropDownMenuTemplate")

function MonDKP:SortLootTable()             -- sorts the Loot History Table by date
  table.sort(MonDKP_Loot, function(a, b)
    return a["date"] > b["date"]
  end)
end

local function SortPlayerTable(arg)             -- sorts player list alphabetically
  table.sort(arg, function(a, b)
    return a < b
  end)
end

local function GetSortOptions()
	local PlayerList = {}
	for i=1, #MonDKP_Loot do
		local playerSearch = MonDKP:Table_Search(PlayerList, MonDKP_Loot[i].player)
		if not playerSearch and not MonDKP_Loot[i].de then
			tinsert(PlayerList, MonDKP_Loot[i].player)
		end
	end
	SortPlayerTable(PlayerList)
	return PlayerList;
end

local function DeleteLootHistoryEntry(index)
	local search = MonDKP:Table_Search(MonDKP_Loot, index, "index");
	local search_player = MonDKP:Table_Search(MonDKP_DKPTable, MonDKP_Loot[search[1][1]].player);
	local curTime = time()
	local curOfficer = UnitName("player")
	local newIndex = curOfficer.."-"..curTime

	
	MonDKP:StatusVerify_Update()
	MonDKP:LootHistory_Reset()

	local tempTable = {
		player = MonDKP_Loot[search[1][1]].player,
		loot =  MonDKP_Loot[search[1][1]].loot,
		zone = MonDKP_Loot[search[1][1]].zone,
		date = time(),
		boss = MonDKP_Loot[search[1][1]].boss,
		cost = -MonDKP_Loot[search[1][1]].cost,
		index = newIndex,
		deletes = MonDKP_Loot[search[1][1]].index
	}

	if search_player then
		MonDKP_DKPTable[search_player[1][1]].dkp = MonDKP_DKPTable[search_player[1][1]].dkp + tempTable.cost 							-- refund previous looter
		MonDKP_DKPTable[search_player[1][1]].lifetime_spent = MonDKP_DKPTable[search_player[1][1]].lifetime_spent + tempTable.cost 		-- remove from lifetime_spent
	end

	MonDKP_Loot[search[1][1]].deletedby = newIndex

	table.insert(MonDKP_Loot, 1, tempTable)
	MonDKP.Sync:SendData("MonDKPDelLoot", tempTable)
	MonDKP:SortLootTable()
	DKPTable_Update()
	MonDKP:LootHistory_Update(L["NOFILTER"]);
end

local function MonDKPDeleteMenu(index)
	local search = MonDKP:Table_Search(MonDKP_Loot, index, "index")
	local search2 = MonDKP:Table_Search(MonDKP_DKPTable, MonDKP_Loot[search[1][1]]["player"])
	local c, deleteString;
	if search2 then
		c = MonDKP:GetCColors(MonDKP_DKPTable[search2[1][1]].class)
		deleteString = L["CONFIRMDELETEENTRY1"]..": |cff"..c.hex..MonDKP_Loot[search[1][1]]["player"].."|r "..L["WON"].." "..MonDKP_Loot[search[1][1]]["loot"].." "..L["FOR"].." "..-MonDKP_Loot[search[1][1]]["cost"].." "..L["DKP"].."?\n\n("..L["THISWILLREFUND"].." |cff"..c.hex..MonDKP_Loot[search[1][1]].player.."|r "..-MonDKP_Loot[search[1][1]]["cost"].." "..L["DKP"]..")";
	else
		deleteString = L["CONFIRMDELETEENTRY1"]..": |cff444444"..MonDKP_Loot[search[1][1]]["player"].."|r "..L["WON"].." "..MonDKP_Loot[search[1][1]]["loot"].." "..L["FOR"].." "..-MonDKP_Loot[search[1][1]]["cost"].." "..L["DKP"].."?\n\n("..L["THISWILLREFUND"].." |cff444444"..MonDKP_Loot[search[1][1]].player.."|r "..-onDKP_Loot[search[1][1]]["cost"].." "..L["DKP"]..")";
	end

	StaticPopupDialogs["DELETE_LOOT_ENTRY"] = {
	  text = deleteString,
	  button1 = L["YES"],
	  button2 = L["NO"],
	  OnAccept = function()
	    DeleteLootHistoryEntry(index)
	  end,
	  timeout = 0,
	  whileDead = true,
	  hideOnEscape = true,
	  preferredIndex = 3,
	}
	StaticPopup_Show ("DELETE_LOOT_ENTRY")
end

local function RightClickLootMenu(self, index)  -- called by right click function on ~201 row:SetScript
	local search = MonDKP:Table_Search(MonDKP_Loot, index, "index")
	menu = {
		{ text = MonDKP_Loot[search[1][1]]["loot"].." "..L["FOR"].." "..MonDKP_Loot[search[1][1]]["cost"].." "..L["DKP"], isTitle = true},
		{ text = "Delete Entry", func = function()
			MonDKPDeleteMenu(index)
		end },
		{ text = L["REASSIGNSELECTED"], func = function()
			local path = MonDKP_Loot[search[1][1]]

			if #core.SelectedData == 1 then
				MonDKP:AwardConfirm(core.SelectedData[1].player, -path.cost, path.boss, path.zone, path.loot, index)
			elseif #core.SelectedData > 1 then
				StaticPopupDialogs["TOO_MANY_SELECTED_LOOT"] = {
				text = L["TOOMANYPLAYERSSELECT"],
				button1 = L["OK"],
				timeout = 0,
				whileDead = true,
				hideOnEscape = true,
				preferredIndex = 3,
			}
			StaticPopup_Show ("TOO_MANY_SELECTED_LOOT")
			else
				MonDKP:AwardConfirm(path.player, -path.cost, path.boss, path.zone, path.loot, index)
			end
		end }
	}
	EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU");
	end

function CreateSortBox()
	local PlayerList = GetSortOptions();
	local curSelected = 0;

	-- Create the dropdown, and configure its appearance
	if not sortDropdown then
		sortDropdown = CreateFrame("FRAME", "MonDKPConfigFilterNameDropDown", MonDKP.ConfigTab5, "MonolithDKPUIDropDownMenuTemplate")
	end

	-- Create and bind the initialization function to the dropdown menu
	UIDropDownMenu_Initialize(sortDropdown, function(self, level, menuList)
		local filterName = UIDropDownMenu_CreateInfo()
		local ranges = {1}

		while ranges[#ranges] < #PlayerList do
			table.insert(ranges, ranges[#ranges]+20)
		end

		if (level or 1) == 1 then
			local numSubs = ceil(#PlayerList/20)
			filterName.func = self.FilterSetValue
			filterName.text, filterName.arg1, filterName.checked, filterName.isNotRadio = L["NOFILTER"], L["NOFILTER"], L["NOFILTER"] == curfilterName, true
			UIDropDownMenu_AddButton(filterName)
			filterName.text, filterName.arg1, filterName.arg2, filterName.checked, filterName.isNotRadio = L["DELETEDENTRY"], L["DELETEDENTRY"], L["DELETEDENTRY"], L["DELETEDENTRY"] == curfilterName, true
			UIDropDownMenu_AddButton(filterName)
		
			for i=1, numSubs do
				local max = i*20;
				if max > #PlayerList then max = #PlayerList end
				filterName.text, filterName.checked, filterName.menuList, filterName.hasArrow = strsub(PlayerList[((i*20)-19)], 1, 1).."-"..strsub(PlayerList[max], 1, 1), curSelected >= (i*20)-19 and curSelected <= i*20, i, true
				UIDropDownMenu_AddButton(filterName)
			end
		else
			filterName.func = self.FilterSetValue
			for i=ranges[menuList], ranges[menuList]+19 do
				if PlayerList[i] then
					local classSearch = MonDKP:Table_Search(MonDKP_DKPTable, PlayerList[i])
				    local c;

				    if classSearch then
				     	c = MonDKP:GetCColors(MonDKP_DKPTable[classSearch[1][1]].class)
				    else
				     	c = { hex="444444" }
				    end
					filterName.text, filterName.arg1, filterName.arg2, filterName.checked, filterName.isNotRadio = "|cff"..c.hex..PlayerList[i].."|r", PlayerList[i], "|cff"..c.hex..PlayerList[i].."|r", PlayerList[i] == curfilterName, true
					UIDropDownMenu_AddButton(filterName, level)
				end
			end
		end
	end)

	sortDropdown:SetPoint("TOPRIGHT", MonDKP.ConfigTab5, "TOPRIGHT", -13, -11)

	UIDropDownMenu_SetWidth(sortDropdown, 150)
	UIDropDownMenu_SetText(sortDropdown, curfilterName or "Filter Name")

  -- Dropdown Menu Function
  function sortDropdown:FilterSetValue(newValue, arg2)
    if curfilterName ~= newValue then curfilterName = newValue else curfilterName = nil end
    UIDropDownMenu_SetText(sortDropdown, arg2)
    MonDKP:LootHistory_Update(newValue)
    CloseDropDownMenus()
  end
end


local tooltip = CreateFrame('GameTooltip', "nil", UIParent, 'GameTooltipTemplate')
local CurrentPosition = 0
local CurrentLimit = 25;
local lineHeight = -65;
local ButtonText = 25;
local curDate = 1;
local curZone;
local curBoss;

function MonDKP:LootHistory_Reset()
	CurrentPosition = 0
	CurrentLimit = 25;
	lineHeight = -65;
	ButtonText = 25;
	curDate = 1;
	curZone = nil;
	curBoss = nil;

	if MonDKP.DKPTable then
		for i=1, #MonDKP_Loot+1 do
			if MonDKP.ConfigTab5.looter[i] then
				MonDKP.ConfigTab5.looter[i]:SetText("")
				MonDKP.ConfigTab5.lootFrame[i]:Hide()
			end
		end
	end
end

local LootHistTimer = LootHistTimer or CreateFrame("StatusBar", nil, UIParent)
function MonDKP:LootHistory_Update(filter)				-- if "filter" is included in call, runs set assigned for when a filter is selected in dropdown.
	if not MonDKP.UIConfig:IsShown() then return end

	local thedate;
	local linesToUse = 1;
	local LootTable = {}
	MonDKP:SortLootTable()
	if LootHistTimer then LootHistTimer:SetScript("OnUpdate", nil) end

	if filter and filter == L["NOFILTER"] then
		curfilterName = L["NOFILTER"]
		CreateSortBox()
	end
	
	if filter then
		MonDKP:LootHistory_Reset()
	end

	if filter and filter ~= L["NOFILTER"] and filter ~= L["DELETEDENTRY"] then
		for i=1, #MonDKP_Loot do
			if not MonDKP_Loot[i].deletes and not MonDKP_Loot[i].deletedby and not MonDKP_Loot[i].hidden and MonDKP_Loot[i].player == filter then
				table.insert(LootTable, MonDKP_Loot[i])
			end
		end
	elseif filter and filter == L["DELETEDENTRY"] then
		for i=1, #MonDKP_Loot do
			if MonDKP_Loot[i].deletes then
				table.insert(LootTable, MonDKP_Loot[i])
			end
		end
	else
		for i=1, #MonDKP_Loot do
			if not MonDKP_Loot[i].deletes and not MonDKP_Loot[i].deletedby and not MonDKP_Loot[i].hidden then
				table.insert(LootTable, MonDKP_Loot[i])
			end
		end
	end

	MonDKP.ConfigTab5.inst:SetText(L["LOOTHISTINST1"]);
	if core.IsOfficer == true then
		MonDKP.ConfigTab5.inst:SetText(MonDKP.ConfigTab5.inst:GetText().."\n"..L["LOOTHISTINST2"])
		MonDKP.ConfigTab6.inst:SetText(L["LOOTHISTINST3"])
	end

	if CurrentLimit > #LootTable then CurrentLimit = #LootTable end;

	if filter and filter ~= L["NOFILTER"] then
		CurrentLimit = #LootTable
	end

	local j=CurrentPosition+1
	local LootTimer = 0
	local processing = false
	LootHistTimer:SetScript("OnUpdate", function(self, elapsed)
		LootTimer = LootTimer + elapsed
		if LootTimer > 0.001 and j <= CurrentLimit and not processing then
			local i = j
			processing = true
		  	local itemToLink = LootTable[i]["loot"]
			local del_search = MonDKP:Table_Search(MonDKP_Loot, LootTable[i].deletes, "index")

		  	if filter == L["DELETEDENTRY"] then
		  		thedate = MonDKP:FormatTime(MonDKP_Loot[del_search[1][1]].date)
		  	else
				thedate = MonDKP:FormatTime(LootTable[i]["date"])
			end

		    if strtrim(strsub(thedate, 1, 8), " ") ~= curDate then
		      linesToUse = 4
		    elseif strtrim(strsub(thedate, 1, 8), " ") == curDate and ((LootTable[i]["boss"] ~= curBoss and LootTable[i]["zone"] ~= curZone) or (LootTable[i]["boss"] == curBoss and LootTable[i]["zone"] ~= curZone)) then
		      linesToUse = 3
		    elseif LootTable[i]["zone"] ~= curZone or LootTable[i]["boss"] ~= curBoss then
		      linesToUse = 2
		    else
		      linesToUse = 1
		    end

		    if (type(MonDKP.ConfigTab5.lootFrame[i]) ~= "table") then
		    	MonDKP.ConfigTab5.lootFrame[i] = CreateFrame("Frame", "MonDKPLootHistoryFrame"..i, MonDKP.ConfigTab5);	-- creates line if it doesn't exist yet
		    end
		    -- determine line height 
	    	if linesToUse == 1 then
				MonDKP.ConfigTab5.lootFrame[i]:SetPoint("TOPLEFT", MonDKP.ConfigTab5, "TOPLEFT", 10, lineHeight-2);
				MonDKP.ConfigTab5.lootFrame[i]:SetSize(200, 14)
				lineHeight = lineHeight-14;
			elseif linesToUse == 2 then
				lineHeight = lineHeight-14;
				MonDKP.ConfigTab5.lootFrame[i]:SetPoint("TOPLEFT", MonDKP.ConfigTab5, "TOPLEFT", 10, lineHeight);
				MonDKP.ConfigTab5.lootFrame[i]:SetSize(200, 28)
				lineHeight = lineHeight-24;
			elseif linesToUse == 3 then
				lineHeight = lineHeight-14;
				MonDKP.ConfigTab5.lootFrame[i]:SetPoint("TOPLEFT", MonDKP.ConfigTab5, "TOPLEFT", 10, lineHeight);
				MonDKP.ConfigTab5.lootFrame[i]:SetSize(200, 38)
				lineHeight = lineHeight-36;
			elseif linesToUse == 4 then
				lineHeight = lineHeight-14;
				MonDKP.ConfigTab5.lootFrame[i]:SetPoint("TOPLEFT", MonDKP.ConfigTab5, "TOPLEFT", 10, lineHeight);
				MonDKP.ConfigTab5.lootFrame[i]:SetSize(200, 50)
				lineHeight = lineHeight-48;
			end;

			MonDKP.ConfigTab5.looter[i] = MonDKP.ConfigTab5.lootFrame[i]:CreateFontString(nil, "OVERLAY")
			MonDKP.ConfigTab5.looter[i]:SetFontObject("MonDKPSmallLeft");
			MonDKP.ConfigTab5.looter[i]:SetPoint("TOPLEFT", MonDKP.ConfigTab5.lootFrame[i], "TOPLEFT", 0, 0);

			local date1, date2, date3 = strsplit("/", strtrim(strsub(thedate, 1, 8), " "))    -- date is stored as yy/mm/dd for sorting purposes. rearranges numbers for printing to string

		    local feedString;

		    local classSearch = MonDKP:Table_Search(MonDKP_DKPTable, LootTable[i]["player"])
		    local c, lootCost;

		    if classSearch then
		     	c = MonDKP:GetCColors(MonDKP_DKPTable[classSearch[1][1]].class)
		    else
		     	c = { hex="444444" }
		    end

		    if tonumber(LootTable[i].cost) < 0 then lootCost = tonumber(LootTable[i].cost) * -1 else lootCost = tonumber(LootTable[i].cost) end

		    if strtrim(strsub(thedate, 1, 8), " ") ~= curDate or LootTable[i]["zone"] ~= curZone then
		    	if strtrim(strsub(thedate, 1, 8), " ") ~= curDate then
					feedString = date2.."/"..date3.."/"..date1.."\n  |cff616ccf"..LootTable[i]["zone"].."|r\n   |cffff0000"..LootTable[i]["boss"].."|r |cff555555("..strtrim(strsub(thedate, 10), " ")..")|r".."\n"
					feedString = feedString.."    "..itemToLink.." "..L["WONBY"].." |cff"..c.hex..LootTable[i]["player"].."|r |cff555555("..lootCost.." "..L["DKP"]..")|r"
				else
					feedString = "  |cff616ccf"..LootTable[i]["zone"].."|r\n   |cffff0000"..LootTable[i]["boss"].."|r |cff555555("..strtrim(strsub(thedate, 10), " ")..")|r".."\n"
					feedString = feedString.."    "..itemToLink.." "..L["WONBY"].." |cff"..c.hex..LootTable[i]["player"].."|r |cff555555("..lootCost.." "..L["DKP"]..")|r"
				end
				        
				MonDKP.ConfigTab5.looter[i]:SetText(feedString);
				curDate = strtrim(strsub(thedate, 1, 8), " ")
				curZone = LootTable[i]["zone"];
				curBoss = LootTable[i]["boss"];
		    elseif LootTable[i]["boss"] ~= curBoss then
		    	feedString = "   |cffff0000"..LootTable[i]["boss"].."|r |cff555555("..strtrim(strsub(thedate, 10), " ")..")|r".."\n"
		    	feedString = feedString.."    "..itemToLink.." "..L["WONBY"].." |cff"..c.hex..LootTable[i]["player"].."|r |cff555555("..lootCost.." "..L["DKP"]..")|r"
		    	 
		    	MonDKP.ConfigTab5.looter[i]:SetText(feedString);
		    	curDate = strtrim(strsub(thedate, 1, 8), " ")
		    	curBoss = LootTable[i]["boss"]
		    else
		    	feedString = "    "..itemToLink.." "..L["WONBY"].." |cff"..c.hex..LootTable[i]["player"].."|r |cff555555("..lootCost.." "..L["DKP"]..")|r"
		    	
		    	MonDKP.ConfigTab5.looter[i]:SetText(feedString);
		    	curZone = LootTable[i]["zone"];
		    end

		    if LootTable[i].reassigned then
		    	MonDKP.ConfigTab5.looter[i]:SetText(MonDKP.ConfigTab5.looter[i]:GetText(feedString).." |cff555555("..L["REASSIGNED"]..")|r")
		    end
		    -- Set script for tooltip/linking
		    MonDKP.ConfigTab5.lootFrame[i]:SetScript("OnEnter", function(self)
		    	local history = 0;
		    	tooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
		    	tooltip:SetHyperlink(itemToLink)
		    	tooltip:AddLine(" ")

		    	local awardOfficer

		    	if filter == L["DELETEDENTRY"] then
		    		awardOfficer = strsplit("-", LootTable[i].deletes)
		    	else
		    		awardOfficer = strsplit("-", LootTable[i].index)
		    	end

		    	local awarded_by_search = MonDKP:Table_Search(MonDKP_DKPTable, awardOfficer, "player")
		    	if awarded_by_search then
			     	c = MonDKP:GetCColors(MonDKP_DKPTable[awarded_by_search[1][1]].class)
			    else
			     	c = { hex="444444" }
			    end

		    	if LootTable[i].bids or LootTable[i].dkp or LootTable[i].rolls then  		-- displays bids/rolls/dkp values if "Log Bids" checked in modes
		    		local path;

		    		tooltip:AddLine(" ")
		    		if LootTable[i].bids then
		    			tooltip:AddLine(L["BIDS"]..":", 0.25, 0.75, 0.90)
		    			table.sort(LootTable[i].bids, function(a, b)
							return a["bid"] > b["bid"]
						end)
						path = LootTable[i].bids
		    		elseif LootTable[i].dkp then
		    			tooltip:AddLine(L["DKPVALUES"]..":", 0.25, 0.75, 0.90)
		    			table.sort(LootTable[i].dkp, function(a, b)
							return a["dkp"] > b["dkp"]
						end)
						path = LootTable[i].dkp
		    		elseif LootTable[i].rolls then
		    			tooltip:AddLine(L["ROLLS"]..":", 0.25, 0.75, 0.90)
		    			table.sort(LootTable[i].rolls, function(a, b)
							return a["roll"] > b["roll"]
						end)
						path = LootTable[i].rolls
		    		end
		    		for j=1, #path do
		    			local col;
		    			local bidder = path[j].bidder
		    			local s = MonDKP:Table_Search(MonDKP_DKPTable, bidder)
		    			local path2 = path[j].bid or path[j].dkp or path[j].roll

		    			if s then
		    				col = MonDKP:GetCColors(MonDKP_DKPTable[s[1][1]].class)
		    			else
		    				col = { hex="444444" }
		    			end
		    			if bidder == LootTable[i].player then
		    				tooltip:AddLine("|cff"..col.hex..bidder.."|r: |cff00ff00"..path2.."|r")
		    			else
		    				tooltip:AddLine("|cff"..col.hex..bidder.."|r: |cffff0000"..path2.."|r")
		    			end
		    		end
		    	end
		    	for j=1, #MonDKP_Loot do
		    		if MonDKP_Loot[j]["loot"] == itemToLink and LootTable[i].date ~= MonDKP_Loot[j].date and not MonDKP_Loot[j].deletedby and not MonDKP_Loot[j].deletes then
		    			local col;
		    			local s = MonDKP:Table_Search(MonDKP_DKPTable, MonDKP_Loot[j].player)
		    			if s then
		    				col = MonDKP:GetCColors(MonDKP_DKPTable[s[1][1]].class)
		    			else
		    				col = { hex="444444" }
		    			end
		    			if history == 0 then
		    				tooltip:AddLine(" ");
		    				tooltip:AddLine(L["ALSOWONBY"]..":", 0.25, 0.75, 0.90, 1, true);
		    				history = 1;
		    			end
		    			tooltip:AddDoubleLine("|cff"..col.hex..MonDKP_Loot[j].player.."|r |cffffffff("..date("%m/%d/%y", MonDKP_Loot[j].date)..")|r", "|cffff0000"..-MonDKP_Loot[j].cost.." "..L["DKP"].."|r", 1.0, 0, 0)
		    		end
		    	end
			    if filter == L["DELETEDENTRY"] then
			    	local delOfficer,_ = strsplit("-", MonDKP_Loot[del_search[1][1]].deletedby)
			    	local col
			    	local del_date = MonDKP:FormatTime(LootTable[i].date)
				    local del_date1, del_date2, del_date3 = strsplit("/", strtrim(strsub(del_date, 1, 8), " "))
			    	local s = MonDKP:Table_Search(MonDKP_DKPTable, delOfficer, "player")
			    	if s then
			    		col = MonDKP:GetCColors(MonDKP_DKPTable[s[1][1]].class)
			    	else
			    		col = { hex="444444"}
			    	end
			    	tooltip:AddLine(" ")
			    	tooltip:AddLine(L["DELETEDBY"], 0.25, 0.75, 0.90, 1, true)
			    	tooltip:AddDoubleLine("|cff"..col.hex..delOfficer.."|r", del_date2.."/"..del_date3.."/"..del_date1.." @ "..strtrim(strsub(del_date, 10), " "),1,0,0,1,1,1)
			    end
			    tooltip:AddLine(" ")
			    tooltip:AddDoubleLine(L["AWARDEDBY"], "|cff"..c.hex..awardOfficer.."|r", 0.25, 0.75, 0.90)
		    	tooltip:Show();
		    end)
		    MonDKP.ConfigTab5.lootFrame[i]:SetScript("OnMouseDown", function(self, button)
	   			if button == "RightButton" and filter ~= L["DELETEDENTRY"] then
	   				if core.IsOfficer == true then
	   					RightClickLootMenu(self, LootTable[i].index)
	   				end
	   			elseif button == "LeftButton" then
	   				if IsShiftKeyDown() then
			    		ChatFrame1EditBox:Show();
			    		ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText()..select(2,GetItemInfo(itemToLink)))
			    		ChatFrame1EditBox:SetFocus();
			    	elseif IsAltKeyDown() then
			    		ChatFrame1EditBox:Show();
			    		ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText()..LootTable[i]["player"].." "..L["WON"].." "..select(2,GetItemInfo(itemToLink)).." "..L["OFF"].." "..LootTable[i]["boss"].." "..L["IN"].." "..LootTable[i]["zone"].." ("..date2.."/"..date3.."/"..date1..") "..L["FOR"].." "..-LootTable[i]["cost"].." "..L["DKP"])
			    		ChatFrame1EditBox:SetFocus();
			    	end
	   			end		    	
		    end)
		    MonDKP.ConfigTab5.lootFrame[i]:SetScript("OnLeave", function()
		    	tooltip:Hide()
		    end)
			if MonDKP.ConfigTab5.LoadHistory then
				MonDKP.ConfigTab5.LoadHistory:SetPoint("TOP", MonDKP.ConfigTab5.lootFrame[i], "BOTTOM", 110, -15)
			end
		    CurrentPosition = CurrentPosition + 1;
		    MonDKP.ConfigTab5.lootFrame[i]:Show();
		    processing = false
		    j=i+1
		    LootTimer = 0
		elseif j > CurrentLimit then
			LootHistTimer:SetScript("OnUpdate", nil)
			LootTimer = 0
			if MonDKP.ConfigTab5.LoadHistory then
				MonDKP.ConfigTab5.LoadHistory:ClearAllPoints();
				MonDKP.ConfigTab5.LoadHistory:SetPoint("TOP", MonDKP.ConfigTab5.lootFrame[CurrentLimit], "BOTTOM", 110, -15)
				if (#LootTable - CurrentPosition) < 25 then
					ButtonText = #LootTable - CurrentPosition;
				end
				MonDKP.ConfigTab5.LoadHistory:SetText(string.format(L["LOAD50MORE"], ButtonText).."...")

				if CurrentLimit >= #LootTable then
					MonDKP.ConfigTab5.LoadHistory:Hide();
				end
			end
		end
 	end)
	if CurrentLimit < #LootTable and not MonDKP.ConfigTab5.LoadHistory then
	 	-- Load More History Button
		MonDKP.ConfigTab5.LoadHistory = self:CreateButton("TOP", MonDKP.ConfigTab5, "BOTTOM", 110, 0, string.format(L["LOAD50MORE"].."...", ButtonText));
		MonDKP.ConfigTab5.LoadHistory:SetSize(110,25)
		MonDKP.ConfigTab5.LoadHistory:SetScript("OnClick", function(self)
			CurrentLimit = CurrentLimit + 25
			if CurrentLimit > #LootTable then
				CurrentLimit = #LootTable
			end
			MonDKP:LootHistory_Update()
		end)
	end
end