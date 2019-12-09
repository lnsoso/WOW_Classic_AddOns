local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "frFR")
if not L then return end


-- Addon information
L["Spy"] = "Spy"
L["Version"] = "Version"
L["VersionCheck"] = "|cffc41e3aAttention! La mauvaise version de Spy est installée. Supprimez cette version et installez Spy Classic."
L["SpyEnabled"] = "|cff9933ffSpy addon enabled."
L["SpyDisabled"] = "|cff9933ffSpy addon disabled. Type |cffffffff/spy enable|cff9933ff to enable."
L["UpgradeAvailable"] = "|cff9933ffA new version of Spy is available. It can be downloaded from:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-classic"

-- Configuration frame name
L["Spy Option"] = "Spy"

-- Configuration strings
L["Profiles"] = "Profiles"

L["GeneralSettings"] = "General Settings"
L["SpyDescription1"] = [[
Spy is an addon that will alert you to the presence of nearby enemy players.
]]
L["SpyDescription2"] = [[

|cffffd000Nearby list|cffffffff
Displays enemy players that have been detected nearby. Players are removed from the list if they have not been detected after a period of time.

|cffffd000Last Hour list|cffffffff
Displays all enemies that have been detected in the last hour.

|cffffd000Ignore list|cffffffff
Players that are added to the Ignore list will not be reported by Spy. You can add and remove players to/from this list by using the button's drop down menu or by holding the Control key while clicking the button.

|cffffd000Kill On Sight list|cffffffff
Players on your Kill On Sight list cause an alarm to sound when detected. You can add and remove players to/from this list by using the button's drop down menu or by holding the Shift key while clicking the button.

The drop down menu can also be used to set the reasons why you have added someone to the Kill On Sight list. If you want to enter a specific reason that is not in the list, then use the "Enter your own reason..." in the Other list.

|cffffd000Author: Slipjack|cffffffff
]]

L["EnableSpy"] = "Enable Spy"
L["EnableSpyDescription"] = "Enables or disables Spy."
L["EnabledInBattlegrounds"] = "Enable Spy in battlegrounds"
L["EnabledInBattlegroundsDescription"] = "Enables or disables Spy when you are in a battleground."
L["EnabledInArenas"] = "Enable Spy in arenas"
L["EnabledInArenasDescription"] = "Enables or disables Spy when you are in an arena."
L["EnabledInWintergrasp"] = "Enable Spy in world combat zones"
L["EnabledInWintergraspDescription"] = "Enables or disables Spy when you are in world combat zones such as Lake Wintergrasp in Northrend."
L["DisableWhenPVPUnflagged"] = "Disable Spy when not flagged for PVP"
L["DisableWhenPVPUnflaggedDescription"] = "Enables or disables Spy depending on your PVP status."

L["DisplayOptions"] = "Display"
L["DisplayOptionsDescription"] = [[
Options for the Spy window and tooltips.
]]
L["ShowOnDetection"] = "Show Spy when enemy players are detected"
L["ShowOnDetectionDescription"] = "Set this to display the Spy window and the Nearby list if Spy is hidden when enemy players are detected."
L["HideSpy"] = "Hide Spy when no enemy players are detected"
L["HideSpyDescription"] = "Set this to hide Spy when the Nearby list is displayed and it becomes empty. Spy will not be hidden if you clear the list manually."
L["ShowOnlyPvPFlagged"] = "Show only enemy players flagged for PvP"
L["ShowOnlyPvPFlaggedDescription"] = "Set this to show only enemy players that are flagged for PvP in the Nearby list."
L["ShowKoSButton"] = "Show KOS button on the enemy target frame"
L["ShowKoSButtonDescription"] = "Set this to show the KOS button on the enemy player's target frame."
L["LockSpy"] = "Lock the Spy window"
L["LockSpyDescription"] = "Locks the Spy window in place so it doesn't move."
L["InvertSpy"] = "Invert the Spy window"
L["InvertSpyDescription"] = "Flips the Spy window upside down."
L["Reload"] = "Reload UI"
L["ReloadDescription"] = "Required when changing the Spy window."
L["ResizeSpy"] = "Resize the Spy window automatically"
L["ResizeSpyDescription"] = "Set this to automatically resize the Spy window as enemy players are added and removed."
L["ResizeSpyLimit"] = "List Limit"
L["ResizeSpyLimitDescription"] = "Limit the number of enemy players shown in the Spy window."
L["DisplayTooltipNearSpyWindow"] = "Display tooltip near the Spy window"
L["DisplayTooltipNearSpyWindowDescription"] = "Set this to display tooltips near the Spy window."
L["SelectTooltipAnchor"] = "Tooltip Anchor Point"
L["SelectTooltipAnchorDescription"] = "Select the anchor point for the tooltip if the option above has been checked"
L["ANCHOR_CURSOR"] = "Cursor"
L["ANCHOR_TOP"] = "Top"
L["ANCHOR_BOTTOM"] = "Bottom"
L["ANCHOR_LEFT"] = "Left"			
L["ANCHOR_RIGHT"] = "Right"
L["TooltipDisplayWinLoss"] = "Display win/loss statistics in tooltip"
L["TooltipDisplayWinLossDescription"] = "Set this to display the win/loss statistics of a player in the player's tooltip."
L["TooltipDisplayKOSReason"] = "Display Kill On Sight reasons in tooltip"
L["TooltipDisplayKOSReasonDescription"] = "Set this to display the Kill On Sight reasons of a player in the player's tooltip."
L["TooltipDisplayLastSeen"] = "Display last seen details in tooltip"
L["TooltipDisplayLastSeenDescription"] = "Set this to display the last known time and location of a player in the player's tooltip."
L["SelectFont"] = "Select a Font"
L["SelectFontDescription"] = "Select a Font for the Spy Window."
L["RowHeight"] = "Select the Row Height"
L["RowHeightDescription"] = "Select the Row Height for the Spy window."
L["Texture"] = "Texture"
L["TextureDescription"] = "Select a texture for the Spy Window"
					
L["AlertOptions"] = "Alerts"
L["AlertOptionsDescription"] = [[
Options for alerts, announcements and warnings when enemy players are detected.
]]
L["SoundChannel"] = "Select Sound Channel"
L["Master"] = "Master"
L["SFX"] = "Sound Effects"
L["Music"] = "Music"
L["Ambience"] = "Ambience"
L["Announce"] = "Send announcements to:"
L["None"] = "None"
L["NoneDescription"] = "Do not announce when enemy players are detected."
L["Self"] = "Self"
L["SelfDescription"] = "Announce to yourself when enemy players are detected."
L["Party"] = "Party"
L["PartyDescription"] = "Announce to your party when enemy players are detected."
L["Guild"] = "Guild"
L["GuildDescription"] = "Announce to your guild when enemy players are detected."
L["Raid"] = "Raid"
L["RaidDescription"] = "Announce to your raid when enemy players are detected."
L["LocalDefense"] = "Local Defense"
L["LocalDefenseDescription"] = "Announce to the Local Defense channel when enemy players are detected."
L["OnlyAnnounceKoS"] = "Only announce enemy players that are Kill On Sight"
L["OnlyAnnounceKoSDescription"] = "Set this to only announce enemy players that are on your Kill On Sight list."
L["WarnOnStealth"] = "Warn upon stealth detection"
L["WarnOnStealthDescription"] = "Set this to display a warning and sound an alert when an enemy player gains stealth."
L["WarnOnKOS"] = "Warn upon Kill On Sight detection"
L["WarnOnKOSDescription"] = "Set this to display a warning and sound an alert when an enemy player on your Kill On Sight list is detected."
L["WarnOnKOSGuild"] = "Warn upon Kill On Sight guild detection"
L["WarnOnKOSGuildDescription"] = "Set this to display a warning and sound an alert when an enemy player in the same guild as someone on your Kill On Sight list is detected."
L["WarnOnRace"] = "Warn upon Race detection"
L["WarnOnRaceDescription"] = "Set this to sound an alert when the selected Race is detected."
L["SelectWarnRace"] = "Select Race for detection"
L["SelectWarnRaceDescription"] = "Select a Race for audio alert."
L["WarnRaceNote"] = "Note: You must target an enemy at least once so their Race can be added to the database. Upon the next detection an alert will sound. This does not work the same as detecting nearby enemies in combat."
L["DisplayWarningsInErrorsFrame"] = "Display warnings in the errors frame"
L["DisplayWarningsInErrorsFrameDescription"] = "Set this to use the errors frame to display warnings instead of using the graphical popup frames."
L["EnableSound"] = "Enable audio alerts"
L["EnableSoundDescription"] = "Set this to enable audio alerts when enemy players are detected. Different alerts sound if an enemy player gains stealth or if an enemy player is on your Kill On Sight list."
L["OnlySoundKoS"] = "Only sound audio alerts for Kill on Sight detection"
L["OnlySoundKoSDescription"] = "Set this to only play audio alerts when enemy players on the Kill on Sight list are detected."
L["StopAlertsOnTaxi"] = "Turn off alerts while on a flight path"
L["StopAlertsOnTaxiDescription"] = "Stop all new alerts and warnings while on a flight path."

L["ListOptions"] = "Nearby List"
L["ListOptionsDescription"] = [[
Options on how enemy players are added and removed.
]]
L["RemoveUndetected"] = "Remove enemy players from the Nearby list after:"
L["1Min"] = "1 minute"
L["1MinDescription"] = "Remove an enemy player who has been undetected for over 1 minute."
L["2Min"] = "2 minutes"
L["2MinDescription"] = "Remove an enemy player who has been undetected for over 2 minutes."
L["5Min"] = "5 minutes"
L["5MinDescription"] = "Remove an enemy player who has been undetected for over 5 minutes."
L["10Min"] = "10 minutes"
L["10MinDescription"] = "Remove an enemy player who has been undetected for over 10 minutes."
L["15Min"] = "15 minutes"
L["15MinDescription"] = "Remove an enemy player who has been undetected for over 15 minutes."
L["Never"] = "Never remove"
L["NeverDescription"] = "Never remove enemy players. The Nearby list can still be cleared manually."
L["ShowNearbyList"] = "Switch to the Nearby list upon enemy player detection"
L["ShowNearbyListDescription"] = "Set this to display the Nearby list if it is not already visible when enemy players are detected."
L["PrioritiseKoS"] = "Prioritise Kill On Sight enemy players in the Nearby list"
L["PrioritiseKoSDescription"] = "Set this to always show Kill On Sight enemy players first in the Nearby list."

L["MapOptions"] = "Map"
L["MapOptionsDescription"] = [[
Options for world map and minimap including icons and tooltips.
]]
L["MinimapDetection"] = "Enable minimap detection"
L["MinimapDetectionDescription"] = "Rolling the cursor over known enemy players detected on the minimap will add them to the Nearby list."
L["MinimapNote"] = "          Note: Only works for players that can Track Humanoids."
L["MinimapDetails"] = "Display level/class details in tooltips"
L["MinimapDetailsDescription"] = "Set this to update the map tooltips so that level/class details are displayed alongside enemy names."
L["DisplayOnMap"] = "Display icons on the map"
L["DisplayOnMapDescription"] = "Display map icons for the location of other Spy users in your party, raid and guild when they detect enemies."
L["SwitchToZone"] = "Switch to current zone map on enemy detection"
L["SwitchToZoneDescription"] = "Change the map to the players current zone map when enemies are detected."
L["MapDisplayLimit"] = "Limit displayed map icons to:"
L["LimitNone"] = "Everywhere"
L["LimitNoneDescription"] = "Displays all detected enemies on the map regardless of your current location."
L["LimitSameZone"] = "Same zone"
L["LimitSameZoneDescription"] = "Only displays detected enemies on the map if you are in the same zone."
L["LimitSameContinent"] = "Same continent"
L["LimitSameContinentDescription"] = "Only displays detected enemies on the map if you are on the same continent."

L["DataOptions"] = "Data Management"
L["DataOptionsDescription"] = [[
Options on how Spy maintains and gathers data.
]]
L["PurgeData"] = "Purge undetected enemy player data after:"
L["OneDay"] = "1 day"
L["OneDayDescription"] = "Purge data for enemy players that have been undetected for 1 day."
L["FiveDays"] = "5 days"
L["FiveDaysDescription"] = "Purge data for enemy players that have been undetected for 5 days."
L["TenDays"] = "10 days"
L["TenDaysDescription"] = "Purge data for enemy players that have been undetected for 10 days."
L["ThirtyDays"] = "30 days"
L["ThirtyDaysDescription"] = "Purge data for enemy players that have been undetected for 30 days."
L["SixtyDays"] = "60 days"
L["SixtyDaysDescription"] = "Purge data for enemy players that have been undetected for 60 days."
L["NinetyDays"] = "90 days"
L["NinetyDaysDescription"] = "Purge data for enemy players that have been undetected for 90 days."
L["PurgeKoS"] = "Purge Kill on Sight players based on undetected time."
L["PurgeKoSDescription"] = "Set this to purge Kill on Sight players that have been undetected based on the time settings for undetected players."
L["PurgeWinLossData"] = "Purge win/loss data based on undetected time."
L["PurgeWinLossDataDescription"] = "Set this to purge win/loss data of your enemy encounters based on the time settings for undetected players."
L["ShareData"] = "Share data with other Spy addon users"
L["ShareDataDescription"] = "Set this to share the details of your enemy player encounters with other Spy users in your party, raid and guild."
L["UseData"] = "Use data from other Spy addon users"
L["UseDataDescription"] = "Set this to use the data collected by other Spy users in your party, raid and guild."
L["ShareKOSBetweenCharacters"] = "Share Kill On Sight players between your characters"
L["ShareKOSBetweenCharactersDescription"] = "Set this to share the players you mark as Kill On Sight between other characters that you play on the same server and faction."

L["SlashCommand"] = "Slash Command"
L["SpySlashDescription"] = "These buttons execute the same functions as the ones in the slash command /spy"
L["Enable"] = "Enable"
L["EnableDescription"] = "Enables Spy and shows the main window."
L["Show"] = "Show"
L["ShowDescription"] = "Shows the main window."
L["Reset"] = "Reset"
L["ResetDescription"] = "Resets the position and appearance of the main window."
L["ClearSlash"] = "Clear"
L["ClearSlashDescription"] = "Clears the list of players that have been detected."
L["Config"] = "Config"
L["ConfigDescription"] = "Open the Interface Addons configuration window for Spy."
L["KOS"] = "KOS"
L["KOSDescription"] = "Add/remove a player to/from the Kill On Sight list."
L["InvalidInput"] = "Invalid Input"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Add/remove a player to/from the Ignore list."

-- Lists
L["Nearby"] = "Nearby"
L["LastHour"] = "Last Hour"
L["Ignore"] = "Ignore"
L["KillOnSight"] = "Kill On Sight"

--Stats
L["Time"] = "Time"	
L["List"] = "List"
L["Filter"] = "Filter"
L["Show Only"] = "Show Only"
L["KOS"] = "KOS"
L["Won/Lost"] = "Won/Lost"
L["Reason"] = "Reason"	 
L["HonorKills"] = "Honor Kills"
L["PvPDeaths"] = "PvP Deaths"

-- Output messages
L["AlertStealthTitle"] = "Stealth player detected!"
L["AlertKOSTitle"] = "Kill On Sight player detected!"
L["AlertKOSGuildTitle"] = "Kill On Sight player guild detected!"
L["AlertTitle_kosaway"] = "Kill On Sight player located by "
L["AlertTitle_kosguildaway"] = "Kill On Sight player guild located by "
L["StealthWarning"] = "|cff9933ffStealth player detected: |cffffffff"
L["KOSWarning"] = "|cffff0000Kill On Sight player detected: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Kill On Sight player guild detected: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Player detected: |cffffffff"
L["PlayersDetectedColored"] = "Players detected: |cffffffff"
L["KillOnSightDetectedColored"] = "Kill On Sight player detected: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Added player to Ignore list: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Removed player from Ignore list: |cffffffff"
L["PlayerAddedToKOSColored"] = "Added player to Kill On Sight list: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Removed player from Kill On Sight list: |cffffffff"
L["PlayerDetected"] = "[Spy] Player detected: "
L["KillOnSightDetected"] = "[Spy] Kill On Sight player detected: "
L["Level"] = "Level"
L["LastSeen"] = "Last seen"
L["LessThanOneMinuteAgo"] = "less than a minute ago"
L["MinutesAgo"] = "minutes ago"
L["HoursAgo"] = "hours ago"
L["DaysAgo"] = "days ago"
L["Close"] = "Close"
L["CloseDescription"] = "|cffffffffHides the Spy window. By default will show again when the next enemy player is detected."
L["Left/Right"] = "Left/Right"
L["Left/RightDescription"] = "|cffffffffNavigates between the Nearby, Last Hour, Ignore and Kill On Sight lists."
L["Clear"] = "Clear"
L["ClearDescription"] = "|cffffffffClears the list of players that have been detected. CTRL-Click will turn Spy On/Off. Shift-Click will turn all sound On/Off."
L["SoundEnabled"] = "Audio alerts enabled"
L["SoundDisabled"] = "Audio alerts disabled"
L["NearbyCount"] = "Nearby Count"
L["NearbyCountDescription"] = "|cffffffffCount of nearby players."
L["Statistics"] = "Statistics"
L["StatsDescription"] = "|cffffffffShows a list of enemy players encountered, win/loss records and where they were last seen."
L["AddToIgnoreList"] = "Add to Ignore list"
L["AddToKOSList"] = "Add to Kill On Sight list"
L["RemoveFromIgnoreList"] = "Remove from Ignore list"
L["RemoveFromKOSList"] = "Remove from Kill On Sight list"
L["RemoveFromStatsList"] = "Remove from Statistics List"   
L["AnnounceDropDownMenu"] = "Announce"
L["KOSReasonDropDownMenu"] = "Set Kill On Sight reason"
L["PartyDropDownMenu"] = "Party"
L["RaidDropDownMenu"] = "Raid"
L["GuildDropDownMenu"] = "Guild"
L["LocalDefenseDropDownMenu"] = "Local Defense"
L["Player"] = " (Player)"
L["KOSReason"] = "Kill On Sight"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Enter your own reason..."
L["KOSReasonClear"] = "Clear Reason"
L["StatsWins"] = "|cff40ff00Wins: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddLosses: "
L["Located"] = "located:"
L["Yards"] = "yards"
L["LocalDefenseChannelName"] = "Défenselocale"

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Started combat";
		["content"] = {
			"Attacked me for no reason",
			"Attacked me at a quest giver", 
			"Attacked me while I was fighting NPCs",
			"Attacked me while I was near an instance",
			"Attacked me while I was AFK",
			"Attacked me while I was mounted/flying",
			"Attacked me while I had low health/mana",
		};
	},
	[2] = {
		["title"] = "Style of combat";
		["content"] = {
			"Ambushed me",
			"Always attacks me on sight",
			"Killed me with a higher level character",
			"Steamrolled me with a group of enemies",
			"Doesn't attack without backup",
			"Always calls for help",
			"Uses too much crowd control",
		};
	},
	[3] = {
		["title"] = "Camping";
		["content"] = {
			"Camped me",
			"Camped an alt",
			"Camped lowbies",
			"Camped from stealth",
			"Camped guild members",
			"Camped game NPCs/objectives",
			"Camped a city/site",
		};
	},
	[4] = {
		["title"] = "Questing";
		["content"] = {
			"Attacked me while I was questing",
			"Attacked me after I helped with a quest",
			"Interfered with a quest objective",
			"Started a quest I wanted to do",
			"Killed my faction's NPCs",
			"Killed a quest NPC",
		};
	},
	[5] = {
		["title"] = "Stole resources";
		["content"] = {
			"Gathered herbs I wanted",
			"Gathered minerals I wanted",
			"Gathered resources I wanted",
			"Killed me and stole my target/rare NPC",
			"Skinned my kills",
			"Salvaged my kills",
			"Fished in my pool",
		};
	},
	[6] = {
		["title"] = "Other";
		["content"] = {
			"Flagged for PvP",
			"Pushed me off a cliff",
			"Uses engineering tricks",
			"Always manages to escape",
			"Uses items and skills to escape",
			"Exploits game mechanics",
			"Enter your own reason...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Enter the Kill On Sight reason for %s:",
	button1 = "Set",
	button2 = "Cancel",
	timeout = 120,
	hasEditBox = 1,
	editBoxWidth = 260,	
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
    	OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Enter your own reason...", reason)
	end,
};

--++ Class descriptions
--L["DEATHKNIGHt"] =" Chevalier de la mort "
--L["DEMONHUNTER"] = "Chasseur de démons"
L["DRUID"] = "Druide"
L["HUNTER"] = "Chasseur"
L["MAGE"] = "Mage"
--L["MONK"] = "Moine"
L["PALADIN"] = "Paladin"
L["PRIEST"] = "Prêtre"
L["ROGUE"] = "Voleur"
L["SHAMAN"] = "Chaman"
L["WARLOCK"] = "Démoniste"
L["WARRIOR"] = "Guerrier"
L["UNKNOWN"] = "Inconnu"

--++ Race descriptions
L["HUMAN"] = "Humain"
L["ORC"] = "Orc"
L["DWARF"] = "Nain"
L["NIGHT ELF"] = "Elfe de la nuit"
L["UNDEAD"] = "Mort-vivant"
L["TAUREN"] = "Tauren"
L["GNOME"] = "Gnome"
L["TROLL"] = "Troll"
L["GOBLIN"] = "Gobelin"
--L["BLOOD ELF"] = "Elfe de sang"
--L["DRAENEI"] = "Draeneï"
--L["WORGEN"] = "Worgen"
--L["PANDAREN"] = "Pandaren"
--L["NIGHTBORNE"] = "Sacrenuit"
--L["HIGHMOUNTAIN TAUREN"] = "Tauren de Haut-Roc"
--L["VOID ELF"] = "Elfe du Vide"
--L["LIGHTFORGED DRAENEI"] = "Draeneï sancteforge"
--L["ZANDALARI TROLL"] = "Troll zandalari"
--L["KUL TIRAN"] = "Kultirassien"
--L["DARK IRON DWARF"] = "Nain sombrefer"
--L["MAG'HAR ORC"] = "Orc mag’har"
 
--Capacités stealth
L["Stealth"] = "Camouflage"
L["Prowl"] = "Rôder"
 
--++ Minimap color codes
--L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
--L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
--L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapGuildText"] = "|cffffffff"

Spy_AbilityList = {
-----------------------------------------------------------
-- Allows an estimation of the race, class and level of a
-- player based on the abilities observed in the combat log.
-----------------------------------------------------------

--++ Racial Traits ++	
	["Camouflage dans l'ombre"]={ class = "Night Elf", level = 1, },
	["Fureur sanguinaire"]={ class = "Orc", level = 1, },
	["Volonté des Réprouvés"]={ class = "Undead", level = 1, },
	["Forme de pierre"]={ class = "Dwarf", level = 1, },
	["Berserker"]={ class = "Troll", level = 1, },
	["Solidité"]={ class = "Orc", level = 1, },
	["Spécialisation Epée"]={ class = "Human", level = 1, },
	["Maître de l'évasion"]={ class = "Gnome", level = 1, },
	["L'esprit humain"]={ class = "Human", level = 1, },
	["Régénération"]={ class = "Troll", level = 1, },
	["Perception"]={ class = "Human", level = 1, },
	["Endurance"]={ class = "Tauren", level = 1, },
	["Spécialisation Arc"]={ class = "Troll", level = 1, },
	["Culture"]={ class = "Tauren", level = 1, },
	["Spécialisation (Ingénierie)"]={ class = "Gnome", level = 1, },
	["Choc martial"]={ class = "Tauren", level = 1, },
	["Tueur de bêtes"]={ class = "Troll", level = 1, },
	["Découverte de trésors"]={ class = "Dwarf", level = 1, },
	["Spécialisation Hache"]={ class = "Orc", level = 1, },
	["Cannibalisme"]={ class = "Undead", level = 1, },
	["Diplomatie"]={ class = "Human", level = 1, },
	["Rapidité"]={ class = "Night Elf", level = 1, },
	["Spécialisation Armes de jet"]={ class = "Troll", level = 1, },
	["Spécialisation Masse"]={ class = "Human", level = 1, },
	["Spécialisation Armes à feu"]={ class = "Dwarf", level = 1, },
	["Respiration aquatique"]={ class = "Undead", level = 1, },
	["Commandement"]={ class = "Orc", level = 1, },
	["Résistance à la Nature"]={ class = "Night Elf", level = 1, },
	["Résistance au Givre"]={ class = "Dwarf", level = 1, },
	["Résistance à l'Ombre"]={ class = "Undead", level = 1, },
	["Résistance aux Arcanes"]={ class = "Gnome", level = 1, },
	["Esprit feu follet"]={ class = "Night Elf", level = 1, },
	
--++ Druid Abilities ++	
	["Toucher guérisseur"]={ class = "DRUID", level = 1, },
	["Colère"]={ class = "DRUID", level = 1, },
	["Eclat lunaire"]={ class = "DRUID", level = 4, },
	["Sarments"]={ class = "DRUID", level = 8, },
	["Forme d’ours"]={ class = "DRUID", level = 10, },
	["Rugissement démoralisant"]={ class = "DRUID", level = 10, },
	["Grondement"]={ class = "DRUID", level = 10, },
	["Mutiler"]={ class = "DRUID", level = 10, },
	["Téléportation : Reflet-de-Lune"]={ class = "DRUID", level = 10, },
	["Enrager"]={ class = "DRUID", level = 12, },
	["Rétablissement"]={ class = "DRUID", level = 12, },
	["Sonner"]={ class = "DRUID", level = 14, },
	["Forme aquatique"]={ class = "DRUID", level = 16, },
	["Balayage"]={ class = "DRUID", level = 16, },
	["Lucioles"]={ class = "DRUID", level = 18, },
	["Hibernation"]={ class = "DRUID", level = 18, },
	["Forme de félin"]={ class = "DRUID", level = 20, },
	["Griffe"]={ class = "DRUID", level = 20, },
	["Rôder"]={ class = "DRUID", level = 20, },
	["Renaissance"]={ class = "DRUID", level = 20, },
	["Déchirure"]={ class = "DRUID", level = 20, },
	["Feu stellaire"]={ class = "DRUID", level = 20, },
	["Lambeau"]={ class = "DRUID", level = 22, },
	["Apaiser les animaux"]={ class = "DRUID", level = 22, },
	["Griffure"]={ class = "DRUID", level = 24, },
	["Délivrance de la malédiction"]={ class = "DRUID", level = 24, },
	["Fureur du tigre"]={ class = "DRUID", level = 24, },
	["Abolir le poison"]={ class = "DRUID", level = 26, },
	["Célérité"]={ class = "DRUID", level = 26, },
	["Rugissement provocateur"]={ class = "DRUID", level = 28, },
	["Dérobade"]={ class = "DRUID", level = 28, },
	["Forme de voyage"]={ class = "DRUID", level = 30, },
	["Morsure féroce"]={ class = "DRUID", level = 32, },
	["Ravage"]={ class = "DRUID", level = 32, },
	["Régénération frénétique"]={ class = "DRUID", level = 36, },
	["Traquenard"]={ class = "DRUID", level = 36, },
	["Forme d’ours redoutable"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["Emprise de la nature"]={ class = "DRUID", level = 10, },
	["Charge farouche"]={ class = "DRUID", level = 20, },
	["Essaim d'insectes"]={ class = "DRUID", level = 20, },
	["Augure de clarté"]={ class = "DRUID", level = 20, },
	["Lucioles (farouche)"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["Promptitude"]={ class = "HUNTER", level = 1, },
	["Tir automatique"]={ class = "HUNTER", level = 1, },
	["Attaque du raptor"]={ class = "HUNTER", level = 1, },
	["Pistage des bêtes"]={ class = "HUNTER", level = 1, },
	["Aspect du singe"]={ class = "HUNTER", level = 4, },
	["Morsure de serpent"]={ class = "HUNTER", level = 4, },
	["Tir des arcanes"]={ class = "HUNTER", level = 6, },
	["Marque du chasseur"]={ class = "HUNTER", level = 6, },
	["Trait de choc"]={ class = "HUNTER", level = 8, },
	["Aspect du faucon"]={ class = "HUNTER", level = 10, },
	["Appel du familier"]={ class = "HUNTER", level = 10, },
	["Renvoyer le familier"]={ class = "HUNTER", level = 10, },
	["Nourrir le familier"]={ class = "HUNTER", level = 10, },
	["Ressusciter le familier"]={ class = "HUNTER", level = 10, },
	["Apprivoise une bête"]={ class = "HUNTER", level = 10, },
	["Trait provocateur"]={ class = "HUNTER", level = 12, },
	["Guérison du familier"]={ class = "HUNTER", level = 12, },
	["Coupure d'ailes"]={ class = "HUNTER", level = 12, },
	["Oeil d'aigle"]={ class = "HUNTER", level = 14, },
	["Oeil de la bête"]={ class = "HUNTER", level = 14, },
	["Effrayer une bête"]={ class = "HUNTER", level = 14, },
	["Piège d'Immolation"]={ class = "HUNTER", level = 16, },
	["Morsure de la mangouste"]={ class = "HUNTER", level = 16, },
	["Flèches multiples"]={ class = "HUNTER", level = 18, },
	["Pistage des morts-vivants"]={ class = "HUNTER", level = 18, },
	["Aspect du guépard"]={ class = "HUNTER", level = 20, },
	["Désengagement"]={ class = "HUNTER", level = 20, },
	["Piège givrant"]={ class = "HUNTER", level = 20, },
	["Piqûre de scorpide"]={ class = "HUNTER", level = 22, },
	["Connaissance des bêtes"]={ class = "HUNTER", level = 24, },
	["Pistage des camouflés"]={ class = "HUNTER", level = 24, },
	["Tir rapide"]={ class = "HUNTER", level = 26, },
	["Pistage des élémentaires"]={ class = "HUNTER", level = 26, },
	["Piège de givre"]={ class = "HUNTER", level = 28, },
	["Aspect de la bête"]={ class = "HUNTER", level = 30, },
	["Feindre la mort"]={ class = "HUNTER", level = 30, },
	["Fusée éclairante"]={ class = "HUNTER", level = 32, },
	["Pistage des démons"]={ class = "HUNTER", level = 32, },
	["Piège explosif"]={ class = "HUNTER", level = 34, },
	["Morsure de vipère"]={ class = "HUNTER", level = 36, },
	["Aspect de la meute"]={ class = "HUNTER", level = 40, },
	["Pistage des géants"]={ class = "HUNTER", level = 40, },
	["Salve"]={ class = "HUNTER", level = 40, },
	["Aspect de la nature"]={ class = "HUNTER", level = 46, },
	["Pistage des draconiens"]={ class = "HUNTER", level = 50, },
	["Tir tranquillisant"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["Visée"]={ class = "HUNTER", level = 20, },
	["Dissuasion"]={ class = "HUNTER", level = 20, },
	["Contre-attaque"]={ class = "HUNTER", level = 30, },
	["Intimidation"]={ class = "HUNTER", level = 30, },
	["Flèche de dispersion"]={ class = "HUNTER", level = 30, },
	["Courroux bestial"]={ class = "HUNTER", level = 40, },
	["Piqûre de wyverne"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["Boule de feu"]={ class = "MAGE", level = 1, },
	["Armure de givre"]={ class = "MAGE", level = 1, },
	["Eclair de givre"]={ class = "MAGE", level = 4, },
	["Invocation d'eau"]={ class = "MAGE", level = 4, },
	["Trait de feu"]={ class = "MAGE", level = 6, },
	["Invocation de nourriture"]={ class = "MAGE", level = 6, },
	["Projectiles des arcanes"]={ class = "MAGE", level = 8, },
	["Métamorphose"]={ class = "MAGE", level = 8, },
	["Nova de givre"]={ class = "MAGE", level = 10, },
	["Explosion des arcanes"]={ class = "MAGE", level = 14, },
	["Détection de la magie"]={ class = "MAGE", level = 16, },
	["Choc de flammes"]={ class = "MAGE", level = 16, },
	["Délivrance de la malédiction mineure"]={ class = "MAGE", level = 18, },
	["Transfert"]={ class = "MAGE", level = 20, },
	["Blizzard"]={ class = "MAGE", level = 20, },
	["Evocation"]={ class = "MAGE", level = 20, },
	["Gardien de feu"]={ class = "MAGE", level = 20, },
	["Bouclier de mana"]={ class = "MAGE", level = 20, },
	["Téléportation : Ironforge"]={ class = "MAGE", level = 20, },
	["Téléportation : Orgrimmar"]={ class = "MAGE", level = 20, },
	["Téléportation : Stormwind"]={ class = "MAGE", level = 20, },
	["Téléportation : Undercity"]={ class = "MAGE", level = 20, },
	["Gardien de givre"]={ class = "MAGE", level = 22, },
	["Brûlure"]={ class = "MAGE", level = 22, },
	["Contresort"]={ class = "MAGE", level = 24, },
	["Cône de froid"]={ class = "MAGE", level = 26, },
	["Invocation d'une agate de mana"]={ class = "MAGE", level = 28, },
	["Armure de glace"]={ class = "MAGE", level = 30, },
	["Téléportation : Darnassus"]={ class = "MAGE", level = 30, },
	["Téléportation : Thunder Bluff"]={ class = "MAGE", level = 30, },
	["Armure du mage"]={ class = "MAGE", level = 34, },
	["Invocation d'une jade de mana"]={ class = "MAGE", level = 38, },
	["Portail : Ironforge"]={ class = "MAGE", level = 40, },
	["Portail : Orgrimmar"]={ class = "MAGE", level = 40, },
	["Portail : Stormwind"]={ class = "MAGE", level = 40, },
	["Portail : Undercity"]={ class = "MAGE", level = 40, },
	["Invocation d'une citrine de mana"]={ class = "MAGE", level = 48, },
	["Portail : Darnassus"]={ class = "MAGE", level = 50, },
	["Portail : Thunder Bluff"]={ class = "MAGE", level = 50, },
	["Illumination des arcanes"]={ class = "MAGE", level = 56, },
	["Invocation d'un rubis de mana"]={ class = "MAGE", level = 58, },
	["Métamorphose : vache"]={ class = "MAGE", level = 60, },
	["Métamorphose"]={ class = "MAGE", level = 60, },
	["Métamorphose"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["Morsure de glace"]={ class = "MAGE", level = 20, },
	["Explosion pyrotechnique"]={ class = "MAGE", level = 20, },
	["Vague explosive"]={ class = "MAGE", level = 30, },
	["Bloc de glace"]={ class = "MAGE", level = 30, },
	["Présence spirituelle"]={ class = "MAGE", level = 30, },
	["Pouvoir des arcanes"]={ class = "MAGE", level = 40, },
	["Combustion"]={ class = "MAGE", level = 40, },
	["Barrière de glace"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["Lumière sacrée"]={ class = "PALADIN", level = 1, },
	["Sceau de piété"]={ class = "PALADIN", level = 1, },
	["Jugement"]={ class = "PALADIN", level = 4, },
	["Protection divine"]={ class = "PALADIN", level = 6, },
	["Sceau du Croisé"]={ class = "PALADIN", level = 6, },
	["Marteau de la justice"]={ class = "PALADIN", level = 8, },
	["Purification"]={ class = "PALADIN", level = 8, },
	["Imposition des mains"]={ class = "PALADIN", level = 10, },
	["Rédemption"]={ class = "PALADIN", level = 12, },
	["Fureur vertueuse"]={ class = "PALADIN", level = 16, },
	["Exorcisme"]={ class = "PALADIN", level = 20, },
	["Eclair lumineux"]={ class = "PALADIN", level = 20, },
	["Détection des morts-vivants"]={ class = "PALADIN", level = 20, },
	["Sceau de justice"]={ class = "PALADIN", level = 22, },
	["Renvoi des morts-vivants"]={ class = "PALADIN", level = 24, },
	["Bénédiction de salut"]={ class = "PALADIN", level = 26, },
	["Intervention divine"]={ class = "PALADIN", level = 30, },
	["Sceau de lumière"]={ class = "PALADIN", level = 30, },
	["Bouclier divin"]={ class = "PALADIN", level = 34, },
	["Sceau de sagesse"]={ class = "PALADIN", level = 38, },
	["Bénédiction de lumière"]={ class = "PALADIN", level = 40, },
	["Invocation d'un cheval de guerre"]={ class = "PALADIN", level = 40, },
	["Epuration"]={ class = "PALADIN", level = 42, },
	["Marteau de courroux"]={ class = "PALADIN", level = 44, },
	["Colère divine"]={ class = "PALADIN", level = 50, },
	["Invocation de destrier"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["Consécration"]={ class = "PALADIN", level = 20, },
	["Sceau d'autorité"]={ class = "PALADIN", level = 20, },
	["Faveur divine"]={ class = "PALADIN", level = 30, },
	["Bouclier sacré"]={ class = "PALADIN", level = 40, },
	["Horion sacré"]={ class = "PALADIN", level = 40, },
	["Repentir"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["Soins inférieurs"]={ class = "PRIEST", level = 1, },
	["Châtiment"]={ class = "PRIEST", level = 1, },
	["Mot de l'ombre : Douleur"]={ class = "PRIEST", level = 4, },
	["Oubli"]={ class = "PRIEST", level = 8, },
	["Prière du désespoir"]={ class = "PRIEST", level = 10, },
	["Maléfice de faiblesse"]={ class = "PRIEST", level = 10, },
	["Attaque mentale"]={ class = "PRIEST", level = 10, },
	["Résurrection"]={ class = "PRIEST", level = 10, },
	["Eclats stellaires"]={ class = "PRIEST", level = 10, },
	["Toucher de faiblesse"]={ class = "PRIEST", level = 10, },
	["Feu intérieur"]={ class = "PRIEST", level = 12, },
	["Cri psychique"]={ class = "PRIEST", level = 14, },
	["Soins"]={ class = "PRIEST", level = 16, },
	["Dissipation de la magie"]={ class = "PRIEST", level = 18, },
	["Peste dévorante"]={ class = "PRIEST", level = 20, },
	["Grâce d'Elune"]={ class = "PRIEST", level = 20, },
	["Réaction"]={ class = "PRIEST", level = 20, },
	["Soins rapides"]={ class = "PRIEST", level = 20, },
	["Flammes sacrées"]={ class = "PRIEST", level = 20, },
	["Apaisement"]={ class = "PRIEST", level = 20, },
	["Entraves des morts-vivants"]={ class = "PRIEST", level = 20, },
	["Garde de l'ombre"]={ class = "PRIEST", level = 20, },
	["Vision télépathique"]={ class = "PRIEST", level = 22, },
	["Brûlure de mana"]={ class = "PRIEST", level = 24, },
	["Contrôle mental"]={ class = "PRIEST", level = 30, },
	["Prière de soins"]={ class = "PRIEST", level = 30, },
	["Abolir maladie"]={ class = "PRIEST", level = 32, },
	["Lévitation"]={ class = "PRIEST", level = 34, },
	["Soins supérieurs"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["Nova sacrée"]={ class = "PRIEST", level = 20, },
	["Focalisation améliorée"]={ class = "PRIEST", level = 20, },
	["Fouet mental"]={ class = "PRIEST", level = 20, },
	["Silence"]={ class = "PRIEST", level = 30, },
	["Puits de lumière"]={ class = "PRIEST", level = 40, },
	["Forme d'Ombre"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["Eviscération"]={ class = "ROGUE", level = 1, },
	["Crochetage"]={ class = "ROGUE", level = 1, },
	["Attaque pernicieuse"]={ class = "ROGUE", level = 1, },
	["Camouflage"]={ class = "ROGUE", level = 1, },
	["Attaque sournoise"]={ class = "ROGUE", level = 4, },
	["Vol à la tire"]={ class = "ROGUE", level = 4, },
	["Suriner"]={ class = "ROGUE", level = 6, },
	["Evasion"]={ class = "ROGUE", level = 8, },
	["Assommer"]={ class = "ROGUE", level = 10, },
	["Débiter"]={ class = "ROGUE", level = 10, },
	["Sprint"]={ class = "ROGUE", level = 10, },
	["Coup de pied"]={ class = "ROGUE", level = 12, },
	["Exposer l'armure"]={ class = "ROGUE", level = 14, },
	["Garrot"]={ class = "ROGUE", level = 14, },
	["Feinte"]={ class = "ROGUE", level = 16, },
	["Embuscade"]={ class = "ROGUE", level = 18, },
	["Poisons"]={ class = "ROGUE", level = 20, },
	["Rupture"]={ class = "ROGUE", level = 20, },
	["Poison affaiblissant"]={ class = "ROGUE", level = 20, },
	["Poison instantané"]={ class = "ROGUE", level = 20, },
	["Distraction"]={ class = "ROGUE", level = 22, },
	["Disparition"]={ class = "ROGUE", level = 22, },
	["Détection des pièges"]={ class = "ROGUE", level = 24, },
	["Poison de distraction mentale"]={ class = "ROGUE", level = 24, },
	["Coup bas"]={ class = "ROGUE", level = 26, },
	["Désarmement de piège"]={ class = "ROGUE", level = 30, },
	["Aiguillon perfide"]={ class = "ROGUE", level = 30, },
	["Poison mortel"]={ class = "ROGUE", level = 30, },
	["Poison douloureux"]={ class = "ROGUE", level = 32, },
	["Cécité"]={ class = "ROGUE", level = 34, },
	["Poudre aveuglante"]={ class = "ROGUE", level = 34, },
	["Chute amortie"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["Frappe fantomatique"]={ class = "ROGUE", level = 20, },
	["Riposte"]={ class = "ROGUE", level = 20, },
	["Déluge de lames"]={ class = "ROGUE", level = 30, },
	["Sang froid"]={ class = "ROGUE", level = 30, },
	["Hémorragie"]={ class = "ROGUE", level = 30, },
	["Préparation"]={ class = "ROGUE", level = 30, },
	["Poussée d'adrénaline"]={ class = "ROGUE", level = 40, },
	["Préméditation"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["Vague de soins"]={ class = "SHAMAN", level = 1, },
	["Eclair"]={ class = "SHAMAN", level = 1, },
	["Arme Croque-roc"]={ class = "SHAMAN", level = 1, },
	["Horion de terre"]={ class = "SHAMAN", level = 4, },
	["Totem de Peau de pierre"]={ class = "SHAMAN", level = 4, },
	["Totem de lien terrestre"]={ class = "SHAMAN", level = 6, },
	["Bouclier de foudre"]={ class = "SHAMAN", level = 8, },
	["Totem de Griffes de pierre"]={ class = "SHAMAN", level = 8, },
	["Horion de flammes"]={ class = "SHAMAN", level = 10, },
	["Arme Langue de feu"]={ class = "SHAMAN", level = 10, },
	["Totem incendiaire"]={ class = "SHAMAN", level = 10, },
	["Totem de Force de la Terre"]={ class = "SHAMAN", level = 10, },
	["Esprit ancestral"]={ class = "SHAMAN", level = 12, },
	["Totem Nova de feu"]={ class = "SHAMAN", level = 12, },
	["Expiation"]={ class = "SHAMAN", level = 12, },
	["Totem de Séisme"]={ class = "SHAMAN", level = 18, },
	["Horion de givre"]={ class = "SHAMAN", level = 20, },
	["Arme de givre"]={ class = "SHAMAN", level = 20, },
	["Loup fantôme"]={ class = "SHAMAN", level = 20, },
	["Totem guérisseur"]={ class = "SHAMAN", level = 20, },
	["Vague de soins inférieurs"]={ class = "SHAMAN", level = 20, },
	["Totem de Purification du poison"]={ class = "SHAMAN", level = 22, },
	["Totem de résistance au Givre"]={ class = "SHAMAN", level = 24, },
	["Double vue"]={ class = "SHAMAN", level = 26, },
	["Totem de Magma"]={ class = "SHAMAN", level = 26, },
	["Totem Fontaine de mana"]={ class = "SHAMAN", level = 26, },
	["Totem de résistance au Feu"]={ class = "SHAMAN", level = 28, },
	["Totem Langue de feu"]={ class = "SHAMAN", level = 28, },
	["Rappel astral"]={ class = "SHAMAN", level = 30, },
	["Totem de Glèbe"]={ class = "SHAMAN", level = 30, },
	["Totem de résistance à la Nature"]={ class = "SHAMAN", level = 30, },
	["Réincarnation"]={ class = "SHAMAN", level = 30, },
	["Arme Furie-des-vents"]={ class = "SHAMAN", level = 30, },
	["Chaîne d'éclairs"]={ class = "SHAMAN", level = 32, },
	["Totem Furie-des-vents"]={ class = "SHAMAN", level = 32, },
	["Totem Sentinelle"]={ class = "SHAMAN", level = 34, },
	["Totem de Mur des vents"]={ class = "SHAMAN", level = 36, },
	["Totem de Purification des maladies"]={ class = "SHAMAN", level = 38, },
	["Salve de guérison"]={ class = "SHAMAN", level = 40, },
	["Totem de Grâce aérienne"]={ class = "SHAMAN", level = 42, },
	["Totem de Tranquillité de l'air"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["Parade"]={ class = "SHAMAN", level = 30, },
	["Maîtrise élémentaire"]={ class = "SHAMAN", level = 40, },
	["Totem de Vague de mana"]={ class = "SHAMAN", level = 40, },
	["Courroux naturel"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["Peau de démon"]={ class = "WARLOCK", level = 1, },
	["Immolation"]={ class = "WARLOCK", level = 1, },
	["Trait de l'ombre"]={ class = "WARLOCK", level = 1, },
	["Invocation d'un diablotin"]={ class = "WARLOCK", level = 1, },
	["Corruption"]={ class = "WARLOCK", level = 4, },
	["Malédiction de faiblesse"]={ class = "WARLOCK", level = 4, },
	["Connexion"]={ class = "WARLOCK", level = 6, },
	["Malédiction d'agonie"]={ class = "WARLOCK", level = 8, },
	["Peur"]={ class = "WARLOCK", level = 8, },
	["Création de Pierre de soins (mineure)"]={ class = "WARLOCK", level = 10, },
	["Siphon d'âme"]={ class = "WARLOCK", level = 10, },
	["Invocation d'un marcheur du Vide"]={ class = "WARLOCK", level = 10, },
	["Captation de vie"]={ class = "WARLOCK", level = 12, },
	["Malédiction de témérité"]={ class = "WARLOCK", level = 14, },
	["Drain de vie"]={ class = "WARLOCK", level = 14, },
	["Respiration interminable"]={ class = "WARLOCK", level = 16, },
	["Douleur brûlante"]={ class = "WARLOCK", level = 18, },
	["Création de Pierre d'âme (mineure)"]={ class = "WARLOCK", level = 18, },
	["Armure démoniaque"]={ class = "WARLOCK", level = 20, },
	["Pluie de feu"]={ class = "WARLOCK", level = 20, },
	["Rituel d'invocation"]={ class = "WARLOCK", level = 20, },
	["Invocation d'une succube"]={ class = "WARLOCK", level = 20, },
	["Création de Pierre de soins (inférieure)"]={ class = "WARLOCK", level = 22, },
	["Oeil de Kilrogg"]={ class = "WARLOCK", level = 22, },
	["Drain de mana"]={ class = "WARLOCK", level = 24, },
	["Détection des démons"]={ class = "WARLOCK", level = 24, },
	["Malédiction des langages"]={ class = "WARLOCK", level = 26, },
	["Détection de l'invisibilité inférieure"]={ class = "WARLOCK", level = 26, },
	["Bannir"]={ class = "WARLOCK", level = 28, },
	["Création de Pierre de feu (inférieure)"]={ class = "WARLOCK", level = 28, },
	["Asservir démon"]={ class = "WARLOCK", level = 30, },
	["Flammes infernales"]={ class = "WARLOCK", level = 30, },
	["Invocation d'un chasseur corrompu"]={ class = "WARLOCK", level = 30, },
	["Création de Pierre d'âme (inférieure)"]={ class = "WARLOCK", level = 30, },
	["Malédiction des éléments"]={ class = "WARLOCK", level = 32, },
	["Gardien de l'ombre"]={ class = "WARLOCK", level = 32, },
	["Création de Pierre de soins"]={ class = "WARLOCK", level = 34, },
	["Création de Pierre de feu"]={ class = "WARLOCK", level = 36, },
	["Création de Pierre de sort"]={ class = "WARLOCK", level = 36, },
	["Détection de l'invisibilité"]={ class = "WARLOCK", level = 38, },
	["Hurlement de terreur"]={ class = "WARLOCK", level = 40, },
	["Invocation d'un palefroi corrompu"]={ class = "WARLOCK", level = 40, },
	["Création de Pierre d'âme"]={ class = "WARLOCK", level = 40, },
	["Voile mortel"]={ class = "WARLOCK", level = 42, },
	["Malédiction de l'ombre"]={ class = "WARLOCK", level = 44, },
	["Création de Pierre de soins (supérieure)"]={ class = "WARLOCK", level = 46, },
	["Création de Pierre de feu (supérieure)"]={ class = "WARLOCK", level = 46, },
	["Feu de l'âme"]={ class = "WARLOCK", level = 48, },
	["Création de Pierre de sort (supérieure)"]={ class = "WARLOCK", level = 48, },
	["Détection de l'invisibilité supérieure"]={ class = "WARLOCK", level = 50, },
	["Inferno"]={ class = "WARLOCK", level = 50, },
	["Création de Pierre d'âme (supérieure)"]={ class = "WARLOCK", level = 50, },
	["Création de Pierre de feu (majeure)"]={ class = "WARLOCK", level = 56, },
	["Création de Pierre de soins (majeure)"]={ class = "WARLOCK", level = 58, },
	["Malédiction funeste"]={ class = "WARLOCK", level = 60, },
	["Rituel de malédiction"]={ class = "WARLOCK", level = 60, },
	["Invocation d'un destrier de l'effroi"]={ class = "WARLOCK", level = 60, },
	["Création de Pierre d'âme (majeure)"]={ class = "WARLOCK", level = 60, },
	["Création de Pierre de sort (majeure)"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["Malédiction amplifiée"]={ class = "WARLOCK", level = 20, },
	["Domination corrompue"]={ class = "WARLOCK", level = 20, },
	["Brûlure de l'ombre"]={ class = "WARLOCK", level = 20, },
	["Malédiction de fatigue"]={ class = "WARLOCK", level = 30, },
	["Sacrifice démoniaque"]={ class = "WARLOCK", level = 30, },
	["Siphon de vie"]={ class = "WARLOCK", level = 30, },
	["Conflagration"]={ class = "WARLOCK", level = 40, },
	["Pacte noir"]={ class = "WARLOCK", level = 40, },
	["Lien spirituel"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["Posture de combat"]={ class = "WARRIOR", level = 1, },
	["Frappe héroïque"]={ class = "WARRIOR", level = 1, },
	["Volée de coups améliorée"]={ class = "WARRIOR", level = 1, },
	["Charge"]={ class = "WARRIOR", level = 4, },
	["Pourfendre"]={ class = "WARRIOR", level = 4, },
	["Coup de tonnerre"]={ class = "WARRIOR", level = 6, },
	["Brise-genou"]={ class = "WARRIOR", level = 8, },
	["Rage sanguinaire"]={ class = "WARRIOR", level = 10, },
	["Posture défensive"]={ class = "WARRIOR", level = 10, },
	["Fracasser armure"]={ class = "WARRIOR", level = 10, },
	["Provocation"]={ class = "WARRIOR", level = 10, },
	["Fulgurance"]={ class = "WARRIOR", level = 12, },
	["Coup de bouclier"]={ class = "WARRIOR", level = 12, },
	["Cri démoralisant"]={ class = "WARRIOR", level = 14, },
	["Vengeance"]={ class = "WARRIOR", level = 14, },
	["Coup railleur"]={ class = "WARRIOR", level = 16, },
	["Maîtrise du blocage"]={ class = "WARRIOR", level = 16, },
	["Désarmement"]={ class = "WARRIOR", level = 18, },
	["Enchaînement"]={ class = "WARRIOR", level = 20, },
	["Représailles"]={ class = "WARRIOR", level = 20, },
	["Cri d’intimidation"]={ class = "WARRIOR", level = 22, },
	["Exécution"]={ class = "WARRIOR", level = 24, },
	["Cri de défi"]={ class = "WARRIOR", level = 26, },
	["Mur protecteur"]={ class = "WARRIOR", level = 28, },
	["Posture berserker"]={ class = "WARRIOR", level = 30, },
	["Interception"]={ class = "WARRIOR", level = 30, },
	["Heurtoir"]={ class = "WARRIOR", level = 30, },
	["Rage berserker"]={ class = "WARRIOR", level = 32, },
	["Tourbillon"]={ class = "WARRIOR", level = 36, },
	["Volée de coups"]={ class = "WARRIOR", level = 38, },
	["Témérité"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["Dernier rempart"]={ class = "WARRIOR", level = 20, },
	["Hurlement perçant"]={ class = "WARRIOR", level = 20, },
	["Bourrasque"]={ class = "WARRIOR", level = 30, },
	["Souhait mortel"]={ class = "WARRIOR", level = 30, },
	["Attaques circulaires"]={ class = "WARRIOR", level = 30, },
	["Sanguinaire"]={ class = "WARRIOR", level = 40, },
	["Frappe mortelle"]={ class = "WARRIOR", level = 40, },
	["Heurt de bouclier"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {

};
 
