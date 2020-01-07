-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

DoIt.Player = {
    init = function ()
        -- onPlayerLogin Handler handled by magnet buttons...
        DoIt.Events.onPlayerReady:subscribe(function ()
            local _ts = tostring;
            addon.system.PlayerName = addon.GetFullPlayerName();
            addon.Debug("{{ System Information }} Version: ".._ts(addon.system.version)..", Build: ".._ts(addon.system.build)..", isClassic: ".._ts(addon.system.isClassic)..", PlayerName = ".._ts(addon.system.PlayerName));
        end)
    end,
    getName = function ()
        return addon.GetFullPlayerName();
    end,
    getInfo = addon.GetPlayerInfo,
    hasAura = function (spellName)
        local i;
        for i = 1, BUFF_MAX_DISPLAY do
            local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura("player", i);
            if (name) and (name == spellName) then
                return true;
            end
        end
        return false;
    end
}