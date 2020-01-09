-- Version : German (by StarDust)
-- Last Update : 05/05/2006

Localization.RegisterAddonStrings("deDE", "Localization", 
  {
    -- Locales
    enUS      = "Englisch";
    enGB      = "Englisch";
    frFR      = "Französisch";
    deDE      = "Deutsch";
    ruRU      = "Russisch";
    zhTW      = "Traditionelles Chinesisch";
    ptBR      = "Portugiesisch";
    
    -- Frame Strings
    Confirm     = "Bestätigen";
    Cancel      = "Abbrechen";
    RemoveUnused    = "Ungenutzte Lokals aus Speicher entfernen.";
    SelectPreferred   = "Bevorzugte Lokalisierung ausw\195\164hlen:";
    AvailLangs    = "Verf\195\188gbare Sprachen";

    --Earth Button
    Localization    = "Lokalisierung";
    ShowPrompt    = "Auswahlfenster";
    EarthTooltip    = "Auswahlfenster f\195\188r verf\195\188gbare Lokalisierungen anzeigen."
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("deDE", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Suche nach Artikeln, welche Pawn hält ein Upgrade";
    OPTIONS           = "Optionen:";
    HELP_ID           = "Pawn Sucher";
    HELP_QUESTION     = "Was bedeutet diese Suchenden tun?";
    HELP_ANSWER       = "Dieser Sucher verwenden eine Skala, die in der Pawn addon definiert wurde, um Upgrades für Ihre aktuell Ausrüstung zu finden.";
    CONFIG_HEADER     = "Pawn Search Criteria";
    SCALE_SELECT      = "Pawn scale";
    SCALE_SELECT_TIP  = "The Pawn Skala, die verwendet werden, um die Position zu bestimmen werden";
    USEABLE_ONLY      = "Verwendbare Produkte nur";
    USEABLE_ONLY_TIP  = "Nur Elemente, die Ihr Charakter benutzen kann.";
    AFFORD_ONLY       = "Nur das, was ich mir leisten kann";
    AFFORD_ONLY_TIP   = "Nur was man derzeit leisten, zu kaufen.";
    USE_BUYOUT        = "Verwenden Buyout";
    USE_BUYOUT_TIP    = "Verwenden Buyout statt Geld bei der Überprüfung Auktionspreise.";
    USE_BESTPRICE        = "Passen Punktzahl basierend auf Preis.";
    USE_BESTPRICE_TIP    = "Passen Sie die Punktzahl durch die Preis des Artikels zurück. Ähnliche Artikel, wird das billigere Produkt höher sein auf der Liste.";
    USE_UNENCHANTED     = "Verwenden Unenchanted Werte";
    USE_UNENCHANTED_TIP = "Verwenden unenchanted Werte für Berechnungen. Falls nicht, wird Einzelteil Werte sind aktuelle Verzauberungen.";
    FORCE2H_WEAP      = "Nur Zweihandwaffen";
    FORCE2H_TIP       = "Beim Vergleich Waffen, berücksichtigen nur Zweihandwaffen.";
    INCLUDE_IN_SEARCH = "Fügen Sie diese Slots bei der Suche:";
    SHOW_HEAD         = "Kopf";
    SHOW_NECK         = "Hals";
    SHOW_SHOULDER     = "Schulter";
    SHOW_BACK         = "Rücken";
    SHOW_CHEST        = "Brust";
    SHOW_WRIST        = "Handgelenke";
    SHOW_HANDS        = "Hände";
    SHOW_WAIST        = "Taille";
    SHOW_LEGS         = "Beine";
    SHOW_FEET         = "Füße";
    SHOW_FINGER       = "Finger";
    SHOW_TRINKET      = "Schmuck";
    SHOW_WEAPON       = "Waffe";
    SHOW_OFFHAND      = "Schildhand";
    SHOW_RANGED       = "Distanz";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "Bei der Suche nach Rüstung, zeigen nur die ausgewählten Panzerung in den Suchergebnissen. Filtern Sie alle anderen Rüstungen.";
    ARMOR_PREFERENCE = "Rüstung Vorlieben";
    NO_PREF   = "Keine Präferenz";
    CLOTH     = "Stoff";
    LEATHER   = "Leder";
    MAIL      = "Kette";
    PLATE     = "Platte";

    --Item Types
    ARMOR   = "Armor";
    TOTEMS  = "Totems";
    LIBRAMS = "Buchbände";
    IDOLS   = "Götzen";
    SIGILS  = "Sigils";
    SHIELDS = "Schilde";
    MISC    = "Verschiedenes";

    -- Two Handed sub-string
    TWOHAND = "Zweihändig";
    
    -- Two Handed Weapons
    STAVES = "Stäbe";
    POLEARMS = "Stangenwaffen";
    -- CROSSBOWS
    -- GUNS
    -- BOWS

    -- Ranged
    DAGGERS = "Dolche";
    BOWS = "Bögen";
    GUNS = "Schusswaffen";
    WANDS = "Zauberstäbe";
    CROSSBOWS = "Armbrüste";
    THROWN = "Wurfwaffe"; -- may be removed

    -- Messages
    BAD_SCALE   = "Please select a valid scale.";
    NOT_WANTED  = "Artikel Steckplatz nicht wollte";
    NOT_UPGRADE = "Pawn-Wert zu niedrig ist.";

    REASON_BUY = "kaufen";
    REASON_BID = "bid";
  },
nil, true) -- Protected
