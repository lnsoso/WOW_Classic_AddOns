local _addonName, _addon = ...;
local ADDONPREFIX = "HL"; -- DO NOT CHANGE! I'm a retard and lenghts are hardcoded now...
local IGNORE_SELF = true;
local FULL_UPDATE_WAIT = 20;
local playerName = GetUnitName("player");
local realmName = GetRealmName();
local frame = CreateFrame("Frame");

local OP_ADD_TARGET = "20";
local OP_REMOVE_TARGET = "21";
local OP_REQUEST_UPDATE = "10";
local OP_MULTIPART_UPDATE = "11";

local lastFullUpdateSent = {
	["CHANNEL"] = 0,
	["ADDON"] = 0
};
local fullUpdateQueued = {
	["CHANNEL"] = 0,
	["ADDON"] = 0
};
local recvBuffer = {};
local handlers = {};

---------------------------------------------
-- Helper functions
---------------------------------------------

--- Turn number into 2 digit left padded string
-- @param num The number to format, must be 0-99
-- @return the 2 digit string
local function PaddedLen(num)
	local str = tostring(num);
	if str:len() == 1 then 
		return "0"..str;
	end
	return str;
end

--- Split string into parts with given length
-- @param istr The input string to split
-- @param partLen Maximum length of single parts
-- @return the number of parts
-- @return array containing the parts
local function SplitString(istr, partLen)
	local splits = 0;
    local splitTable = {};
    
	while true do
		splits = splits + 1;
	
		if istr:len() <= partLen then
			splitTable[splits] = istr;
			break;
		end
		
		splitTable[splits] = istr:sub(1, partLen);
		istr = istr:sub(partLen+1);
	end

	return splits, splitTable;
end

local ProcessUpdateQueue;
do
    local sinceLastUpdate = 0;
    --- Process the update send "queue"
    function ProcessUpdateQueue(self, tdiff)
        sinceLastUpdate = sinceLastUpdate + tdiff;
        if sinceLastUpdate < 1 then 
            return; 
        end
        sinceLastUpdate = 0;
        
        local curTime = GetTime();
        if fullUpdateQueued["CHANNEL"] > 0 and fullUpdateQueued["CHANNEL"] < curTime then
            fullUpdateQueued["CHANNEL"] = 0;
            _addon:SyncSendFullList("CHANNEL");
        end
        
        if fullUpdateQueued["ADDON"] > 0 and fullUpdateQueued["ADDON"] < curTime then
            fullUpdateQueued["ADDON"] = 0;
            _addon:SyncSendFullList("ADDON");
        end
        
        if fullUpdateQueued["ADDON"] == 0 and fullUpdateQueued["CHANNEL"] == 0 then
            _addon:PrintDebug("sync unset OnUpdate");
            self:SetScript("OnUpdate", nil);
        end
    end
end


---------------------------------------------
-- Handler functions
---------------------------------------------

--- Handle OP_REQUEST_UPDATE
-- Sends full list update to source channel.
handlers[OP_REQUEST_UPDATE] = function(msg, author, source)
	_addon:PrintDebug("Got OP_REQUEST_UPDATE from " .. author .. ", responding...");
	_addon:SyncSendFullList(source);
end

--- Handle OP_ADD_TARGET
-- Adds new entry to list if data is valid.
handlers[OP_ADD_TARGET] = function(msg, author)
	local nlen = tonumber(msg:sub(1,2));
	local rlen = tonumber(msg:sub(3,4));
	if not nlen or not rlen or (nlen+rlen+4+10) ~= msg:len() then
		_addon:PrintDebug("Recieved broken OP_ADD_TARGET: " .. msg);
        if rlen and nlen then 
            _addon:PrintDebug("Expected length " .. (nlen+rlen+4+10) .. " got " .. msg:len()); 
        end
		return;
	end
	
	local addedTime = tonumber(msg:sub(msg:len()-9));
	if addedTime == nil then
		_addon:PrintDebug("Got invalid entry from " .. author .. ": Time is nil");
	end
	
	local nresult, name = _addon:FormatPlayerName( msg:sub(5,4+nlen) );
	local rresult, reason = _addon:FormatReason( msg:sub(5+nlen, msg:len()-10) );
	if nresult == 0 and rresult == 0 then
		_addon:PrintDebug(author .. " OP_ADD_TARGET: " .. name .. " | " .. reason);
		_addon:AddToList(name, reason, author, addedTime);
    else
		_addon:PrintDebug("Got invalid entry from " .. author .. ": " .. name .. " | " .. reason);
	end
end

--- Handle OP_REMOVE_TARGET
-- Remove entry from list if data is valid.
handlers[OP_REMOVE_TARGET] = function(msg, author)
	local nlen = tonumber(msg:sub(1,2));
	if not nlen or (nlen+2) ~= msg:len() then
		_addon:PrintDebug("Recieved broken OP_REMOVE_TARGET: " .. msg);
        if nlen then 
            _addon:PrintDebug("Expected length " .. (nlen+2) .. " got " .. msg:len()); 
        end
		return;
	end
	
	local name = msg:sub(3,nlen+2);
	_addon:PrintDebug("Attempting to delete entry " .. name .. " because OP_REMOVE_TARGET from " .. author);
	_addon:RemoveFromList(name, author);
end

--- Handle OP_MULTIPART_UPDATE
-- Recieve multipart updates, parse entries when last part was recieved.
-- Replaces ALL entries of the author with the newly recieved list.
handlers[OP_MULTIPART_UPDATE] = function(msg, author)
	local part = tonumber(msg:sub(1,2));
	local maxpart = tonumber(msg:sub(3,4));
	if not part or not maxpart or msg:len() < 5 or maxpart < part then
		_addon:PrintDebug("Recieved broken OP_MULTIPART_UPDATE: " .. msg);
		return;
	end

	if maxpart > 99 then
		_addon:PrintDebug("Ignore stupid part count from " .. author);
		return;
	end
	
	if part == 1 then
		if recvBuffer[author] == nil then
			recvBuffer[author] = {
				["msg"] = msg:sub(5),
				["recievedCount"] = 1,
				["partCount"] = maxpart
			};
		else
			recvBuffer[author].msg = msg:sub(5);
			recvBuffer[author].recievedCount = 1;
			recvBuffer[author].partCount = maxpart;
		end
	else
		if recvBuffer[author] == nil then
			return;
		end
		recvBuffer[author].msg = recvBuffer[author].msg .. msg:sub(5);
		recvBuffer[author].recievedCount = recvBuffer[author].recievedCount + 1;
	end
	
	_addon:PrintDebug("Recieved OP_MULTIPART_UPDATE from " .. author .. " (" .. recvBuffer[author].recievedCount .. "/" .. recvBuffer[author].partCount .. ")");
	
	if recvBuffer[author].recievedCount == recvBuffer[author].partCount then
		local roff = 1;
		local parsedData = {};
		local nlen, rlen, name, reason, addedTime;
		local msg = recvBuffer[author].msg;
		local msglen = msg:len();
		
		recvBuffer[author] = nil;
		
		while true do
            if roff >= msglen then 
                break; 
            end
		
			nlen = tonumber(msg:sub(roff, roff+1));
			rlen = tonumber(msg:sub(roff+2, roff+3));
			roff = roff+4;
			
			if not nlen or nlen == 0 or not rlen or rlen == 0 then
				_addon:PrintDebug("Multipart update from " .. author .. " was malformed!");
				_addon:PrintDebug(msg);
				return;
			end
			
			name = msg:sub(roff, roff+nlen-1);
			roff = roff+nlen;
			reason = msg:sub(roff, roff+rlen-1);
			roff = roff+rlen;
			addedTime = tonumber(msg:sub(roff, roff+9));
			roff = roff+10;
			
			parsedData[name] = {reason, addedTime};
		end
		
		_addon:ClearForeignData(author, true);
		
		_addon:PrintDebug("Adding OP_MULTIPART_UPDATE entries from " .. author .. ":");
		for k, data in pairs(parsedData) do
			if data[2] == nil then
				_addon:PrintDebug("INVALID ENTRY: Time is nil");
			end
			nlen, name = _addon:FormatPlayerName(k);
			rlen, reason = _addon:FormatReason(data[1]);
			if nlen == 0 and rlen == 0 then
				_addon:AddToList(name, reason, author, data[2]);
            else
				_addon:PrintDebug("INVALID ENTRY: " .. name .. " | " .. reason);
			end
		end
	end
end


---------------------------------------------
-- Events
---------------------------------------------

--- Handle CHAT_MSG_ADDON events
function frame.CHAT_MSG_ADDON(prefix, msg, distType, sender)
    if not Hitlist_settings.syncGuild or prefix ~= ADDONPREFIX or distType ~= "GUILD" then 
        return; 
    end

	sender = _addon.RemoveServerDash(sender);
    if IGNORE_SELF and sender == playerName then 
        return; 
    end
    
    local OPC = msg:sub(1,2);

	if handlers[OPC] ~= nil then 
		handlers[OPC](msg:sub(3), sender, "ADDON");
		return;
	end
	
	_addon:PrintDebug("Invalid OPC from " .. sender .. " recieved: " .. OPC);
end

--- Handle CHAT_MSG_CHANNEL events
function frame.CHAT_MSG_CHANNEL(msg, author, lang, arg4, arg5, arg6, arg7, channelNum, channelName)
    if not Hitlist_settings.syncChannel or channelNum ~= _addon.syncChannelId or msg:sub(1,2) ~= ADDONPREFIX then 
        return;
    end

	author = _addon.RemoveServerDash(author);
    if IGNORE_SELF and author == playerName then 
        return;
    end
    
    local OPC = msg:sub(3,4);

	if handlers[OPC] ~= nil then 
		handlers[OPC](msg:sub(5), author, "CHANNEL");
		return;
	end
	
	_addon:PrintDebug("Invalid OPC from " .. author .. " recieved: " .. OPC);
end

frame:SetScript("OnEvent", function(self, event, ...) frame[event](...); end);
frame:RegisterEvent("CHAT_MSG_ADDON");
frame:RegisterEvent("CHAT_MSG_CHANNEL");


---------------------------------------------
-- Addon functions
---------------------------------------------

--- Send message out in selected channel
-- Only works if relevant sync options are on.
-- @param msg The message to send
-- @param target If not nil only send in "ADDON" or "CHANNEL"
local function SendMessageOut(msg, target)
	if Hitlist_settings.syncGuild and (target == nil or target == "ADDON") then 
		ChatThrottleLib:SendAddonMessage("NORMAL", ADDONPREFIX, msg, "GUILD");
	end
	
	if Hitlist_settings.syncChannel and (target == nil or target == "CHANNEL") then
		if _addon.syncChannelId == nil then
			_addon:PrintDebug("Tried to send via custom channel but we aren't in one!");
			return;
		end
		msg = ADDONPREFIX .. msg;
		ChatThrottleLib:SendChatMessage("NORMAL", ADDONPREFIX, msg, "CHANNEL", nil, _addon.syncChannelId);
	end
end

--- Send add to list (OP_ADD_TARGET)
-- Makes others add the entry to their list.
-- @param name The name of the target
-- @param reason The reason for adding
-- @param timeAdded Time entry was added locally (it was just now when this happens lol, but whatever)
function _addon:SyncAddedEntry(name, reason, timeAdded)
	_addon:PrintDebug("Sending OP_ADD_TARGET");
	SendMessageOut(OP_ADD_TARGET .. PaddedLen(name:len()) .. PaddedLen(reason:len()) .. name .. reason .. timeAdded);
end

--- Send remove target (OP_REMOVE_TARGET)
-- Makes others remove the entry from their list too, if they have it from this character!
-- @param name The name of the target that was removed
-- TODO: Maybe need to find a way to ID by account and not char.
function _addon:SyncRemovedEntry(name)
	_addon:PrintDebug("Sending OP_REMOVE_TARGET");
	SendMessageOut(OP_REMOVE_TARGET .. PaddedLen(name:len()) .. name);
end

--- Send update request (OP_REQUEST_UPDATE)
-- Request a full list update.
-- @param target The channel ("ADDON" or "CHANNEL") to request it in, both if nil
function _addon:SyncRequestFullList(target)
	_addon:PrintDebug("Sending OP_REQUEST_UPDATE");
	SendMessageOut(OP_REQUEST_UPDATE, target);
end

--- Send full update (OP_MULTIPART_UPDATE)
-- Sending may be delayed if update was already sent recently for the target channel.
-- @param target The channel ("ADDON" or "CHANNEL") to send it in
function _addon:SyncSendFullList(target)
	_addon:PrintDebug("Sending OP_MULTIPART_UPDATE");
	
	if fullUpdateQueued[target] > 0 then
		_addon:PrintDebug("MPU send already queued");
		return
	end
	
	local curTime = GetTime()
	if lastFullUpdateSent[target] + FULL_UPDATE_WAIT > curTime then
		local wait = FULL_UPDATE_WAIT - (curTime - lastFullUpdateSent[target]);
		_addon:PrintDebug("last MPU was recent, queue to send in " .. wait .. " sec");
		fullUpdateQueued[target] = curTime + wait;
		frame:SetScript("OnUpdate", ProcessUpdateQueue);
		lastFullUpdateSent[target] = 0;
		return;
	end
	
	local msg = "";
	for name, v in pairs(Hitlist_data[realmName].entries) do
		if Hitlist_data[realmName].localNames[v.by] then
			msg = msg .. PaddedLen(name:len()) .. PaddedLen(v.reason:len()) .. name .. v.reason .. v.added;
		end
	end
	
	if msg == "" then
		_addon:PrintDebug("Nothing to send!");
		return;
	end
	
    local splitcount, msgsplits = SplitString(msg, 247);

	_addon:PrintDebug("Sending update in " .. splitcount .. " parts");
	
	for i=1, splitcount, 1 do
		SendMessageOut(OP_MULTIPART_UPDATE .. PaddedLen(i) .. PaddedLen(splitcount) .. msgsplits[i], target);
	end
	
	lastFullUpdateSent[target] = curTime;
end