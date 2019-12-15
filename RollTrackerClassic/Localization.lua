local RTC_TOCNAME,RTC = ...

-- Basic localizations
function RTC.GetLocale()
	local ColRed="|cffff4040"
	
	local DefaultEnGB = {
			["MsgNbRolls"] = "%d Roll(s)",
			["MsgRollCleared"] = "All rolls have been cleared.",
			["MsgUndoRoll"]="Undo all rolls.",
			["MsgAnnounce"] = "%s won with a roll of %d.",
			["MsgAnnounceTie"] = "Tie, %s won with a roll of %d.",
			["MsgNotRolled"]="The following people still need to roll or say '%s'",
			["MsgCheat"]="Ignoring %s's roll of %s (%s-%s).",  -- (player, roll, max_roll, min_roll)
			["MsgStart"]="New roll starting now! Type '/rnd' or '%s'",
			["MsgStartGreenAndNeed"]="New roll starting now! Type '/rnd' for need, '/rnd 1-50' for greed or '%s'",
			["MsgNextItem"]="Next item: %s",
			["MsgTooltip"]=ColRed.."Left click|r to open RTC |n"..ColRed.."Shift+Left click|r to open 'Loot Rolls'|n"..ColRed.."Right click|r to open options",
			["MsgBar"]="==============================",
			["MsgLocalRestart"]="The setting is not transferred until after a restart (/reload)",
			["MsgNbLoots"]="%d stored loot(s).",
			["MsgLootLine"]="%s: %s receives loot: %s", -- date, name, item
			["MsgLootCleared"] = "All stored loots have been cleared.",
			["MsgUndoLoot"]="Undo all loots.",
			["MsgLTnotenabled"]="Loot Tracker is not enabled.",
			["MsgRaidRoll"] = "%s won. (%d)",
			["MsgForcedAnnounce"]="No rolls",
			["MsgStartCD"]="Start a countdown with right click on [Announce] or '/rtc cd'",
						
			["TxtGreed"]="Greed",
			["TxtNeed"]="Need",
			["TxtLine"]="------------------------------------------------------------------------------------------------------",
			["pass"] = "pass",		
			
			["BtnClear"]="Clear",
			["BtnUndo"]="Undo",
			["BtnNotRolled"]="Not rolled",
			["BtnRoll"]="Roll",
			["BtnAnnounce"]="Announce",
			["BtnGreed"]="Greed",
			["BtnPass"]="Pass",			
			["BtnOpen"]="Open",
			["BtnConfig"]="Settings",
			["BtnLootRolls"]="Loot Rolls",
			["BtnOpenLoot"]="Loot Tracker",
			["BtnCSVExport"]="CSV Export",
			["BtnCancel"]="Cancel",
			["BtnRaidRoll"]="Raid Roll",
			["BtnColorNormal"]="Colour text",
			["BtnColorCheat"]="Colour cheat",
			["BtnColorGuild"]="Colour guild",
			["BtnColorInfo"]="Colour info",		
			["BtnColorChat"]="Colour chat message",
			["BtnColorScroll"]="Colour list entry",
			
			["EdtWhiteList"]="Whitelist ItemIds",
			["EdtNbLoots"]="Maximum stored loot",
			["EdtCSVexport"]="CSV-Export-Format",
			["EdtCDRefresh"]="Refresh Countdown after roll (seconds)",
			["EdtDefaultCD"]="Default Countdown (seconds)",	
			["EdtAutoCloseDelay"]="Delayed closing in seconds",
			["EdtAnnounceList"]="Entries in the announcement list",
			
			["TxtCSVJokers"]="%% %name% %class% %timestamp% %dd% %mm% %yy% %HH% %MM% %SS%",
			["TxtCSVJokers2"]="%iname% %irarity% %iraritytxt% %ilevel% %iid% %iprice% %icount% %itype% %itypetxt%",
			["TxtCSVJokersTitle"]="For CSV-Export you can use this jokers:",
			["TxtItemType"]="Attention! ItemType is independent of the rarity!",
			
			["TabRoll"]="Rolls",
			["TabLoot"]="Loot",
			["TabCSV"]="CSV",
			
			["PanelLootTracker"]="Loot Tracker",
			["HeaderRarity"]="Track Rarity",
			["HeaderItemType"]="Track ItemType",
			["HeaderSettings"]="Settings",
			["HeaderCustomLocales"]="Localization",
			["HeaderCSV"]="CSV-Export",
			["PanelAbout"]="About",
			["HeaderSlashCommand"]="Slash Commands",
			["HeaderCredits"]="Credits",
			["HeaderInfo"]="Information",
			["HeaderUsage"]="Usage",
		
			["Cboxshowminimapbutton"]="Show minimap button",
			["CboxLockMinimapButton"]="Lock minimap button position",		
			["CboxLockMinimapButtonDistance"]="Minimize minimap button distance",
			["CboxCloseOnClear"]="Close window after [Clear]",
			["CboxClearOnAnnounce"]="Clear rolls after [Announce]",
			["CboxCloseOnAnnounce"]="Close window after [Announce]",
			["CboxClearOnClose"]="Clear rolls after [Close]",
			["CboxIgnoreDouble"]="Ignore double rolls",
			["CboxRejectOutBounds"]="Reject rolls with bounds other than (1-100)",
			["CboxAnnounceIgnoreDouble"]="Only with [Announce]: Ignore double rolls",
			["CboxAnnounceRejectOutBounds"]="Only with [Announce]: Reject rolls with bounds other than (1-100)",
			["CboxNeedAndGreed"]="Use Need '/rnd' and Greed '/rnd 1-50' system, ignores out of bounce",
			["CboxShowNotRolled"]="Show [Not rolled] button",
			["CboxAutoLootRolls"]="Open 'Loot Rolls' automatically",
			["CboxAutoCloseLootRolls"]="Automatic close 'Loot Rolls' when everyone has rolled",
			["CboxClearOnStart"]="Clear when somebody starts a new roll",
			["CboxOpenOnStart"]="Open when somebody starts a new roll",
			["CboxColorName"]="Colorize names by class",
			["CboxShowClassIcon"]="Show class icon",
			["CboxOnDebug"]="Show debug information",
			["CboxShowGuildRank"]="Show guild rank",
			["CboxAutmaticAnnounce"]="Automatic announce rolls",
			
			["CboxLTShortMessage"]="Short Message",
			["CboxLTTrackSolo"]="Track solo",
			["CboxLTTrackGroup"]="Track party",
			["CboxLTTrackSRaid"]="Track raid with 10 or less members",
			["CboxLTTrackBRaid"]="Track raid with 11 or more members",
			["CboxLTEnable"]="Enable loot tracking",
			["CboxLTSmallFont"]="Small font",
			["CboxLTShowIcon"]="Show item icon",
			
			["SlashClearRolls"]="Clear rolls",
			["SlashClearLoot"]="Clear loot",
			["SlashClearLootRolls"]="Clear 'Loot Rolls'",
			["SlashUndoRolls"]="Recover last rolls",
			["SlashUndoLoot"]="Recover last loots",
			["SlashAnnounce"]="Announce winner of the last roll",
			["SlashNotRolled"]="Remind everyone who has not rolled",
			["SlashClose"]="Close main window",
			["SlashReset"]="Reset position of main window",
			["SlashConfig"]="Open Configuration",
			["SlashAbout"]="Open about",
			["SlashStart"]="Announce a new roll, <value> can be empty or itemlink",
			["SlashOpen"]="Open main window",
			["SlashRaidRoll"]="Roll a player name",
			["SlashRaidRollList"]="Output all player",
			["SlashCountdown"]="Countdown <value> in seconds",
			
			["AboutInfo"]="Have you ever tried to roll the 'Onyxia Hide Backpack' in a raid? RTC collects all roll results and sorts them. Ever thought about whether you wanted something for your second-equip, but didn't know if somebody needed it? RTC can automatically open the Blizzard 'Loot rolls' window, where you can see immediately who needs or has greed.|nIn raid ever lost the overview, who got what? Again, RTC can help you. On request, it records all items, including a variable export function.",
			
			["AboutSlashCommand"]="<value> can be true, 1, enable, false, 0, disable. If <value> is omitted, the current status switches.",
			
			["AboutUsage"]="RTC will automatically open when someone rolls the dice. Double rolls or rolls outside the default range are ignored on request.|nBy default, the automatic opening of 'Loot Rolls' is disabled. Likewise, the 'Loot Tracker' must be turned on manually.",
			
			["AboutCredits"]="Russian translation by tierggg and Hubbotu|nBaudzilla for the graphics/idea of the resize-code|nRollTracker Classic is an updated version of 'RollTracker Lite', originally by Jerry Chong - zanglang@gmail.com.",

			
		}
		
	local locales = {
		deDE = {
			["MsgNbRolls"] = "%d Würfelergebnisse",		
			["MsgRollCleared"] = "Alle Würfelergebnisse gelöscht.",
			["MsgUndoRoll"]="Alle Würfelergebnisse wieder hergestellt.",		
			["MsgAnnounce"]="%s hat mit einer %d gewonnen",
			["MsgAnnounceTie"] = "Gleichstand, %s haben mit einer %d gewonnen.",
			["MsgNotRolled"]="Noch nicht gewürfelt oder '%s' geschrieben:",
			["MsgCheat"]="%s wurf mit %s (%s-%s) wird ignoriert.",  -- (player, roll, max_roll, min_roll)
			["MsgStart"]="Neue Würfelrunde! Gib '/rnd' oder '%s' ein",
			["MsgStartGreenAndNeed"]="Neue Würfelrunde! Gib '/rnd' für Bedarf, '/rnd 1-50' für Gier oder '%s' ein",
			["MsgNextItem"]="Nächster Gegenstand: %s",		
			["MsgTooltip"]=ColRed.."Linksklick|r für RTC|n"..ColRed.."Shift+Linksklick|r für 'Beuteverteilung'|n"..ColRed.."Rechtsklick|r für Einstellungen",
			["MsgBar"]="==============================",	
			["MsgLocalRestart"]="Die Lokalisierung wird erst nach einem Neustart übernommen (/reload)",
			["MsgNbLoots"]="%d gespeicherte Beute.",
			["MsgLootLine"]="%s: %s erhält Beute: %s", -- date, name, item
			["MsgLootCleared"] = "Sämtliche gespeichte Beute gelöscht",
			["MsgUndoLoot"]="Beute wiederhergestellt.",
			["MsgLTnotenabled"]="Loot Tracker ist nicht aktiv",
			["MsgRaidRoll"]="RaidRoll: %s hat gewonnen (%d)",
			["MsgForcedAnnounce"]="Keine Würfelergebnisse",
			["MsgStartCD"]="Den Countdown mit rechtsklick auf [Ansagen] oder '/rtc cd' starten",
			
			["TxtGreed"]="Gier",
			["TxtNeed"]="Bedarf",
			["TxtLine"]="------------------------------------------------------------------------------------------------------",
			["pass"] = "passe",		
						
			["BtnClear"]="Löschen",
			["BtnUndo"]="Undo",
			["BtnNotRolled"]="Fehlende",
			["BtnRoll"]="Würfeln",
			["BtnAnnounce"]="Ansagen",
			["BtnGreed"]="Gier",
			["BtnPass"]="Passen",			
			["BtnOpen"]="Öffnen",
			["BtnConfig"]="Einstellungen",
			["BtnLootRolls"]="Beuteverteilung",
			["BtnOpenLoot"]="Loot Tracker",
			["BtnCSVExport"]="CSV Export",
			["BtnCancel"]="Abbruch",
			["BtnRaidRoll"]="Raid Roll",
			["BtnColorNormal"]="Text-Farbe",
			["BtnColorCheat"]="Cheat-Farbe",
			["BtnColorGuild"]="Gilden-Farbe",
			["BtnColorInfo"]="Info-Farbe",		
			["BtnColorChat"]="Chat-Nachricht-Farbe",
			["BtnColorScroll"]="Listeneintrag-Farbe",
			
			["EdtWhiteList"]="Whitelist ItemIds",
			["EdtNbLoots"]="Maximale Anzahl der gespeicherten Beute",
			["EdtCSVexport"]="CSV-Export-Format",
			["EdtCDRefresh"]="Countdown nach einem Wurf (Sekunden)",
			["EdtDefaultCD"]="Standard Countdown (Sekunden)",	
			["EdtAutoCloseDelay"]="Verzögertes schließen in Sekunden",
			["EdtAnnounceList"]="Einträge in der Ansagen-Liste",
			
			["TxtCSVJokers"]="%% %name% %class% %timestamp% %dd% %mm% %yy% %HH% %MM% %SS%",
			["TxtCSVJokers2"]="%iname% %irarity% %iraritytxt% %ilevel% %iid% %iprice% %icount% %itype% %itypetxt%",
			["TxtCSVJokersTitle"]="Für den CSV-Export stehen folgende Joker zur Verfügung",
			["TxtItemType"]="Achtung! ItemType ist unabhängig von der Seltenheit!",
			
			["TabRoll"]="Würfe",
			["TabLoot"]="Beute",
			["TabCSV"]="CSV",
			
			["PanelLootTracker"]="Loot Tracker",
			["HeaderRarity"]="Beachte Seltenheit",
			["HeaderItemType"]="Beachte ItemType",
			["HeaderSettings"]="Einstellungen",
			["HeaderCustomLocales"]="Lokalisierung",
			["HeaderCSV"]="CSV-Export",
			["PanelAbout"]="Über",
			["HeaderSlashCommand"]="Befehle",
			["HeaderCredits"]="Credits",
			["HeaderInfo"]="Information",
			["HeaderUsage"]="Usage",
			
			["Cboxshowminimapbutton"]="Minimap-Icon anzeigen",
			["CboxLockMinimapButton"]="Minimap-Icon-Position sperren",		
			["CboxLockMinimapButtonDistance"]="Minimap-Icon-Entfernung minimieren",
				
			["CboxCloseOnClear"]="Fenster schließen nach [Löschen]",
			["CboxClearOnAnnounce"]="Würfelergebnisse löschen nach [Ansagen]",
			["CboxCloseOnAnnounce"]="Fenster schließen nach [Ansagen]",
			["CboxClearOnClose"]="Würfelergebnisse löschen nach [Schließen]",
			["CboxIgnoreDouble"]="Doppelte Würfe ignorieren",
			["CboxRejectOutBounds"]="Würfe außerhalb 1-100 ignorieren",
			["CboxAnnounceIgnoreDouble"]="Nur bei [Ansagen]: Doppelte Würfe ignorieren",
			["CboxAnnounceRejectOutBounds"]="Nur bei [Ansagen]: Würfe außerhalb 1-100 ignorieren",
			["CboxNeedAndGreed"]="Verwende das Bedarf '/rnd' und Gier '/rnd 1-50' System, Würfe außerhalb ignorieren",
			["CboxShowNotRolled"]="Zeige [Fehlende] Button",
			["CboxAutoLootRolls"]="'Beuteverteilung' automatisch öffnen",
			["CboxAutoCloseLootRolls"]="'Beuteverteilung' automatisch schließen, wenn verwürfelt",
			["CboxClearOnStart"]="Würfelergebnisse löschen, wenn jemand eine neue Würfelrunde startet",
			["CboxOpenOnStart"]="RTC öffnen, wenn jemand eine neue Würfelrunde startet",
			["CboxColorName"]="Namen nach Klasse einfärben",
			["CboxShowClassIcon"]="Klassenzeichen anzeigen",
			["CboxOnDebug"]="Zeige Debug-Informationen",
			["CboxShowGuildRank"]="Zeige Gildenränge",
			["CboxAutmaticAnnounce"]="Würfelergebnisse automatisch ansagen",
			
			["CboxLTShortMessage"]="Kurzformat",
			["CboxLTTrackSolo"]="Nur wenn alleine",
			["CboxLTTrackGroup"]="Nur in einer Gruppe",
			["CboxLTTrackSRaid"]="Nur im Raid mit 10 oder weniger",
			["CboxLTTrackBRaid"]="Nur im Raud mít 11 oder mehr",
			["CboxLTEnable"]="Aktiviere loot tracking",
			["CboxLTSmallFont"]="Kleine Schrift",
			["CboxLTShowIcon"]="Zeige Beute-Icon",
			
			["SlashClearRolls"]="Würfelergebnisse löschen",
			["SlashClearLoot"]="Beute löschen",
			["SlashClearLootRolls"]="'Beuteverteilung' löschen",
			["SlashUndoRolls"]="Letzte Würfelergebnisse wiederherstellen",
			["SlashUndoLoot"]="Letzte Beute wiederherstellen",
			["SlashAnnounce"]="Gewinner der letzten Würfelrunde bekannt geben",
			["SlashNotRolled"]="Jeden erinnern, noch zu würfeln",
			["SlashClose"]="Hauptfenster schließen",
			["SlashReset"]="Fensterposition zurücksetzen",
			["SlashConfig"]="Konfiguration öffnen",
			["SlashAbout"]="About öffnen",
			["SlashStart"]="Neue Würfelrunde ankündigen, <value> kann leer oder ein ItemLink sein",
			["SlashOpen"]="Hauptfenster öffnen",
			["SlashRaidRoll"]="Würfle einen Mitspielernamen",
			["SlashRaidRollList"]="Ausgabe aller Mitspieler",
			["SlashCountdown"]="Countdown <value> in Sekunden",
			
			["AboutInfo"]="Hast du jemals versucht, um den 'Rucksack aus Onyxias Haut' in Raid zu verwürfeln? RTC sammelt alle Würfelergebnisse und sortiert sie. Schon mal überlegt, ob du was für dein Zweit-Equip haben wolltest, aber nicht wusstest, ob wer bedarf hat? RTC kann dir automatisch das Blizzard 'Beuteverteilung' Window öffnen. Dort siehst du sofort wer bedarf oder gier hat.|nIn Raid jemals die Übersicht verloren, wer was bekommen hat? Auch hier kann RTC dir helfen. Auf Wunsch zeichnet es alle Gegenstände auf, inklusive einer variablen Export-Funktion.",
			
			["AboutSlashCommand"]="<value> kann true,1,enable,false,0,disable sein. Wird <value> weggelassen, schaltet der aktuelle Status um.",
			
			["AboutUsage"]="RTC wird sich automatisch öffnen, wenn jemand würfelt. Doppelte Würfel oder würfe außerhalb des Standard-Bereichs werden auf wunsch ignoriert.|nStandardmäßig ist das automatische öffnen von 'Beuteverteilung' deaktivert. Genauso muss der 'Loot Tracker' manuell eingeschaltet werden.",
			
			["AboutCredits"]="Hubbotu und kavarus für die russische Übersetzung|nBaudzilla für die Grafiken/Idee des resize-code|nRollTracker Classic ist eine stark erweiterte Version von 'RollTracker Lite', ursprünglich von Jerry Chong - zanglang@gmail.com",
			

			
		},
		esMX = {
			["MsgRollCleared"] = "Todas las tiradas han sido borradas.",
			["MsgNbRolls"] = "%d Tiradas",
		},
		frFR = {
			["MsgRollCleared"] = "Tous les jets ont été effacés.",
			["MsgNbRolls"] = "%d Jet(s)",
		},
		ruRU = {
			["MsgNbRolls"] = "%d ролл(ов)",
			["MsgRollCleared"] = "Все роллы очищены.",
			["MsgUndoRoll"]="Отменить все роллы",
			["MsgAnnounce"] = "%s выигрывает, ролл %d.",
			["MsgAnnounceTie"] = "%s выигрывает, ролл %d.",
			["MsgNotRolled"]="Эти люди еще не роллили или не сказали '%s'",
			["MsgCheat"]="Игнорировать ролл %s на %s (%s-%s).",  -- (player, roll, max_roll, min_roll)
			["MsgStart"]="Новый ролл начат! Напиши '/rnd' или '%s'",
			["MsgStartGreenAndNeed"]="Новый ролл начат! Напиши '/rnd' для 'Нужно', '/rnd 1-50' для не откажусь или '%s'",
			["MsgNextItem"]="Новый ролл: %s",
			["MsgTooltip"]=ColRed.."ЛКМ|r открыть RTC |n"..ColRed.."Нажмите Shift+Left|r открыть 'Ролл Предметов'|n"..ColRed.."ПКМ|r открыть настройки",
			["MsgBar"]="==============================",
			["MsgLocalRestart"]="Настройка не передается до перезагрузки (/reload)",
			
			["TxtGreed"]="Не откажусь",
			["TxtNeed"]="Мне это нужно",
			["TxtLine"]="------------------------------------------------------------------------------------------------------",
			["pass"] = "пас",
			["BtnClear"]="Очистка",
			["BtnNotRolled"]="Не разроллено",
			["BtnRoll"]="Ролл",
			["BtnAnnounce"]="Объявить",
			["BtnGreed"]="Не откажусь",
			["BtnPass"]="Пас",
			
			["BtnOpen"]="Открыть",
			["BtnConfig"]="Настройки",
			["BtnLootRolls"]="Ролл Предметов",
			
			["HeaderSettings"]="Настройки",
			["HeaderCustomLocales"]="Перевод",
			["Cboxshowminimapbutton"]="Показать кнопку на мини-карте",
			["CboxCloseOnClear"]="Закрыть окно после [Очистка]",
			["CboxClearOnAnnounce"]="Очистить роллы после [Объявить]",
			["CboxCloseOnAnnounce"]="Закрыть окно после [Объявить]",
			["CboxClearOnClose"]="Очистить роллы после [Закрыть]",
			["CboxIgnoreDouble"]="Игнорировать двойные роллы",
			["CboxRejectOutBounds"]="Отклонить роллы с диапазоном не (1-100)",
			["CboxAnnounceIgnoreDouble"]="Только после [Объявить]: Игнорировать двойные роллы",
			["CboxAnnounceRejectOutBounds"]="Только после [Объявить]: Отклонить роллы с диапазоном не (1-100)",
			["CboxNeedAndGreed"]="'Не откажусь' - '/rnd' и 'Не откажусь' - '/rnd 1-50' , игнор ошибок",
			["CboxShowNotRolled"]="Показать [Пас] кнопку",
			["CboxAutoLootRolls"]="Открывать 'Ролл Предметов' автоматически",
			["CboxAutoCloseLootRolls"]="Автоматически закрывать 'Ролл Предметов' когда все отроллили",
			["CboxClearOnStart"]="Очищено, когда кто-то начинает новый ролл",
			["CboxOpenOnStart"]="Открыто, когда кто-то начинает новый ролл",
			["CboxColorName"]="Раскрась имена по классам",
			["CboxShowClassIcon"]="Показать значок класса",
		},
		zhCN = {
			["MsgRollCleared"] = "所有骰子已被清除。",
			["MsgNbRolls"] = "%d个骰子",
		},
		zhTW = {
			["MsgRollCleared"] = "所有擲骰紀錄已被清除。",
			["MsgNbRolls"] = "共計 %d 人擲骰",
		},
	}
	

	
	
	
	
	
	locales.esES=locales.esMX
	
	if RollTrackerClassicDB and RollTrackerClassicDB.OnDebug then
		for lkey,loc in pairs(locales) do
			if loc["MsgStart"] then
				for key,value in pairs(DefaultEnGB) do
					if loc[key]==nil then --or loc[key]==value then
						print ("RTC-Missing:"..lkey.."["..key.."]")
					end
				end
			end	
		end
	end
	
	
	local L = locales[GetLocale()] or {}
	
	if RollTrackerClassicDB and RollTrackerClassicDB.CustomLocales and type(RollTrackerClassicDB.CustomLocales) == "table" then
		for key,value in pairs(RollTrackerClassicDB.CustomLocales) do
			if value~=nil and value ~="" then
				L[key.."_org"]=L[key]
				L[key]=value
			end
		end
	end
	
	setmetatable(DefaultEnGB,{__index =function(t,k) return "["..k.."]" end})
	
	setmetatable(L, {
		__index = DefaultEnGB
	})
	
	return L
end