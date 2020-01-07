local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RaidSummon", "deDE", false, true)
if not L then return end

L["RaidSummon"] = "RaidSummon"
L["Language"] = "Deutsch"
L["AddonEnabled"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Version ' .. X .. ' von ' .. Y .. ' geladen'
end
L["AddonDisabled"] = "RaidSummon deaktiviert"
L["FrameHeader"] = function(X)
	return 'RaidSummon v' .. X
end
L["Lockdown"] = "|cff9482c9RaidSummon:|r Du befindest dich im Kampf, Aktion abgebrochen"
L["noRaid"] = "|cff9482c9RaidSummon:|r Keine Schlachtzuggruppe gefunden."
L["MemberRemoved"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Entferne Schlachtzugsmitglieder ' .. X .. ' von der Beschörungsliste, wie von ' .. Y .. ' angefordert'
end
L["MemberAdded"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Füge Schlachtzugsmitglieder ' .. X .. ' zu der Beschörungsliste hinzu, wie von ' .. Y .. ' angefordert'
end

--Options
L["OptionZoneName"] = "Gebiet"
L["OptionZoneDesc"] = "Schaltet die Ankündigung von Gebieten (z.B. Orgrimmar) und Teilgebieten (z.B. Tal der Weisheit)ein."
L["OptionWhisperName"] = "Flüstern"
L["OptionWhisperDesc"] = "Schaltet die Flüsterfunktion beim Beschwören ein."
L["OptionHelpName"] = "Hilfe"
L["OptionHelpDesc"] = "Zeigt eine Liste der möglichen Kommandos und Optionen an."
L["OptionConfigName"] = "Konfiguration"
L["OptionConfigDesc"] = "Öffnet das Konfigurationsmenü."
L["OptionGroupOptionsName"] = "Optionen"
L["OptionGroupCommandsName"] = "Kommandos"
L["OptionHeaderProfileName"] = "ACE3 Profile"
L["OptionListName"] = "Liste"
L["OptionListDesc"] = "Zeigt die Liste der Schlachtzugsmitglieder an, die eine Beschwörung angefordert haben."
L["OptionClearName"] = "Löschen"
L["OptionClearDesc"] = "Löscht die Beschörungsliste."
L["OptionToggleName"] = "Anzeige"
L["OptionToggleDesc"] = "Zeigt die Beschörungsliste an oder versteckt diese."
L["OptionAddName"] = "Hinzufügen"
L["OptionAddDesc"] = "Fügt ein Schlachtzugsmitglieder zur Beschörungsliste hinzu (Groß- und Kleinschreibung beachten)."
L["OptionRemoveName"] = "Entfernen"
L["OptionRemoveDesc"] = "Entfernt ein Schlachtzugsmitglieder von der Beschörungsliste (Groß- und Kleinschreibung beachten)."

--Slash Command Options
L["OptionWhisperEnabled"] = "|cff9482c9RaidSummon:|r Option Flüstern |cff00ff00eingeschaltet|r"
L["OptionWhisperDisabled"] = "|cff9482c9RaidSummon:|r Option Flüstern |cffff0000ausgeschaltet|r"
L["OptionZoneEnabled"] = "|cff9482c9RaidSummon:|r Option Gebiet |cff00ff00eingeschaltet|r"
L["OptionZoneDisabled"] = "|cff9482c9RaidSummon:|r Option Gebiet |cffff0000ausgeschaltet|r"
L["OptionHelpPrint"] = [[
|cff9482c9RaidSummon Verwendung:|r
/rs oder /raidsummon { clear | config | help | list | add | toggle | whisper | zone }
 - |cff9482c9clear|r: Löscht die Beschörungsliste.
 - |cff9482c9config|r: Öffnet das Konfigurationsmenü.
 - |cff9482c9help|r: Zeigt eine Liste der möglichen Kommandos und Optionen an.
 - |cff9482c9list|r: Zeigt die Liste der Schlachtzugsmitglieder an, die eine Beschwörung angefordert haben.
 - |cff9482c9add|r: Fügt ein Schlachtzugsmitglieder zur Beschörungsliste hinzu  (Groß- und Kleinschreibung beachten).
 - |cff9482c9remove|r: Entfernt ein Schlachtzugsmitglieder von der Beschörungsliste  (Groß- und Kleinschreibung beachten).
 - |cff9482c9toggle|r: Zeigt die Beschörungsliste an oder versteckt diese.
 - |cff9482c9whisper|r: Schaltet die Flüsterfunktion beim Beschwören ein.
 - |cff9482c9zone|r: Schaltet die Ankündigung von Gebieten (z.B. Orgrimmar) und Teilgebieten (z.B. Tal der Weisheit) ein.
Um das Fenster zu verschieben Umschalttaste + linke Maustaste verwenden.
]]
L["OptionListEmpty"] = "|cff9482c9RaidSummon:|r Beschörungsliste ist leer"
L["OptionList"] = "|cff9482c9RaidSummon:|r Schlachtzugsmitglieder die eine Beschwörung angefordert haben:"
L["OptionClear"] = "|cff9482c9RaidSummon:|r Beschörungsliste gelöscht"

--Summon Announce
--W=Whisper/R=Raid Z=Zone S=Subzone T=Target Player
L["SummonAnnounceRZS"] = function(T,Z,S)
	return 'RaidSummon: Beschwöre ' .. T .. ' nach ' .. Z .. ' - ' .. S
end
L["SummonAnnounceWZS"] = function(Z,S)
	return 'RaidSummon: Beschwöre dich nach ' .. Z .. ' - ' .. S
end
L["SummonAnnounceRZ"] = function(T,Z,S)
	return 'RaidSummon: Beschwöre ' .. T .. ' nach ' .. Z
end
L["SummonAnnounceWZ"] = function(Z,S)
	return 'RaidSummon: Beschwöre dich nach ' .. Z
end
L["SummonAnnounceR"] = function(T)
	return 'RaidSummon: Beschwöre ' .. T
end
L["SummonAnnounceW"] = "RaidSummon: Beschwöre dich"
L["SummonAnnounceError"] = "|cff9482c9RaidSummon:|r Fehler bei der Ankündigung"
L["TargetMissmatch"] = function(X,Y)
	return '|cff9482c9RaidSummon:|r Beschwören abgebrochen. Dein Target ' .. X .. ' stimmt nicht mit dem Namen überein, der angeklickt wurde ' .. Y
end