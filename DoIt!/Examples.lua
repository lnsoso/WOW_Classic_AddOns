-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

--[[-----------------------------------------------------------------------------

    Gold Spam Blocker
    Note: Part of the code for this example is in Bindings.xml

--]]-----------------------------------------------------------------------------

BINDING_HEADER_DOIT = "DoIt!";
BINDING_NAME_DOIT_TOGGLE_GOLDSPAM = "Toggle Gold Spam Blocking";

-- default value
DoIt_Saved.IsGoldSpamBlockingEnabled = true;

local _inviteHandler = function (channelName, sender)
    if (channelName:lower():find("gold")) then
        DeclineChannelInvite(channelName);
        StaticPopup_Hide('CHAT_CHANNEL_INVITE');
        local added = C_FriendList.AddIgnore(sender)
        DoIt.Echo("[Channel Request Blocked] Channel request from "..tostring(sender).." was blocked and user was ignored. [Gold Spam]");
    end
end

local function _init()
    if (DoIt_Saved.IsGoldSpamBlockingEnabled) then
        DoIt.Events.CHANNEL_INVITE_REQUEST:subscribe(_inviteHandler);
    else
        DoIt.Events.CHANNEL_INVITE_REQUEST:unsubscribe(_inviteHandler);
    end
end

function DoIt.BindingGoldSpamToggle()
    DoIt_Saved.IsGoldSpamBlockingEnabled = not DoIt_Saved.IsGoldSpamBlockingEnabled;
    _init();
    local state = "disabled";
    if (DoIt_Saved.IsGoldSpamBlockingEnabled) then state = "enabled" end 
    DoIt.Alert("Gold spam blocking "..state);
end

DoIt.Events.VARIABLES_LOADED:subscribe(function (name)
    _init();
end);

--[[-------------------------------------- End of gold spam blocker example ---------------------------------------]]--


--[[-----------------------------------------------------------------------------

    Frame Mover
    Note: Part of the code for this example is in Bindings.xml

]]-------------------------------------------------------------------------------

BINDING_NAME_DOIT_TOGGLE_MOVER = "Toggle Frame Mover Start/Stop";
addon.FrameMoverMoving = false;

function DoIt.ToggleMover()
    addon.FrameMoverMoving = not addon.FrameMoverMoving;
    DoIt.Frame.MoveFocus(addon.FrameMoverMoving);
end

--[[-------------------------------------- End of frame mover example ---------------------------------------]]--

--[[-----------------------------------------------------------------------------

    Keeps you in the LookingForGroup channel if you are not inside and instance
    Note: Part of the code for this example is in Bindings.xml

]]-------------------------------------------------------------------------------
BINDING_NAME_DOIT_TOGGLE_LFG_MANAGE = "Toggle disabling of the LFG channel in instances";

local _LFG_handler = function ()
    local zone, area, world, zoneType, isManaged, bindLocation = DoIt.GetPlayerInfo()
    if (zoneType == "world") then
        -- Channel enabled
        if (not DoIt.Channels.IsJoinedToChannel("LookingForGroup")) then
            DoIt.Echo("Joining LFG channel")
            JoinChannelByName("LookingForGroup")
        end
    else
        -- channel disabled
        if (DoIt.Channels.IsJoinedToChannel("LookingForGroup")) then
            DoIt.Echo("Leaving LFG channel")
            LeaveChannelByName("LookingForGroup")
        end
    end
end

function DoIt.ToggleManage(init)
    if (not init) then
        DoIt_Saved.ManageLFG = not DoIt_Saved.ManageLFG;
    end
    
    local state = "{Unknown}";
    if (DoIt_Saved.ManageLFG) then
        state = "enabled";
        _LFG_handler();
        DoIt.Events.onZoneChanged:subscribe(_LFG_handler);
    else
        state = "disabled";
        DoIt.Echo("Joining LFG channel");
        JoinChannelByName("LookingForGroup");
        DoIt.Events.onZoneChanged:unsubscribe(_LFG_handler);
    end
    DoIt.Alert("LFG channel handling "..state);
end

DoIt.Events.VARIABLES_LOADED:subscribe(function (name)
    DoIt.ToggleManage(true);
end);


--[[-------------------------------------- End of LFG channel handler example ---------------------------------------]]--