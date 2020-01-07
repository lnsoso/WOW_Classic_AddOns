-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

TimeSpan = {
    new = function (constructor)
        return addon.createInstance(TimeSpan, constructor);
    end,
    constructor = function (self)

    end,
}

DateTime = {
    new = function (constructor)
        return addon.createInstance(DateTime, constructor);
    end,
    constructor = function (self)

    end,    
}