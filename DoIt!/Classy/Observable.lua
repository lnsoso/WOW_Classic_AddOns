-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

Observable = {
    new = function (initialValue)
        return addon.createInstance(Observable, function (self)
            self._value = initialValue;
        end);
    end,
    constructor = function (self)
        self._listeners = SingleArray.new();
    end,
    get = function (self) 
        return self._value;
    end,
    set = function (self, value)
        if (value ~= self._value) then
            self._value = value;
            self:invokeValueChanged(value);
        end
    end,
    subscribe = function (self, func)
        -- Subscribe to value changed events
        if (type(func) == "function") then
            self._listeners:add(func);
        end
    end,
    unsubscribe = function (self, func)
        -- Unsubscribe to value changed events
        self._listeners:remove(func);
    end,
    invokeValueChanged = function (self, newValue)
        -- Invoke all functions in _listeners.
        local listeners = self._listeners:get();
        for key, value in ipairs(listeners) do
            if (listeners[key]) then
                listeners[key](newValue);
            end
        end
    end,
}