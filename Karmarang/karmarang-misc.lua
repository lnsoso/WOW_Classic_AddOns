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

function c:TableContainsValue(t, value)
	if t and value and value ~= "" then
		for _, tValue in ipairs(t) do
			if tValue == value then
				return true;
			end
		end
	end
end

function c:GetTimestamp(dateTime)
	if dateTime and dateTime ~= "" then
		local t, dateStr, timeStr = {}, unpack(c:Split(dateTime, " "));

		if dateStr then
			t.year, t.month, t.day = unpack(c:Split(dateStr, "-"));
			if strlen(t.year) == 4 then
				t.year = string.sub(t.year, 3, 4);
			end

			if timeStr then
				t.hour, t.min, t.sec = unpack(c:Split(timeStr, ":"))
			end

			if not tonumber(t.year) or not tonumber(t.month) or not tonumber(t.day) then
				return;
			end
		end

		return tostring(time({year="20" .. t.year, month=t.month, day=t.day, hour=t.hour, min=t.min, sec=t.sec}));
	else
		return tostring(GetServerTime());
	end
end

function c:FormatTimeStamp(timeStamp)
	local seconds = tonumber(timeStamp)

	if seconds <= 0 then
		return "00:00:00";
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600));
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)));
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
		return hours .. ":" .. mins .. ":" .. secs;
	end
end

function c:GetSortedTableKeys(t)
	if t then
		local keys = {};
		for k, _ in pairs(t) do
			local num = tonumber(k);
			if num then
				table.insert(keys, num);
			else
				table.insert(keys, k);
			end
		end
		table.sort(keys, function(a, b) return a > b end); -- descending
		return keys;
	end
end

function c:FormatKarma(karma, count)
	if karma then
		local result = "|cff" .. c:KarmaToColor(karma) .. math.floor(karma * 100) .. "%|r";
		if count and count > 0 then
			result = result .. " (" .. count .. ")";
		end
		return result;
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
		if entry[c.ENTRY_AUTHOR] ~= c.hashTag then
			return "|cffffffff\"" .. c:Truncate(entry[c.ENTRY_COMMENT], KARMA_OPT[c.OPT_MAXLENGTH_TOOLTIP]) .. "\"|r";
		end
		return "\"" .. c:Truncate(entry[c.ENTRY_COMMENT], KARMA_OPT[c.OPT_MAXLENGTH_TOOLTIP]) .. "\"";
	end
end

function c:PrepareBroadcastMessage(entry)
	local msg = c.KARMA_PREFIX_BROADCAST;
	msg = msg .. entry[c.ENTRY_TIMESTAMP] .. "_";
	msg = msg .. entry[c.ENTRY_AUTHOR] .. "_";
	msg = msg .. entry[c.ENTRY_PLAYERNAME] .. "_";
	msg = msg .. entry[c.ENTRY_KARMA];
	if entry[c.ENTRY_COMMENT] and entry[c.ENTRY_COMMENT] ~= "" then
		msg = msg .. "_" .. entry[c.ENTRY_COMMENT];
	end

	return msg;
end

function c:AddRealmName(name)
	if name then
		return c:RemoveRealmFromName(name) .. "-" .. c.realmName; -- make sure to dont add it twice
	end
	return name;
end

function c:RemoveRealmFromName(name)
	if name then
		return name:gsub("%-" .. c.realmName, "");
	end
	return name;
end

function c:StringHash(text)
	local counter = 1
	local len = string.len(text)
	for i = 1, len, 3 do
	  counter = math.fmod(counter*8161, 4294967279) +  -- 2^32 - 17: Prime!
		  (string.byte(text,i)*16776193) +
		  ((string.byte(text,i+1) or (len-i+256))*8372226) +
		  ((string.byte(text,i+2) or (len-i+256))*3932164)
	end
	return math.fmod(counter, 4294967291) -- 2^32 - 5: Prime (and different from the prime in the loop)
  end

function c:GetVersionComponents(version)
	version = version or c.KARMA_VERSION;
	local result = c:Split(version, ".");
	return tonumber(result[1]), tonumber(result[2]), tonumber(result[3]);
end

function c:IsVersionBelow(version, currentVersion)
	version = version or KARMA_OPT[c.INFO_VERSION];
	local major, minor, rev = c:GetVersionComponents(version);
	minor = minor or 0;
	rev = rev or 0;

	currentVersion = currentVersion or c.KARMA_VERSION;
	local cMajor, cMinor, cRev = c:GetVersionComponents(currentVersion);
	cMinor = cMinor or 0;
	cRev = cRev or 0;

	return not cMajor or not cMinor or cMajor < major or (cMajor == major and cMinor < minor) or (cMajor == major and cMinor == minor and cRev < rev);
end

function c:IsVersionAbove(version, currentVersion)
	version = version or KARMA_OPT[c.INFO_VERSION];
	local major, minor, rev = c:GetVersionComponents(version);
	minor = minor or 0;
	rev = rev or 0;

	currentVersion = currentVersion or c.KARMA_VERSION;
	local cMajor, cMinor, cRev = c:GetVersionComponents(currentVersion);
	cMinor = cMinor or 0;
	cRev = cRev or 0;

	return not cMajor or not cMinor or cMajor > major or (cMajor == major and cMinor > minor) or (cMajor == major and cMinor == minor and cRev > rev);
end

function c:Deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            setmetatable(copy, c:Deepcopy(getmetatable(orig), copies))
            for orig_key, orig_value in next, orig, nil do
                copy[c:Deepcopy(orig_key, copies)] = c:Deepcopy(orig_value, copies)
            end
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end