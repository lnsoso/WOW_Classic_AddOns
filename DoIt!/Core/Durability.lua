-- Initialize local namespace 
local addonName, addon = ...
local _G = _G
---
--- This needs to be redone, or moved to another class, it's more of an example than a reusable api
---
addon.Durability = {
    previousDurability = nil,
    init = function ()
        DoIt.Events.UPDATE_INVENTORY_DURABILITY:subscribe(function () addon.Durability.process(false) end);
        DoIt.Events.UPDATE_INVENTORY_ALERTS:subscribe(function () addon.Durability.process(true) end);
    end,
    get = function ()
        local totalCurrent, totalMax = 0, 0;
        for slot=0, 17 do
            local current, maximum = GetInventoryItemDurability(slot);
            if (current ~= nil and maximum ~= nil) then
                totalCurrent = totalCurrent + current;
                totalMax = totalMax + maximum;
            end
        end
        if (totalMax == 0) then totalMax = 1 end -- Prevents divide by zero
        return totalCurrent, totalMax;
    end,
    process = function (force)
        local totalCurrent, totalMax = addon.Durability.get();
        local percentage = totalCurrent / totalMax * 100;
        if (force or not previousDurability or previousDurability ~= percentage) then
            if (percentage < 0.4) then
                addon.Echo("You have significant durability damage; your durability is "..string.format("%0.1f", percentage).."%");
            else
                addon.Echo("Your durability is "..string.format("%0.1f", percentage).."%");
            end
            previousDurability = percentage;
        end
    end,
}

-- Export
DoIt.Durability = addon.Durability;
