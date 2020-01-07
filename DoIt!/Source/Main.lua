--[[

    This is the final script that loads, it initializes nearly everything in one spot

]]
-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

addon.Main = (function()
    -- Global variables Init
    (function ()
        
    end)();

    -- Instance singletons
    (function ()
        -- Instance and place in the addon namespace
        DoIt.Events = addon.Events.new();

        -- Instance the Messsenger component, arg1 is the prefix for addon messages.
        DoIt.Msg = addon.Messenger.new("DoIt!");

        -- Instance the Everyone component
        DoIt.Everyone = addon.Everyone.new();

        -- Instance the addon-to-addon component
        DoIt.Comm = addon.Communications.new();

        -- Instance the Who class
        DoIt.Who = addon.Who.new();

        -- Instance and place in the addon namespace
        addon.app = addon.App.new();

    end)();

    -- Initialize statics
    (function ()
        -- Init Durability
        DoIt.Durability.init();

        -- Init Debugger
        DoIt.Debugger.init();

        -- Init Player
        DoIt.Player.init();
    end)();

    -- Event Handlers
    (function ()
        DoIt.Events.onPlayerReady:subscribe(function ()
            DoIt.Comm:test();
        end)
        DoIt.Events.UI_ERROR_MESSAGE:subscribe(function (_, message)
            --addon.Echo("\124cffFF0000\124Hitem:19:0:0:0:0:0:0:0\124h"..tostring(message).."\124h\124r");
        end)
        DoIt.Events.CHAT_MSG_CHANNEL:subscribe(function (text, channel, sender, target, zoneChannelId, localId, name, instanceId, _, _, _, guid)
            --addon.Echo("> "..tostring(zoneChannelId)..", "..tostring(localId)..", "..tostring(name)..", "..tostring(guid))
        end)
    end)();
end)();


function TEST_ARG( a, ... )
    if a then
        print(a)
        return TEST_ARG( ... )
    end
 end


