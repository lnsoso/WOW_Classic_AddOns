-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

-- Standard array
Array = {
    new = function (constructor, existingData)
        return addon.createInstance(Array, constructor, existingData);
    end,
    constructor = function (self)
        if (not self._type) then
            self._type = "Array";
            self._array = { }
        end
    end,
    length = function (self)
        return #self._array;
    end,
    add = function (self, value)
        self._array[#self._array + 1] = value;
    end,
    remove = function (self, index)
        table.remove(self._array, index);
    end,
    get = function (self)
        return self._array;
    end,
}

-- Each value can only exist once in a single array. This allows a simple remove-by-value
-- instead of remove-by-index.
SingleArray = {
    new = function (constructor, existingData)
        return addon.createInstance(SingleArray, constructor, existingData);
    end,
    constructor = function (self)
        if (not self._type) then
            self._type = "SingleArray";
            self._array = { };
        end
    end,
    length = function (self)
        return #self._array;
    end,
    find = function (self, value)
        for i = 1, #self._array do
            if (self._array[i] == value) then
                return i;
            end
        end
    end,
    add = function (self, value)
        local index = self:find(value);
        if (index) then return false end; -- Don't add twice
        self._array[#self._array + 1] = value;
        return true;
    end,
    remove = function (self, value)
        local index = self:find(value);
        if (not index) then return end; -- Value not found
        table.remove(self._array, index);
    end,
    get = function (self)
        return self._array;
    end,
}