-- scope stuff
karmarang = karmarang or {};
local c = karmarang;

function c:Println(str)
	if str then
		print("[Karmarang] " .. str);
	end
end

function c:Split(str, delimiter)
	local result = {};
	if str and str ~= "" then
    	for substr in string.gmatch(str, "[^".. delimiter.. "]*") do
	        if substr and substr ~= "" then
            	table.insert(result, substr);
			end
		end
    end
    return result;
end

function c:StartsWith(str, substr)
   return string.sub(str, 1, string.len(substr)) == substr;
end

function c:Trim(str)
	if str then
		return (str:gsub("^%s*(.-)%s*$", "%1"))
	end
	return "";
end

function c:Truncate(str, maxLength)
	if str then
		if strlen(str) > maxLength then
			return strsub(str, 1, maxLength - 4) .. " ...";
		else
			return str;
		end
	end
	return "";
end

function c:BoolToYesNo(value)
	if value then
		return c:GetText("yes");
	end
	return c:GetText("no");
end

function c:GetTableSize(t)
	local count = 0;
	if t then
		for _, __ in pairs(t) do
			count = count + 1;
		end
	end
    return count;
end

function c:GetDate(dateTime)
	if dateTime then
		local tmp = c:Split(dateTime, " ");
		if tmp[1] then
			return c:Trim(tmp[1]);
		else
			return;
		end
	end
	return date("%y-%m-%d");
end

function c:GetDateTime()
	return date("%y-%m-%d %H:%M:%S");
end

function c:GetSortedTableKeys(t)
	if t then
		local keys = {};
		for k, _ in pairs(t) do
			if k ~= c.CACHE_LATESTCOMMENTS then -- messy worarkound
				table.insert(keys, k);
			end
		end
		table.sort(keys, function(a, b) return a > b end); -- descending
		return keys;
	end
end

function c:FormatKarma(karma)
	if karma then
		--> input: -100 to 100
		karma = (karma + 1) / 2;
		--> output: 0 to 100

		return "|cff" .. c:KarmaToColor(karma) .. math.floor(karma * 100) .. "%|r";
	end
	return c:GetText("unknown");
end

function c:ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...);
		return r, g, b;
	elseif perc <= 0 then
		local r, g, b = ...;
		return r, g, b;
	end

	local num = select('#', ...) / 3;

	local segment, relperc = math.modf(perc * (num - 1));
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...);

	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

function c:KarmaToColor(karma)
	local red, green = c:ColorGradient(karma, 1,0,0, 1,1,0, 0,1,0);
	return string.format("%02x", red * 255) .. string.format("%02x", green * 255) .. "00";
end

function c:FormatComment(entry)
	if entry then
		if entry[c.ENTRY_AUTHOR] ~= c.charName then
			return "|cffffffff\"" .. c:Truncate(entry[c.ENTRY_COMMENT], KARMA_OPT[c.OPT_MAXLENGTH_TOOLTIP]) .. "\"|r";
		end
		return "\"" .. c:Truncate(entry[c.ENTRY_COMMENT], KARMA_OPT[c.OPT_MAXLENGTH_TOOLTIP]) .. "\"";
	end
end

function c:PrepareBroadcastMessage(entry)
	local msg = c.KARMA_PREFIX_BROADCAST .. "_";
	msg = msg .. entry[c.ENTRY_DATETIME] .. "_";
	msg = msg .. entry[c.ENTRY_AUTHOR] .. "_";
	msg = msg .. entry[c.ENTRY_PLAYERNAME] .. "_";
	msg = msg .. entry[c.ENTRY_KARMA];
	if entry[c.ENTRY_COMMENT] and entry[c.ENTRY_COMMENT] ~= "" then
		msg = msg .. "_" .. entry[c.ENTRY_COMMENT];
	end

	return msg;
end

function c:SearchPlayers(str)
	local result = {};
	if str and str ~= "" then
		str = strupper(str);
		for playerName, _ in pairs(KARMA_DB) do
			if strfind(strupper(playerName), str) then
				table.insert(result, playerName);
			end
		end
	end

	table.sort(result, function(a, b) return a < b end); -- ascending
	return result;
end

function c:RemoveRealmFromName(name)
	return name:gsub("%-" .. GetRealmName(), "");
end