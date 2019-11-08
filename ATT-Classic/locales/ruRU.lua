-- Localization for Russian Clients.
if GetLocale() ~= "ruRU" then return; end
local app = select(2, ...);
local L = app.L;

-- TODO

-- Dungeons
L.ZONE_TEXT_TO_MAP_ID["Непроглядная Пучина"] = 221;	-- BFD
L.ZONE_TEXT_TO_MAP_ID["Глубины Черной горы"] = 242;	-- BRD
L.ZONE_TEXT_TO_MAP_ID["Черная гора"] = 35;	-- BRM
L.ZONE_TEXT_TO_MAP_ID["Вершина Черной горы"] = 250;	-- BRS
L.ZONE_TEXT_TO_MAP_ID["Мертвые копи"] = 291;	-- DM/VC
L.ZONE_TEXT_TO_MAP_ID["Забытый Город"] = 234;	-- Dire Maul
L.ZONE_TEXT_TO_MAP_ID["Гномреган"] = 226;	-- Gnomer
L.ZONE_TEXT_TO_MAP_ID["Мародон"] = 280;	-- Maraudon
L.ZONE_TEXT_TO_MAP_ID["Огненная пропасть"] = 213;	-- RFC
L.ZONE_TEXT_TO_MAP_ID["Курганы Иглошкурых"] = 300;	-- RFD
L.ZONE_TEXT_TO_MAP_ID["Лабиринты Иглошкурых"] = 301;	-- RFK
L.ZONE_TEXT_TO_MAP_ID["Некроситет"] = 310;	-- SCHOLO
L.ZONE_TEXT_TO_MAP_ID["Крепость Темного Клыка"] = 310;	-- SFK
L.ZONE_TEXT_TO_MAP_ID["Монастырь Алого ордена"] = 435;	-- SM
L.ZONE_TEXT_TO_MAP_ID["Стратхольм"] = 317;	-- STRATH
L.ZONE_TEXT_TO_MAP_ID["Храм Атал'Хаккара"] = 220;	-- ST
L.ZONE_TEXT_TO_MAP_ID["Ульдаман"] = 230;	-- ULDA
L.ZONE_TEXT_TO_MAP_ID["Пещеры Стенаний"] = 279;	-- WC
L.ZONE_TEXT_TO_MAP_ID["Зул'Фаррак"] = 219;	-- ZF

local a = L.NPC_ID_NAMES;
for key,value in pairs({
	-- Enter translated NPCID's here
})
do a[key] = value; end

local a = L.OBJECT_ID_NAMES;
for key,value in pairs({
	-- Enter translated OBJECTID's here
})
do a[key] = value; end