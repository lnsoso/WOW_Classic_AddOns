------------------------------------------------------------------
-- Name: ConfigFrame										    --
-- Description: Set values of user options        				--
-- Parent Frame: OptionsMenuFrame              					--
------------------------------------------------------------------

MTSLOPTUI_CONFIG_FRAME = {
    FRAME_WIDTH = 715,
    FRAME_HEIGHT = 225,
    MARGIN_LEFT = 25,
    MARGIN_RIGHT = 175,
    split_modes = {
        MTSL,
        ACCOUNT,
        DATABASE,
    },
    ui_scales = {
        MTSL,
        ACCOUNT,
        DATABASE,
        OPTIONSMENU,
    },
    WIDTH_DD = 100,

    show_welcome = 1,

    ---------------------------------------------------------------------------------------
    -- Initialises the titleframe
    ----------------------------------------------------------------------------------------
    Initialise = function (self, parent_frame)
        self.ui_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", "MTSLOPTUI_ConfigFrame", parent_frame, nil, self.FRAME_WIDTH, self.FRAME_HEIGHT, false)
        -- below title frame
        self.ui_frame:SetPoint("TOPLEFT", parent_frame, "BOTTOMLEFT", 0, -5)

        self:InitialiseCheckBoxWelcomeMessage()
        self:InitialiseDropDownsMTSLFrameLocation()
        self:InitialiseDropDownsUISplitOrientation()
        self:InitialiseDropDownsUISplitScale()
        self:InitialiseDropDownsFonts()
    end,

    InitialiseCheckBoxWelcomeMessage = function(self)
        self.ui_frame.welcome_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "Display addon loaded message", self.MARGIN_LEFT, -3, "LABEL", "TOPLEFT")

        self.welcome_check = CreateFrame("CheckButton", "MTSLOPTUI_ConfigFrame_Welcome", self.ui_frame, "ChatConfigCheckButtonTemplate");
        self.welcome_check:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT + 100, 0)
        -- ignore the event for ticking checkbox
        self.welcome_check:SetScript("OnClick", function() end)
        self.welcome_check:SetChecked(MTSLUI_SAVED_VARIABLES:GetShowWelcomeMessage())
    end,

    InitialiseDropDownsMTSLFrameLocation = function (self)
        -- UI Split Orientation
        self.locations = {
            {
                ["name"] = MTSLUI_LOCALES_LABELS["left"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "left",
            },
            {
                ["name"] = MTSLUI_LOCALES_LABELS["right"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "right",
            }
        }

        -- drop downs split orientation
        self.ui_frame.location_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "MTSL frame location", self.MARGIN_LEFT, -40, "LABEL", "TOPLEFT")

        self.ui_frame.location_mtsl_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_MTSL", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.location_mtsl_drop_down:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT, -33)
        self.ui_frame.location_mtsl_drop_down.initialize = self.CreateDropDownLocationMTSL
        UIDropDownMenu_SetWidth(self.ui_frame.location_mtsl_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.location_mtsl_drop_down, MTSLUI_LOCALES_LABELS[string.lower(MTSLUI_SAVED_VARIABLES:GetMTSLLocation())][MTSLUI_CURRENT_LANGUAGE])
    end,

    InitialiseDropDownsUISplitOrientation = function (self)
        -- UI Split Orientation
        self.orientations = {
            {
                ["name"] = MTSLUI_LOCALES_LABELS["vertical"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "Vertical",
            },
            {
                ["name"] = MTSLUI_LOCALES_LABELS["horizontal"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "Horizontal",
            }
        }

        -- drop downs split orientation
        self.ui_frame.orientation_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "UI Split orientation", self.MARGIN_LEFT, -90, "LABEL", "TOPLEFT")

        self.ui_frame.orientation_mtsl_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_MTSL", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.orientation_mtsl_drop_down:SetPoint("TOPLEFT", self.ui_frame.location_mtsl_drop_down, "BOTTOMLEFT", 0, -18)
        self.ui_frame.orientation_mtsl_drop_down.initialize = self.CreateDropDownOrientationMTSL
        UIDropDownMenu_SetWidth(self.ui_frame.orientation_mtsl_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.orientation_mtsl_drop_down, MTSLUI_LOCALES_LABELS[string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("MTSL"))][MTSLUI_CURRENT_LANGUAGE])
        -- center text above the dropdown
        self.ui_frame.orientation_mtsl_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.orientation_mtsl_drop_down, "MTSL", 0, 20, "LABEL", "CENTER")

        self.ui_frame.orientation_account_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_ACC", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.orientation_account_drop_down:SetPoint("TOPLEFT", self.ui_frame.orientation_mtsl_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.orientation_account_drop_down.initialize = self.CreateDropDownOrientationAccount
        UIDropDownMenu_SetWidth(self.ui_frame.orientation_account_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.orientation_account_drop_down, MTSLUI_LOCALES_LABELS[string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("ACCOUNT"))][MTSLUI_CURRENT_LANGUAGE])
        -- center text above the dropdown
        self.ui_frame.orientation_account_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.orientation_account_drop_down, "Account Explorer", 0, 22, "LABEL", "CENTER")

        self.ui_frame.orientation_database_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_DB", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.orientation_database_drop_down:SetPoint("TOPLEFT", self.ui_frame.orientation_account_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.orientation_database_drop_down.initialize = self.CreateDropDownOrientationDatabase
        UIDropDownMenu_SetWidth(self.ui_frame.orientation_database_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.orientation_database_drop_down, MTSLUI_LOCALES_LABELS[string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("DATABASE"))][MTSLUI_CURRENT_LANGUAGE])
        -- center text above the dropdown
        self.ui_frame.orientation_database_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.orientation_database_drop_down, "Database Explorer", 0, 22, "LABEL", "CENTER")
    end,

    InitialiseDropDownsUISplitScale = function (self)
        self.scales = {}

        local current_scale = tonumber(MTSLUI_SAVED_VARIABLES.MIN_UI_SCALE)

        while current_scale <= tonumber(MTSLUI_SAVED_VARIABLES.MAX_UI_SCALE) do
            local new_scale = {
                ["id"] = current_scale,
                ["name"] =  (100*current_scale) .. " %",
            }
            -- steps of 5%
            current_scale = current_scale + 0.05
            table.insert(self.scales, new_scale)
        end

        self.ui_frame.scale_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "UI Scale", self.MARGIN_LEFT, -141, "LABEL", "TOPLEFT")

        self.ui_frame.scale_mtsl_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_SCALE_MTSL", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.scale_mtsl_drop_down:SetPoint("TOPLEFT", self.ui_frame.orientation_mtsl_drop_down, "BOTTOMLEFT", 0, -18)
        self.ui_frame.scale_mtsl_drop_down.initialize = self.CreateDropDownScaleMTSL
        UIDropDownMenu_SetWidth(self.ui_frame.scale_mtsl_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.scale_mtsl_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("MTSL"))
        -- center text above the dropdown
        self.ui_frame.scale_mtsl_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.scale_mtsl_drop_down, "MTSL", 0, 22, "LABEL", "CENTER")

        self.ui_frame.scale_account_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_SCALE_ACC", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.scale_account_drop_down:SetPoint("TOPLEFT", self.ui_frame.scale_mtsl_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.scale_account_drop_down.initialize = self.CreateDropDownScaleAccount
        UIDropDownMenu_SetWidth(self.ui_frame.scale_account_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.scale_account_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("ACCOUNT"))
        -- center text above the dropdown
        self.ui_frame.scale_account_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.scale_account_drop_down, "Account Explorer", 0, 22, "LABEL", "CENTER")

        self.ui_frame.scale_database_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_SCALE_DB", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.scale_database_drop_down:SetPoint("TOPLEFT", self.ui_frame.scale_account_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.scale_database_drop_down.initialize = self.CreateDropDownScaleDatabase
        UIDropDownMenu_SetWidth(self.ui_frame.scale_database_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.scale_database_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("DATABASE"))
        -- center text above the dropdown
        self.ui_frame.scale_database_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.scale_database_drop_down, "Database Explorer", 0, 22, "LABEL", "CENTER")

        self.ui_frame.scale_optionsmenu_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_SCALE_OPTIONS", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.scale_optionsmenu_drop_down:SetPoint("TOPLEFT", self.ui_frame.scale_database_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.scale_optionsmenu_drop_down.initialize = self.CreateDropDownScaleOptionsMenu
        UIDropDownMenu_SetWidth(self.ui_frame.scale_optionsmenu_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.scale_optionsmenu_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("OPTIONSMENU"))
        -- center text above the dropdown
        self.ui_frame.scale_options_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.scale_optionsmenu_drop_down, "Options menu", 0, 22, "LABEL", "CENTER")
    end,

    InitialiseDropDownsFonts = function (self)
        -- Fonts
        self.font_names = MTSLUI_FONTS.AVAILABLE_FONT_NAMES
        self.font_name =  MTSLUI_PLAYER.FONT.NAME
        self.font_sizes = MTSLUI_FONTS.AVAILABLE_FONT_SIZES
        self.font_size = {
            title = MTSLUI_PLAYER.FONT.SIZE.TITLE,
            label = MTSLUI_PLAYER.FONT.SIZE.LABEL,
            text = MTSLUI_PLAYER.FONT.SIZE.TEXT,
        }

        self.ui_frame.font_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_LOCALES_LABELS["font"][MTSLUI_CURRENT_LANGUAGE] .. " (" .. MTSLUI_LOCALES_LABELS["reload UI"][MTSLUI_CURRENT_LANGUAGE] .. ")", self.MARGIN_LEFT, -192, "LABEL", "TOPLEFT")

        self.ui_frame.font_type_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_font_MTSL", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.font_type_drop_down:SetPoint("TOPLEFT", self.ui_frame.scale_mtsl_drop_down, "BOTTOMLEFT", 0, -18)
        self.ui_frame.font_type_drop_down.initialize = self.CreateDropDownFontType
        UIDropDownMenu_SetWidth(self.ui_frame.font_type_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.font_type_drop_down, MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSLUI_FONTS.AVAILABLE_FONT_NAMES, "id", self.font_name).name)
        -- center text above the dropdown
        self.ui_frame.font_type_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.font_type_drop_down, "Type", 0, 22, "LABEL", "CENTER")

        self.ui_frame.font_title_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_font_TITLE", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.font_title_drop_down:SetPoint("TOPLEFT", self.ui_frame.font_type_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.font_title_drop_down.initialize = self.CreateDropDownSizeTitle
        UIDropDownMenu_SetWidth(self.ui_frame.font_title_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.font_title_drop_down, self.font_size.title)
        -- center text above the dropdown
        self.ui_frame.font_title_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.font_title_drop_down, "Title", 0, 22, "LABEL", "CENTER")

        self.ui_frame.font_label_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_font_LABEL", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.font_label_drop_down:SetPoint("TOPLEFT", self.ui_frame.font_title_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.font_label_drop_down.initialize = self.CreateDropDownSizeLabel
        UIDropDownMenu_SetWidth(self.ui_frame.font_label_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.font_label_drop_down, self.font_size.label)
        -- center text above the dropdown
        self.ui_frame.font_label_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.font_label_drop_down, "Label / List", 0, 22, "LABEL", "CENTER")

        self.ui_frame.font_text_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_font_TEXT", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.font_text_drop_down:SetPoint("TOPLEFT", self.ui_frame.font_label_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.font_text_drop_down.initialize = self.CreateDropDownSizeText
        UIDropDownMenu_SetWidth(self.ui_frame.font_text_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.font_text_drop_down, self.font_size.text)
        -- center text above the dropdown
        self.ui_frame.font_options_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.font_text_drop_down, "Text", 0, 22, "LABEL", "CENTER")
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for location mtsl frame
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownLocationMTSL = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.locations, MTSLOPTUI_CONFIG_FRAME.ChangeLocationMTSLHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for split orientation
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownOrientationMTSL = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.orientations, MTSLOPTUI_CONFIG_FRAME.ChangeOrientationMTSLHandler)
    end,

    CreateDropDownOrientationAccount = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.orientations, MTSLOPTUI_CONFIG_FRAME.ChangeOrientationAccountHandler)
    end,

    CreateDropDownOrientationDatabase = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.orientations, MTSLOPTUI_CONFIG_FRAME.ChangeOrientationDatabaseHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for UI scaling
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownScaleMTSL = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.scales, MTSLOPTUI_CONFIG_FRAME.ChangeScaleMTSLHandler)
    end,

    CreateDropDownScaleAccount = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.scales, MTSLOPTUI_CONFIG_FRAME.ChangeScaleAccountHandler)
    end,

    CreateDropDownScaleDatabase = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.scales, MTSLOPTUI_CONFIG_FRAME.ChangeScaleDatabaseHandler)
    end,

    CreateDropDownScaleOptionsMenu = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.scales, MTSLOPTUI_CONFIG_FRAME.ChangeScaleOptionsMenuHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for font
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownFontType = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.font_names, MTSLOPTUI_CONFIG_FRAME.ChangeFontTypeHandler)
    end,

    CreateDropDownSizeTitle = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.font_sizes, MTSLOPTUI_CONFIG_FRAME.ChangeFontSizeTitleHandler)
    end,

    CreateDropDownSizeLabel = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.font_sizes, MTSLOPTUI_CONFIG_FRAME.ChangeFontSizeLabelHandler)
    end,

    CreateDropDownSizeText = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.font_sizes, MTSLOPTUI_CONFIG_FRAME.ChangeFontSizeTextHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the location
    ----------------------------------------------------------------------------------------------------------
    ChangeLocationMTSLHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeLocation(value, text)
    end,

    ChangeLocation = function(self, value, text)
        self.location_mtsl = value
        UIDropDownMenu_SetText(self.ui_frame.location_mtsl_drop_down, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the orientation
    ----------------------------------------------------------------------------------------------------------
    ChangeOrientationMTSLHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeOrientation("MTSL", value, text)
    end,

    ChangeOrientationAccountHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeOrientation("ACCOUNT", value, text)
    end,

    ChangeOrientationDatabaseHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeOrientation("DATABASE", value, text)
    end,

    ChangeOrientation = function(self, dropdown_name, value, text)
        self.split_modes[dropdown_name] = value
        UIDropDownMenu_SetText(self.ui_frame["orientation_" .. string.lower(dropdown_name) .. "_drop_down"], text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the scale
    ----------------------------------------------------------------------------------------------------------
    ChangeScaleMTSLHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeScale("MTSL", value, text)
    end,

    ChangeScaleAccountHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeScale("ACCOUNT", value, text)
    end,

    ChangeScaleDatabaseHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeScale("DATABASE", value, text)
    end,

    ChangeScaleOptionsMenuHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeScale("OPTIONSMENU", value, text)
    end,

    ChangeScale = function(self, dropdown_name, value, text)
        self.ui_scales[dropdown_name] = value
        UIDropDownMenu_SetText(self.ui_frame["scale_" .. string.lower(dropdown_name) .. "_drop_down"], text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the font
    ----------------------------------------------------------------------------------------------------------
    ChangeFontTypeHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeFontType(value, text)
    end,

    ChangeFontSizeTitleHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeFontSize("title", value, text)
    end,

    ChangeFontSizeLabelHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeFontSize("label", value, text)
    end,

    ChangeFontSizeTextHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeFontSize("text", value, text)
    end,

    ChangeFontType = function(self, value, text)
        self.font_name = value
        UIDropDownMenu_SetText(self.ui_frame["font_type_drop_down"], text)
    end,

    ChangeFontSize = function(self, dropdown_name, value, text)
        self.font_size[dropdown_name] = value
        UIDropDownMenu_SetText(self.ui_frame["font_" .. string.lower(dropdown_name) .. "_drop_down"], text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Save the current valures
    ----------------------------------------------------------------------------------------------------------
    Save = function(self)
        MTSLUI_SAVED_VARIABLES:SetShowWelcomeMessage(self.welcome_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetMTSLLocation(self.location_mtsl)

        MTSLUI_SAVED_VARIABLES:SetSplitModes(self.split_modes)
        MTSLUI_SAVED_VARIABLES:SetUIScales(self.ui_scales)

        -- if Font was actualy changed, reload ui
        if MTSLUI_SAVED_VARIABLES:SetFont(self.font_name, self.font_size) == true then
            MTSLUI_FONTS:Initialise()
            ReloadUI()
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Reset the current valures
    ----------------------------------------------------------------------------------------------------------
    ResetUI = function(self)
        MTSLUI_SAVED_VARIABLES:SetShowWelcomeMessage(self.welcome_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetMTSLLocation(self.location_mtsl)

        UIDropDownMenu_SetText(self.ui_frame.orientation_mtsl_drop_down, MTSLUI_LOCALES_LABELS[string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("MTSL"))][MTSLUI_CURRENT_LANGUAGE])
        UIDropDownMenu_SetText(self.ui_frame.orientation_database_drop_down, MTSLUI_LOCALES_LABELS[string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("ACCOUNT"))][MTSLUI_CURRENT_LANGUAGE])
        UIDropDownMenu_SetText(self.ui_frame.orientation_database_drop_down, MTSLUI_LOCALES_LABELS[string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("DATABASE"))][MTSLUI_CURRENT_LANGUAGE])

        UIDropDownMenu_SetText(self.ui_frame.scale_mtsl_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("MTSL"))
        UIDropDownMenu_SetText(self.ui_frame.scale_account_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("ACCOUNT"))
        UIDropDownMenu_SetText(self.ui_frame.scale_database_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("DATABASE"))
        UIDropDownMenu_SetText(self.ui_frame.scale_optionsmenu_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("OPTIONSMENU"))

        UIDropDownMenu_SetText(self.ui_frame.font_type_drop_down, MTSLUI_PLAYER.FONT.NAME)
        UIDropDownMenu_SetText(self.ui_frame.font_title_drop_down, MTSLUI_PLAYER.FONT.SIZE.TITLE)
        UIDropDownMenu_SetText(self.ui_frame.font_label_drop_down, MTSLUI_PLAYER.FONT.SIZE.LABEL)
        UIDropDownMenu_SetText(self.ui_frame.font_text_drop_down, MTSLUI_PLAYER.FONT.SIZE.TEXT)
    end,
}