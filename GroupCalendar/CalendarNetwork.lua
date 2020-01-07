gGroupCalendar_MessagePrefix0 = "GC3";
gGroupCalendar_MessagePrefix = gGroupCalendar_MessagePrefix0.."/";

gGroupCalendar_MessagePrefixLength = string.len(gGroupCalendar_MessagePrefix);

gGroupCalendar_ShowChat = false;

local gGroupCalendar_EventSyncQueue = {};

gGroupCalendar_Channel =
{	
	Status        = "Disconnected",
	StatusMessage = nil,
	GotTooManyChannelsMessage = false,
};

gGroupCalendar_Queue =
{
	TasksDelay       = 0,
	TasksElapsed     = 0,
	Tasks            = {},
	
	RequestsDelay    = 0,
	RequestsElapsed  = 0,
	Requests         = {[1] = {}, [2] = {}},
	
	InboundDelay     = 0,
	InboundMessages  = {},
	InboundLastSender = nil,
	InboundTimeSinceLastMessage = 0,
	
	OutboundDelay    = 0,
	OutboundMessages = {},
	OutboundTimeSinceLastMessage = 0,
	
	DatabaseUpdates  = {},
	RSVPUpdates      = {},
};

gCalendarNetwork_UserTrustCache =
{
};

gCalendarNetwork_RequestDelay =
{
	Init = 60,
	ShortInit = 5,
	SelfUpdateRequest = 0,
	ExternalUpdateRequest = 60,
	OwnedNotices = 120, -- Allow time for updates to arrive before we'll start advertising databases
	JoinChannel2 = 2,
	OwnedUpdate = 0,
	ProxyUpdateMin = 6,
	ProxyUpdateRange = 4,
	
	RFUMin = 1,
	RFURange = 5,

	UPDMin = 0,
	UPDRange = 2,
	
	OwnedNOURange = 0,
	ProxyNOUMin = 6,
	ProxyNOURange = 4,
	
	InboundQueue = 0.2,
	OutboundQueue = 0.2,
	RequestQueue = 0.2,
	
	-- Outbound queue delay 1 - 5 seconds
	
	OutboundQueueGapMin = 1, -- Delay for after last inbound message was processed
	OutboundQueueGapWidth = 5, -- Random delay after the min time
	
	-- Request queue delay 1 - 5 seconds
	
	RequestQueueGapMin = 1,  -- Delay for after last inbound or outbound message was processed
	RequestQueueGapWidth = 4, -- Random delay after the min time
	
	GuildUpdateAutoConfig = 2,
	
	CheckDatabaseTrust = 10,
	GuildRosterUpdate = 1,
	
	VersionCheckDelayMin = 19 * 60,
	VersionCheckDelayRange = 2 * 60,
	
	-- Maximum age for an update is two minutes
	
	MaximumUpdateAge = 300,
};

function CalendarNetwork_GetChannelStatus()
	return gGroupCalendar_Channel.Status;
end

function CalendarNetwork_SetChannelStatus(pStatus, pStatusMessage)
	gGroupCalendar_Channel.Status = pStatus;
	gGroupCalendar_Channel.StatusMessage = pStatusMessage;	
	GroupCalendar_UpdateChannelStatus();
end

function CalendarNetwork_JoinChannel2(pParams)
	
	local registeredPrefixes = C_ChatInfo.GetRegisteredAddonMessagePrefixes()
	
	local vFound = false;

	for vPrefixNum, vPrefix in ipairs(registeredPrefixes) do
		if vPrefix == gGroupCalendar_MessagePrefix0 then
			vFound = true;
			break;
		end
	end

	
	if vFound == false then
		local successfulRequest = C_ChatInfo.RegisterAddonMessagePrefix(gGroupCalendar_MessagePrefix0);
	end

	CalendarNetwork_JoinedChannel();
	
	return true;
end

function CalendarNetwork_JoinedChannel()
	CalendarNetwork_SetChannelStatus("Connected");
	--CalendarNetwork_RequestAllVersions();
end


function CalendarNetwork_UnpackIndexedList(...)
	
	local	vList = {};
	local argn = select('#', ...)
	
	for vIndex = 1, argn, 3 do
		
		local arg1 = select(vIndex, ...)
		local arg2 = select(vIndex+1, ...)		
		vList[tonumber(arg1)] = arg2;
	end
	
	return vList;
end

function CalendarNetwork_GetChannelList()
	local	vChannelList = CalendarNetwork_UnpackIndexedList(GetChannelList());
	
	return vChannelList;
end

function CalendarNetwork_CalendarLoaded()
	-- Set up a deferred initialization
	
	--CalendarNetwork_SetChannelStatus("Starting");

	CalendarNetwork_QueueTask(CalendarNetwork_Initialize, nil, 4, "INIT");
end

function CalendarNetwork_ProcessCommandString(pSender, pTrustLevel, pCommandString)
	
	local	vCommand = CalendarNetwork_ParseCommandSubString(pCommandString);
	
	if not vCommand then
		
		if gGroupCalendar_Settings.Debug then
			Calendar_DebugMessage("ProcessCommandString: Couldn't parse ["..pSender.."]:"..pCommandString);
		end
		
		return false;
	end
	
	return CalendarNetwork_ProcessCommand(pSender, pTrustLevel, vCommand);
end

function CalendarNetwork_ProcessCommand(pSender, pTrustLevel, pCommand)

	local	vOpcode = pCommand[1].opcode;
	local	vOperands = pCommand[1].operands;
	
	table.remove(pCommand, 1);
		
	if vOpcode == "TRUST" then
		CalendarNetwork_ProcessTrustCommand(pSender, vOperands);
	elseif vOpcode == "TRUSTREQ" then
		CalendarNetwork_ProcessTrustRequestCommand(pSender, vOperands);
	elseif vOpcode == "SYNCREQ" then
		CalendarNetwork_LoadSyncQueue();
	elseif vOpcode == "EVT1" then
		CalendarNetwork_ProcessEventUpdateCommand(pSender, vOperands);
	elseif vOpcode == "EVT2" then
		CalendarNetwork_ProcessEventTitleUpdateCommand(pSender, vOperands);
	elseif vOpcode == "RSVP1" then
		CalendarNetwork_ProcessRSVPUpdateCommand(pSender, vOperands);
	elseif vOpcode == "RSVP2" then
		CalendarNetwork_ProcessRSVPCommentUpdateCommand(pSender, vOperands);
	elseif vOpcode == "VERREQ" then
		local versionEntry = {};
		versionEntry.UserName = pSender;
		versionEntry.Version = vOperands[1];
		gGroupCalendar_PlayerVersions[pSender] = versionEntry;
		CalendarNetwork_QueueOutboundMessage("/VER:"..gGroupCalendar_VersionString);
	elseif vOpcode == "VER" then
		local versionEntry = {};
		versionEntry.UserName = pSender;
		versionEntry.Version = vOperands[1];
		gGroupCalendar_PlayerVersions[pSender] = versionEntry;
	else
		if gGroupCalendar_Settings.Debug then
			Calendar_DebugMessage("ProcessCommand: Unknown opcode "..vOpcode);
		end
	end
end

function CalendarNetwork_ProcessEventUpdateCommand(pSender, pCommand)
	local vDate = tonumber(pCommand[1]);
	local vGUID = pCommand[2];
	local vChangedDate = tonumber(pCommand[3]);
	local vChangedTime = tonumber(pCommand[4]);
	local vType = pCommand[5];
	local vStatus = pCommand[6];
	local vTime = tonumber(pCommand[7]);
	local vDuration = tonumber(pCommand[8]);
	local vMinLevel = tonumber(pCommand[9]);
	local vMaxLevel = tonumber(pCommand[10]);

	local foundEvent = nil;
	local updateEvent = false;
	local RemoveAllRSVPs = false;

	-- Check if the date is more recent
	if gGroupCalendar_GuildDatabase.Events[vDate] then
		for vEventIndex, vEvent in pairs (gGroupCalendar_GuildDatabase.Events[vDate]) do
			if vEvent.mGUID == vGUID then
				foundEvent = vEvent;
				if EventDatabase_SecondDateTimeNewer(vEvent.mChangedDate, vEvent.mChangedTime, vChangedDate, vChangedTime) then
					-- Update is newer than what we have. Update the event.
					updateEvent = true;
					-- if the event is deleted, remove all attendance as it's a waste of space
					if vStatus == "D" and vEvent.mStatus ~= "D" then
						vEvent.mAttendance = {};
						-- Remove all pending RSVP updates also. 
						RemoveAllRSVPs = true;									
					end
				end
			end
		end
	end

	if not foundEvent then		
		-- Event doesnt exist yet. Make it.
		local	foundEvent = EventDatabase_NewEvent(gGroupCalendar_GuildDatabase, vDate);
		foundEvent.mChangedDate = vChangedDate;
		foundEvent.mChangedTime = vChangedTime;
		foundEvent.mType = vType;
		foundEvent.mStatus = vStatus;
		foundEvent.mTime = vTime;
		foundEvent.mDuration = vDuration;
		foundEvent.mGUID = vGUID;
		foundEvent.mMinLevel = vMinLevel;
		foundEvent.mMaxLevel = vMaxLevel;
		EventDatabase_AddEvent(gGroupCalendar_GuildDatabase, foundEvent);		
	end

	if updateEvent == true then
		foundEvent.mChangedDate = vChangedDate;
		foundEvent.mChangedTime = vChangedTime;
		foundEvent.mType = vType;
		foundEvent.mStatus = vStatus;
		foundEvent.mTime = vTime;
		foundEvent.mDuration = vDuration;
		foundEvent.mMinLevel = vMinLevel;
		foundEvent.mMaxLevel = vMaxLevel;

		-- Remove event updates
		gGroupCalendar_EventSyncQueue = CalendarNetwork_ArrayRemove(gGroupCalendar_EventSyncQueue, function(t, i, j)
			local v = t[i];
			return not ((v.mUpdateTpye == 1 and v.mEvent == foundEvent) or (RemoveAllRSVPs == true and v.mUpdateTpye == 2 and v.mEvent == foundEvent));
		end);	

		GroupCalendar_EventChanged(gGroupCalendar_GuildDatabase, foundEvent);
	end
end

function CalendarNetwork_ProcessEventTitleUpdateCommand(pSender, pCommand)
	local vDate = tonumber(pCommand[1]);
	local vGUID = pCommand[2];
	local vChangedDate = tonumber(pCommand[3]);
	local vChangedTime = tonumber(pCommand[4]);
	local vTitle = Calendar_UnescapeString(pCommand[5]);	

	-- Check if the date is more recent
	if gGroupCalendar_GuildDatabase.Events[vDate] then
		for vEventIndex, vEvent in pairs (gGroupCalendar_GuildDatabase.Events[vDate]) do
			if vEvent.mGUID == vGUID then
				if EventDatabase_SecondDateTimeNewer(vEvent.mChangedDate, vEvent.mChangedTime, vChangedDate, vChangedTime) then
					-- Update is newer than what we have. Update the event.

					-- Update the event values
					vEvent.mChangedDate = vChangedDate;
					vEvent.mChangedTime = vChangedTime;
					vEvent.mTitle = vTitle;							
				
					-- Update the calendar
					GroupCalendar_EventChanged(gGroupCalendar_GuildDatabase, vEvent);
				end			
			end
		end
	end
end

function CalendarNetwork_ProcessRSVPUpdateCommand(pSender, pCommand)
	local vEventDate = tonumber(pCommand[1]);
	local vGUID = pCommand[2];
	local vAttendee = pCommand[3];
	local vDate = tonumber(pCommand[4]);
	local vTime = tonumber(pCommand[5]);
	local vOrigDate = tonumber(pCommand[6]);
	local vOrigTime = tonumber(pCommand[7]);
	local vRole = pCommand[8];
	local vLevel = tonumber(pCommand[9]);
	local vRank = tonumber(pCommand[10]);
	local vClass = pCommand[11];
	local vStatus = pCommand[12];
	local vRace = pCommand[13];

	-- Check if the date is more recent
	if gGroupCalendar_GuildDatabase.Events[vEventDate] then
		for vEventIndex, vEvent in pairs (gGroupCalendar_GuildDatabase.Events[vEventDate]) do
			if vEvent.mGUID == vGUID then

				local vUpd = false;
				local vRSVP = vEvent.mAttendance[vAttendee];
				if not vRSVP then
					vUpd = true;
					vRSVP = {};				
					vRSVP.mName = vAttendee;
					vEvent.mAttendance[vAttendee] = vRSVP;
				elseif EventDatabase_SecondDateTimeNewer(vRSVP.mDate, vRSVP.mTime, vDate, vTime) then
					vUpd = true;
				end

				if vUpd == true then
					vRSVP.mRole = vRole;
					vRSVP.mDate = vDate;
					vRSVP.mTime = vTime;
					vRSVP.mStatus = vStatus;
					vRSVP.mOriginalDate = vOrigDate;
					vRSVP.mOriginalTime = vOrigTime;								
					vRSVP.mClassCode = vClass;
					vRSVP.mRaceCode = vRace;
					vRSVP.mLevel = vLevel;
					vRSVP.mGuildRank = vRank;

					-- Remove RSVP update
					gGroupCalendar_EventSyncQueue = CalendarNetwork_ArrayRemove(gGroupCalendar_EventSyncQueue, function(t, i, j)
						local v = t[i];
						return not (v.mUpdateTpye == 2 and v.mEvent == vEvent and v.mRSVP.mName == vAttendee);
					end);
				--else
				--	print ("Not Updating RSVP");
				end
				
				-- Update the attendance list
				if gCalendarEventViewer_Event == vEvent then
					CalendarAttendanceList_EventChanged(CalendarEventViewerAttendance, gCalendarEventViewer_Database, gCalendarEventViewer_Event);
				end
				
				CalendarEventEditor_EventChanged(vEvent);

			end
		end
	end
end

function CalendarNetwork_ProcessRSVPCommentUpdateCommand(pSender, pCommand)
	local vEventDate = tonumber(pCommand[1]);
	local vGUID = pCommand[2];
	local vAttendee = pCommand[3];
	local vDate = tonumber(pCommand[4]);
	local vTime = tonumber(pCommand[5]);
	local vComment = Calendar_UnescapeString(pCommand[6]);	

	-- Check if the date is more recent
	if gGroupCalendar_GuildDatabase.Events[vEventDate] then
		for vEventIndex, vEvent in pairs (gGroupCalendar_GuildDatabase.Events[vEventDate]) do
			if vEvent.mGUID == vGUID then

				local vRSVP = vEvent.mAttendance[vAttendee];
				if vRSVP and EventDatabase_SecondDateTimeNewer(vRSVP.mDate, vRSVP.mTime, vDate, vTime) then
					vRSVP.mComment = vComment;					
				end
							
				-- Update the attendance list
				if gCalendarEventViewer_Event == vEvent then
					CalendarAttendanceList_EventChanged(CalendarEventViewerAttendance, gCalendarEventViewer_Database, gCalendarEventViewer_Event);
				end
				
				CalendarEventEditor_EventChanged(vEvent);
			end
		end
	end
end

function CalendarNetwork_ArrayRemove(t, fnKeep)
    local j, n = 1, #t;

    for i=1,n do
        if (fnKeep(t, i, j)) then
            -- Move i's kept value to j's position, if it's not already there.
            if (i ~= j) then
                t[j] = t[i];
                t[i] = nil;
            end
            j = j + 1; -- Increment position of where we'll place the next kept value.
        else
            t[i] = nil;
        end
    end

    return t;
end

function CalendarNetwork_ProcessTrustCommand(pSender, pCommand)
	
	--local params = CalendarNetwork_ParseParameterString(pCommand);
	local pVersion = tonumber(pCommand[1]);
	local pGuild = pCommand[2];
	local pTrustAnyone = pCommand[3];
	local pTrustGuildies = pCommand[4];
	local pMinRank = pCommand[5];

	local pPlayers = {};
	if pCommand[6] then
		for vPlayerName, vPlayerSecurity in string.gmatch(pCommand[6], "(%a+)~(%d)~") do
			pPlayers[vPlayerName] = tonumber(vPlayerSecurity);
		end
	end
	CalendarNetwork_ReceiveTrustUpdate(pSender, pGuild, pVersion, pTrustAnyone, pTrustGuildies, pMinRank, pPlayers);

end

function CalendarNetwork_ProcessTrustRequestCommand(pSender, pCommand)
	--local params = CalendarNetwork_ParseParameterString(pCommand);
	local pVersion = tonumber(pCommand[1]);
	local pGuild = pCommand[2];

	if gGroupCalendar_PlayerSettings.Security.Version > pVersion and gGroupCalendar_PlayerSettings.Security.Guild == pGuild then
		-- We have newer trust settings. Send our version to others
		CalendarNetwork_QueueTrustUpdate();
	elseif gGroupCalendar_PlayerSettings.Security.Version < pVersion and gGroupCalendar_PlayerSettings.Security.Guild == pGuild then
		-- We have a lower version than the user requesting an update. Ask for an update ourselves as it must be out of date.
		CalendarNetwork_QueueTrustRequest();
	end
end

function CalendarNetwork_ResetQueues()
	gGroupCalendar_Queue =
	{
		TasksDelay       = 0,
		TasksElapsed     = 0,
		Tasks            = {},
		
		RequestsDelay    = 0,
		RequestsElapsed  = 0,
		Requests         = {[1] = {}, [2] = {}},
		
		InboundDelay     = 0,
		InboundMessages  = {},
		InboundLastSender = nil,
		InboundTimeSinceLastMessage = 0,
		
		OutboundDelay    = 0,
		OutboundMessages = {},
		OutboundTimeSinceLastMessage = 0,
		
		DatabaseUpdates  = {},
		RSVPUpdates      = {},
	};
end

function CalendarNetwork_ParseCommandSubString(pCommandString)
	
	-- Break the command into parts
	local	vCommand = {};

	-- May need to add a "/" at the start of this match
	for vOpcode, vOperands in string.gmatch(pCommandString, "/(%w+):*([^/]*)") do

		local	vOperation = {};		
		vOperation.opcode = vOpcode;
		vOperation.operandString = vOperands;
		vOperation.operands = CalendarNetwork_ParseParameterString(vOperands);
		
		table.insert(vCommand, vOperation);
	end
	
	return vCommand;
end

function CalendarNetwork_ParseParameterString(pParameterString)
	local	vParameters = {};
	local	vIndex = 0;
	local	vFound = true;
	local	vStartIndex = 1;
	
	while vFound do
		local	vEndIndex;
		
		vFound, vEndIndex, vParameter = string.find(pParameterString, "([^,]*),", vStartIndex);
		
		vIndex = vIndex + 1;
		
		if not vFound then
			vParameters[vIndex] = string.sub(pParameterString, vStartIndex);
			break;
		end
		
		vParameters[vIndex] = vParameter;
		vStartIndex = vEndIndex + 1;
	end
	
	return vParameters;
end

function CalendarNetwork_QueueOutboundMessage(pMessage)
	table.insert(gGroupCalendar_Queue.OutboundMessages, pMessage);
	
	GroupCalendar_StartUpdateTimer();
end

function CalendarNetwork_QueueInboundMessage(pSender, pTrustLevel, pMessage)
	table.insert(gGroupCalendar_Queue.InboundMessages, {mSender = pSender, mTrustLevel = pTrustLevel, mMessage = pMessage});
	
	if table.getn(gGroupCalendar_Queue.InboundMessages) == 1 then
		gGroupCalendar_Queue.InboundDelay = 0;
	end
	
	GroupCalendar_StartUpdateTimer();
end

function CalendarNetwork_QueueTask(pTaskFunc, pTaskParam, pDelay, pTaskID)
	local	vTask = {mTaskFunc = pTaskFunc, mTaskParam = pTaskParam, mDelay = pDelay, mID = pTaskID};
	
	-- Ignore tasks with duplicate IDs
	
	if pTaskID then
		for vIndex, vTask in pairs(gGroupCalendar_Queue.Tasks) do
			if vTask.mID == pTaskID then
				return;
			end
		end
	end
	
	-- Insert the task
	
	table.insert(gGroupCalendar_Queue.Tasks, vTask);
		
	CalendarNetwork_UpdateTaskQueueDelay();
	
	return true;
end

function CalendarNetwork_UpdateTaskQueueDelay()
	local	vDelay = nil;
	
	for vIndex, vTask in pairs(gGroupCalendar_Queue.Tasks) do
		if not vDelay
		or vTask.mDelay < vDelay then
			vDelay = vTask.mDelay;
		end
	end
	
	gGroupCalendar_Queue.TasksDelay = vDelay;
	
	if vDelay then
		GroupCalendar_StartUpdateTimer();
	end
end

function CalendarNetwork_SetTaskDelay(pTaskID, pDelay)
	-- Ignore tasks with duplicate IDs
	
	for vIndex, vTask in pairs(gGroupCalendar_Queue.Tasks) do
		if vTask.mID == pTaskID then
			vTask.mDelay = pDelay;
			CalendarNetwork_UpdateTaskQueueDelay();
			return;
		end
	end
end

function CalendarNetwork_QueueRequest(pRequest, pDelay, pPriority)
	pRequest.mDelay = pDelay;
	
	if gGroupCalendar_Settings.DebugQueues then
		Calendar_DebugMessage("CalendarNetwork_QueueRequest: "..pRequest.mOpcode.." in "..pDelay.." seconds");
	end
	
	if not pPriority then
		pPriority = 2;
	end
	
	table.insert(gGroupCalendar_Queue.Requests[pPriority], pRequest);
	
	local	vTotalRequests = 0;
	
	for vPriority, vRequestQueue in pairs(gGroupCalendar_Queue.Requests) do
		vTotalRequests = vTotalRequests + table.getn(gGroupCalendar_Queue.Requests[vPriority]);
	end
	
	local	vDelay = pRequest.mDelay;
	
	if vDelay < gCalendarNetwork_RequestDelay.RequestQueue then
		vDelay = gCalendarNetwork_RequestDelay.RequestQueue;
	end
	
	if vTotalRequests == 1
	or vDelay < gGroupCalendar_Queue.RequestsDelay then
		gGroupCalendar_Queue.RequestsDelay = vDelay;
	end
	
	GroupCalendar_StartUpdateTimer();
	
	return true;
end

function CalendarNetwork_SetRequestPriority(pRequest, pPriority)
	for vPriority, vRequests in pairs(gGroupCalendar_Queue.Requests) do
		for vIndex, vRequest in pairs(vRequests) do
			if vRequest == pRequest then
				if vPriority ~= pPriority then
					table.remove(vRequests, vIndex);
					table.insert(gGroupCalendar_Queue.Requests[pPriority], vRequest);
				end
				return;
			end
		end
	end
end

function CalendarNetwork_DeleteRequestByOpcode(pOpcode)
	for vPriority, vRequests in pairs(gGroupCalendar_Queue.Requests) do
		for vIndex, vRequest in pairs(vRequests) do
			if vRequest.mOpcode == pOpcode then
				table.remove(vRequests, vIndex);
				return true;
			end
		end
	end
	
	return false;
end

function CalendarNetwork_QueueUniqueOpcodeRequest(pRequest, pDelay)
	CalendarNetwork_DeleteRequestByOpcode(pRequest.mOpcode);
	
	return CalendarNetwork_QueueRequest(pRequest, pDelay);
end

function CalendarNetwork_QueueUniqueUserRequest(pRequest, pDelay)
	-- Remove an existing request with the same opcode and user name
	
	for vPriority, vRequests in pairs(gGroupCalendar_Queue.Requests) do
		for vIndex, vRequest in pairs(vRequests) do
			if vRequest.mOpcode == pRequest.mOpcode
			and vRequest.mUserName == pRequest.mUserName then
				table.remove(vRequests, vIndex);
				break;
			end
		end
	end
	
	return CalendarNetwork_QueueRequest(pRequest, pDelay);
end

function CalendarNetwork_ArrayContainsArray(pArray, pSubArray)
	for vFieldName, vFieldValue in pairs(pSubArray) do
		if pArray[vFieldName] ~= vFieldValue then
			return false;
		end
	end
	
	return true;
end

function CalendarNetwork_FindRequest(pRequest)
	for vPriority, vRequests in pairs(gGroupCalendar_Queue.Requests) do
		for vIndex, vRequest in pairs(vRequests) do
			if CalendarNetwork_ArrayContainsArray(vRequest, pRequest) then
				return vRequest;
			end
		end
	end
	
	return nil;
end

function CalendarNetwork_NeedsUpdateTimer()
	if gGroupCalendar_Queue.TasksDelay then
		return true;
	end
	
	for vPriority, vRequests in pairs(gGroupCalendar_Queue.Requests) do
		if table.getn(vRequests) > 0 then
			return true;
		end
	end
	
	if table.getn(gGroupCalendar_Queue.InboundMessages) > 0 then
		return true;
	end

	if table.getn(gGroupCalendar_Queue.OutboundMessages) > 0 then
		return true;
	end
	
	return false;
end

function CalendarNetwork_ProcessTaskQueue(pElapsed)
	if not gGroupCalendar_Queue.TasksDelay then
		return;
	end
	
	gGroupCalendar_Queue.TasksDelay = gGroupCalendar_Queue.TasksDelay - pElapsed;
	gGroupCalendar_Queue.TasksElapsed = gGroupCalendar_Queue.TasksElapsed + pElapsed;
	
	if gGroupCalendar_Queue.TasksDelay <= 0 then
		local	vNumTasks = table.getn(gGroupCalendar_Queue.Tasks);
		local	vIndex = 1;
		
		gGroupCalendar_Queue.TasksDelay = nil;
		
		local	vLatencyStartTime;
		
		if gGroupCalendar_Settings.DebugLatency then
			vLatencyStartTime = GetTime();
		end
		
		while vIndex <= vNumTasks do
			local	vTask = gGroupCalendar_Queue.Tasks[vIndex];
			
			vTask.mDelay = vTask.mDelay - gGroupCalendar_Queue.TasksElapsed;
			
			if vTask.mDelay <= 0 then
				table.remove(gGroupCalendar_Queue.Tasks, vIndex);
				vNumTasks = vNumTasks - 1;
				
				-- Perform the task
				
				vTask.mTaskFunc(vTask.mTaskParam);

			else
				if not gGroupCalendar_Queue.TasksDelay
				or vTask.mDelay < gGroupCalendar_Queue.TasksDelay then
					gGroupCalendar_Queue.TasksDelay = vTask.mDelay;
				end
				
				vIndex = vIndex + 1;
			end
		end
		
		if gGroupCalendar_Settings.DebugLatency then
			local	vElapsed = GetTime() - vLatencyStartTime;
			
			if vElapsed > 0.1 then
				Calendar_DebugMessage("Tasks took "..vElapsed.."s to execute ("..vNumTasks.." tasks)");
			end
		end
		
		gGroupCalendar_Queue.TasksElapsed = 0;
	end
end

function CalendarNetwork_ProcessInboundQueue(pElapsed)
	local	vNumInboundMessages = table.getn(gGroupCalendar_Queue.InboundMessages);
	
	if vNumInboundMessages > 0 then
		local	vCollisionDetected = false;
		
		gGroupCalendar_Queue.InboundDelay = gGroupCalendar_Queue.InboundDelay - pElapsed;
		
		if gGroupCalendar_Queue.InboundDelay <= 0 then
			-- Process one message
			
			local	vMessage = gGroupCalendar_Queue.InboundMessages[1];
			
			table.remove(gGroupCalendar_Queue.InboundMessages, 1);
			
			local	vLatencyStartTime;
			
			if gGroupCalendar_Settings.DebugLatency then
				vLatencyStartTime = GetTime();
			end
			
			CalendarNetwork_ProcessCommandString(vMessage.mSender, vMessage.mTrustLevel, vMessage.mMessage);
			
			if gGroupCalendar_Settings.DebugLatency then
				local	vElapsed = GetTime() - vLatencyStartTime;
				
				if vElapsed > 0.1 then
					Calendar_DebugMessage("Inbound message took "..vElapsed.."s to process");
					Calendar_DumpArray("Message", vMessage);
				end
			end

			gGroupCalendar_Queue.InboundDelay = gCalendarNetwork_RequestDelay.InboundQueue;
			
			if gGroupCalendar_Queue.InboundLastSender ~= vMessage.mSender then
				if gGroupCalendar_Queue.InboundTimeSinceLastMessage < gCalendarNetwork_RequestDelay.OutboundQueueGapMin then
					-- Collision between other senders detected
					
					if gGroupCalendar_Settings.DebugQueues then
						Calendar_DebugMessage("Collision detected between "..gGroupCalendar_Queue.InboundLastSender.." and "..vMessage.mSender);
					end
					
					vCollisionDetected = true;
				end
				
				gGroupCalendar_Queue.InboundLastSender = vMessage.mSender;
			end
			
			gGroupCalendar_Queue.InboundTimeSinceLastMessage = 0;
		end
		
		-- Terminate processing while there are any pending inbound messages and delay further
		-- processing of the outbound and request queues
		
		-- If there was a collision and we *weren't* part of it then increase the range to
		-- avoid allowing us to become a part of the next collision.  self should gradually eliminate
		-- transmittors from the collisions until someone successfully takes over the wire.
		-- self probably seems really counterintuitive, but the idea is to eliminate players who
		-- didn't participate in a collision from attempting to try again.  By doing self, each collision
		-- should eliminate a significant number of players from the accident, leaving only the actual
		-- victims to try again.  The next collision will then eliminate several of those players
		-- until within a few seconds only one player remains and that player will then have control
		-- and finish his transmission.
		
		local	vOutboundQueueGapMin = gCalendarNetwork_RequestDelay.OutboundQueueGapMin;
		local	vRequestQueueGapMin = gCalendarNetwork_RequestDelay.RequestQueueGapMin;
		
		if vCollisionDetected
		and gGroupCalendar_Queue.OutboundTimeSinceLastMessage > gCalendarNetwork_RequestDelay.OutboundQueueGapMin then
			-- Collision detected between other players so use a longer gap to make sure
			-- we're not part of the next collision

			vOutboundQueueGapMin = vOutboundQueueGapMin + gCalendarNetwork_RequestDelay.OutboundQueueGapWidth;
			vRequestQueueGapMin = vRequestQueueGapMin  + gCalendarNetwork_RequestDelay.RequestQueueGapWidth;
		end
		
		vRandom = math.random();
		
		if gGroupCalendar_Queue.OutboundDelay < vOutboundQueueGapMin then
			gGroupCalendar_Queue.OutboundDelay = vOutboundQueueGapMin + vRandom * gCalendarNetwork_RequestDelay.OutboundQueueGapWidth;
		end
		
		if gGroupCalendar_Queue.RequestsDelay < vRequestQueueGapMin then
			gGroupCalendar_Queue.RequestsDelay = vRequestQueueGapMin + vRandom * gCalendarNetwork_RequestDelay.RequestQueueGapWidth;
		end
		
		return true;
	end
	
	return false;
end

function CalendarNetwork_ProcessOutboundQueue(pElapsed)
	local	vNumOutboundMessages = table.getn(gGroupCalendar_Queue.OutboundMessages);
	
	if vNumOutboundMessages > 0 then
		gGroupCalendar_Queue.OutboundDelay = gGroupCalendar_Queue.OutboundDelay - pElapsed;
		
		if gGroupCalendar_Queue.OutboundDelay <= 0 then
			local	vLatencyStartTime;
			
			if gGroupCalendar_Settings.DebugLatency then
				vLatencyStartTime = GetTime();
			end
			
			-- Send one message

			local	vMessage = gGroupCalendar_Queue.OutboundMessages[1];
			
			table.remove(gGroupCalendar_Queue.OutboundMessages, 1);
			
			CalendarNetwork_SendMessage(vMessage);
			
			gGroupCalendar_Queue.OutboundDelay = gCalendarNetwork_RequestDelay.OutboundQueue;
			
			-- Reset the time since last message to figure out if we're part of a collision
			
			gGroupCalendar_Queue.OutboundTimeSinceLastMessage = 0;
			
			--
			
			if gGroupCalendar_Settings.DebugLatency then
				local	vElapsed = GetTime() - vLatencyStartTime;
				
				if vElapsed > 0.1 then
					Calendar_DebugMessage("Outbound message took "..vElapsed.."s to process");
					Calendar_DebugMessage(vMessage);
				end
			end
			
			-- Stop processing if self isn't the last outbound message, otherwise
			-- go ahead and allow the request queue to be processed
			
			if vNumOutboundMessages == 1 then
				gGroupCalendar_Queue.RequestsDelay = 0;
			else
				return true;
			end
		else
			-- Terminate processing while there are any pending outbound messages and delay further
			-- processing of the request queues
			
			gGroupCalendar_Queue.RequestsDelay = gCalendarNetwork_RequestDelay.RequestQueueGapMin + math.random() * gCalendarNetwork_RequestDelay.RequestQueueGapWidth;
			return true;
		end
	end
	
	return false;
end

function CalendarNetwork_ProcessRequestQueue(pElapsed, pSuppressProcessing)
	local	vNumRequests = 0;
	
	for vPriority, vRequests in pairs(gGroupCalendar_Queue.Requests) do
		vNumRequests = vNumRequests + table.getn(vRequests);
	end
	
	if vNumRequests > 0 then
		
		gGroupCalendar_Queue.RequestsDelay = gGroupCalendar_Queue.RequestsDelay - pElapsed;
		gGroupCalendar_Queue.RequestsElapsed = gGroupCalendar_Queue.RequestsElapsed + pElapsed;
		
		if gGroupCalendar_Queue.RequestsDelay <= 0 then
			-- Process one request
			
			local	vDidProcessRequest = pSuppressProcessing;
			local	vMinDelayForNextRequest = nil;
			
			local	vLatencyStartTime;
			local	vTotalRequests = 0;
			
			if gGroupCalendar_Settings.DebugLatency then
				vLatencyStartTime = GetTime();
			end
			
			for vPriority, vRequests in pairs(gGroupCalendar_Queue.Requests) do
				local	vIndex = 1;
				local	vNumRequestsselfQueue = table.getn(vRequests);
				
				vTotalRequests = vTotalRequests + vNumRequestsselfQueue;
				
				while vIndex <= vNumRequestsselfQueue do
					local	vRequest = vRequests[vIndex];
					
					if vRequest.mDelay > 0 then
						vRequest.mDelay = vRequest.mDelay - gGroupCalendar_Queue.RequestsElapsed;
						
						if vRequest.mDelay < 0 then
							vRequest.mDelay = 0;
						end
					end
					
					if vRequest.mDelay == 0
					and not vDidProcessRequest then
						
						table.remove(vRequests, vIndex);
						vNumRequestsselfQueue = vNumRequestsselfQueue - 1;
						
						CalendarNetwork_ProcessRequest(vRequest);
						
						vDidProcessRequest = true;
					else
						
						if not vMinDelayForNextRequest
						or vRequest.mDelay < vMinDelayForNextRequest then
							vMinDelayForNextRequest = vRequest.mDelay;
						end
						
						vIndex = vIndex + 1;
					end
				end -- while vIndex
			end -- for vPriority
			
			if gGroupCalendar_Settings.DebugLatency then
				local	vElapsed = GetTime() - vLatencyStartTime;
				
				if vElapsed > 0.1 then
					Calendar_DebugMessage("Requests took "..vElapsed.."s to process ("..vTotalRequests.." total requests)");
				end
			end
			
			if not vMinDelayForNextRequest
			or vMinDelayForNextRequest < gCalendarNetwork_RequestDelay.RequestQueue then
				vMinDelayForNextRequest = gCalendarNetwork_RequestDelay.RequestQueue;
			end
			
			gGroupCalendar_Queue.RequestsDelay = vMinDelayForNextRequest;
			gGroupCalendar_Queue.RequestsElapsed = 0;
		end
	end
end

function CalendarNetwork_ProcessQueues(pElapsed)	

	-- Process tasks
	
	CalendarNetwork_ProcessTaskQueue(pElapsed);
	
	-- Update the collision detection counters
	
	gGroupCalendar_Queue.InboundTimeSinceLastMessage = gGroupCalendar_Queue.InboundTimeSinceLastMessage + pElapsed;
	gGroupCalendar_Queue.OutboundTimeSinceLastMessage = gGroupCalendar_Queue.OutboundTimeSinceLastMessage + pElapsed;
	
	-- Process inbound messages
	
	local	vSuppressRequests = false;
	
	if CalendarNetwork_ProcessInboundQueue(pElapsed) then
		vSuppressRequests = true;
	
	elseif CalendarNetwork_ProcessOutboundQueue(pElapsed) then
		vSuppressRequests = true;
	end
	
	-- Process pending requests if there are no outbound messages pending
	
	CalendarNetwork_ProcessRequestQueue(pElapsed, vSuppressRequests);
end

function CalendarNetwork_ProcessRequest(pRequest)
	local	vDatabase = gGroupCalendar_GuildDatabase;
	
	if pRequest.mOpcode == "TRUST" then
		CalendarNetwork_SendTrustUpdate();
	elseif pRequest.mOpcode == "TRUSTREQ" then
		CalendarNetwork_SendTrustRequest();	
	elseif pRequest.mOpcode == "VERREQ" then	
		CalendarNetwork_QueueOutboundMessage("/VERREQ:"..gGroupCalendar_VersionString);
	elseif pRequest.mOpcode == "SYNCREQ" then	
		CalendarNetwork_QueueOutboundMessage("/SYNCREQ:"..gGroupCalendar_PlayerName);
		CalendarNetwork_LoadSyncQueue();
	elseif pRequest.mOpcode == "SYNCUPD" then
		CalendarNetwork_SendNextSyncUpdate();
	end
end

function CalendarNetwork_Initialize()
	gGroupCalendar_Initialized = true;
	
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("GroupCalendar Initializing: Starting initialization");
	end
	
	CalendarNetwork_PlayerGuildChanged();

	CalendarNetwork_JoinChannel2(nil);
	
	Calendar_GetPrimaryTradeskills();
end

gCalendarNetwork_GuildMemberRankCache = nil;

function CalendarNetwork_FlushCaches()
	--print ("FlushCaches");
	gCalendarNetwork_GuildMemberRankCache = nil;
	gCalendarNetwork_UserTrustCache = {};
end

function CalendarNetwork_GetGuildRosterCache()
	if gCalendarNetwork_GuildMemberRankCache then
		--print ("Return Roster Cache")
		return gCalendarNetwork_GuildMemberRankCache;
	end
	
	-- Clear the cache
	
	gCalendarNetwork_GuildMemberRankCache = {};
	
	-- Scan the roster and collect the info
	--print ("Building Guild Roster Cache")
	local		vNumGuildMembers = GetNumGuildMembers(true);
	for vIndex = 1, vNumGuildMembers do
		local	vName, vRank, vRankIndex, vLevel, vClass, vZone, vNote, vOfficerNote, vOnline = GetGuildRosterInfo(vIndex);
		
		if vName then -- Have to check for name in case a guild member gets booted while querying the roster
			vName = GroupCalendar_RemoveRealmName(vName);
			local	vMemberInfo =
			{
				Name = vName,
				RankIndex = vRankIndex,
				Level = vLevel,
				Class = vClass,
				Zone = vZone,
				OfficerNote = vOfficerNote,
				Online = vOnline
			};
			
			gCalendarNetwork_GuildMemberRankCache[strupper(vName)] = vMemberInfo;

		end
	end
	
	-- Dump any cached trust info
	
	gCalendarNetwork_UserTrustCache = {};
	
	return gCalendarNetwork_GuildMemberRankCache;
end

local	gGroupCalendar_SentLoadGuildRoster = false;

function CalendarNetwork_LoadGuildRosterTask()
	if IsInGuild() then
		--print ("Loading Guild Roster");
		GuildRoster();
	end
	
	-- Schedule another task to load the roster again
	-- in four minutes
	
	CalendarNetwork_QueueTask(
			CalendarNetwork_LoadGuildRosterTask, nil,
			120, "GUILDROSTER");
end

function CalendarNetwork_LoadGuildRoster()
	if not IsInGuild()
	or GetNumGuildMembers() > 0
	or gGroupCalendar_SentLoadGuildRoster then
		return;
	end
	
	gGroupCalendar_SentLoadGuildRoster = true;
	
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("CalendarNetwork_LoadGuildRoster: Loading");
	end
	
	CalendarNetwork_LoadGuildRosterTask();
end

function CalendarNetwork_UserIsInSameGuild(pUserName)
	if not IsInGuild() then
		return false, nil;
	end
	
	-- Build the roster
	
	if GetNumGuildMembers() == 0 then
		CalendarNetwork_LoadGuildRoster();
		return false, nil; -- have to return false for now since we don't really know
	end
	
	-- Search for the member
	
	local		vUpperUserName = strupper(pUserName);
	local		vRosterCache = CalendarNetwork_GetGuildRosterCache();
	local		vMemberInfo = vRosterCache[vUpperUserName];
	
	if not vMemberInfo then
		return false, nil;
	end

	return true, vMemberInfo.RankIndex;
end

function CalendarNetwork_SendMessage(pMessage)	
	C_ChatInfo.SendAddonMessage(gGroupCalendar_MessagePrefix0, pMessage, "GUILD");
end

function CalendarNetwork_ChannelMessageReceived(pSender, pMessage)
	CalendarNetwork_QueueInboundMessage(pSender, vTrustLevel, pMessage);	
end

function CalendarNetwork_GetGuildMemberIndex(pPlayerName)
	local		vUpperUserName = strupper(pPlayerName);
	local		vNumGuildMembers = GetNumGuildMembers(true);
	
	for vIndex = 1, vNumGuildMembers do
		local	vName = GetGuildRosterInfo(vIndex);
		
		if strupper(GroupCalendar_RemoveRealmName(vName)) == vUpperUserName then
			return vIndex;
		end
	end
	
	return nil;
end

function CalendarTrust_GetCurrentTrustGroup()
	if gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		return 2;
	elseif gGroupCalendar_PlayerSettings.Security.TrustGuildies then
		return 1;
	else
		return 0;
	end
end

function CalendarTrust_SetCurrentTrustGroup(pTrustGroup, pMinRank)
	if pTrustGroup == 2 then
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = true;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = false;
	elseif pTrustGroup == 1 then
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = false;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = true;
	else
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = false;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = false;
	end
	
	gGroupCalendar_PlayerSettings.Security.MinTrustedRank =  pMinRank;
	
	CalendarTrust_TrustSettingsChanged();
end

function CalendarTrust_TrustSettingsChanged()
	-- If you're the leader, send an update to everyone
	if gGroupCalendar_PlayerGuildRank == 0 then
		gGroupCalendar_PlayerSettings.Security.Version = gGroupCalendar_PlayerSettings.Security.Version + 1;	
		CalendarNetwork_QueueTrustUpdate();
	end
end

function CalendarNetwork_QueueTrustUpdate()
	vRequest = {};		
	vRequest.mOpcode = "TRUST";
	CalendarNetwork_QueueUniqueOpcodeRequest(vRequest, gCalendarNetwork_RequestDelay.RFUMin + math.random() * gCalendarNetwork_RequestDelay.RFURange);
end

function CalendarNetwork_QueueTrustRequest()
	vRequest = {};		
	vRequest.mOpcode = "TRUSTREQ";
	CalendarNetwork_QueueUniqueOpcodeRequest(vRequest, gCalendarNetwork_RequestDelay.RFUMin + math.random() * gCalendarNetwork_RequestDelay.RFURange);
end

function CalendarNetwork_SendTrustUpdate()	
	local trust = gGroupCalendar_PlayerSettings.Security;
	local	vRequest = "/TRUST:"..trust.Version..","..gGroupCalendar_PlayerGuild..","..tostring(trust.TrustAnyone)..","..tostring(trust.TrustGuildies)..","..trust.MinTrustedRank..",";
	for vPlayerName, vPlayerSecurity in pairs(trust.Player) do
		vRequest = vRequest..vPlayerName.."~"..vPlayerSecurity.."~";
	end
	CalendarNetwork_QueueOutboundMessage(vRequest);
end

function CalendarNetwork_SendTrustRequest()
	if gGroupCalendar_PlayerGuild then
		local trust = gGroupCalendar_PlayerSettings.Security;
		local	vRequest = "/TRUSTREQ:"..trust.Version..","..gGroupCalendar_PlayerGuild;	
		CalendarNetwork_QueueOutboundMessage(vRequest);
	end
end

function CalendarNetwork_ReceiveTrustUpdate(pSender, pGuild, pVersion, pTrustAnyone, pTrustGuildies, pMinRank, pPlayers)
	-- Ignore settings not from your guild
	if pGuild == gGroupCalendar_PlayerGuild then
		-- If you're the guild leader, compare what version you have to the received message. If it's newer, incremement the version and resend
		if gGroupCalendar_PlayerGuildRank == 0 and pVersion > gGroupCalendar_PlayerSettings.Security.Version then
			gGroupCalendar_PlayerSettings.Security.Version = pVersion + 1;
			CalendarNetwork_SendTrustUpdate();
		elseif pVersion > gGroupCalendar_PlayerSettings.Security.Version then
			-- Update the trust settings as the received version is higher
			if pTrustAnyone == "true" then
				gGroupCalendar_PlayerSettings.Security.TrustAnyone = true;
			else
				gGroupCalendar_PlayerSettings.Security.TrustAnyone = false;
			end
			if pTrustGuildies == "true" then
				gGroupCalendar_PlayerSettings.Security.TrustGuildies = true;
			else
				gGroupCalendar_PlayerSettings.Security.TrustGuildies = false;
			end			
			gGroupCalendar_PlayerSettings.Security.MinTrustedRank = tonumber(pMinRank);
			gGroupCalendar_PlayerSettings.Security.Player = pPlayers;
			gGroupCalendar_PlayerSettings.Security.Version = pVersion;
			gGroupCalendar_PlayerSettings.Security.Guild = pGuild
			
			CalendarTrust_TrustSettingsChanged();
			if GroupCalendarFrame.selectedTab == 2 then
				GroupCalendar_UpdateTrustedPlayerList();
				GroupCalendar_ShowPanel(2);
			end

		elseif pVersion == gGroupCalendar_PlayerSettings.Security.Version then
			-- Remove any pending trust updates in the message queue to avoid spamming
			CalendarNetwork_DeleteRequestByOpcode("TRUST");
		end
	end
end

function CalendarTrust_merge(a, b)
    if type(a) == 'table' and type(b) == 'table' then
        for k,v in pairs(b) do if type(v)=='table' and type(a[k] or false)=='table' then merge(a[k],v) else a[k]=v end end
    end
    return a
end

function CalendarTrust_TrustCheckingAvailable()
	if not gGroupCalendar_PlayerSettings.Security.TrustGuildies then
		return true;
	end
	
	-- Doesn't matter if they're not in a guild
	
	if not IsInGuild() then
		return true;
	end

	-- If trust is guild members only then verify that the roster has been loaded
	
	return GetNumGuildMembers() > 0;
end

function CalendarTrust_GetUserTrustLevel(pUserName)
	local	vUserTrustInfo = gCalendarNetwork_UserTrustCache[pUserName];
	
	if not vUserTrustInfo then
		vUserTrustInfo = {};
		vUserTrustInfo.mTrustLevel = CalendarTrust_CalcUserTrust(pUserName);
		gCalendarNetwork_UserTrustCache[pUserName] = vUserTrustInfo;
	end
	
	--print ("GetUserTrustLevel for "..pUserName.. ":" .. vUserTrustInfo.mTrustLevel)
	return vUserTrustInfo.mTrustLevel;
end

function CalendarTrust_UserIsTrusted(pUserName)
	return CalendarTrust_GetUserTrustLevel(pUserName) == 2;
end

function CalendarTrust_UserIsTrustedForRSVPs(pUserName)
	return CalendarTrust_GetUserTrustLevel(pUserName) >= 1;
end

function CalendarTrust_CalcUserTrust(pUserName)
	-- If the user is one of our own characters, then trust them completely
	
	local	vDatabase = EventDatabase_GetDatabase(pUserName, false);
	
	if vDatabase
	and vDatabase.IsPlayerOwned then
		if gGroupCalendar_Settings.DebugTrust then
			Calendar_DebugMessage("CalendarTrust_CalcUserTrust: Implicit trust for "..pUserName);
		end
		--print ("CalcUserTrust for " .. pUserName ..":2.0")
		return 2;
	end

	return CalendarTrust_CalcUserTrustExplicit(pUserName);
end

function CalendarTrust_CalcUserTrustExplicit(pUserName)	

	local	vPlayerSecurity = gGroupCalendar_PlayerSettings.Security.Player[pUserName];
	
	-- See if they're explicity allowed/forbidden
	
	if vPlayerSecurity ~= nil then

		if vPlayerSecurity == 1 then
			-- Trusted
			
			if gGroupCalendar_Settings.DebugTrust then
				Calendar_DebugMessage("CalendarTrust_CalcUserTrust: Explicit trust for "..pUserName);
			end
			--print ("CalcUserTrustExplicit for " .. pUserName ..":2.1")
			return 2;
		elseif vPlayerSecurity == 2 then
			-- Excluded
			
			if gGroupCalendar_Settings.DebugTrust then
				Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." explicity excluded");
			end
			--print ("CalcUserTrustExplicit for " .. pUserName ..":0.1")
			return 0;
		else
			Calendar_DebugMessage("GroupCalendar: Unknown player security setting of "..vPlayerSecurity.." for "..pUserName);
		end
	end
	
	-- Return true if we'll allow anyone in the channel
	
	if gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		if gGroupCalendar_Settings.DebugTrust then
			Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." trusted (all trusted)");
		end
		--print ("CalcUserTrustExplicit for " .. pUserName ..":2.2")
		return 2;
	end
	
	-- Return true if they're in the same guild and of sufficient rank
	
	if gGroupCalendar_PlayerSettings.Security.TrustGuildies then
		local	vIsInGuild, vGuildRank = CalendarNetwork_UserIsInSameGuild(pUserName);
		if vIsInGuild then
			if not gGroupCalendar_PlayerSettings.Security.MinTrustedRank
			or vGuildRank <= gGroupCalendar_PlayerSettings.Security.MinTrustedRank then
				if gGroupCalendar_Settings.DebugTrust then
					Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." trusted (guild member)");
				end
				--print ("CalcUserTrustExplicit for " .. pUserName ..":2.3")
				return 2;
			else
				if gGroupCalendar_Settings.DebugTrust then
					Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." partially trusted (guild member)");
				end
				--print ("CalcUserTrustExplicit for " .. pUserName ..":1.1")
				return 1;
			end
		end
	end
	
	-- Failed all tests
		
	if gGroupCalendar_Settings.DebugTrust then
		Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." not trusted (all tests failed)");
	end
	--print ("CalcUserTrustExplicit for " .. pUserName ..":0.2")
	return 0;
end

function CalendarNetwork_EventChanged(pDatabase, pEvent, pChangedFields)
	-- Don't record private events in the change history
	
	if pEvent.mPrivate then
		return;
	end
	
	-- Append a change record for the event
	
	--local	vChangeList = EventDatabase_GetCurrentChangeList(pDatabase);
	
	--EventDatabase_AppendEventUpdate(
	--		vChangeList,
	--		pEvent,
	--		EventDatabase_GetEventPath(pEvent),
	--		pChangedFields);
end

function CalendarTrust_GetNumTrustedPlayers(pTrustSetting)
	local	vNumPlayers = 0;
	
	for vPlayerName, vPlayerSecurity in pairs(gGroupCalendar_PlayerSettings.Security.Player) do
		if vPlayerSecurity == pTrustSetting then
			vNumPlayers = vNumPlayers + 1;
		end
	end
	
	return vNumPlayers;
end

function CalendarTrust_GetIndexedTrustedPlayers(pTrustSetting, pIndex)
	local	vPlayerIndex = 1;
	
	for vPlayerName, vPlayerSecurity in pairs(gGroupCalendar_PlayerSettings.Security.Player) do
		if vPlayerSecurity == pTrustSetting then
			if vPlayerIndex == pIndex then
				return vPlayerName;
			end
			
			vPlayerIndex = vPlayerIndex + 1;
		end
	end
	
	return nil;
end

function CalendarNetwork_PlayerGuildChanged()
	-- Update the guild in the database
	
	if gGroupCalendar_UserDatabase then
		gGroupCalendar_UserDatabase.Guild = gGroupCalendar_PlayerGuild;
	end
	
	-- Just return if we're not initialized yet
	
	if not gGroupCalendar_Initialized then
		EventDatabase_UpdateGuildRankCache();
		return;
	end
	
	-- Clear the roster load flag
	
	gGroupCalendar_SentLoadGuildRoster = false;
	
	CalendarNetwork_FlushCaches();
	
	-- If the player is unguilded then simply leave the data
	-- channel if it was auto-configured, flush any databases
	-- which are no longer trusted and exit
	
	if not IsInGuild() then
		gGroupCalendar_GuildDatabase = nil;
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("PlayerGuildChanged: Player is now unguilded");
		end			
		return;
	else
		-- Load the guild's database
		gGroupCalendar_GuildDatabase = EventDatabase_GetDatabase(gGroupCalendar_PlayerGuild, true);
	end
	-- Force the roster to reload or to start loading
	
	CalendarNetwork_LoadGuildRosterTask();
end

function CalendarNetwork_CheckPlayerGuild()
	local	vPlayerGuild;

	if IsInGuild() then
		vPlayerGuild, _, gGroupCalendar_PlayerGuildRank = GetGuildInfo("player");
		
		--if gGroupCalendar_PlayerName == "Magne" then
		--	gGroupCalendar_PlayerGuildRank = 0;
		--end		
		
		-- Just return if the server is lagging and the guild info
		-- isn't available yet
		
		if not vPlayerGuild then
			return;
		end

		gGroupCalendar_UserDatabase.GuildRank = gGroupCalendar_PlayerGuildRank;

	else
		vPlayerGuild = nil;
		gGroupCalendar_PlayerGuildRank = nil;
		gGroupCalendar_UserDatabase.GuildRank = nil;
	end

	if gGroupCalendar_PlayerGuild ~= vPlayerGuild then
		gGroupCalendar_PlayerGuild = vPlayerGuild;
		
		CalendarNetwork_PlayerGuildChanged();
	end

	-- Reset settings if not in a guild or the guild changes
	if gGroupCalendar_PlayerSettings and (gGroupCalendar_PlayerGuild == nil or gGroupCalendar_PlayerGuild ~= gGroupCalendar_PlayerSettings.Security.Guild) then
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = false;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = true;
		gGroupCalendar_PlayerSettings.Security.MinTrustedRank = 0;
		gGroupCalendar_PlayerSettings.Security.Player = {};
		gGroupCalendar_PlayerSettings.Security.Version = 0;
		gGroupCalendar_PlayerSettings.Security.Guild = gGroupCalendar_PlayerGuild
	end

	CalendarNetwork_QueueTrustRequest();

	CalendarNetwork_QueueSyncRequest();

	CalendarNetwork_QueueVersionRequest();

	if gGroupCalendar_PlayerGuild ~= nil then
		gGroupCalendar_GuildDatabase = EventDatabase_GetDatabase(gGroupCalendar_PlayerGuild, true);
	else
		gGroupCalendar_GuildDatabase = nil;
	end
end

function CalendarNetwork_SendEventUpdate(pEvent, pIncRSVPs)
	local cmd1 = "/EVT1:" .. pEvent.mDate .. "," .. pEvent.mGUID .. "," .. pEvent.mChangedDate .. "," .. pEvent.mChangedTime;
	cmd1 = cmd1 .. ",".. pEvent.mType;
	cmd1 = cmd1 .. ",".. pEvent.mStatus;
	cmd1 = cmd1 .. ",".. pEvent.mTime;
	cmd1 = cmd1 .. ",".. pEvent.mDuration;

	if pEvent.mMinLevel then
		cmd1 = cmd1 .. ",".. pEvent.mMinLevel;
	else
		cmd1 = cmd1 .. ",";
	end

	if pEvent.mMaxLevel then
		cmd1 = cmd1 .. ",".. pEvent.mMaxLevel;
	else
		cmd1 = cmd1 .. ",";
	end

	--print ("len:" .. strlen(cmd1));
	CalendarNetwork_QueueOutboundMessage(cmd1);

	local cmd2 = "/EVT2:" .. pEvent.mDate .. "," .. pEvent.mGUID .. "," .. pEvent.mChangedDate .. "," .. pEvent.mChangedTime;
	if pEvent.mTitle then
		cmd2 = cmd2 .. ",".. Calendar_EscapeString(pEvent.mTitle);	
	else
		cmd2 = cmd2 .. ",";
	end

	--print ("len:" .. strlen(cmd2));
	CalendarNetwork_QueueOutboundMessage(cmd2);
	

	if pEvent.mAttendance and pIncRSVPs and pEvent.mStatus ~= "D" then
		for vAttendee, vRSVP in pairs(pEvent.mAttendance) do
			CalendarNetwork_SendRSVPUpdate(pEvent, vRSVP);
		end
	end
end

function CalendarNetwork_SendRSVPUpdate(pEvent, pRSVP)
	
	local cmd1 = "/RSVP1:" .. pEvent.mDate .. "," .. pEvent.mGUID .. "," .. pRSVP.mName;
	if pRSVP.mDate then
		cmd1 = cmd1 .. ",".. pRSVP.mDate;
	else
		cmd1 = cmd1 .. ",";
	end

	if pRSVP.mTime then
		cmd1 = cmd1 .. ",".. pRSVP.mTime;
	else
		cmd1 = cmd1 .. ",";
	end

	if pRSVP.mOriginalDate then
		cmd1 = cmd1 .. ",".. pRSVP.mOriginalDate;
	else
		cmd1 = cmd1 .. ",";
	end

	if pRSVP.mOriginalTime then
		cmd1 = cmd1 .. ",".. pRSVP.mOriginalTime;
	else
		cmd1 = cmd1 .. ",";
	end

	if pRSVP.mRole then
		cmd1 = cmd1 .. ",".. pRSVP.mRole;
	else
		cmd1 = cmd1 .. ",";
	end 

	if pRSVP.mLevel then
		cmd1 = cmd1 .. ",".. pRSVP.mLevel;
	else
		cmd1 = cmd1 .. ",";
	end

	if pRSVP.mGuildRank then
		cmd1 = cmd1 .. ",".. pRSVP.mGuildRank;
	else
		cmd1 = cmd1 .. ","
	end

	if pRSVP.mClassCode then
		cmd1 = cmd1 .. ",".. pRSVP.mClassCode;
	else
		cmd1 = cmd1 .. ",";
	end
	 
	cmd1 = cmd1 .. ",".. pRSVP.mStatus;

	if pRSVP.mRaceCode then
		cmd1 = cmd1 .. ",".. pRSVP.mRaceCode;
	else
		cmd1 = cmd1 .. ",";
	end

	--print ("len:" .. strlen(cmd1));
	CalendarNetwork_QueueOutboundMessage(cmd1);

	local cmd2 = "/RSVP2:" .. pEvent.mDate .. "," .. pEvent.mGUID .. "," .. pRSVP.mName;
	if pRSVP.mDate then
		cmd2 = cmd2 .. ",".. pRSVP.mDate;
	else
		cmd2 = cmd2 .. ",";
	end

	if pRSVP.mTime then
		cmd2 = cmd2 .. ",".. pRSVP.mTime;
	else
		cmd2 = cmd2 .. ",";
	end
	
	if pRSVP.mComment then
		cmd2 = cmd2 .. ",".. Calendar_EscapeString(pRSVP.mComment);
	else
		cmd2 = cmd2 .. ",";
	end

	--print ("len:" .. strlen(cmd2));
	CalendarNetwork_QueueOutboundMessage(cmd2);

end

function CalendarNetwork_QueueVersionRequest()
	--if IsInGuild() then
		vRequest = {};		
		vRequest.mOpcode = "VERREQ";
		CalendarNetwork_QueueUniqueOpcodeRequest(vRequest, 5);
	--end
end

function CalendarNetwork_QueueSyncRequest()
	--if IsInGuild() then
		vRequest = {};		
		vRequest.mOpcode = "SYNCREQ";
		CalendarNetwork_QueueUniqueOpcodeRequest(vRequest, 5);
	--end
end

function CalendarNetwork_QueueSyncUpdate()
	vRequest = {};		
	vRequest.mOpcode = "SYNCUPD";
	CalendarNetwork_QueueUniqueOpcodeRequest(vRequest, gCalendarNetwork_RequestDelay.UPDMin + math.random() * gCalendarNetwork_RequestDelay.UPDRange);
end

function CalendarNetwork_LoadSyncQueue()
	-- Clear the queue
	gGroupCalendar_EventSyncQueue = {};

	if gGroupCalendar_GuildDatabase then
		gGroupCalendar_EventSyncQueue = {};

		for vEventDate, vEventList in pairs(gGroupCalendar_GuildDatabase.Events) do
			if vEventDate >= gGroupCalendar_MinimumEventDate then -- Don't send old events
				for vEventNum, vEvent in pairs(vEventList) do
					local vEventUpd = {
						mUpdateTpye = 1,
						mEvent = vEvent,
					}
					table.insert(gGroupCalendar_EventSyncQueue, vEventUpd);

					if vEvent.mAttendance and vEvent.mStatus ~= "D" then
						for vAttendee, vRSVP in pairs(vEvent.mAttendance) do
							local vRSVPUpd = {
								mUpdateTpye = 2,
								mEvent = vEvent,
								mRSVP = vRSVP,
							}
							table.insert(gGroupCalendar_EventSyncQueue, vRSVPUpd);
						end
					end
				end
			end
		end

		-- Queue sending the next update if items remain in the queue
		if table.getn(gGroupCalendar_EventSyncQueue) > 0 then
			CalendarNetwork_QueueSyncUpdate();
		end
	end
end

function CalendarNetwork_SendNextSyncUpdate()
	
	if table.getn(gGroupCalendar_EventSyncQueue) > 0 then
		local vUpd = gGroupCalendar_EventSyncQueue[1];
		table.remove(gGroupCalendar_EventSyncQueue, 1);

		if vUpd.mUpdateTpye == 1 then
			CalendarNetwork_SendEventUpdate(vUpd.mEvent, false);
		elseif vUpd.mUpdateTpye == 2 then
			CalendarNetwork_SendRSVPUpdate(vUpd.mEvent, vUpd.mRSVP);
		end
	end

	-- Queue sending the next update if items remain in the queue
	if table.getn(gGroupCalendar_EventSyncQueue) > 0 then
		CalendarNetwork_QueueSyncUpdate();
	end
end


