local addonName, addon = ...
local _G = _G

--
-- Used to merge tables
--
local function tableMerge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1;
end

--
-- This is the beast that create instances of a table, creating the feel of a class. I know
-- there are other ways to do this, but this way looks nice and works great. It's used in the Classy 
--
function addon.createInstance(classProtoType, constructor, existingData)
    local lookup_table = {};
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    local object = _copy(classProtoType);
    if (existingData) then
        object = tableMerge(object, existingData);
    end
    if (constructor and type(constructor) == "function") then
        if (object.constructor and type(object.constructor) == "function") then
            object:constructor(); -- base constructor
        end
        object.constructor = constructor; -- set the constructor
    end
    if (object.constructor) then
        object:constructor(); -- class constructor
        object.constructor = nil; -- single call only
    end
    return object;
end

-- Unused atm
local function is_iterable (val)
    if type(val) == 'table' then return true end
    local mt = getmetatable(val);
    if mt == true then return true end
    return mt and mt.__pairs and true
end

