-- Traditional Chinese Strings

Localization.RegisterAddonStrings("zhTW", "Localization",
  {
    -- Locales
	enUS = "英語";
	enGB = "英語";
	frFR = "法語";
	ruRU = "俄語";
	zhTW = "中國傳統"; -- Requires localization
    deDE = "德語";
    ptBR = "葡萄牙";

    -- Frame Strings
    Cancel = "取消";
	Confirm = "確認";
	SelectPreferred = "選擇一個首選本地語言:";
	RemoveUnused = "從內存中移除不使用的語言.";
	AvailLangs = "可用的語言";

    --Earth Button
	Localization = "本地化";
	ShowPrompt = "顯示提示";
	EarthTooltip = "顯示本地選擇框體.";
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("zhTW", "Auc-Searcher-Pawn",
  {
    -- Config
	MAIN_TITLE = "查詢Pawn判定的提升物品";
	OPTIONS = "選項:";
    HELP_ID = "Pawn搜索器";
	HELP_QUESTION = "這個搜索器用來幹什麼的?";
    HELP_ANSWER = "這個搜索器將通過使用在Pawn插件中已被定義的比例,來為你當前已裝備的物品找出升級替代品.";
	CONFIG_HEADER = "Pawn搜索判定標準";
	SCALE_SELECT = "Pawn 比例名稱";
	SCALE_SELECT_TIP = "此Pawn比例將被用來確定物品價值";
    USEABLE_ONLY = "僅可用物品";
	USEABLE_ONLY_TIP = "僅你的角色可用的物品.";
	AFFORD_ONLY = "僅我買得起的";
	AFFORD_ONLY_TIP = "只顯示你當前買得起的東西.";
	USE_BUYOUT = "使用買出價";
	USE_BUYOUT_TIP = "當選擇拍賣價格時使用買出價來替代競價.";
    USE_BESTPRICE = "調整價格的基礎上的得分。";
    USE_BESTPRICE_TIP = "返回該項目的價格調整得分。對於類似的項目，更便宜的項目將名單上的高。";
    USE_UNENCHANTED     = "使用未附魔值";
    USE_UNENCHANTED_TIP = "使用未附魔的計算值。如果沒有選中項的值將包括當前的結界。";
	FORCE2H_TIP = "當比較武器時,僅考慮雙手武器.";
	FORCE2H_WEAP = "僅雙手武器";
	INCLUDE_IN_SEARCH = "當搜索時包含這些位置:";
	SHOW_BACK = "背部";
	SHOW_CHEST = "胸部";
	SHOW_FEET = "腳部";
	SHOW_FINGER = "手指";
	SHOW_HANDS = "手部";
	SHOW_HEAD = "頭部";
	SHOW_LEGS = "腿部";
	SHOW_NECK = "頸部";
	SHOW_OFFHAND = "副手";
	SHOW_SHOULDER = "肩部";
	SHOW_TRINKET = "飾品";
	SHOW_WAIST = "腰部";
	SHOW_WEAPON = "武器";
	SHOW_WRIST = "手腕";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "尋找裝甲時，在搜索結果中只顯示所選的護甲類型。過濾掉所有其他的裝甲類型。";
    ARMOR_PREFERENCE = "護甲偏好";
    NO_PREF   = "無特別偏好";
    CLOTH     = "布甲";
    LEATHER   = "皮甲";
    MAIL      = "鎖甲";
    PLATE     = "鎧甲";

    --Item Types
	ARMOR = "護甲";
	TOTEMS = "圖騰";
	LIBRAMS = "聖契";
	IDOLS = "神像";
	SIGILS = "符印";
    SHIELDS = "盾牌";
    MISC    = "其他";

	-- Two Handed sub-string
    TWOHAND = "雙手";
    
    -- Two Handed Weapons
	STAVES = "法杖";
    POLEARMS = "長柄武器";
    -- CROSSBOWS
    -- GUNS
    -- BOWS
	
    -- RANGED
    BOWS = "弓";
    GUNS = "槍械";
    WANDS = "魔杖";
    CROSSBOWS = "弩";
    THROWN = "投擲武器"; -- may be removed

    -- Messages
    BAD_SCALE = "請選擇一個有效的比例.";
    NOT_WANTED = "不需要的物品欄";
	NOT_UPGRADE = "Pawn數值太低.";

	REASON_BUY = "買";
	REASON_BID = "競價";
  },
nil, true) -- Protected
