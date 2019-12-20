--do not load the addon if current player is not a shaman
a, b, classId = UnitClass("player")
if (classId ~= 7) then return end

local ActiveTotems = 
{
	[1] = { SpellId = 0, StartTime = 0 },
	[2] = { SpellId = 0, StartTime = 0 },
	[3] = { SpellId = 0, StartTime = 0 },
	[4] = { SpellId = 0, StartTime = 0 }
}


local function ClearTotem(totemIndex)
	ActiveTotems[totemIndex].SpellId = 0
	ActiveTotems[totemIndex].StartTime = 0
	
	UIElements[totemIndex].Image:SetTexture(nil)
	UpdateTotemData()
end

function PlayerTotemUpdate(totemSlot)
	--in Blizzard's api earth and fire indexes are switched. switch them back here
	totemIndex = totemSlot
	if (totemSlot == 1) then totemIndex = 2 end
	if (totemSlot == 2) then totemIndex = 1 end
	
	--if the last succeeded time for this totem type is less than 0.75 sec ago from now ignore this event. this is necessary because sometimes PLAYER_TOTEM_UPDATE gets called twice for the same totem event for no apparent reason
	lastSucceeded = ActiveTotems[totemIndex].StartTime
	if (GetTime() < (lastSucceeded + 0.75)) then return end
	
	--if a totem currently exists for this slot then it must have been destroyed. clear data
	if (ActiveTotems[totemIndex].SpellId ~= 0) then ClearTotem(totemIndex) end
	
	UpdateTotemData()
end

function SpellCastSucceeded(spellId)
	totemIndex = GetSpellTotemIndex(spellId)
	if (totemIndex == nil) then return end
		
	--update active totems and totem data
	ActiveTotems[totemIndex].SpellId = spellId
	ActiveTotems[totemIndex].StartTime = GetTime()
	UpdateTotemData()
end

function UpdateTotemData()
	for totemIndex = 1, 4 
	do
		spellId = ActiveTotems[totemIndex].SpellId
		local icon = GetSpellTexture(spellId)
		UIElements[totemIndex].Image:SetTexture(icon)
		
		RefreshTimer(totemIndex)
		RefreshAffectedCount(totemIndex)
	end
end

--[[
	Get the number of players affected by the totem with the given index.
]]
local function GetAffectedCount(totemIndex)
	local unitsAffected = 0
	local allUsersAffected = true

	--get the number of units = 1 (player) + party members
	unitCount = 1 + math.min(4, GetNumGroupMembers())
	for unitIndex = 1, unitCount 
	do
		--get ID of this unit and the totem aura (spell) ID we are looking for
		unitId = GetUnitId(unitIndex)
		totemAuraId = Totems[spellId].AuraId;
		
		--disregard offline players
		if (UnitIsConnected(unitId))
		then
			if (IsUnitAffected(unitId, totemAuraId)) 
			then 
				--if unit is affected by this totem, increment affected if yes
				unitsAffected = unitsAffected + 1 
			else
				--check if totem is useful for this class. if yes mark not all users as affected
				isUseful = IsAuraUsefulToUnit(unitId, totemAuraId)
				if (isUseful) then allUsersAffected = false end
			end
		end
	end
	
	return unitsAffected, allUsersAffected
end

--[[
	Refreshes the number of players affected by the totem with the given index.
]]
function RefreshAffectedCount(totemIndex)
	local spellId = ActiveTotems[totemIndex].SpellId
	totemCountText = UIElements[totemIndex].Count
	
	--if no totem found set empty text and return
	if (spellId == 0)
	then
		totemCountText:SetText("");
		return
	end
	
	--if affected count should be ignored for this totem set white text and —
	if (Totems[spellId].AuraId == 0)
	then
		totemCountText:SetText("—");
		totemCountText:SetTextColor(1.0, 1.0, 1.0, 1.0)
	else
		local unitsAffected, allUsersAffected = GetAffectedCount(totemIndex)
		totemCountText:SetText(unitsAffected);
		
		if (allUsersAffected) 
		then 
			totemCountText:SetTextColor(0.0, 1.0, 0.0, 1.0)
		else
			totemCountText:SetTextColor(1.0, 0.0, 0.0, 1.0)
		end
	end
end

--[[
	Refreshes the time left until expiry of the totem with the given index.
]]
function RefreshTimer(totemIndex)
	local timeLeftText = ""
	
	startTime = ActiveTotems[totemIndex].StartTime
	
	if (startTime ~= 0) 
	then
		--get duration for this totem
		spellId = ActiveTotems[totemIndex].SpellId
		duration = Totems[spellId].Duration
		
		timeElapsed = GetTime() - startTime
		timeLeft = duration - timeElapsed
		if (timeLeft < 0) then timeLeft = 0 end
		
		minutes = string.format("%2.f", math.floor(timeLeft / 60))
		seconds = string.format("%02.f", math.floor(timeLeft  - minutes * 60))
		timeLeftText = minutes .. ":" .. seconds
	end
	
	UIElements[totemIndex].Timer:SetText(timeLeftText)
end

--[[
	Zone changed implies all totems destroyed. 
	For some reason PLAYER_TOTEM_UPDATE in that case so this is a workaround.
]]
function ZoneChanged()
	for totemIndex = 1, 4 
	do
		ClearTotem(totemIndex)
	end
end