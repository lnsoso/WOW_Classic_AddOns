DBM_BidBot_ItemHistory = {}

local BidBot_Queue, BidBot_Biddings = {}, {}
local BidBot_InProgress = false
local BidBot_CurrentItem, AddItem, AddBid, DelBid, AuctionEnd, StartBidding, DoInjectToDKPSystem, sendchatmsg
local myname = UnitName("player")

do
	local function toboolean(var)
		if var then return true else return false end
	end

	local function creategui()
		local panel = DBM_RaidLeadPanel:CreateNewPanel(L.TabCategory_BidBot, "option")
		do
			local area = panel:CreateArea(L.AreaGeneral, nil, 280, true)
			local checkclients = area:CreateButton(L.Button_ShowClients, 100, 16)
			checkclients:SetPoint('TOPRIGHT', area.frame, "TOPRIGHT", -10, -10)
			checkclients:SetNormalFontObject(GameFontNormalSmall)
			checkclients:SetHighlightFontObject(GameFontNormalSmall)
			checkclients:SetScript("OnClick", function(self)
				if IsInRaid() and IsInGroup(LE_PARTY_CATEGORY_HOME) then
					SendAddonMessage("DBM_BidBot", "showversion!", "RAID")
				else
					DBM:AddMsg(L.Local_NoRaid)
				end
			end)
			local enabled 		= area:CreateCheckButton(L.Enable, true)
			enabled:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self)
				if IsInRaid() and IsInGroup(LE_PARTY_CATEGORY_HOME) then
					if settings.enabled then
						SendAddonMessage("DBM_BidBot", "bye!", "RAID")
					else
						SendAddonMessage("DBM_BidBot", "Hi!", "RAID")
					end
				end
				settings.enabled = toboolean(self:GetChecked())
			end)
			local bid_raidwarn	= area:CreateCheckButton(L.ShowinRaidWarn, true)
			local bidtyp_open	= area:CreateCheckButton(L.PublicBids, true)
			local bidtyp_payall	= area:CreateCheckButton(L.PayWhatYouBid, true)
			local chatchannel
			do
				local channels = {
					{text=L.Local,	value="LOCAL"},
					{text=L.Officer,value="OFFICER"},
					{text=L.Guild,	value="GUILD"},
					{text=L.Raid,	value="RAID"},
					{text=L.Party,	value="PARTY"}
				}
				for i=1, select("#", GetChannelList()), 3 do
					local chanid, channame = select(i, GetChannelList())
					if chanid > 3 then
						table.insert(channels, {
							text = channame,
							value = channame
						})
					end
				end
				chatchannel 	= area:CreateDropdown(L.ChatChannel, channels, nil, settings.chatchannel, function(value) settings.chatchannel = value end)
			end
			local minGebot	 	= area:CreateEditBox(L.MinBid, settings.keyword, 100)
			local duration		= area:CreateEditBox(L.Duration, settings.keyword, 100)
			local output 		= area:CreateEditBox(L.OutputBids, settings.keyword, 100)
			chatchannel:SetPoint("TOPLEFT", bidtyp_payall, "BOTTOMLEFT", 0, -10)
			minGebot:SetPoint("TOPLEFT", chatchannel, "BOTTOMLEFT", 30, -15)
			duration:SetPoint("TOPLEFT", minGebot, "BOTTOMLEFT", 0, -20)
			output:SetPoint("TOPLEFT", duration, "BOTTOMLEFT", 0, -20)
			minGebot:SetNumeric()
			duration:SetNumeric()
			output:SetNumeric()
			bid_raidwarn:SetScript("OnClick", 	function(self) settings.withraidwarn = toboolean(self:GetChecked()) end)
			bid_raidwarn:SetScript("OnShow", 	function(self) self:SetChecked(settings.withraidwarn) end)
			bidtyp_open:SetScript("OnClick", 	function(self) settings.bidtyp_open = toboolean(self:GetChecked()) end)
			bidtyp_open:SetScript("OnShow", 	function(self) self:SetChecked(settings.bidtyp_open) end)
			bidtyp_payall:SetScript("OnClick",	function(self) settings.bidtyp_payall = toboolean(self:GetChecked()) end)
			bidtyp_payall:SetScript("OnShow", 	function(self) self:SetChecked(settings.bidtyp_payall) end)
			minGebot:SetScript("OnTextChanged", 	function(self) settings.minGebot = self:GetNumber() end)
			minGebot:SetScript("OnShow", 		function(self) self:SetText(settings.minGebot) end)
			duration:SetScript("OnTextChanged", 	function(self) settings.duration = self:GetNumber() end)
			duration:SetScript("OnShow", 		function(self) self:SetText(settings.duration) end)
			output:SetScript("OnTextChanged", 	function(self) settings.output = self:GetNumber() end)
			output:SetScript("OnShow", 		function(self) self:SetText(settings.output) end)
		end

		panel:SetMyOwnHeight()
		local historypanel = panel:CreateNewPanel(L.TabCategory_History, "option")

		do
			local area = historypanel:CreateArea(L.AreaItemHistory, nil, 360, true)
			local history = area:CreateScrollingMessageFrame(area.frame:GetWidth()-20, 220, nil, nil, GameFontHighlightSmall)
			history:ClearAllPoints()
			history:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 5, -5)
			history:SetPoint("BOTTOMRIGHT", area.frame, "BOTTOMRIGHT", 5, 5)
			history:SetScript("OnShow", function(self)
				if #DBM_BidBot_ItemHistory > 0 then
					self:SetMaxLines((#DBM_BidBot_ItemHistory*4)+1)
					for k,itembid in pairs(DBM_BidBot_ItemHistory) do
						if itembid and itembid.item and itembid.points then
							if #itembid.bids > 0 then
								self:AddMessage("["..date(L.DateFormat, itembid.time).."]: "..itembid.item.." "..itembid.points.." DKP ")
								for i=1, 3, 1 do
									if itembid.bids[i] then
										self:AddMessage("               -> "..i..". "..itembid.bids[i].name.."("..itembid.bids[i].points..")")
									end
								end
								self:AddMessage(" ")
							else
								self:AddMessage("["..date(L.DateFormat, itembid.time).."]: "..itembid.item.." "..L.Disenchant)
							end
						end
					end
				end
			end)
		end
		historypanel:SetMyOwnHeight()
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 11)
end

function sendchatmsg(msg)
	if settings.chatchannel == "LOCAL" then
		DBM:AddMsg(msg)
	elseif settings.chatchannel == "GUILD" or settings.chatchannel == "RAID" or settings.chatchannel == "PARTY" or settings.chatchannel == "OFFICER" then
		SendChatMessage(msg, settings.chatchannel)
	else
		local chanid = GetChannelName(settings.chatchannel)
		if chanid > 4 then
			SendChatMessage(msg, "CHANNEL", nil, chanid)
		else
			DBM:AddMsg(L.Error_ChanNotFound:format(msg))
		end
	end
end

function AddItem(ItemLink)
	local newID = select(4, string.find(ItemLink, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r"))
	for k, v in pairs(BidBot_Queue) do
		if newID == select(4, string.find(v, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r")) then
			return
		end
	end
	table.insert(BidBot_Queue, ItemLink)
end

function AddBid(bidder, bid)
	for k,v in pairs(BidBot_Biddings) do
		if v.Name == bidder then
			BidBot_Biddings[k] = nil
		end
	end
	table.insert(BidBot_Biddings, {
		["Name"] = bidder,
		["Bid"] = bid
	})
	if settings.bidtyp_open then
		sendchatmsg(L.Prefix..L.Message_BidPubMessage:format(bidder, bid))
	else
		SendChatMessage("<DBM> "..L.Prefix..L.Whisper_Bid_OK:format(bid), "WHISPER", nil, bidder)
	end
end

function DelBid(bidder)
	if settings.bidtyp_open then
		sendchatmsg(L.Prefix..L.Whisper_Bid_DEL_failed)
		return
	end
	for k,v in pairs(BidBot_Biddings) do
		if v.Name == bidder then
			BidBot_Biddings[k] = nil
		end
	end
	SendChatMessage("<DBM> "..L.Prefix..L.Whisper_Bid_DEL, "WHISPER", nil, bidder)
end

function AuctionEnd()
	BidBot_InProgress = false
	local Itembid = {
		time = time(),
		item = BidBot_CurrentItem,
		points = 0,
		bids = {}
	}
	local tmp = {}
	for k,v in pairs(BidBot_Biddings) do
		table.insert(tmp, v)
	end
	BidBot_Biddings = tmp
	if BidBot_Biddings[1] and BidBot_Biddings[2] then
		table.sort(BidBot_Biddings, function(a,b) return a.Bid > b.Bid end)
		if settings.bidtyp_payall then
			Itembid.points = BidBot_Biddings[1]["Bid"]
		else
			if BidBot_Biddings[1]["Bid"] ==  BidBot_Biddings[2]["Bid"] then
				Itembid.points = BidBot_Biddings[1]["Bid"]
			else
				Itembid.points = BidBot_Biddings[2]["Bid"] + 1
			end
		end
		sendchatmsg(L.Prefix..L.Message_ItemGoesTo:format(Itembid.item, BidBot_Biddings[1]["Name"], Itembid.points))
	elseif BidBot_Biddings[1] then
		if settings.bidtyp_payall then
			Itembid.points = BidBot_Biddings[1]["Bid"]
		else
			Itembid.points = settings.minGebot
		end
		sendchatmsg(L.Prefix..L.Message_ItemGoesTo:format(Itembid.item, BidBot_Biddings[1]["Name"], Itembid.points))
	else
		sendchatmsg(L.Prefix..L.Message_NoBidMade:format(Itembid.item))
	end

	local counter, max, msg = 0, false, ""
	for posi, werte in pairs(BidBot_Biddings) do
		counter = counter + 1
		table.insert(Itembid.bids, {
			["points"] = werte.Bid,
			["name"] = werte.Name
		})
		msg = msg..werte.Name.."("..werte.Bid..")"
		if posi <= settings.output then
			sendchatmsg(L.Prefix..L.Message_Biddings:format(posi, werte.Name, werte.Bid))
		elseif not max then
			max = true
		end
	end
	table.insert(DBM_BidBot_ItemHistory, Itembid)
	if counter > 0 then
		DoInjectToDKPSystem(Itembid)
	end
	SendAddonMessage("DBM_BidBot", "ITEM:"..select(2, strsplit(":", Itembid.item))..":"..Itembid.points..":("..msg..")", "RAID")
	if max then
		sendchatmsg(L.Prefix..L.Message_BiddingsVisible:format(counter))
	end
	BidBot_CurrentItem = ""
	table.wipe(BidBot_Biddings)
	if #BidBot_Queue then
		sendchatmsg("--- --- --- --- ---")
		DBM:Schedule(1.5, StartBidding)
	end
end

function StartBidding()
	if BidBot_InProgress then
		DBM:AddMsg(L.Prefix..L.Whisper_InUse:format(CurrentItem))
	else
		local ItemLink = false
		if BidBot_Queue[1] then
			ItemLink = table.remove(BidBot_Queue)
		end
		if ItemLink == false then
			return
		end
		BidBot_InProgress = true
		BidBot_CurrentItem = ItemLink
		for i=select("#", BidBot_Biddings), 1, -1 do
			BidBot_Biddings[i] = nil
		end
		if settings.withraidwarn then
			SendChatMessage(L.Prefix..L.Message_StartRaidWarn:format(ItemLink, myname), "RAID_WARNING")
		end
		sendchatmsg(L.Prefix..L.Message_StartBidding:format(ItemLink, myname, settings.minGebot))
		sendchatmsg(L.Prefix..L.Message_DoBidding:format(ItemLink, settings.duration))
		DBM:Schedule((settings.duration / 6) * 5, function()
			sendchatmsg(L.Prefix..L.Message_DoBidding:format(ItemLink, math.floor(settings.duration / 6)))
		end)
		DBM:Schedule(settings.duration / 2, function()
			sendchatmsg(L.Prefix..L.Message_DoBidding:format(ItemLink, math.floor(settings.duration / 2)))
		end)
		DBM:Schedule(settings.duration, AuctionEnd)
	end
end

do
	local hiddenedit = CreateFrame('EditBox', "DBM_DKP_PopupExtension", UIParent)
	hiddenedit:SetWidth(40)
	hiddenedit:SetHeight(20)
	hiddenedit:ClearFocus()
	hiddenedit:SetAutoFocus(false)
	hiddenedit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	hiddenedit:SetFontObject('GameFontHighlightSmall')
	hiddenedit:SetMaxLetters(5)
	hiddenedit:Hide()
	hiddenedit.left = hiddenedit:CreateTexture(nil, "BACKGROUND")
	hiddenedit.left:SetPoint("LEFT", hiddenedit, "LEFT", -10, 0)
	hiddenedit.left:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left")
	hiddenedit.left:SetWidth(40)
	hiddenedit.left:SetHorizTile(true)
	hiddenedit.left:SetTexCoord(0, .15, 0, 1)
	hiddenedit.right = hiddenedit:CreateTexture(nil, "BACKGROUND")
	hiddenedit.right:SetPoint("RIGHT", hiddenedit, "RIGHT", 5, 0)
	hiddenedit.right:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
	hiddenedit.right:SetWidth(20)
	hiddenedit.right:SetHorizTile(true)
	hiddenedit.right:SetVertTile(true)
	hiddenedit.right:SetTexCoord(0.92, 1, 0, 1)
	StaticPopupDialogs["DBM_DKP_ACCEPT"] = {
		text = "bitte Item %s bestätigen",
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 32,
		OnShow = function(self)
			hiddenedit:ClearAllPoints()
			hiddenedit:SetParent(self)
			hiddenedit:SetPoint("TOPRIGHT", self.editBox, "TOPLEFT", -20, -6)
			hiddenedit:SetText(hiddenedit.itemtable.points)
			hiddenedit:Show()
			self.editBox:SetText(hiddenedit.itemtable.player)
		end,
		OnAccept = function(self)
			hiddenedit.itemtable.points = tonumber(hiddenedit:GetNumber())
			hiddenedit.itemtable.player = self.editBox:GetText()
			if hiddenedit.itemtable.points and hiddenedit.itemtable.points > 0 then
				-- don't save item when DKP are zero
				DBM_AddItemToDKP(hiddenedit.itemtable)
			end
			hiddenedit.itemtable = nil
		end,
		OnHide = function(self)
			hiddenedit:SetParent(UIParent)
			hiddenedit:Hide()
			hiddenedit:SetText("")

			self.editBox:SetText("")
		end,
		timeout = 0,
		exclusive = 0,
		hideOnEscape = 0
	}

	function DoInjectToDKPSystem(itemtable)
		if DBM_DKP_System_Settings and DBM_DKP_System_Settings.enabled then
			hiddenedit.itemtable = {
				item = itemtable.item,
				points = itemtable.points,
				time = itemtable.time,
				player = itemtable.bids[1].name
			}
			StaticPopup_Show("DBM_DKP_ACCEPT", itemtable.item)
		end
	end
end

do
	local bidbot_clients = {}

	local function amIactive()
		if not IsInRaid() and IsInGroup(LE_PARTY_CATEGORY_HOME) then
			return false
		end
		for k,v in pairs(bidbot_clients) do
			if DBM:GetRaidRank(k) >= 2 then
				if k == myname then
					return true
				else
					return false
				end
			end
		end
		for k,v in pairs(bidbot_clients) do
			if UnitIsConnected(DBM:GetRaidUnitId(k)) and k < myname then
				return false
			end
		end
		return true
	end

	local function OnMsgRecived(msg, name, nocheck)
		if settings.enabled and IsInRaid() and msg and string.find(string.lower(msg), "^!bid ") then
			if not nocheck and not amIactive() then
				return false
			end
			if name ~= myname and not DBM:GetRaidUnitId(name) then
				return false
			end
			local ItemLink = string.gsub(msg, "^!(%w+) ", "")
			if string.find(ItemLink, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r") then
				for link in string.gmatch(ItemLink, "(|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r)") do
					AddItem(link)
				end
				if BidBot_InProgress then
					SendChatMessage("<DBM>"..L.Prefix..L.Whisper_Queue, "WHISPER", nil, name)
				else
					DBM:Schedule(1.5, StartBidding)
				end
			end
			return true
		end
		return false
	end

	local BidBot_Frame = CreateFrame("Frame", "DBM_BidBotFrame", UIParent)
	local function RegisterEvents(...)
		for i = 1, select("#", ...) do
			BidBot_Frame:RegisterEvent(select(i, ...))
		end
	end

 	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER",
		function(self, event, ...)
			local msg = ...
			if not msg then
				return (BidBot_InProgress and self:find("^%d+$"))
			else
				return (BidBot_InProgress and msg:find("^%d+$")), ...
			end
		end
	)

	BidBot_Frame:SetScript("OnEvent", function(self, event, ...)
		local arg1, arg2 = ...
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			DBM:RegisterCallback("raidJoin", function(event, name)
				if settings.enabled and name and name == myname then
					SendAddonMessage("DBM_BidBot", "Hi!", "WHISPER", name)
				end
			end)
			RegisterEvents(
				"CHAT_MSG_GUILD",
				"CHAT_MSG_RAID",
				"CHAT_MSG_SAY",
				"CHAT_MSG_PARTY",
				"CHAT_MSG_OFFICER",
				"CHAT_MSG_RAID_LEADER",
				"CHAT_MSG_WHISPER",
				"RAID_ROSTER_UPDATE",
				"CHAT_MSG_ADDON"
			)
		elseif settings.enabled and event == "CHAT_MSG_WHISPER" and BidBot_InProgress then
			if arg1:find("^%d+$") then
				local biddkp = tonumber(arg1)
				if biddkp > 0 and biddkp < 50000 then
					AddBid(arg2, biddkp)
				elseif biddkp == 0 then
					DelBid(arg2)
				end
			end
		elseif settings.enabled and event == "CHAT_MSG_ADDON" then
			local prefix, msg, channel, sender = select(1, ...)
			if prefix == "DBM_BidBot" then
				if msg == "Hi!" then
					bidbot_clients[sender] = true
					if settings.enabled and channel == "RAID" then
						SendAddonMessage("DBM_BidBot", "Hi!", "WHISPER", sender)
					end
				elseif msg == "bye!" then
					bidbot_clients[sender] = nil
				elseif msg == "showversion!" then
					if channel == "RAID" then
						SendAddonMessage("DBM_BidBot", "version: r"..tostring(revision), "WHISPER", sender)
					end
				elseif msg:sub(0, 9) == "version: " then
					DBM:AddMsg( L.Local_Version:format(sender, msg:sub(9)) )
				elseif msg:sub(0, 5) == "ITEM:" and sender ~= myname then
					if DBM:GetRaidUnitId(sender) and not channel == "RAID" then return end
					if not DBM:GetRaidUnitId(sender) and not channel == "GUILD" then return end
					local _, itemid, dkp, savedbids = strsplit(":",msg)
					local Itembid = {
						time = time(),
						item = select(2, GetItemInfo(itemid)),
						points = dkp,
						bids = {}
					}
					for bidder, biddkp  in string.gmatch(savedbids, '(%a+)%((%d+)%)') do
						table.insert(Itembid.bids, { ["points"] = biddkp, ["name"] = bidder })
					end
					table.insert(DBM_BidBot_ItemHistory, Itembid)
					if Itembid.bids[1] and Itembid.bids[1].name then
						DoInjectToDKPSystem(Itembid)
					end
				end
			end
		end

		if event:sub(0, 9) == "CHAT_MSG_" then
			OnMsgRecived(select(1, ...), select(2, ...), (event=="CHAT_MSG_WHISPER"))
		end
	end)
	RegisterEvents("ADDON_LOADED")
end