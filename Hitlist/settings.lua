local _addonName, _addon = ...;
local L = _addon:GetLocalization();
local playerName = GetUnitName("player");
local realmName = GetRealmName();

local DEFAULTSETTINGS = {
    ["firstStart"] = true,
	["syncGuild"] = false,
	["syncChannel"] = false,
	["channelName"] = "",
	["channelPw"] = "",
	["triggerCd"] = 30,
	["triggerNameCd"] = 120,
	["showKillerList"] = true,
	["playSound"] = true,
	["debug"] = false,
	["stealthAlertAll"] = false,
	["snapToMinimap"] = true,
    ["nearbyListLocked"] = false,
    ["nearbyListShown"] = true,
    ["nearbyListMaxShow"] = 5,
	["version"] = GetAddOnMetadata(_addonName, "Version")
};

local oldChannel = "";
local oldPw = "";

--- Process new settings before they are saved to SV table
local function OnSettingChange(tempSettings)
    if tempSettings["triggerCd"] == nil or tempSettings["triggerCd"] == 0 then
        tempSettings["triggerCd"] = 1;
    end

    if tempSettings["triggerNameCd"] == nil or tempSettings["triggerNameCd"] == 0 then
        tempSettings["triggerNameCd"] = 1;
    end

	if tempSettings["snapToMinimap"] then
		HLUI_MinimapIcon:SnapToMinimap();
    end
    
    oldChannel = Hitlist_settings["channelName"];
    oldPw = Hitlist_settings["channelPw"];
end

--- Handle stuff after settings changed, if needed
local function AfterSettingsChange()
    if oldChannel ~= Hitlist_settings["channelName"] then
        if oldChannel:len() > 0 then
            _addon:PrintDebug("channel name was changed, ditching old sync channel");
            LeaveChannelByName(oldChannel);
        end
        if Hitlist_settings["channelName"]:len() > 1 then
            _addon:JoinSyncChannel();
        end
    elseif Hitlist_settings["channelName"]:len() > 0 and oldPw ~= Hitlist_settings["channelPw"] then
        _addon:PrintDebug("Channel pw changed, (try) joining again");
		_addon:JoinSyncChannel();
    end

    if Hitlist_settings["syncGuild"] then
		local guildName = GetGuildInfo("player");
		if guildName == nil then
			_addon:PrintError(L["ERROR_SYNC_NOT_IN_GUILD"]);
			Hitlist_settings["syncGuild"] = false;
		else
			_addon:SyncRequestFullList("ADDON");
			_addon:SyncSendFullList("ADDON");
		end
	end
end

--- Setup SV tables, check settings and setup settings menu
function _addon:SetupSettings()
	if Hitlist_data == nil then
		Hitlist_data = {};
	end
	
	if Hitlist_data[realmName] == nil then
		Hitlist_data[realmName] = {
			["localNames"] = {},
			["entries"] = {},
            ["nearbyWhitelist"] = {}
		};
	end
    
    if Hitlist_settings == nil then
		Hitlist_settings = DEFAULTSETTINGS;
	end
    
	for k, v in pairs(DEFAULTSETTINGS) do
		if Hitlist_settings[k] == nil then
			_addon:PrintDebug("Creating missing setting " .. k);
			Hitlist_settings[k] = v;
		end
	end

    local settings = _addon:GetSettingsBuilder();
    settings:Setup(Hitlist_settings, DEFAULTSETTINGS, nil, [[Interface\AddOns\Hitlist\img\logosettings]], 192, 48, nil, -16);
    settings:SetBeforeSaveCallback(OnSettingChange);
    settings:SetAfterSaveCallback(AfterSettingsChange);

    settings:MakeHeading(L["SETTINGS_HEAD_GENERAL"]);

    local row = settings:MakeSettingsRow(1);
    settings:MakeCheckboxOption("showKillerList", L["SETTINGS_SHOW_KILLER_LIST"], L["SETTINGS_SHOW_KILLER_LIST_TT"], row);
    settings:MakeCheckboxOption("playSound", L["SETTINGS_PLAY_SOUND"], L["SETTINGS_PLAY_SOUND_TT"], row);

    row = settings:MakeSettingsRow(1);
    settings:MakeCheckboxOption("snapToMinimap", L["SETTINGS_SNAP_MINIMAP"], L["SETTINGS_SNAP_MINIMAP_TT"], row);
    settings:MakeCheckboxOption("stealthAlertAll", L["SETTINGS_STEALTH_ALERT_ALL"], L["SETTINGS_STEALTH_ALERT_ALL_TT"], row);

    settings:UpdateRowGroup(1);

    settings:MakeEditBoxOption("triggerCd", L["SETTINGS_TRIGGER_CD"], 3, true, L["SETTINGS_TRIGGER_CD_TT"], nil, nil, 90);
    settings:MakeEditBoxOption("triggerNameCd", L["SETTINGS_TARGET_CD"], 3, true, L["SETTINGS_TARGET_CD_TT"], nil, nil, 90);
    
    settings:MakeSliderOption("nearbyListMaxShow", L["SETTINGS_NEARBY_MAX_LABEL"], L["SETTINGS_NEARBY_MAX_TT"], 1, 15, 1);

    settings:MakeHeading(L["SETTINGS_HEAD_SYNC"]);
    row = settings:MakeSettingsRow();
    settings:MakeCheckboxOption("syncGuild", L["SETTINGS_SYNC_GUILD"], L["SETTINGS_SYNC_GUILD_TT"], row);
    settings:MakeCheckboxOption("syncChannel", L["SETTINGS_SYNC_CHANNEL"], L["SETTINGS_SYNC_CHANNEL_TT"], row);
    settings:MakeEditBoxOption("channelName", L["SETTINGS_CHANNEL_NAME"], 14, false, nil, nil, nil, 90);
    settings:MakeEditBoxOption("channelPw", L["SETTINGS_CHANNEL_PW"], 14, false, nil, nil, nil, 90);

    settings:MakeHeading(L["SETTINGS_HEAD_TESTSHOW"]);
    row = settings:MakeSettingsRow();

    settings:MakeButton(L["SETTINGS_TEST_ALERT"], function() 
        _addon:Trigger(playerName, true); 
    end, row);

    settings:MakeButton(L["SETTINGS_TEST_KILLER_LIST"], function() 
        _addon:LastAttackers_Demo(); 
    end, row);

    settings:MakeButton(L["SETTINGS_TEST_NEARBY"], function() 
        _addon:NearbyList_Show();
        _addon:NearbyList_Test();
    end, row);

    settings:MakeButton(L["SETTINGS_TEST_SOUND"], function() 
        _addon:PlaySoundNotify(); 
    end, row);

    -- TODO: temporary placeholder until I implement a nicer method
    settings:MakeHeading(L["SETTINGS_HEAD_DATA"]);
    settings:MakeButton(L["SETTINGS_DELETE_NBWLDATA"], function() 
        wipe(Hitlist_data[realmName].nearbyWhitelist);
        _addon:PrintSuccess(L["SETTINGS_DELETE_NBWLDATA_SUCCESS"]);
    end);
end