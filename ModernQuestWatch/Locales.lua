local _, S = ...

local L = {
	enUS = {
		SHIFT_CLICK = "Shift-Click",
		ALT_CLICK = "Alt-Click",
		UNTRACK_USAGE = "Untrack a quest",
		MOVE_USAGE = "Move the quest tracker",
		RESET = "Settings have been reset",
	},
	deDE = {
		RESET = "Einstellungen wurden zurückgesetzt",
	},
	esES = {
	},
	esMX = {
	},
	frFR = {
	},
	itIT = {
	},
	koKR = {
		RESET = "설정이 초기화되었습니다",
	},
	ptBR = {
	},
	ruRU = { -- https://github.com/Hubbotu/ModernQuestWatch/blob/patch-1/Locales.lua#L25
		UNTRACK_USAGE = "отследить квест",
		MOVE_USAGE = "переместить квест трекер",
		RESET = "Настройки были сброшены",
	},
	--zhCN = {},
	zhTW = {
		RESET = "設定已經重置",
	},
}

L.zhCN = L.zhTW

S.L = setmetatable(L[GetLocale()] or L.enUS, {__index = function(t, k)
	local v = rawget(L.enUS, k) or k
	rawset(t, k, v)
	return v
end})
