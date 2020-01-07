--[[

    This class is used for the managment of both public and private channels

]]

local addonName, addon = ...
local _G = _G

addon.Channels = {
    ---
    --- Returns a table of all joined channels
    ---
    GetJoinedChannels = function ()
        local channels = { }
        local chanList = { GetChannelList() }
        for i=1, #chanList, 3 do
            table.insert(channels, {
                id = chanList[i],
                name = chanList[i+1],
                disabled = chanList[i+2], -- Is owned the 3rd parameter?
            })
        end
        return channels;
    end,
    ---
    --- Returns true if your are joined to the channel
    ---
    IsJoinedToChannel = function (channelName)
        local channelTable = addon.Channels.GetJoinedChannels();
        for i=1, #channelTable do
            local channelInfo = channelTable[i];
            if (channelInfo.name == channelName) then return true end
        end
        return false;
    end,
}

DoIt.Channels = addon.Channels;
