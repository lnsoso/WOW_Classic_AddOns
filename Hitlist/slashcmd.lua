local _addonName, _addon = ...;
local L = _addon:GetLocalization();

SLASH_HITLIST1 = "/hl";
SLASH_HITLIST2 = "/hitlist";
SlashCmdList["HITLIST"] = function(arg)
	if arg == "show" then
		_addon:MainUI_OpenList();
		return;
	end
	
	if arg == "add" then
		_addon:MainUI_ShowAddForm();
		return;
	end
    
    if arg == "settings" then
		-- Open settings panel
		InterfaceOptionsFrame_OpenToCategory(_addonName);
        -- REEEEEEEEEEEEEEEE
		InterfaceOptionsFrame_OpenToCategory(_addonName);
		return
	end
	
	if arg == "debug" then
		Hitlist_settings.debug = not Hitlist_settings.debug;
		local actstr = "off";
		if Hitlist_settings.debug then actstr = "on"; end
		print("Debug output is now " .. actstr);
		return;
	end
	
	if arg == "update" then
		_addon:SyncRequestFullList();
		return;
	end

	if arg == "nearby" then
		_addon:NearbyList_Show();
		return;
    end

	print(L["SLASH_CHAT_COMMANDS"]);
	print(L["SLASH_CHAT_SETTINGS"]:format(SLASH_HITLIST1, "settings"));
	print(L["SLASH_CHAT_OPEN"]:format(SLASH_HITLIST1, "show"));
	print(L["SLASH_CHAT_ADD"]:format(SLASH_HITLIST1, "add"));
	print(L["SLASH_CHAT_NEARBY"]:format(SLASH_HITLIST1, "nearby"));
	print(L["SLASH_CHAT_UPDATE"]:format(SLASH_HITLIST1, "update"));
end;