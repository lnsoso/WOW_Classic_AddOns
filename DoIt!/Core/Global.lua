local addonName, addon = ...
local _G = _G

--[[ Slash Commands ]]--
SLASH_DOIT_DEBUG1 = '/doitdebug';

SlashCmdList["DOIT_DEBUG"] = function (msg, value)
    if (msg:len() > 0) then
        msg = msg:lower();
        DoIt_Saved.Debug = ((msg == "on") or (msg == "true") or (msg == "1") or (msg == true));
    end
	if (DoIt_Saved.Debug) then state = "on." else state = "off." end
	DoIt.Echo("DoIt! Debugging is "..state);
end;

-- Grab the current system information
local version, build, buildDate, tocversion = GetBuildInfo();
addon.system = { };
addon.system.version = version;
addon.system.build = build;
addon.system.isClassic = (string.sub(version, 1, 2) == "1.");
addon.system.expansion = GetAccountExpansionLevel();

-- Initialize namespaces (tables)
DoIt = { };
DoIt_Saved = { }
DoIt.IsClassic = addon.system.isClassic;

function DoIt.GetSystemInfo()
    return addon.system;
end

---
--- Prints information to the default chat window
---
function addon.Echo(message)
	DEFAULT_CHAT_FRAME:AddMessage(message, 0.25, 0.5, 1.0, 1);
end

---
--- Like Echo() but will only show if debugging is enabled, unless isError is set; in which case
--- the error is shown even if debugging is not enabled, errors also have a red color
---
function addon.Debug(message, isError)
    if (DoIt_Saved.Debug or isError) then
        if (isError) then
            message = "\124cffFF0000\124Hitem:19:0:0:0:0:0:0:0\124h"..tostring(message).."\124h\124r";
        end
		DEFAULT_CHAT_FRAME:AddMessage(message, 0.25, 1.0, 1.0, 1);
	end
end

---
--- Makes use of the UIErrorsFrame to display information to the user without having to
--- clutter the default chat window
---
function addon.Alert(message, isError, fontSize)
    if (not fontSize or type(fontSize) ~= "number") then fontSize = 16 end
    if (isError) then message = "\124cffFF0000\124Hitem:19:0:0:0:0:0:0:0\124h"..tostring(message).."\124h\124r" end

    if (type(fontSize) == "number" and fontSize ~= 16) then
        local gfo = UIErrorsFrame:GetFontObject();
        local fontName, fontHeight, fontFlags = gfo:GetFont();
        
        -- Setup code that runs 2.25 seconds from now that will restore the font size to normal
        addon.Alert_onUpdateElapsed = 2.25;
        if (not addon.Alert_onUpdate) then
            addon.Alert_onUpdate = function(elapsed)
                addon.Alert_onUpdateElapsed = addon.Alert_onUpdateElapsed - elapsed;
                if (addon.Alert_onUpdateElapsed) > 0 then return end
                -- Restore Font Size
                gfo:SetFont(fontName, 16, fontFlags);
                UIErrorsFrame:SetFontObject(gfo);
                DoIt.Events.onUpdate:unsubscribe(addon.Alert_onUpdate);
                addon.Alert_onUpdate = nil;
            end
            DoIt.Events.onUpdate:subscribe(addon.Alert_onUpdate);
            gfo:SetFont(fontName, fontSize, fontFlags);
            UIErrorsFrame:SetFontObject(gfo);
        end
    end
    UIErrorsFrame:AddMessage(message, 1.0, 1.0, 0.0);
end

---
--- Returns the current player's full name
---
function addon.GetFullPlayerName()
    local name, realm = UnitName("player");
    if (not realm) then realm = GetRealmName() end
    return tostring(name).."-"..tostring(realm), name, realm;
end

---
--- Returns the "name-realm" format for a given name
---
function addon.GetFullname(name)
    if (name) then
        if (not string.find(name, "-")) then
            name = (name.."-"..tostring(GetRealmName()));
        end
        return name;
    end
end

---
--- Removes the realm from a player's name
---
function addon.GetShortname(name)
    if (name) then
        local idx = string.find(name, "-");
        if (not idx) then return name end
        return string.sub(name, 1, idx - 1);
    end
end

---
--- Get's information about the players current location
--- Return values: zone, area, world, zoneType, isManaged (Blizzard made the group), playerFacing
--- ZoneTypes: "unknown", "world", "dungeon" (despite group type), "raid" (despite group type), "battleground", or "arena".
--- addon.GetPlayerInfo() return parameter values. addon:GetPlayerInfo() returns a parameters in a table.
---
function addon.GetPlayerInfo(asTable)
	local isManaged = false;
	local name, instanceType, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapId, lfgID = GetInstanceInfo();
	--local _, _, , isRandom, BattleGroundID = GetBattlegroundInfo(BGindex);
	local isRestricted = (HasLFGRestrictions and HasLFGRestrictions());
	local area = GetRealZoneText();
	local zone = GetMinimapZoneText()
    local bindLocation = GetBindLocation();
    local facing = GetPlayerFacing(); -- in radians, 0 = north, values increasing counterclockwise

	if (instanceType == nil or instanceType == "") then instanceType = "unknown"
	elseif (instanceType == "none") then instanceType = "world"
	elseif (instanceType == "party") then instanceType = "dungeon"
	elseif (instanceType == "pvp") then instanceType = "battleground" end

	if (instanceType == "arena" or instanceType == "battleground" or isRestricted) then isManaged = true end
	if (zone == nil or zone == "") then zone = "unknown" end
	if (area == nil or area == "") then area = "unknown" end

    if (asTable) then
        return {
            zone = zone,
            area = area,
            name = name,
            type = instanceType,
            isManaged = isManaged,
            bindLocation = bindLocation,
            facing = facing
        }
    end
	return zone, area, name, instanceType, isManaged, bindLocation, facing;
end

--
-- Returns the mount info of one random favorite mount
--
local function GetOneFavoriteMount()
	local mountIdTable = C_MountJournal.GetMountIDs();
	local results = { };
	for idx = 1, #mountIdTable, 1 do
		local mountId = mountIdTable[idx];
		local _, _, _, isActive, isUsable, _, isFavorite = C_MountJournal.GetMountInfoByID(mountId)
		if (mountId and isFavorite and isUsable and not isActive) then
			table.insert(results, mountId);
		end
	end
	if (#results > 0) then
		-- Get the mount in-use and make sure it's not what random()'s value is.
		local rand = results[math.random(1, #results)];
		return C_MountJournal.GetMountInfoByID(rand);
	end
end

--
-- Summon a random favorite mount (GLOBAL FUNCTION)
--
function SummonRandomFavoriteMount()
	local _, _, _, _, _, _, _, _, _, _, _, mountId = GetOneFavoriteMount();
	if (mountId) then
		C_MountJournal.SummonByID(mountId);
	end
end

-- Exports
DoIt.Echo = addon.Echo
DoIt.Alert = addon.Alert
DoIt.Debug = addon.Debug
DoIt.GetFullPlayerName = addon.GetFullPlayerName;
DoIt.GetFullname = addon.GetFullname;
DoIt.GetShortname = addon.GetShortname;
DoIt.GetPlayerInfo = addon.GetPlayerInfo;
