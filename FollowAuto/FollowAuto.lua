local follow = CreateFrame("frame",nil,UIParent)
local configurationPanelCreated = false
--Creat panel



-- set default variable
function loadSettings()
    -- Set a flag as event will repeat
    if settings == nil then
        settings = settings or {}
        settings.followCheck = true
        settings.command = "follow"
        settings.tradeCheck = true
        settings.greyCheck = true
        settings.greenCheck = false
        settings.blueCheck = false
    end
end

DonotSellItem = {
"厚符文布绷带",
"超强治疗药水",
"强效法力药水",
}

function CreatPanel()
    local configurationPanel = CreateFrame("Frame", "MainFrame")
    configurationPanel.name = "AutoFollow"
    InterfaceOptions_AddCategory(configurationPanel)
    -- Title
    local introMessageHeader = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
    introMessageHeader:SetPoint("TOPLEFT", 10, -10)
    introMessageHeader:SetText("AUTOFOLLOW")


    -- subTitle
    local nameTitle = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
    nameTitle:SetPoint("TOPLEFT", 15, -65)
    nameTitle:SetText("followCommand:")

    --Creat a checkButton
    local followCheckBox = CreateFrame("CheckButton","followCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    followCheckBox:SetPoint("TOPLEFT",10, -40)
    getglobal(followCheckBox:GetName().."Text"):SetText("AutoFollow")

    -- Creat a editbox
    local nameBox = CreateFrame("EditBox","FollowUnit", configurationPanel)
    nameBox:SetMultiLine(true)
    nameBox:SetTextInsets(6, 10, 3, 5)
    nameBox:SetFontObject(ChatFontNormal)
    nameBox:SetWidth(80)
    nameBox:SetHeight(18)
    nameBox:SetPoint("TOPLEFT",153, -67)
    nameBox:HighlightText()
    nameBox:SetMaxLetters(10)
    nameBox:SetAutoFocus(false)
    nameBox:SetBackdrop({
        _,
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        _,
        _,
        edgeSize = 10,
        _
    })

    -- Creat option for trade
    -- Title
    local introMessageHeader2 = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
    introMessageHeader2:SetPoint("TOPLEFT", 10, -120)
    introMessageHeader2:SetText("AUTO TRADE GRAY")

    --Creat a checkButton
    local tradeCheckBox = CreateFrame("CheckButton","tradeCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    tradeCheckBox:SetPoint("TOPLEFT",10, -150)
    getglobal(tradeCheckBox:GetName().."Text"):SetText("trade")

    -- Title
    local introMessageHeader3 = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontRedSmall")
    introMessageHeader3:SetPoint("TOPLEFT", 10, -205)
    introMessageHeader3:SetText("CHOOSE TRADE QUAILTY")

    --Creat a checkButton
    local colorCheckBox1 = CreateFrame("CheckButton","colorCheckBox1", configurationPanel, "ChatConfigCheckButtonTemplate")
    colorCheckBox1:SetPoint("TOPLEFT",10, -235)
    getglobal(colorCheckBox1:GetName().."Text"):SetText("grey")
    colorCheckBox1:RegisterForClicks("AnyUp",false)

    --Creat a checkButton
    local colorCheckBox2 = CreateFrame("CheckButton","colorCheckBox2", configurationPanel, "ChatConfigCheckButtonTemplate")
    colorCheckBox2:SetPoint("TOPLEFT",10, -265)
    getglobal(colorCheckBox2:GetName().."Text"):SetText("green")
    colorCheckBox2:RegisterForClicks("AnyUp",false)

    --Creat a checkButton
    local colorCheckBox3 = CreateFrame("CheckButton","colorCheckBox3", configurationPanel, "ChatConfigCheckButtonTemplate")
    colorCheckBox3:SetPoint("TOPLEFT",10, -295)
    getglobal(colorCheckBox3:GetName().."Text"):SetText("blue")
    colorCheckBox3:RegisterForClicks("AnyUp",false)

    -- set click action
    colorCheckBox1:SetScript("OnClick", function(self)
        colorCheckBox1:SetChecked(true)
        colorCheckBox2:SetChecked(false)
        colorCheckBox3:SetChecked(false)
    end)

    colorCheckBox2:SetScript("OnClick", function(self)
        if colorCheckBox2:GetChecked() == false then
            colorCheckBox1:SetChecked(true)
            colorCheckBox2:SetChecked(false)
            colorCheckBox3:SetChecked(false)
        else
            colorCheckBox1:SetChecked(true)
            colorCheckBox2:SetChecked(true)
            colorCheckBox3:SetChecked(false)
        end

    end)

    colorCheckBox3:SetScript("OnClick", function(self)
        if colorCheckBox3:GetChecked() == false then
            colorCheckBox1:SetChecked(true)
            colorCheckBox2:SetChecked(true)
            colorCheckBox3:SetChecked(false)
        else
            colorCheckBox1:SetChecked(true)
            colorCheckBox2:SetChecked(true)
            colorCheckBox3:SetChecked(true)
        end

    end)


    -- OK
    configurationPanel.okay = function(self)
        settings.followCheck = followCheckBox:GetChecked()
        settings.tradeCheck = tradeCheckBox:GetChecked()
        settings.command = nameBox:GetText()
        settings.greyCheck = colorCheckBox1:GetChecked()
        settings.greenCheck = colorCheckBox2:GetChecked()
        settings.blueCheck = colorCheckBox3:GetChecked()

    end

    -- cancel
    configurationPanel.cancel = function(self)
        followCheckBox:SetChecked(settings.followCheck)
        tradeCheckBox:SetChecked(settings.tradeCheck)
        colorCheckBox1:SetChecked(settings.greyCheck)
        colorCheckBox2:SetChecked(settings.greenCheck)
        colorCheckBox3:SetChecked(settings.blueCheck)
        nameBox:SetText(settings.command)


    end

    configurationPanel.cancel()
end


--Check the quality user choosed
function qualityCheck()
    local qualityCount = -1
    if settings.greyCheck == true then
        qualityCount =0
    end
    if settings.greenCheck == true then
        qualityCount = 2
    end
    if settings.blueCheck == true then
        qualityCount = 3
    end
    return qualityCount
end



-- To prevent multipul loading
function follow:followEvent(event,arg1,_,_,_,arg5,_,_,_,_,_,_,_,_)
    if event == "ADDON_LOADED" then

        if configurationPanelCreated == false then
            configurationPanelCreated = true
            loadSettings()
            CreatPanel()
        end

    end
    if settings.followCheck == true then
        if event == "CHAT_MSG_PARTY" or "CHAT_MSG_PARTY_LEADER" then
            if arg1 == settings.command then
                print("Starting follow")
                FollowUnit(arg5)
            end
            if arg1 == "stop" then
                FollowUnit("player")
            end
        end
    end

    if event == "TRADE_SHOW" then
        if settings.tradeCheck == true then
            for bag = 0, 4 do
                for slot = 0, GetContainerNumSlots(bag) do
                    local link = GetContainerItemLink(bag, slot)
                    if link and (select(3, GetItemInfo(link)) <= qualityCheck())  then
                        if select(1, GetItemInfo(link)) ~= "厚符文布绷带" and select(1, GetItemInfo(link)) ~= "超强治疗药水" and select(1, GetItemInfo(link)) ~= "强效法力药水" and select(1, GetItemInfo(link)) ~= "有限无敌药水" and select(1, GetItemInfo(link)) ~= "自然防护药水" and select(1, GetItemInfo(link)) ~= "魔粉" and select(1, GetItemInfo(link)) ~= "传送门符文" and select(1, GetItemInfo(link)) ~= "传送符文" and select(1, GetItemInfo(link)) ~= "魔法晶水" and select(1, GetItemInfo(link)) ~= "魔法甜面包"then
                            UseContainerItem(bag, slot)
                        end
                    end
                end
            end
        end
    end


end


-- Registe event and set script
follow:RegisterEvent("CHAT_MSG_PARTY")
follow:RegisterEvent("ADDON_LOADED")
follow:RegisterEvent("CHAT_MSG_PARTY_LEADER")
follow:RegisterEvent("TRADE_SHOW")
follow:RegisterEvent("PLAYER_LOGIN")

follow:SetScript("OnEvent",follow.followEvent)

-- Set Slash command
SLASH_TEST1 = "/autofollow"
SLASH_TEST2 = "/af"
SlashCmdList["TEST"] = function(msg)
    InterfaceOptionsFrame_OpenToCategory("AutoFollow")
end

