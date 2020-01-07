local MyAddonName, MyAddonTable = ...

MyAddonTable.Utility = MyAddonTable.Utility or {}
local Utility = MyAddonTable.Utility

--[[
]]

Utility.Chat = {}
local this = Utility.Chat

this.ClassColors =
{
	["DEATHKNIGHT"]	= "C41F3B",
	["DEMONHUNTER"]	= "A330C9",
	["DRUID"]		= "FF7D0A",
	["HUNTER"]		= "ABD473",
	["MAGE"]		= "40C7EB",
	["MONK"]		= "00FF96",
	["PALADIN"]		= "F58CBA",
	["PRIEST"]		= "FFFFFF",
	["ROGUE"]		= "FFF569",
	["SHAMAN"]		= "0070DE",
	["WARLOCK"]		= "8787ED",
	["WARRIOR"]		= "C79C6E"
}

this.FactionColors =
{
	["Alliance"]	= "002366", --royal blue; pure blue is very hard to see on most backgrounds
	["Horde"]		= "FF0000",
	["Neutral"]		= "00FF00"
}

function this:GetColoredText(ColorHex, Message)
	return "|cFF"..ColorHex..tostring(Message).."|r"
end

function this:White(Message)
    return "|cFFFFFFFF"..tostring(Message).."|r"
end

function this:Red(Message)
    return "|cFFFF0000"..tostring(Message).."|r"
end

function this:Green(Message)
    return "|cFF00FF00"..tostring(Message).."|r"
end

function this:Blue(Message)
    return "|cFF0000FF"..tostring(Message).."|r"
end

function this:Yellow(Message)
    return "|cFFFFFF00"..tostring(Message).."|r"
end

function this:Gray(Message)
    return "|cFF9D9D9D"..tostring(Message).."|r"
end

function this:Purple(Message)
    return "|cFFA335EE"..tostring(Message).."|r"
end

function this:Orange(Message)
    return "|cFFFF8000"..tostring(Message).."|r"
end

function this:Gold(Message)
    return "|cFFE6CC80"..tostring(Message).."|r"
end

function this:Debug(Message)
	print(self:Yellow(MyAddonName)..self:Green(" DEBUG: ")..self:Yellow(Message))
	return
end

function this:Warning(Message)
	print(self:Yellow(MyAddonName)..self:Yellow(" WARNING: ")..tostring(Message))
	return
end

function this:Error(Message)
	print(self:Yellow(MyAddonName)..self:Red(" ERROR: ")..self:Yellow(Message))
	return
end

function this:AddonMessage(Text)
	print(self:Yellow(MyAddonName)..": "..Text)
	return
end

function this:BooleanText(Bool, Message)
	if(Bool == true) then
		return self:Green(Message)
	else
		return self:Red(Message)
	end
end

function this:Boolean(Bool)
	return self:BooleanText(Bool,Bool)
end

function this:ClassColor(Class, Text)
	if(self.ClassColors[Class] == nil) then
		self:Error("trying to use an invalid class-color: "..Class)
	end
	
	return self:GetColoredText(self.ClassColors[Class], Text)
end

function this:FactionColor(Faction, Text)
	if(self.FactionColors[Faction] == nil) then
		self:Error("trying to use an invalid faction-color: "..Faction)
	end
	
	return self:GetColoredText(self.FactionColors[Faction], Text)
end

function this:GetColorCodedName(CharacterData)
	return self:ClassColor(CharacterData.Class, CharacterData.Name)
end

function this:GetColorCodedFullName(CharacterData)
	return self:ClassColor(CharacterData.Class, CharacterData.Name.."-"..CharacterData.Realm)
end
