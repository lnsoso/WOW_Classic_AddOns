-- English text strings

Localization.RegisterAddonStrings("enUS", "Localization",
  {
    -- Locales
    enUS      = "English";
    enGB      = "English";
    frFR      = "French";
    ruRU      = "Russian";
    zhTW      = "Traditional Chinese";
    deDE      = "German";
    ptBR      = "Brazilian Portuguese";

    -- Frame Strings
    Confirm         = "Confirm";
    Cancel          = "Cancel";
    RemoveUnused    = "Remove unused locales from memory.";
    SelectPreferred = "Select a preferred localization:";
    AvailLangs      = "Available Languages";

    --Earth Button
    Localization  = "Localization";
    ShowPrompt    = "Show Prompt";
    EarthTooltip  = "Show Locale Selection Dialogue.";
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("enUS", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Search for items which Pawn considers an upgrade";
    OPTIONS           = "Options:";
    HELP_ID           = "Pawn Searcher";
    HELP_QUESTION     = "What does this searcher do?";
    HELP_ANSWER       = "This searcher will use a scale that has been defined in the Pawn addon to locate upgrades for your currently equipped items.";
    CONFIG_HEADER     = "Pawn Search Criteria";
    SCALE_SELECT      = "Pawn scale";
    SCALE_SELECT_TIP  = "The Pawn scale that will be used to determine the item value";
    USEABLE_ONLY      = "Useable items only";
    USEABLE_ONLY_TIP  = "Only items that your character can use.";
    AFFORD_ONLY       = "Only what I can afford";
    AFFORD_ONLY_TIP   = "Only show what you can currently afford to buy.";
    USE_BUYOUT        = "Use buyout";
    USE_BUYOUT_TIP    = "Use buyout instead of bid when checking auction prices.";
    USE_BESTPRICE       = "Adjust score based on price.";
    USE_BESTPRICE_TIP   = "Adjust the score returned by the price of the item.  For similar items, the cheaper item will be higher on the list.";
    USE_UNENCHANTED     = "Use Unenchanted Values";
    USE_UNENCHANTED_TIP = "Use unenchanted values for calculations. If not checked, item values will include current enchantements.";
    FORCE2H_WEAP      = "Only 2H Weapons";
    FORCE2H_TIP       = "When comparing weapons, only consider 2-Handed Weapons.";
    INCLUDE_IN_SEARCH = "Include these slots when searching:";
    SHOW_HEAD         = "Head";
    SHOW_NECK         = "Neck";
    SHOW_SHOULDER     = "Shoulder";
    SHOW_BACK         = "Back";
    SHOW_CHEST        = "Chest";
    SHOW_WRIST        = "Wrist";
    SHOW_HANDS        = "Hands";
    SHOW_WAIST        = "Waist";
    SHOW_LEGS         = "Legs";
    SHOW_FEET         = "Feet";
    SHOW_FINGER       = "Finger";
    SHOW_TRINKET      = "Trinket";
    SHOW_WEAPON       = "Weapon";
    SHOW_OFFHAND      = "Off-Hand";
    SHOW_RANGED       = "Ranged";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "Only show the selected armor type in search results.  Filter out all other armor types.";
    ARMOR_PREFERENCE = "Armor Preference";
    NO_PREF   = "No Preference";
    CLOTH     = "Cloth";
    LEATHER   = "Leather";
    MAIL      = "Mail";
    PLATE     = "Plate";

    --Item Types
    ARMOR   = "Armor";
    TOTEMS  = "Totems";
    LIBRAMS = "Librams";
    IDOLS   = "Idols";
    SIGILS  = "Sigils";
    SHIELDS = "Shields";
    MISC    = "Miscellaneous";

    -- Two Handed sub-string
    TWOHAND = "Two-Hand";
    
    -- Two Handed Weapons
    STAVES = "Staves";
    POLEARMS = "Polearms";
    -- CROSSBOWS
    -- GUNS
    -- BOWS

    -- Ranged
    DAGGERS = "Daggers";
    BOWS = "Bows";
    GUNS = "Guns";
    WANDS = "Wands";
    CROSSBOWS = "Crossbows";
    THROWN = "Thrown"; -- may be removed

    -- Messages
    BAD_SCALE   = "Please select a valid scale.";
    NOT_WANTED  = "Item slot not wanted";
    NOT_UPGRADE = "Pawn value is too low.";

    REASON_BUY = "buy";
    REASON_BID = "bid";
  },
nil, true) -- Protected
