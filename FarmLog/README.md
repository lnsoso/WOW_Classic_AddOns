# FarmLog
World of Warcraft Classic addon that logs loot, monster kills, honor and instances. Know exactly what your farm session has yielded.

### What it is for
You can track your farming session and know how much gold/hour you make. Good for general grinding, instance item farming, rep farm, tradeskill work, honor farm, know how many you killed in a rare BoE farm, etc etc.

FarmLog now tracks Black Lotus picking and shows respawn timers! (need DBM addon for timer bars)

### What it does
* Tracks 
    * Shows Gold/Hour of active farming session
    * Farm session time with a stopwatch
    * Mob kills, counts how many of each mob was killed
    * Loot from mobs and quests
    * Herbalism, skinning and mining yield
    * Money loot, displays total gold collected
    * Shows loot vendor value in gold
    * Reputation gain per faction
    * XP gained
    * Skill levels
    * Honor gain, HKs, DKs, ranks kill count
    * Black Lotus pick time and location
    * Deaths
* Allows reporting farm results
* Display farm yield in a window with all looted items
* Allows filtering item poor and common items
* Save multiple farm sessions, you can switch to a different session and continue from where you left off. Read more about Sessions below.
* When a Black Lotus is picked, it will log the time, zone and coords. You can see it by clicking the BL in your session log
* If you have DBM installed, it'll start a timer for next spawn. It persists through logout / playing alts.

### How to install
* Download, extract (if zipped)
* Make sure folder doesn't have `-master` surffix
* Copy `FarmLog` folder to your `WoW\Interface\AddOns` folder

### How to use
* `/fl` - toggle logging on/off
* `/fl r` - reset log
* `/fl s` - shows log
* `/fl set <ITEMLINK> <GOLDVALUE>` - sets AH value of an item, in gold

### Sessions 
Many times you pause your farming to do something else in game, like doing an instance and afterwards continue to farm herbs. So you want to know how much herb farming yields and how much the instance run has yielded, but these are two different sessions! That's why you can name sessions and switch between them according to what you're doing. 

Another thing is that the more time & data you have per session, the more accurate gold/hour metric you're going to see. For example, you can `/fl switch Herbing` when collecting herbs and `/fl switch Fishing` whenever you fish, do that for a week and you'll get a reasonably accurate gold/hour metric.

### Frequently Asked Questions
**Why do some items appear under "Unknown"?**
 When a loot log messages arrives, it does not contain the mob name that dropped it. Assuming that it came from the last killed mob because one may kill multiple mobs and later loot them all. So we need a loot window to appear, we then know what loot that mob dropped and make correct attribution.
 Sometimes, a loot is received without any loot window being opened, like for instance when someone in your group loots a mob with green item and you win the roll. In this case, the addon won't know which mob dropped it.
 This may also happen if you have addons like "Leatrix Plus" with "Fast loot" option enabled. This causes loot to be received before loot window is opened, so the addon doesn't know where it came from.


![Preview 1](https://github.com/E1ila/FarmLog/blob/master/Preview7.png)
![Preview 2](https://github.com/E1ila/FarmLog/blob/master/Preview5.png)
![Preview 3](https://github.com/E1ila/FarmLog/blob/master/Preview6.png)
![Preview 4](https://github.com/E1ila/FarmLog/blob/master/Preview2.png)
![Preview 5](https://github.com/E1ila/FarmLog/blob/master/Preview.png)
![Preview 6](https://github.com/E1ila/FarmLog/blob/master/Preview3.png)
![Preview 7](https://github.com/E1ila/FarmLog/blob/master/Preview4.png)

### Changes 
* 1.19.2
    * Fixed tracking of award honor gain
* 1.19
    * Counting battle grounds count, as well as wins/loss count
    * BGs are not counted for instance lock count
    * Honor diminshing returns can be disabled for BGs (still not confirmed if it's enabled in BGs)
    * Added separate option to resume/pause a BG farm, so if you initiated a BG farm session, it'll know to pause when you leave BG and resume when youo come back.
    * Added level-up count
* 1.18.3
    * Fixed bug causing consumes used on different levels (character level up) to be shown seperately on the log.
* 1.18.2 
    * Fixed (non) parsing of loot messages for non-english languages.
    * Fixed an error when starting new session when old one had consumes in it.
* 1.18.1
    * Added option for AH min quality, this will allow choosing for which item quality price will be taken from an AH scan. For instance, if min quality is Rare+, vendor price will be used for green items and below.
    * Fixed HUD positioning issue, it should now show correctly.
* 1.18
    * Consumes tracking! Will now log all (hopefully) consumes you've been using in your session. Their value will be deducted from the vendor price, thus affecting GPH. You can disable it from the options screen (`/fl`), or manually adjust consumes prices with `/fl set [Item Link] 1` to set an item's price to 1 gold, it'll try to use Auctionator or TSM price first. If you find any missing consume, feel free to report in https://github.com/E1ila/FarmLog
* 1.17.9
    * With Auto Instance Switch enabled, FarmLog will now resume a session if current farm is an instance farm. When choosing a farm that's used in an instance, it'll bind the farm session to that instance and from that moment on, when you enter that instance while on this farm session, the addon will just resume it, instead of switching to "Dire Maul" farm. If FarmLog is set to another session, not related to DM, it will switch to "Dire Maul" farm session once you go into DM. Hope I explained it well, if not - just try and see how it works.
    * Added `/farm` command to toggle session active/paused.
    * Starting a new session will enable Current session view
    * Diminishing returns reset is checked upon login as well, for Honor % tooltip
    * Disabled mouse interaction of Honor Frenzy frame
* 1.17.8
    * Honor frenzy count! Shows how many you've killed in a row and how much honor it yielded.
* 1.17.7
    * Numbers bigger than 999 will use a thusands separator
    * Using known vendor price when recalculating profit, this fixes some vendor items with no value due wow API thottle
    * Removed number of instances form pvp mode
* 1.17.6
    * Supporting TradeSkillManager addon for AH price check!
* 1.17.5
    * Showing honor % to be received on enemy player tooltip! 
    * Fixed Fishing bug when loot was attributed to "Unknown", thanks https://github.com/aEnigmatic
    * Added integration with Auctionator for AH item value, thanks https://github.com/aEnigmatic
    * Supporting items with no AH nor vendor value (Mature Black Dragon Sinew, etc)
    * Supporting BigWigs for Black Lotus timer
* 1.17.2
    * Added XP/hour, contribution by github.com/Tanoh
    * Fixed crash for unknown XP & money loot events
* 1.17.1
    * Added + button in All Farms window to create a new farm, will use the text in search box
* 1.17
    * Heads-up Display! Minified window with quick summary of your current session.
    * PvP mode! You can now switch between viewing honor or drops for each farm.
    * Added option to pause session on login, so it won't run after logging back in
* 1.16
    * Options screen! You can now configure FarmLog to your liking. Write `/fl` or Shift+Click the minimap button to see the option screen.
* 1.15.2
    * Counting rank kill count, instead of player names. This will reduce overload on the log and display more relevant information in later weeks, when we have higher ranks.
    * Starting  a new session now resets session time
    * Fixed bug introduced in 1.15.1 causing mob kills to not be counted
* 1.15.1
    * Fixed calculation of honor to support the diminishing return effect for honor
* 1.15
    * Supporting honor farm! Have a pleasant ranking.
* 1.14.3 
    * Fixed bug when holding shift on an item in loot log, it would show wrong "each" price
    * Added `/fl blp NAME` command to log a BL picked by another player
    * Fixed loading errors for new users
* 1.14.2
    * Fixed error showing up sometimes when picking BL
* 1.14
    * Multi-session farms! You can now see current session yield, or change to total view. Now you can tell if your current session has been better than past ones or clear current session without affecting past metrics.
* 1.13.2
    * Supporting player death count
    * Updated section colors
    * Fixed tracking of BL skill attempts, will take gear +herbalism into account
* 1.13.1
    * Supporting chest treasures! Loot from chests will be attributed to Treasure category
    * Measuring Black Lotus failed pick attempts & success for each Herbalism skill level
    * Fixed error shown when entering an instance
    * Counting instance IDs now even if Auto Switch Instance is disabled
* 1.13
    * Black Lotus Timers! FarmLog now logs Black Lotus picks and if you have DBM addon, it'll show a timer until next spawn, per map.
* 1.12.5
    * Fixed bug when loading a session without instance count
* 1.12.4
    * Added total instance count to loot log
* 1.12
    * Showing the number of instance IDs you've been to in the last hour
    * AH prices are saved separately per realm
    * Fixed "Unknown" mob name with fast loot, when not in party / raid
    * Fixed bug causing miscalculation of new loot, was using the latest quantity looted instead of total for item's total profit
    * Fixed wrong attribution of loot to mobs that had already loot attributed to them
* 1.11.6
    * You can now disable groupping by mob name
    * Added sort buttons to sessions window
    * Added search box in sessions window
* 1.11.3
    * Fixed loot window sorting bug
* 1.11
    * Writing `/fl w` without a session name will use the current minimap zone for a session name
    * Fixed some bugs occuring when deleting a session
    * Buttons added to loot window: sort by name/gold/kills
* 1.10
    * Main loot window doesn't hide bags
    * Main loot window visibility is saved, so if you close it, it will remain closed the next time you login
    * Sessions list now has a separate window
    * Fixed a bug causing recipes to be displayed wrong at the log
    * Displaying color-coded individual item's price: white = vendor, blue = AH scan, yellow = manual price set
    * Use shift when hovering item price to see price per item (instead of total for x quantity)
    * Fixed a bug causing AH scan to set 0 price for items with bid only
    * Fixed auto resume not working
* 1.9
    * You can now scan the auction house by opening the AH interface and writing `/fl ah`. FarmLog will record the minimal price per item and will use it to calculate AH profits. You can override item's price by setting price manually `/fl set [Arcane Crystal] 50`, then your manual entry will be used instead.
    * Fixed stored links - remove player level from link, so you don't get the duplicate items once you level up. 
    * Removed redundant level of array in database's drops.mob.item lists
* 1.8.1
    * Clearing a session while paused won't resume it
    * Updated minimap tooltip text
* 1.8 
    * Added Tooltip on minimap icon, showing current session
    * Main window won't close when hitting ESC
    * Allow ignoring certain items for GPH, write `/fl i [Item Link]` to add/remove from ignore list
* 1.7.3
    * Fixed bug causing to sometimes not track gray items
* 1.7.2
    * Fixed window positioning bug, causing position to load incorrectly
* 1.7.1
    * Fixed exception when parsing +rep message
* 1.6
    * REVAMPED USER INTERFACE!
    * Added delete session warning
    * Choosing a session from the UI won't resume it
    * Added reset window position `/fl rmw` and reset minimap icon `/fl rmi`
    * Fixed exception for new sessions GPH calculation
    * Pauses session when leaving instance, if Auto Switch Instances is enabled
* 1.4
    * New saved variables database format
* 1.3 
    * Allowing to rename sessions
* 1.2
    * Auto start session when entering an instance, with current instance name for session name.
* 1.1 
    * Sessions! You can now keep multiple session, read about it and how to use it above.
    * Removed "Reset Data" offer when entering an instance or after `/reload`.
* 1.0 
    * Initial release.

### To do
* Track traded gold (for enchanting, etc)
* Show repair bill
* Allow custom attribution loot to certain mob
* Support multiboxing GPH
* Add button to a rename a farm
* Show menu when clicking items on list - delete/blacklist/hide/set AH price/reassign
* Show drop chances
* Allow filtering loot window by quality, green/rare/epic buttons
* Allow starting instance session on first hit
* Allow manually increasing/decreasing kill values
* Allow sending session report
* Show list of instances and times
* Show AH scan time
* Allow scanning using a UI button
* Allow to show specific lines from log in HUD
* Allow tracking rested XP
* With auto instance switch ON, return to previous farm when leaving instance
* Sum consumes value on "Consumes" row
* Disable logging of trades somehow, unless enabled

### MIT License
Copyright 2019 https://github.com/E1ila

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
