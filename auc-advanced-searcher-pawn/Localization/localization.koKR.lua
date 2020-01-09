-- English text strings

Localization.RegisterAddonStrings("koKR", "Localization",
  {
    -- Locales
    enUS      = "영국 사람";
    enGB      = "영국 사람";
    frFR      = "프랑스 사람";
    ruRU      = "러시아인";
    zhTW      = "중국어 번체";
    deDE      = "독일 사람";
    ptBR      = "포르투갈 어";

    -- Frame Strings
    Confirm         = "확인하다";
    Cancel          = "취소하다";
    RemoveUnused    = "메모리에서 사용하지 않는 로케일을 제거합니다.";
    SelectPreferred = "선호하는 현지화를 선택 :";
    AvailLangs      = "이용 가능한 언어";

    --Earth Button
    Localization  = "현지화";
    ShowPrompt    = "프롬프트 표시";
    EarthTooltip  = "언어 선택 대화를 표시합니다.";
  },
nil, true) -- Protected

Localization.RegisterAddonStrings("koKR", "Auc-Searcher-Pawn",
  {
    -- Config
    MAIN_TITLE        = "업그레이드를 고려하는 폰 상품을 검색";
    OPTIONS           = "옵션 :";
    HELP_ID           = "전당포 검색 자";
    HELP_QUESTION     = "이 검색자가 어떤 역할을합니까?";
    HELP_ANSWER       = "이 검색자가 귀하의 현재 시설 항목에 대한 업그레이드를 찾습니다 폰의 부가에 정의 된 크기를 사용합니다.";
    CONFIG_HEADER     = "전당포 검색 조건";
    SCALE_SELECT      = "담보 규모";
    SCALE_SELECT_TIP  = "항목 값을 결정하는 데 사용됩니다 폰 규모";
    USEABLE_ONLY      = "사용 가능한 항목 만";
    USEABLE_ONLY_TIP  = "당신의 캐릭터가 사용할 수있는 항목 만.";
    AFFORD_ONLY       = "만, 여유가 수";
    AFFORD_ONLY_TIP   = "당신이 현재 무엇을 살것인지를 보여 줍니다.";
    USE_BUYOUT        = "인수를 사용하여";
    USE_BUYOUT_TIP    = "경매 가격을 확인할 때 인수 대신 입찰가를 사용합니다.";
    USE_BESTPRICE        = "가격을 기준으로 점수를 조정합니다.";
    USE_BESTPRICE_TIP    = "항목의 가격에 의해 반환 된 점수를 조정합니다. 유사한 항목은 저렴 항목은 목록에서 높을 것입니다.";
    USE_UNENCHANTED     = "Unenchanted 값을 사용";
    USE_UNENCHANTED_TIP = "계산에 대한 unenchanted 값을 사용합니다. 선택하지 않으면 항목 값은 현재 enchantments 포함됩니다.";
    FORCE2H_WEAP      = "만 양손 무기";
    FORCE2H_TIP       = "무기를 비교했을 때 만 양손 무기를 고려합니다.";
    INCLUDE_IN_SEARCH = "검색 할 때 다음 슬롯을 포함 :";
    SHOW_HEAD         = "머리";
    SHOW_NECK         = "목";
    SHOW_SHOULDER     = "어깨";
    SHOW_BACK         = "등";
    SHOW_CHEST        = "가슴";
    SHOW_WRIST        = "손목";
    SHOW_HANDS        = "손";
    SHOW_WAIST        = "허리";
    SHOW_LEGS         = "다리";
    SHOW_FEET         = "발";
    SHOW_FINGER       = "손가락";
    SHOW_TRINKET      = "장신구";
    SHOW_WEAPON       = "무기";
    SHOW_OFFHAND      = "보조장비";
    SHOW_RANGED       = "원거리 장비";

    --Armor Preference
    ARMORPREF_SELECT_TIP = "갑옷을 검색하면 검색 결과에서 선택한 갑옷 유형을 보여줍니다. 다른 모든 갑옷 유형을 필터링 할 수 있습니다.";
    ARMOR_PREFERENCE = "갑옷 환경 설정";
    NO_PREF   = "어떤 환경 설정 없음";
    CLOTH     = "천";
    LEATHER   = "가죽";
    MAIL      = "사슬";
    PLATE     = "판금";

    --Item Types
    ARMOR   = "방어구";
    TOTEMS  = "토템";
    LIBRAMS = "성서";
    IDOLS   = "우상";
    SIGILS  = "인장";
    SHIELDS = "방패";
    MISC    = "기타";

    -- Two Handed sub-string
    TWOHAND = "양손"; 
    
    -- Two Handed Weapons
    STAVES = "지팡이류";
    POLEARMS = "장창류";
    -- CROSSBOWS
    -- GUNS
    -- BOWS

    -- Ranged
    BOWS = "활류";
    GUNS = "총기류";
    WANDS = "마법봉류";
    CROSSBOWS = "석궁류";
    THROWN = "투척 무기"; -- may be removed

    -- Messages
    BAD_SCALE   = "유효한 규모를 선택하십시오.";
    NOT_WANTED  = "항목 슬롯 원하지 않는";
    NOT_UPGRADE = "담보 값이 너무 낮습니다.";

    REASON_BUY = "사다";
    REASON_BID = "매기다";
  },
nil, true) -- Protected
