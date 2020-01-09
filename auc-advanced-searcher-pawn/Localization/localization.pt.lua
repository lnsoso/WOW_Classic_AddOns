-- English text strings

Localization.RegisterAddonStrings("ptBR", "Localization",
  {
    -- Locales
    enUS      = "Inglês Americano";
    enGB      = "Inglês Europeu";
    frFR      = "Francês";
    deDE      = "Alemão";
    ruRU      = "Russo";
    zhTW      = "Chinês Tradicional";
    ptBR      = "Português";

    -- Frame Strings
    Confirm         = "Confirmar";
    Cancel          = "Cancelar";
    RemoveUnused    = "Remover da memoria localizações não usadas.";
    SelectPreferred = "Seleccione o idioma preferido:";
    AvailLangs      = "Idiomas disponíveis";

    --Earth Button
    Localization  = "Localização";
    ShowPrompt    = "Mostrar aviso";
    EarthTooltip  = "Mostrar dialogo de selecção local."
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("ptBR", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "Procurar por itens que o Pawn considera um upgrade";
    OPTIONS           = "Opções:";
    HELP_ID           = "Pesquisador do Pawn";
    HELP_QUESTION     = "O que faz este pesquisador?";
    HELP_ANSWER       = "Esta procura irá usar a escala que foi definida no addon Pawn para localizar upgrades para o equipamento que tem equipado.";
    CONFIG_HEADER     = "Critérios de procura do Pawn";
    SCALE_SELECT      = "Escala do Pawn";
    SCALE_SELECT_TIP  = "A escala do Pawn que vai ser usada para determinar o valor do item";
    USEABLE_ONLY      = "Apenas itens que possa usar";
    USEABLE_ONLY_TIP  = "Apenas itens que o seu personagem possa usar.";
    AFFORD_ONLY       = "Apenas o que consigo comprar";
    AFFORD_ONLY_TIP   = "Mostra apenas o que consegue comprar de momento com o dinheiro disponível.";
    USE_BUYOUT        = "Usar Arremate";
    USE_BUYOUT_TIP    = "Usar Arremate em vez de Dar lance quando verificar os preços dos leilões.";
    USE_BESTPRICE     = "Ajustar o valor baseado no preço.";
    USE_BESTPRICE_TIP = "Ajustar pelo preço do item o valor mostrado. Para itens similares, o mais barato ficará acima na lista.";
    USE_UNENCHANTED     = "Usar valores Unenchanted";
    USE_UNENCHANTED_TIP = "Use valores unenchanted para cálculos. Se não for marcada, os valores de itens inclui encantamentos atuais.";
    FORCE2H_WEAP      = "Apenas de 2M";
    FORCE2H_TIP       = "Ao comparar armas, considerar apenas Armas de Duas mãos";
    INCLUDE_IN_SEARCH = "Incluir estes compartimentos ao procurar:";
    SHOW_HEAD         = "Cabeça";
    SHOW_NECK         = "Pescoço";
    SHOW_SHOULDER     = "Ombro";
    SHOW_BACK         = "Costas";
    SHOW_CHEST        = "Torso";
    SHOW_WRIST        = "Pulsos";
    SHOW_HANDS        = "Mãos";
    SHOW_WAIST        = "Cintura";
    SHOW_LEGS         = "Pernas";
    SHOW_FEET         = "Pés";
    SHOW_FINGER       = "Dedo";
    SHOW_TRINKET      = "Berloque";
    SHOW_WEAPON       = "Arma";
    SHOW_OFFHAND      = "Mão secundária";
    SHOW_RANGED       = "Longo alcance";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "Ao procurar por armadura, apenas mostrar o tipo de armadura selecionada em resultados de pesquisa. Filtrar todos os tipos de armaduras outros.";
    ARMOR_PREFERENCE = "Preferência de Armadura";
    NO_PREF   = "Nenhuma Preferência";
    CLOTH     = "Tecido";
    LEATHER   = "Couro";
    MAIL      = "Malha";
    PLATE     = "Placas";

    --Item Types
    ARMOR   = "Armadura";
    TOTEMS  = "Totens";
    LIBRAMS = "Incunábulos";
    IDOLS   = "Ídolos";
    SIGILS  = "Signos";
    SHIELDS = "Escudos";
    MISC    = "Diversos";

    -- Two Handed sub-string
    TWOHAND = "Duas Mãos";
    
    -- Two Handed Weapons
    STAVES = "Cajados";
    POLEARMS = "Armas de Haste";
    -- CROSSBOWS
    -- GUNS
    -- BOWS
    
    -- Ranged
    DAGGERS = "Adagas";
    BOWS = "Arcos";
    GUNS = "Armas de fogo";
    WANDS = "Varinhas";
    CROSSBOWS = "Bestas";
    THROWN = "Arremesso"; -- may be removed

    -- Messages
    BAD_SCALE   = "Por favor seleccione uma escala válida.";
    NOT_WANTED  = "Compartimento de item não incluído";
    NOT_UPGRADE = "O valor do Pawn é muito baixo.";

    REASON_BUY = "comprar";
    REASON_BID = "lance";
  },
nil, true) -- Protected
