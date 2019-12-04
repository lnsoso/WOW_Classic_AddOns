-- scope stuff
karmarang = karmarang or {};
local c = karmarang;

-- variables
c.MAX_LATESTCOMMENTS = 3;

c.COMMENT_MAXLENGTH = 120;
c.OPT_MAXLENGTH_TOOLTIP = "OPT_MAXLENGTH_TOOLTIP";

c.KARMA_PREFIX_HELLO = "_KRM_HE";
c.KARMA_PREFIX_BYE = "_KRM_BY";
c.KARMA_PREFIX_BROADCAST = "_KRM_BC";
c.KARMA_PREFIX_SYNC = "_KRM_SY";

local INFO_VERSION = "INFO_VERSION";
local INFO_LASTSYNC = "INFO_LASTSYNC";

local OPT_COMM = "OPT_COMM";
local OPT_NOTIFYRECEIVEBROADCAST = "OPT_NOTIFYRECEIVEBROADCAST";
local OPT_CACHEONSTARTUP = "OPT_CACHEONSTARTUP";
local OPT_COMMENTPREF = "OPT_COMMENTPREF";
local COMMENTPREF_ALL = "COMMENTPREF_ALL";
local COMMENTPREF_OWN = "COMMENTPREF_OWN";

local KARMA_VERSION = "1.12";
local KARMA_CHANNELNAME = "KarmarangBroadcast";
local KARMA_CHANNELPASSWORD = "KarmarangPassword";

local messageQueue = {};

local onlinePlayers = {};
local syncQueue = {}; -- player -> entries

-- init
function c:Init()
	c.charName = UnitName("player");

	KARMA_OPT = KARMA_OPT or {};
	KARMA_OPT[INFO_VERSION] = KARMA_OPT[INFO_VERSION] or KARMA_VERSION;
	KARMA_OPT[c.OPT_MAXLENGTH_TOOLTIP] = KARMA_OPT[c.OPT_MAXLENGTH_TOOLTIP] or 40;
	KARMA_OPT[OPT_COMM] = KARMA_OPT[OPT_COMM] or true;
	KARMA_OPT[OPT_NOTIFYRECEIVEBROADCAST] = KARMA_OPT[OPT_NOTIFYRECEIVEBROADCAST] or true;
	KARMA_OPT[OPT_CACHEONSTARTUP] = KARMA_OPT[OPT_CACHEONSTARTUP] or true;
	KARMA_OPT[OPT_COMMENTPREF] = KARMA_OPT[OPT_COMMENTPREF] or COMMENTPREF_ALL;

	if KARMA_OPT[INFO_VERSION] ~= KARMA_VERSION then
		c:KarmaUpdate();
	end

	c:PrepareDialogs();
	if KARMA_OPT[OPT_CACHEONSTARTUP] then
		c:ValidateDatabase();
	end

	if KARMA_OPT[OPT_COMM] then
		c:SetCommunication();
	else
		c:Println(c:GetText("Attention: You are not participating in Karma broadcasts. Type \"/karma comm\" to enable Karma broadcasts."));
	end

	c.initFinished = true;
	c:Println(c:GetText("AddOn loaded. Type /karma for options."));
end

function c:KarmaUpdate()
	-- for future use
	KARMA_OPT[INFO_VERSION] = KARMA_VERSION;
end

-- command handling
SLASH_KARMARANG1 = "/karma";
local CMD_CACHE = "cache";
local CMD_COMM = "comm";
local CMD_GETKARMA = "get";
local CMD_NOTIFYRECEIVEBROADCAST = "notify";
local CMD_PREF = "pref";
local CMD_RESET = "reset";

local CMD_ONLINEPLAYERS = "onlineplayers"; -- experimental, only for debugging

SlashCmdList["KARMARANG"] = function(msg)
	if msg then
		msg = c:Trim(msg);

		if msg == CMD_RESET then
			StaticPopup_Show(c.DIALOG_RESET);
			return;
		elseif msg == CMD_CACHE then
			KARMA_OPT[OPT_CACHEONSTARTUP] = not KARMA_OPT[OPT_CACHEONSTARTUP];
			c:Println(c:GetText("Database caching on startup: ") ..  c:BoolToYesNo(KARMA_OPT[OPT_CACHEONSTARTUP]));
			return;
		elseif msg == CMD_COMM then
			KARMA_OPT[OPT_COMM] = not KARMA_OPT[OPT_COMM];
			c:SetCommunication();
			return;
		elseif msg == CMD_NOTIFYRECEIVEBROADCAST then
			KARMA_OPT[OPT_NOTIFYRECEIVEBROADCAST] = not KARMA_OPT[OPT_NOTIFYRECEIVEBROADCAST];
			c:Println(c:GetText("Notifications about incoming Karmas: ") ..  c:BoolToYesNo(KARMA_OPT[OPT_NOTIFYRECEIVEBROADCAST]));
			return;
		elseif msg == CMD_PREF then
			if KARMA_OPT[OPT_COMMENTPREF] == COMMENTPREF_ALL then
				KARMA_OPT[OPT_COMMENTPREF] = COMMENTPREF_OWN;
				c:Println(c:GetText("Your own comments are preferred for tooltips."));
			else
				KARMA_OPT[OPT_COMMENTPREF] = COMMENTPREF_ALL;
				c:Println(c:GetText("Your own comments are NOT preferred for tooltips."));
			end
			return;
		elseif c:StartsWith(msg, CMD_GETKARMA) then
			msg = c:Trim(msg:gsub(CMD_GETKARMA, ""));
			local playerNames = c:SearchPlayers(msg);
			local count, noResults = 0, table.getn(playerNames);
			if noResults == 0 then
				c:Println(c:GetText("No players found for: \"%s\".", msg));
				return;
			end
			for _, playerName in ipairs(playerNames) do
				count = count + 1;
				local karma = c:GetKarma(playerName);
				c:Println("[" .. count .. "] " .. playerName .. ": " ..  c:FormatKarma(karma));

				if count == 10 then
					local additionalResults = noResults - count;
					if additionalResults > 0 then
						c:Println(c:GetText("... and %s more results.", additionalResults));
					end
					return;
				end
			end
			return;
		elseif msg == CMD_ONLINEPLAYERS then
			-- experimental, only for debugging
			c:Println("Online players: " .. c:GetTableSize(onlinePlayers));
			for playerName, loginDateTime in pairs(onlinePlayers) do
				c:Println(playerName);
			end
			return;
		end
	end

	c:Println(c:GetText("Unknown command. Possible parameters are: /karma ..."));
	c:Println(c:GetText("cache -> Toggles database caching on startup."));
	c:Println(c:GetText("comm -> Toggles Karma broadcasts (automatically joins the Karma_Broadcast channel if active)."));
	c:Println(c:GetText("get [text] -> Searches the database for player names containing [text]."));
	c:Println(c:GetText("notify -> Toggles whether or not you will be notified about received Karma broadcasts."));
	c:Println(c:GetText("pref -> Toggles whether your own comments are preferred for tooltips or not."));
	c:Println(c:GetText("reset -> Resets the Karmarang database."));
end

-- event handling
c.eventFrame = c.eventFrame or CreateFrame("Frame");
c.eventFrame:RegisterEvent("ADDON_LOADED");
c.eventFrame:RegisterEvent("PLAYER_LOGOUT");
c.eventFrame:RegisterEvent("CHAT_MSG_CHANNEL");

c.eventFrame:SetScript("OnEvent", function(self, event, msg, ...)
	if event then
		if event == "ADDON_LOADED" and msg == "Karmarang" and not c.initFinished then
			c:Init();
		elseif event == "CHANNEL_UI_UPDATE" then
			C_Timer.After(3, function() c:JoinChannel(); end);
		elseif event == "CHAT_MSG_CHANNEL" then
			if KARMA_OPT[OPT_COMM] then
				local channelNumber = c:GetChannelNumber();
				if channelNumber then
					local author, language, channelNameWithNumber, target, flags, zoneID, channelNo, channelName, lineID, guid = select(4, ...);
					if target == channelNumber then
						c:HandleMessage(msg);
					end
				end
			else
				c:SetCommunication();
			end
		elseif event == "PLAYER_LOGOUT" then
			local channelNumber = c:GetChannelNumber();
			if channelNumber then
				SendChatMessage(c.KARMA_PREFIX_BYE .. "_" .. c.charName, "CHANNEL", nil, channelNumber);
			end
		end
	end
end);

DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", function(self, link, string, button, ...)
	local linkType, arg1, arg2, arg3 = strsplit(":", link)
	if linkType == "player" and button == "LeftButton" and IsShiftKeyDown() then
		arg1 = c:RemoveRealmFromName(arg1);
		local karma = c:GetKarma(arg1);
		c:Println(arg1 .. ": " ..  c:FormatKarma(karma));
	end
end);

-- UI stuff
GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	local targetName, isPlayer = UnitName("mouseover"), UnitIsPlayer("mouseover");
	if targetName and isPlayer then
		GameTooltip:AddDoubleLine(c:GetText("Karma") .. ":", c:FormatKarma(c:GetKarma(targetName)));

		local maxLatestComments, latestComments = c.MAX_LATESTCOMMENTS, {};
		if KARMA_OPT[OPT_COMMENTPREF] == COMMENTPREF_OWN then
			-- prefer own comments
			for _, entry in ipairs(c:GetLatestComments(targetName, c.charName, maxLatestComments)) do
				table.insert(latestComments, entry);
			end
		end

		-- add others' comments
		local count = table.getn(latestComments);
		if count < maxLatestComments then
			for _, entry in ipairs(c:GetLatestComments(targetName, nil, maxLatestComments)) do
				if KARMA_OPT[OPT_COMMENTPREF] == COMMENTPREF_ALL or entry[c.ENTRY_AUTHOR] ~= c.charName then
					table.insert(latestComments, entry);
					count = count + 1;

					if count == maxLatestComments then
						break;
					end
				end
			end
		end

		for _, entry in ipairs(latestComments) do
			GameTooltip:AddLine(c:FormatComment(entry));
		end
	end
end);

hooksecurefunc("UnitPopup_ShowMenu", 
	function(self, level, target, name, userData)
		if UIDROPDOWNMENU_MENU_LEVEL == 1 then
			local targetedPlayer = UnitName("target");

			if target == "player" or (targetedPlayer and target and targetedPlayer == UnitName(target) and UnitIsPlayer("target")) then
				-- separator and default values
				local info = UIDropDownMenu_CreateInfo();
				info.notCheckable = true;
				info.notClickable = true;
				info.hasArrow = false;
				UIDropDownMenu_AddButton(info);

				-- title/header
				info.isTitle = true;
				info.text = c:GetText("Karma");
				UIDropDownMenu_AddButton(info);
				info.isTitle = false;

				if target == "player" or targetedPlayer == c.charName then
					-- own karma
					info.text = c:GetText("Your Karma: ") .. c:FormatKarma(c:GetKarma(c.charName));
					UIDropDownMenu_AddButton(info);

					-- add others' comments
					for _, entry in ipairs(c:GetLatestComments(c.charName)) do
						info.text = c:FormatComment(entry)
						UIDropDownMenu_AddButton(info);
					end
				elseif c:IsAllowed(targetedPlayer) then
					-- other players (allowed to set karma)
					info.notClickable = false;
					info.disabled = false;
					info.text = c:GetText("|cff00ff00Upvote and comment|r");
					info.func = function() c:ShowCommentDialog(targetedPlayer, 1); end
					UIDropDownMenu_AddButton(info);

					info.text = c:GetText("Neutral (comment only)");
					info.func = function() c:ShowCommentDialog(targetedPlayer, 0); end
					UIDropDownMenu_AddButton(info);

					info.text = c:GetText("|cffff0000Downvote and comment|r");
					info.func = function() c:ShowCommentDialog(targetedPlayer, -1); end
					UIDropDownMenu_AddButton(info);
				else
					-- other players (not allowed to set karma)
					info.notClickable = false;
					info.disabled = true;
					info.text = c:GetText("\"%s\" already received Karma today!", targetedPlayer);
					UIDropDownMenu_AddButton(info);
				end
			end
		end
	end);

-- core functions
function c:ShowCommentDialog(targetName, score)
	local text;
	if score == 1 then
		text = c:GetText("You are about to\n|cff00ff00UPVOTE|r\nthe player \"%s\".", targetName);
	elseif score == -1 then
		text = c:GetText("You are about to\n|cffff0000DOWNVOTE|r\nthe player \"%s\".", targetName);
	else
		text = c:GetText("You are about to rate the player \"%s\" neutrally.", targetName);
	end

	local dialog = StaticPopup_Show(c.DIALOG_COMMENT, text);
	if dialog then
		dialog.data = targetName;
		dialog.data2 = score;
	end
end

function c:IsAllowed(playerName, author)
	if not author then
		author = c.charName;
	end

	if KARMA_DB[playerName] and KARMA_DB[playerName][author] then
		for dateTime, entry in pairs(KARMA_DB[playerName][author]) do
			if c:GetDate(dateTime) == c:GetDate() then
				return false;
			end
		end
	end
	return true;
end

function c:AddKarma(targetName, karma, text)
	local entry = c:SetKarma(c.charName, targetName, karma, text);
	if entry and KARMA_OPT[OPT_COMM] then
		c:BroadcastKarma(entry);
	end
end

-- communication functions
function c:SetCommunication()
	if KARMA_OPT[OPT_COMM] then
		local channelNumber = c:GetChannelNumber();
		if not channelNumber then
			if (GetNumDisplayChannels() > 0) then
				C_Timer.After(3, function() c:JoinChannel(); end);
			else
				c.eventFrame:RegisterEvent("CHANNEL_UI_UPDATE");
			end
		else
			return channelNumber;
		end
	elseif c:GetChannelNumber() then
		c:LeaveChannel();
	end
end

function c:JoinChannel()
	if not c:GetChannelNumber() then
		c.eventFrame:UnregisterEvent("CHANNEL_UI_UPDATE");
		JoinTemporaryChannel(KARMA_CHANNELNAME, KARMA_CHANNELPASSWORD);

		local channelNumber = c:GetChannelNumber();
		if channelNumber then
			-- successful join
			c:Println(c:GetText("Broadcast channel joined. You are participating in Karma broadcasts."));
			SendChatMessage(c.KARMA_PREFIX_HELLO .. "_" .. c.charName, "CHANNEL", nil, channelNumber);
			while table.getn(messageQueue) > 0 do
				SendChatMessage(table.remove(messageQueue), "CHANNEL", nil, channelNumber);
			end
		else
			c:Println(c:GetText("Warning: Joining Karma broadcast channel failed."));
		end
	end
end

function c:LeaveChannel()
	local channelNumber = c:GetChannelNumber();
	if channelNumber then
		SendChatMessage(c.KARMA_PREFIX_BYE .. "_" .. c.charName, "CHANNEL", nil, channelNumber);
		LeaveChannelByName(KARMA_CHANNELNAME);
		c:Println(c:GetText("Broadcast channel left. You are no longer participating in Karma broadcasts."));
	end
end

function c:GetChannelNumber()
	local id, name = GetChannelName(KARMA_CHANNELNAME);
	if id > 0 then
		return id;
	end
end

function c:HandleMessage(msg)
	if msg then
		if c:StartsWith(msg, c.KARMA_PREFIX_HELLO) then
			local isValid, playerName = c:DecodeMessage(msg);
			if isValid then
				onlinePlayers[playerName] = c:GetDateTime();
			end
			-- todo: prepare sync
		elseif c:StartsWith(msg, c.KARMA_PREFIX_BYE) then
			local isValid, playerName = c:DecodeMessage(msg);
			if isValid then
				onlinePlayers[playerName] = nil;
				syncQueue[playerName] = nil;
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_BROADCAST) then
			local isValid, dateTime, author, playerName, karma, comment = c:DecodeMessage(msg);
			if isValid and author ~= c.charName then
				c:SetKarma(author, playerName, karma, comment, dateTime);
				if KARMA_OPT[OPT_NOTIFYRECEIVEBROADCAST] then
					c:Println(c:GetText("Received Karma broadcast from \"%s\".", author));
				end
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNC) then
			local isValid, dateTime, author, playerName, karma, comment = c:DecodeMessage(msg);
			if isValid then
				c:SetKarma(author, playerName, karma, comment, dateTime);
				-- todo: remove from sync todo
			end
		end
	end
end

function c:DecodeMessage(msg)
	if c:StartsWith(msg, c.KARMA_PREFIX_HELLO) then
		local playerName = msg:gsub(c.KARMA_PREFIX_HELLO, "");
		return playerName and playerName ~= "", playerName; -- isValid, playerName
	elseif c:StartsWith(msg, c.KARMA_PREFIX_BYE) then
		local playerName = msg:gsub(c.KARMA_PREFIX_BYE, "");
		return playerName and playerName ~= "", playerName; -- isValid, playerName
	elseif c:StartsWith(msg, c.KARMA_PREFIX_BROADCAST) then
		msg = msg:gsub(c.KARMA_PREFIX_BROADCAST, "");
		local payload = c:Split(msg, "_");
		if payload and table.getn(payload) then
			return true, payload[1], payload[2], payload[3], payload[4], payload[5]; -- isValid, dateTime, author, playerName, karma, comment
		end
	elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNC) then
		msg = msg:gsub(c.KARMA_PREFIX_SYNC, "");
		local payload = c:Split(msg, "_");
		if payload and table.getn(payload) then
			return true, payload[1], payload[2], payload[3], payload[4], payload[5]; -- isValid, dateTime, author, playerName, karma, comment
		end
	end
	return false;
end

function c:BroadcastKarma(entry)
	local channelNumber, msg = c:SetCommunication(), c:PrepareBroadcastMessage(entry);
	if msg and msg ~= "" then
		if channelNumber then
			SendChatMessage(msg, "CHANNEL", nil, c:GetChannelNumber());
		else
			table.insert(messageQueue, msg);
			c:ToggleCommunication();
		end
	end
end