------------------------------------------------------
-- Contains all functions for addon/saved variables --
------------------------------------------------------
----------------------------------
-- Creates all saved variables --
----------------------------------
MTSLUI_PLAYER = {
    UI_SCALE = {
        MTSL,
        ACCOUNT,
        DATABASE,
        NPC,
        OPTIONSMENU,
    },
    UI_SPLIT_MODE = {
        MTSL,
        ACCOUNT,
        DATABASE,
        NPC,
    },
    FONT = {
        NAME,
        SIZE_SMALL,
        SIZE_NORMAL,
        SIZE_LARGE,
    },
    MINIMAP = {
        ACTIVE,
        ANGLE,
        RADIUS,
        SHAPE,
    },
    WELCOME_MSG,
    MTSL_LOCATION,
    AUTO_SHOW_MTSL,
    PATCH_LEVEL_MTSL,
}

MTSLUI_SAVED_VARIABLES = {
    MIN_UI_SCALE = "0.5",
    MAX_UI_SCALE = "1.25",
    DEFAULT_UI_SCALE = "1.00",
    DEFAULT_UI_SPLIT_MODE = "Vertical",
    DEFAULT_SIZE_TEXT = 10,
    DEFAULT_SIZE_LABEL = 11,
    DEFAULT_SIZE_TITLE = 13,
    -- Default at "12 o clock"
    MIN_MINIMAP_ANGLE = 0,
    MAX_MINIMAP_ANGLE = 359,
    DEFAULT_MINIMAP_ANGLE = 90,
    -- Default circle
    DEFAULT_MINIMAP_SHAPE = "circle",
    MIN_MINIMAP_RADIUS = -16,
    MAX_MINIMAP_RADIUS = 32,
    DEFAULT_MINIMAP_RADIUS = 0,

    -- Try and load the values from saved files
    Initialise = function(self)
        -- reset all if not found (first time)
        if MTSLUI_PLAYER == nil then
            self:ResetPlayer()
        else
            -- reset/remove the old splitmode
            if MTSLUI_PLAYER.SPLIT_MODE ~= nil then
                MTSLUI_PLAYER.SPLIT_MODE = nil
            end
            -- only reset the scale
            if MTSLUI_PLAYER.UI_SCALE == nil then
                self:ResetUIScales()
            else
                self:ValidateUIScales()
            end
            -- only reset the split
            if MTSLUI_PLAYER.UI_SPLIT_MODE == nil then
                self:ResetSplitModes()
            else
                self:ValidateSplitModes()
            end

            self:SetShowWelcomeMessage(MTSLUI_PLAYER.WELCOME_MSG)
            self:SetAutoShowMTSL(MTSLUI_PLAYER.AUTO_SHOW_MTSL)
            self:SetPatchLevelMTSL(MTSLUI_PLAYER.PATCH_LEVEL_MTSL)

            if MTSLUI_PLAYER.FONT == nil or type(MTSLUI_PLAYER.FONT) ~= "table" or
                    MTSLUI_PLAYER.FONT.SIZE == nil or type(MTSLUI_PLAYER.FONT.SIZE) ~= "table" then
                self:ResetFont()
            else
                self:ValidateFont()
            end
            -- Intialise our fonts
            MTSLUI_FONTS:Initialise()

            -- only reset the minimap
            if MTSLUI_PLAYER.MINIMAP == nil or MTSLUI_PLAYER.MINIMAP == {} then
                self:ResetMinimap()
            else
                self:ValidateMinimap()
            end

            -- only reset the tooltip
            if MTSLUI_PLAYER.TOOLTIP == nil or MTSLUI_PLAYER.TOOLTIP == {} then
                self:ResetEnhancedTooltip()
            else
                self:ValidateEnhancedTooltip()
            end

            self:SetMTSLLocation(MTSLUI_PLAYER.MTSL_LOCATION)
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Reset the players saved variables
    ------------------------------------------------------------------------------------------------
    ResetPlayer = function(self)
        print(MTSLUI_FONTS.COLORS.TEXT.WARNING .. "MTSL: All saved variables have been reset to default values!")
        MTSLUI_PLAYER = {}
        self:ResetUIScales()
        self:ResetSplitModes()
        self:ResetFont()
        MTSLUI_PLAYER.WELCOME_MSG = 1
        MTSLUI_PLAYER.AUTO_SHOW_MTSL = 1
        MTSLUI_PLAYER.PATCH_LEVEL_MTSL = MTSL_DATA.MIN_PATCH_LEVEL
        self:ResetMinimap()
        self:ResetTooltip()
    end,

    ------------------------------------------------------------------------------------------------
    -- Reset the content of the savedvariable to have a "clean" install
    ------------------------------------------------------------------------------------------------
    ResetSavedVariables = function(self)
        MTSLUI_PLAYER = nil
        self:Initialise()
        self:LoadSavedSplitModes()
        self:LoadSavedUIScales()
        self:LoadSavedFont()
    end,

    ------------------------------------------------------------------------------------------------
    -- Reset all UI scales to the default UI scale
    ------------------------------------------------------------------------------------------------
    ResetUIScales = function(self)
        MTSLUI_PLAYER.UI_SCALE = {}
        MTSLUI_PLAYER.UI_SCALE.MTSL = self.DEFAULT_UI_SCALE
        MTSLUI_PLAYER.UI_SCALE.ACCOUNT = self.DEFAULT_UI_SCALE
        MTSLUI_PLAYER.UI_SCALE.DATABASE = self.DEFAULT_UI_SCALE
        MTSLUI_PLAYER.UI_SCALE.NPC = self.DEFAULT_UI_SCALE
        MTSLUI_PLAYER.UI_SCALE.OPTIONSMENU = self.DEFAULT_UI_SCALE
    end,

    ------------------------------------------------------------------------------------------------
    -- Reset all split modes to the default value
    ------------------------------------------------------------------------------------------------
    ResetSplitModes = function(self)
        MTSLUI_PLAYER.UI_SPLIT_MODE = {}
        MTSLUI_PLAYER.UI_SPLIT_MODE.MTSL = self.DEFAULT_UI_SPLIT_MODE
        MTSLUI_PLAYER.UI_SPLIT_MODE.ACCOUNT = self.DEFAULT_UI_SPLIT_MODE
        MTSLUI_PLAYER.UI_SPLIT_MODE.DATABASE = self.DEFAULT_UI_SPLIT_MODE
        MTSLUI_PLAYER.UI_SPLIT_MODE.NPC = self.DEFAULT_UI_SPLIT_MODE
    end,

    -----------------------------------------------------------------------------------------------
    -- Reset the font to default
    ------------------------------------------------------------------------------------------------
    ResetFont = function(self)
        local font_names = {
            ["frFR"] = "FRIZQT__",
            ["enGB"] = "FRIZQT__",
            ["enUS"] = "FRIZQT__",
            ["deDE"] = "FRIZQT__",
            ["ruRU"] = "FRIZQT___CYR",
            ["esES"] = "FRIZQT__",
            ["esMX"] = "FRIZQT__",
            ["ptBR"] = "FRIZQT__",
            ["koKR"] = "2002",
            ["zhCN"] = "ARKai_T",
            ["zhTW"] = "ARKai_T",
        }
        local font_name = font_names[GetLocale()]
        -- fall back to default
        if font_name == nil then
            font_name = "FRIZQT__"
        end

        MTSLUI_PLAYER.FONT = {}
        MTSLUI_PLAYER.FONT.NAME = font_name .. ".ttf"
        MTSLUI_PLAYER.FONT.SIZE = {}
        MTSLUI_PLAYER.FONT.SIZE.TEXT = self.DEFAULT_SIZE_TEXT
        MTSLUI_PLAYER.FONT.SIZE.LABEL = self.DEFAULT_SIZE_LABEL
        MTSLUI_PLAYER.FONT.SIZE.TITLE = self.DEFAULT_SIZE_TITLE

        print(MTSLUI_FONTS.COLORS.TEXT.WARNING .. "MTSL: Font was reset to default!")
    end,

    ------------------------------------------------------------------------------------------------
    -- Reset all minimap values to default
    ------------------------------------------------------------------------------------------------
    ResetMinimap = function(self)
        MTSLUI_PLAYER.MINIMAP = {}
        MTSLUI_PLAYER.MINIMAP.ACTIVE = 1
        MTSLUI_PLAYER.MINIMAP.ANGLE = self.DEFAULT_MINIMAP_ANGLE
        MTSLUI_PLAYER.MINIMAP.RADIUS = self.DEFAULT_MINIMAP_RADIUS
        MTSLUI_PLAYER.MINIMAP.SHAPE = self.DEFAULT_MINIMAP_SHAPE

        MTSLUI_MINIMAP:Show()
    end,

    ------------------------------------------------------------------------------------------------
    -- Reset all tooltip values to default
    ------------------------------------------------------------------------------------------------
    ResetEnhancedTooltip = function(self)
        MTSLUI_PLAYER.TOOLTIP = {}
        MTSLUI_PLAYER.TOOLTIP.FACTIONS = "current character"
        MTSLUI_PLAYER.TOOLTIP.ACTIVE = 1
    end,
    ------------------------------------------------------------------------------------------------
    -- Load the saved splitmode from saved variable
    ------------------------------------------------------------------------------------------------
    LoadSavedSplitModes = function(self)
        if MTSLUI_PLAYER == nil then
            self:ResetSavedVariables()
        else
            -- convert old to new also
            if MTSLUI_PLAYER.UI_SPLIT_MODE == nil or type(MTSLUI_PLAYER.UI_SPLIT_MODE) ~= "table" then
                self:ResetSplitModes()
                print(MTSLUI_FONTS.COLORS.TEXT.WARNING .. "MTSL: All UI split orientations were reset to " .. self.DEFAULT_UI_SPLIT_MODE .. "!")
            else
                self:ValidateSplitModes()
            end
            self:SetSplitModes(MTSLUI_PLAYER.UI_SPLIT_MODE)
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Validates the saved splitmode from saved variable
    ------------------------------------------------------------------------------------------------
    ValidateSplitModes = function(self)
        local keys_to_check =  { "MTSL", "ACCOUNT", "DATABASE", "NPC" }
        
        for _,k in pairs(keys_to_check) do
            -- reset split mode if not valid
            if not self:IsValidSplitMode(MTSLUI_PLAYER.UI_SPLIT_MODE[k]) then
                MTSLUI_PLAYER.UI_SPLIT_MODE[k] = self.DEFAULT_UI_SPLIT_MODE
                print(MTSLUI_FONTS.COLORS.TEXT.WARNING .. "MTSL: " .. k .. " UI split oritentation was reset " .. self.DEFAULT_UI_SPLIT_MODE .. "!")
            end
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Set the splitmodes of the main windows
    --
    -- @split_modes         Array           List containing the splitmodes for all main windows
    ------------------------------------------------------------------------------------------------
    SetSplitModes = function(self, split_modes)
        local keys_to_check =  { "MTSL", "ACCOUNT", "DATABASE", "NPC" }
        local frames_to_split = {
            MTSL = MTSLUI_MISSING_TRADESKILLS_FRAME,
            ACCOUNT = MTSLUI_ACCOUNT_EXPLORER_FRAME,
            DATABASE = MTSLUI_DATABASE_EXPLORER_FRAME,
            NPC = MTSLUI_NPC_EXPLORER_FRAME,
        }
        for _,k in pairs(keys_to_check) do
            -- apply split mode if valide
            if self:IsValidSplitMode(split_modes[k]) then
                MTSLUI_PLAYER.UI_SPLIT_MODE[k] = split_modes[k]
                frames_to_split[k]:SetSplitOrientation(MTSLUI_PLAYER.UI_SPLIT_MODE[k])
            end
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the splitmode of a frame
    --
    -- return			String          The split orientation for the frame (The number for UI scale (will be > 0.5 and < 1.25)
    ------------------------------------------------------------------------------------------------
    GetSplitMode = function(self, name)
        -- return the splitmode if not nil
        if MTSLUI_PLAYER.UI_SPLIT_MODE[name] ~= nil then
            return MTSLUI_PLAYER.UI_SPLIT_MODE[name]
        end
        -- return default if not found
        return self.DEFAULT_UI_SPLIT_MODE
    end,

    ------------------------------------------------------------------------------------------------
    -- Check if a split orientation mode for UI frame is valid
    --
    -- @ui_scale        Number      The number of the scale (only valid >= 0.5 and <= 1.25)
    ------------------------------------------------------------------------------------------------
    IsValidSplitMode = function(self, split_mode)
        return split_mode == "Vertical" or split_mode == "Horizontal"
    end,

    ------------------------------------------------------------------------------------------------
    -- Load the saved ui scales from saved variable
    ------------------------------------------------------------------------------------------------
    LoadSavedUIScales = function(self)
        if MTSLUI_PLAYER == nil then
            self:ResetSavedVariables()
        else
            -- convert old to new also
            if MTSLUI_PLAYER.UI_SCALE == nil then
                self:ResetUIScales()
                print(MTSLUI_FONTS.COLORS.TEXT.WARNING .. "MTSL: All UI scales were reset to " ..  self.DEFAULT_UI_SCALE .. "!")
            -- Scales are saved, so check if valid
            else
                self:ValidateUIScales()
            end
            -- Set the valid scales for all windows
            self:SetUIScales(MTSLUI_PLAYER.UI_SCALE)
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Validate the saved UI scales from saved variable
    ------------------------------------------------------------------------------------------------
    ValidateUIScales = function(self)
        local keys_to_check =  { "MTSL", "ACCOUNT", "DATABASE", "NPC", "OPTIONSMENU" }

        for _,k in pairs(keys_to_check) do
            -- reset split mode if not valid
            if not self:IsValidUIScale(MTSLUI_PLAYER.UI_SCALE[k]) then
                MTSLUI_PLAYER.UI_SCALE[k] = self.DEFAULT_UI_SCALE
                print(MTSLUI_FONTS.COLORS.TEXT.WARNING .. "MTSL: " .. k .. " UI scale was reset to " ..  self.DEFAULT_UI_SCALE .. "!")
            end
        end
    end,
    
    ------------------------------------------------------------------------------------------------
    -- Check if a value for UI scale is valid
    --
    -- @ui_scale        Number      The number of the scale (must be => MIN_UI_SCALE and <= MAX_UI_SCALE)
    ------------------------------------------------------------------------------------------------
    IsValidUIScale = function(self, ui_scale)
        return ui_scale ~= nil and tonumber(ui_scale) ~= nil and
                tonumber(ui_scale) >= tonumber(self.MIN_UI_SCALE) and tonumber(ui_scale) <= tonumber(self.MAX_UI_SCALE)
    end,

    ------------------------------------------------------------------------------------------------
    -- Scales the UI of the addon
    --
    -- @scale			Number			The number for UI scale (must be => MIN_UI_SCALE and <= MAX_UI_SCALE)
    ------------------------------------------------------------------------------------------------
    SetUIScales = function(self, scales)
        local keys_to_check =  { "MTSL", "ACCOUNT", "DATABASE", "NPC", "OPTIONSMENU" }
        local frames_to_scale = {
            MTSL = MTSLUI_MISSING_TRADESKILLS_FRAME,
            ACCOUNT = MTSLUI_ACCOUNT_EXPLORER_FRAME,
            DATABASE = MTSLUI_DATABASE_EXPLORER_FRAME,
            NPC = MTSLUI_NPC_EXPLORER_FRAME,
            OPTIONSMENU = MTSLUI_OPTIONS_MENU_FRAME,
        }
        
        for _,k in pairs(keys_to_check) do
            -- apply split mode if valide
            if self:IsValidUIScale(scales[k]) then
                MTSLUI_PLAYER.UI_SCALE[k] = tostring(scales[k])
                frames_to_scale[k]:SetUIScale(tonumber(MTSLUI_PLAYER.UI_SCALE[k]))
            end
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets he scale of the UI of the addon
    --
    -- return			Number			The number for UI scale (will be >= MIN_UI_SCALE and <= MAX_UI_SCALE)
    ------------------------------------------------------------------------------------------------
    GetUIScale = function(self, name)
        -- return the scale if not nil
        if MTSLUI_PLAYER.UI_SCALE[name] ~= nil then
             return MTSLUI_PLAYER.UI_SCALE[name]
        end
        -- return default if not found
        return self.DEFAULT_UI_SCALE
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets he scale of the UI of the addon as text to show
    --
    -- return			String			The number for UI scale as percentage text (100 % if not found)
    ------------------------------------------------------------------------------------------------
    GetUIScaleAsText = function(self, name)
        -- return the scale if not nil
        if MTSLUI_PLAYER.UI_SCALE[name] ~= nil then
            return (100*MTSLUI_PLAYER.UI_SCALE[name]) .. " %"
        end
        -- return default if not found
        return (100 * self.DEFAULT_UI_SCALE) .. " %"
    end,

    ------------------------------------------------------------------------------------------------
    -- Load the font from saved variable
    ------------------------------------------------------------------------------------------------
    LoadSavedFont = function(self)
        if MTSLUI_PLAYER == nil then
            self:ResetSavedVariables()
        else
            -- convert old to new also
            if self:ValidateFont() == false then
                self:ResetFont()
            end
            MTSLUI_FONTS:Initialise()
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Validates the saved splitmode from saved variable
    ------------------------------------------------------------------------------------------------
    ValidateFont = function(self)
        -- Check if name of font is valid
        if MTSLUI_PLAYER.FONT.NAME == nil or self:IsValidFontType(MTSLUI_PLAYER.FONT.NAME) == false then
            self:ResetFont()
        end
        -- check the numbers of the each size
        local keys_to_check =  { "TITLE", "LABEL", "TEXT" }

        for _,k in pairs(keys_to_check) do
            if not self:IsValidFontSize(MTSLUI_PLAYER.FONT.SIZE[k]) then
                self:ResetFont()
            end
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Check if a name of the font is valid
    --
    -- @ui_scale        Number      The number of the scale (must be => MIN_UI_SCALE and <= MAX_UI_SCALE)
    ------------------------------------------------------------------------------------------------
    IsValidFontType = function(self, font_name)
        return font_name ~= nil and font_name == "FRIZQT___CYR.ttf" or MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSLUI_FONTS.AVAILABLE_FONT_NAMES, "id", font_name) ~= nil
    end,

    ------------------------------------------------------------------------------------------------
    -- Check if a value for UI scale is valid
    --
    -- @ui_scale        Number      The number of the scale (must be => MIN_UI_SCALE and <= MAX_UI_SCALE)
    ------------------------------------------------------------------------------------------------
    IsValidFontSize = function(self, font_size)
        return font_size ~= nil and tonumber(font_size) >= tonumber(MTSLUI_FONTS.MIN_SIZE) and tonumber(font_size) <= tonumber(MTSLUI_FONTS.MAX_SIZE)
    end,

    ------------------------------------------------------------------------------------------------
    -- Set the font
    --
    -- @font_name           String          The name of the font
    -- @font_sizes          Array           List containing the sizes for the 3 font_sizes used
    --
    -- returns              Boolean         Flag indication if font actually was updated/changed
    ------------------------------------------------------------------------------------------------
    SetFont = function(self, font_name, font_sizes)
        local font_changed = false
        if self:IsValidFontType(font_name) and font_name ~= MTSLUI_PLAYER.FONT.NAME then
            MTSLUI_PLAYER.FONT.NAME = font_name
            font_changed = true
        end

        if self:IsValidFontSize(font_sizes["text"]) and font_sizes["text"] ~= MTSLUI_PLAYER.FONT.SIZE.TEXT then
            MTSLUI_PLAYER.FONT.SIZE.TEXT = tonumber(font_sizes["text"])
            font_changed = true
        end

        if self:IsValidFontSize(font_sizes["label"]) and font_sizes["label"] ~= MTSLUI_PLAYER.FONT.SIZE.LABEL then
            MTSLUI_PLAYER.FONT.SIZE.LABEL = tonumber(font_sizes["label"])
            font_changed = true
        end

        if self:IsValidFontSize(font_sizes["title"]) and font_sizes["title"] ~= MTSLUI_PLAYER.FONT.SIZE.TITLE then
            MTSLUI_PLAYER.FONT.SIZE.TITLE = tonumber(font_sizes["title"])
            font_changed = true
        end

        return font_changed
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the flag to say if we show welcome message or not
    --
    -- @show_welcome        Number          Flag indicating to show or not (1 = yes, 0 = no)
    ------------------------------------------------------------------------------------------------
    SetShowWelcomeMessage = function(self, show_welcome)
        MTSLUI_PLAYER.WELCOME_MSG = 1
        if show_welcome == 0 or show_welcome == false then
            MTSLUI_PLAYER.WELCOME_MSG = 0
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the flag to say if we show welcome message or not
    --
    -- return			Number          Flag indicating to show or not (1 = yes, 0 = no)
    ------------------------------------------------------------------------------------------------
    GetShowWelcomeMessage = function(self)
        return MTSLUI_PLAYER.WELCOME_MSG
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the flag to show MTSL when opening a tradeskillframe/craftframe
    --
    -- @auto_show_mtsl        Number          Flag indicating to show or not (1 = yes, 0 = no)
    ------------------------------------------------------------------------------------------------
    SetAutoShowMTSL = function(self, auto_show_mtsl)
        MTSLUI_PLAYER.AUTO_SHOW_MTSL = 1
        if auto_show_mtsl == nil or auto_show_mtsl == 0 or auto_show_mtsl == false then
            MTSLUI_PLAYER.AUTO_SHOW_MTSL = 0
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the flag to show MTSL when opening a tradeskillframe/craftframe
    --
    -- return			Number          Flag indicating to show or not (1 = yes, 0 = no)
    ------------------------------------------------------------------------------------------------
    GetAutoShowMTSL = function(self)
        return MTSLUI_PLAYER.AUTO_SHOW_MTSL
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets  the location where MTSL is hooked (left or right)
    --
    -- @frame_location        String         The location (default = right)
    ------------------------------------------------------------------------------------------------
    SetMTSLLocation = function(self, frame_location)
        MTSLUI_PLAYER.MTSL_LOCATION = "right"
        if frame_location == "left" then
            MTSLUI_PLAYER.MTSL_LOCATION = "left"
        end
        -- reanchor the button if visible
        if MTSLUI_TOGGLE_BUTTON ~= nil and MTSLUI_TOGGLE_BUTTON:IsShown() then
            MTSLUI_TOGGLE_BUTTON:ReanchorButton()
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the location where MTSL is hooked (left or right)
    --
    -- return			String         The location
    ------------------------------------------------------------------------------------------------
    GetMTSLLocation = function(self)
        return MTSLUI_PLAYER.MTSL_LOCATION
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the number of content patch used to show data
    --
    -- @patch_level        Number          Number between MTSL_DATA.MIN_PATCH_LEVEL and MTSL_DATA.MAX_PATCH_LEVEL
    ------------------------------------------------------------------------------------------------
    SetPatchLevelMTSL = function(self, patch_level)
        MTSLUI_PLAYER.PATCH_LEVEL_MTSL = 1
        if patch_level ~= nil and tonumber(patch_level) < tonumber(MTSL_DATA.MAX_PATCH_LEVEL) then
            MTSLUI_PLAYER.PATCH_LEVEL_MTSL = patch_level
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the number of content patch used to show data
    --
    -- return			Number          The number of content patch
    ------------------------------------------------------------------------------------------------
    GetPatchLevelMTSL = function(self)
        if MTSLUI_PLAYER.PATCH_LEVEL_MTSL == nil then
            MTSLUI_PLAYER.PATCH_LEVEL_MTSL = 1
        end
        return MTSLUI_PLAYER.PATCH_LEVEL_MTSL
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the flag to say if we enhance tooltip or not
    --
    -- @enhance_tooltip        Number          Flag indicating to show or not (1 = yes, 0 = no)
    ------------------------------------------------------------------------------------------------
    SetEnhancedTooltipActive = function(self, enhance_tooltip)
        MTSLUI_PLAYER.TOOLTIP.ACTIVE = 1
        if enhance_tooltip == 0 or enhance_tooltip == false then
            MTSLUI_PLAYER.TOOLTIP.ACTIVE = 0
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the flag to say if we enhance tooltip or not
    --
    -- return			Number          Flag indicating to enhance tooltip or not (1 = yes, 0 = no)
    ------------------------------------------------------------------------------------------------
    GetEnhancedTooltipActive = function(self)
        return MTSLUI_PLAYER.TOOLTIP.ACTIVE
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the factions to show in the ehanced tooltip
    --
    -- @show_factions        String          Factions to show ("any" or "current player")
    ------------------------------------------------------------------------------------------------
    SetEnhancedTooltipFaction = function(self, show_factions)
        MTSLUI_PLAYER.TOOLTIP.FACTIONS = "current character"
        if show_factions == "any" then
            MTSLUI_PLAYER.TOOLTIP.FACTIONS = show_factions
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the factions to show in the ehanced tooltip
    --
    -- return			 String          Factions to show ("any" or "current player")
    ------------------------------------------------------------------------------------------------
    GetEnhancedTooltipFaction = function(self)
        return MTSLUI_PLAYER.TOOLTIP.FACTIONS
    end,

    ValidateEnhancedTooltip = function(self)
        self:SetEnhancedTooltipActive(MTSLUI_PLAYER.TOOLTIP.ACTIVE)
        self:SetEnhancedTooltipFaction(MTSLUI_PLAYER.TOOLTIP.FACTIONS)
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the flag to say if we show minimapbutton or not
    --
    -- @show_minimap        Number          Flag indicating to show or not (1 = yes, 0 = no)
    ------------------------------------------------------------------------------------------------
    SetMinimapButtonActive = function(self, show_minimap)
        MTSLUI_PLAYER.MINIMAP.ACTIVE = 1
        MTSLUI_MINIMAP:Show()
        if show_minimap == 0 or show_minimap == false then
            MTSLUI_PLAYER.MINIMAP.ACTIVE = 0
            MTSLUI_MINIMAP:Hide()
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the flag to say if we show minimapbutton or not
    --
    -- return			Number          Flag indicating to show or not (1 = yes, 0 = no)
    ------------------------------------------------------------------------------------------------
    GetMinimapButtonActive = function(self)
        return MTSLUI_PLAYER.MINIMAP.ACTIVE
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the angle of the button around minimap
    --
    -- return			Number          The angle of the button (0 - 359 degrees)
    ------------------------------------------------------------------------------------------------
    GetMinimapButtonAngle = function(self)
        if MTSLUI_PLAYER.MINIMAP.ANGLE == nil then
            MTSLUI_PLAYER.MINIMAP.ANGLE = self.DEFAULT_MINIMAP_ANGLE
        end
        return MTSLUI_PLAYER.MINIMAP.ANGLE
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the angle of the button around minimap
    --
    -- @new_angle       Number          The new angle (0 - 359 degrees)
    ------------------------------------------------------------------------------------------------
    SetMinimapButtonAngle = function(self, new_angle)
        if new_angle ~= nil then
            MTSLUI_PLAYER.MINIMAP.ANGLE = self.MIN_MINIMAP_ANGLE
            if tonumber(new_angle) <= self.MAX_MINIMAP_ANGLE then
                MTSLUI_PLAYER.MINIMAP.ANGLE = new_angle
            end
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the shape of the minimap
    --
    -- return			String          The shape of the minimap (C or R)
    ------------------------------------------------------------------------------------------------
    GetMinimapShape = function(self)
        if MTSLUI_PLAYER.MINIMAP.SHAPE == nil then
            MTSLUI_PLAYER.MINIMAP.SHAPE = self.DEFAULT_MINIMAP_SHAPE
        end
        return MTSLUI_PLAYER.MINIMAP.SHAPE
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the shape of the minimap
    --
    -- @new_shape        String          The shape of the minimap (C or R)
    ------------------------------------------------------------------------------------------------
    SetMinimapShape = function(self, new_shape)
        MTSLUI_PLAYER.MINIMAP.SHAPE = "circle"
        if new_shape == "square" then
            MTSLUI_PLAYER.MINIMAP.SHAPE = new_shape
        end
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the radius of the button next to the minimap
    --
    -- return			String          The shape of the minimap (C or R)
    ------------------------------------------------------------------------------------------------
    GetMinimapButtonRadius = function(self)
        if MTSLUI_PLAYER.MINIMAP.RADIUS == nil then
            MTSLUI_PLAYER.MINIMAP.RADIUS = self.DEFAULT_MINIMAP_RADIUS
        end
        return MTSLUI_PLAYER.MINIMAP.RADIUS
    end,

    ------------------------------------------------------------------------------------------------
    -- Sets the radius of the button next to the minimap
    --
    -- @new_radius        number          The radius (number between 0 and 15)
    ------------------------------------------------------------------------------------------------
    SetMinimapButtonRadius = function(self, new_radius)
        if new_radius ~= nil then
            MTSLUI_PLAYER.MINIMAP.RADIUS = self.MIN_MINIMAP_RADIUS
            if tonumber(new_radius) <= self.MAX_MINIMAP_RADIUS then
                MTSLUI_PLAYER.MINIMAP.RADIUS = new_radius
            end
        end
    end,

    ValidateMinimap = function(self)
        self:SetMinimapButtonActive(MTSLUI_PLAYER.MINIMAP.ACTIVE)
        self:SetMinimapShape(MTSLUI_PLAYER.MINIMAP.SHAPE)
        self:SetMinimapButtonRadius(MTSLUI_PLAYER.MINIMAP.RADIUS)
        self:SetMinimapButtonAngle(MTSLUI_PLAYER.MINIMAP.ANGLE)
    end,
}