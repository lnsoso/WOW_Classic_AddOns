local MyAddonName, MyAddonTable = ...

MyAddonTable.Utility = MyAddonTable.Utility or {}
local Utility = MyAddonTable.Utility

--[[
]]

Utility.Item = {}
local this = Utility.Item

function this:GetItemInfoByID(ItemID, CBFunction)

	local MyItem = Item:CreateFromItemID(ItemID)
	if(MyItem:IsItemDataCached() == true) then
		CBFunction(MyItem)
	else
		MyItem:ContinueOnItemLoad(function()
			CBFunction(MyItem)
			return
		end)
	end
	
	return
end
