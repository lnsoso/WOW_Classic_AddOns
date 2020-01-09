-- English text strings

Localization.RegisterAddonStrings("zhCN", "Localization",
  {
    -- Locales
    enUS      = "英文";
    enGB      = "英语";
    frFR      = "法式";
    ruRU      = "俄语";
    zhTW      = "中国传统";
    deDE      = "德语";
    ptBR      = "葡萄牙语";

    -- Frame Strings
    Confirm         = "确认";
    Cancel          = "取消";
    RemoveUnused    = "从内存中删除未使用的语言环境。";
    SelectPreferred = "选择一个首选的本地化：";
    AvailLangs      = "可用语言";

    --Earth Button
    Localization  = "本土化";
    ShowPrompt    = "显示提示";
    EarthTooltip  = "显示语言环境选择对话。";
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("zhCN", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "搜索项目的的Pawn认为升级";
    OPTIONS           = "选项：";
    HELP_ID           = "的Pawn搜索器";
    HELP_QUESTION     = "搜索做什么？";
    HELP_ANSWER       = "搜索将使用已被定义在Pawn插件的规模，定位升级当前装备的物品。";
    CONFIG_HEADER     = "的Pawn搜索条件";
    SCALE_SELECT      = "的Pawn规模";
    SCALE_SELECT_TIP  = "了Pawn的规模将用于确定项目的价值";
    USEABLE_ONLY      = "可用的项目";
    USEABLE_ONLY_TIP  = "只有你的角色可以使用的项目。";
    AFFORD_ONLY       = "只有我能买得起什么";
    AFFORD_ONLY_TIP   = "只显示你目前能买得起。";
    USE_BUYOUT        = "使用买断";
    USE_BUYOUT_TIP    = "检查时，拍卖价格，而不是使用收购出价。";
    USE_BESTPRICE        = "调整价格的基础上的得分。";
    USE_BESTPRICE_TIP    = "返回该项目的价格调整得分。对于类似的项目，更便宜的项目将名单上的高。";
    USE_UNENCHANTED     = "使用未附魔值";
    USE_UNENCHANTED_TIP = "使用未附魔的计算值。如果没有选中项的值将包括当前的结界。";
    FORCE2H_WEAP      = "只有两个双手武器。";
    FORCE2H_TIP       = "比较武器时，只考虑两双手武器。";
    INCLUDE_IN_SEARCH = "在搜索时，包括这些插槽：";
    SHOW_HEAD         = "头部";
    SHOW_NECK         = "颈部";
    SHOW_SHOULDER     = "肩部";
    SHOW_BACK         = "背部";
    SHOW_CHEST        = "胸部";
    SHOW_WRIST        = "手腕";
    SHOW_HANDS        = "手";
    SHOW_WAIST        = "腰部";
    SHOW_LEGS         = "腿部";
    SHOW_FEET         = "脚";
    SHOW_FINGER       = "指";
    SHOW_TRINKET      = "饰品";
    SHOW_WEAPON       = "武器";
    SHOW_OFFHAND      = "副手";
    SHOW_RANGED       = "远程";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "寻找装甲时，在搜索结果中只显示所选的护甲类型。过滤掉所有其他的装甲类型。";
    ARMOR_PREFERENCE = "护甲偏好";
    NO_PREF   = "无特别偏好";
    CLOTH     = "布甲";
    LEATHER   = "皮甲";
    MAIL      = "锁甲";
    PLATE     = "板甲";

    --Item Types
    ARMOR   = "护甲";
    TOTEMS  = "图腾";
    LIBRAMS = "圣契";
    IDOLS   = "神像";
    SIGILS  = "魔印";
    SHIELDS = "盾牌";
    MISC    = "其它";

    --Two Handed sub-string
    TWOHAND = "双手";
    
    -- Two Handed Weapons
    STAVES = "法杖";
    POLEARMS = "长柄武器";
    -- CROSSBOWS
    -- GUNS
    -- BOWS

    -- Ranged
    DAGGERS = "匕首";
    BOWS = "弓";
    GUNS = "枪械";
    WANDS = "魔杖";
    CROSSBOWS = "弩";
    THROWN = "投掷武器"; -- may be removed

    -- Messages
    BAD_SCALE   = "请选择一个有效的规模。";
    NOT_WANTED  = "不想要的物品槽";
    NOT_UPGRADE = "的Pawn值太低。";

    REASON_BUY = "买";
    REASON_BID = "出价";
  },
nil, true) -- Protected
