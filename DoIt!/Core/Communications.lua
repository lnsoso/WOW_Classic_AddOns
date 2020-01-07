--[[

This component is for addon-to-addon communications
    * Make sure to throttle messages

]]
-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

--[[

Message Types
    * Warlock LFW (in group with a nearby party member)
    * A summon stone (in group with a nearby party member)
    * A mage with all at least two capital city portals LFW
    * A pax looking for summon
    * A pax looking for a mage portal to another capital. The pax must be near the mage, or in
      a capital city to make this request.
]]

addon.Communications = {
    new = function (constructor)
        return addon.createInstance(addon.Communications, constructor);
    end,
    constructor = function (self)
        --DoIt.Events.CHAT_MSG_ADDON:subscribe(function (prefix, text, channel, sender, target, zoneChannelId, localId, name, instanceId)
        --    if (prefix ~= DoIt.msg:getPrefix()) then return end;
        --    local fullName, shortName, realmName = addon.GetFullPlayerName();
        --    addon.Debug("["..tostring(target).."]: "..tostring(text)..", "..tostring(channel).." @"..tostring(sender));
        --end);
    end,
    test = function (self)
        -- Say "HELLO" to myself
        --DoIt.msg:sendWhisper(addon.GetFullPlayerName(), "HELLO", true)
        --DoIt.msg:sendWhisper("Nightness", "<msg>", true)
    end,
}

