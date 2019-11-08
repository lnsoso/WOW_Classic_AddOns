-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                http://www.curse.com/addons/wow/tradeskill-master               --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

--- Debug Functions
-- @module Debug

local _, TSM = ...
local Debug = TSM.Init("Util.Debug")
TSM.Debug = Debug
local private = {
	startSystemTimeMs = floor(GetTime() * 1000),
	startTimeMs = time() * 1000 + (floor(GetTime() * 1000) % 1000),
}
local ADDON_NAME_SHORTERNS = {
	-- shortern "TradeSkillMaster" to "TSM"
	[".-lMaster\\"] = "TSM\\",
}
local IGNORED_STACK_LEVEL_MATCHERS = {
	-- ignore wrapper code from LibTSMClass
	"LibTSMClass%.lua:",
}


-- ============================================================================
-- Module Functions
-- ============================================================================

--- Gets the current time in milliseconds since epoch
-- The time returned could be up to a second off absolutely, but relative times are guarenteed to be accurate.
-- @treturn number The current time in milliseconds since epoch
function Debug.GetTimeMilliseconds()
	local systemTimeMs = floor(GetTime() * 1000)
	return private.startTimeMs + (systemTimeMs - private.startSystemTimeMs)
end

--- Gets the location string for the specified stack level
-- @tparam number targetLevel The stack level to get the location for
-- @tparam[opt] thread thread The thread to get the location for
-- @treturn string The location string
function Debug.GetStackLevelLocation(targetLevel, thread)
	targetLevel = targetLevel + 1
	assert(targetLevel > 0)
	local level = 1
	while true do
		local stackLine = nil
		if thread then
			stackLine = debugstack(thread, level, 1, 0)
		else
			stackLine = debugstack(level, 1, 0)
		end
		if not stackLine or stackLine == "" then
			return
		end
		stackLine = strmatch(stackLine, "^%.*([^:]+:%d+):")
		if stackLine then
			local ignored = false
			for _, matchStr in ipairs(IGNORED_STACK_LEVEL_MATCHERS) do
				if strmatch(stackLine, matchStr) then
					ignored = true
					break
				end
			end
			if not ignored then
				targetLevel = targetLevel - 1
				if targetLevel == 0 then
					stackLine = gsub(stackLine, "/", "\\")
					for matchStr, replaceStr in pairs(ADDON_NAME_SHORTERNS) do
						stackLine = gsub(stackLine, matchStr, replaceStr)
					end
					return stackLine
				end
			end
		end
		level = level + 1
	end
end
