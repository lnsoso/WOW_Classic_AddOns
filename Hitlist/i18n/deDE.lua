local _addonName, _addon = ...;
local L = _addon:AddLocalization("deDE", true);
if L == nil then return; end

L["ERROR_SYNC_NOT_IN_GUILD"] = "Du bist in keiner Gilde, Gildenabgleich deaktiviert!";
L["ERROR_SYNC_CHANNEL_NAME"] = "Kanalname muss eingetragen sein wenn Gildenabgleich aktiviert ist!";
L["ERROR_SYNC_CHANNEL_JOIN"] = "Konnte Kanal nicht beitreten! Ist das Passwort falsch?";
L["SYNC_CHANNEL_JOINED"] = "Kanal beigetreten!";

L["ERROR_ENTRY_ALREADY_EXISTS"] = "Eintrag für %s ist bereits vorhanden, erhalten von %s.";
L["ERROR_MAXIMUM_REACHED"] = "Maximale Anzahl an lokalen Einträgen erreicht, du kannst nicht einfach jeden hinzufügen!";

L["CHATLINE_TARGET_FOUND"] = "Ziel gefunden -> %s";
L["CHATLINE_PLAYER_USED_SPELL"] = "Feindlicher Spieler %s hat |cFF77FF77|Hspell:%d|h[%s]|h|r benutzt!";
L["CHATLINE_PLAYER_USED_SPELL_LISTED"] = "Gelisteter Spieler %s hat |cFF77FF77|Hspell:%d|h[%s]|h|r benutzt!";

L["SETTINGS_HEAD_GENERAL"] = "Allgemein";
L["SETTINGS_HEAD_SYNC"] = "Datenabgleich";
L["SETTINGS_HEAD_TESTSHOW"] = "Teste/Zeige Funktionen";
L["SETTINGS_HEAD_DATA"] = "Daten Löschen";
L["SETTINGS_PLAY_SOUND"] = "Tonausgabe aktivieren";
L["SETTINGS_PLAY_SOUND_TT"] = "Spiele ein Warnsignal wenn ein Ziel gefunden wurde.";
L["SETTINGS_TEST_SOUND"] = "Ton bei weiterem Ziel";
L["SETTINGS_SHOW_KILLER_LIST"] = "Zeige Angreiferliste nach Tod";
L["SETTINGS_SHOW_KILLER_LIST_TT"] = "Eine Liste der letzten Angreifer mit der Möglichkeit sie hinzuzufügen.";
L["SETTINGS_STEALTH_ALERT_ALL"] = "Verstohlenheitswarnung für alle Spieler";
L["SETTINGS_STEALTH_ALERT_ALL_TT"] = "Addon zeigt Warnung für Verstohlenheit/Schleichen für alle Spieler an, nicht nur für jene auf der Liste.";
L["SETTINGS_SYNC_GUILD"] = "Abgleich mit Gilde";
L["SETTINGS_SYNC_GUILD_TT"] = "Sende und empfange Einträge über deine Gilde.";
L["SETTINGS_SYNC_CHANNEL"] = "Abgleich mit Kanal";
L["SETTINGS_SYNC_CHANNEL_TT"] = "Sende und empfange Einträge über einen eigenen Chatkanal.";
L["SETTINGS_CHANNEL_NAME"] = "Kanalname:";
L["SETTINGS_CHANNEL_PW"] = "Kanalpasswort:";
L["SETTINGS_TRIGGER_CD"] = "Auslöse-CD:";
L["SETTINGS_TRIGGER_CD_TT"] = "Nach dem Auslösen warte so viele Sekunden. Gefundene Ziele werden weiterhin im Chat und per Ton angekündigt.";
L["SETTINGS_TARGET_CD"] = "CD je Ziel:";
L["SETTINGS_TARGET_CD_TT"] = "Nach dem Auslösen für ein Ziel wird es für so viele Sekunden vollkommen ignoriert.";
L["SETTINGS_TEST_ALERT"] = "Zielbenachrichtigung";
L["SETTINGS_TEST_NEARBY"] = "Nahe Feinde";
L["SETTINGS_TEST_KILLER_LIST"] = "Letzte Angreifer";
L["SETTINGS_DELETE_SYNCDATA"] = "Empfangene Einträge";
L["SETTINGS_DELETE_SYNCDATA_SUCCESS"] = "Von anderen Spielern empfangene Daten wurden gelöscht!";
L["SETTINGS_DELETE_SYNCDATA_SUCCESS_NAME"] = "Von %s empfangene Daten wurden gelöscht!";
L["SETTINGS_DELETE_DATA_SUCCESS"] = "Liste wurde geleert!";
L["SETTINGS_SNAP_MINIMAP"] = "Button an Minimap einrasten";
L["SETTINGS_SNAP_MINIMAP_TT"] = "Raste Minimapbutton am Rand der Minimap ein.";
L["SETTINGS_DELETE_NBWLDATA"] = "Whitelist für nahe Feinde";
L["SETTINGS_DELETE_NBWLDATA_SUCCESS"] = "Whitelist für nahe Feinde wurde geleert!";
L["SETTINGS_NEARBY_MAX_LABEL"] = "Nahe Feinde Listengröße";
L["SETTINGS_NEARBY_MAX_TT"] = "Gibt an wie viele Spieler gleichzeitig in der Liste naher Feinde stehen können.";

L["SLASH_CHAT_COMMANDS"] = "|cFFFFFF00" .. _addonName .. " Befehle:";
L["SLASH_CHAT_SETTINGS"] = "|cFF00FFFF%s %s|r Einstellungen öffnen";
L["SLASH_CHAT_OPEN"] = "|cFF00FFFF%s %s|r Zeige Liste";
L["SLASH_CHAT_ADD"] = "|cFF00FFFF%s %s|r Zeige Hinzufügendialog";
L["SLASH_CHAT_NEARBY"] = "|cFF00FFFF%s %s|r Zeige und entsperre Liste naher Feinde";
L["SLASH_CHAT_UPDATE"] = "|cFF00FFFF%s %s|r Sende manuelle Datenanfrage falls Abgleichoptionen aktiviert sind, sollte unnötig sein";

L["UI_BACK"] = "Zurück";
L["UI_CANCEL"] = "Abbrechen";

L["UI_LIST_ADDED"] = "(vor %s)";
L["UI_LIST_DELMEN_TITLE"] = "Einträge Entfernen";
L["UI_LIST_DELMEN_DELALL"] = "ALLE Einträge";
L["UI_LIST_DELMEN_DELALLREC"] = "ALLE empfangenen Einträge";
L["UI_LIST_DELMEN_DELSPECIFIC"] = "Von spezifischem Spieler";
L["UI_ADDFORM_TITLE"] = "Ziel Hinzufügen";
L["UI_ADDFORM_NAME"] = "Name:";
L["UI_ADDFORM_REASON"] = "Grund:";
L["UI_ADDFORM_ADD_BUTTON"] = "Hinzufügen";
L["UI_ADDFORM_ERR_NAME"] = "Zielname fehlt oder ist zu kurz!";
L["UI_ADDFORM_ERR_NAME_INVALID"] = "Zielname ist ungültig!";
L["UI_ADDFORM_ERR_REASON"] = "Grund fehlt oder ist zu kurz!";
L["UI_RMFORM_TITLE"] = "Entferne Einträge";
L["UI_RMFORM_DESC"] = "Dies wird alle Einträge entfernen, welche vom angegebenen Spieler empfangen wurden.";
L["UI_RMFORM_ERR_MISSING"] = "Name fehlt oder ist zu kurz!";
L["UI_RMFORM_REMOVE"] = "Entfernen";
L["UI_RMOTHER_TITLE"] = "Entferne Fremdeinträge";
L["UI_RMOTHER_DESC"] = "Dies wird alle Einträge entfernen, welche von anderen Spielern empfangen wurden.";
L["UI_RMALL_TITLE"] = "Entferne alle Einträge";
L["UI_RMALL_DESC"] = "Dies wird alle Einträge löschen, deine mit inbegriffen!";
L["UI_RMALL_REMOVE"] = "Alles entfernen";

L["UI_LIST_BUTTON_NEARBY_SHOW"] = "Nahe Feinde UI anzeigen";
L["UI_LIST_BUTTON_NEARBY_UNLOCK"] = "Nahe Feinde UI entsperren";
L["UI_LIST_BUTTON_NEARBY_UNLOCK_COMBAT"] = "Entsperren im Kampf nicht möglich!";
L["UI_LIST_BUTTON_SETTINGS"] = "Einstellungen öffnen";
L["UI_LIST_BUTTON_ADD"] = "Eintrag hinzufügen";
L["UI_LIST_BUTTON_DELETE"] = "Einträge verwalten";

L["UI_KILLERLIST_TITLE"] = "Letzte Angreifer";

L["TIME_UNIT_SECOND"] = "Sekunde";
L["TIME_UNIT_MINUTE"] = "Minute";
L["TIME_UNIT_HOUR"] = "Stunde";
L["TIME_UNIT_DAY"] = "Tag";
L["TIME_UNIT_WEEK"] = "Woche";
L["TIME_UNIT_MONTH"] = "Monat";
L["TIME_UNIT_SECONDS"] = "Sekunden";
L["TIME_UNIT_MINUTES"] = "Minuten";
L["TIME_UNIT_HOURS"] = "Stunden";
L["TIME_UNIT_DAYS"] = "Tage";
L["TIME_UNIT_WEEKS"] = "Wochen";
L["TIME_UNIT_MONTHS"] = "Monate";

L["UI_MMB_OPEN"] = "Öffne " .. _addonName;

L["UI_TARGETDISP_TARGET_FOUND"] = "ZIEL GEFUNDEN";
L["UI_TARGETDISP_TARGETING_LOCKED"] = "Zielauswahl funktioniert nach Kampf!";
L["UI_TARGETDISP_TT_TARGET"] = "Linksklick für Zielauswahl.";
L["UI_TARGETDISP_TT_TARGET_HIDE"] = "Linksklick für Zielauswahl, Rechtsklick zum schließen.";

L["UI_TT_PLAYER_ON_LIST"] = "Spieler ist auf der Liste:";
L["UI_TT_YOU"] = "dir";
L["UI_TT_ADDED_BY"] = "(Von %s vor %s hinzugefügt)";

L["NBL_TITLE"] = "Nahe Feinde";
L["UI_NBL_TT_TARGET_WL"] = "Linksklick für Zielauswahl, (Umschalt-)Rechtsklick zum (permanenten) verbergen.";