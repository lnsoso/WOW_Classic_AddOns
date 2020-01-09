-- Number of bags a player has, think it's safe to hardcode it.
local GS_PLAYER_BAG_COUNT = 5
local SPL_BUTTON_Frame = CreateFrame("Frame", nil, UIParent)
local Dialog = LibStub("LibDialog-1.0")
local DEBUG = false

local function verifyName(name)
	if not name or name == "" then
		return false
	end
	return true
end
Dialog:Register("SPL_ADD_BOX", {
  text = 'SupplyBag - 新增背包配置',
  show_while_dead = true,
  is_exclusive = true,

  editboxes = {
    {
      label = '配置名称',
      on_enter_pressed = function(self)
        --和确定按钮一样的操作
        local name = self:GetParent().editboxes[1]:GetText()
        if not verifyName(name) then
          return
        end
        save(name)
        Dialog:Dismiss("SPL_ADD_BOX")
      end,
      on_escape_pressed = function(self)
        Dialog:Dismiss("SPL_ADD_BOX")
      end,
      on_text_changed = function(self)
        local name = self:GetParent().editboxes[1]:GetText()
        if verifyName(name) then
          self:GetParent().buttons[1]:Enable()
        else
          self:GetParent().buttons[1]:Disable()
        end
      end,
      auto_focus = true,
      maxLetters = 100,
    },
  },
  buttons = {
    {
      text = ACCEPT,
      on_click = function(self)
        local name = self.editboxes[1]:GetText()
        if not verifyName(name) then
          return
        end
        save(name)
        Dialog:Dismiss("SPL_ADD_BOX")
      end,
    },
    {
      text = CANCEL,
      on_click = function(self)
        Dialog:Dismiss("SPL_ADD_BOX")
      end,
    },
  },
  on_show = function(self)
    local name = self.editboxes[1]:GetText()
    if verifyName( name) then
      self.buttons[1]:Enable()
    else
      self.buttons[1]:Disable()
    end
  end
})

Dialog:Register("SPL_REMOVE_BOX", {
  text = 'SupplyBag - 删除该背包配置 ',
  show_while_dead = true,
  is_exclusive = true,
  buttons = {
    {
      text = ACCEPT,
      on_click = function(self)
        remove(self.data)
        Dialog:Dismiss("SPL_REMOVE_BOX")
      end,
    },
    {
      text = CANCEL,
      on_click = function(self)
        Dialog:Dismiss("SPL_REMOVE_BOX")
      end,
    },
  },
  on_show = function(self)
    local name = self.data
  end
})
--//直接打印table
function printTable(t, n)
  if "table" ~= type(t) then
    return 0
  end
  n = n or 0
  local str_space = ""
  for i = 1, n do
    str_space = str_space.."  "
  end
  print(str_space.."{")
  for k, v in pairs(t) do
    local str_k_v
    if(type(k)=="string")then
      str_k_v = str_space.."  "..tostring(k).." = "
    else
      str_k_v = str_space.."  ["..tostring(k).."] = "
    end
    if "table" == type(v) then
      print(str_k_v)
      printTable(v, n + 1)
    else
      if(type(v)=="string")then
        str_k_v = str_k_v.."\""..tostring(v).."\""
      else
        str_k_v = str_k_v..tostring(v)
      end
      print(str_k_v)
    end
  end
  print(str_space.."}")
end

function msgInfo(msg)
  local str = '|cFFFFFF00SupplyBag|r '..msg
  print(str)
end
function msgWarn(msg)
  local str = '|CFFFF8000SupplyBag '..msg..' |r'
  print(str)
end
function msgError(msg)
  local str = '\124cFFFF0000SupplyBag Error!!:|r '..msg
  print(str)
end


--复制table
function clone(org)
  local function copy(org, res)
      for k,v in pairs(org) do
          if type(v) ~= "table" then
              res[k] = v
          else
              res[k] = {}
              copy(v, res[k])
          end
      end
  end

  local res = {}
  copy(org, res)
  return res
end

function getTableLen(tab)
  local count=0
  for k,v in pairs(tab) do
      count = count + 1
  end
  return count
end
--判断table中是否有value
function is_include(value, tbl)
  for k,v in ipairs(tbl) do
    if v == value then
        return true
    end
  end
  return false
end

function isMagicItem(itemID)
  --从这里抓的： https://cn.classic.wowhead.com/consumable-items?filter=9;1;0
  local magicIDList = {1113,1114,1199,1487,2136,2288,3772,5223,5227,5229,5232,5349,5350,5406,5509,5510,5511,5512,5513,8007,8008,8075,8076,8077,8078,8079,9421,14894,16892,16893,16895,16896,19004,19005,19006,19007,19008,19009,19010,19011,19012,19013,19696,21236,22895}
  if is_include(itemID,magicIDList) then
    return true
  end
  return false
end

-- 获取当前包裹的物品清单
function getMyBagsItems()
    local itemList = {}
    -- we loop over the bag indexes
    for bag = 0, GS_PLAYER_BAG_COUNT - 1, 1 do
      for bagSlot = 1, GetContainerNumSlots(bag), 1 do
        local item = GetContainerItemLink(bag, bagSlot)
        local unusedTexture, itemCount = GetContainerItemInfo(bag, bagSlot)

        if (not (item == nil)) then 
          local itemName, itemLink, itemRarity,
          itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
          itemEquipLoc, itemTexture, vendorPrice = GetItemInfo(item)
          local itemFullInfo = {}
          itemFullInfo['itemName'] = itemName
          itemFullInfo['itemCount'] = itemCount
          itemFullInfo['itemStackCount'] = itemStackCount

          table.insert(itemList,itemFullInfo)
        end -- closing if item is not nil

      end -- closing the looping inside a bag
    end -- closing the looping over all bags
    --printTable(itemList)
    return itemList
end

function getConfig(name) 
  return SupplyBagSavedVariablesPerCharacter.data[name]
end
function saveConfig(name,itemList) 
  SupplyBagSavedVariablesPerCharacter.data = SupplyBagSavedVariablesPerCharacter.data or {}
  SupplyBagSavedVariablesPerCharacter.data[name] = itemList
end

function save(name)
    local itemList = {}
    -- we loop over the bag indexes
    for bag = 0, GS_PLAYER_BAG_COUNT - 1, 1 do
      for bagSlot = 1, GetContainerNumSlots(bag), 1 do
        local item = GetContainerItemLink(bag, bagSlot)
        local unusedTexture, itemCount = GetContainerItemInfo(bag, bagSlot)
        local itemID = GetContainerItemID(bag, bagSlot)

        --魔法物品不用存
        if ((not (item == nil)) and (not isMagicItem(itemID))) then 
          local itemName, itemLink, itemRarity,
          itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
          itemEquipLoc, itemTexture, vendorPrice = GetItemInfo(item)
          local curItemInfo = {}
          curItemInfo['itemName'] = itemName
          curItemInfo['itemCount'] = itemCount
          curItemInfo['itemStackCount'] = itemStackCount
          
          -- 还需要增加判断，魔法物品不用存储
          if(itemList[itemName]) then --重复的物品，增加计数
            itemList[itemName]['itemCount'] = itemList[itemName]['itemCount'] + itemCount
          else
            itemList[itemName] = curItemInfo
          end
        end -- closing if item is not nil

      end -- closing the looping inside a bag
    end -- closing the looping over all bags

    saveConfig(name,itemList)
    msgInfo("保存配置 "..name.." 成功")
    initButton(true) -- 重载按钮
end

function list()
  local allList = SupplyBagSavedVariablesPerCharacter.data
  if not allList then
    msgInfo('没有配置')
  else
    local listStr = ''
    for k in pairs(allList) do
      listStr = listStr..k..'\n'
    end
    if string.len(listStr)<=0 then
      msgInfo('没有配置')
    else
      msgInfo('目前已有以下配置: \n'..listStr)
    end
  end
end

function remove(key)
  local allList = SupplyBagSavedVariablesPerCharacter.data
  if not allList then
    msgInfo('没有配置')
  else
    local curConfig = allList[key]
    if not curConfig then
      msgInfo('没有找到配置"'..key..'"')
    else
      allList[key] = nil
      msgInfo('删除配置 '..key..' 成功')
    end
  end
  initButton(true)
end

--needMoveToBank: 如果true，则把背包里其他物品存到银行
function load(key, needMoveToBank)
    if not SupplyBag.bankOpened then
      msgInfo('请打开银行进行补给')
      return
    end
    
    local storeConfig = getConfig(key)
    if not storeConfig then
      msgInfo('没有配置'..key)
      return
    end
    
    local storeItems = clone(storeConfig)
    local storeItemsLen = getTableLen(storeItems)
    local storeDone = 0
    local bagItems = getMyBagsItems()

    local bagEmptySlot = {} --空的背包slot
    local bankEmptySlot = {} -- 空的银行slot

    local needPickToBanksItems = {} -- 需要放到银行的物品
    -- 把背包里面不是的存进银行
    for bag = 0, NUM_BAG_SLOTS do
      for bagSlot = 1, GetContainerNumSlots(bag), 1 do
        local item = GetContainerItemLink(bag, bagSlot)
        local unusedTexture, itemCount = GetContainerItemInfo(bag, bagSlot)
        local itemID = GetContainerItemID(bag, bagSlot)

        if not isMagicItem(itemID) then  --魔法物品不用处理
          if (not (item == nil)) then 
            local itemName, itemLink, itemRarity,
            itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
            itemEquipLoc, itemTexture, vendorPrice = GetItemInfo(item)

            local curStoreItem = storeItems[itemName]
            if(curStoreItem and curStoreItem.itemCount>0) then
              --如果store里有该物品，则保留背包里该物品，并减掉store里的数量
              local count = storeItems[itemName].itemCount - itemCount
              storeItems[itemName].itemCount = count
              if (count<=0) then
                storeDone = storeDone+1
                storeItems[itemName] = nil
              end
            else
              --store里没有该物品，存到银行
              table.insert(needPickToBanksItems,{bag, bagSlot})
            end
          else --空背包先存着，后面取物品需要
            local emptySlot = {bag,bagSlot}
            table.insert(bagEmptySlot,emptySlot)
          end
        end
      end
    end

    --开始从银行里取物品
    -- 5 to 11 for bank bags (numbered left to right, was 5-10 prior to 2.0)
    -- -1是银行原始包，坑
    --https://wowwiki.fandom.com/wiki/BagId
    for bankBag = -1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
      if (bankBag >= 0 and bankBag<NUM_BAG_SLOTS+1) then
        --不是银行背包，不作处理，lua没有continue，先这么着
      else
        for bankBagSlot = 1, GetContainerNumSlots(bankBag), 1 do
          local item = GetContainerItemLink(bankBag, bankBagSlot)
          local unusedTexture, itemCount = GetContainerItemInfo(bankBag, bankBagSlot)
  
          if (not (item == nil)) then 
            local itemName, itemLink, itemRarity,
            itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
            itemEquipLoc, itemTexture, vendorPrice = GetItemInfo(item)
            
            local storeItem = storeItems[itemName]
            if (storeItem and storeItem.itemCount>0) then --需要放到背包
              -- 放到背包
              --PickupContainerItem(bankBag, bankBagSlot)
              local pickCount = math.min(itemCount,storeItem.itemCount)
              SplitContainerItem(bankBag, bankBagSlot,pickCount)
              local emptySlot = bagEmptySlot[1]
              PickupContainerItem(emptySlot[1], emptySlot[2])
              table.remove(bagEmptySlot,1)
              
              local slot = {bankBag, bankBagSlot}
              --table.insert(bankEmptySlot,slot) -- 标记为空的slot--这种空的还不能标记，东西放不进去

              local count = storeItem.itemCount - pickCount
              storeItem.itemCount = count
              if (count<=0) then --如果这个物品都拿完了，就记个数，后面校验是否有缺的物品
                storeItems[itemName] = nil
                storeDone = storeDone+1
              end
            end
          else
            local slot = {bankBag, bankBagSlot}
            table.insert(bankEmptySlot,slot)
          end
        end
      end
    end

    --把背包里多余的东西移到银行
    if (needMoveToBank) then
      while #needPickToBanksItems>0 do
        if #bankEmptySlot>0 then
          local bagsItem = needPickToBanksItems[1]
          local bankSlot = bankEmptySlot[1]
          
          PickupContainerItem(bagsItem[1], bagsItem[2])
          PickupContainerItem(bankSlot[1], bankSlot[2])
  
          table.remove(needPickToBanksItems,1)
          table.remove(bankEmptySlot,1)
        else
          msgInfo('银行满了')
          break
        end
      end
      
    end
    
    if (storeDone >= storeItemsLen) then --不用从银行取货了
      msgInfo('已经补充完毕')
    else
      local listStr = ''
      for k,v in pairs(storeItems) do
        listStr = listStr..k..'x'..v.itemCount..', '
      end
      msgInfo('还缺少东西没补充: \n'..listStr)
    end

end

--BANKFRAME_OPENED

SLASH_SUPPLYBAG1="/supplybag"
SLASH_SUPPLYBAG2="/spl"
SlashCmdList["SUPPLYBAG"]=function(msg)
    local arr = {}
    for w in string.gmatch(msg, "%S+") do
      table.insert(arr,w)
    end
    local cmd = arr[1]
    local key = arr[2]

    if cmd == 'save' then
        if (not key) then
          msgInfo('请输入要保存的名称')
        else
          save(key)
        end
      elseif cmd == 'list' then
        list()
      elseif cmd == 'load' then
        if (not key) then
          msgInfo('请输入要加载的配置名称')
        else
          load(key)
        end
      elseif cmd == 'loadas' then
        if (not key) then
          msgInfo('请输入要加载的配置名称')
        else
          load(key,true)
        end
      elseif cmd == 'remove' then
        if (not key) then
          msgInfo('请输入要删除的配置名称')
        else
          remove(key)
        end
      else
        --指令不对
        msgInfo('\n /spl save NAME \n /spl load NAME\n /spl remove NAME\n /spl list')
    end
end

SupplyBag = CreateFrame"Frame"
SupplyBag:SetScript("OnEvent", function(self, event, ...) self[event](self,event,...) end)
local version = GetAddOnMetadata("SupplyBag", "Version") or "alpha"
SupplyBag.version = version

function SupplyBag:ADDON_LOADED(event, addon)
	if addon ~= 'SupplyBag' then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	
	SupplyBagSavedVariablesPerCharacter = SupplyBagSavedVariablesPerCharacter or {}
	
	local oldver = SupplyBagSavedVariablesPerCharacter.version
	if oldver ~= version then
		SupplyBagSavedVariablesPerCharacter.version = version
	end
	
  msgInfo(format('%s loaded!', version))
	
	SupplyBag:RegisterEvent"BANKFRAME_OPENED"
	SupplyBag:RegisterEvent"BANKFRAME_CLOSED"
  
  initButton()
end
SupplyBag:RegisterEvent"ADDON_LOADED"

function SupplyBag:BANKFRAME_OPENED()
  SupplyBag.bankOpened = true
  showButton()
end

function SupplyBag:BANKFRAME_CLOSED()
	SupplyBag.bankOpened = false
  hideButton()
end

function showButton()
  SPL_BUTTON_Frame:Show()
end
function hideButton()
  SPL_BUTTON_Frame:Hide()
end
function initButton(needRefresh) 
  --移除旧框架
  if (needRefresh and SPL_BUTTON_Frame) then
    SPL_BUTTON_Frame:Hide()
    SPL_BUTTON_Frame:SetParent(nil)
    SPL_BUTTON_Frame:UnregisterAllEvents()
    SPL_BUTTON_Frame:SetID(0)
    SPL_BUTTON_Frame:ClearAllPoints()
  end
  
  --主框体
  SPL_BUTTON_Frame = CreateFrame("Frame", 'SPL_BUTTON_Frame', UIParent)
  SPL_BUTTON_Frame:SetWidth(1) -- 设置宽度
  SPL_BUTTON_Frame:SetHeight(1) -- 设置高度
  SPL_BUTTON_Frame:SetBackdropColor(0, 0, 0, 0.6) -- 背景材质颜色 (Red, Green, Black, Alpha) 各参数的范围都是 0-1
  SPL_BUTTON_Frame:SetBackdropBorderColor(0, 0, 0, 1)  -- 边框材质颜色 (Red, Green, Black, Alpha) 各参数的范围都是 0-1
  SPL_BUTTON_Frame:SetPoint("TOPLEFT", BankFrame, "BOTTOMLEFT", 10, 0)
  SPL_BUTTON_Frame:SetBackdrop({
    --bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    --edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 2,
    edgeSize = 2,
    insets = { left = 1, right = 1, top = 1, bottom = 1 }
  })
  --设置框体移动
  SPL_BUTTON_Frame:SetClampedToScreen(true)
  SPL_BUTTON_Frame:SetMovable(true)
  --SPL_BUTTON_Frame:SetUserPlaced(false)  --这个设置成true就不会保存移动后的位置
  SPL_BUTTON_Frame:EnableMouse(true)
  SPL_BUTTON_Frame:RegisterForDrag("LeftButton","RightButton")
  
  if not SupplyBag.bankOpened then --银行打开时才显示
    if not DEBUG then --调试模式不隐藏
      hideButton()
    end
  else
    showButton()
  end
  
  
  local allList = SupplyBagSavedVariablesPerCharacter.data
  local buttonSN = 0
  if not allList then
    --msgInfo('没有配置')
  else
    --根据用户配置生成按钮
    for k in pairs(allList) do
      local button = CreateFrame("Button", k, SPL_BUTTON_Frame, "UIPanelButtonTemplate")
      button:EnableMouse(true)
      button:SetSize(30 ,22) -- width, height
      button:SetPoint("LEFT", SPL_BUTTON_Frame, "LEFT", buttonSN*28, 0)
      button:SetText(buttonSN+1)
      button:SetScript("OnMouseDown", function(self, button)
        local name = self:GetName()
        if button == 'LeftButton' then --左键，加载配置，并清理背包
          if IsControlKeyDown() then --按下ctrl键时，触发删除
            Dialog:Spawn('SPL_REMOVE_BOX',name)
          else
            load(name,true)
          end
        elseif(button == 'RightButton') then --右键，只加载配置，不清理背包
          load(name)
        end
      end)
      --按钮提示语
      button:SetScript('OnEnter',function(self)
        GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
        GameTooltip:SetText('背包配置: '..self:GetName(), 1, 1, 1)
        GameTooltip:AddLine('鼠标左键点击 : 加载并清理背包', 0, 1, 0)
        GameTooltip:AddLine('鼠标右键点击 : 加载配置', 0, 1, 0)
        GameTooltip:AddLine('ctrl+鼠标左键点击 : 删除配置', 0, 1, 0)
        GameTooltip:Show()
      end)
      button:SetScript('OnLeave',function(self)
        GameTooltip:Hide()
      end)

      buttonSN = buttonSN+1
    end
  end

  -- 新增配置的按钮
  local buttonAdd = CreateFrame("Button", 'SPL_BTN_ADD', SPL_BUTTON_Frame, "UIPanelButtonTemplate")
  buttonAdd:SetSize(30 ,22)
  buttonAdd:SetPoint("LEFT", SPL_BUTTON_Frame, "LEFT", buttonSN*28, 0)
  buttonAdd:SetText('+')
  buttonAdd:SetPoint("CENTER")
  buttonAdd:SetScript("OnClick", function(self)
    Dialog:Spawn('SPL_ADD_BOX')
  end)
  buttonAdd:SetScript('OnEnter',function(self)
    GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
    GameTooltip:SetText( '新增配置' )
    GameTooltip:Show()
  end)
  buttonAdd:SetScript('OnLeave',function(self)
    GameTooltip:Hide()
  end)

  -- 移动按钮
  local buttonMove = CreateFrame("Button", 'SPL_BTN_MOVE', SPL_BUTTON_Frame)
  buttonMove:SetClampedToScreen(true)
  buttonMove:SetSize(20 ,20)
  buttonMove:SetPoint("LEFT", SPL_BUTTON_Frame, "LEFT", (buttonSN+1)*28, 0)
  buttonMove:SetHighlightTexture('Interface\\Buttons\\UI-Common-MouseHilight','ADD')
  buttonMove:SetPoint("CENTER")
  buttonMove:SetScript("OnMouseDown", function(self,button)
    if (button == "LeftButton" and IsAltKeyDown() ) then  -- alt+左键移动框体
      self:GetParent():StartMoving()
    end
  end)
  buttonMove:SetScript("OnMouseUp", function(self)
    self:GetParent():StopMovingOrSizing()
  end)
  buttonMove:SetScript('OnEnter',function(self)
    GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
    GameTooltip:AddLine('Alt+鼠标左键点击 : 移动框体', 0, 1, 0)
    GameTooltip:Show()
  end)
  buttonMove:SetScript('OnLeave',function(self)
    GameTooltip:Hide()
  end)

end