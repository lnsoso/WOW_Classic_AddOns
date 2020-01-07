--[[

    This component keeps a database of other players for the purpose of mesh networking

    See if it's possible for pull player names from channel rosters, like the "Chat Channels" frame does.

]]
-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

addon.Everyone = {
    new = function (constructor)
        return addon.createInstance(addon.Everyone, constructor);
    end,
    constructor = function (self)
        DoIt.Events.VARIABLES_LOADED:subscribe(function (name)
            self:registerEvents();
            self:registerFriends();
        end);
    end,
    registerFriends = function (self)
        local num, totalNum = C_FriendList.GetNumFriends();
        for idx=1, num do
            local info = C_FriendList.GetFriendInfoByIndex(idx);
            addon.Debug("Friend=> "..tostring(#info))
            for i=1, #info do
                addon.Debug("Friend=> "..tostring(info[i]))
                --info = {
                --    connected,
                --    name,
                --    className,
                --    area,
                --    notes,
                --    guid,
                --    level,
                --    dnd,
                --    afk,
                --    rafLinkType,
                --    mobile,
                --}
            end
        end
    end,
    registerEvents = function (self)
        -- Initialize the DoIt_MeshNetworking global saved variable
        local realm = GetRealmName();
        if (not DoIt_MeshNetworking) then DoIt_MeshNetworking = { } end
        DoIt_MeshNetworking[realm] = SingleArray.new(nil, DoIt_MeshNetworking[realm]); 

        DoIt.Events.CHAT_MSG_CHANNEL:subscribe(function (text, fullPlayerName)
            self:addFound(addon.GetShortname(fullPlayerName));
        end)
        DoIt.Events.CHAT_MSG_GUILD:subscribe(function (text, fullPlayerName)
            self:addFound(addon.GetShortname(fullPlayerName));
        end)
        DoIt.Events.CHAT_MSG_SAY:subscribe(function (text, fullPlayerName)
            self:addFound(addon.GetShortname(fullPlayerName));
        end)
        DoIt.Events.CHAT_MSG_YELL:subscribe(function (text, fullPlayerName)
            self:addFound(addon.GetShortname(fullPlayerName));
        end)
    end,
    whoIsQuery = function (self, search)
        C_FriendList.SetWhoToUi(true);
        C_FriendList.SendWho(search);
        --Name (n-"<char_name>")
        --Zone (z-"<zone_name>")
        --Race (r-"<race_name>")
        --Class (c-"<class_name>")
        --Guild (g-"<guild_name>")
        --Level ranges: (<lower_limit>-<higher_limit>)
        local num, totalNum = C_FriendList.GetNumWhoResults();
        info = C_FriendList.GetWhoInfo(index);
        --info = {
        --    fullName,
        --    fullGuildName,
        --    level,
        --    raceStr,
        --    classStr,
        --    area,
        --    filename,
        --    gender,
        --}
        C_FriendList.SortWho("sorting");

    end,
    addFound = function (self, name)
        local realm = GetRealmName();
        if (name and (type(name) == "string") and DoIt_MeshNetworking[realm]:add(name)) then
            -- addon.Debug("NewName: "..name..". Total = "..tostring(DoIt_MeshNetworking[realm]:length()))
            -- TODO: Query each name to see if they are using this addon
        end
    end,
}

