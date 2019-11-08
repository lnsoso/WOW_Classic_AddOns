-- English text strings

Localization.RegisterAddonStrings("esMX", "Localization",
  {
    -- Locales
    enUS      = "Inglés";
    enGB      = "Inglés";
    frFR      = "Francés";
    ruRU      = "Ruso";
    zhTW      = "Chino Tradicional";
    deDE      = "Alemán";
    ptBR      = "Portugués";

    -- Frame Strings
    Confirm         = "Confirmar";
    Cancel          = "Cancelar";
    RemoveUnused    = "Retire locales no utilizados de la memoria.";
    SelectPreferred = "Seleccione una localización preferida:";
    AvailLangs      = "Idiomas disponibles";

    --Earth Button
    Localization  = "Localización";
    ShowPrompt    = "Mostrar Preguntar";
    EarthTooltip  = "Mostrar el diálogo de configuración regional de Selección.";
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("esMX", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Buscar elementos que Pawn considera una actualización";
    OPTIONS           = "Opciones:";
    HELP_ID           = "Buscador Pawn";
    HELP_QUESTION     = "¿Qué significa este buscador a hacer?";
    HELP_ANSWER       = "Este buscador utilizará una escala que ha sido definido en el addon Pawn para localizar actualizaciones de tus items equipados.";
    CONFIG_HEADER     = "Criterios de búsqueda Pawn";
    SCALE_SELECT      = "Pawn escala";
    SCALE_SELECT_TIP  = "La escala Pawn que se utiliza para determinar el valor del elemento";
    USEABLE_ONLY      = "Artículos utilizables sólo";
    USEABLE_ONLY_TIP  = "Sólo los elementos que tu personaje puede utilizar.";
    AFFORD_ONLY       = "Sólo lo que me puedo permitir";
    AFFORD_ONLY_TIP   = "Sólo muestra lo que actualmente puede permitirse el lujo de comprar.";
    USE_BUYOUT        = "Utilice compra";
    USE_BUYOUT_TIP    = "Utilice compra en lugar de la oferta al comprobar los precios de subasta.";
    USE_BESTPRICE        = "Ajuste puntuación basada en el precio.";
    USE_BESTPRICE_TIP    = "Ajustar la puntuación devuelta por el precio del artículo. Para elementos similares, el material más barato será más alta en la lista.";
    USE_UNENCHANTED     = "Utilice valores sin encantamientos";
    USE_UNENCHANTED_TIP = "Utilice valores sin encantamientos para los cálculos. Si no se marca, valores de los elementos se incluyen encantamientos actuales.";
    FORCE2H_WEAP      = "Sólo armas a dos manos.";
    FORCE2H_TIP       = "Al comparar las armas, sólo se consideran armas a dos manos.";
    INCLUDE_IN_SEARCH = "Incluya estas ranuras al buscar:";
    SHOW_HEAD         = "Cabeza";
    SHOW_NECK         = "Cuello";
    SHOW_SHOULDER     = "Hombros";
    SHOW_BACK         = "Espalda";
    SHOW_CHEST        = "Torso";
    SHOW_WRIST        = "Muñeca";
    SHOW_HANDS        = "Manos";
    SHOW_WAIST        = "Cintura";
    SHOW_LEGS         = "Piernas";
    SHOW_FEET         = "Pies";
    SHOW_FINGER       = "Dedo";
    SHOW_TRINKET      = "Abalorio";
    SHOW_WEAPON       = "Arma";
    SHOW_OFFHAND      = "Mano Izquierda";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "Durante la búsqueda de armas, sólo muestran el tipo de armadura seleccionada en los resultados de búsqueda. Filtrar todos los tipos de armadura otros.";
    ARMOR_PREFERENCE = "Armadura de Preferencia";
    NO_PREF   = "No tengo preferencias";
    CLOTH     = "Tela";
    LEATHER   = "Cuero";
    MAIL      = "Mallas";
    PLATE     = "Placas";

    --Item Types
    ARMOR   = "Armadura";
    TOTEMS  = "Tótems";
    LIBRAMS = "Tratados";
    IDOLS   = "Ãdolos";
    SIGILS  = "Sigilos";
    SHIELDS = "Escudos";
    MISC    = "Miscelánea";

    -- Two Handed sub-string
    TWOHAND = "Dos Manos";
    
    -- Two Handed Weapons
    STAVES = "Bastones";
    POLEARMS = "Armas de asta";
    -- CROSSBOWS
    -- GUNS
    -- BOWS

    -- Ranged
    DAGGERS = "Dagas";
    BOWS = "Arcos";
    GUNS = "Pistolas";
    WANDS = "Varitas";
    CROSSBOWS = "Ballestas";
    THROWN = "Arrojadiza"; -- may be removed

    -- Messages
    BAD_SCALE   = "Por favor, seleccione una escala válida.";
    NOT_WANTED  = "Espacio de objeto no quería";
    NOT_UPGRADE = "Pawn valor es demasiado bajo.";

    REASON_BUY = "comprar";
    REASON_BID = "ofrecer";
  },
nil, true) -- Protected
