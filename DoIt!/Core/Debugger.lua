-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

DoIt.Debugger = {
    init = function ()
        DoIt.Events.ADDON_ACTION_BLOCKED:subscribe(function (arg1, arg2) DoIt.Debugger.blocked(arg1, arg2) end);
    end,
    blocked = function (arg1, arg2)
        DoIt.Debug("<Addon-Action-Blocked>: "..tostring(arg1)..", "..tostring(arg2));
    end,
}
