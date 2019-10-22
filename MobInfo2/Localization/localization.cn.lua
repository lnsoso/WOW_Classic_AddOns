--   
-- zhTW Chinese Traditional Localisation for MobInfo
--
-- created by 艾娜罗沙@奥妮克希亚
-- updated by Coppermurky@暗影之月
-- updated for v3.46 by Avai@亚雷戈斯
--

MI2_Locale = GetLocale()

if ( MI2_Locale == "zhCN" ) then

MI2_SpellSchools		= { ["奥术"]="ar", ["火焰"]="fi", ["冰霜"]="fr", ["暗影"]="sh", ["神圣"]="ho", ["自然"]="na" } 

MI_TXT_WELCOME			= "欢迎使用MobInfo！";
MI_DESCRIPTION			= "增加怪物的详细相关信息到提示讯息视窗，并且在目标状态栏显示估计的生命/法力资料。";
MI_TXT_GENERAL_OPTIONS		= "这个选项页面可控制 MobInfo 的主要功能. 其它的选项页面则是针对各个功能做进一步的设定."

MI_TXT_GOLD			= "金";
MI_TXT_SILVER			= "银";
MI_TXT_COPPER			= "铜";

MI_TXT_OPEN			= "开启"
MI_TXT_COMBINED			= "已合并等级："
MI_TXT_MOB_DB_SIZE		= "MobInfo数据库大小："
MI_TXT_HEALTH_DB_SIZE		= "生命力数据库大小："
MI_TXT_PLAYER_DB_SIZE		= "玩家生命力数据库大小："
MI_TXT_ITEM_DB_SIZE		= "物品数据库大小："
MI_TXT_CUR_TARGET		= "目前目标："
MI_TXT_MH_DISABLED		= "MobInfo 警告：发现MobHealth插件。本插件内建的MobHealth功能已停用，请删除独立的MobHealth插件，以启用本插件的全部功能。"
MI_TXT_MH_DISABLED2		= (MI_TXT_MH_DISABLED.."\n\n 单独停用MobHealth并不会失去资料。\n\n好处是：血量/魔法位置可调整，并可调整显示字体和大小")
MI_TXT_CLR_ALL_CONFIRM		= "你确认要执行以下删除动作吗？"
MI_TXT_SEARCH_LEVEL		= "怪物等级："
MI_TXT_SEARCH_MOBTYPE		= "怪物类型："
MI_TXT_SEARCH_LOOTS		= "怪物已拾取："
MI_TXT_TRIM_DOWN_CONFIRM	= "警告：这是一个直接永久性的资料删除动作。你真的想删除没有被选取到的那些资料吗？"
MI_TXT_CLAM_MEAT		= "蚌肉"
MI_TXT_SHOWING			= "显示列表："
MI_TXT_DROPPED_BY		= "掉落："
MI_TXT_IMMUNE			= "免疫:"
MI_TXT_RESIST			= "抵抗:"
MI_TXT_DEL_SEARCH_CONFIRM	= "你是否真的要自数据库中，删除搜寻结果中的%d笔怪物的资料？"
MI_TXT_WRONG_LOC		= "错误：MobInfo数据库的语系和WOW程序本身的语系不一致。在解决这问题之前，MobInfo数据库是没有用的。"
MI_TXT_WRONG_DBVER		= "错误：MobInfo数据库不兼容于目前的版本.\n\nMobInfo必须要先删除旧有的资料档案."
MI_TXT_PRICE			= "商人买入价"
MI_TXT_TOOLTIP_MOVE		= "要移动工具提示锚点\n只要利用鼠标拖拉的方式拉到你想要的位置即可."
MI_TXT_ITEMFILTER		= "拾取物品过滤"

MI2_CHAT_MOBRUNS		= "想要转身逃跑"
MI2_TXT_MOBRUNS			= "*逃跑*"

BINDING_HEADER_MI2HEADER	= "MobInfo"
BINDING_NAME_MI2CONFIG		= "开启MobInfo选项"

MI2_FRAME_TEXTS = {}
MI2_FRAME_TEXTS["MI2_FrmTooltipContent"]	= "怪物提示讯息内容"
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"]		= "怪物血量选项"
MI2_FRAME_TEXTS["MI2_FrmDatabaseOptions"]	= "数据库选项"
MI2_FRAME_TEXTS["MI2_FrmHealthValueOptions"]	= "生命力"
MI2_FRAME_TEXTS["MI2_FrmManaValueOptions"]	= "法力值"
MI2_FRAME_TEXTS["MI2_FrmSearchOptions"]		= "搜寻选项"
MI2_FRAME_TEXTS["MI2_FrmImportDatabase"]	= "汇入外部资料"
MI2_FRAME_TEXTS["MI2_FrmItemTooltip"]		= "物品提示讯息选项"
MI2_FRAME_TEXTS["MI2_FrmTooltipLayout"]		= "MobInfo工具提示模板"


---------------------------
-- Tooltip Options/Content
---------------------------

MI_TXT_HEALTH		= "生命力"
MI_HLP_HEALTH		= "显示生命力信息 (目前/最大)"
MI_TXT_MANA		= "法力值"
MI_HLP_MANA		= "显示法力/怒气/精力信息 (目前/最大)"
MI_TXT_KILLS		= "杀死数"
MI_HLP_KILLS		= "显示你杀死此怪的次数\n这个数目依照角色不同\n而分别储存"
MI_TXT_LOOTS		= "拾取次数"
MI_HLP_LOOTS		= "显示此怪舍取的次数"
MI_TXT_COINS		= "平均金钱掉落"
MI_HLP_COINS		= "显示此怪平均掉钱数\n此为显示舍取后平均所得到的金额\n(但不包括舍取时金额为0的次数)"
MI_TXT_ITEMVAL		= "平均物品价值"
MI_HLP_ITEMVAL		= "显示掉落物品的平均价值\n此为显示掉落物品的平均价值\n(但不包括物品价值为0的次数)"
MI_TXT_MOBVAL		= "怪物总价值"
MI_HLP_MOBVAL		= "显示此怪的平均总价值\n此为显示舍取后所得到的金额\n以及掉落物品的平均价值"
MI_TXT_XP		= "经验"
MI_HLP_XP		= "显示杀死此怪所得到的经验值.\n(不显示灰色怪物的经验值)"
MI_TXT_TO_LEVEL		= "升级还需..."
MI_HLP_TO_LEVEL		= "显示到升级前还需杀死多少与目前同样的怪物.\n(不显示灰色怪物的数目)"
MI_TXT_EMPTY_LOOTS	= "空舍取数"
MI_HLP_EMPTY_LOOTS	= "显示空尸数目 (数目/百分比)\n此为显示你舍取了多少内无宝物的\n空尸体数目"
MI_TXT_CLOTH_DROP	= "布料掉落"
MI_HLP_CLOTH_DROP	= "显示怪物掉落布料的信息"
MI_TXT_CLASS		= "职业"
MI_HLP_CLASS		= "显示怪物的职业"
MI_TXT_DAMAGE		= "伤害+DPS"
MI_HLP_DAMAGE		= "显示怪物所能造成的伤害 (最小/最大) 和 DPS (每秒伤害率)\n各个角色的伤害值以及DPS为分开储存.\n虽然DPS的更新会有些慢, 但会在每一次的战斗中\n都会进行计算"
MI_TXT_QUALITY		= "质量"
MI_OPT_QUALITY		= "掉落物品的质量"
MI_HLP_QUALITY		= "显示舍取质量的次数及百分比\n此设定为计算捡取的物品等级和次数\n如捡舍到空尸则不予计算.\n百分比则是显示每一种物品等级捡取的比率"
MI_TXT_LOCATION		= "地点: "
MI_HELP_LOCATION	= "显示怪物现身的地点\n要使用这个设定必需启用记录地点选项"
MI_TXT_LOWHEALTH	= "转身逃跑侦测"
MI_HELP_LOWHEALTH	= "侦测会转身逃跑的怪物\n这个侦测讯息将会以红字表示在工具提示内"
MI_TXT_RESISTS		= "抗性"
MI_OPT_RESISTS		= "抗性和免疫"
MI_HELP_RESISTS		= "依照怪物本身法术的能力来显示\n抗性和免疫的信息"
MI_TXT_ITEMLIST		= "基本舍取物品清单"
MI_HELP_ITEMLIST	= "显示基本舍取物品的名称及数量\n所谓基本舍取物品为除了布料或皮革以外的物品统称.\n要使用这个设定必需启用记录舍取物品选项"
MI_TXT_CLOTHSKIN	= "布料和皮革舍取"
MI_HELP_CLOTHSKIN	= "显示舍取的布料和皮革的名称及数量\n要使用这个设定必需启用记录舍取物品选项"
MI_TXT_IMMUN		= "免疫"
MI_HELP_IMMUN		= "侦测具有免疫的怪物"

--------------------
-- General Options
--------------------
MI2_OPTIONS = {};

MI2_OPTIONS["MI2_OptSaveBasicInfo"] = 
			{ text = "记录怪物并保存详细怪物信息"; 
			help = "此功能可让你启用或停用记录详细怪物的信息\n储存的记录可以用于显示在工具提示中, 或是\n用于MobInfo的搜寻工具里.\n并且你可以从这些资料得知物品掉落的信息.\n\n备注: 怪物生命力及法力的记录在此项停用时仍会进行." }

MI2_OPTIONS["MI2_OptShowMobInfo"] = 
			{ text = "在MobInfo工具提示显示怪物信息"; 
			help = "启用工具提示显示怪物信息.\n使用这个选项来设定你要在工具提示上显示\n哪些怪物资料." }

MI2_OPTIONS["MI2_OptUseGameTT"] = 
			{ text = "使用游戏工具提示替代MobInfo工具提示"; 
			help = "预设MobInfo使用自定的工具提示框架设定,\n启用此项来使用游戏内建工具提示以取代MobInfo工具提示框架设定." }

MI2_OPTIONS["MI2_OptShowItemInfo"] = 
			{ text = "在物品工具提示显示进阶信息"; 
			help = "启用这个选项将会在工具提示中显示物品信息.\n你可以在工具提示选项中你可以设定\n你要显示的信息项目."; }

MI2_OPTIONS["MI2_OptShowTargetInfo"] = 
			{ text = "在目标框架显示怪物信息 (生命力/法力/其它)"; 
			help = "在目标框架中显示目标的生命力/法力等等的数值.\n(只有在没有安装任何UnitFrame插件才有作用)\n你可以在目标选项页面中设定显示的位置." }

MI2_OPTIONS["MI2_OptShowMMButton"] = 
			{ text = "显示小地图按钮"; 
			help = "在小地图小显示/隐藏MobInfo按钮" }

MI2_OPTIONS["MI2_OptMMButtonPos"] = 
			{ text = "小地图按钮位置"; 
			help = "使用移动条变更MobInfo按钮在小地图上的位置" }


--------------------
-- Other Options
--------------------

MI2_OPTIONS["MI2_OptShowIGrey"] = 
			{ text = ""; 
			help = "在工具提示中显示灰色物品" }

MI2_OPTIONS["MI2_OptShowIWhite"] = 
			{ text = ""; 
			help = "在工具提示中显示白色物品" }

MI2_OPTIONS["MI2_OptShowIGreen"] = 
			{ text = ""; 
			help = "在工具提示中显示绿色物品" }

MI2_OPTIONS["MI2_OptShowIBlue"] = 
			{ text = ""; 
			help = "在工具提示中显示蓝色物品" }

MI2_OPTIONS["MI2_OptShowIPurple"] = 
			{ text = ""; 
			help = "在工具提示中显示紫色物品" }

MI2_OPTIONS["MI2_OptMouseTooltip"] = 
			{ text = "在鼠标上显示工具提示"; 
			help = "在鼠标上显示MobInfo的工具提示\n并且会随着鼠标而移动." }

MI2_OPTIONS["MI2_OptHideAnchor"] = 
			{ text = "隐藏工具提示锚点"; 
			help = "隐藏MobInfo工具提示上的'MI'锚点." }

MI2_OPTIONS["MI2_OptShowCombined"] = 
			{ text = "合并怪物信息"; 
			help = "在工具提示合并怪物等级信息." }

MI2_OPTIONS["MI2_OptSmallFont"] = 
			{ text = "使用小字体"; 
			help = "工具提示使用小字体" }

MI2_OPTIONS["MI2_OptTooltipMode"] = 
			{ text = "工具提示位置"; 
			help = "设定工具提示视窗的位置."; choice1 = "左上"; choice2 = "左下"; choice3 = "右上 "; choice4 = "右下"; choice5="Center Above"; choice6="Center Below" }

MI2_OPTIONS["MI2_OptCompactMode"] =
			{ text = "双列工具提示"; 
			help = "用双列工具提示视窗显示怪物信息.\n工具提示视窗会变得更宽\n但有一定的限制." }

MI2_OPTIONS["MI2_OptOtherTooltip"] =
			{ text = "关闭其它工具提示"; 
			help = "当工具提示显示怪物信息时关闭其它的提示讯息." }

MI2_OPTIONS["MI2_OptSearchMinLevel"] = 
			{ text = "最小"; 
			help = "搜寻怪物时的最小等级限制"; }

MI2_OPTIONS["MI2_OptSearchMaxLevel"] = 
			{ text = "最大"; 
			help = "搜寻怪物时的最大等级限制(必须< 66)"; }

MI2_OPTIONS["MI2_OptSearchNormal"] = 
			{ text = "普通"; 
			help = "在搜寻结果中包含普通怪物"; }

MI2_OPTIONS["MI2_OptSearchElite"] = 
			{ text = "精英"; 
			help = "在搜寻结果中包含精英怪"; }

MI2_OPTIONS["MI2_OptSearchBoss"] = 
			{ text = "首领"; 
			help = "在搜寻结果中包含首领级别的怪物"; }

MI2_OPTIONS["MI2_OptSearchMinLoots"] = 
			{ text = "最小"; 
			help = "搜寻结果中的怪物，必须「拾取其物品」过的最小次数"; }

MI2_OPTIONS["MI2_OptSearchMaxLoots"] = 
			{ text = "最大"; 
			help = "搜寻结果中的怪物，必须「拾取其物品」过的最小次数"; }

MI2_OPTIONS["MI2_OptSearchMobName"] = 
			{ text = "怪物名称"; 
			help = "想要搜寻的怪物的部分，或者完整名称"; 
			info = '空白时，不限制搜寻全部的物品。输入"*"搜寻全部物品'; }  

MI2_OPTIONS["MI2_OptSearchItemName"] = 
			{ text = "物品名称"; 
			help = "想要搜寻的物品部分或者完整名称";
			info = '空白时将会搜寻所有物品名称'; }	

MI2_OPTIONS["MI2_OptSortByValue"] = 
			{ text = "按数值分类"; 
			help = "分类搜寻结果按怪物值"; 
			info = '按你能够对怪物造成的伤害值，来寻找它们。'; }

MI2_OPTIONS["MI2_OptSortByItem"] = 
			{ text = "按物品数分类"; 
			help = "分类搜寻结果按物品数列表"; 
			info = '按怪物掉落指定物品的质量分类寻找到的怪物。'; }

MI2_OPTIONS["MI2_OptItemTooltip"] = 
			{ text = "物品信息栏显示掉落怪物"; 
			help = "在物品的提示信息中，显示掉落该物品的怪物名称"; 
			info = "在提示信息中显示可掉落鼠标所指物品的所有怪物。\n每行显示该怪物掉落的物品数量及占总数的百分比。" }

MI2_OPTIONS["MI2_OptShowItemPrice"] =
			{ text = "显示商店售价"; 
			help = "在物品的提示信息中，显示该物品的商店售出价格" }

MI2_OPTIONS["MI2_OptCombinedMode"] = 
			{ text = "整合相同怪物"; help = "对同样名字的怪物合并计算"; 
			info = "整合模式会合并计算相同名字，但不同等级的怪物。\n启用后将使得不同等级但是同一名字的怪物，其资料显示一致。" }

MI2_OPTIONS["MI2_OptKeypressMode"] = 
			{ text = "按住ALT显示怪物信息"; 
			help = "只有按下ALT才会在提示框显示怪物信息"; }

MI2_OPTIONS["MI2_OptItemFilter"] = 
			{ text = ""; 
			help = "设置提示信息里显示的拾取物品的过滤条件";
			info = "只在提示信息中显示那些包含过滤文本的物品。\n例如输入'布'将只显示物品名称包含'布'的物品。\n不输入任何文字查看所有物品。" }

MI2_OPTIONS["MI2_OptSavePlayerHp"] = 
			{ text = "永久储存玩家生命力"; 
			help = "永久储存在PVP战斗中获得的玩家生命力资料。";
			info = "一般情况下PVP战斗结束\n后玩家生命力资料将被丢弃，这\n个选项允许你记录该资料。" }

MI2_OPTIONS["MI2_OptAllOn"] = 
			{ text = "显示全开"; 
			help = "将所有的显示选项打开"; }

MI2_OPTIONS["MI2_OptAllOff"] = 
			{ text = "显示全关"; 
			help = "将所有的显示选项关闭"; }

MI2_OPTIONS["MI2_OptDefault"] = 
			{ text = "预设"; 
			help = "显示预设的怪物信息"; }

MI2_OPTIONS["MI2_OptBtnDone"] = 
			{ text = "完成"; 
			help = "关闭 MobInfo 选项对话方块"; }

MI2_OPTIONS["MI2_OptTargetHealth"] = 
			{ text = "显示生命力"; 
			help = "在目标框显示生命力"; }

MI2_OPTIONS["MI2_OptTargetMana"] = 
			{ text = "显示法力值"; 
			help = "在目标框显示法力值"; }

MI2_OPTIONS["MI2_OptHealthPercent"] = 
			{ text = "显示百分比"; 
			help = "在目标框显示生命力百分比"; }

MI2_OPTIONS["MI2_OptManaPercent"] = 
			{ text = "显示百分比"; 
			help = "在目标框显示法力值百分比"; }

MI2_OPTIONS["MI2_OptHealthPosX"] = 
			{ text = "水平位置"; 
			help = "调整生命力的水平位置"; }

MI2_OPTIONS["MI2_OptHealthPosY"] = 
			{ text = "垂直位置"; 
			help = "调整生命力的垂直位置"; }

MI2_OPTIONS["MI2_OptManaPosX"] = 
			{ text = "水平位置"; 
			help = "调整法力值的水平位置"; }

MI2_OPTIONS["MI2_OptManaPosY"] = 
			{ text = "垂直位置"; 
			help = "调整法力值的垂直位置"; }

MI2_OPTIONS["MI2_OptTargetFont"] = 
			{ text = "字体"; 
			help = "设定生命/法力值的显示字体";
			choice1= "数值字体"; choice2="游戏字体"; choice3="物品信息字体" }

MI2_OPTIONS["MI2_OptTargetFontSize"] = 
			{ text = "字体大小"; 
			help = "设定生命/法力值的显示字体大小。"; }

MI2_OPTIONS["MI2_OptClearTarget"] = 
			{ text = "清除目前目标资料"; 
			help = "清除目前目标的资料。"; }

MI2_OPTIONS["MI2_OptClearMobDb"] = 
			{ text = "清除怪物资料"; 
			help = "清除全部怪物信息资料。"; }

MI2_OPTIONS["MI2_OptClearHealthDb"] = 
			{ text = "清除生命力资料"; 
			help = "清除全部怪物生命力资料。"; }

MI2_OPTIONS["MI2_OptClearPlayerDb"] = 
			{ text = "清除玩家资料"; 
			help = "清除全部玩家生命力资料。"; }

MI2_OPTIONS["MI2_OptSaveItems"] = 
			{ text = "记录以下质量的掉落物品资料:"; 
			help = "开启后记录所有MobInfo所能记的怪物相关资料。";
			info = "你可以选择想记录的物品的质量等级。"; }

MI2_OPTIONS["MI2_OptSaveCharData"] = 
			{ text = "记录角色相关的怪物资料"; 
			help = "开启后记录所有和玩家角色有关的怪物信息。";
			info = "开启或关闭保存以下资料：\n击杀次数、最大／最小伤害、DPS (每秒伤害值)\n\n这些资料将依玩家角色分开储存。\n这几个资料只能同时设定为『储存』或『不储存』。"; }

MI2_OPTIONS["MI2_OptSaveResist"] = 
			{ text = "记录抵抗和免疫资料"; 
			help = "记录怪物对各种性质的法术的抵抗和免疫的资料。";
			info = "记录怪物对各种属性法术的抵抗和免疫的统计资料。"; }

MI2_OPTIONS["MI2_OptItemsQuality"] = 
			{ text = ""; 
			help = "记录指定质量(含)更好的物品详细信息。"; 
			choice1 = "灰色以及更好"; choice2="白色以及更好"; choice3="绿色以及更好" }

MI2_OPTIONS["MI2_OptTrimDownMobData"] = 
			{ text = "最佳化怪物数据库大小"; 
			help = "移除过剩的资料，以最佳化怪物数据库大小。";
			info = "过剩的资料是指数据库里，未被设定为需要记录的全部资料。"; }

MI2_OPTIONS["MI2_OptImportMobData"] = 
			{ text = "开始汇入"; 
			help = "汇入外部资料到你自己的怪物数据库";
			info = "注意：请仔细详读汇入步骤的指示！\n一定要在汇入前，先备份自己的数据库，以免造成资料永久遗失！"; }

MI2_OPTIONS["MI2_OptDeleteSearch"] = 
			{ text = "删除"; 
			help = "自数据库中，删除所有在搜寻结果中的怪物资料。";
			info = "警告：本步骤是没办法复原的，\n使用前请小心！\n建议在删除这些资料前，先备份自己的数据库。"; }

MI2_OPTIONS["MI2_OptImportOnlyNew"] = 
			{ text = "只汇入目前还未知的怪物资料"; 
			help = "汇入目前在你的数据库中，还没有记录的资料";
			info = "开启这个选项可以预防现在已存在的资料，被汇入的资料盖掉，\n只有目前未知(新的)资料会汇入数据库。\n如此可以确保原资料的一致性。"; }

MI2_OPTIONS["MI2_SearchResultFrameTab1"] = 
			{ text = "怪物列表"; 
			help = ""; }

MI2_OPTIONS["MI2_SearchResultFrameTab2"] = 
			{ text = "物品列表"; 
			help = ""; }

MI2_OPTIONS["MI2_OptionsTabFrameTab1"] = 
			{ text = "提示信息选项"; 
			help = "设定在提示信息里面，显示的怪物信息选项"; }

MI2_OPTIONS["MI2_OptionsTabFrameTab2"] = 
			{ text = "生命/法力值"; 
			help = "设置目标框中显示生命/法力值的选项"; }

MI2_OPTIONS["MI2_OptionsTabFrameTab3"] = 
			{ text = "数据库"; 
			help = "数据库管理选项"; }

MI2_OPTIONS["MI2_OptionsTabFrameTab4"] = 
			{ text = "搜寻"; 
			help = "搜寻数据库"; }

MI2_OPTIONS["MI2_OptionsTabFrameTab5"] = 
			{ text = "一般"; 
			help = "MobInfo插件的一般选项"; }

end