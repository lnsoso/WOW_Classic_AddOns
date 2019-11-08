-- English text strings

Localization.RegisterAddonStrings("itIT", "Localization",
  {
    -- Locales
    enUS      = "Inglese";
    enGB      = "Inglese";
    frFR      = "Francese";
    ruRU      = "Russo";
    zhTW      = "Cinese tradizionale";
    deDE      = "Tedesco";
    ptBR      = "Portoghese";

    -- Frame Strings
    Confirm         = "Confirm";
    Cancel          = "Cancel";
    RemoveUnused    = "Rimuovere locali non utilizzati dalla memoria.";
    SelectPreferred = "Selezionare una localizzazione preferita:";
    AvailLangs      = "Lingue disponibili";

    --Earth Button
    Localization  = "Localization";
    ShowPrompt    = "Show Prompt";
    EarthTooltip  = "Mostra selezione dialogo Locale.";
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("itIT", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Cerca articoli che Pawn considera un aggiornamento";
    OPTIONS           = "Opzioni:";
    HELP_ID           = "Pawn Searcher";
    HELP_QUESTION     = "Che cosa fa questo ricercatore fare?";
    HELP_ANSWER       = "Questo ricercatore utilizza una scala che è stato definito nel addon Pawn per individuare gli aggiornamenti per i vostri elementi attualmente attrezzate.";
    CONFIG_HEADER     = "Pawn Criteri di ricerca";
    SCALE_SELECT      = "Pawn scala";
    SCALE_SELECT_TIP  = "La scala Pawn che verrà utilizzato per determinare il valore dell'elemento";
    USEABLE_ONLY      = "Oggetti utilizzabili solo";
    USEABLE_ONLY_TIP  = "Solo gli elementi che il tuo personaggio può utilizzare.";
    AFFORD_ONLY       = "Solo quello che mi posso permettere";
    AFFORD_ONLY_TIP   = "Mostra solo ciò che si può attualmente permettersi di acquistare.";
    USE_BUYOUT        = "Utilizzare buyout";
    USE_BUYOUT_TIP    = "Uso buyout invece di offerta quando il controllo dei prezzi d'asta.";
    USE_BESTPRICE        = "Regolare punteggio in base al prezzo.";
    USE_BESTPRICE_TIP    = "Regolare il punteggio restituito dal prezzo del prodotto. Articoli simili, l'elemento più economico sarà più alto nella lista.";
    USE_UNENCHANTED     = "Utilizzare valori Unenchanted";
    USE_UNENCHANTED_TIP = "Utilizzare i valori unenchanted per i calcoli. Se non è selezionato, i valori voce include incantesimi attuali.";
    FORCE2H_WEAP      = "Solo armi a due mani.";
    FORCE2H_TIP       = "Quando si confrontano le armi, in considerazione solo armi a due mani.";
    INCLUDE_IN_SEARCH = "Includere questi slot per la ricerca:";
    SHOW_HEAD         = "Testa";
    SHOW_NECK         = "Collo";
    SHOW_SHOULDER     = "Spalle";
    SHOW_BACK         = "Schiena";
    SHOW_CHEST        = "Torso";
    SHOW_WRIST        = "Polsi";
    SHOW_HANDS        = "Mani";
    SHOW_WAIST        = "Cintura";
    SHOW_LEGS         = "Gambe";
    SHOW_FEET         = "Piedi";
    SHOW_FINGER       = "Dito";
    SHOW_TRINKET      = "Orecchino";
    SHOW_WEAPON       = "Arma";
    SHOW_OFFHAND      = "Mano Secondaria";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "Durante la ricerca di armi, mostra solo il tipo selezionato armatura nei risultati di ricerca. Filtra tutti i tipi di armature altri.";
    ARMOR_PREFERENCE = "Armatura Preferenze";
    NO_PREF   = "Nessuna preferenza";
    CLOTH     = "Stoffa";
    LEATHER   = "Cuoio";
    MAIL      = "Maglia";
    PLATE     = "Piastre";

    --Item Types
    ARMOR   = "Armatura";
    TOTEMS  = "Totems";
    LIBRAMS = "Tomi";
    IDOLS   = "Idoli";
    SIGILS  = "Sigilli";
    SHIELDS = "Scudi";
    MISC    = "Varie";

    -- Two Handed sub-string
    TWOHAND = "a Due Mani";
    
    -- Two-Handed Weapons
    STAVES = "Bastoni";
    POLEARMS = "Armi ad Asta";
    -- CROSSBOWS
    -- GUNS
    -- BOWS

    -- Ranged
    DAGGERS = "Pugnali";
    BOWS = "Archi";
    GUNS = "Armi da fuoco";
    WANDS = "Bacchette";
    CROSSBOWS = "Balestre";
    THROWN = "da Lancio"; -- may be removed

    -- Messages
    BAD_SCALE   = "Please select a valid scale.";
    NOT_WANTED  = "Slot Articolo non voluto";
    NOT_UPGRADE = "Pawn valore è troppo basso.";

    REASON_BUY = "acquistare";
    REASON_BID = "offrire";
  },
nil, true) -- Protected
