local _addonName, _addon = ...;
local L = _addon:GetLocalization();
local playerName = GetUnitName("player");
local realmName = GetRealmName();
local LOCAL_ENTRY_LIMIT = 30;
local lastTrigger = 0;
local lastTriggerName = {};

--- Join channel for data sync
function _addon:JoinSyncChannel(dontSend)
	if Hitlist_settings.channelName == nil or Hitlist_settings.channelName:len() == 0 then
		self:PrintError(L["ERROR_SYNC_CHANNEL_NAME"]);
		return;
	end
	
	self.syncChannelId = nil;
	self.syncChannelName = nil;
	
	JoinTemporaryChannel(Hitlist_settings.channelName, Hitlist_settings.channelPw);
	
	local id, name = GetChannelName(Hitlist_settings.channelName);
	if name == nil or id == nil then
		self:PrintError(L["ERROR_SYNC_CHANNEL_JOIN"]);
		return;
	end
	
	self.syncChannelId = id;
	self.syncChannelName = name;
	
	self:PrintSuccess(L["SYNC_CHANNEL_JOINED"]);

	if not dontSend then
		_addon:SyncRequestFullList("CHANNEL");
		_addon:SyncSendFullList("CHANNEL");
	end
end

--- Add new target to the list
-- @param targetName The already formatted name
-- @param reason The already formatted reason
-- @param by The name of the player who added it
-- @param timeAdded The time it was added, if nil current time is used (optional)
function _addon:AddToList(targetName, reason, by, timeAdded)
	if Hitlist_data[realmName].entries[targetName] ~= nil then
		if Hitlist_data[realmName].entries[targetName].by == by or Hitlist_data[realmName].localNames[by] ~= nil then
			self:PrintDebug("Target " .. targetName .. " already exists from same source, updating reason");
			Hitlist_data[realmName].entries[targetName].reason = reason;
			return;
		end
	
		if by == playerName then
			self:PrintError(L["ERROR_ENTRY_ALREADY_EXISTS"]:format(targetName, Hitlist_data[realmName].entries[targetName].by));
		end
		self:PrintDebug("Duplicate entry for " .. targetName .. " from " .. by ..", already have from " .. Hitlist_data[realmName].entries[targetName].by);
		
		return;
	end
	
    -- Limit local entries because this shouldn't have the whole server in it
    local count = 0;
	if by == playerName then
		for _,v in pairs(Hitlist_data[realmName].entries) do 
            if Hitlist_data[realmName].localNames[v.by] then 
                count = count + 1; 
            end
		end
		if count >= LOCAL_ENTRY_LIMIT then
			self:PrintError(L["ERROR_MAXIMUM_REACHED"]);
			return;
		end
    else
		for _,v in pairs(Hitlist_data[realmName].entries) do 
            if v.by == by then 
                count = count + 1; 
            end
		end
		if count >= LOCAL_ENTRY_LIMIT then
			return;
		end
    end
	
    if timeAdded == nil then 
        timeAdded = time(); 
    end
	Hitlist_data[realmName].entries[targetName] = {
		["reason"] = reason,
		["by"] = by,
		["added"] = timeAdded
	};
	self:MainUI_UpdateList();
	self:PrintDebug("Added: " .. targetName .. " | " .. reason .. " | BY: " .. by);
	
    if by == playerName then 
        self:SyncAddedEntry(targetName, reason, timeAdded); 
    end
end

--- Remove target from the list
-- @param targetName The target to remove
-- @param requester Player name who requested the delete
function _addon:RemoveFromList(targetName, requester)
	if Hitlist_data[realmName].entries[targetName] == nil then
		self:PrintDebug("Can't remove entry " .. targetName .. " because it doesn't exist!");
		return;
	end

	if Hitlist_data[realmName].entries[targetName].by ~= requester and Hitlist_data[realmName].localNames[Hitlist_data[realmName].entries[targetName].by] == nil then
		self:PrintDebug("Author mismatch on remove, ignoring! " .. Hitlist_data[realmName].entries[targetName].by .. " <-> " .. requester);
		return;
	end
	
	Hitlist_data[realmName].entries[targetName] = nil;
	self:MainUI_UpdateList();
	
	self:PrintDebug("Removed entry " .. targetName .. "! Requested by " .. requester);
    if requester == playerName then 
        self:SyncRemovedEntry(targetName); 
    end
end

--- Play sound alert
function _addon:PlaySoundAlert()
    PlaySoundFile("Sound/Doodad/LightHouseFogHorn.ogg", "Master");
	PlaySoundFile("Sound/Doodad/HornGoober.ogg", "Master");
	--post 8.2 API changes, not in classic (yet?)
    --PlaySoundFile(567094, "Master");
    --PlaySoundFile(566726, "Master");
end

--- Play "incoming" emote sound depending on player race and sex
function _addon:PlaySoundNotify()
	local race = UnitRace("player");
    local sex = UnitSex("player");
    
	local sounds = {
		["Human"] = {
			[2] = "Sound/character/Human/HumanVocalMale/HumanMaleIncoming01.ogg",
			[3] = "Sound/character/Human/HumanVocalFemale/HumanFemaleIncoming01.ogg",
		},
		["NightElf"] = {
			[2] = "Sound/character/NightElf/NightElfVocalMale/NightElfMaleIncoming01.ogg",
			[3] = "Sound/character/NightElf/NightElfVocalFemale/NightElfFemaleIncoming01.ogg",
		},
		["Dwarf"] = {
			[2] = "Sound/character/Dwarf/DwarfVocalMale/DwarfMaleIncoming01.ogg",
			[3] = "Sound/character/Dwarf/DwarfVocalFemale/DwarfFemaleIncoming01.ogg",
		},
		["Gnome"] = {
			[2] = "Sound/character/Gnome/GnomeVocalMale/GnomeMaleIncoming01.ogg",
			[3] = "Sound/character/Gnome/GnomeVocalFemale/GnomeFemaleIncoming01.ogg",
		},
		["Orc"] = {
			[2] = "Sound/character/Orc/OrcVocalMale/OrcMaleIncoming01.ogg",
			[3] = "Sound/character/Orc/OrcVocalFemale/OrcFemaleIncoming01.ogg",
		},
		["Troll"] = {
			[2] = "Sound/character/Troll/TrollVocalMale/TrollMaleIncoming01.ogg",
			[3] = "Sound/character/Troll/TrollVocalFemale/TrollFemaleIncoming01.ogg",
		},
		["Tauren"] = {
			[2] = "Sound/character/Tauren/TaurenVocalMale/TaurenMaleIncoming01.ogg",
			[3] = "Sound/character/Tauren/TaurenVocalFemale/TaurenFemaleIncoming01.ogg",
		},
		["Scourge"] = {
			[2] = "Sound/character/Scourge/ScourgeVocalMale/UndeadMaleIncoming01.ogg",
			[3] = "Sound/character/Scourge/ScourgeVocalFemale/UndeadFemaleIncoming01.ogg",
		},
	}; 
	
	--[[ post 8.2 API changes, not in classic (yet?)
    local sounds = {
		["Human"] = {
			[2] = 540701,
			[3] = 540621,
		},
		["NightElf"] = {
			[2] = 541123,
			[3] = 541047,
		},
		["Dwarf"] = {
			[2] = 540059,
			[3] = 540005,
		},
		["Gnome"] = {
			[2] = 540475,
			[3] = 540447,
		},
		["Orc"] = {
			[2] = 541382,
			[3] = 541318,
		},
		["Troll"] = {
			[2] = 543318,
			[3] = 543255,
		},
		["Tauren"] = {
			[2] = 543054,
			[3] = 542988,
		},
		["Scourge"] = {
			[2] = 542751,
			[3] = 542677,
		},
    }; ]]
	PlaySoundFile(sounds[race][sex], "Master");
end

--- Trigger for found target
-- @param name The name of the found target
-- @param ignoreCd If set will ignore trigger and name CDs
function _addon:Trigger(name, ignoreCd)
	local curTime = GetTime();

	if ignoreCd ~= true then 
		if lastTriggerName[name] ~= nil and lastTriggerName[name] > curTime - Hitlist_settings.triggerNameCd then
			return;
		end
	
		if lastTrigger > curTime - Hitlist_settings.triggerCd then 
            self:PrintDebug("Still on trigger CD, only play warning sound!");

            self:PrintWarn(L["CHATLINE_TARGET_FOUND"]:format(name));
            if Hitlist_settings.playSound then
                self:PlaySoundNotify(); 
            end

			lastTriggerName[name] = curTime;
			return;
		end
	end
    
    self:PrintWarn(L["CHATLINE_TARGET_FOUND"]:format(name));
    
    if _addon:TargetNotification_SetTarget(name) then
        if Hitlist_settings.playSound then 
            self:PlaySoundAlert(); 
        end
    else
        if Hitlist_settings.playSound then
            self:PlaySoundNotify(); 
        end
    end

	lastTrigger = curTime;
	lastTriggerName[name] = curTime;
end

--- Clear out targets recieved from other players
-- @param fromPlayer The name of whom to delete entries from, all if nil
-- @param silent Don't output notification in chat
function _addon:ClearForeignData(fromPlayer, silent)
	for name, v in pairs(Hitlist_data[realmName].entries) do
		if Hitlist_data[realmName].localNames[v.by] == nil and (fromPlayer == nil or v.by == fromPlayer) then
			Hitlist_data[realmName].entries[name] = nil;
		end
    end
    
    self:MainUI_UpdateList();

	if silent then
		return;
	end

    if fromPlayer then
        _addon:PrintSuccess(L["SETTINGS_DELETE_SYNCDATA_SUCCESS_NAME"]:format(fromPlayer));
    else
        _addon:PrintSuccess(L["SETTINGS_DELETE_SYNCDATA_SUCCESS"]);
    end
end

--- Clear the whole target list
function _addon:ClearList()
    wipe(Hitlist_data[realmName].entries);
    self:MainUI_UpdateList();
    _addon:PrintSuccess(L["SETTINGS_DELETE_DATA_SUCCESS"]);
end

------------------------------------------------
-- Helper
------------------------------------------------

--- Format player name
-- If name is invalid gives the reason why.
-- Upper case first char, remove whitespace.
-- @param name The name reason
-- @return 0 if success, otherwise number telling the problem
-- @return The formated name, nil if invalid name
function _addon:FormatPlayerName(name)
    if not name then 
        return 1, ""; -- no name given (too short)
    end

    name = strtrim(name);
    
    local found = string.find(name, " ");
    if found then
        return 2, name; -- invalid name
    end

    local len = name:len();
    if len < 2 then
        return 1, name; -- too short
    end

    if len > 12 then
        return 3, name; -- too long
    end
	return 0, (strtrim(name):lower():gsub("^%l", string.upper));
end

-- Format reason string
-- Only removes whitespace for now.
-- @param reason The reason string
-- @return 0 if success, otherwise number telling the problem
-- @return The formated reason, nil if invalid
function _addon:FormatReason(reason)
    if not reason then 
        return 1, ""; -- no reason given (too short)
    end

    reason = strtrim(reason);
    local len = reason:len();

    if len < 3 then
        return 1, reason; -- too short
    end

    if len > 99 then
        return 2, reason; -- too long
    end

	return 0, reason;
end

--- Remove server names from names given as "Character-Servername"
-- @param name The name to remove the dash server part from
function _addon.RemoveServerDash(name)
	local serverDash = name:find("-");
    if serverDash then 
        return name:sub(1, serverDash-1); 
    end
	return name;
end

--- Convert seconds to a more readable format
-- @param diff Time in seconds
function _addon:HumanTimeDiff(diff)
	local val, unit;
    if diff < 60 then 
        val = diff; 
        unit = "TIME_UNIT_SECOND";
    elseif diff < 3600 then 
        val = math.floor(diff/60 + 0.5); 
        unit = "TIME_UNIT_MINUTE";
    elseif diff < 86400 then 
        val = math.floor(diff/3600 + 0.5); 
        unit = "TIME_UNIT_HOUR";
    elseif diff < 604800 then 
        val = math.floor(diff/86400 + 0.5); 
        unit = "TIME_UNIT_DAY";
    elseif diff < 2419200 then 
        val = math.floor(diff/604800 + 0.5); 
        unit = "TIME_UNIT_WEEK";
    else 
        val = math.floor(diff/2419200 + 0.5); 
        unit = "TIME_UNIT_MONTH" 
    end
    if val > 1 then 
        unit = unit .. "S"; 
    end
	return val .. " " .. L[unit];
end

--- Print msg to chat, replacing default color
-- @param msg The message to print
-- @param defColor The color to use as default given as color esc sequence
local function PrintToChat(msg, defColor)
  msg = msg:gsub("|r", defColor);
  print(defColor .. _addonName .. ": " .. msg);
end

--- Print success message (green)
-- @param msg The message to print
function _addon:PrintSuccess(msg)
	PrintToChat(msg, "|cFF33FF33");
end

--- Print error message (red)
-- @param msg The message to print
function _addon:PrintError(msg)
	PrintToChat(msg, "|cFFFF3333");
end

--- Print warning message (orange)
-- @param msg The message to print
function _addon:PrintWarn(msg)
	PrintToChat(msg, "|cFFFFAA22");
end

--- Helper for printing tables
local function PrintDebugTable(t, depth)
	for k,v in pairs(t) do
		print(string.rep("-", depth) .. " " .. k .. ": " .. tostring(v));
		if type(v) == "table" then 
			PrintDebugTable(v, depth+1);
		end
	end
end

--- Print message or table if debug output is on
-- @param o The string or table to print
function _addon:PrintDebug(o)
    if not Hitlist_settings.debug then 
        return; 
    end
	
	if type(o) == "table" then 
		local count = 0;
        for _ in pairs(o) do 
            count = count + 1; 
        end
		print(tostring(o) .. " size: " .. count);
		PrintDebugTable(o,1);
		return;
	end
		
	print(o);
end

local dtimers = {};
function _addon:StartDebugTimer(name)
    if not Hitlist_settings.debug then 
        return; 
    end
    dtimers[name] = debugprofilestop();
end

function _addon:TakeDebugTime(name)
    if not Hitlist_settings.debug or dtimers[name] == nil then 
        return; 
    end
    print(name .. " took " .. (debugprofilestop() - dtimers[name]) .. "ms");
end