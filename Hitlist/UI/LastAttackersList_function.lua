local _, _addon = ...;

local trackingTable = {};

--- Set or update last attacker
-- @param name The name of the attacker
-- @param timestamp The timestamp of the attack
function _addon.LastAttackers_Set(name, timestamp)
    trackingTable[name] = timestamp;
end

--- Clear the last attacker table
function _addon:LastAttackers_Clear()
    wipe(trackingTable);
end

--- Show the last attacker list from current entries
function _addon:LastAttackers_Show()
	local timestamp = time();
    local sortingTable = {};

    for name, lastAttackTime in pairs(trackingTable) do
        if lastAttackTime + 60 > timestamp then
            table.insert(sortingTable, {name, lastAttackTime});
        end
    end	
    
    if #trackingTable == 0 then 
        return; 
    end
	
	table.sort(sortingTable, function(a,b)
		return a[2] > b[2];
    end)
    
    wipe(trackingTable);
    
    for k, v in ipairs(sortingTable) do
        table.insert(trackingTable, v[1]);
    end	

    HLUI_LastAttackers:ShowList(trackingTable);
end

--- Show the last attacker list filled with some example names
function _addon:LastAttackers_Demo()
	HLUI_LastAttackers:ShowList({"脑瘫网恋达人"});
end