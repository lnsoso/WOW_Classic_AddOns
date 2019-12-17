----- scope stuff -----
karmarang = karmarang or {};
local c = karmarang;

----- variables -----
c.KARMA_VERSION = "1.15";

c.MAX_LATESTCOMMENTS = 3;
c.MAX_KARMATIMEOUT = 30;
c.MAX_KARMACOOLDOWN = 120;
c.COMMENT_MAXLENGTH = 120;
c.OPT_MAXLENGTH_TOOLTIP = "OPT_MAXLENGTH_TOOLTIP";

--c.KARMA_SCALE_BASE = 0.5;
c.KARMA_SCALE_OTHERS = 1;
c.KARMA_SCALE_SELF = 1;

c.KARMA_PREFIX_HELLO = "_KRM_HE_";
c.KARMA_PREFIX_HANDSHAKE = "_KRM_HS_";
c.KARMA_PREFIX_BYE = "_KRM_BY_";
c.KARMA_PREFIX_BROADCAST = "_KRM_BC_";

c.KARMA_PREFIX_SYNCREQUEST = "_KRM_RQ_";
c.KARMA_PREFIX_SYNCPREPARED = "_KRM_SP_";
c.KARMA_PREFIX_SYNCDATA = "_KRM_SD_";
c.KARMA_PREFIX_SYNCFINISHED = "_KRM_SF_";

c.INFO_VERSION = "INFO_VERSION";
local INFO_HASHTAG = "INFO_HASHTAG";
local INFO_LASTSYNC = "INFO_LASTSYNC";

local OPT_COMM = "OPT_COMM";
local OPT_SYNCONSTARTUP = "OPT_SYNCONSTARTUP";
local OPT_COMMENTPREF = "OPT_COMMENTPREF";
local COMMENTPREF_ALL = "COMMENTPREF_ALL";
local COMMENTPREF_OWN = "COMMENTPREF_OWN";

local KARMA_CHANNELNAME = "KarmarangBroadcast";
local KARMA_CHANNELPASSWORD = "KarmarangPassword";

local DENIED_COOLDOWN = "DENIED_COOLDOWN";
local DENIED_FORBIDDEN = "DENIED_FORBIDDEN";

local PRIO_ALERT = "ALERT";
local PRIO_NORMAL = "NORMAL";
local PRIO_BULK = "BULK";

local TAG_MENU_KARMARANG = "TAG_MENU_KARMARANG";
local TAG_MENU_UPDATE_COOLDOWN = "TAG_MENU_UPDATE_COOLDOWN";
local TAG_MENU_UPDATE_TIMEOUT = "TAG_MENU_UPDATE_TIMEOUT";

local newVersionNotified = c.KARMA_VERSION;
local messageQueue = {};

local onlinePlayers = {};
local syncTable = {}; -- [#]requesterTable -> [#]responderTable -> entries (key: timeStamp_authorTag_playerName)

local raidMembers;

----- init and versioning -----
function c:Init()
	local bnetName = c:GetBattleNetTag();
	if bnetName then
		c.hashTag = tostring(c:StringHash(bnetName));

		KARMA_OPT = KARMA_OPT or {};
		KARMA_OPT["dev"] = nil;
		KARMA_OPT[INFO_HASHTAG] = KARMA_OPT[INFO_HASHTAG] or c.hashTag;

		if KARMA_OPT[INFO_HASHTAG] == c.hashTag then
			KARMA_OPT[c.OPT_MAXLENGTH_TOOLTIP] = KARMA_OPT[c.OPT_MAXLENGTH_TOOLTIP] or 40;
			KARMA_OPT[OPT_COMMENTPREF] = KARMA_OPT[OPT_COMMENTPREF] or COMMENTPREF_ALL;
			KARMA_OPT[c.INFO_VERSION] = KARMA_OPT[c.INFO_VERSION] or c.KARMA_VERSION;

			if KARMA_OPT[OPT_SYNCONSTARTUP] == nil then
				KARMA_OPT[OPT_SYNCONSTARTUP] = true;
			end
			if KARMA_OPT[OPT_COMM] == nil then
				KARMA_OPT[OPT_COMM] = true;
			end

			c.charName = UnitName("player");
			c.realmName = GetRealmName();

			if c:IsVersionAbove() then
				c:KarmaUpdate();
			end

			c:PrepareDialogs();

			c:RealmDataSetInit();
			c:ValidateDatabase();

			c:CleanUpRecentPlayers();
			c.eventFrame:RegisterEvent("PLAYER_LOGOUT");
			c.eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
			c.eventFrame:RegisterEvent("RAID_ROSTER_UPDATE");
			c.eventFrame:RegisterEvent("CHANNEL_UI_UPDATE");

			c.initFinished = true;
			c:Println(c:GetText("AddOn loaded: Version %s. Type /karma for options.", c.KARMA_VERSION));
			c:Println(c:GetText("For updates, additional information and current Karma rules, visit \"https://www.curseforge.com/wow/addons/karmarang\"."));
		else
			c:Println(c:GetText("Error: BNet Tag hash mismatch. Type \"/karma defaults\" to reset Karmarang to defaults."));
		end
	else
		c:Println(c:GetText("Warning: You are not connected to the BNet Service. Karmarang initialization aborted."));
	end
end

function c:Start()
	if not c.initFailed then
		if not c.initFinished then
			C_Timer.After(1, function() c:Start(); end); -- try again
		else
			if KARMA_OPT[OPT_COMM] then
				if not c.channelUiUpdated then
					C_Timer.After(1, function() c:Start(); end); -- try again
				else
					if not c:GetChannelNumber() then
						c:JoinChannel();
						C_Timer.After(1, function() c:Start(); end); -- try again
					else
						c:SendMessage(PRIO_ALERT, c.KARMA_PREFIX_HELLO .. c.charName .. "_" .. c.hashTag .. "_" .. c.KARMA_VERSION);

						if KARMA_OPT[OPT_SYNCONSTARTUP] then
							-- lastsync abchecken. nur ein mal am tag
							-- prepare sync as a requester (delayed)
							--C_Timer.After(15, function() c:RequestSync(); end);
						end
					end
				end
			else
				c:Println(c:GetText("Attention: You are not participating in Karma broadcasts. Type \"/karma comm\" to enable Karma broadcasts."));
			end
		end
	end
end

function c:KarmaUpdate()
	if c:IsVersionAbove("1.12") then -- 1.13 update
		c:Println(c:GetText("Karmarang is running on a new version. Some changes to your database need to be performed. Please wait..."));
		-- realm-subset upgrade
		local tmp = c:Deepcopy(KARMA_DB);
		KARMA_DB = {};
		KARMA_DB[c.realmName] = tmp;

		-- convert dates to timestamps, remove cache
		for playerName, playerEntry in pairs(KARMA_DB[c.realmName]) do
			local newPlayerEntry = {};
			for author, authorEntry in pairs(playerEntry) do
				if author ~= "CACHE_LATESTCOMMENTS" then
					local newAuthorEntry = {};
					for dateTime, entry in pairs(authorEntry) do
						if author ~= "CACHE_LATESTCOMMENTS" then
							local newEntry, timeStamp = {}, c:GetTimestamp(dateTime);
							if timeStamp then
								newEntry[c.ENTRY_TIMESTAMP] = timeStamp;
								newEntry[c.ENTRY_AUTHOR] = author;
								newEntry[c.ENTRY_PLAYERNAME] = playerName;
								newEntry[c.ENTRY_KARMA] = entry[c.ENTRY_KARMA];
								newEntry[c.ENTRY_COMMENT] = entry[c.ENTRY_COMMENT];
								newAuthorEntry[timeStamp] = newEntry;
							end
						end
					end
					newPlayerEntry[author] = newAuthorEntry;
				end
			end
			KARMA_DB[c.realmName][playerName] = newPlayerEntry;
		end
	end

	KARMA_OPT[c.INFO_VERSION] = c.KARMA_VERSION;
	c:Println(c:GetText("Karmarang version update complete. Current version: %s", c.KARMA_VERSION));
end

function c:NotifyNewVersion(version)
	c:Println(c:GetText("Another player is using a newer Karmarang version than you: %s. Please visit \"https://www.curseforge.com/wow/addons/karmarang\" to update.", version));
	newVersionNotified = version;
end

----- battle net -----
function c:GetBattleNetTag()
	if BNConnected() then
		local presenceID, toonID, currentBroadcast, bnetAFK, bnetDND = BNGetInfo();
		return toonID;
	end
end

----- command handling -----
SLASH_KARMARANG1 = "/karma";
local CMD_SYNCONSTART = "synconstart";
local CMD_COMM = "comm";
local CMD_DEFAULTS = "defaults";
local CMD_GETKARMA = "get";
local CMD_PREF = "pref";
local CMD_RESETALL = "resetall";
local CMD_RESETREALM = "resetrealm";
local CMD_SYNC = "sync";

local CMD_ONLINEPLAYERS = "onlineplayers"; -- experimental, only for debugging

SlashCmdList["KARMARANG"] = function(msg)
	if msg then
		if c.initFinished then
			msg = c:Trim(msg);

			if msg == CMD_DEFAULTS then
				local dialog = StaticPopup_Show(c.DIALOG_RESET, c:GetText("This will reset Karmarang completely (database and settings). \n\nAre you sure?"));
				if dialog then
					dialog.data = CMD_DEFAULTS;
				end
				return;
			elseif msg == CMD_RESETALL then
				local dialog = StaticPopup_Show(c.DIALOG_RESET, c:GetText("This will reset the Karmarang database (all realms).\n\nAre you sure?"));
				if dialog then
					dialog.data = CMD_RESETALL;
				end
				return;
			elseif msg == CMD_RESETREALM then
				local dialog = StaticPopup_Show(c.DIALOG_RESET, c:GetText("This will reset the Karmarang database (current realm only).\n\nAre you sure?"));
				if dialog then
					dialog.data = CMD_RESETREALM;
				end
				return;
			elseif msg == CMD_SYNCONSTART then
				--KARMA_OPT[OPT_SYNCONSTARTUP] = not KARMA_OPT[OPT_SYNCONSTARTUP];
				--c:Println(c:GetText("Database synchronization on startup: ") ..  c:BoolToYesNo(KARMA_OPT[OPT_SYNCONSTARTUP]));
				--return;
			elseif msg == CMD_COMM then
				KARMA_OPT[OPT_COMM] = not KARMA_OPT[OPT_COMM];
				if KARMA_OPT[OPT_COMM] then
					c:JoinChannel();
				else
					c:LeaveChannel();
				end
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
					c:Println("[" .. count .. "] " .. playerName .. ": " ..  c:FormatKarma(c:GetDisplayKarma(playerName)));

					if count == 10 then
						local additionalResults = noResults - count;
						if additionalResults > 0 then
							c:Println(c:GetText("... and %s more results.", additionalResults));
						end
						return;
					end
				end
				return;
			elseif msg == CMD_SYNC then
				if KARMA_OPT[OPT_COMM] then
					--c:RequestSync();
				else
					-- todo: message
				end				
				--return;

			-- dev commands, only for debugging
			elseif msg == "dev" then
				KARMA_OPT["dev"] = true;
				return;
			elseif msg == "onlineplayers" then
				c:Println("Online players: " .. c:GetTableSize(onlinePlayers));
				for playerName, data in pairs(onlinePlayers) do
					c:Println(playerName .. " (" .. data[c.ENTRY_VERSION] .. ")");
				end
				return;
			end

			c:Println(c:GetText("Unknown command. Possible parameters are: /karma ..."));
			c:Println(c:GetText("comm -> Toggles Karma broadcasts (automatically joins the Karma_Broadcast channel if active)."));
			c:Println(c:GetText("defaults -> Resets Karmarang to defaults."));
			c:Println(c:GetText("get [text] -> Searches the database for player names containing [text]."));
			c:Println(c:GetText("pref -> Toggles whether your own comments are preferred for tooltips or not."));
			c:Println(c:GetText("resetall -> Resets Karmarang to default values (database and settings)."));
			c:Println(c:GetText("resetrealm -> Resets the Karmarang database."));
			c:Println(c:GetText("sync -> Sends a synchronization request to other Karmarang users."));
			--c:Println(c:GetText("synconstart -> Toggles database synchronization on startup."));
		else
			c:Println(c:GetText("The AddOn has not been initialized due to an error. Please relog and try again."));
		end
	end
end

function c:Reset(command)
	if not c:IsSyncPending() then
		if command == CMD_DEFAULTS then
			KARMA_OPT = nil;
			c:ResetDatabase();
			c:Println(c:GetText("Karmarang has been reset to defaults. AddOn will be re-initialized..."));
			c:Init();
		elseif command == CMD_RESETALL then
			c:ResetDatabase();
		elseif command == CMD_RESETREALM then
			c:ResetDatabase(c.realmName);
		end
	else
		c:Println(c:GetText("Karmarang cannot be reset while synchronization is pending. Please try again once progress is finished."));
	end
end

----- event handling -----
c.eventFrame = c.eventFrame or CreateFrame("Frame");
c.eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
c.eventFrame:RegisterEvent("ADDON_LOADED");
c.eventFrame:SetScript("OnEvent", function(self, event, msg, ...)
	if event then
		if event == "ADDON_LOADED" and msg == "Karmarang" and not c.initFinished then
			c:Init();
		elseif event == "PLAYER_ENTERING_WORLD" then
			c:Start();
		elseif event == "CHANNEL_UI_UPDATE" and c.initFinished then
			c.eventFrame:UnregisterEvent("CHANNEL_UI_UPDATE");
			C_Timer.After(3, function()
				c.channelUiUpdated = true; -- 3 secs after the first channel has been joined
			end);
		elseif event == "CHAT_MSG_CHANNEL" and c.initFinished and KARMA_OPT[OPT_COMM] then
			local channelNumber = c:GetChannelNumber();
			if channelNumber then
				local author, language, channelNameWithNumber, target, flags, zoneID, channelNo, channelName, lineID, guid = select(4, ...);
				if target == channelNumber then
					c:HandleMessage(msg);
				end
			end
		elseif event == "PLAYER_LOGOUT" and c.initFinished then
			c:SetRecentPlayers(c:GetRaidMembers()[0]);
			if KARMA_OPT[OPT_COMM] then
				local channelNumber = c:GetChannelNumber();
				if channelNumber then
					c:SendMessage(PRIO_ALERT, c.KARMA_PREFIX_BYE .. c.hashTag);
				end
			end
		elseif event == "GROUP_ROSTER_UPDATE" or event == "RAID_ROSTER_UPDATE" then
			c:SetRecentPlayers(c:GetRaidMembers()[0]);
			raidMembers = nil;
		end
	end
end);

----- UI stuff -----
DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", function(self, link, string, button, ...)
	if c.initFinished then
		local linkType, arg1, arg2, arg3 = strsplit(":", link)
		if linkType == "player" and button == "LeftButton" and IsShiftKeyDown() then
			arg1 = c:RemoveRealmFromName(arg1);
			c:Println(arg1 .. ": " ..  c:FormatKarma(c:GetDisplayKarma(arg1)));
		end
	end
end);

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	if c.initFinished then
		local targetName, isPlayerFrame = c:GetPlayerNameFromUnitFrame(GetMouseFocus());
		targetName = targetName or UnitName("mouseover");
		local isPlayer = isPlayerFrame or UnitIsPlayer("mouseover");

		if targetName and isPlayer then
			GameTooltip:AddDoubleLine(c:GetText("Karma") .. ":", c:FormatKarma(c:GetDisplayKarma(targetName)));

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
					if KARMA_OPT[OPT_COMMENTPREF] == COMMENTPREF_ALL or entry[c.ENTRY_AUTHOR] ~= c.hashTag or entry[c.ENTRY_AUTHOR] ~= c.charName then -- charname backwards compatibility, might be removed some time in the future
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
	end
end);

hooksecurefunc("UnitPopup_ShowMenu", 
	function(self, level, target, name, userData)
		if c.initFinished and UIDROPDOWNMENU_MENU_LEVEL == 1 then
			--level PARTY, target partyn
			if c:KarmaApplies(level, name) then
				local targetedPlayer = name or UnitName(target) or UnitName("target");
				targetedPlayer = c:RemoveRealmFromName(targetedPlayer);

				-- refresh recentplayers
				c:SetRecentPlayers(c:GetRaidMembers()[0]);
				raidMembers = nil;

				-- separator and default values
				local info = UIDropDownMenu_CreateInfo();
				info.notCheckable = true;
				info.notClickable = true;
				info.hasArrow = false;
				info.value = TAG_MENU_KARMARANG;
				UIDropDownMenu_AddButton(info);

				-- title/header
				info.isTitle = true;
				info.text = c:GetText("Karma");
				UIDropDownMenu_AddButton(info);
				info.isTitle = false;

				if target == "player" or targetedPlayer == c.charName then
					-- own karma
					info.text = c:GetText("Your Karma: ") .. c:FormatKarma(c:GetDisplayKarma(c.charName));
					UIDropDownMenu_AddButton(info);

					-- add others' comments
					for _, entry in ipairs(c:GetLatestComments(c.charName)) do
						info.text = c:FormatComment(entry)
						UIDropDownMenu_AddButton(info);
					end
				else
					local reason, timeLeft = c:KarmaDenied(targetedPlayer);
					if not reason then
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

						if c:PlayerIsRecentMember(targetedPlayer) and not c:PlayerIsMember(targetedPlayer) then
							info.notClickable = false;
							info.disabled = true;
							info.value = TAG_MENU_UPDATE_TIMEOUT;
							info.arg1 = targetedPlayer;
							info.text = c:GetText("Time left: %s", c:FormatTimeStamp(c:GetRemainingKarmaTimeout(targetedPlayer)));
							UIDropDownMenu_AddButton(info);
						end
					elseif reason == DENIED_COOLDOWN then
						info.notClickable = false;
						info.disabled = true;
						info.arg1 = targetedPlayer;
						info.text = c:GetText("\"%s\" recently received Karma!", targetedPlayer);
						UIDropDownMenu_AddButton(info);

						info.value = TAG_MENU_UPDATE_COOLDOWN;
						info.text = c:GetText("Cooldown: %s", c:FormatTimeStamp(timeLeft));
						UIDropDownMenu_AddButton(info);
					elseif reason == DENIED_FORBIDDEN then
						info.notClickable = false;
						info.disabled = true;
						info.text = c:GetText("You are not allowed to send Karma to \"%s\".", targetedPlayer);
						UIDropDownMenu_AddButton(info);
					end
				end
			end
		end

		-- live timers
		local n = 1;
		while _G["DropDownList1Button" .. n] do
			if _G["DropDownList1Button" .. n].value == TAG_MENU_UPDATE_TIMEOUT then
				_G["DropDownList1Button" .. n]:SetScript("OnUpdate", function(self, elapsed)
					self.TimeSinceLastUpdate = self.TimeSinceLastUpdate or 0;
					self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
					if (self.TimeSinceLastUpdate > 1) then
						local timeout = c:GetRemainingKarmaTimeout(self.arg1);
						if timeout and timeout > 0 then
							self:SetText(c:GetText("Time left: %s", c:FormatTimeStamp(timeout)));
						else
							self:SetScript("OnUpdate", nil);
							self:GetParent():Hide();
						end						
						self.TimeSinceLastUpdate = 0;
					end
				end);
			elseif _G["DropDownList1Button" .. n].value == TAG_MENU_UPDATE_COOLDOWN then
				_G["DropDownList1Button" .. n]:SetScript("OnUpdate", function(self, elapsed)
					self.TimeSinceLastUpdate = self.TimeSinceLastUpdate or 0;
					self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
					if (self.TimeSinceLastUpdate > 1) then
						local coolDown = c:GetRemainingKarmaCooldown(self.arg1);
						if coolDown > 0 then
							self:SetText(c:GetText("Cooldown: %s", c:FormatTimeStamp(coolDown)));
						else
							self:SetScript("OnUpdate", nil);
							self:GetParent():Hide();
						end
						self.TimeSinceLastUpdate = 0;
					end
				end);
			elseif _G["DropDownList1Button" .. n].value == TAG_MENU_KARMARANG then
				_G["DropDownList1Button" .. n]:SetScript("OnUpdate", nil);
			end
			n = n + 1;
		end
	end);

function c:GetPlayerNameFromUnitFrame(unitFrame)
	if unitFrame then
		local frameName = unitFrame:GetName();
		if c:StartsWith(frameName, "PartyMemberFrame") then
			-- party frames
			frameName = frameName:gsub("PartyMemberFrame", "");
			local playerName = UnitName("party".. frameName);
			return playerName, true;
		elseif c:StartsWith(frameName, "CompactRaidGroup") then
			-- compactraidgroup
			frameName = frameName:gsub("CompactRaidGroup", "");
			frameName = frameName:gsub("Member", "");
			if strlen(frameName) == 2 then
				local subGroupId, playerInSubGroupId = tonumber(string.sub(frameName, 1, 1)), tonumber(string.sub(frameName, 2, 2));
				if c:GetRaidMembers()[subGroupId] then
					local playerName = c:GetRaidMembers()[subGroupId][playerInSubGroupId];
					return playerName, true;
				end
			end
		elseif c:StartsWith(frameName, "CompactRaidFrame") then
			-- compactraidframe
			frameName = frameName:gsub("CompactRaidFrame", "");
			local playerName = UnitName("raid".. frameName);
			return playerName, true;
		elseif c:StartsWith(frameName, "RaidPullout") then
			-- pulloutgroup
			frameName = frameName:gsub("RaidPullout", "");
			frameName = frameName:gsub("ClearButton", "");
			frameName = frameName:gsub("Button", "");
			if strlen(frameName) == 2 then
				local subGroupId, playerInSubGroupId = tonumber(string.sub(frameName, 1, 1)), tonumber(string.sub(frameName, 2, 2));
				if c:GetRaidMembers()[subGroupId] then
					local playerName = c:GetRaidMembers()[subGroupId][playerInSubGroupId];
					return playerName, true;
				end
			end
		end
	end
end

----- core functions -----
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

function c:GetRaidMembers()
	if not raidMembers then
		raidMembers = {};
		raidMembers[0] = {};
		local noRaidMembers = GetNumGroupMembers();

		if noRaidMembers then
			for n = 1, noRaidMembers do
				local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(n);

				-- table of all raid members by id
				raidMembers[0][n] = name;

				-- table of all raid members, mapped by subgroups
				raidMembers[subgroup] = raidMembers[subgroup] or {};
				local subGroupId = table.getn(raidMembers[subgroup]) + 1;
				raidMembers[subgroup][subGroupId] = name;

				n = n + 1;
			end
		end
	end
	return raidMembers;
end

function c:KarmaApplies(level, name)
	return level == "SELF" or level == "PARTY" or level == "RAID" or level == "PLAYER" or (level == "TARGET" and UnitIsPlayer("target")) or (level ~= "TARGET" and name);
end

function c:KarmaDenied(playerName, author)
	author = author or c.hashTag;

	if KARMA_OPT["dev"] then
		return;
	end

	local coolDown = c:HasCooldownOnPlayer(playerName, author);
	if coolDown then
		return DENIED_COOLDOWN, coolDown; -- reason, timeLeft
	end

	if not c:PlayerIsTarget(playerName) and not c:PlayerIsMember(playerName) and not c:PlayerIsRecentMember(playerName) then
		return DENIED_FORBIDDEN;
	end
end

function c:HasCooldownOnPlayer(playerName, author)
	author = author or c.hashTag;
	return c:GetRemainingKarmaCooldown(playerName, author);
end

function c:PlayerIsTarget(playerName)
	return UnitName("target") and UnitIsPlayer("target") and playerName and playerName == UnitName("target");
end

function c:PlayerIsMember(playerName)
	return playerName and c:TableContainsValue(c:GetRaidMembers()[0], playerName);
end

function c:PlayerIsRecentMember(playerName)
	return c:GetRemainingKarmaTimeout(playerName);
end

function c:AddKarma(targetName, karma, text)
	local targetEntry = c:SetKarma(c.hashTag, targetName, karma, text);
	local selfEntry = c:SetKarma(c.hashTag, c.charName, karma * 0.1);
	if targetEntry and selfEntry and KARMA_OPT[OPT_COMM] then
		c:BroadcastKarma(targetEntry);
		c:BroadcastKarma(selfEntry);
	end
end

-- communication functions
function c:JoinChannel()
	local channelNumber = c:GetChannelNumber();
	if not channelNumber then
		JoinTemporaryChannel(KARMA_CHANNELNAME, KARMA_CHANNELPASSWORD);

		channelNumber = c:GetChannelNumber();
		if channelNumber then
			c.eventFrame:RegisterEvent("CHAT_MSG_CHANNEL");

			-- successful join
			c:Println(c:GetText("Broadcast channel joined. You are participating in Karma broadcasts."));

			-- send queued messages (if any)
			while table.getn(messageQueue) > 0 do
				local entry = table.remove(messageQueue, 1);
				c:SendMessage(entry["priority"], entry["message"]);
			end
		else
			c:Println(c:GetText("Warning: Joining Karma broadcast channel failed."));
		end
	end
end

function c:LeaveChannel()
	local channelNumber = c:GetChannelNumber();
	if channelNumber then
		c:SendMessage(PRIO_ALERT, c.KARMA_PREFIX_BYE .. c.charName);
		LeaveChannelByName(KARMA_CHANNELNAME);
		c.eventFrame:UnregisterEvent("CHAT_MSG_CHANNEL");
		c:Println(c:GetText("Broadcast channel left. You are no longer participating in Karma broadcasts."));
	end
end

function c:GetChannelNumber()
	local id, name = GetChannelName(KARMA_CHANNELNAME);
	if id > 0 then
		return id;
	end
end

function c:SendMessage(priority, message)
	local channelNumber = c:GetChannelNumber();
	if not channelNumber then
		 if priority and message then
			local newEntry = {};
			newEntry["priority"] = priority;
			newEntry["message"] = message;
			table.insert(messageQueue, newEntry);
		 end

		 C_Timer.After(3, function() c:SendMessage(); end); -- timeout after channel join
	elseif priority and message then
		ChatThrottleLib:SendChatMessage(priority, "Karmarang", message, "CHANNEL", nil, channelNumber);
	end
end

function c:HandleMessage(msg)
	if msg then
		if c:StartsWith(msg, c.KARMA_PREFIX_HELLO) then
			local isValid, playerName, playerHashTag, playerVersion = c:DecodeMessage(msg);
			if isValid then -- and playerName ~= c.charName then
				c:AddOnlinePlayer(playerName, playerHashTag, playerVersion);
				local channelNumber = c:GetChannelNumber();
				if channelNumber then
					-- respond to hello
					--c:SendMessage(PRIO_NORMAL, c.KARMA_PREFIX_HANDSHAKE .. c.charName .. "_" .. c.hashTag .. "_" .. c.KARMA_VERSION);
				end

				if c:IsVersionBelow(playerVersion, newVersionNotified) then
					c:NotifyNewVersion(playerVersion);
				end
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_HANDSHAKE) then
			local isValid, playerName, playerHashTag, playerVersion = c:DecodeMessage(msg);
			if isValid and playerName ~= c.charName then
				c:AddOnlinePlayer(playerName, playerHashTag, playerVersion);
			end

			if c:IsVersionBelow(playerVersion, newVersionNotified) then
				c:NotifyNewVersion(playerVersion);
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_BYE) then
			local isValid, playerName = c:DecodeMessage(msg);
			if isValid and playerName ~= c.charName then
				onlinePlayers[playerName] = nil;
				c:NextResponder(playerName);
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_BROADCAST) then
			local isValid, timeStamp, author, playerName, karma, comment = c:DecodeMessage(msg);
			if isValid and author ~= c.hashTag and author ~= c.charName then  -- charname backwards compatibility, might be removed some time in the future
				c:SetKarma(author, playerName, karma, comment, timeStamp);
				if KARMA_OPT["dev"] then
					c:Println(c:GetText("Received Karma broadcast for \"%s\".", playerName));
				end
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNCREQUEST) then
			local isValid, playerName = c:DecodeMessage(msg);
			if isValid then
				-- prepare sync as a responder
				--c:PrepareSync(playerName);
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNCPREPARED) then
			local isValid, playerName = c:DecodeMessage(msg);
			if isValid then
				
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNCDATA) then
			local isValid, timeStamp, author, playerName, karma, comment = c:DecodeMessage(msg);
			if isValid then
				c:SetKarma(author, playerName, karma, comment, timeStamp);
				-- todo: remove from sync todo
			end
		elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNCFINISHED) then
			local isValid, playerName, requester = c:DecodeMessage(msg);
			if isValid then
				--c:NextResponder(playerName, requester);
			end
		end
	end
end

function c:DecodeMessage(msg)
	if c:StartsWith(msg, c.KARMA_PREFIX_HELLO) then
		msg = msg:gsub(c.KARMA_PREFIX_HELLO, "");
		local playerName, playerHashTag, playerVersion = unpack(c:Split(msg, "_"));
		return playerName and playerName ~= "" and playerHashTag and playerHashTag ~= "" and playerVersion and playerVersion ~= "", playerName, playerHashTag, playerVersion; -- isValid, playerName, playerHashTag, playerVersion
	elseif c:StartsWith(msg, c.KARMA_PREFIX_HANDSHAKE) then
		msg = msg:gsub(c.KARMA_PREFIX_HANDSHAKE, "");
		local playerName, playerHashTag, playerVersion = unpack(c:Split(msg, "_"));
		return playerName and playerName ~= "" and playerHashTag and playerHashTag ~= "" and playerVersion and playerVersion ~= "", playerName, playerHashTag, playerVersion; -- isValid, playerName, playerHashTag, playerVersion
	elseif c:StartsWith(msg, c.KARMA_PREFIX_BYE) then
		local playerName = msg:gsub(c.KARMA_PREFIX_BYE, "");
		return playerName and playerName ~= "", playerName; -- isValid, playerName
	elseif c:StartsWith(msg, c.KARMA_PREFIX_BROADCAST) then
		msg = msg:gsub(c.KARMA_PREFIX_BROADCAST, "");
		local payload = c:Split(msg, "_");
		if payload and table.getn(payload) == 5 then
			return true, unpack(payload); -- isValid, timeStamp, author, playerName, karma, comment
		end
	elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNCREQUEST) then
		local playerName = msg:gsub(c.KARMA_PREFIX_SYNCREQUEST, "");
		return playerName and playerName ~= "", playerName; -- isValid, playerName
	elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNCPREPARED) then
		local playerName = msg:gsub(c.KARMA_PREFIX_SYNCPREPARED, "");
		return playerName and playerName ~= "", playerName; -- isValid, playerName
	elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNCDATA) then
		msg = msg:gsub(c.KARMA_PREFIX_SYNCDATA, "");
		local payload = c:Split(msg, "_");
		if payload and table.getn(payload) == 5 then
			return true, unpack(payload); -- isValid, timeStamp, author, playerName, karma, comment
		end
	elseif c:StartsWith(msg, c.KARMA_PREFIX_SYNCFINISHED) then
		msg = msg:gsub(c.KARMA_PREFIX_SYNCFINISHED, "");
		local playerName, requester = unpack(c:Split(msg, "_"));
		return playerName and playerName ~= "" and requester and requester ~= "", playerName, requester;
	end
	return false;
end

function c:BroadcastKarma(entry)
	local msg = c:PrepareBroadcastMessage(entry);
	if msg and msg ~= "" then
		c:SendMessage(PRIO_NORMAL, msg);
	end
end

----- synchronization functions ----- (STILL IN DEVELOPMENT)
function c:AddOnlinePlayer(playerName, playerHashTag, playerVersion)
	-- add player
	local playerEntry = {};
	playerEntry[c.ENTRY_HASHTAG] = playerHashTag;
	playerEntry[c.ENTRY_PLAYERNAME] = playerName;
	playerEntry[c.ENTRY_TIMESTAMP] = c:GetTimestamp();
	playerEntry[c.ENTRY_VERSION] = playerVersion;
	onlinePlayers[playerName] = playerEntry;

	-- sort list
	local tmp = {};
	for _, key in ipairs(c:GetSortedTableKeys(onlinePlayers)) do
		tmp[key] = onlinePlayers[key];
	end
	onlinePlayers = tmp;

	-- add to aux database
	c:AddPlayerInfo(playerEntry);

	if KARMA_OPT["dev"] then
		c:Println(c:GetText("Player came online: %s", playerName));
	end
end

function c:IsSyncPending()
	return c:GetRequester(c.charName);
end

function c:RequestSync()
	if not c:IsSyncPending() then
		local channelNumber = c:SetCommunication();
		if channelNumber then
			c:PrepareSync(); -- prepare sync as requester
			c:SendMessage(PRIO_NORMAL, c.KARMA_PREFIX_SYNCREQUEST .. c.charName);
			c:Println(c:GetText("Synchronization request sent. This can take a few moments..."));
			return true;
		else
			c:Println(c:GetText("Error: Synchronization request could not be sent."));
		end
	else
		c:Println(c:GetText("Synchronization is still in progress. You cannot send another request until it is finished."));
	end
end

function c:GetRequester(playerName)
	for _, table in ipairs(syncTable) do
		if table[c.ENTRY_PLAYERNAME] == playerName then
			return table[c.ENTRY_PLAYERNAME];
		end
	end
	return false;
end

function c:NextResponder(lastResponder, requester)
	if lastResponder then
		--for requester, requesterTable in pairs(syncQueue) do
		--	requesterTable[lastResponder] = nil;
		--	if requesterTable
		--end
		
				-- remove from responders
		--		for responder, table in pairs(syncQueue) do
		--			table[playerName] = nil;
		--		end
				-- todo -> check if i am next responder

				-- remove from requesters
		--		syncQueue[playerName] = nil;

	end
end

function c:PrepareSync(requester)
	if requester then
		-- as a responder

	else
		-- as a requester
		local myEntry = {};
		myEntry[c.ENTRY_PLAYERNAME] = c.charName;
		myEntry[c.ENTRY_DATA] = {};
		table.insert(syncTable, myEntry);

		local partners = onlinePlayers;
		for playerName, partnerTable in pairs(partners) do
			if c:IsVersionAbove("1.13", partnerTable[c.ENTRY_VERSION]) then
				local responderEntry = {};
				responderEntry[c.ENTRY_PLAYERNAME] = playerName;
				responderEntry[c.ENTRY_DATA] = {};
				table.insert(myEntry[c.ENTRY_DATA], responderEntry);
			end
		end
	end
end

function c:StartSync(requester)

end