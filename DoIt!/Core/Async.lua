--[[

    This class is used to invoke functions async based on time, using OnUpdate 

]]

local addonName, addon = ...
local _G = _G

addon.Async = {
    new = function (constructor)
        return addon.createInstance(addon.Async, constructor);
    end,
    constructor = function (self)

    end,
}

addon.Timer = {
    new = function (interval, instance, func)
        return addon.createInstance(addon.Timer, function (self)
            self.TimeSinceLastUpdate = 0;
            self.callback = func;
            self.instance = instance;
            self.interval = interval;
            self.stopped = false;
        end);
    end,
    constructor = function (self)
        DoIt.Events.onUpdate:subscribe(function (elapsed)
            if (not self.stopped and self.callback and self.interval and self.interval > 0) then
                if (not elapsed) then return end
                self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 
                if (self.TimeSinceLastUpdate < self.interval) then return end
                self.TimeSinceLastUpdate = 0;
                self.callback(self.instance);
            end
        end);
    end,
    stop = function (self)
        self.stopped = true;
    end
}

addon.Countdown = {
    new = function (constructor)
        return addon.createInstance(addon.Countdown, constructor);
    end,
    constructor = function (self)

    end,
}

-- Exports
DoIt.Timer = addon.Timer