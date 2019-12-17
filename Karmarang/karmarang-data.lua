----- scope stuff -----
karmarang = karmarang or {};
local c = karmarang;
----- general -----

local CLEANUP_INTERVAL = 15;	-- minutes

----- main database -----
KARMA_DB = KARMA_DB or {};
-- [playerName]table ->	[author]table -> [timeStamp]entryfields
--										            synctable	-> [playerName]timeStamp

c.ENTRY_HASHTAG = "ENTRY_HASHTAG";								-- entry hashtag
c.ENTRY_TIMESTAMP = "ENTRY_TIMESTAMP";							-- entry timeStamp (= entry key)
c.ENTRY_AUTHOR = "ENTRY_AUTHOR";								-- entry author hashtag
c.ENTRY_PLAYERNAME = "ENTRY_PLAYERNAME";						-- entry playername (target)
c.ENTRY_KARMA = "ENTRY_KARMA";									-- entry karma
c.ENTRY_COMMENT = "ENTRY_COMMENT";								-- entry comment
c.ENTRY_SYNC = "ENTRY_SYNC";									-- entry sync table (playerName -> timeStamp)

c.ENTRY_VERSION = "ENTRY_VERSION";								-- version (player entry)
c.ENTRY_DATA = "ENTRY_DATA";									-- data (syncQueue entry)

function c:ValidateDatabase()
	--if pcall(c.BuildDatabaseCache) then
		c:Println(c:GetText("Database validation complete."));
	--	return true;
	--else
	--	c:ResetDatabase();
	--	c:Println(c:GetText("Error while validating database. It seems your database was malformed. In order for Karmarang to work properly, it needed to be reset. We are sorry. :("));
	--end
end

function c:ResetDatabase(realm)
	if realm then
		KARMA_DB[c.realmName] = {};
		c:Println(c:GetText("Realm has been reset successfully."));
	else
		KARMA_DB = {};
		KARMA_DB_AUX = {};
		c:Println(c:GetText("Database has been reset successfully."));
	end
	c:RealmDataSetInit();
end

function c:GetLatestComments(targetPlayerName, authorHashTag, maxComments)
	local result = {};

	if targetPlayerName and KARMA_DB[c.realmName][targetPlayerName] then
		maxComments = maxComments or c.MAX_LATESTCOMMENTS;		

		local entries, count = {}, 0;
		if targetPlayerName and KARMA_DB[c.realmName][targetPlayerName] then
			if authorHashTag then
				local sortedTimeStamps = c:GetSortedTableKeys(KARMA_DB[c.realmName][targetPlayerName][authorHashTag]);
				if sortedTimeStamps then
					for _, timeStamp in ipairs(sortedTimeStamps) do
						timeStamp = tostring(timeStamp);
						if KARMA_DB[c.realmName][targetPlayerName][authorHashTag][timeStamp][c.ENTRY_COMMENT] and KARMA_DB[c.realmName][targetPlayerName][authorHashTag][timeStamp][c.ENTRY_COMMENT] ~= "" then
							table.insert(result, KARMA_DB[c.realmName][targetPlayerName][authorHashTag][timeStamp]);

							count = count + 1;
							if count == maxComments then
								return result;
							end
						end
					end
				end
			else
				for author, data in pairs(KARMA_DB[c.realmName][targetPlayerName]) do
					for _, entry in ipairs(c:GetLatestComments(targetPlayerName, author, maxComments)) do
						local timeStamp = entry[c.ENTRY_TIMESTAMP];
						entries[timeStamp] = entries[timeStamp] or {};
						table.insert(entries[timeStamp], entry);
					end
				end

				local sortedTimeStamps = c:GetSortedTableKeys(entries)
				if sortedTimeStamps then
					for _, timeStamp in ipairs(sortedTimeStamps) do
						timeStamp = tostring(timeStamp);
						for _, entry in ipairs(entries[timeStamp]) do
							table.insert(result, entry);

							count = count + 1;
							if count == maxComments then
								return result;
							end
						end
					end
				end
			end
		end
	end
	return result;
end

function c:SetKarma(authorHashTag, targetPlayerName, karma, text, timeStamp)
	if authorHashTag and targetPlayerName and karma and (karma ~= 0 or (text and text ~= "")) then
		KARMA_DB[c.realmName][targetPlayerName] = KARMA_DB[c.realmName][targetPlayerName] or {};
		KARMA_DB[c.realmName][targetPlayerName][authorHashTag] = KARMA_DB[c.realmName][targetPlayerName][authorHashTag] or {};

		timeStamp = timeStamp or c:GetTimestamp();

		if not KARMA_DB[c.realmName][targetPlayerName][authorHashTag][timeStamp] then -- prevent overwriting
			local newEntry = {};
			newEntry[c.ENTRY_TIMESTAMP] = timeStamp;
			newEntry[c.ENTRY_AUTHOR] = authorHashTag;
			newEntry[c.ENTRY_PLAYERNAME] = targetPlayerName;
			newEntry[c.ENTRY_KARMA] = karma;
			if text and text ~= "" then
				newEntry[c.ENTRY_COMMENT] = text;
			end

			-- set entry
			KARMA_DB[c.realmName][targetPlayerName][authorHashTag][timeStamp] = newEntry;
			return newEntry;
		end
	end
end

function c:GetKarma(targetPlayerName, authorHashTag)
	if targetPlayerName and KARMA_DB[c.realmName][targetPlayerName] then
		if authorHashTag then
			if KARMA_DB[c.realmName][targetPlayerName][authorHashTag] then
				local subSum, subCount = 0, 0;
				for timeStamp, values in pairs(KARMA_DB[c.realmName][targetPlayerName][authorHashTag]) do
					if values[c.ENTRY_KARMA] ~= 0 then
						subSum = subSum + values[c.ENTRY_KARMA];
						if abs(values[c.ENTRY_KARMA]) == 1 then
							subCount = subCount + 1;
						end
					end
				end
				if subCount > 0 then
					return subSum / subCount, targetPlayerName == c.charName;
				end
			end
		else
			local sum, count, displayCount = 0, 0, 0;
			for author, data in pairs(KARMA_DB[c.realmName][targetPlayerName]) do
				local authorKarma, authorIsPlayer = c:GetKarma(targetPlayerName, author);
				if authorKarma then
					sum = sum + authorKarma;
					count = count + 1;
					if not authorIsPlayer then
						displayCount = displayCount + 1;
					end
				end
			end
			if count > 0 then
				return sum / count, displayCount;
			end
		end
	end
end

function c:GetDisplayKarma(targetPlayerName, authorHashTag)
	local karma, count = c:GetKarma(targetPlayerName, authorHashTag);

	--> input: -100 to 100
	if karma then
		karma = (karma + 1) / 2;

		if karma > 1 then
			karma = 1;
		elseif karma < 0 then
			karma = 0;
		end
	end
	--> output: 0 to 100

	return karma, count;
end

function c:GetSyncData(requester)
	local result = {};

	for playerName, playerTable in pairs(KARMA_DB[c.realmName]) do
		for author, authorTable in pairs(playerTable) do
			for timeStamp, entryValue in pairs(authorTable) do
				entryValue[c.ENTRY_SYNC] = entryValue[c.ENTRY_SYNC] or {};

				if not entryValue[c.ENTRY_SYNC][requester] then
					result[playerName] = result[playerName] or {};
					result[playerName][author] = result[playerName][author] or {};

					local syncEntry = {};
					syncEntry[c.ENTRY_TIMESTAMP] = timeStamp;
					syncEntry[c.ENTRY_AUTHOR] = author;
					syncEntry[c.ENTRY_PLAYERNAME] = playerName;
					syncEntry[c.ENTRY_KARMA] = entryValue[c.ENTRY_KARMA];
					syncEntry[c.ENTRY_COMMENT] = entryValue[c.ENTRY_COMMENT];

					result[playerName][author][timeStamp] = syncEntry;
				end
			end
		end
	end

	return result;
end

function c:SearchPlayers(str)
	local result = {};
	if str and str ~= "" then
		str = strupper(str);
		for playerName, _ in pairs(KARMA_DB[c.realmName]) do
			if strfind(strupper(playerName), str) then
				table.insert(result, playerName);
			end
		end
	end

	table.sort(result, function(a, b) return a < b end); -- ascending
	return result;
end

----- aux database -----
local NAME_BY_HASHTAG, HASHTAG_BY_NAME, LASTSEEN = "NAME_BY_HASHTAG", "HASHTAG_BY_NAME", "LASTSEEN";
local RECENTPLAYERS = "RECENTPLAYERS";

KARMA_DB_AUX = KARMA_DB_AUX or {};

function c:GetPlayerNames(hashTag)
	return KARMA_DB_AUX[NAME_BY_HASHTAG][hashTag];
end

function c:GetPlayerHashtag(playerName)
	return KARMA_DB_AUX[c.realmName][HASHTAG_BY_NAME][playerName];
end

function c:AddPlayerInfo(playerEntry)
	local hashTag = playerEntry[c.ENTRY_HASHTAG];
	local playerName = playerEntry[c.ENTRY_PLAYERNAME];
	if hashTag and playerName then
		-- hash by name
		KARMA_DB_AUX[c.realmName][HASHTAG_BY_NAME][playerName] = hashTag;

		-- name by hash
		KARMA_DB_AUX[NAME_BY_HASHTAG][hashTag] = KARMA_DB_AUX[NAME_BY_HASHTAG][hashTag] or {};
		KARMA_DB_AUX[NAME_BY_HASHTAG][hashTag][c.realmName] = KARMA_DB_AUX[NAME_BY_HASHTAG][hashTag][c.realmName] or {};
		if not c:TableContainsValue(KARMA_DB_AUX[NAME_BY_HASHTAG][hashTag][c.realmName], playerName) then
			table.insert(KARMA_DB_AUX[NAME_BY_HASHTAG][hashTag][c.realmName], playerName);
		end

		-- lastseen
		KARMA_DB_AUX[LASTSEEN][hashTag] = playerEntry;
	end
end

function c:SetRecentPlayers(players)
	if players then
		for _, playerName in ipairs(players) do
			c:SetRecentPlayer(playerName);
		end
	end
end

function c:SetRecentPlayer(playerName)
	if playerName ~= c.charName then
		KARMA_DB_AUX[c.realmName][RECENTPLAYERS][playerName] = c:GetTimestamp();
	end
end

function c:CleanUpRecentPlayers()
	local currentTimestamp = c:GetTimestamp();
	for playerName, timeStamp in pairs(KARMA_DB_AUX[c.realmName][RECENTPLAYERS]) do
		if currentTimestamp - timeStamp > c.MAX_KARMATIMEOUT * 60 then
			KARMA_DB_AUX[c.realmName][RECENTPLAYERS][playerName] = nil;
		end
	end
	C_Timer.After(CLEANUP_INTERVAL * 60, function() c:CleanUpRecentPlayers(); end); -- repeat
end

function c:GetRemainingKarmaCooldown(playerName, author)
	author = author or c.hashTag;

	local shortestDiff;
	if KARMA_DB[c.realmName][playerName] and KARMA_DB[c.realmName][playerName][author] then
		local currentTimeStamp = tonumber(c:GetTimestamp());

		for timeStamp, entry in pairs(KARMA_DB[c.realmName][playerName][author]) do
			local diff = currentTimeStamp - tonumber(timeStamp);
			if diff <= c.MAX_KARMACOOLDOWN * 60 and (not shortestDiff or diff < shortestDiff) then
				shortestDiff = diff;
			end
		end
	end

	if shortestDiff then
		return c.MAX_KARMACOOLDOWN * 60 - shortestDiff;
	end
end

function c:GetRemainingKarmaTimeout(playerName)
	local playerLastSeen = KARMA_DB_AUX[c.realmName][RECENTPLAYERS][playerName];
	if playerLastSeen then
		local remainingTime = tonumber(playerLastSeen) + c.MAX_KARMATIMEOUT * 60 - tonumber(c:GetTimestamp());
		if remainingTime <= 0 then
			KARMA_DB_AUX[c.realmName][RECENTPLAYERS][playerName] = nil;
		else
			return remainingTime;
		end
	end
end

----- general -----
function c:RealmDataSetInit()
	-- main
	KARMA_DB[c.realmName] = KARMA_DB[c.realmName] or {};

	-- aux
	KARMA_DB_AUX[c.realmName] = KARMA_DB_AUX[c.realmName] or {};
	KARMA_DB_AUX[c.realmName][HASHTAG_BY_NAME] = KARMA_DB_AUX[c.realmName][HASHTAG_BY_NAME] or {};
	KARMA_DB_AUX[NAME_BY_HASHTAG] = KARMA_DB_AUX[NAME_BY_HASHTAG] or {};

	KARMA_DB_AUX[LASTSEEN] = KARMA_DB_AUX[LASTSEEN] or {};

	KARMA_DB_AUX[c.realmName][RECENTPLAYERS] = KARMA_DB_AUX[c.realmName][RECENTPLAYERS] or {};
end