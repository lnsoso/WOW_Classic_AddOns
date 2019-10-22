local _addonName, _addon = ...;
local L = _addon:AddLocalization("enUS", true);
if L == nil then return; end

L["ERROR_SYNC_NOT_IN_GUILD"] = "You are not in a guild, guild sync disabled!";
L["ERROR_SYNC_CHANNEL_NAME"] = "Channel name must be defined when channel sync is active!";
L["ERROR_SYNC_CHANNEL_JOIN"] = "Failed to join sync channel! Is the password wrong?";
L["SYNC_CHANNEL_JOINED"] = "Joined sync channel!";

L["ERROR_ENTRY_ALREADY_EXISTS"] = "Entry for %s already exists, recieved from %s.";
L["ERROR_MAXIMUM_REACHED"] = "Maximum number of local entries reached, you can't just add everybody!";

L["CHATLINE_TARGET_FOUND"] = "Found a target -> %s";
L["CHATLINE_PLAYER_USED_SPELL"] = "Hostile player %s used |cFF77FF77|Hspell:%d|h[%s]|h|r!";
L["CHATLINE_PLAYER_USED_SPELL_LISTED"] = "Listed player %s used |cFF77FF77|Hspell:%d|h[%s]|h|r!";

L["SETTINGS_HEAD_GENERAL"] = "General";
L["SETTINGS_HEAD_SYNC"] = "Sync";
L["SETTINGS_HEAD_TESTSHOW"] = "Test/Show Features";
L["SETTINGS_HEAD_DATA"] = "Delete Data";
L["SETTINGS_PLAY_SOUND"] = "Play sounds"
L["SETTINGS_PLAY_SOUND_TT"] = "Play a sound when a target is found.";
L["SETTINGS_TEST_SOUND"] = "Sound for additional target";
L["SETTINGS_SHOW_KILLER_LIST"] = "Last attackers list on death";
L["SETTINGS_SHOW_KILLER_LIST_TT"] = "Show list of last attackers with an option to add them when you die.";
L["SETTINGS_STEALTH_ALERT_ALL"] = "Show stealth alert for all players";
L["SETTINGS_STEALTH_ALERT_ALL_TT"] = "If checked addon will show stealth/prowl alert for all players, not just those on the list.";
L["SETTINGS_SYNC_GUILD"] = "Sync with guild";
L["SETTINGS_SYNC_GUILD_TT"] = "Send and recieve entries over your guild.";
L["SETTINGS_SYNC_CHANNEL"] = "Sync with channel";
L["SETTINGS_SYNC_CHANNEL_TT"] = "Send and recieve entries over custom chat channel.";
L["SETTINGS_CHANNEL_NAME"] = "Channel name:";
L["SETTINGS_CHANNEL_PW"] = "Channel PW:";
L["SETTINGS_TRIGGER_CD"] = "Trigger CD:";
L["SETTINGS_TRIGGER_CD_TT"] = "After an alert wait this many seconds before triggering again. Found targets will still trigger a sound and chat message.";
L["SETTINGS_TARGET_CD"] = "Per target CD:";
L["SETTINGS_TARGET_CD_TT"] = "After triggering for a target completely ignore it for that many seconds.";
L["SETTINGS_TEST_ALERT"] = "Target alert";
L["SETTINGS_TEST_NEARBY"] = "Nearby hostiles";
L["SETTINGS_TEST_KILLER_LIST"] = "Last attackers";
L["SETTINGS_DELETE_SYNCDATA"] = "Recieved target data";
L["SETTINGS_DELETE_SYNCDATA_SUCCESS"] = "Data recieved from other players deleted!";
L["SETTINGS_DELETE_SYNCDATA_SUCCESS_NAME"] = "Data recieved from %s deleted!";
L["SETTINGS_DELETE_DATA_SUCCESS"] = "List was cleared!";
L["SETTINGS_SNAP_MINIMAP"] = "Snap button to minimap";
L["SETTINGS_SNAP_MINIMAP_TT"] = "Snap minimap button to minimap border.";
L["SETTINGS_DELETE_NBWLDATA"] = "Nearby hostile whitelist";
L["SETTINGS_DELETE_NBWLDATA_SUCCESS"] = "Whitelist for nearby hostiles cleared!";
L["SETTINGS_NEARBY_MAX_LABEL"] = "Nearby hostile list size";
L["SETTINGS_NEARBY_MAX_TT"] = "How many players the nearby hostile list can show at once.";

L["SLASH_CHAT_COMMANDS"] = "|cFFFFFF00" .. _addonName .. " commands:";
L["SLASH_CHAT_SETTINGS"] = "|cFF00FFFF%s %s|r Open settings panel";
L["SLASH_CHAT_OPEN"] = "|cFF00FFFF%s %s|r Open hitlist";
L["SLASH_CHAT_ADD"] = "|cFF00FFFF%s %s|r Open add dialog";
L["SLASH_CHAT_NEARBY"] = "|cFF00FFFF%s %s|r Open and unlock nearby hostiles list";
L["SLASH_CHAT_UPDATE"] = "|cFF00FFFF%s %s|r Send manual update request if sync options are active, should be unnecessary";

L["UI_BACK"] = "Back";
L["UI_CANCEL"] = "Cancel";

L["UI_LIST_ADDED"] = "(%s ago)";
L["UI_LIST_DELMEN_TITLE"] = "Delete Entries";
L["UI_LIST_DELMEN_DELALL"] = "ALL entries";
L["UI_LIST_DELMEN_DELALLREC"] = "ALL recieved entries";
L["UI_LIST_DELMEN_DELSPECIFIC"] = "From specific player";
L["UI_ADDFORM_TITLE"] = "Add Target";
L["UI_ADDFORM_NAME"] = "Name:";
L["UI_ADDFORM_REASON"] = "Reason:";
L["UI_ADDFORM_ADD_BUTTON"] = "Add";
L["UI_ADDFORM_ERR_NAME"] = "Target name missing or too short!";
L["UI_ADDFORM_ERR_NAME_INVALID"] = "Target name is invalid!";
L["UI_ADDFORM_ERR_REASON"] = "Reason missing or too short!";
L["UI_RMFORM_TITLE"] = "Remove Entries";
L["UI_RMFORM_DESC"] = "This will remove all entries recieved from the given player.";
L["UI_RMFORM_ERR_MISSING"] = "Name missing or too short!";
L["UI_RMFORM_REMOVE"] = "Delete";
L["UI_RMOTHER_TITLE"] = "Remove Foreign Entries";
L["UI_RMOTHER_DESC"] = "This will remove all entries recieved from other player.";
L["UI_RMALL_TITLE"] = "Remove all Entries";
L["UI_RMALL_DESC"] = "This will remove all entries from the list, including yours!";
L["UI_RMALL_REMOVE"] = "Delete Everything";

L["UI_LIST_BUTTON_NEARBY_SHOW"] = "Show nearby hostiles list";
L["UI_LIST_BUTTON_NEARBY_UNLOCK"] = "Unlock nearby hostiles list";
L["UI_LIST_BUTTON_NEARBY_UNLOCK_COMBAT"] = "Can't unlock in combat!";
L["UI_LIST_BUTTON_SETTINGS"] = "Open settings";
L["UI_LIST_BUTTON_ADD"] = "Add entry";
L["UI_LIST_BUTTON_DELETE"] = "Manage entries";

L["UI_KILLERLIST_TITLE"] = "Last Attackers";

L["TIME_UNIT_SECOND"] = "second";
L["TIME_UNIT_MINUTE"] = "minute";
L["TIME_UNIT_HOUR"] = "hour";
L["TIME_UNIT_DAY"] = "day";
L["TIME_UNIT_WEEK"] = "week";
L["TIME_UNIT_MONTH"] = "month";
L["TIME_UNIT_SECONDS"] = "seconds";
L["TIME_UNIT_MINUTES"] = "minutes";
L["TIME_UNIT_HOURS"] = "hours";
L["TIME_UNIT_DAYS"] = "days";
L["TIME_UNIT_WEEKS"] = "weeks";
L["TIME_UNIT_MONTHS"] = "months";

L["UI_MMB_OPEN"] = "Open " .. _addonName;

L["UI_TARGETDISP_TARGET_FOUND"] = "TARGET FOUND";
L["UI_TARGETDISP_TARGETING_LOCKED"] = "Targeting will work after combat!";
L["UI_TARGETDISP_TT_TARGET"] = "Leftclick to target.";
L["UI_TARGETDISP_TT_TARGET_HIDE"] = "Leftclick to target, rightclick to hide.";

L["UI_TT_PLAYER_ON_LIST"] = "Player is on hitlist:";
L["UI_TT_YOU"] = "you";
L["UI_TT_ADDED_BY"] = "(Added by %s %s ago)";

L["NBL_TITLE"] = "Nearby Hostiles";
L["UI_NBL_TT_TARGET_WL"] = "Leftclick to target, (shift-)rightclick to (permanently) hide.";