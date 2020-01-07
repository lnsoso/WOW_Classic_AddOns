-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

Job = {
    new = function (job)
        return addon.createInstance(Job, function (self)
            self.callback = job;
        end);
    end,
    constructor = function (self)

    end,
    invoke = function (self)
        if (type(self.callback) == "function") then
            self.callback();
        end
    end,
}