-- scope stuff
karmarang = karmarang or {};
local c = karmarang;

-- variables
c.CACHE_LATESTCOMMENTS = "CACHE_LATESTCOMMENTS";				-- cache for latest comments
c.ENTRY_DATETIME = "ENTRY_DATETIME";							-- entry dateTime (= entry key)
c.ENTRY_AUTHOR = "ENTRY_AUTHOR";								-- entry author
c.ENTRY_PLAYERNAME = "ENTRY_PLAYERNAME";						-- entry playername (target)
c.ENTRY_KARMA = "ENTRY_KARMA";									-- entry karma
c.ENTRY_COMMENT = "ENTRY_COMMENT";								-- entry comment

KARMA_DB = KARMA_DB or {};
KARMA_DB[c.CACHE_LATESTCOMMENTS] = KARMA_DB[c.CACHE_LATESTCOMMENTS] or {};

function c:ValidateDatabase()
	if pcall(c.BuildDatabaseCache) then
		c:Println(c:GetText("Database validation complete."));
	else
		c:ResetDatabase();
		c:Println(c:GetText("Error while validating database. It seems your database was malformed. In order for Karmarang to work properly, it needed to be reset. We are sorry. :("));
	end
end

function c:ResetDatabase()
	KARMA_DB = {};
end

function c:BuildDatabaseCache()
	for playerName, _ in pairs(KARMA_DB) do
		c:UpdateLatestComments(playerName);
	end
end

function c:UpdateLatestComments(playerName, author, maxComments)
	if not maxComments then 
		maxComments = c.MAX_LATESTCOMMENTS;
	end

	local result, entries, count = {}, {}, 0;
	if playerName and KARMA_DB[playerName] then
		if author then
			local sortedDateTimes = c:GetSortedTableKeys(KARMA_DB[playerName][author]);
			if sortedDateTimes then
				for _, dateTime in ipairs(sortedDateTimes) do
					if KARMA_DB[playerName][author][dateTime][c.ENTRY_COMMENT] and KARMA_DB[playerName][author][dateTime][c.ENTRY_COMMENT] ~= "" then
						table.insert(result, KARMA_DB[playerName][author][dateTime]);

						count = count + 1;
						if count == maxComments then
							KARMA_DB[playerName][author][c.CACHE_LATESTCOMMENTS] = result;
							return result;
						end
					end
				end
			end
			KARMA_DB[playerName][author][c.CACHE_LATESTCOMMENTS] = result;
		else
			for author, data in pairs(KARMA_DB[playerName]) do
				if author ~= c.CACHE_LATESTCOMMENTS then
					for _, entry in ipairs(c:UpdateLatestComments(playerName, author, maxComments)) do
						local dateTime = entry[c.ENTRY_DATETIME];
						if not entries[dateTime] then
							entries[dateTime] = {};
						end
						table.insert(entries[dateTime], entry);
					end
				end
			end

			local sortedDateTimes = c:GetSortedTableKeys(entries)
			if sortedDateTimes then
				for _, dateTime in ipairs(sortedDateTimes) do
					for _, entry in ipairs(entries[dateTime]) do
						table.insert(result, entry);

						count = count + 1;
						if count == maxComments then
							KARMA_DB[playerName][c.CACHE_LATESTCOMMENTS] = result;
							return result;
						end
					end
				end
			end
			KARMA_DB[playerName][c.CACHE_LATESTCOMMENTS] = result;
		end
	end

	return result;
end

function c:AppendLatestComment(playerName, author, newEntry)
	if playerName then
		local tmp, latestComments, count = KARMA_DB[playerName][c.CACHE_LATESTCOMMENTS], {}, 0;
		table.insert(latestComments, newEntry);
		for _, entry in ipairs(tmp) do
			table.insert(latestComments, entry);

			count = count + 1;
			if count == c.MAX_LATESTCOMMENTS then
				break;
			end
		end
		KARMA_DB[playerName][c.CACHE_LATESTCOMMENTS] = latestComments;

		if author then
			local tmp, latestComments, count = KARMA_DB[playerName][author][c.CACHE_LATESTCOMMENTS], {}, 0;
			table.insert(latestComments, newEntry);
			for _, entry in ipairs(tmp) do
				table.insert(latestComments, entry);

				count = count + 1;
				if count == c.MAX_LATESTCOMMENTS then
					break;
				end
			end
			KARMA_DB[playerName][author][c.CACHE_LATESTCOMMENTS] = latestComments;
		end
	end
end

function c:GetLatestComments(playerName, author, maxComments)
	if playerName and KARMA_DB[playerName] then
		if author then
			return KARMA_DB[playerName][author][c.CACHE_LATESTCOMMENTS] or c:UpdateLatestComments(playerName, author, maxComments);
		else
			return KARMA_DB[playerName][c.CACHE_LATESTCOMMENTS] or c:UpdateLatestComments(playerName, nil, maxComments);
		end
	end
	return {};
end

function c:SetKarma(author, playerName, karma, text, dateTime)
	if author and playerName and karma and (karma ~= 0 or (text and text ~= "")) then
		if not KARMA_DB[playerName] then
			KARMA_DB[playerName] = {};
			KARMA_DB[playerName][c.CACHE_LATESTCOMMENTS] = {};
		end

		if not KARMA_DB[playerName][author] then
			KARMA_DB[playerName][author] = {};
			KARMA_DB[playerName][author][c.CACHE_LATESTCOMMENTS] = {};
		end

		if not dateTime then
			dateTime = c:GetDateTime();
		end

		if not KARMA_DB[playerName][author][c:GetDate(dateTime)] then
			local newEntry = {};
			newEntry[c.ENTRY_DATETIME] = dateTime;
			newEntry[c.ENTRY_AUTHOR] = author;
			newEntry[c.ENTRY_PLAYERNAME] = playerName;
			newEntry[c.ENTRY_KARMA] = karma;
			if text and text ~= "" then
				newEntry[c.ENTRY_COMMENT] = text;
			end

			KARMA_DB[playerName][author][dateTime] = newEntry;

			if newEntry[c.ENTRY_COMMENT] then
				c:AppendLatestComment(playerName, author, newEntry);
			end
			return newEntry;
		end
	end
end

function c:GetKarma(playerName, author)
	if playerName and KARMA_DB[playerName] then
		if author then
			if KARMA_DB[playerName][author] then
				local subSum, subCount = 0, 0;
				for dateTime, values in pairs(KARMA_DB[playerName][author]) do
					if dateTime ~= c.CACHE_LATESTCOMMENTS and values[c.ENTRY_KARMA] ~= 0 then  -- messy worarkound
						subSum = subSum + values[c.ENTRY_KARMA];
						subCount = subCount + 1;
					end
				end
				if subCount > 0 then
					return subSum / subCount;
				end
			end
		else
			local sum, count = 0, 0;
			for author, data in pairs(KARMA_DB[playerName]) do
				if author ~= c.CACHE_LATESTCOMMENTS then  -- messy worarkound
					local authorKarma = c:GetKarma(playerName, author);
					if authorKarma then
						sum = sum + authorKarma;
						count = count + 1;
					end
				end
			end
			if count > 0 then
				return sum / count;
			end
		end
	end
end