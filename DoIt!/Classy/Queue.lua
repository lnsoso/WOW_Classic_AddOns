-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

Queue = {
    new = function (constructor)
        return addon.createInstance(Queue, constructor);
    end,

    constructor = function(self, ...)
        self._collection = Collection.new();
    end,

    add = function(self, arg)
       self._collection:pushleft(arg);
    end,

    next = function(self)
        return self._collection:popright();
    end,
}