local MyAddonName, MyAddonTable = ...

MyAddonTable.SlashCommands = {}
local this = MyAddonTable.SlashCommands

--[[
]]

local Chat = MyAddonTable.Utility.Chat

function this:Help(arg, cmd)

	if((cmd ~= "?") and (cmd ~= "help")) then
		Chat:AddonMessage("invalid argument: "..cmd)
	else
		Chat:AddonMessage("Command Help")
	end

	print(Chat:Green("/isc EraseAllData"))
	print("   Erase all stored item data. You will have to log in on every character again to rebuild it. Use this command if you have deleted characters and need to remove their data from surveys or if your data was corrupted somehow.")
	print("   "..Chat:Red("WARNING:").." There is no way to recover the data! You can only rebuild it by logging characters!")
	
	print(Chat:Green("/isc EraseCharacter [Character-Realm]"))
	print("   Erase the specified character from ISC SavedVariables. Use this if you deleted this character or you simply do not want to be bothered with it anymore. This will also remove all Items this character may still hold from Tooltips.")
	print("   "..Chat:Red("WARNING:").." There is no way to recover the data! You can only rebuild it by logging the character in again!")
	
	print(Chat:Green("/isc GenerateItemLinkFromItemID [ItemID]"))
	print(Chat:Green(" /isc generate [ItemID]"))
	print(Chat:Green(" /isc g [ItemID]"))
	print("  Add a clickable ItemLink to your chat. You can use this link to easily check the tooltip if/where you may possess this item on the current realm.")
	print("  "..Chat:Green("Example:").." /isc g 18230")
	
	print(Chat:Green("/isc SearchItemByName [Text]"))
	print(Chat:Green(" /isc search [Text]"))
	print(Chat:Green(" /isc s [Text]"))
	print("   Search the names of all items in your possession on the current realm for [Text] and add a Link to them if a match is found. The search is case-sensitive and uses local client language. You can specify any part of the name, even single letters.")
	print("  "..Chat:Green("Example:").." /isc s Silk")
	
	print(Chat:Green("/isc ListRealmMoney [Realm]"))
	print(Chat:Green("/isc money [Realm]"))
	print(Chat:Green(" /isc m [Realm]"))
	print("   Print a survey of your Gold on [Realm]. If no realm is specified the current realm is used.")
	
	return
end

function this:EraseAllData()

	MyAddonTable.Storage:EraseAllData()	
	return
end

function this:EraseCharacter(arg)

	local CharacterName, RealmName = arg:match("^(%S+)-(%S+)$")
	
	if((CharacterName == nil) or (RealmName == nil)) then
		Chat:Error("Argument did not equal \"Character-Realm\": \""..arg.."\"")
		return
	end
	
	MyAddonTable.Storage:EraseCharacter(RealmName, CharacterName)
	return
end

function this:SearchItemByName(arg)

	MyAddonTable.ItemSearch:Start(arg)
	
	return
end

function this:search(arg)
	return self:SearchItemByName(arg)
end

function this:s(arg)
	return self:SearchItemByName(arg)
end

function this:GenerateItemLinkFromItemID(arg)
	
	local ItemID = tonumber(arg)
	if(ItemID == nil) then
		Chat:Error("Invalid ItemID argument.")
		return
	end
	
	local GeneratedItem = Item:CreateFromItemID(ItemID)
	if(GeneratedItem:IsItemEmpty() == true)then
		Chat:Error("Invalid ItemID argument.")
		return
	end
	GeneratedItem:ContinueOnItemLoad(function()
		Chat:AddonMessage(GeneratedItem:GetItemLink())
	end)
	
	return
end

function this:generate(arg)
	return self:GenerateItemLinkFromItemID(arg)
end

function this:g(arg)
	return self:GenerateItemLinkFromItemID(arg)
end


function this:ListRealmMoney(Realm)
	MyAddonTable.Storage:ListRealmMoney(Realm)
	return
end

function this:money(Realm)
	return self:ListRealmMoney(Realm)
end

function this:m(Realm)
	return self:ListRealmMoney(Realm)
end

function this:ShowInterfaceOptions()
	MyAddonTable.Options:Show()
end

function this:options()
	return self:ShowInterfaceOptions()
end

function this:config()
	return self:ShowInterfaceOptions()
end

function this:setup()
	return self:ShowInterfaceOptions()
end


--DEBUG
--function this:DEBUG_LOGOUT(arg)
	
	--print("DEBUG: calling logout EventHandler...")
	--MyAddonTable.EventHandlers:PLAYER_LOGOUT()
	
	--return
--end

function this:Init()

	local Chat = MyAddonTable.Utility.Chat
	
	local GlobalAddonSlashPrefix = "ITEMSURVEYCLASSIC"
	local Commands =
	{
		"/itemsurveyclassic",
		"/isc"
	}

	for k, Command in ipairs(Commands) do
		local NewCommand = "SLASH_"..GlobalAddonSlashPrefix..k
		if(_G[NewCommand] ~= nil) then
			Chat:Error("Trying to register slash command that is already in use.")
			return
		end
		
		_G[NewCommand] = Command
	end
	
	if(SlashCmdList[GlobalAddonSlashPrefix] ~= nil) then
		Chat:Error("Trying to register slash prefix already in use.")
		return
	end
	
	local function SlashHandler(Message, EditBox)
		local cmd, arg = Message:match("^(%S*)%s*(.-)$")
		
		if(this[cmd] == nil) then
			self:Help(arg, cmd)
		else
			this[cmd](self, arg)
		end
		
		return
	end
	
	SlashCmdList[GlobalAddonSlashPrefix] = SlashHandler
	
	return
end
