## Version History

### v1.13.34 (Feb 3, 2020)

* Update skills know count number to now show the number for the current phase but also total number after all content is released
    * Updated numbers in progressbar to not only show current max amount of recipes but also the total in the end (= number between [])
    * Updated numbers in Database explorer under each profession icon to not only show current max amount of recipes but also the total in the end (= number between [])
    * Extra number between [] is not shown if current phase already has all total skills to be released
* Added NPC explorer frame (/mtsl npc or alt + left click on minimap button)
    * Shows a list of all available NPCs that teaches a skill, drop/vendor recipe or start quest
    * Ability to filter by: Name, Faction, Profession, Type/Source, trainer rank, Zone 
    * Icons showing standing of NPC (skull if hostile/mob, mix Alliance/horde icon for Neutral)
    * Icons showing the profession to which the skill belongs
* Added options to config menu to allow scaling & setting of splitmode of NPC explorer frame
* Added buttons to each Explorer frame to be quickly swap to another explorer frame (Between Account, Database and NPC)
* Corrected & verified all Blacksmithing data

### v1.13.33 (Jan 24, 2020)

* Fixed bug that prevented minimap settings from being saved
* Fixed bug that prevented enhanced tooltip settings from being saved
* Added patch levels between current and max for filtering in Database & Account explorer
* Added correct XP level needed to train each rank for each profession
* Checked, Corrected & Verified all skills/items/levels of Cooking, First Aid, Mining & Poisons
* Added more localisation strings
* Fixed bug where addon frames sometimes where not always shown on top
* Improved moving minimap button code, it should move smoothly now
* Set patch level of content back to 2 instead of 3

### v1.13.32 (Jan 19, 2020)

* Added enhancement to tooltip to show status of your other characters (on same realm) for the recipe
    * Green = learned
    * Orange = not learned but high enough skill to learn
    * Red = not learned and too low skill
* Added options to optionsmenu
    * Enhance tooltip (Default on)
    * Show all alts on same realm or only only alts with same faction (Default = same faction)
* Removed options from optionsmenu
    * Set content patch/phase level (now hardcoded again)
* Added label to show content phase in detailswindow of a skill
* Fixed a bug where source type for alternative source of skill did not show properly
* Fixed a bug where searching for partial skill did not always result in correct skills list
* Fixed a bug where skills with multiple sources did not filter correctly when choosing a specific zone
* Added an option to filter by faction (Alliance, Horde or any faction that uses reputation)
* Removed labels in filter frame to save space => added text to the "Any" option for each filter
 
### v1.13.31 (Jan 9, 2020)

* Fixed bug that always opened MTSL window even if option was disabled
* Fixed bug in options menu where checkboxes were always shown as checked even if they were not
* Added an event to capture "ding" of player to update XP level while playing
* Fixed bug where MTSL account explorer did not work for other locales then English
* Fixed a refresh bug in MTSL account explorer when changing characters, the list did not update
* Slashcommands now work case insensitive

### v1.13.30 (Jan 8, 2020)

* Fixed the help text with wrong slashcommand text
* Added lots of missing Korean & Chinese quest names
* Added poisons
* Fixed bug where Current Zone of player did not update/display correct in the filter frame

### v1.13.29 (Jan 3, 2020)

* Fixed some wrong Chinese translations
* Added minimap button (Default on and shown at top of minimap)
    * Left Click: opens MTSL options menu
    * Ctrl + Left Click opens MTSL account explorer
    * Shift + Left Click: opens MTSL database explorer
* Added options to configure minimap button
    * Activate/Deactivate the minimap button (Default on)
    * Button radius compared to minimap edge (Default 0)
    * Shape of the minimap (Default circle)

### v1.13.28 (Dec 23, 2019)

*   Compatible game version 1.13.3
*   Added an option to directly show MTSL when opening a profession window
*   Added an option to set the current content patch level used to show data
*   Fixed some wrong Korean translations
*   Added translations for Mexican Spanish for all skills, recipes, items & specialisations. Other data is copied from Spanish

### v1.13.27 (Dec 7, 2019)

*   Checked and fixed all Alchemy data
*   Added some missing translations, almost all in-game items done
*   Comparing known skills by name without spaces to avoid conflicts with number of spaces

### v1.13.26 (Nov 17, 2019)

*   Fixed wrong quest data
*   Fixed some wrong translations
*   Fixed some wrong profession data
*   Fixed all remaining spells with minimum skill of 0 to have correct minimum skill needed to learn
*   Fixed bug that prevented correct update of player list frame

### v1.13.25 (Nov 8, 2019)

*   Added specialisations as skills too
*   Fixed some wrong recipes
*   Added holidays as source type
*   Added label to show the holiday needed to get a skill
*   Added label to show the sourcetype of a sources of a skill (e.g.: if skill is obtained from recipe, you can also see the sourcetype of the recipe)
*   Fixed bug when using the sourcetype filter
*   Fixed bug when using the phase filter

### v1.13.24 (Oct 27, 2019)

*   Fixed some Blacksmithing data
*   Added translations to some of the options menu labels/buttons
*   Added label for "realm" and "character" in options menu
*   Improved French localization
*   Translated all special actions to each locale

### v1.13.23 (Oct 26, 2019)

*   Added option to change font type & size of Titles, labels & text
    *   UI will auto reload if changed
    *   Does not affect buttons & dropdowns
*   Improved French localization

### v1.13.22 (Oct 25, 2019)

*   Fixed bug for addon not working for engineering by adding ranks to the levels
*   Default selected current character in mtsl options screen

### v1.13.21 (Oct 24, 2019)

*   Added specialisations to spells (Blacksmithing, Engineering & Leatherworking)
*   Fixed some engineering recipes
*   Fixed bug with lower trained ranks still shown in list
*   Only hooked MTSL to SkilletFrame if also used/visible
*   Replaced sort option by level/name by option to search by (partial) name
*   Added filter option for source type of skill (Trainer, Quest, Vendor, Drop, Object)
*   Added filter option for specialisations

### v1.13.20 (Oct 13, 2019)

*   Fixed wrong translations
*   Fixed some lua errrors
*   TradeSkillFrame & CraftFrame are now draggable
*   Added menu option to hook MTSL button left or right on TradeSkillFrame/CraftFrame
*   Support for SkilletFrame for CraftFrame as well

### v1.13.19 (Oct 12, 2019)

*   Account Explorer uses different code to show learned skills (**resave all players/professions**)
*   Colored skill level in Account Explorer to show status
    *   Green : learned
    *   Orange : can be learned
    *   Red : can not be learned
*   Changes to options menu:
    *   Added UI split-orientation option for all 3 main windows (will reset current saved scale!)
    *   Redesigned scaling to drop downs for compacter/better view
*   Fixed some wrong translations
*   Account explorer & options menu window is now movable/draggable
*   Refactored UI code making all 3 main windows appear/use same code
*   Split up datafile with continents & zones
*   Moved "Kalimdor" up in filterlist before "The Eastern Kingdoms"
*   Numerous code fixing for smaller filesize addon & faster running
*   Sort players by name/realm in Account Explorer & Database explorer view
*   Filters players by realm in Account Explorer & Database explorer view

### v1.13.18 (Oct 1, 2019)

*   Changed way options/config is saved so current saved scale will be reset first time!
*   Fixed scaling bug
*   Fixed some wrong translations
*   Split the location filter up into 2 dropdowns (1 for continent & 1 for subzone)
*   Added "continents" for Dungeon, Raid & BG to "lighten" the mount of subzones in each drop down
*   Added a configuration menu (/mtsl or /mtsl config or /mtsl options) to allow more user UI tweaking
    *   Choose splitdirection (Horizontal/Vertical) for MTSL main window (NOT Account or Database explorer)
    *   UI Scaling for each Frame (Keep in mind that if other addon scales window, it adds to that scale)
    *   Choose default font (not yet available)
    *   Remove a character
    *   Clear all saved data and restore default values
*   Slash commands for user config have been removed

### v1.13.17 (Sep 29, 2019)

*   Translated all built-in MTSL labels (Report mistakes or improvements in opened Issues tickets)
*   Added support for Skillet-Classic addon

### v1.13.16 (Sep 29, 2019)

*   Added check to only add "current zone" to list of zone filter when possible (does not always find the zone)

### v1.13.15 (Sep 29, 2019)

*   Added content phases to items
    *   Only shows obtainable (current in game) skills next to tradeskill/craft window
    *   Ability to show items only for current phase or all in Database explorer
*   Ability to sort (name, level) or (name & realm) in Account & Database Explorer
*   Ability to filter on zone (All, current, specific zone) in Database Explorer
    *   World drops ignored when filtering on specific zone
*   Ability to filter on zone (All, current) in MTSL window
*   Translated some of the MTSL labels

### v1.13.14 (Sep 27, 2019)

*   Added support for Chinese & Korean locales
*   Translated all the NPC's, objects & quests to have their localised name
*   Changed default font to Arial Narrow to save space

### v1.13.13 (Sep 24, 2019)

*   Added checks for hunter beast training

### v1.13.12 (Sep 22, 2019)

*   Fixed some wrong translations
*   Fixed Account explorer when a character has no known tradeskills
*   Fixed width of selected/hoovered listitems to fill the frame
*   Expanded width of listframes to show all text (French text was sometimes outside frame)
*   Added localised names for factions

### v1.13.11 (Sep 22, 2019)

*   Added localised names for zones (TomTom waypoints should now work in all supported languages)
*   Fixed bug where Enchanting was no longer available for addon
*   Fixed some wrong data

### v1.13.10 (Sep 20, 2019)

*   Added Account explorer window (/mtsl acc or /mtsl account)
*   Added colors for factions (red = Horde, blue = Alliance)
*   Added frames to visible see which profession is selected in Database & Account explorer
*   Added extra check for craftwindows, only "Enchanting" will trigger MTSL

### v1.13.09 (Sep 16, 2019)

*   Added integration for TomTom waypoints. (Needs TomTom installed)
    *   Click on a name of NPC/object to get add a waypoint
    *   Only tested on English client
    *   Warning will be printed if TomTom is not installed (only 1 time)
*   Database Explorer window now also hides if u press "Esc" key
*   Fixed bug with Fontsize of labels
*   Fixed bug with Russian naming for Mining profession
*   Fixed a bug in code for event "TRAINER_UPDATE"
*   Fixed some wrong data

### v1.13.08 (Sep 16, 2019)

*   Russian characters are now shown properly
*   Added additional check for poisons of rogues
*   Removed debugging prints

### v1.13.07 (Sep 15, 2019)

*   Fixed bug that Poisons frame of rogue was seen as Tradeskill (TradeSkill might be added later on)
*   Characters are once again saved!
*   Added conversion for old saved data to new structure
*   Able to remove saved data for a character (use /mtsl remove <name char> <name realm>)
*   Able to reset the saved data (use /mtsl reset)

### v1.13.06 (Sep 15, 2019)

*   Added support all languages (Built-in labels & texts still in English)
*   Added scaling of Database Explorer.
    *   use /mtsl scale <scale number> to set it (0.5-1.25)
    *   Scale is saved
*   Trainer update event only triggers refresh of skills if trainer of the current shown profession is opened
*   Crafting items should not trigger update/refresh of UI

### v1.13.05 (Sep 13, 2019)

*   Added tooltips on mouse over for skills & recipes
*   Added message if quest not available for your faction
*   Added character view panel to Database Explorer which lets you see if characters can learn the skill
*   Database Explorer window is draggable
*   Automatic selecting first skill (if one is available) when opening/showing the window

### v1.13.04 (Sep 13, 2019)

*   Added Database explorer window:
    *   Check out any skill for any profession
    *   to open: use /mtsl db or /mstl database

### v1.13.03 (Sep 11, 2019)

*   Fixed UI for main scrollbar
*   Changed scrolling to 5 items at a time
*   Moved the MTSL button above the tradeskill/craft window to avoid overlap other addons
*   Fixed the layout when a skill has multiple sources (Bug nr 2)

### v1.13.02 (Sep 9, 2019)

*   Added check for locales. Only enUS or enGB are supported and will load

### v1.13.01 (Sep 9, 2019)

*   Initial version