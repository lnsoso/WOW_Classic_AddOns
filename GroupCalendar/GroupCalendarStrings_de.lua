﻿if GetLocale() == "deDE" then
    GroupCalendar_cTitle = "Group Calendar v%s";

    GroupCalendar_cSun = "So";
    GroupCalendar_cMon = "Mo";
    GroupCalendar_cTue = "Di";
    GroupCalendar_cWed = "Mi";
    GroupCalendar_cThu = "Do";
    GroupCalendar_cFri = "Fr";
    GroupCalendar_cSat = "Sa";

	GroupCalendar_cSunday = "Sonntag";
	GroupCalendar_cMonday = "Montag";
	GroupCalendar_cTuesday = "Dienstag";
	GroupCalendar_cWednesday = "Mittwoch";
	GroupCalendar_cThursday = "Donnerstag";
	GroupCalendar_cFriday = "Freitag";
	GroupCalendar_cSaturday = "Samstag";
	
	GroupCalendar_Settings_ShowDebug = "Display Debug Messages";
	GroupCalendar_Settings_ShowDebugTip = "Show/Hide debug messages.";
	GroupCalendar_Settings_ShowMinimap = "Show Minimap";
	GroupCalendar_Settings_ShowMinimapTip = "Show/Hide the minimap icon.";
	GroupCalendar_Settings_MondayFirstDay = "Monday first day of week";
	GroupCalendar_Settings_MondayFirstDayTip = "Display Monday as the first day in the calendar.";
	GroupCalendar_Settings_Use24HrTime = "Verwenden Sie die 24-Stunden-Zeit";
	GroupCalendar_Settings_Use24HrTimeTip = "Verwenden Sie die 24-Stunden-Zeit";

    GroupCalendar_cSelfWillAttend = "%s wird teilnehmen";

    GroupCalendar_cMonthNames = {"Januar", "Februar", "M\195\164rz", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"};
	GroupCalendar_cDayOfWeekNames = {GroupCalendar_cSunday, GroupCalendar_cMonday, GroupCalendar_cTuesday, GroupCalendar_cWednesday, GroupCalendar_cThursday, GroupCalendar_cFriday, GroupCalendar_cSaturday};
    
    GroupCalendar_cLoadMessage = "GroupCalendar geladen. Gib /calendar zur Anzeige ein";
    GroupCalendar_cInitializingGuilded = "GroupCalendar: Initialisiere Einstellungen f\195\188r Gildenmitglieder";
    GroupCalendar_cInitializingUnguilded = "GroupCalendar: Initialisiere Einstellungen f\195\188r andere Spieler";
    GroupCalendar_cLocalTimeNote = "(%s lokal)";

    GroupCalendar_cOptions = "Setup...";

    GroupCalendar_cCalendar = "Kalender";
    GroupCalendar_cChannel = "Channel";
    GroupCalendar_cTrust = "Berechtigungen";
    GroupCalendar_cAbout = "\195\156ber";

	GroupCalendar_cUseServerDateTime = "Benutze Server-Zeitformat";
	GroupCalendar_cUseServerDateTimeDescription = "Aktivieren um Events im Server Zeitformat anzuzeigen. Deaktivieren um Events im lokalen Zeitformat anzuzeigen";
	    
    GroupCalendar_cChannelStatus =
    {
		Starting = {mText = "Status: Beginnend", mColor = {r = 1, g = 1, b = 0.3}},
		Synching = {mText = "Status: Synchronisieren", mColor = {r = 0.3, g = 1, b = 0.3}},
        Connected = {mText = "Status: In Verbindung gebracht", mColor = {r = 0.3, g = 1, b = 0.3}},
        Disconnected = {mText = "Status: Getrennt", mColor = {r = 1, g = 0.2, b = 0.4}},
        Initializing = {mText = "Status: Initialisierung", mColor = {r = 1, g = 1, b = 0.3}},
		Error = {mText = "Error: %s", mColor = {r = 1, g = 0.2, b = 0.4}},
    };

    GroupCalendar_cConnected = "Verbunden";
    GroupCalendar_cDisconnected = "Getrennt";
	GroupCalendar_cTooManyChannels = "Man kann immer nur in h\195\182chstens 10 Channels gleichzeitig sein";
	GroupCalendar_cJoinChannelFailed = "Fehler beim Betreten des Channels";
	GroupCalendar_cWrongPassword = "Falsches Passwort";
	GroupCalendar_cAutoConfigNotFound = "Keine Daten in Gilden Notizen gefunden";
	GroupCalendar_cErrorAccessingNote = "Fehler beim empfangen der Konfigurationsdaten";

    GroupCalendar_cTrustConfigTitle = "Berechtigungen Setup";
    GroupCalendar_cTrustConfigDescription = "Vertrauen bestimmt, wer Ereignisse erstellen kann. Nur der Gildenleiter kann diese Einstellungen ändern.";
    GroupCalendar_cTrustGroupLabel = "Berechtigt:";
    GroupCalendar_cEvent = "Event";
    GroupCalendar_cAttendance = "Anmeldungen";

    GroupCalendar_cAboutTitle = "\195\156ber GroupCalendar";
    GroupCalendar_cTitleVersion = "GroupCalendar v"..gGroupCalendar_VersionString;
    GroupCalendar_cAuthor = "Klassischer Autor: Magne - Remulos".."\n".."Vanille-Autor: Baylord - Thunderlord";
    GroupCalendar_cTestersTitle = "Testerinnen";
    GroupCalendar_cSpecialThanksTitle = "Besonderer Dank";
    GroupCalendar_cRebuildDatabase = "Datenbank erneuern";
    GroupCalendar_cRebuildDatabaseDescription = "Erneuert den Event-Datenbestand deines Charakters.  Dies kann Probleme beheben, wenn andere Spieler nicht alle deine Events sehen k\195\182nnen. Es besteht ein geringes Risiko das einige Anmeldungs-Best\195\164tigungen verloren gehen k\195\182nnen.";

    GroupCalendar_cTrustGroups =
    {
        "Jeder mit Zugriff auf den Daten Channel",
        "Alle Gildenmitglieder",
        "Nur Spieler aus der Berechtigungs Liste"
    };

    GroupCalendar_cTrustAnyone = "Berechtigt jeden mit Zugriff auf den Daten Channel";
    GroupCalendar_cTrustGuildies = "Berechtigt andere Mitglieder deiner Gilde";
    GroupCalendar_cTrustMinRank = "Mindestrang:";
    GroupCalendar_cTrustNobody = "Berechtigt nur Spieler die in der unteren Liste eingetragen sind";
    GroupCalendar_cTrustedPlayers = "Berechtigte Spieler";
    GroupCalendar_cExcludedPlayers = "Ausgeschlossene Spieler"
    GroupCalendar_cPlayerName = "Spieler Name:";
    GroupCalendar_cAddTrusted = "Berechtigen";
    GroupCalendar_cRemoveTrusted = "Entfernen";
    GroupCalendar_cAddExcluded = "Ausschlie\195\159en";

    CalendarEventViewer_cTitle = "Event Details";
    CalendarEventViewer_cDone = "Fertig";

    CalendarEventViewer_cLevelRangeFormat = "Level %i bis %i";
    CalendarEventViewer_cMinLevelFormat = "Ab Level %i";
    CalendarEventViewer_cMaxLevelFormat = "Bis Level %i";
    CalendarEventViewer_cAllLevels = "Alle Level";
    CalendarEventViewer_cSingleLevel = "Nur Level %i";

    CalendarEventViewer_cYes = "Ja - Ich werde teilnehmen";
    CalendarEventViewer_cNo = "Nein - Ich werde nicht teilnehmen";

    CalendarEventViewer_cResponseMessage =
    {
        "Status: Nichts gesendet",
        "Status: Warte auf Best\195\164tigung",
        "Status: Best\195\164tigung - Akzeptiert",
        "Status: Best\195\164tigung - StandBy",
        "Status: Best\195\164tigung - Abgelehnt",
		"Status: Banned from event",
    };

    CalendarEventEditorFrame_cTitle = "Event Neu/Bearbeiten";
    CalendarEventEditor_cDone = "Fertig";
    CalendarEventEditor_cDelete = "L\195\182schen";

    CalendarEventEditor_cConfirmDeleteMsg = "L\195\182schen \"%s\"?"

    -- Event names

	GroupCalendar_cGeneralEventGroup = "Allgemein";
	GroupCalendar_cRaidEventGroup = "Raids";
	GroupCalendar_cDungeonEventGroup = "Dungeons";
	GroupCalendar_cBattlegroundEventGroup = "Schlachtfelder";

    GroupCalendar_cMeetingEventName = "Treffen";
    GroupCalendar_cBirthdayEventName = "Geburtstag";
	GroupCalendar_cRoleplayEventName = "Rollenspiel";
	GroupCalendar_cActivityEventName = "Veranstaltung";

	GroupCalendar_cAQREventName = "Ruinen von Ahn'Qiraj";
	GroupCalendar_cAQTEventName = "Tempel von Ahn'Qiraj";
    GroupCalendar_cBFDEventName = "Blackfathom Tiefen";
    GroupCalendar_cBRDEventName = "Blackrocktiefen";
    GroupCalendar_cUBRSEventName = "Obere Blackrockspitze";
    GroupCalendar_cLBRSEventName = "Untere Blackrockspitze";
    GroupCalendar_cBWLEventName = "Pechschwingenhort";
    GroupCalendar_cDeadminesEventName = "Todesminen";
    GroupCalendar_cDMEventName = "D\195\188sterbruch";
    GroupCalendar_cGnomerEventName = "Gnomeregan";
    GroupCalendar_cMaraEventName = "Maraudon";
    GroupCalendar_cMCEventName = "Geschmolzener Kern";
    GroupCalendar_cOnyxiaEventName = "Onyxias Hort";
    GroupCalendar_cRFCEventName = "Ragefireabgrund";
    GroupCalendar_cRFDEventName = "H\195\188gel von Razorfen";
    GroupCalendar_cRFKEventName = "Kral von Razorfen";
    GroupCalendar_cSMEventName = "Scharlachrotes Kloster";
    GroupCalendar_cScholoEventName = "Scholomance";
    GroupCalendar_cSFKEventName = "Burg Shadowfang";
    GroupCalendar_cStockadesEventName = "Verlies";
    GroupCalendar_cStrathEventName = "Stratholme";
    GroupCalendar_cSTEventName = "Versunkener Tempel";
    GroupCalendar_cUldEventName = "Uldaman";
    GroupCalendar_cWCEventName = "H\195\182hlen des Wehklagens";
    GroupCalendar_cZFEventName = "Zul'Farrak";
    GroupCalendar_cZGEventName = "Zul'Gurub";
	GroupCalendar_cNaxxEventName = "Naxxramas";

	GroupCalendar_cPvPEventName = "General PvP";
	GroupCalendar_cABEventName = "Arathi Becken";
	GroupCalendar_cAVEventName = "Alterac Tal";
	GroupCalendar_cWSGEventName = "Warsong Schlucht";
	
	GroupCalendar_cZGResetEventName = "Zul'Gurub Resets";
	GroupCalendar_cMCResetEventName = "Molten Core Resets";
	GroupCalendar_cOnyxiaResetEventName = "Onyxia Resets";
	GroupCalendar_cBWLResetEventName = "Blackwing Lair Resets";
	GroupCalendar_cAQRResetEventName = "Ahn'Qiraj Ruins Resets";
	GroupCalendar_cAQTResetEventName = "Ahn'Qiraj Temple Resets";
	GroupCalendar_cNaxxResetEventName = "Naxxramas Resets";

	GroupCalendar_cTransmuteCooldownEventName = "Transmute Available";
	GroupCalendar_cSaltShakerCooldownEventName = "Salt Shaker Available";
	GroupCalendar_cMoonclothCooldownEventName = "Mooncloth Available";
	GroupCalendar_cSnowmasterCooldownEventName = "SnowMaster 9000 Available";

	GroupCalendar_cPersonalEventOwner = "Private";

	GroupCalendar_cRaidInfoMCName = GroupCalendar_cMCEventName;
	GroupCalendar_cRaidInfoOnyxiaName = GroupCalendar_cOnyxiaEventName;
	GroupCalendar_cRaidInfoZGName = GroupCalendar_cZGEventName;
	GroupCalendar_cRaidInfoBWLName = GroupCalendar_cBWLEventName;
	GroupCalendar_cRaidInfoAQRName = GroupCalendar_cAQREventName;
	GroupCalendar_cRaidInfoAQTName = GroupCalendar_cAQTEventName;
	GroupCalendar_cRaidInfoNaxxName = GroupCalendar_cNaxxEventName;
	
    -- Race names

    GroupCalendar_cDwarfRaceName = "Zwerg";
    GroupCalendar_cGnomeRaceName = "Gnom";
    GroupCalendar_cHumanRaceName = "Mensch";
    GroupCalendar_cNightElfRaceName = "Nachtelf";
    GroupCalendar_cOrcRaceName = "Ork";
    GroupCalendar_cTaurenRaceName = "Tauren";
    GroupCalendar_cTrollRaceName = "Troll";
    GroupCalendar_cUndeadRaceName = "Untote";
    GroupCalendar_cBloodElfRaceName = "Blutelf";
    GroupCalendar_cDraeneiRaceName = "Draenei";

    -- Class names

    GroupCalendar_cDruidClassName = "Druide";
    GroupCalendar_cHunterClassName = "J\195\164ger";
    GroupCalendar_cMageClassName = "Magier";
    GroupCalendar_cPaladinClassName = "Paladin";
    GroupCalendar_cPriestClassName = "Priester";
    GroupCalendar_cRogueClassName = "Schurke";
    GroupCalendar_cShamanClassName = "Schamane";
    GroupCalendar_cWarlockClassName = "Hexenmeister";
    GroupCalendar_cWarriorClassName = "Krieger";

    -- Plural forms of class names

    GroupCalendar_cDruidsClassName = "Druiden";
    GroupCalendar_cHuntersClassName = "J\195\164ger";
    GroupCalendar_cMagesClassName = "Magier";
    GroupCalendar_cPaladinsClassName = "Paladine";
    GroupCalendar_cPriestsClassName = "Priester";
    GroupCalendar_cRoguesClassName = "Schurken";
    GroupCalendar_cShamansClassName = "Schamanen";
    GroupCalendar_cWarlocksClassName = "Hexenmeister";
    GroupCalendar_cWarriorsClassName = "Krieger";

    -- ClassColorNames are the indices for the RAID_CLASS_COLORS array found in FrameXML\Fonts.xml
    -- in the English version of WoW these are simply the class names in caps, I don't know if that's
    -- true of other languages so I'm putting them here in case they need to be localized

    GroupCalendar_cDruidClassColorName = "DRUID";
    GroupCalendar_cHunterClassColorName = "HUNTER";
    GroupCalendar_cMageClassColorName = "MAGE";
    GroupCalendar_cPaladinClassColorName = "PALADIN";
    GroupCalendar_cPriestClassColorName = "PRIEST";
    GroupCalendar_cRogueClassColorName = "ROGUE";
    GroupCalendar_cShamanClassColorName = "SHAMAN";
    GroupCalendar_cWarlockClassColorName = "WARLOCK";
    GroupCalendar_cWarriorClassColorName = "WARRIOR";

    -- Label forms of the class names for the attendance panel.  Usually just the plural
    -- form of the name followed by a colon

    GroupCalendar_cDruidsLabel = GroupCalendar_cDruidsClassName..":";
    GroupCalendar_cHuntersLabel = GroupCalendar_cHuntersClassName..":";
    GroupCalendar_cMagesLabel = GroupCalendar_cMagesClassName..":";
    GroupCalendar_cPaladinsLabel = GroupCalendar_cPaladinsClassName..":";
    GroupCalendar_cPriestsLabel = GroupCalendar_cPriestsClassName..":";
    GroupCalendar_cRoguesLabel = GroupCalendar_cRoguesClassName..":";
    GroupCalendar_cShamansLabel = GroupCalendar_cShamansClassName..":";
    GroupCalendar_cWarlocksLabel = GroupCalendar_cWarlocksClassName..":";
    GroupCalendar_cWarriorsLabel = GroupCalendar_cWarriorsClassName..":";

    GroupCalendar_cTimeLabel = "Uhrzeit:";
    GroupCalendar_cDurationLabel = "Dauer:";
    GroupCalendar_cEventLabel = "Event:";
    GroupCalendar_cTitleLabel = "Titel:";
    GroupCalendar_cLevelsLabel = "Level:";
    GroupCalendar_cLevelRangeSeparator = "bis";
    GroupCalendar_cDescriptionLabel = "Beschreibung:";
    GroupCalendar_cCommentLabel = "Kommentar:";

    CalendarEditor_cNewEvent = "Neues Event...";
    CalendarEditor_cEventsTitle = "Events";

	CalendarEventEditor_cNotTrustedMsg = "Ereignisse können aufgrund von Vertrauenseinstellungen nicht erstellt werden";
	CalendarEventEditor_cOk = "in Ordnung";

    CalendarEventEditor_cNotAttending = "Nicht angemeldet";
    CalendarEventEditor_cConfirmed = "Best\195\164tigt";
    CalendarEventEditor_cDeclined = "Abgelehnt";
    CalendarEventEditor_cStandby = "Auf Warteliste";
	CalendarEventEditor_cPending = "Wartet...";
    CalendarEventEditor_cUnknownStatus = "Unbekannt %s";

    GroupCalendar_cChannelNameLabel = "Channel Name:";
    GroupCalendar_cPasswordLabel = "Passwort:";

    GroupCalendar_cTimeRangeFormat = "%s bis %s";
    
	GroupCalendar_cPluralMinutesFormat = "%d Minuten";
	GroupCalendar_cSingularHourFormat = "%d Stunde";
	GroupCalendar_cPluralHourFormat = "%d Stunden";
	GroupCalendar_cSingularHourPluralMinutes = "%d Stunde %d Minuten";
	GroupCalendar_cPluralHourPluralMinutes = "%d Stunden %d Minuten";
	
	GroupCalendar_cLongDateFormat = "$day. $month $year";
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $day. $month $year";
	
	GroupCalendar_cNotAttending = "Abgemeldet";
	GroupCalendar_cAttending = "Angemeldet";
	GroupCalendar_cPendingApproval = "Anmeldung l\195\164uft";

	GroupCalendar_cQuestAttendanceNameFormat = "$name ($role $level $race)";
	GroupCalendar_cMeetingAttendanceNameFormat = "$name ($role $level $class)";

	GroupCalendar_cNumAttendeesFormat = "%d Anmeldungen";
	
	BINDING_HEADER_GROUPCALENDAR_TITLE = "GroupCalendar";
	BINDING_NAME_GROUPCALENDAR_TOGGLE = "GroupCalendar an/aus";

	-- Tradeskill cooldown items
	
	GroupCalendar_cHerbalismSkillName = "Kr\195\164uterkunde";
	GroupCalendar_cAlchemySkillName = "Alchimie";
	GroupCalendar_cEnchantingSkillName = "Verzauberkunst";
	GroupCalendar_cLeatherworkingSkillName = "Lederverarbeitung";
	GroupCalendar_cSkinningSkillName = "K\195\188rschnerei";
	GroupCalendar_cTailoringSkillName = "Schneiderei";
	GroupCalendar_cMiningSkillName = "Bergbau";
	GroupCalendar_cBlacksmithingSkillName = "Schmiedekunst";
	GroupCalendar_cEngineeringSkillName = "Ingenieurskunst";
	
	GroupCalendar_cTransmuteMithrilToTruesilver = "Transmutieren: Mithril in Echtsilber";
	GroupCalendar_cTransmuteIronToGold = "Transmutieren: Eisen in Gold";
	GroupCalendar_cTransmuteLifeToEarth = "Transmutieren: Leben zu Erde";
	GroupCalendar_cTransmuteWaterToUndeath = "Transmutieren: Wasser zu Untod";
	GroupCalendar_cTransmuteWaterToAir = "Transmutieren: Wasser zu Luft";
	GroupCalendar_cTransmuteUndeathToWater = "Transmutieren: Untod zu Wasser";
	GroupCalendar_cTransmuteFireToEarth = "Transmutieren: Feuer zu Erde";
	GroupCalendar_cTransmuteEarthToLife = "Transmutieren: Erde zu Leben";
	GroupCalendar_cTransmuteEarthToWater = "Transmutieren: Erde zu Wasser";
	GroupCalendar_cTransmuteAirToFire = "Transmutieren: Luft zu Feuer";
	GroupCalendar_cTransmuteArcanite = "Transmutieren: Arkanit";
	GroupCalendar_cMooncloth = "Mondstoff";

	GroupCalendar_cCharactersLabel = "Character:";
	GroupCalendar_cRoleLabel = "Role:";
	GroupCalendar_cTankLabel = "Tank";
	GroupCalendar_cHealerLabel = "Healer";
	GroupCalendar_cDpsLabel = "DPS";
	GroupCalendar_cUnknownRoleLabel = "Unknown";

	GroupCalendar_cConfirmed = "Accepted";
	GroupCalendar_cStandby = "Standby";
	GroupCalendar_cDeclined = "Declined";
	GroupCalendar_cRemove = "Remove";
	GroupCalendar_cEditPlayer = "Edit Player...";
	GroupCalendar_cInviteNow = "Inivte to group";
	GroupCalendar_cStatus = "Status";
	GroupCalendar_cAddPlayerEllipses = "Add player...";

	GroupCalendar_cAddPlayer = "Add player";
	GroupCalendar_cPlayerLevel = "Level:";
	GroupCalendar_cPlayerClassLabel = "Class:";
	GroupCalendar_cPlayerRaceLabel = "Race:";
	GroupCalendar_cPlayerStatusLabel = "Status:";
	GroupCalendar_cRankLabel = "Guild rank:";
	GroupCalendar_cGuildLabel = "Guild:";
	GroupCalendar_cSave = "Save";
	GroupCalendar_cLastWhisper = "Last whisper:";
	GroupCalendar_cReplyWhisper = "Whisper reply:";

	GroupCalendar_cUnknown = "Unknown";
	GroupCalendar_cAutoConfirmationTitle = "Automatic Confirmations";
	GroupCalendar_cEnableAutoConfirm = "Enable automatic confirmations";
	GroupCalendar_cMinLabel = "min";
	GroupCalendar_cMaxLabel = "max";

	GroupCalendar_cAddPlayerTitle = "Add...";
	GroupCalendar_cAutoConfirmButtonTitle = "Settings...";

	GroupCalendar_cClassLimitDescription = "Use the fields below to set minimum and maximum numbers for each class.  Classes which haven't met the minimum yet will be filled first, the extra spots will be filled in order of response until the maximums are reached.";

	GroupCalendar_cViewByDate = "View by Date";
	GroupCalendar_cViewByRank = "View by Rank";
	GroupCalendar_cViewByName = "View by Name";
	GroupCalendar_cViewByStatus = "View by Status";
	GroupCalendar_cViewByClassRank = "View by Class and Rank";

	GroupCalendar_cMaxPartySizeLabel = "Maximum party size:";
	GroupCalendar_cMinPartySizeLabel = "Minimum party size:";
	GroupCalendar_cNoMinimum = "No minimum";
	GroupCalendar_cNoMaximum = "No maximum";
	GroupCalendar_cPartySizeFormat = "%d players";

	GroupCalendar_cInviteButtonTitle = "Invite Selected";
	GroupCalendar_cAutoSelectButtonTitle = "Select Players...";
	GroupCalendar_cAutoSelectWindowTitle = "Select Players";

	GroupCalendar_cNoSelection = "No players selected";
	GroupCalendar_cSingleSelection = "1 player selected";
	GroupCalendar_cMultiSelection = "%d players selected";

	GroupCalendar_cInviteNeedSelectionStatus = "Select players to be invited";
	GroupCalendar_cInviteReadyStatus = "Ready to invite";
	GroupCalendar_cInviteInitialInvitesStatus = "Sending initial invitations";
	GroupCalendar_cInviteAwaitingAcceptanceStatus = "Waiting for initial acceptance";
	GroupCalendar_cInviteConvertingToRaidStatus = "Converting to raid";
	GroupCalendar_cInviteInvitingStatus = "Sending invitations";
	GroupCalendar_cInviteCompleteStatus = "Invitations completed";
	GroupCalendar_cInviteReadyToRefillStatus = "Ready to fill vacant slots";
	GroupCalendar_cInviteNoMoreAvailableStatus = "No more players available to fill the group";
	GroupCalendar_cRaidFull = "Raid full";

	GroupCalendar_cInviteWhisperFormat = "[GroupCalendar] You are being invited to the event '%s'.  Please accept the invitation if you wish to join this event.";
	GroupCalendar_cAlreadyGroupedWhisper = "[GroupCalendar] You are already in a group.  Please /w back when you leave your group.";
	GroupCalendar_cAlreadyGroupedSysMsg = "(.+) is already in a group";
	GroupCalendar_cInviteDeclinedSysMsg = "(.+) declines your group invitation.";
	GroupCalendar_cNoSuchPlayerSysMsg = "No player named '(.+)' is currently playing.";

	GroupCalendar_cJoinedGroupStatus = "Joined";
	GropuCalendar_cInvitedGroupStatus = "Invited";
	GropuCalendar_cReadyGroupStatus = "Ready";
	GroupCalendar_cGroupedGroupStatus = "In another group";
	GroupCalendar_cStandbyGroupStatus = "Standby";
	GroupCalendar_cDeclinedGroupStatus = "Declined invitation";
	GroupCalendar_cOfflineGroupStatus = "Offline";
	GroupCalendar_cLeftGroupStatus = "Left group";

	GroupCalendar_cPriorityLabel = "Priority:";
	GroupCalendar_cPriorityDate = "Date";
	GroupCalendar_cPriorityRank = "Rank";

	GroupCalendar_cConfrimDeleteRSVP = "Remove %s from this event? They can't join again unless you add them back manually.";

	GroupCalendar_cConfirmSelfUpdateMsg = "%s";
	GroupCalendar_cConfirmSelfUpdateParamFormat = "A newer copy of the events for $mUserName is available from $mSender.  Do you want to update your events to the newer version? If you update then any events you've added or changed since logging in will be lost.";
	GroupCalendar_cConfirmSelfRSVPUpdateParamFormat = "A newer copy of the attendance requests for %mUserName is available from $mSender.  Do you wnat to update your attendance requests to the newer version?  If you update then any unconfirmed attendance changes you've made since logging in will be lost.";
	GroupCalendar_cUpdate = "Update";

	GroupCalendar_cConfirmClearWhispers = "Clear all recent whispers?";
	GroupCalendar_cClear = "Clear";
	
	CalendarDatabases_cTitle = "Group Calendar Versions";
	CalendarDatabases_cRefresh = "Refresh";
	CalendarDatabases_cRefreshDescription = "Requests online players to send their version numbers.  It may take several minutes for version numbers to update.  Updates received while self window is closed will still be recorded and can be viewed at a later time.";

	GroupCalendar_cVersionFormat = "Group Calendar v%s";
	GroupCalendar_cShortVersionFormat = "v%s";
	GroupCalendar_cVersionUpdatedFormat = "as of %s %s (local time)";
	GroupCalendar_cVersionUpdatedUnknown = "Date version info was last seen is unknown";

	GroupCalendar_cToggleVersionsTitle = "Show Player Versions";
	GroupCalendar_cToggleVersionsDescription = "Shows what version of Group Calendar other players are running";

	GroupCalendar_cChangesDelayedMessage = "Group Calendar: Changes made while synchronizing with the network will not be sent until synchronization is completed.";

	GroupCalendar_cConfirmKillMsg = "Are you sure you want to force the events from %s out of the network?"; 
	GroupCalendar_cKill = "Kill";

	GroupCalendar_cNotAnOfficerError = "GroupCalendar: Only guild officers are not allowed to do that";
	GroupCalendar_cUserNameExpected = "GroupCalendar: Expected user name";
	GroupCalendar_cDatabaseNotFoundError = "GroupCalendar: Database for %s not found.";
	GroupCalendar_cCantKillGuildieError = "GroupCalendar: Can't purge a user who's in your guild";
end
