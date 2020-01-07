local MyAddonName, MyAddonTable = ...
local this = MyAddonTable

--[[
]]

local Chat = this.Utility.Chat

function this:GetCharacterInfo(CharacterData)

	local PlayerClass	= select(2, UnitClass("player"))
	local PlayerFaction	= UnitFactionGroup("player")
	--local ClassColor	= select(4, GetClassColor(PlayerClass))
	local CurrentTime	= GetServerTime()
	
	--[[
	if the user deleted an existing character and recreated a character with the same name the old stored data will obviously no longer match.
	the info right here can simply be replaced and most storage data will be overwritten automatically
	the only thing not that easy will be mail. mail that should be visible in the old characters inbox will be overwritten. however, mail that the deleted character sent to other Alts will
	not be able to be returned and print the wrong warnings. the same is true for mail in transit. However, these issues will sort themself out rather quickly (4 days max) and then the
	corrupted mail will be deleted from the SavedVariables.
	We should consider this for profession data later, though.
	--]]
	
	local Info = CharacterData.Info or { LastVisit = {} }
	Info.Class				= PlayerClass
	Info.Faction			= PlayerFaction
	Info.Realm				= self.CurrentRealmName
	Info.Name				= self.CurrentCharacterName
	Info.NameCC				= Chat:GetColorCodedName(Info)
	Info.FullNameCC			= Chat:GetColorCodedFullName(Info)
	Info.LastVisit.Login	= CurrentTime

	return Info
end

function this:GetCurrentCharacterName()
	return self.CurrentCharacterName
end

function this:GetCurrentRealmName()
	return self.CurrentRealmName
end

--Init may be called both on Login or after data-reset
function this:Init()

	self.CurrentCharacterName, self.CurrentRealmName = UnitFullName("player")
		
	if(self.CurrentRealmName == nil) then
		Chat:Error("Realm-Name not available.")
	end

	self.SlashCommands:Init()
	self.Storage:Init()
	
	return
end

--start addon
this.EventHandlers:Init()
