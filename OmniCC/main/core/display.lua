-- A cooldown text display
local _, Addon = ...

-- the expected size of an icon
local ICON_SIZE = 36
local DEFAULT_STATE = "seconds"

local After = _G.C_Timer.After
local GetTickTime = _G.GetTickTime
local min = math.min
local round = _G.Round
local UIParent = _G.UIParent

local displays = {}

local Display = Addon:CreateHiddenFrame("Frame")

Display.__index = Display

function Display:Get(owner)
    return displays[owner]
end

function Display:GetOrCreate(owner)
    if not owner then return end

    return displays[owner] or self:Create(owner)
end

function Display:Create(owner)
    local display = setmetatable(Addon:CreateHiddenFrame("Frame", nil, owner), Display)

    display.text = display:CreateFontString(nil, "OVERLAY")
    -- display:UpdateCooldownTextFont()
    -- display:UpdateCooldownTextPosition()

    display:SetScript("OnSizeChanged", self.OnSizeChanged)
    display._onScaleUpdated = function() display:OnScaleChanged() end
    display.cooldowns = {}


    displays[owner] = display
    return display
end

-- adjust font size whenever the timer's size changes
-- and hide if it gets too tiny
function Display:OnSizeChanged()
    local oldSize = self.sizeRatio

    if oldSize ~= self:CalculateSizeRatio() then
        self:UpdateCooldownTextSizeAndColor()
        -- self:UpdateCooldownTextFont()
        -- self:UpdateCooldownTextPosition()
    end
end

-- adjust font size whenever the timer's size changes
-- and hide if it gets too tiny
function Display:OnScaleChanged()
    local oldScale = self.scaleRatio

    if oldScale ~= self:CalculateScaleRatio() then
        self:UpdateCooldownTextSizeAndColor()
    end
end

-- update text when the timer notifies us of a change
function Display:OnTimerTextUpdated(timer, text)
    if timer ~= self.timer then return end

    self.text:SetText(text or "")
end

function Display:OnTimerStateUpdated(timer, state)
    if timer ~= self.timer then return end

    state = state or DEFAULT_STATE

    if self.state ~= state then
        self.state = state
        self:UpdateCooldownTextSizeAndColor()
    end
end

function Display:OnTimerFinished(timer)
    if self.timer == timer then
        local cooldown = self.activeCooldown

        local settings = cooldown._occ_settings
        if settings and (settings.minEffectDuration or 0) <= cooldown._occ_duration then
            Addon.FX:Run(self.activeCooldown, settings.effect or "none")
        end
    end
end

function Display:OnTimerDestroyed(timer)
    if self.timer == timer then
        self:RemoveCooldown(self.activeCooldown)
    end
end

function Display:CalculateSizeRatio()
    local sizeRatio
    local sets = self:GetSettings()

    if sets and sets.scaleText then
        sizeRatio = round(min(self:GetSize())) / ICON_SIZE
    else
        sizeRatio = 1
    end

    self.sizeRatio = sizeRatio

    return sizeRatio
end

function Display:CalculateScaleRatio()
    local scaleRatio = self:GetEffectiveScale() / UIParent:GetEffectiveScale()

    self.scaleRatio = scaleRatio

    return scaleRatio
end

function Display:AddCooldown(cooldown)
    local cooldowns = self.cooldowns
    if not cooldowns[cooldown] then
        cooldowns[cooldown] = true
    end

    self:UpdatePrimaryCooldown()
    self:UpdateTimer()
end

function Display:RemoveCooldown(cooldown)
    local cooldowns = self.cooldowns
    if cooldowns[cooldown] then
        cooldowns[cooldown] = nil

        self:UpdatePrimaryCooldown()
        self:UpdateTimer()
    end
end

function Display:UpdatePrimaryCooldown()
    local cooldown = self:GetCooldownWithHighestPriority()

    if self.activeCooldown ~= cooldown then
        self.activeCooldown = cooldown

        if cooldown then
            self:SetAllPoints(cooldown)
            self:SetFrameLevel(cooldown:GetFrameLevel() + 7)
            self:UpdateCooldownTextFont()
            self:UpdateCooldownTextPosition()
        end
    end
end

function Display:UpdateTimer()
    local oldTimer = self.timer and self.timer
    local oldTimerKey = oldTimer and oldTimer.key

    local newTimer = self.activeCooldown and Addon.Timer:GetOrCreate(self.activeCooldown)
    local newTimerKey = newTimer and newTimer.key

    -- update subscription if we're watching a different timer
    if oldTimer ~= newTimer then
        self.timer = newTimer

        if oldTimer then
            oldTimer:Unsubscribe(self)
        end
    end

    -- only show display if we have a timer to watch
    if newTimer then
        newTimer:Subscribe(self)

        -- only update text if the timer we're watching has changed
        if newTimerKey ~= oldTimerKey then
            self:OnTimerTextUpdated(newTimer, newTimer.text)
            self:OnTimerStateUpdated(newTimer, newTimer.state)
            self:Show()
        end

        -- SUF hack to update scale of frames after cooldowns are set
        After(GetTickTime(), self._onScaleUpdated)
    else
        self:Hide()
    end
end

do
    -- given two cooldown cooldowns, returns the more important one
    local function cooldown_Compare(lhs, rhs)
        if lhs == rhs then
            return lhs
        end

        -- prefer the one that isn't nil
        if rhs == nil then
            return lhs
        end

        if lhs == nil then
            return rhs
        end

        -- prefer cooldownProxies ending first
        local lEnd = lhs._occ_start + lhs._occ_duration
        local rEnd = rhs._occ_start + rhs._occ_duration

        if lEnd < rEnd then
            return lhs
        end

        if lEnd > rEnd then
            return rhs
        end

        -- then check priority
        if lhs._occ_priority < rhs._occ_priority then
            return lhs
        end

        return rhs
    end

    function Display:GetCooldownWithHighestPriority()
        local result

        for cooldown in pairs(self.cooldowns) do
            result = cooldown_Compare(cooldown, result)
        end

        return result
    end
end

function Display:UpdateCooldownText()
    self:UpdateCooldownTextFont()
    self:UpdateCooldownTextPosition()
    self:UpdateCooldownTextSizeAndColor()
end


function Display:UpdateCooldownTextFont()
    local sets = self:GetSettings()
    local text = self.text

    if sets then
        if not text:SetFont(sets.fontFace, sets.fontSize, sets.fontOutline) then
            text:SetFont(STANDARD_TEXT_FONT, sets.fontSize, sets.fontOutline)
        end

        local shadow = sets.fontShadow
        text:SetShadowColor(shadow.r, shadow.g, shadow.b, shadow.a)
        text:SetShadowOffset(shadow.x, shadow.y)
    else
        text:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")
    end
end

-- props:{x, y}
function Display:UpdateCooldownTextPosition()
    local sets = self:GetSettings()

    if sets then
        self.text:ClearAllPoints()
        self.text:SetPoint(sets.anchor, sets.xOff, sets.yOff)
    else
        self.text:ClearAllPoints()
        self.text:SetPoint("CENTER")
    end
end

-- props:{size, scale, state}
function Display:UpdateCooldownTextSizeAndColor()
    local sets = self:GetSettings()
    if not sets then return end

    local sizeRatio = self.sizeRatio or self:CalculateSizeRatio()
    local scaleRatio = self.scaleRatio or self:CalculateScaleRatio()

    local style = sets.textStyles[self.state or DEFAULT_STATE]
    local styleRatio = style and style.scale or 1

    if (sizeRatio * scaleRatio * styleRatio) >= (sets.minSize or 0) then
        self.text:Show()
        self.text:SetScale(sizeRatio * styleRatio)
        self.text:SetTextColor(style.r, style.g, style.b, style.a)
    else
        self.text:Hide()
    end
end

function Display:GetSettings()
    return self.activeCooldown and self.activeCooldown._occ_settings
end

function Display:ForAll(method, ...)
    for _, display in pairs(displays) do
        local func = display[method]
        if type(func) == "function" then
            func(display, ...)
        end
    end
end

function Display:ForActive(method, ...)
    for _, display in pairs(displays) do
        if display.timer ~= nil then
            local func = display[method]
            if type(func) == "function" then
                func(display, ...)
            end
        end
    end
end

-- exports
Addon.Display = Display
