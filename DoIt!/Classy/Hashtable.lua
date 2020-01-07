-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

Hashtable = {
    new = function (constructor)
        return addon.createInstance(Hashtable, constructor);
    end,
    constructor = function (self)

    end,
}