local _, core = ...;
local _G = _G;
local MonDKP = core.MonDKP;
local L = core.L;

local DKPTableTemp = {}
local ValInProgress = false

function MonDKP_TableCompare(t1,t2) 		-- compares two tables. returns true if all keys and values match
	local ty1 = type(t1)
	local ty2 = type(t2)
	
	if ty1 ~= ty2 then
		return false
	end
	
	if ty1 ~= 'table' and ty2 ~= 'table' then
		return t1 == t2
	end
	
	for k1,v1 in pairs(t1) do
		local v2 = t2[k1]
		if v2 == nil or not TableCompare(v1,v2) then
			return false
		end
	end
	for k2,v2 in pairs(t2) do
		local v1 = t1[k2]
		if v1 == nil or not TableCompare(v1,v2) then
			return false
		end
	end
	return true
end

function MonDKP:ValidateDKPTable_Loot()
	DKPTableTemp = {}
	local i=1
	local timer = 0
	local processing = false
	
	local ValidateTimer = ValidateTimer or CreateFrame("StatusBar", nil, UIParent)
	ValidateTimer:SetScript("OnUpdate", function(self, elapsed)
		timer = timer + elapsed
		if timer > 0.01 and i <= #MonDKP_Loot and not processing then
			processing = true
			local search = MonDKP:Table_Search(DKPTableTemp, MonDKP_Loot[i].player, "player")

			if search then
				DKPTableTemp[search[1][1]].dkp = DKPTableTemp[search[1][1]].dkp + tonumber(MonDKP_Loot[i].cost)
				DKPTableTemp[search[1][1]].lifetime_spent = DKPTableTemp[search[1][1]].lifetime_spent + tonumber(MonDKP_Loot[i].cost)
			else
				table.insert(DKPTableTemp, { player=MonDKP_Loot[i].player, dkp=tonumber(MonDKP_Loot[i].cost), lifetime_gained=0, lifetime_spent=tonumber(MonDKP_Loot[i].cost) })
			end
			processing = false
			i=i+1
			timer = 0
		elseif i > #MonDKP_Loot then
			ValidateTimer:SetScript("OnUpdate", nil)
			timer = 0
			MonDKP:ValidateDKPTable_DKP()
		end
	end)
end

function MonDKP:ValidateDKPTable_DKP()
	local i=1
	local j=1
	local timer = 0
	local timer2 = 0
	local processing = false
	local pause = false
	local proc2 = false
	
	local ValidateTimer = ValidateTimer or CreateFrame("StatusBar", nil, UIParent)
	ValidateTimer:SetScript("OnUpdate", function(self, elapsed)
		timer = timer + elapsed
		if timer > 0.0001 and i <= #MonDKP_DKPHistory and not processing and not pause then
			processing = true
			pause = true

			local players = {strsplit(",", strsub(MonDKP_DKPHistory[i].players, 1, -2))}
			local dkp = {strsplit(",", MonDKP_DKPHistory[i].dkp)}

			if #dkp == 1 then
				for i=1, #players do
					dkp[i] = tonumber(dkp[1])
				end
			else
				for i=1, #dkp do
					dkp[i] = tonumber(dkp[i])
				end
			end
			
			local ValidateTimer2 = ValidateTimer2 or CreateFrame("StatusBar", nil, UIParent)
			ValidateTimer2:SetScript("OnUpdate", function(self, elapsed)
				timer2 = timer2 + elapsed
				if timer2 > 0.0001 and j <= #players and not proc2 then
					proc2 = true

					local search = MonDKP:Table_Search(DKPTableTemp, players[j], "player")

					if search then
						DKPTableTemp[search[1][1]].dkp = DKPTableTemp[search[1][1]].dkp + tonumber(dkp[j])
						if ((tonumber(dkp[j]) > 0 and not MonDKP_DKPHistory[i].deletes) or (tonumber(dkp[j]) < 0 and MonDKP_DKPHistory[i].deletes)) and not strfind(MonDKP_DKPHistory[i].dkp, "%-%d*%.?%d+%%") then
							DKPTableTemp[search[1][1]].lifetime_gained = DKPTableTemp[search[1][1]].lifetime_gained + tonumber(dkp[j])
						end
					else
						if ((tonumber(dkp[j]) > 0 and not MonDKP_DKPHistory[i].deletes) or (tonumber(dkp[j]) < 0 and MonDKP_DKPHistory[i].deletes)) and not strfind(MonDKP_DKPHistory[i].dkp, "%-%d*%.?%d+%%") then
							table.insert(DKPTableTemp, { player=players[j], dkp=tonumber(dkp[j]), lifetime_gained=tonumber(dkp[j]), lifetime_spent=0 })
						else
							table.insert(DKPTableTemp, { player=players[j], dkp=tonumber(dkp[j]), lifetime_gained=0, lifetime_spent=0 })
						end
					end
					j=j+1
					proc2 = false
				elseif j > #players then
					ValidateTimer2:SetScript("OnUpdate", nil)
					j=1
					timer2 = 0
					pause = false					
					i=i+1
					processing = false
					timer = 0
				end
			end)
		elseif i > #MonDKP_DKPHistory and not processing and not proc2 and not pause then
			ValidateTimer:SetScript("OnUpdate", nil)
			timer = 0
			MonDKP:ValidateDKPTable_Final()
		end
	end)
end

function MonDKP:ValidateDKPTable_Final()
	-- validates all profile DKP values against saved values created above
	local i=1
	local timer = 0
	local processing = false
	local rectified = 0
	
	local ValidateTimer = ValidateTimer or CreateFrame("StatusBar", nil, UIParent)
	ValidateTimer:SetScript("OnUpdate", function(self, elapsed)
		timer = timer + elapsed
		if timer > 0.1 and i <= #DKPTableTemp and not processing then
			processing = true
			local flag = false
			local search = MonDKP:Table_Search(MonDKP_DKPTable, DKPTableTemp[i].player, "player")

			if search then
				if MonDKP_Archive[DKPTableTemp[i].player] then
					DKPTableTemp[i].dkp = DKPTableTemp[i].dkp + tonumber(MonDKP_Archive[DKPTableTemp[i].player].dkp)
					DKPTableTemp[i].lifetime_gained = DKPTableTemp[i].lifetime_gained + tonumber(MonDKP_Archive[DKPTableTemp[i].player].lifetime_gained)
					DKPTableTemp[i].lifetime_spent = DKPTableTemp[i].lifetime_spent + tonumber(MonDKP_Archive[DKPTableTemp[i].player].lifetime_spent)
				end
				if tonumber(DKPTableTemp[i].dkp) ~= MonDKP_DKPTable[search[1][1]].dkp then
					MonDKP_DKPTable[search[1][1]].dkp = tonumber(DKPTableTemp[i].dkp)
					flag = true
				end
				if tonumber(DKPTableTemp[i].lifetime_gained) ~= MonDKP_DKPTable[search[1][1]].lifetime_gained then
					MonDKP_DKPTable[search[1][1]].lifetime_gained = tonumber(DKPTableTemp[i].lifetime_gained)
					flag = true
				end
				if tonumber(DKPTableTemp[i].lifetime_spent) ~= MonDKP_DKPTable[search[1][1]].lifetime_spent then
					MonDKP_DKPTable[search[1][1]].lifetime_spent = tonumber(DKPTableTemp[i].lifetime_spent)
					flag = true
				end
			end
			if flag then rectified = rectified + 1 end
			i=i+1
			processing = false
			timer = 0
		elseif i > #DKPTableTemp then
			ValidateTimer:SetScript("OnUpdate", nil)
			timer = 0
			if rectified == 0 then
				MonDKP:Print(L["VALIDATIONCOMPLETE1"])
			else
				MonDKP:Print(string.format(L["VALIDATIONCOMPLETE2"], rectified))
			end
			ValInProgress = false
			table.wipe(DKPTableTemp)
			MonDKP:FilterDKPTable(core.currentSort, "reset")
		end
	end)
end

function MonDKP:ValidateDKPHistory()
	local deleted_entries = 0
	local i=1
	local timer = 0
	local processing = false
	
	local ValidateTimer = ValidateTimer or CreateFrame("StatusBar", nil, UIParent)
	ValidateTimer:SetScript("OnUpdate", function(self, elapsed)
		timer = timer + elapsed
		if timer > 0.01 and i <= #MonDKP_DKPHistory and not processing then
			processing = true
			-- delete duplicate entries and correct DKP (DKPHistory table)
			local search = MonDKP:Table_Search(MonDKP_DKPHistory, MonDKP_DKPHistory[i].index, "index")
			
			if MonDKP_DKPHistory[i].deletes then  -- adds deltedby index to field if it was received after a delete entry was received but was sent by someone that did not have the delete entry
				local search = MonDKP:Table_Search(MonDKP_DKPHistory, MonDKP_DKPHistory[i].deletes, "index")

				if search and not MonDKP_DKPHistory[search[1][1]].deletedby then
					MonDKP_DKPHistory[search[1][1]].deletedby = MonDKP_DKPHistory[i].index
				end
			end

			if #search > 1 then
				for j=2, #search do
					table.remove(MonDKP_DKPHistory, search[j][1])
					deleted_entries = deleted_entries + 1
				end
			else
				i=i+1
			end

			processing = false
			timer = 0
		elseif i > #MonDKP_DKPHistory then
			ValidateTimer:SetScript("OnUpdate", nil)
			timer = 0
			MonDKP:ValidateDKPTable_Loot()
		end
	end)
end

function MonDKP:ValidateLootTable()  -- validation starts here
	if ValInProgress then
		MonDKP:Print(L["VALIDATEINPROG"])
		return
	end
	local deleted_entries = 0
	-- delete duplicate entries and correct DKP (loot table)
	local i=1
	local timer = 0
	local processing = false
	ValInProgress = true
	
	MonDKP:Print(L["VALIDATINGTABLES"])
	local ValidateTimer = ValidateTimer or CreateFrame("StatusBar", nil, UIParent)
	ValidateTimer:SetScript("OnUpdate", function(self, elapsed)
		timer = timer + elapsed
		if timer > 0.01 and i <= #MonDKP_Loot and not processing then
			processing = true
			local search = MonDKP:Table_Search(MonDKP_Loot, MonDKP_Loot[i].index, "index")
			
			if search and #search > 1 then
				for j=2, #search do
					table.remove(MonDKP_Loot, search[j][1])
					deleted_entries = deleted_entries + 1
				end
			else
				i=i+1
			end
			processing = false
			timer = 0
		elseif i > #MonDKP_Loot then
			ValidateTimer:SetScript("OnUpdate", nil)
			timer = 0
			MonDKP:ValidateDKPHistory()
		end
	end)
end

function MonDKP_ReindexTables()
	local GM
	local i = 1

	for i=1, GetNumGuildMembers() do
		local name,_,rank = GetGuildRosterInfo(i)
		if rank == 0 then
			name = strsub(name, 1, string.find(name, "-")-1)
			GM = name; 
			break
		end
	end

	i=1
	while i <= #MonDKP_DKPHistory do
		if MonDKP_DKPHistory[i].deletes or MonDKP_DKPHistory[i].deletedby or MonDKP_DKPHistory[i].reason == "Migration Correction" then
			table.remove(MonDKP_DKPHistory, i)
		else
			if (MonDKP_DB.defaults.installed and MonDKP_DKPHistory[i].date < MonDKP_DB.defaults.installed) or (not MonDKP_DB.defaults.installed and MonDKP_DKPHistory[i].date < MonDKP_DB.defaults.installed210) then
				MonDKP_DKPHistory[i].index = GM.."-"..MonDKP_DKPHistory[i].date  	-- reindexes under GMs name if the entry was created prior to 2.1 (for uniformity)
			end
			i=i+1
		end
	end

	i=1
	while i <= #MonDKP_Loot do
		if MonDKP_Loot[i].deletes or MonDKP_Loot[i].deletedby then
			table.remove(MonDKP_Loot, i)
		else
			if (MonDKP_DB.defaults.installed and MonDKP_Loot[i].date < MonDKP_DB.defaults.installed) or (not MonDKP_DB.defaults.installed and MonDKP_Loot[i].date < MonDKP_DB.defaults.installed210) then
				MonDKP_Loot[i].index = GM.."-"..MonDKP_Loot[i].date 				-- reindexes under GMs name if the entry was created prior to 2.1 (for uniformity)
			end
			i=i+1
		end
	end
	MonDKP_DKPHistory.seed = 0
	MonDKP_Loot.seed = 0
end