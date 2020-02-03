# MissingTradeSkillsList
Addon for World Of Warcraft Classic v1.13  
Shows the missing recipes/skills for a tradeskill and where to get them  
Addon only works **all** languages now! (MTSL Options menu still only shown in English only)  

Please **donate** (paypal to thumbkin83@gmail.com) if you want to support this addon!

### Author
Thumbkin (Retail: EU-Burning Steppes, Classic: EU-Pyrewood Village)

### Screenshots
MTSL - Vertical split (Change using options menu)
![alt text](http://mtsl.ddns.net/images/mtsl_main.png "Missing TradeSkills List - Main window")
Account explorer (/mtsl acc or /mtsl account)
![alt text](http://mtsl.ddns.net/images/mtsl_account.png "Missing TradeSkills List - Account explorer")
Database explorer (/mtsl db or /mtsl database)
![alt text](http://mtsl.ddns.net/images/mtsl_database.png "Missing TradeSkills List - Database explorer")
NPC explorer (/mtsl npc)
![alt text](http://mtsl.ddns.net/images/mtsl_npc.png "Missing TradeSkills List - NPC explorer")
Options menu (/mtsl or /mtsl config or /mtsl options)
![alt text](http://mtsl.ddns.net/images/mtsl_options.png "Missing TradeSkills List - Options menu")
Minimap button
![alt text](http://mtsl.ddns.net/images/mtsl_minimap.png "Missing TradeSkills List - Minimap")
Enhanced tooltip
![alt text](http://mtsl.ddns.net/images/mtsl_tooltip.png "Missing TradeSkills List - Enhanced tooltip")

### Key Features

* List of all available skills & recipes for Alchemy, Blacksmithing, Cooking, Enchanting, Engineering, First Aid, Leatherworking, Mining, Poisons & Tailoring
* Following professions have full correct data: Alchemy, Blacksmithing, Cooking, First Aid, Mining & Poisons
* View missing skills for a profession (open tradeskill frame and use MTSL button)
* Explorer frames to browse the addon data
    * View skills learned on your alts (/mtsl acc)
    * All ingame skills (/mtsl db)
    * All ingame NPCs to see what they offer (/mtsl npc)
* Options menu to configure addon settings (/mtsl or /mtsl config or /mtsl options)
* Minimap button to quickly access the explorer frames or options menu
* Integration with other addons (seperate addon installation needed)
    * TomTom: set waypoints to NPCs by clicking on their names
    * Skillet-Classic
* Enhanced tooltip to show status of alts on same realm for a recipe 
    * Green = learned
    * Orange = not learned but high enough skill to learn
    * Red = not learned and too low skill

### Known Bugs

* Not all trainer skills have the correct minimum skill required or price
* Not all skills have the correct required XP level  
* World drops currently left out when filtering on specific zone for drops (mob range check not yet in place)  

### Latest version (v1.13.34)

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
 
 View full version history [here](http://mtsl.ddns.net/VERSION_HISTORY.html) or VERSION_HISTORY.md inside zip addon