
local addon, ns = ...

local L = {};
ns.L = setmetatable(L,{__index=function(t,k)
	local v = tostring(k)
	rawset(t,k,v)
	return v
end});

-- Do you want to help localize this addon?
-- https://wow.curseforge.com/projects/farmhud/localization


L["AddOnLoaded"] = "AddOn loaded..."
L["AddOnLoadedDesc"] = "Show 'AddOn loaded...' message on login"
L["AreaBorder"] = "Area border"
L["AreaBorderByClient"] = "Use tracking option from game client"
L["AreaBorderOnHUD"] = "%s area border in HUD"
L["BgTransparency"] = "Background transparency"
L["CardinalPoints"] = "Cardinal points"
L["CardinalPointsColorDesc"] = "Adjust the color of cardinal points (%s)"
L["CardinalPointsColorResetDesc"] = "Reset the color of cardinal points (%s)"
L["CardinalPointsGroup1"] = "N, W, S, E"
L["CardinalPointsGroup2"] = "NW, NE, SW, SE"
L["CardinalPointsShow"] = "Show cardinal points"
L["CardinalPointsShowDesc"] = "Display the cardinal points on HUD"
L["ChangeRadius"] = "Distance from center"
L["ChangeRadiusDesc"] = "Change the distance from center from the HUD"
L["Coords"] = "Coordinations"
L["CoordsBottom"] = "Coordinations on bottom"
L["CoordsBottomDesc"] = "Display the player coordinations on bottom"
L["CoordsColorDesc"] = "Adjust the color of coordations"
L["CoordsColorResetDesc"] = "Reset the color of coordations"
L["CoordsShow"] = "Show coordinations"
L["CoordsShowDesc"] = "Show player coordinations on HUD"
L["DataBrokerOptions"] = "to open FarmHud options"
L["DataBrokerToggle"] = "to toggle FarmHud"
L["E"] = "E"
L["GatherCircle"] = "Gather circle"
L["GatherCircleColorDesc"] = "Adjust the color of the gather circle"
L["GatherCircleDesc"] = "The gather circle is a visual help line. It stands for the distance around your position in there all points of interest (mailbox, ore, herb) will be appear on minimap and FarmHud"
L["GatherCircleShow"] = "Show gather circle"
L["GatherCircleShowDesc"] = "Show the gather circle on HUD"
L["HudSize"] = "HUD Size"
L["HudSizeDesc"] = "Sets the HUD size to a percentage of screen height"
L["HudSymbolScale"] = "HUD symbol scale"
L["HudSymbolScaleDesc"] = "Scale the symbols on HUD"
L["KeyBindBackground"] = "Toggle FarmHud's minimap background"
L["KeyBindBackgroundDesc"] = "Set the keybinding to show minimap background."
L["KeyBindMouse"] = "Toggle FarmHud's tooltips (Can't click through Hud)"
L["KeyBindMouseDesc"] = "Set the keybinding to allow mouse over for tooltips from point of interest nodes (like ore,herb or quest giver). Or for clicking on the hud to submit a ping to your group or raid."
L["KeyBindToggle"] = "Toggle FarmHud's Display"
L["KeyBindToggleDesc"] = "Set the keybinding to show FarmHud."
L["MinimapIcon"] = "Minimap Icon"
L["MinimapIconDesc"] = "Show the minimap icon."
L["MouseOn"] = "MOUSE ON"
L["MouseOver"] = "Mouse over options"
L["MouseOverOnHold"] = "Mouse over on hold modifier key"
L["MouseOverOnHoldDesc"] = "This is an option to enable mouse over mode while you are holding a modifier key like Alt"
L["N"] = "N"
L["NE"] = "NE"
L["NW"] = "NW"
L["OnScreen"] = "OnScreen buttons"
L["OnScreenAlphaDesc"] = "Adjust the transparency the the OnScreen buttons"
L["OnScreenBottom"] = "OnScreen buttons on bottom"
L["OnScreenBottomDesc"] = "Display the OnScreen buttons on bottom from center of the HUD"
L["OnScreenShow"] = "Show OnScreen buttons"
L["OnScreenShowDesc"] = "Show OnScreen buttons (\"mouse on\"-mode, hud close button and more)"
L["PlaceholderDesc"] = "The placeholder is an element to hold all visible elements of your minimap in place while Farmhud is active."
L["PlayerDot"] = "Player arrow or dot"
L["PlayerDotDesc"] = "Change the look of your player dot/arrow on opened FarmHud"
L["QuestArrow"] = "Quest arrow"
L["QuestArrowDesc"] = "Display quest arrow on opened HUD"
L["ResetColor"] = "Reset color"
L["Rotation"] = "Rotation"
L["RotationDesc"] = "Force enable minimap rotation on HUD mode"
L["S"] = "S"
L["SE"] = "SE"
L["ShowPlaceholder"] = "Show elements"
L["ShowPlaceholderBg"] = "Show Background"
L["ShowPlaceholderBgDesc"] = "Display a black background instead of the minimap while FarmHud is active."
L["ShowPlaceholderDesc"] = "The elements of your minimap remain visible even when FarmHud is active."
L["SupportBlizzard"] = "Blizzard have made some changes that makes useless to offer optional support of single addons or libraries."
L["SupportHereBeDragon"] = "Tomtom and HandyNotes are supported through the library HereBeDragon but HandyNotes have a problem with Hud toggling. All icons around you position will be disappear by toggling FarmHud. But through a littble bit walking/flying arround should be displayed again."
L["SupportOptions"] = "Support options"
L["SW"] = "SW"
L["TextScale"] = "Text scale"
L["TextScaleDesc"] = "Text scaling on HUD for cardinal points, mouse on and coordinations"
L["Time"] = "Server/Local time"
L["TimeBottom"] = "Time on bottom"
L["TimeBottomDesc"] = "Display the time on bottom"
L["TimeColorDesc"] = "Adjust the color of time"
L["TimeColorResetDesc"] = "Reset the color of time"
L["TimeServer"] = "Server time"
L["TimeServerDesc"] = "Display server time otherwise local time"
L["TimeShow"] = "Show time"
L["TimeShowDesc"] = "Display server or local time on HUD mode"
L["W"] = "W"


if LOCALE_deDE then
L["AddOnLoaded"] = "AddOn geladen..."
L["AddOnLoadedDesc"] = "Zeige \"AddOn geladen...\" Mitteilung beim Login"
L["AreaBorder"] = "Gebietsgrenze"
L["AreaBorderByClient"] = "Nutze Aufspur-Option vom Spiel"
L["AreaBorderOnHUD"] = "%s Gebietsgrenze auf dem HUD"
L["BgTransparency"] = "Hintergrundtransparenz"
L["CardinalPoints"] = "Himmelsrichtungen"
L["CardinalPointsColorDesc"] = "Ändere die Farbe der Himmelsrichtungen (%s)"
L["CardinalPointsColorResetDesc"] = "Die Farbe der Himmelsrichtungen (%s) zurücksetzen"
L["CardinalPointsGroup1"] = "N, W, S, O"
L["CardinalPointsGroup2"] = "NW, NO, SW, SO"
L["CardinalPointsShow"] = "Zeige Himmelsrichtungen"
L["CardinalPointsShowDesc"] = "Zeige die Himmelsrichtungen auf dem HUD"
L["ChangeRadius"] = "Distanz zum Zentrum"
L["ChangeRadiusDesc"] = "Ändere die Distanze zum Zentrum vom HUD"
L["Coords"] = "Koordinaten"
L["CoordsBottom"] = "Koordinaten unten"
L["CoordsBottomDesc"] = "Zeige die Spielerkoordinaten unten"
L["CoordsColorDesc"] = "Ändere die Farbe der Koordinaten"
L["CoordsColorResetDesc"] = "Die Farbe der Koordinaten zurücksetzen"
L["CoordsShow"] = "Zeige Spielerkoordinaten"
L["CoordsShowDesc"] = "Zeige die Spielerkoordinaten auf dem HUD"
L["DataBrokerOptions"] = "zum öffnen der FarmHud Optionen"
L["DataBrokerToggle"] = "um FarmHud ein-/auszublenden"
L["E"] = "O"
L["GatherCircle"] = "Sammelkreis"
L["GatherCircleColorDesc"] = "Ändere die Farbe des Sammelkreises"
L["GatherCircleDesc"] = "Der Sammelkreis ist eine visuelle Hilfslinie. Sie steht für die Distanz um deine Position, in der alle Punkte von Interesse (Briefkasten, Erze, Kräuter) auf Minikarte und FarmHud erscheinen"
L["GatherCircleShow"] = "Zeige Sammelkreis"
L["GatherCircleShowDesc"] = "Zeige den Sammelkreis auf dem HUD"
L["HudSize"] = "HUD Größe"
L["HudSizeDesc"] = "Stellt die HUD Größe nach einem Prozentwert der Bildschirmhöhe ein"
L["HudSymbolScale"] = "HUD Symbolskalierung"
L["HudSymbolScaleDesc"] = "Skaliere die Symbole auf dem HUD"
L["KeyBindBackground"] = "FarmHud's Minikartenhintergrund umschalten"
L["KeyBindBackgroundDesc"] = "Setzte eine Tastaturbelegung zum Anzeigen des Minikartenhintergrunds"
L["KeyBindMouse"] = "FarmHud's tooltips umschalten (Kann nicht durch Hud klicken)"
L["KeyBindMouseDesc"] = "Stellt die Tastenzuweisung so ein, dass ein Tooltip erscheint sobald die Maus über einen interessanten Punkt (wie Erz, Kräuter oder Questgeber) bewegt wurde. Oder um auf das HUD zu klicken um einen Ping für deine Gruppe oder deinen Raid zu erzeugen."
L["KeyBindToggle"] = "FarmHud's Anzeige umschalten"
L["KeyBindToggleDesc"] = "Setze eine Tastaturbelegung um FarmHud anzuzeigen"
L["MinimapIcon"] = "Minikartensymbol"
L["MinimapIconDesc"] = "Zeige das Minikartensymbol"
L["MouseOn"] = "MAUS AN"
L["MouseOver"] = "Mausdrüber Optionen"
L["MouseOverOnHold"] = "Mausdrüber beim Halten einer Zusatztaste"
L["MouseOverOnHoldDesc"] = "Dies ist eine Option zum aktieren des Mausdrüber-Modus solange du eine Zusatztaste wie Alt gedrückt hälst"
L["N"] = "N"
L["NE"] = "NO"
L["NW"] = "NW"
L["OnScreen"] = "OnScreen Schaltflächen"
L["OnScreenAlphaDesc"] = "Ändere die Transparenz der OnScreen Schaltflächen"
L["OnScreenBottom"] = "OnScreen Schaltflächen unten"
L["OnScreenBottomDesc"] = "Zeige die OnScreen Schaltflächen unterhalb des Zentrums vom HUD an"
L["OnScreenShow"] = "Zeige OnScreen Schaltflächen"
L["OnScreenShowDesc"] = "Zeige OnScreen Schaltflächen (\"Maus an\"-Modus, Hud-Schließen-Schaltflächen und mehr)"
L["PlaceholderDesc"] = "Der Platzhalter ist ein Element um sichtbare Element deiner Minikarte am Platz zu halten solange FarmHud aktiv ist."
L["PlayerDot"] = "Spielerpfeil oder Punkt"
L["PlayerDotDesc"] = "Verändere das Aussehen deines Spielerpunkts/-pfeils im geöffneten FarmHud"
L["QuestArrow"] = "Questpfeil"
L["QuestArrowDesc"] = "Zeigt den Questpfeil auf geöffnetem HUD"
L["ResetColor"] = "Farbe zurücksetzen"
L["Rotation"] = "Drehung"
L["RotationDesc"] = "Forciert die Antivierung der Minikartenrotation im HUD Modus"
L["S"] = "S"
L["SE"] = "SO"
L["ShowPlaceholder"] = "Zeige Elemente"
L["ShowPlaceholderBg"] = "Zeige Hintergrund"
L["ShowPlaceholderBgDesc"] = "Zeigt einen schwarzen Hintergrund anstelle der Minikarte solange FarmHud aktiv ist."
L["ShowPlaceholderDesc"] = "Die Elemente deiner Minikarte bleiben sichtbar auch wenn FarmHud aktiv ist."
L["SupportBlizzard"] = "Blizzard hat ein paar Änderungen gemacht, die es Nutzslos machen noch optionale Unterstützungen für einzelne AddOns und Bibliotheken anzubieten."
L["SupportHereBeDragon"] = "TomTom und HandyNotes werden durch die Bibliothek HereBeDragon unterstützt, aber HandyNotes hat ein Problem beim Umschalten des HUD's. Alle Symbole um deine Position verschwinden beim ein/-ausblenden von FarmHud. Aber durch ein wenig herumlaufen/-fliegen sollten sie bald wieder angezeigt werden."
L["SupportOptions"] = "Unterstützungsoptionen"
L["SW"] = "SW"
L["TextScale"] = "Textskalierung"
L["TextScaleDesc"] = "Textskalierung auf dem HUD für Himmelsrichtungen, \"MAUS AN\" und Koordinaten"
L["Time"] = "Server/Lokale Zeit"
L["TimeBottom"] = "Zeit unten"
L["TimeBottomDesc"] = "Zeigt die Zeit unten an"
L["TimeColorDesc"] = "Ändere die Farbe der Zeit"
L["TimeColorResetDesc"] = "Die Farbe der Zeit zurücksetzen"
L["TimeServer"] = "Serverzeit"
L["TimeServerDesc"] = "Zeigt die Serverzeit andernfalls die lokale Zeit"
L["TimeShow"] = "Zeige die Zeit"
L["TimeShowDesc"] = "Zeit Serverzeit oder lokale Zeit im Hud Modus"
L["W"] = "W"

end

if LOCALE_esES then
L["AddOnLoaded"] = "AddOn Cargado..."
L["AddOnLoadedDesc"] = "Muestra el mensaje \"AddOn Cargado\" después del Login"
L["AreaBorder"] = "Perímetro"
L["AreaBorderByClient"] = "Usa la opción de trackeo del juego"

end

if LOCALE_esMX then

end

if LOCALE_frFR then

end

if LOCALE_itIT then

end

if LOCALE_koKR then
L["AddOnLoaded"] = "애드온 로드됨..."
L["AddOnLoadedDesc"] = "접속 시 '애드온 로드됨...' 메시지를 표시합니다."
L["AreaBorder"] = "영역 경계"
L["AreaBorderByClient"] = "게임 클라이언트의 추적 옵션 사용"
L["AreaBorderOnHUD"] = "HUD의 %s 영역 경계"
L["BgTransparency"] = "배경 투명도"
L["CardinalPoints"] = "기본 방위"
L["CardinalPointsColorDesc"] = "기본 방위(%s)의 색상을 조정합니다."
L["CardinalPointsColorResetDesc"] = "기본 방위(%s)의 색상을 초기화합니다."
L["CardinalPointsGroup1"] = "북, 서, 남, 동"
L["CardinalPointsGroup2"] = "북서, 북동, 남서, 남동"
L["CardinalPointsShow"] = "기본 방위 표시"
L["CardinalPointsShowDesc"] = "HUD에 기본 방위를 표시합니다."
L["ChangeRadius"] = "반지름"
L["ChangeRadiusDesc"] = "HUD의 반지름을 바꿉니다."
L["Coords"] = "좌표"
L["CoordsBottom"] = "하단에 좌표"
L["CoordsBottomDesc"] = "하단에 플레이어 좌표를 표시합니다."
L["CoordsColorDesc"] = "좌표의 색상을 조정합니다."
L["CoordsColorResetDesc"] = "좌표의 색상을 초기화합니다."
L["CoordsShow"] = "좌표 표시"
L["CoordsShowDesc"] = "HUD에 플레이어 좌표를 표시합니다."
L["DataBrokerOptions"] = "- FarmHud 옵션 열기"
L["DataBrokerToggle"] = "- FarmHud 켜고 끄기"
L["E"] = "동"
L["GatherCircle"] = "채집 원"
L["GatherCircleColorDesc"] = "채집 원의 색상을 조정합니다."
L["GatherCircleDesc"] = "채집 원은 눈에 보이는 도움선입니다. 미니맵과 FarmHud에 나타나는 모든 관심 지점(우편함, 광석, 약초)에서 당신 위치 주변의 거리를 나타냅니다."
L["GatherCircleShow"] = "채집 원 표시"
L["GatherCircleShowDesc"] = "HUD에 채집 원을 표시합니다."
L["HudSize"] = "HUD 크기"
L["HudSizeDesc"] = "HUD 크기를 화면 높이의 백분율로 설정합니다."
L["HudSymbolScale"] = "HUD 기호 크기 비율"
L["HudSymbolScaleDesc"] = "HUD 위 기호의 크기 비율입니다."
L["KeyBindBackground"] = "FarmHud의 미니맵 배경 켜고 끄기"
L["KeyBindBackgroundDesc"] = "미니맵 배경을 표시하는 단축키를 설정합니다."
L["KeyBindMouse"] = "FarmHud의 툴팁을 켜고 끄기 (Hud를 통과해 클릭 불가)"
L["KeyBindMouseDesc"] = "(광석, 약초 또는 퀘스트 제공자 같은) 관심 지점 노드의 툴팁을 마우스 오버할 수 있거나 파티나 공격대에 핑을 보내기 위해 Hud를 클릭하기 위한 단축키를 설정합니다."
L["KeyBindToggle"] = "FarmHud 표시 켜고 끄기"
L["KeyBindToggleDesc"] = "FarmHud를 표시하는 단축키를 설정합니다."
L["MinimapIcon"] = "미니맵 아이콘"
L["MinimapIconDesc"] = "미니맵 아이콘을 표시합니다."
L["MouseOn"] = "마우스 온"
L["MouseOver"] = "마우스 오버 옵션"
L["MouseOverOnHold"] = "누름 시 마우스 오버 보조 키"
L["MouseOverOnHoldDesc"] = "이는 Alt와 같은 보조 키를 누르고 있는 동안 마우스 오버 모드를 켜는 옵션입니다."
L["N"] = "북"
L["NE"] = "북동"
L["NW"] = "북서"
L["OnScreen"] = "화면 위 버튼"
L["OnScreenAlphaDesc"] = "화면 위 버튼의 투명도를 조정합니다."
L["OnScreenBottom"] = "하단에 화면 위 버튼"
L["OnScreenBottomDesc"] = "HUD 하단에 화면 위 버튼을 표시합니다."
L["OnScreenShow"] = "화면 위 버튼 표시"
L["OnScreenShowDesc"] = "화면 위 버튼(\"마우스 온\" 모드, Hud 닫기 버튼 등)을 표시합니다."
L["PlaceholderDesc"] = "Placeholder는 Farmhud가 활성화되어 있는 동안 미니맵에 보이는 모든 요소를 제자리에 고정시키는 요소입니다."
L["PlayerDot"] = "플레이어 화살표 또는 점"
L["PlayerDotDesc"] = "열린 FarmHud에서 플레이어 점/화살표 모양을 바꿉니다."
L["QuestArrow"] = "퀘스트 화살표"
L["QuestArrowDesc"] = "열린 HUD에 퀘스트 화살표를 표시합니다."
L["ResetColor"] = "색상 초기화"
L["Rotation"] = "회전"
L["RotationDesc"] = "HUD 모드에서 미니맵 회전을 강제로 실행합니다."
L["S"] = "남"
L["SE"] = "남동"
L["ShowPlaceholder"] = "요소 표시"
L["ShowPlaceholderBg"] = "배경 표시"
L["ShowPlaceholderBgDesc"] = "FarmHud가 활성화되어 있는 동안 미니맵 대신 검은색 배경을 표시합니다."
L["ShowPlaceholderDesc"] = "미니맵 요소가 FarmHud가 활성화되어 있어도 계속 표시됩니다."
L["SupportBlizzard"] = "Blizzard가 단일 애드온 또는 라이브러리에 선택적인 지원을 제공하는 게 쓸모없게 약간 변경했습니다."
L["SupportHereBeDragon"] = "TomTom과 HandyNotes는 HereBeDragon 라이브러리를 통해 지원되지만 HandyNotes는 Hud 켜고 끄기에 문제가 있습니다. 위치 주변 모든 아이콘은 FarmHud를 켜면 사라집니다. 그러나 약간의 주변 걷기/비행을 통해 다시 표시될 겁니다."
L["SupportOptions"] = "지원 옵션"
L["SW"] = "남서"
L["TextScale"] = "텍스트 크기 비율"
L["TextScaleDesc"] = "HUD 상 기본 방위, 마우스 온 및 좌표 텍스트의 크기 비율입니다."
L["Time"] = "서버/지역 시간"
L["TimeBottom"] = "하단에 시간"
L["TimeBottomDesc"] = "하단에 시간을 표시합니다."
L["TimeColorDesc"] = "시간의 색상을 조정합니다."
L["TimeColorResetDesc"] = "시간의 색상을 초기화합니다."
L["TimeServer"] = "서버 시간"
L["TimeServerDesc"] = "서버 시간 그렇지 않으면 지역 시간을 표시합니다."
L["TimeShow"] = "시간 표시"
L["TimeShowDesc"] = "HUD 모드에서 서버 또는 지역 시간을 표시합니다."
L["W"] = "서"

end

if LOCALE_ptBR or LOCALE_ptPT then

end

if LOCALE_ruRU then

end

if LOCALE_zhCN then

end

if LOCALE_zhTW then
L["CoordsBottom"] = "底部座標"
L["DataBrokerToggle"] = "打開農人雷達"
L["E"] = "東"
L["KeyBindMouse"] = "開啟FarmHud的提示 (無法點選hud後面的東西)"
L["KeyBindToggle"] = "開啟FarmHud的顯示"
L["KeyBindToggleDesc"] = "射的快捷建來顯示FarmHud"
L["MinimapIcon"] = "小地圖圖示"
L["MouseOn"] = "滑鼠開啟"
L["N"] = "北"
L["NE"] = "東北"
L["NW"] = "西北"
L["S"] = "南"
L["SE"] = "東南"
L["SupportOptions"] = "支援選項"
L["SW"] = "西南"
L["W"] = "西"

end

BINDING_HEADER_FARMHUD = addon;
BINDING_NAME_TOGGLEFARMHUD = L.KeyBindToggle;
BINDING_NAME_TOGGLEFARMHUDMOUSE	= L.KeyBindMouse;
BINDING_NAME_TOGGLEFARMHUDBACKGROUND = L.KeyBindBackground;
