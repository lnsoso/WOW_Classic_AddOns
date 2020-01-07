-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

---
--- This entire file is really just a place for me to test things, in the release version it will be removed
---

addon.Distance = {
    Inspect = 1, -- 28 yards
    Trade = 2, -- 11.11 yards
    Duel = 3, -- 9.9 yards
    Follow = 4 -- 28 yards
}

addon.InfoType = {
    Item = "item",
    Spell = "spell",
    Macro = "macro",
    Money = "money",
    Mount = "mount",
    Merchant = "merchant"
}

addon.App = {
    new = function(constructor)
        return addon.createInstance(addon.App, constructor)
    end,
    constructor = function(self)
        DoIt.Events.onZoneChanged:subscribe(
            function(zone, area, world, zoneType, isManaged, bindLocation)
                -- addon.Echo("onZoneChanged: "..tostring(zone).." |cffFF0000" .. tostring(area) .. "|r")
            end)

        DoIt.Events.onPlayerLogin:subscribe(
            function(fullPlayerName)
                -- addon.Echo("{{ Thank you "..tostring(fullPlayerName).." for choosing Classic Tools }}")
            end)

        -- static exports
        DoIt.DumpMouseFrameEvents = addon.App.DumpMouseFrameEvents;
    end,
    -- Get the frame that is under mouse, dumps any changes to this value as a DoIt.Debug output
    DumpMouseFrameEvents = function ()
        local currentValue = GetMouseFocus()
        DoIt.Events.onUpdate:subscribe(function(self, elapsed)
            local testValue = GetMouseFocus()
            if (testValue and testValue ~= currentValue) then
                currentValue = testValue;
                local parent = currentValue:GetParent();
                if (parent) then
                    DoIt.Debug("MouseOver: "..tostring(currentValue:GetName())..", "..tostring(parent:GetName()))
                else
                    DoIt.Debug("MouseOver: "..tostring(currentValue:GetName()))
                end
            end
        end)
    end,
    testOld = function(self)
        local idx = 0;
        DoIt_Export = { };
        DoIt_Export.IdToName = { };
        DoIt_Export.NameToId = { };
        while (idx < #addon.TexturesRetailName) do
            idx = idx + 1;
            local name = addon.TexturesRetailName[idx];
            print(tostring(name));
            for id, value in pairs(addon.ArtTexturePaths) do
                if (value == name) then 
                    DoIt_Export.IdToName[id] = value;
                    DoIt_Export.NameToId[name] = id;
                end
            end
        end
    end,
    onEvent = function(self, event, arg1, arg2)
        if (event == "CHAT_MSG_ADDON" or event == "COMBAT_LOG_EVENT_UNFILTERED") then
            return
        end
        addon.Echo("OnEvent: " .. tostring(event) .. " [ " .. tostring(arg1) ..
                       " , " .. tostring(arg2) .. " ]")
    end,
    onUpdate = function(self, elapsed)
        -- Simulated "event" that watches for cursor pick-ups
        -- local infoType, itemID, itemLink = GetCursorInfo()
        -- local shiftDown = IsShiftKeyDown();
        -- local supportedType = (type == "spell" or type == "item" or type == "petaction" or type == "macro" or type == "flyout" or type == "mount");

        -- Run monitor loop that constantly checks for aggro changes

        -- local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitThreatSituation("unit", "mob")
        --[[
            With otherunit specified
                nil = unit is not on otherunit's threat table.
                0 = not tanking, lower threat than tank.
                1 = not tanking, higher threat than tank.
                2 = insecurely tanking, another unit have higher threat but not tanking.
                3 = securely tanking, highest threat
            Without otherunit specified
                nil = unit is not on any other unit's threat table.
                0 = not tanking anything.
                1 = not tanking anything, but have higher threat than tank on at least one unit.
                2 = insecurely tanking at least one unit, but not securely tanking anything.
                3 = securely tanking at least one unit.
        ]] --
        --[[
            * Each group members threat individually against all attacking npc's
            ** Get group or raid list
            ** Get attacking npc list
            ** 
            
        ]]

        -- local status = UnitThreatSituation("unit"[, "otherunit"])
        -- UNIT_THREAT_LIST_UPDATE: "unitTarget"
        -- UNIT_THREAT_SITUATION_UPDATE: "unitTarget"
    end
}

