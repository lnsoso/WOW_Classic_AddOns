local MyAddonName, MyAddonTable = ...

MyAddonTable.Utility = MyAddonTable.Utility or {}
local Utility = MyAddonTable.Utility

--[[
]]

Utility.Table = {}
local this = Utility.Table

function this:Contains(t, x)
	for k,v in pairs(t) do
		if(v == x) then
			return true
		end
	end
	
	return false
end

function this:GetNumEntries(t)
	local Count = 0
	for _ in pairs(t) do
		Count = Count + 1
	end
	return Count
end

function this:IsEmpty(t)
	if(next(t) == nil) then
		return true
	end
	return false
end

function this:Clear(t)
	for k in pairs(t) do
		t[k] = nil
	end
	return
end

function this:Append(t, x)
	t[#t + 1] = x
	return
end

function this:Remove(t, x)
	for k,v in pairs(t) do
		if(v == x) then
			t[k] = nil
			return true
		end
	end
	return false
end
