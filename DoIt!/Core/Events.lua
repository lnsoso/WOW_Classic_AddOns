-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

local additional_retail_event_names = {
    "SPELL_ACTIVATION_OVERLAY_HIDE",
    -- TODO..
}

local event_names = {
    "ACTIONBAR_SHOWGRID",
    "ACTIONBAR_HIDEGRID",
    "ACTIONBAR_PAGE_CHANGED",
    "ACTIONBAR_SLOT_CHANGED",
    "ACTIONBAR_UPDATE_COOLDOWN",
    "ACTIONBAR_UPDATE_STATE",
    "ACTIONBAR_UPDATE_USABLE",
    "ADDON_ACTION_BLOCKED",
    "ADDON_ACTION_FORBIDDEN",
    "ADDON_LOADED",
    "AREA_POIS_UPDATED",
    "AREA_SPIRIT_HEALER_IN_RANGE",
    "AREA_SPIRIT_HEALER_OUT_OF_RANGE",
    "AUCTION_HOUSE_SHOW",
    "AUCTION_ITEM_LIST_UPDATE",
    "AUCTION_BIDDER_LIST_UPDATE",
    "AUCTION_MULTISELL_START",
    "AUCTION_MULTISELL_UPDATE",
    "AUCTION_OWNED_LIST_UPDATE",
    "AUCTION_HOUSE_CLOSED",
    "BAG_NEW_ITEMS_UPDATED",
    "BAG_UPDATE",
    "BAG_UPDATE_COOLDOWN",
    "BAG_UPDATE_DELAYED",
    "BANKFRAME_CLOSED",
    "BANKFRAME_OPENED",
    "BATTLEFIELDS_SHOW",
    "BN_BLOCK_FAILED_TOO_MANY",
    "BN_BLOCK_LIST_UPDATED",
    "BN_CHAT_WHISPER_UNDELIVERABLE",
    "BN_CONNECTED",
    "BN_CUSTOM_MESSAGE_CHANGED",
    "BN_CUSTOM_MESSAGE_LOADED",
    "BN_DISCONNECTED",
    "BN_FRIEND_INFO_CHANGED",
    "BN_FRIEND_ACCOUNT_OFFLINE",
    "BN_FRIEND_ACCOUNT_ONLINE",
    "BN_FRIEND_INVITE_ADDED",
    "BN_FRIEND_INVITE_LIST_INITIALIZED",
    "BN_FRIEND_INVITE_REMOVED",
    "BN_FRIEND_LIST_SIZE_CHANGED",
    "BN_INFO_CHANGED",
    "BN_REQUEST_FOF_SUCCEEDED",
    "CANCEL_LOOT_ROLL",
    "CANCEL_SUMMON",
    "CHANNEL_INVITE_REQUEST",
    "CHANNEL_UI_UPDATE",
    "CHANNEL_COUNT_UPDATE",
    "CHANNEL_ROSTER_UPDATE",
    "CHANNEL_LEFT",
    "CHANNEL_FLAGS_UPDATED",
    "CHARACTER_POINTS_CHANGED",
    "CHAT_MSG_ADDON",
    "CHAT_MSG_BN_INLINE_TOAST_ALERT",
    "CHAT_MSG_AFK",
    "CHAT_MSG_BG_SYSTEM_NEUTRAL",
    "CHAT_MSG_DND",
    "CHAT_MSG_CHANNEL",
    "CHAT_MSG_CHANNEL_JOIN",
    "CHAT_MSG_CHANNEL_LEAVE",
    "CHAT_MSG_CHANNEL_NOTICE",
    "CHAT_MSG_CHANNEL_NOTICE_USER",
    "CHAT_MSG_COMBAT_FACTION_CHANGE", -- Rep increase
    "CHAT_MSG_COMBAT_HONOR_GAIN",
    "CHAT_MSG_COMBAT_MISC_INFO",
    "CHAT_MSG_COMBAT_XP_GAIN",
    "CHAT_MSG_EMOTE",
    "CHAT_MSG_GUILD",
    "CHAT_MSG_INSTANCE_CHAT",
    "CHAT_MSG_LOOT",
    "CHAT_MSG_MONEY",
    "CHAT_MSG_MONSTER_YELL",
    "CHAT_MSG_MONSTER_SAY",
    "CHAT_MSG_MONSTER_EMOTE",
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_PET_INFO",
    "CHAT_MSG_SAY",
    "CHAT_MSG_SKILL",
    "CHAT_MSG_SYSTEM",
    "CHAT_MSG_OPENING",
    "CHAT_MSG_TEXT_EMOTE",
    "CHAT_MSG_TRADESKILLS",
    "CHAT_MSG_TARGETICONS",
    "CHAT_MSG_YELL",
    "CHAT_MSG_WHISPER",
    "CHAT_MSG_WHISPER_INFORM",
    "CLOSE_INBOX_ITEM",
    "COMBAT_LOG_EVENT",
    "COMBAT_LOG_EVENT_UNFILTERED",
    "COMBAT_RATING_UPDATE",
    "COMBAT_TEXT_UPDATE",
    "COMMENTATOR_ENTER_WORLD",
    "COMPACT_UNIT_FRAME_PROFILES_LOADED",
    "CONFIRM_LOOT_ROLL",
    "CONFIRM_BINDER",
    "CONFIRM_SUMMON",
    "CONFIRM_XP_LOSS",
    "CONSOLE_MESSAGE",
    "CORPSE_IN_RANGE",
    "CORPSE_IN_INSTANCE",
    "CORPSE_OUT_OF_RANGE",
    "CORPSE_POSITION_UPDATE",
    "CURRENT_SPELL_CAST_CHANGED",
    "CURSOR_UPDATE",
    "CVAR_UPDATE",
    "DELETE_ITEM_CONFIRM",
    "DISPLAY_SIZE_CHANGED",
    "DYNAMIC_GOSSIP_POI_UPDATED",
    "EQUIP_BIND_CONFIRM",
    "EXECUTE_CHAT_LINE",        -- Fasinating event, will show each line of a magnet button macro (or presumably any macrotext usage in secure buttons)
    "FRIENDLIST_UPDATE",
    "GET_ITEM_INFO_RECEIVED",
    "GOSSIP_CONFIRM",
    "GOSSIP_CONFIRM_CANCEL",
    "GOSSIP_CLOSED",
    "GOSSIP_SHOW",
    "GROUP_JOINED",
    "GROUP_FORMED",
    "GROUP_LEFT",
    "GROUP_ROSTER_UPDATE",
    "GUILD_MOTD", -- arg1 == guild's motd
    "GUILD_ROSTER_UPDATE",
    "GUILD_RANKS_UPDATE",
    "HEARTHSTONE_BOUND",
    "IGNORELIST_UPDATE",
    "INCOMING_RESURRECT_CHANGED",
    "INITIAL_CLUBS_LOADED",
    "INSTANCE_BOOT_START",
    "INSTANCE_BOOT_STOP",
    "INSTANCE_GROUP_SIZE_CHANGED",
    "INSPECT_READY",
    "ITEM_DATA_LOAD_RESULT", -- Happens when character info window is opened
    "ITEM_LOCKED",
    "ITEM_LOCK_CHANGED",
    "ITEM_PUSH",
    "ITEM_RESTORATION_BUTTON_STATUS",
    "ITEM_TEXT_BEGIN",
    "ITEM_TEXT_READY",
    "ITEM_TEXT_CLOSED",
    "ITEM_UNLOCKED",
    "KNOWLEDGE_BASE_SYSTEM_MOTD_UPDATED", -- Guild motd related?
    "LEARNED_SPELL_IN_TAB",
    "LOADING_SCREEN_DISABLED",
    "LOADING_SCREEN_ENABLED",
    "LOOT_CLOSED",
    "LOOT_HISTORY_AUTO_SHOW",
    "LOOT_HISTORY_ROLL_CHANGED",
    "LOOT_HISTORY_ROLL_COMPLETE",
    "LOOT_ITEM_AVAILABLE", -- Think this is the roll to loot window
    "LOOT_ITEM_ROLL_WON",
    "LOOT_OPENED",
    "LOOT_READY",
    "LOOT_ROLLS_COMPLETE",
    "LOOT_HISTORY_FULL_UPDATE", -- Think this is when you win a loot roll, but your bags are full
    "LOOT_SLOT_CLEARED",
    "LOSS_OF_CONTROL_ADDED",
    "LOSS_OF_CONTROL_UPDATE",
    "LUA_WARNING",
    "MACRO_ACTION_FORBIDDEN",
    "MACRO_ACTION_BLOCKED",
    "MAP_EXPLORATION_UPDATED",
    "MAIL_CLOSED",
    "MAIL_FAILED",
    "MAIL_INBOX_UPDATE",
    "MAIL_SHOW",
    "MAIL_SEND_INFO_UPDATE",
    "MAIL_SEND_SUCCESS",
    "MAIL_SUCCESS", -- Hide the new mail icon?
    "MAP_EXPLORATION_UPDATED",
    "MERCHANT_SHOW",
    "MERCHANT_UPDATE",
    "MERCHANT_CLOSED",
    "MINIMAP_PING",
    "MINIMAP_UPDATE_ZOOM",
    "MINIMAP_UPDATE_TRACKING",
    "MIRROR_TIMER_STOP",
    "MIRROR_TIMER_START",
    "MODIFIER_STATE_CHANGED",
    "MUTELIST_UPDATE",
    "NAME_PLATE_UNIT_ADDED",
    "NAME_PLATE_UNIT_REMOVED",
    "NAME_PLATE_CREATED",
    "NEW_AUCTION_UPDATE",
    "NEW_RECIPE_LEARNED",
    "NEW_WMO_CHUNK",
    "PARTY_INVITE_REQUEST",
    "PARTY_LEADER_CHANGED",
    "PARTY_MEMBER_ENABLE",
    "PARTY_MEMBER_DISABLE",
    "PET_BAR_UPDATE",
    "PET_BAR_UPDATE_COOLDOWN",
    "PET_BAR_UPDATE_USABLE",
    "PORTRAITS_UPDATED",
    "PLAYER_ALIVE",
    "PLAYER_AVG_ITEM_LEVEL_UPDATE",
    "PLAYERBANKSLOTS_CHANGED",
    "PLAYER_CAMPING", -- 30 idle logout notification
    "PLAYER_CONTROL_LOST",
    "PLAYER_CONTROL_GAINED",
    "PLAYER_DAMAGE_DONE_MODS",
    "PLAYER_DEAD",
    "PLAYER_ENTERING_WORLD",
    "PLAYER_ENTER_COMBAT",
    "PLAYER_EQUIPMENT_CHANGED",
    "PLAYER_FLAGS_CHANGED",
    "PLAYER_GUILD_UPDATE",
    "PLAYER_LEAVE_COMBAT",
    "PLAYER_LEAVING_WORLD",
    "PLAYER_LEVEL_CHANGED",
    "PLAYER_LEVEL_UP",
    "PLAYER_LOGIN",
    "PLAYER_MONEY",
    "PLAYER_MOUNT_DISPLAY_CHANGED",
    "PLAYER_PVP_RANK_CHANGED",
    "PLAYER_PVP_KILLS_CHANGED",
    "PLAYER_SKINNED",
    "PLAYER_QUITING",
    "PLAYER_REGEN_DISABLED",
    "PLAYER_REGEN_ENABLED",
    "PLAYER_ROLES_ASSIGNED",
    "PLAYER_STARTED_MOVING",
    "PLAYER_STOPPED_MOVING",
    "PLAYER_TARGET_CHANGED",
    "PLAYER_TARGET_SET_ATTACKING", -- ???
    "PLAYER_TRADE_MONEY",
    "PLAYER_UNGHOST",
    "PLAYER_UPDATE_RESTING",
    "PLAYER_XP_UPDATE",
    "PLAYERBANKBAGSLOTS_CHANGED",
    "PVP_TIMER_UPDATE",
    "QUICK_TICKET_THROTTLE_CHANGED",
    "QUEST_ACCEPTED",
    "QUEST_COMPLETE",
    "QUEST_DETAIL",
    "QUEST_FINISHED",
    "QUEST_GREETING",
    "QUEST_ITEM_UPDATE",
    "QUEST_LOG_UPDATE",
    "QUEST_PROGRESS",
    "QUEST_REMOVED",
    "QUEST_TURNED_IN",
    "QUEST_WATCH_LIST_CHANGED",
    "QUEST_WATCH_UPDATE",
    "RAID_TARGET_UPDATE",
    "RESURRECT_REQUEST",
    "REQUEST_CEMETERY_LIST_RESPONSE",
    "SCREENSHOT_STARTED",
    "SCREENSHOT_SUCCEEDED",
    "SECURE_TRANSFER_CONFIRM_TRADE_ACCEPT",
    "SECURE_TRANSFER_CANCEL",
    "SEND_MAIL_COD_CHANGED",
    "SEND_MAIL_MONEY_CHANGED",
    "SKILL_LINES_CHANGED",
    "SOUND_DEVICE_UPDATE",
    "SOR_BY_TEXT_UPDATED",
    "SOR_COUNTS_UPDATED",
    "SPELLS_CHANGED",
    "SPELL_TEXT_UPDATE",
    "SPELL_POWER_CHANGED",
    "SPELL_DATA_LOAD_RESULT",
    "SPELL_UPDATE_USABLE",
    "SPELL_UPDATE_COOLDOWN",
    "SPELL_UPDATE_CHARGES",
    "START_LOOT_ROLL",
    "START_TIMER",
    "STORE_PURCHASE_LIST_UPDATED",
    "STORE_STATUS_CHANGED",
    "TABARD_CANSAVE_CHANGED",
    "TOGGLE_CONSOLE",
    "TAXIMAP_OPENED",
    "TAXIMAP_CLOSED",
    "TOKEN_STATUS_CHANGED",
    "TOKEN_DISTRIBUTIONS_UPDATED",
    "TOKEN_MARKET_PRICE_UPDATED", -- ???
    "TRADE_ACCEPT_UPDATE",
    "TRADE_CLOSED",
    "TRADE_MONEY_CHANGED",
    "TRADE_SHOW",
    "TRADE_POTENTIAL_BIND_ENCHANT",
    "TRADE_PLAYER_ITEM_CHANGED",
    "TRADE_REQUEST_CANCEL",
    "TRADE_TARGET_ITEM_CHANGED",
    "TRADE_SKILL_UPDATE",
    "TRADE_SKILL_SHOW",
    "TRADE_SKILL_CLOSE",
    "TRADE_UPDATE",
    "TRAINER_CLOSED",
    "TRAINER_DESCRIPTION_UPDATE",
    "TRAINER_SERVICE_INFO_NAME_UPDATE",
    "TRAINER_SHOW",
    "TRAINER_UPDATE",
    "UI_SCALE_CHANGED",
    "UI_ERROR_MESSAGE",
    "UI_INFO_MESSAGE",
    "UNIT_ATTACK",
    "UNIT_ATTACK_POWER",
    "UNIT_ATTACK_SPEED",
    "UNIT_AURA",
    "UNIT_COMBAT",
    "UNIT_CONNECTION",
    "UNIT_CLASSIFICATION_CHANGED",
    "UNIT_LEVEL",
    "UNIT_NAME_UPDATE",
    "UNIT_DAMAGE",
    "UNIT_DEFENSE",
    "UNIT_DISPLAYPOWER",
    "UNIT_FACTION",
    "UNIT_FLAGS",
    "UNIT_HAPPINESS",   -- A pet thing
    "UNIT_HEALTH",
    "UNIT_HEALTH_FREQUENT",
    "UNIT_INVENTORY_CHANGED",
    "UNIT_MAXHEALTH",
    "UNIT_MAXPOWER",        
    "UNIT_MODEL_CHANGED",
    "UNIT_OTHER_PARTY_CHANGED",
    "UNIT_PET", -- Pet summoned ?
    "UNIT_PHASE",
    "UNIT_PORTRAIT_UPDATE",
    "UNIT_POWER_UPDATE",
    "UNIT_POWER_FREQUENT",
    "UNIT_QUEST_LOG_CHANGED",
    "UNIT_RANGED_ATTACK_POWER",
    "UNIT_RANGEDDAMAGE",
    "UNIT_RESISTANCES",
    "UNIT_SPELL_HASTE",
    "UNIT_SPELLCAST_CHANNEL_UPDATE",
    "UNIT_SPELLCAST_DELAYED",
    "UNIT_SPELLCAST_FAILED",
    "UNIT_SPELLCAST_FAILED_QUIET",
    "UNIT_SPELLCAST_INTERRUPTED",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP",
    "UNIT_SPELLCAST_SENT",
    "UNIT_SPELLCAST_SUCCEEDED",
    "UNIT_SPELLCAST_CHANNEL_START",
    "UNIT_SPELLCAST_CHANNEL_STOP",
    "UNIT_STATS",
    "UNIT_TARGET",
    "UNIT_TARGETABLE_CHANGED",
    "UPDATE_ACTIVE_BATTLEFIELD",
    "UPDATE_ALL_UI_WIDGETS",
    "UPDATE_BATTLEFIELD_SCORE",
    "UPDATE_BATTLEFIELD_STATUS",
    "UPDATE_BINDINGS",
    "UPDATE_BONUS_ACTIONBAR",
    "UPDATE_CHAT_COLOR",
    "UPDATE_CHAT_COLOR_NAME_BY_CLASS",
    "UPDATE_CHAT_WINDOWS",
    "UPDATE_GM_STATUS",
    "UPDATE_INVENTORY_DURABILITY",
    "UPDATE_INVENTORY_ALERTS", -- You have a significant amount of durability damage.
    "UPDATE_EXHAUSTION",
    "UPDATE_FACTION",
    "UPDATE_FLOATING_CHAT_WINDOWS",
    "UPDATE_INSTANCE_INFO",
    "UPDATE_MACROS",
    "UPDATE_MOUSEOVER_UNIT",
    "UPDATE_PENDING_MAIL",
    "UPDATE_STEALTH",
    "UPDATE_SHAPESHIFT_COOLDOWN",
    "UPDATE_SHAPESHIFT_FORM",
    "UPDATE_SHAPESHIFT_FORMS",
    "UPDATE_SHAPESHIFT_USABLE",
    "UPDATE_TRADESKILL_RECAST",
    "UPDATE_WEB_TICKET",
    "VARIABLES_LOADED",
    "VOICE_CHAT_ACTIVE_OUTPUT_DEVICE_UPDATED",
    "VOICE_CHAT_ACTIVE_INPUT_DEVICE_UPDATED",
    "VOICE_CHAT_CHANNEL_JOINED",
    "VOICE_CHAT_CHANNEL_MEMBER_ADDED",
    "VOICE_CHAT_CHANNEL_MEMBER_REMOVED",
    "VOICE_CHAT_CHANNEL_REMOVED",
    "VOICE_CHAT_CHANNEL_MEMBER_VOLUME_CHANGED",
    "VOICE_CHAT_CONNECTION_SUCCESS",
    "VOICE_CHAT_DEAFENED_CHANGED",
    "VOICE_CHAT_INPUT_DEVICES_UPDATED",
    "VOICE_CHAT_LOGIN",
    "VOICE_CHAT_MUTED_CHANGED",
    "VOICE_CHAT_OUTPUT_DEVICES_UPDATED",
    "VOICE_CHAT_PTT_BUTTON_PRESSED_STATE_CHANGED",
    "WHO_LIST_UPDATE",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED",
    "ZONE_CHANGED_NEW_AREA",
}

addon.Events = {
    new = function (constructor)
        return addon.createInstance(addon.Events, constructor);
    end,
    constructor = function (self)
        -- Custom event handlers
        self.onPlayerReady = addon.EventHandler.new();
        self.onPlayerLogin = addon.EventHandler.new();
        self.onZoneChanged = addon.EventHandler.new();
        self.onUpdate = addon.EventHandler.new()

        -- Regular event handlers
        for i=1, #event_names do
            self[event_names[i]] = addon.EventHandler.new();
        end

        -- additional_retail_event_names
        if (not addon.system.isClassic) then
            for i=1, #event_names do
                self[additional_retail_event_names[i]] = addon.EventHandler.new();
            end
        end

        -- Create a frame for receiving the events
        local frame = CreateFrame("Frame", "GenericEventHandlerWindow");
        frame:RegisterAllEvents();
        frame:SetScript("OnUpdate", function (_, elapsed)
            self:update(elapsed)
        end);
        frame:SetScript("OnEvent", function (_, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
            self:parser(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
        end);
        frame:Show();
    end,
    parser = function (self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
        -- Custom Events
        if (event == "PLAYER_LOGIN" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA") then
            local zone, area, world, zoneType, isManaged, bindLocation = addon.GetPlayerInfo()
            if (zone == "unknown") then
                self.onPlayerLogin:invoke(addon.GetFullPlayerName());
            else
                self.onZoneChanged:invoke(zone, area, world, zoneType, isManaged, bindLocation);
            end
            if (not self.stop) then 
                self.onPlayerReady:invoke();
                self.stop = true;
            end
        end
        -- Blizzard Events
        if (not self[event]) then
            addon.Debug("Unhandled Event: "..tostring(event)..", "..tostring(arg1)..", "..tostring(arg2)..", "..tostring(arg3)..", "..tostring(arg4));
        else
            -- Dumps early events (debug only)
            --if (not self.stop and not string.find(event, "UPDATE")) then
            --if (not string.find(event, "UPDATE") and not event:find("UNFILTERED") and not event:find("CHAT")) then
                --addon.Debug("<Event> "..tostring(event)..", "..tostring(arg1)..", "..tostring(arg2));
            --end
            self[event]:invoke(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        end
    end,
    update = function (self, elapsed)
        self.onUpdate:invoke(elapsed);
    end,
}

addon.EventHandler = {
    new = function (constructor)
        return addon.createInstance(addon.EventHandler, constructor);
    end,
    constructor = function (self)
        self._listeners = SingleArray.new();
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
    invoke = function (self, ...)
        -- Invoke all functions in _listeners.
        local listeners = self._listeners:get();
        for key, value in ipairs(listeners) do
            if (listeners[key]) then
                listeners[key](...);
            end
        end
    end,
}
