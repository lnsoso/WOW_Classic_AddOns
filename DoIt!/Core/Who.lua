local addonName, addon = ...
local _G = _G

addon.LOADED_WHO = true;

addon.Who = {
    new = function (constructor)
        return addon.createInstance(addon.Who, constructor);
    end,
    constructor = function (self)
        -- WHO_LIST_UPDATE
        DoIt.Events.WHO_LIST_UPDATE:subscribe(function (self, arg1, arg2, arg3, arg4)
            addon.Debug("WHO_LIST_UPDATE: "..tostring(arg1)..", "..tostring(arg2)..", "..tostring(arg3)..", "..tostring(arg4))
        end)
    end,
    sendWho = function (self, filter)
        SetWhoToUI(true); -- WoW API
        return SendWho(filter); -- WoW API
    end,
    searchByName = function (self, playerName, levelFilter, callback)
        if (type(playerName) == "string" and playerName:len() > 0) then
            local filter = tostring(levelFilter) or "";
            self:sendWho('n-"'..playerName..'" '..filter);
        end
    end,
    searchByZone = function (self, zoneName, levelFilter, callback)
        if (type(zoneName) == "string" and zoneName:len() > 0) then
            local filter = tostring(levelFilter) or "";
            self:sendWho('z-"'..zoneName..'" '..filter);
        end
    end,
    searchByRace = function (self, raceName, levelFilter, callback)
        if (type(raceName) == "string" and raceName:len() > 0) then
            local filter = tostring(levelFilter) or "";
            self:sendWho('r-"'..raceName..'" '..filter);
        end
    end,
    searchByClass = function (self, className, levelFilter, callback)
        if (type(className) == "string" and className:len() > 0) then
            local filter = tostring(levelFilter) or "";
            self:sendWho('c-"'..className..'" '..filter);
        end
    end,
    searchByGuild = function (self, guild, levelFilter, callback)
        if (type(className) == "string" and className:len() > 0) then
            local filter = tostring(levelFilter) or "";
            self:sendWho('c-"'..className..'" '..filter);
        end
    end,
    searchByLevel = function (self, level, callback)
        local levelNum = tonumber(level);
        if (levelNum and levelNum > 0) then
            self:sendWho(tostring(level));
        end
    end,
    searchByLevelRange = function (self, lowestLevel, highestLevel, callback)
        local lowNum = tonumber(lowestLevel);
        local highNum = tonumber(highestLevel);
        if (lowNum and highNum and lowNum > 0 and lowNum <= highNum) then
            self:sendWho(tostring(lowNum).."-"..tostring(highNum));
        end
    end,
}