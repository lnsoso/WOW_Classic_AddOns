-- French text strings
-- Last Update : 05/07/2006 ( By Sasmira )

Localization.RegisterAddonStrings("frFR", "Localization", 
  {
    -- Locales
    enUS      = "d'Angleterre";
    enGB      = "Anglais";
    frFR      = "Français";
    deDE      = "Allemand";
    ptBR      = "Portugais";
    zhTW      = "Chinois traditionnel";
    ruRU      = "Russe";
    
    -- Frame Strings
    Confirm     = "Confirmer";
    Cancel      = "Annuler";
    RemoveUnused  = "Supprimer de la m\195\169moire les variables inutilis\195\169es.";
    SelectPreferred = "Choisissez votre localisation pr\195\169f\195\169r\195\169e:";
    AvailLangs    = "Langages valides";
    EarthTooltip = "Voir le dialogue de sélection de paramètres régionaux.";
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("frFR", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Rechercher des articles Pawn qui considère une mise à niveau";
    OPTIONS           = "Options:";
    HELP_ID           = "Chercheur Pawn";
    HELP_QUESTION     = "Qu'est-ce chercheur faire?";
    HELP_ANSWER       = "Ce chercheur va utiliser une échelle qui a été défini dans l'addon Pawn pour localiser des améliorations pour vos objets actuellement équipés.";
    CONFIG_HEADER     = "Critères de recherche Pawn";
    SCALE_SELECT      = "Pawn graduation";
    SCALE_SELECT_TIP  = "La graduation Pawn qui sera utilisée pour déterminer la valeur de l'élément";
    USEABLE_ONLY      = "Articles utilisables uniquement";
    USEABLE_ONLY_TIP  = "Seuls les éléments que votre personnage peut utiliser.";
    AFFORD_ONLY       = "Seulement ce que je peux me permettre";
    AFFORD_ONLY_TIP   = "Seulement montrer ce que vous pouvez actuellement les moyens d'acheter.";
    USE_BUYOUT        = "Utilisez rachat";
    USE_BUYOUT_TIP    = "Utilisez rachat au lieu de l'offre lors de la vérification des prix aux enchères.";
    USE_BESTPRICE        = "Réglez score basé sur le prix.";
    USE_BESTPRICE_TIP    = "Réglez le score renvoyé par le prix de l'article. Rechercher des articles similaires, moins cher article sera élevé sur la liste.";
    USE_UNENCHANTED     = "Utiliser les valeurs non enchantés";
    USE_UNENCHANTED_TIP = "Utiliser les valeurs non enchantés pour les calculs. Si ce n'est pas cochée, les valeurs des éléments comprendront enchantements actuelles.";
    FORCE2H_WEAP      = "Seules les armes à deux mains";
    FORCE2H_TIP       = "Lorsque l'on compare les armes, ne considère armes à deux mains.";
    INCLUDE_IN_SEARCH = "Inclure ces emplacements lors de la recherche:";
    SHOW_HEAD         = "Tête";
    SHOW_NECK         = "Cou";
    SHOW_SHOULDER     = "Epaule";
    SHOW_BACK         = "Dos";
    SHOW_CHEST        = "Torse";
    SHOW_WRIST        = "Poignets";
    SHOW_HANDS        = "Mains";
    SHOW_WAIST        = "Taille";
    SHOW_LEGS         = "Jambes";
    SHOW_FEET         = "Pieds";
    SHOW_FINGER       = "Doigt";
    SHOW_TRINKET      = "Bijou";
    SHOW_WEAPON       = "Arme";
    SHOW_OFFHAND      = "Main gauche";
    SHOW_RANGED       = "À distance";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "Lors de la recherche d'armure, ne montrent que le type d'armure sélectionnée dans les résultats de recherche. Filtrer tous les autres types d'armures.";
    ARMOR_PREFERENCE = "Orientation Armure";
    NO_PREF   = "Indifférent";
    CLOTH     = "Tissu";
    LEATHER   = "Cuir";
    MAIL      = "Mailles";
    PLATE     = "Plaques";

    --Item Types
    ARMOR   = "Armure";
    TOTEMS  = "Totems";
    LIBRAMS = "Librams";
    IDOLS   = "Idoles";
    SIGILS  = "Glyphes";
    SHIELDS = "Boucliers";
    MISC    = "Divers";

    -- Two Handed sub-string
    TWOHAND = "Deux mains";
    
    -- Two Handed Weapons
    STAVES = "Bâtons";
    POLEARMS = "Armes d'hast";
    -- CROSSBOWS
    -- GUNS
    -- BOWS

    -- Ranged
    DAGGERS = "Dagues";
    BOWS = "Arcs";
    GUNS = "Fusils";
    WANDS = "Baguettes";
    CROSSBOWS = "Arbalètes";
    THROWN = "Armes de jets"; -- may be removed

    -- Messages
    BAD_SCALE   = "S'il vous plaît sélectionner un barème en vigueur.";
    NOT_WANTED  = "Fente article ne voulait pas.";
    NOT_UPGRADE = "Pawn valeur est trop faible.";

    REASON_BUY = "acheter";
    REASON_BID = "faire une offre";
  },
nil, true) -- Protected
