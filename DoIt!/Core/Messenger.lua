--[[

This component is for addon-to-addon communications
    * Make sure to throttle messages

]]
-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

addon.Messenger = {
    -- The id is used for addon messages
    new = function (id)
        return addon.createInstance(addon.Messenger, function (self)
            self.ID = id
            local successfulRequest = C_ChatInfo.RegisterAddonMessagePrefix(id);
        end);
    end,
    getPrefix = function (self)
        return self.ID;
    end,
    sendParty = function (self, message, addonMsg)
        if (addonMsg) then
            return C_ChatInfo.SendAddonMessage(self.ID, message, "PARTY");
        end
        return SendChatMessage(message, "PARTY"); 
    end,
    sendRaid = function (self, message, addonMsg)
        if (addonMsg) then
            return C_ChatInfo.SendAddonMessage(self.ID, message, "RAID");
        end
        return SendChatMessage(message, "RAID"); 
    end,
    sendGuild = function (self, message, addonMsg)
        if (addonMsg) then
            return C_ChatInfo.SendAddonMessage(self.ID, message, "GUILD");
        end
        return SendChatMessage(message, "GUILD"); 
    end,
    sendBattleground = function (self, message, addonMsg)
        if (addonMsg) then
            return C_ChatInfo.SendAddonMessage(self.ID, message, "BATTLEGROUND");
        end
        return SendChatMessage(message, "BATTLEGROUND");
    end,
    sendWhisper = function (self, target, message, addonMsg)
        if (addonMsg) then
            return C_ChatInfo.SendAddonMessage(self.ID, message, "WHISPER", target);
        end
        return SendChatMessage(message, "WHISPER", DEFAULT_CHAT_FRAME.editBox.languageID, target) 
    end,
    sendChannel = function (self, target, message, addonMsg)
        -- if target needs to be the numeric channel number, obtain it using GetChannelName("channelName")
        if (type(target) == "string") then
            target = GetChannelName(target);
        end
        if (addonMsg) then
            return C_ChatInfo.SendAddonMessage(self.ID, message, "CHANNEL", target);
        end
        return SendChatMessage(message, "CHANNEL", DEFAULT_CHAT_FRAME.editBox.languageID, target)
    end,
    sendSay = function (self, message)
        return SendChatMessage(message, "SAY");
    end,
    sendRaidWarning = function (self, message)
        return SendChatMessage(message, "RAID_WARNING");
    end,
    sendYell = function (self, message)
        return SendChatMessage(message, "YELL");
    end,
    sendEmote = function (self, message) -- /me
        return SendChatMessage(message, "EMOTE");
    end,
    setAFK = function (self, message) -- AFK message
        return SendChatMessage(message, "AFK");
    end,
    setDND = function (self, message) -- DND message
        return SendChatMessage(message, "DND");
    end,
}