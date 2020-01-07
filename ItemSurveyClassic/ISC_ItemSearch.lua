local MyAddonName, MyAddonTable = ...

MyAddonTable.ItemSearch = {}
local this = MyAddonTable.ItemSearch

--[[
using the CurrentNameTable to get a table containing all item-names makes the actual search trivial.
]]

local Chat = MyAddonTable.Utility.Chat

function this:Finish(Text, CNT)

	Chat:AddonMessage("Searching your storage for items with names containing: \""..Text.."\"")
	local Matches = 0
	for ItemID, ItemData in pairs(CNT) do
		if(string.match(ItemData.Name, Text) ~= nil) then
			--print(Chat.ISCText(ItemData.Link))
			print(ItemData.Link)
			Matches = Matches + 1
		end
	end
	Chat:AddonMessage(Matches.." matching item(s) found.")

	return
end

function this:Start(Text)

	MyAddonTable.CurrentNameTable:Create(function(CNT)
		self:Finish(Text, CNT)
		return
	end)

	return
end
