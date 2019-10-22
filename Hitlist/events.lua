local _addonName, _addon = ...;
local L = _addon:GetLocalization();
local playerName = GetUnitName("player");
local realmName = GetRealmName();
local _, zoneType = GetInstanceInfo(); 

local frame = CreateFrame("Frame");
local handlers = {};


-- wohoo, lets save 1µs/frame in the biggest clusterfuck of fight if we're lucky!
local LastAttackers_Set = _addon.LastAttackers_Set;
local IsStealthSpell = _addon.IsStealthSpell;
local GetStealthSpellId = _addon.GetStealthSpellId;
local NearbyList_AddEnemy = _addon.NearbyList_AddEnemy;
local GetClassAndLevelFromSpellId = _addon.GetClassAndLevelFromSpellId;
local RemoveServerDash = _addon.RemoveServerDash;


--- Check if name is in target list
-- @param name The name to check
-- @return true if name is in target list
local function CheckName(name)
	if Hitlist_data[realmName].entries[name] ~= nil then
		_addon:Trigger(name);
		return true;
	end
	return false;
end


-- ADDON_LOADED
function handlers.ADDON_LOADED(addonName)
    if addonName ~= _addonName then 
        return; 
    end
	frame:UnregisterEvent("ADDON_LOADED");
	_addon:SetupSettings();
    Hitlist_data[realmName].localNames[playerName] = true;
end

-- PLAYER_LOGIN
function handlers.PLAYER_LOGIN()
    _addon:PrintDebug("PLAYER_LOGIN");
	frame:UnregisterEvent("PLAYER_LOGIN");
	
	if Hitlist_settings.syncGuild then
		local guildName = GetGuildInfo("player");
		if guildName == nil then
			_addon:PrintError(L["ERROR_SYNC_NOT_IN_GUILD"]);
			Hitlist_settings.syncGuild = false;
		end
	end
	
	if Hitlist_settings.syncChannel then
		_addon:PrintDebug("Channel sync is on");
		if GetNumDisplayChannels() > 0 then
			_addon:PrintDebug("Can already join channel");
			_addon:JoinSyncChannel();
		else
            _addon:PrintDebug("Can't join now, registering event");
            frame:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
            frame:RegisterEvent("CHANNEL_UI_UPDATE");  
		end
	end
	
	if Hitlist_settings.syncGuild then
		_addon:SyncRequestFullList("ADDON");
		_addon:SyncSendFullList("ADDON");
	end
    
    _addon:MainUI_UpdateList();
    _addon:NearbyList_Init();

    if Hitlist_settings.firstStart then
        _addon:MainUI_OpenList();
        _addon:NearbyList_Test();
        _addon:TargetNotification_SetTarget(playerName)
        _addon:LastAttackers_Demo();
        Hitlist_settings.firstStart = false;
    end
end

-- PLAYER_ENTERING_WORLD
function handlers.PLAYER_ENTERING_WORLD()
    _addon:PrintDebug("PLAYER_ENTERING_WORLD");
    _, zoneType = GetInstanceInfo();
end

-- CHANNEL_UI_UPDATE
function handlers.CHANNEL_UI_UPDATE()
    _addon:PrintDebug("CHANNEL_UI_UPDATE");
	frame:UnregisterEvent("CHANNEL_UI_UPDATE");
	_addon:JoinSyncChannel(true);
end

-- CHAT_MSG_CHANNEL_NOTICE
function handlers.CHAT_MSG_CHANNEL_NOTICE(joinLeave, a2, a3, channelName, a5, a6, channelType, channelNumber)
    _addon:PrintDebug("CHAT_MSG_CHANNEL_NOTICE");
    _addon:PrintDebug(joinLeave .. " " .. channelName);
    if _addon.syncChannelId == channelNumber then
        _addon:PrintDebug("Sync channel ready");
        _addon:SyncRequestFullList("CHANNEL");
	    _addon:SyncSendFullList("CHANNEL");
        frame:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE");
    end
end

-- PLAYER_REGEN_ENABLED
function handlers.PLAYER_REGEN_ENABLED()
	if UnitIsDead("player") and Hitlist_settings.showKillerList then
        if zoneType ~= "pvp" then
            _addon:LastAttackers_Show(); 
        end
    end
    _addon:LastAttackers_Clear();
    _addon:TargetNotification_CombatEnded();
    _addon:NearbyList_CombatEnd();
    _addon:MainUI_CombatEnd();
end

-- PLAYER_REGEN_DISABLED
function handlers.PLAYER_REGEN_DISABLED()
    _addon:NearbyList_CombatStart();
    _addon:MainUI_CombatStart();
end

-- PLAYER_TARGET_CHANGED
function handlers.PLAYER_TARGET_CHANGED()
    local name = UnitName("target");
    if name == nil then
        return;
    end
    CheckName(RemoveServerDash(name));
end

-- UPDATE_MOUSEOVER_UNIT
function handlers.UPDATE_MOUSEOVER_UNIT()
    local name = UnitName("mouseover");
    if name == nil then
        return;
    end
	CheckName(RemoveServerDash(name));
end

-- COMBAT_LOG_EVENT_UNFILTERED
function handlers.COMBAT_LOG_EVENT_UNFILTERED()
    local casterListed = false;
    local timestamp, eventType, _,_, sourceName, sourceFlags, _,_, targetName, targetFlags,_, _, spellName = CombatLogGetCurrentEventInfo();

    if bit.band(targetFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
        -- Add to last attackers if we are target and source is damage from a player
        if bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 and targetName == playerName and eventType:sub(eventType:len()-6) == "_DAMAGE" then
            LastAttackers_Set(RemoveServerDash(sourceName), timestamp);
        end

        if bit.band(targetFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then
            CheckName(RemoveServerDash(targetName));
        end
    end
    
    -- Caster is player and hostile
    if bit.band(sourceFlags, 0x440) == 0x440 then
        casterListed = CheckName(RemoveServerDash(sourceName)); 
        
        -- Check for stealth
        if casterListed or Hitlist_settings.stealthAlertAll then
            if eventType == "SPELL_AURA_APPLIED" then
                if IsStealthSpell(spellName) then
                    _addon:PrintWarn(L["CHATLINE_PLAYER_USED_SPELL"]:format(sourceName, GetStealthSpellId(spellName), spellName));
                end
            end
        end

        -- Add nearby hostile
        if zoneType ~= "pvp" and sourceName and eventType:sub(1,5) == "SPELL" then
            local class, level = GetClassAndLevelFromSpellId(spellName);
            NearbyList_AddEnemy(RemoveServerDash(sourceName), class, level);
        end
    end
end

-- CHAT_MSG_EMOTE
function handlers.CHAT_MSG_EMOTE(_, playerName)
	CheckName(RemoveServerDash(playerName));
end

-- CHAT_MSG_TEXT_EMOTE
function handlers.CHAT_MSG_TEXT_EMOTE(_, playerName)
	CheckName(RemoveServerDash(playerName));
end

-- CHAT_MSG_SAY
function handlers.CHAT_MSG_SAY(_, playerName)
	CheckName(RemoveServerDash(playerName));
end

-- CHAT_MSG_YELL
function handlers.CHAT_MSG_YELL(_, playerName)
	CheckName(RemoveServerDash(playerName));
end


frame:SetScript( "OnEvent",function(self, event, ...) 
	handlers[event](...);
end)
frame:RegisterEvent("PLAYER_REGEN_ENABLED");
frame:RegisterEvent("PLAYER_REGEN_DISABLED");
frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
frame:RegisterEvent("PLAYER_TARGET_CHANGED");
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
frame:RegisterEvent("PLAYER_LOGIN");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("CHAT_MSG_EMOTE");
frame:RegisterEvent("CHAT_MSG_TEXT_EMOTE");
frame:RegisterEvent("CHAT_MSG_SAY");
frame:RegisterEvent("CHAT_MSG_YELL");