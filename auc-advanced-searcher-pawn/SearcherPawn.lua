--[[
  Auctioneer Advanced - Search UI - Searcher Pawn
  URL: http://www.curse.com/addons/wow/auc-advanced-searcher-pawn

  This is a plugin module for the SearchUI that assists in searching by evaluating items with Pawn

  License:
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program(see GPL.txt); if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

  Note:
    This AddOn's source code is specifically designed to work with
    World of Warcraft's interpreted AddOn system.
    You have an implicit license to use this AddOn with these facilities
    since that is its designated purpose as per:
    http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]
-- Create a new instance of our lib with our parent
local lib, parent, private = AucSearchUI.NewSearcher("Pawn-Ru")

if not lib then
  return
end

--local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get,set,default,Const, resources = parent.GetSearchLocals()

Localization.SetAddonDefault("Auc-Searcher-Pawn", "enUS")

-------------------------------------------------------------------
-- Set the name of the Auctioneer Search Option
lib.tabname = "Pawn"
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Set our defaults
default("search.pawn.scalenum", "")
default("search.pawn.canuse", false)
default("search.pawn.force2h", false)
default("search.pawn.head", true)
default("search.pawn.neck", true)
default("search.pawn.shoulder", true)
default("search.pawn.back", true)
default("search.pawn.chest", true)
default("search.pawn.wrist", true)
default("search.pawn.hands", true)
default("search.pawn.waist", true)
default("search.pawn.legs", true)
default("search.pawn.feet", true)
default("search.pawn.finger", true)
default("search.pawn.trinket", true)
default("search.pawn.weapon", true)
default("search.pawn.offhand", true)
default("search.pawn.ranged", true)
default("search.pawn.ammo", true)
default("search.pawn.unenchanted", false)
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Interface to the Localization lib
local function TEXT(key) return Localization.GetClientString("Auc-Searcher-Pawn", key) end
-------------------------------------------------------------------

default("search.pawn.armorpref", TEXT("NO_PREF"))

-------------------------------------------------------------------
-- Sprinkle these throughout the code to debug.
-- print(string.format("Sometext %s [%d]", somevar, somevar2))
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Map between Auctioneer ipos and Pawn slot values
-------------------------------------------------------------------
local convertSlot = {
  {
    "HeadSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [1] head
  {
    "NeckSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [2] neck
  {
    "ShoulderSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [3] shoulder
  {
    nil, -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [4] shirt / body
  {
    "ChestSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [5] chest
  {
    "WaistSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [6] waist
  {
    "LegsSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [7] legs
  {
    "FeetSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [8] feet
  {
    "WristSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [9] wrist
  {
    "HandsSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [10] hand
  {
    "Finger0Slot", -- [1] primary slot
    "Finger1Slot", -- [2] secondary slot
  }, -- [11] finger
  {
    "Trinket0Slot", -- [1] primary slot
    "Trinket1Slot", -- [2] secondary slot
  }, -- [12] trinket
  {
    "MainHandSlot", -- [1] primary slot
    "SecondaryHandSlot", -- [2] secondary slot
  }, -- [13] weapon
  {
    "SecondaryHandSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [14] shield
  {
    "MainHandSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [15] ranged - right
  {
    "BackSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [16] cloak
  {
    "MainHandSlot", -- [1] primary slot
    "SecondaryHandSlot", -- [2] secondary slot
  }, -- [17] 2hweapon
  {
    nil, -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [18] bag
  {
    nil, -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [19] tabard
  {
    "ChestSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [20] robe
  {
    "MainHandSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [21] weaponmainhand
  {
    "SecondaryHandSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [22] weaponoffhand
  {
    "SecondaryHandSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [23] holdable
  {
    "AmmoSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [24] ammo
  {
    "MainHandSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [25] thrown
  {
    "RangedSlot", -- [1] primary slot
    nil, -- [2] secondary slot
  }, -- [26] ranged
}

-------------------------------------------------------------------
-- Refetch Pawn Scales -- Called by the config menu
--  * Needed to ensure that we have updated scales
--  * If we don't do this, then new scales will not be found
--  * until the user logs out
--
-- local Globals used:
-- Cache for valid scales
local validScales = {}
-- Cache the Scale Table from Pawn
local scaletable = {}
-------------------------------------------------------------------
function updateScales()
  -- reset the valid scale cache
  validScales = {}

  local scalecopy = {}
  scaletable = PawnGetAllScalesEx()

  table.insert(scalecopy, { 1, "" })

  for i,j in pairs(scaletable) do
    if j["IsVisible"] then
      table.insert(scalecopy, { i+1, j["LocalizedName"] })
    end
  end

  return scalecopy
end

-------------------------------------------------------------------
-- Return the name of the scale
-- Globals Used:
-------------------------------------------------------------------
function GetScaleName(scalenum)
  local scalename = ""

  -- Does the stored scale exist
  for i, j in pairs(scaletable) do
    if i == (scalenum - 1) then -- subtract 1, due to offset introduced in menu
      scalename = j["Name"]
      break
    end
  end

  return scalename
end

-------------------------------------------------------------------
-- Validate the user's choice of scale
-------------------------------------------------------------------
function ValidateScale()
  -- Did the user pick a scale
  local scalenum = get("search.pawn.scalenum")

  -- Convert strings if we get them to numbers
  -- seems to happen if no scale is selected
  if type(scalenum) == "string" then
    scalenum = tonumber(scalenum)
  end

  -- Error, undefined
  if not scalenum then
    return false
  end

  local isValid = validScales[scalenum]
  -- Check cache first, if we have validated this before
  -- we don't need to validate it now.
  if not isValid then
    local scalename = GetScaleName(scalenum)

    -- Error, undefined
    if scalename == "" then
      return false
    end

    local scalefound = PawnDoesScaleExist(scalename)
    -- Error, Pawn doesn't recognize the scale number
    if not scalefound then
      return false
    end

    -- Cache validation if true
    validScales[scalenum] = true
  end

  return true
end

-------------------------------------------------------------------
-- Convert RGB to Hex
-------------------------------------------------------------------
local function RGBPercToHex(r, g, b)
  r = r <= 1 and r >= 0 and r or 0
  g = g <= 1 and g >= 0 and g or 0
  b = b <= 1 and b >= 0 and b or 0
  return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

-------------------------------------------------------------------
-- Create and scan a tooltip looking for red text.
-------------------------------------------------------------------
local function CanUse(link)
  MyScanningTooltip:ClearLines()
  MyScanningTooltip:SetHyperlink(link)
  local retval = true

  for i=1,MyScanningTooltip:NumLines() do
    --Check left side text to see if it is red, if so, can't use
    local mytext = getglobal("MyScanningTooltipTextLeft" .. i)
    local text = mytext:GetText()
    if text then
      local r,g,b,a = mytext:GetTextColor()
      local hex = RGBPercToHex(r,g,b)
      if hex == "fe1f1f" then
        retval = false
      end
    end

    --Check right side text to see if it is red, if so, can't use
    local mytextr = getglobal("MyScanningTooltipTextRight" .. i)
    local textr = mytextr:GetText()
    if textr then
      local r,g,b,a = mytextr:GetTextColor()
      local hex = RGBPercToHex(r,g,b)
      if hex == "fe1f1f" then
        retval = false
      end
    end
  end

  return retval
end

-------------------------------------------------------------------
-- Returns true if the user can dual wield, false otherwise
--
-------------------------------------------------------------------
local function CanDualWield()
  local localized_pclass, pclass = UnitClass("player")

  _candualcache = false

  if pclass == "ROGUE" then
    --Rogues get DualWield for Free after character creation
    _candualcache = true
  else
    -- Warriors have Crazed Berzerker spell if they can dual wield
    -- Additionally, they can have Titan's Grip at level 38 that allows them to dual wield 2 handed weapons
    local crazed_localized = GetSpellInfo(23588) -- get the localized name
    local crazed = GetSpellInfo(crazed_localized) -- check to see if it is in the spellbook
    if crazed then
      _candualcache = true
    end
    if not _candualcache then
      local titans_localized = GetSpellInfo(46917) -- get the localized name
      local titans = GetSpellInfo(titans_localized) -- check to see if it is in the spellbook
      if titans then
        _candualcache = true
      end
      if not _candualcache then
        -- see if Monk, Shaman or Hunter has learned "Dual Wield" yet
        local dual_localized = GetSpellInfo(674)
        local dualwield = GetSpellInfo(dual_localized)
        if dualwield then  -- name will be defined if the user has learned "Dual Wield"
          _candualcache = true
        end
      end
    end
  end -- rogue / death knight

  return _candualcache
end

--------------------------------------------------------------------
-- Get Slot info, store it in cache and return
-- Globals used:
local slotCache = {}
--------------------------------------------------------------------
local function GetCachedSlot(SlotName)
  -- ensure we have a valid keyname
  if type(SlotName) ~= "string" then
    return nil
  end
  if not slotCache[SlotName] then
    local slotId, textureName = GetInventorySlotInfo(SlotName)
    slotCache[SlotName] = slotId
  end
  return slotCache[SlotName]
end

-------------------------------------------------------------------
-- Returns true if the user has a 2h weapon equipped
--
-------------------------------------------------------------------
local is2handed = {}
local function Is2hEquipped()
  local retval = false
  local ItemLink = GetInventoryItemLink("player", GetInventorySlotInfo("MainHandSlot"))

  local tsize = #(is2handed)
  if tsize == 0 then
    table.insert(is2handed, TEXT("STAVES"))
    table.insert(is2handed, TEXT("POLEARMS"))
    table.insert(is2handed, TEXT("BOWS"))
    table.insert(is2handed, TEXT("GUNS"))
    table.insert(is2handed, TEXT("CROSSBOWS"))
  end

  if ItemLink then
    local _, _, _, _, _, _, itemSubType = GetItemInfo(ItemLink)
    if tContains(is2handed,itemSubType) then
       retval = true
    else
      local start, _ = string.find(itemSubType, TEXT("TWOHAND"), 1, true)
      if start then
        retval = true
      end
    end
  end

  return retval
end

-------------------------------------------------------------------
-- Convert between auctioneer equip positions and Pawn equip positions
-------------------------------------------------------------------
local function ConvertSlot(ipos)
  local primaryslot = nil
  local secondaryslot = nil

  local candual = CanDualWield()

  local slots = convertSlot[ipos]
  primaryslot = slots[1]
  secondaryslot = slots[2]

  -- Ensure they can dual wield before
  -- allowing them to compare against off-hand
  -- ShadowVall: Sorry, I dont understand code below:(  ipos=22 is offhand weapon. why You erase primary slot?
     -- Reason, this turns off checking off-hand items for weapons you cannot use.
     -- (it filters the item out later on in the code, due to primary slot being nil)
        -- ShadowVall: it is smart, strange and difficult to understand:)
           -- This is done so that the FilterItem function can filter these out
  local is1h = false
  if ipos == Const.EquipEncode["INVTYPE_WEAPON"] then
    is1h = true
  end
  if not candual then
    if ipos == Const.EquipEncode["INVTYPE_WEAPONOFFHAND"] then
      -- This filters the object entirely as the weapon can only be equipped in the Off-hand
      primaryslot = nil
    else
      -- This one turns off checking the secondary slot if the weapon can go into either slot and the user cannot dual wield
      if is1h then
        secondaryslot = nil
      end
    end
  end
  -- end of misunderstanding

  -- Short Circuit
  if primaryslot == nil and secondaryslot == nil then
    return nil, nil
  end

  if type(primaryslot) == "string" then
    primaryslot = GetCachedSlot(primaryslot)
  end

  if type(secondaryslot) == "string" then
    secondaryslot = GetCachedSlot(secondaryslot)
  end

  local force2h = get("search.pawn.force2h")
  local offhandslot = GetCachedSlot("SecondaryHandSlot")

  -- If the item can go in either hand and the user has a 2h weapon equipped
  -- change the primaryslot to be that of the main hand and remove the secondaryslot
  -- only items that are better than the 2h weap will be returned
  local is2h = Is2hEquipped()
  if is2h then
    if primaryslot == offhandslot or is1h then
      primaryslot = GetCachedSlot("MainHandSlot")
      secondaryslot = nil
    end
  end

  return primaryslot, secondaryslot
end -- function ConvertSlot(ipos)

-------------------------------------------------------------------
-- Check to see if the user checked the box for this slot
-------------------------------------------------------------------
local function SlotOK(slot)
  -- short-circuit if slot is out of bounds
  if slot == nil or slot < 0 or slot > 18 then
    return false
  end

  -- Build table so that we avoid a large if/else
  local slotOK = {
      get("search.pawn.head"),     -- [1] head
      get("search.pawn.neck"),     -- [2] neck
      get("search.pawn.shoulder"), -- [3] shoulder
      false,                       -- [4] shirt
      get("search.pawn.chest"),    -- [5] chest
      get("search.pawn.waist"),    -- [6] waist
      get("search.pawn.legs"),     -- [7] legs
      get("search.pawn.feet"),     -- [8] feet
      get("search.pawn.wrist"),    -- [9] wrist
      get("search.pawn.hands"),    -- [10] hand
      get("search.pawn.finger"),   -- [11] finger
      get("search.pawn.finger"),   -- [12] finger
      get("search.pawn.trinket"),  -- [13] trinket
      get("search.pawn.trinket"),  -- [14] trinket
      get("search.pawn.back"),     -- [15] cloak
      get("search.pawn.weapon"),   -- [16] weapon
      get("search.pawn.offhand"),  -- [17] offhand
      get("search.pawn.ranged"),   -- [18] ranged
      get("search.pawn.ammo"),     -- [19] ammo
  }

  -- See if the user wants the slot that this item would occupy
  local retval = slotOK[slot]

  -- sanity check the result
  if retval == nil then
    retval = false
  else
    if type(retval) ~= "boolean" then
      retval = false
    end
  end

  return retval
end

-------------------------------------------------------------------
-- Ensure that we have a valid ipos from Auctioneer
--  This allows real time searching to work
-------------------------------------------------------------------
local function ConvertIpos(ipos)
  -- Must have ipos
  if ipos == nil then
    return nil
  end

  -- Realtime search support
  if type(ipos) == "string" then
    ipos = Const.InvTypes[ipos]
  end

  return ipos
end

-------------------------------------------------------------------
-- See if the user can afford the item
-------------------------------------------------------------------
local function FilterPrice(itemData)
  local impoor = get("search.pawn.impoor")

  if impoor then
    local pmoney = GetMoney()
    local usebuyout = get("search.pawn.buyout")
    local buyout = itemData[Const.BUYOUT]
    local bid = itemData[Const.MINBID]

    if usebuyout then
      if pmoney < buyout then
        return false
      end
    else
      if pmoney < bid then
        return false
      end
    end -- buyout / bid
  end -- impoor

  return true
end

local isRanged = {}
local function IsRangedItem(subtype)
  local tsize = #(isRanged)
  if tsize == 0 then
    table.insert(isRanged, TEXT("BOWS"))
    table.insert(isRanged, TEXT("GUNS"))
    table.insert(isRanged, TEXT("WANDS"))
    table.insert(isRanged, TEXT("CROSSBOWS"))
    --table.insert(isRanged, TEXT("DAGGERS"))
    table.insert(isRanged, TEXT("THROWN")) -- These may be removed from the game.
  end
  if tContains(isRanged, subtype) then
    return true
  end

  return false
end

-------------------------------------------------------------------
-- Filter out an item if
--
-- 1) ipos from Auctioneer is undefined
-- 2) if the item does not have a link
-- 3) if the item cannot be equipped
-- 4) if the user checked "Only What I Can Use" and the item is not useable
-- 5) if the object doesn't go to a slot we care about (nil / ignore slot - shirts, tabards, etc.)
-- 6) if the user unchecked the slot in the search option section
-- 7) if the user only wants 2h weapons and we get a weapon that isn't 2h
-- 8) if the user cannot afford the item and they only want to see what they can afford
-- 9) if the item is armor and armor type is not marked as wanted
-------------------------------------------------------------------
local function FilterItem(itemData)
  local link = itemData[Const.LINK]
  local ipos  = ConvertIpos(itemData[Const.IEQUIP])
  local itype = itemData[Const.ITYPE]
  local subtype = itemData[Const.ISUB]

  -- Must have ipos
  if ipos == nil then
    return true
  end

  -- Does the item have a link
  if not link then
    return true
  end

  -- Only filter items that can be equipped (not materials, scrolls etc)
  if not IsEquippableItem(link) then
    return true
  end

  -- Check to see if the user can use the item
  -- but only do this if they checked the "Can Use" checkbox
  local canuse = get("search.pawn.canuse")
  if canuse then
    local icanuse = CanUse(link)
    if not icanuse then
      return true
    end
  end

  local primaryslot, secondaryslot = ConvertSlot(ipos)
  -- Is there a slot to be compared
  if not primaryslot then
    return true
  end

  -- This ensures that 1h main-hand items get filtered if user only wants to see 2h items
  local force2h = get("search.pawn.force2h")
  if force2h and primaryslot == GetCachedSlot("MainHandSlot") then
    if ipos == Const.EquipEncode["INVTYPE_WEAPON"] then
      return true
    end
    if ipos == Const.EquipEncode["INVTYPE_WEAPONMAINHAND"] then
      return true
    end
    if ipos == Const.EquipEncode["INVTYPE_WEAPONOFFHAND"] then
      return true
    end
  end

  -- Check to see if item is wanted
  local wanted = SlotOK(primaryslot)
  if not wanted then -- check other slot
    wanted = SlotOK(secondaryslot)
    if not wanted then -- still not wanted, check if they have ranged checked
      if get("search.pawn.ranged") then
        wanted = IsRangedItem(subtype)
      end
      if not wanted then
        return true
      end
    end
  end

  -- Check to see if we can afford the item
  if not FilterPrice(itemData) then
    return true
  end

  -- Check the armor type to see if it is wanted
  local armorPref = get("search.pawn.armorpref")
  if armorPref == TEXT("NO_PREF") then
    return false
  else
    if itype == TEXT("ARMOR") then
      if subtype == TEXT("MISC") then -- rings / trinkets / necklace
        return false
      end
      if subtype == TEXT("SHIELDS") then
        return false
      end
      if subtype == armorPref then
        return false
       else
        return true
       end
    end
  end

  return false
end

-------------------------------------------------------------------
-- Returns pawn values for a given equipped slot
-------------------------------------------------------------------
local function GetPawnValueEquipped(slot)
  local useUnenchanted = get("search.pawn.unenchanted")
  local mItem = PawnGetItemDataForInventorySlot(slot,useUnenchanted)

  local currentValue = 0
  local baseValue = 0

  -- If there is no item equipped in that slot, then any item is an upgrade
  if not mItem then
    return currentValue
  end

  -- Grab the values for the item equipped in the main slot
  local scalenum = get("search.pawn.scalenum")
  local scalename = GetScaleName(scalenum)
  currentValue, baseValue = PawnGetSingleValueFromItem(mItem, scalename)

  if currentValue == nil then
    currentValue = 0
  end

  if baseValue == nil then
    baseValue = 0
  end

  if useUnenchanted then
    return baseValue
  end

  return currentValue
end -- function GetPawnValueEquipped(slot)

-------------------------------------------------------------------
-- Returns back value of equipped items
--   for primary and secondary slots
-------------------------------------------------------------------
local function GetEquippedVal(itemData)
  -- Get value of equivalent slot(s).
  local itype = itemData[Const.ITYPE]
  local ipos  = ConvertIpos(itemData[Const.IEQUIP])
  local subtype = itemData[Const.ISUB]

  local primaryslot, secondaryslot = ConvertSlot(ipos)

  -- we can assume primaryslot is defined and secondaryslot might be defined at this point
  -- as anything with a nil primaryslot got filtered out before this function was called
  -- Get value for main slot
  local primaryValue = GetPawnValueEquipped(primaryslot)
  local secondaryValue = -1
  -- Get value for other slot
  if secondaryslot then
    secondaryValue = GetPawnValueEquipped(secondaryslot)
  end

  -- Ensure that primaryValue is not nil
  if primaryValue == nil then
    primaryValue = 0
  end

  return primaryValue, secondaryValue
end

-------------------------------------------------------------------
-- Returns pawn value from a itemData structure
-------------------------------------------------------------------
local function GetPawnValueItem(itemData)
  local link = itemData[Const.LINK]
  local useUnenchanted = get("search.pawn.unenchanted")

  -- Get the signature of this item and find it's stats.
  local item = PawnGetItemData(link)

  -- ensure we get an item structure from Pawn
  if item == nil then
    return 0
  end

  -- Grab the values for the item from Auctioneer
  local scalenum = get("search.pawn.scalenum")
  local scalename = GetScaleName(scalenum)
  local auctionValue, unenchantedValue = PawnGetSingleValueFromItem(item, scalename)

  if useUnenchanted then
    auctionValue = unenchantedValue
  end

  -- ensure auctionValue is valid number
  if auctionValue == nil then
    auctionValue = 0
  end

  return auctionValue
end -- function GetPawnValueItem(itemData)

-------------------------------------------------------------------
-- Check to see if the item is an upgrade or not
-------------------------------------------------------------------
local function IsUpgrade(itemData)
  -- Get value of Item in Search Results
  local auctionValue = GetPawnValueItem(itemData)
  local ipos  = ConvertIpos(itemData[Const.IEQUIP])

  local retval = false
  local dStr = ""
  local diff = 0

  -- Using the values from Pawn
  local primaryValue, secondaryValue = GetEquippedVal(itemData)

  -- compare 2-handed weapons against both main hand and off hand combined
  -- unless Titan Grip is available in which case only check primary hand value
  if ipos == Const.EquipEncode["INVTYPE_2HWEAPON"] then
    local bValue = primaryValue + secondaryValue
    local localized_pclass, pclass = UnitClass("player")

    if pclass == "WARRIOR" then -- Check to see if they have the talent Titan Grip
      local titans_localized = GetSpellInfo(46917) -- get the localized name
      local hastitans = GetSpellInfo(titans_localized) -- check to see if it is in the spellbook

      if hastitans then
        bValue = primaryValue
        if secondaryValue < primaryValue then
          bValue = secondaryValue
        end
      end
    end
    if auctionValue > bValue then
      diff = auctionValue - bValue
      retval = true
    end
  else
    -- We are not checking a 2h weapon
    -- Check for Main Slot
    if auctionValue > primaryValue then
      diff = auctionValue - primaryValue
      retval = true
    else -- Check Other Slot (-1 is no secondary slot to check, like feet, neck, head)
      if secondaryValue ~= -1 and auctionValue > secondaryValue then
        diff = auctionValue - secondaryValue
        retval = true
      end
    end
  end

  -- example output
  -- if false: return back false, ""
  -- if true: return back true, "  20.52"
  if retval then
    -- What kind of choice should we present
    local usebuyout = get("search.pawn.buyout")
    local bestprice = get("search.pawn.bestprice")

    if bestprice then
      local buyout = itemData[Const.BUYOUT]
      local bid = itemData[Const.BID]

      if buyout == nil then
        buyout = 0
      end

      if bid == nil then
        bid = 0
      end

      local price = bid

      if usebuyout then
        price = buyout
      end
      dStr = string.format("+%7.2f", (100*diff) / (price/10000))
    else
      dStr = string.format("+%7.2f", diff)
    end
  end
  return retval, dStr
end -- function IsUpgrade(itemData)

-------------------------------------------------------------------
-- This function is automatically called by Auctioneer
-- when the user first clicks Pawn in the search list
-------------------------------------------------------------------
function lib:MakeGuiConfig(gui)
  -- Get our tab and populate it with our controls
  local id = gui:AddTab(lib.tabname, "Searchers")

  local armorPrefTable = {}
  table.insert(armorPrefTable, {TEXT("NO_PREF"), TEXT("NO_PREF")})
  table.insert(armorPrefTable, {TEXT("CLOTH"), TEXT("CLOTH")})
  table.insert(armorPrefTable, {TEXT("LEATHER"), TEXT("LEATHER")})
  table.insert(armorPrefTable, {TEXT("MAIL"), TEXT("MAIL")})
  table.insert(armorPrefTable, {TEXT("PLATE"), TEXT("PLATE")})

  -- Add the help
  gui:AddSearcher("Pawn", TEXT("MAIN_TITLE"), 100)
  gui:AddHelp(id, TEXT("HELP_ID"), TEXT("HELP_QUESTION"), TEXT("HELP_ANSWER"))

  -- Add Header
  gui:AddControl(id, "Header", 0, TEXT("CONFIG_HEADER"))

  -- Store Top of Column position
  local last = gui:GetLast(id)
  gui:AddControl(id, "Subhead", 0, TEXT("OPTIONS"))
  gui:AddControl(id, "Subhead", 0, TEXT("SCALE_SELECT"))
  gui:AddControl(id, "Selectbox",  0, 1, updateScales, "search.pawn.scalenum", "")
  gui:AddTip(id, TEXT("SCALE_SELECT_TIP"))
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.canuse", TEXT("USEABLE_ONLY"))
  gui:AddTip(id, TEXT("USEABLE_ONLY_TIP"))
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.impoor", TEXT("AFFORD_ONLY"))
  gui:AddTip(id, TEXT("AFFORD_ONLY_TIP"))
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.buyout", TEXT("USE_BUYOUT"))
  gui:AddTip(id, TEXT("USE_BUYOUT_TIP"))
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.bestprice", TEXT("USE_BESTPRICE"))
  gui:AddTip(id, TEXT("USE_BESTPRICE_TIP"))
  gui:AddControl(id, "Checkbox",   0, 0, "search.pawn.unenchanted", TEXT("USE_UNENCHANTED"))
  gui:AddTip(id, TEXT("USE_UNENCHANTED_TIP"))
  gui:AddControl(id, "Subhead", 0, TEXT("ARMOR_PREFERENCE"))
  gui:AddControl(id, "Selectbox",  0, 1, armorPrefTable, "search.pawn.armorpref", "")
  gui:AddTip(id, TEXT("ARMORPREF_SELECT_TIP"))

  -- Reposition to top for next column
  gui:SetLast(id,last)
  gui:AddControl(id, "Subhead", 0.40, TEXT("INCLUDE_IN_SEARCH"))

  -- Store new Top of Column position
  last = gui:GetLast(id)
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.head", TEXT("SHOW_HEAD"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.neck", TEXT("SHOW_NECK"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.shoulder", TEXT("SHOW_SHOULDER"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.back", TEXT("SHOW_BACK"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.chest", TEXT("SHOW_CHEST"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.wrist", TEXT("SHOW_WRIST"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.hands", TEXT("SHOW_HANDS"))
  gui:AddControl(id, "Checkbox",   0.40, 0, "search.pawn.waist", TEXT("SHOW_WAIST"))

  -- Reposition to top for next column
  gui:SetLast(id,last)
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.legs", TEXT("SHOW_LEGS"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.feet", TEXT("SHOW_FEET"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.finger", TEXT("SHOW_FINGER"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.trinket", TEXT("SHOW_TRINKET"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.weapon", TEXT("SHOW_WEAPON"))
  gui:AddControl(id, "Checkbox",   0.65, 2, "search.pawn.force2h", TEXT("FORCE2H_WEAP"))
  gui:AddTip(id, TEXT("FORCE2H_TIP"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.offhand", TEXT("SHOW_OFFHAND"))
  gui:AddControl(id, "Checkbox",   0.65, 0, "search.pawn.ranged", TEXT("SHOW_RANGED"))
end

-------------------------------------------------------------------
-- Auctioneer interface.  Each search result is passed into this function
-- Return values:
--      boolean - true / false
--      reason - string if boolean is false, nil otherwise
--             ####  The following return values are only present if boolean is true
--      profit - 0 if AucAdvanced.Modules.Util.PriceLevel is not loaded, nil otherwise
--      delta -  zero padded pawn delta
-------------------------------------------------------------------
function lib.Search(itemData)
  local usebuyout = get("search.pawn.buyout")

  -- What kind of choice should we present
  local reason = TEXT("REASON_BID")
  if usebuyout then
    reason = TEXT("REASON_BUY")
  end

  -- Ensure we have a valid scale chosen
  if not ValidateScale() then
    return false, TEXT("BAD_SCALE")
  else
    -- Check to see if the item is valid and that the user wants it evaluated
    if FilterItem(itemData) then
      return false, TEXT("NOT_WANTED")
    end
  end

  -- Ok At this point we can use the item and possibly can afford it
  -- Check to see if it is an upgrade
  local isUpgrade, dStr = IsUpgrade(itemData)

  if isUpgrade then
    if not AucAdvanced.Modules.Util.PriceLevel then
      return reason,nil,0,dStr
    else
      return reason,nil,nil,dStr
    end
  else
    return false, TEXT("NOT_UPGRADE")
  end
end -- function lib.Search(itemData)
