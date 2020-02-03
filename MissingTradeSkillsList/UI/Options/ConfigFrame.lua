------------------------------------------------------------------
-- Name: ConfigFrame										    --
-- Description: Set values of user options        				--
-- Parent Frame: OptionsMenuFrame              					--
------------------------------------------------------------------

MTSLOPTUI_CONFIG_FRAME = {
    FRAME_WIDTH = 840,
    FRAME_HEIGHT = 325,
    MARGIN_LEFT = 25,
    MARGIN_RIGHT = 175,
    split_modes = {
        MTSL,
        ACCOUNT,
        DATABASE,
        NPC,
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

        local margin_top = -3
        self:InitialiseOptionsWelcomeMessage(margin_top)
        margin_top = margin_top - 25
        self:InitialiseOptionsAutoShowMTSL(margin_top)
        margin_top = margin_top - 40
        self:InitialiseOptionsMinimap(margin_top)
        margin_top = margin_top - 40
        -- Disabled, due to back to hard coded pathc level
        -- self:InitialiseOptionsMTSLPatchLevel(margin_top)
        self:InitialiseOptionsTooltip(margin_top)
        margin_top = margin_top - 30
        self:InitialiseOptionsMTSLFrameLocation(margin_top)
        margin_top = margin_top - 50
        self:InitialiseOptionsUISplitOrientation(margin_top)
        margin_top = margin_top - 50
        self:InitialiseOptionsUISplitScale(margin_top)
        margin_top = margin_top - 50
        self:InitialiseOptionsFonts(margin_top)
    end,

    InitialiseOptionsWelcomeMessage = function(self, margin_top)
        self.ui_frame.welcome_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "Display addon loaded message", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.welcome_check = CreateFrame("CheckButton", "MTSLOPTUI_ConfigFrame_Welcome", self.ui_frame, "ChatConfigCheckButtonTemplate");
        self.welcome_check:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT + 110, margin_top + 5)
        -- ignore the event for ticking checkbox
        self.welcome_check:SetScript("OnClick", function() end)

        if MTSLUI_SAVED_VARIABLES:GetShowWelcomeMessage() == 1 then
            self.welcome_check:SetChecked(true)
            -- using false or 0 does not work, has to be nil
        else
            self.welcome_check:SetChecked(nil)
        end
    end,

    InitialiseOptionsAutoShowMTSL = function(self, margin_top)
        self.ui_frame.autoshow_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "Auto show MTSL", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.autoshow_check = CreateFrame("CheckButton", "MTSLOPTUI_ConfigFrame_AutoShow", self.ui_frame, "ChatConfigCheckButtonTemplate");
        self.autoshow_check:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT + 110, margin_top + 5)
        -- ignore the event for ticking checkbox
        self.autoshow_check:SetScript("OnClick", function() end)

        if MTSLUI_SAVED_VARIABLES:GetAutoShowMTSL() == 1 then
            self.autoshow_check:SetChecked(true)
        -- using false or 0 does not work, has to be nil
        else
            self.autoshow_check:SetChecked(nil)
        end
    end,

    InitialiseOptionsMinimap = function(self, margin_top)
        self.ui_frame.minimap_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "Minimap icon", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.minimap_button_check = CreateFrame("CheckButton", "MTSLOPTUI_ConfigFrame_Minimap", self.ui_frame, "ChatConfigCheckButtonTemplate");
        self.minimap_button_check:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT + 110, margin_top + 5)
        -- ignore the event for ticking checkbox
        self.minimap_button_check:SetScript("OnClick", function() end)

        if MTSLUI_SAVED_VARIABLES:GetMinimapButtonActive() == 1 then
            self.minimap_button_check:SetChecked(true)
            -- using false or 0 does not work, has to be nil
        else
            self.minimap_button_check:SetChecked(nil)
        end

        -- UI Split Orientation
        self.minimap_shapes = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("circle"),
                ["id"] = "circle",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("square"),
                ["id"] = "square",
            }
        }

        -- drop downs minimap shape
        self.minimap_shape = MTSLUI_SAVED_VARIABLES:GetMinimapShape()
        self.ui_frame.minimap_shape_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_MINIMAP_SHAPE", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.minimap_shape_drop_down:SetPoint("TOPLEFT", self.minimap_button_check, "TOPRIGHT", -5, 2)
        self.ui_frame.minimap_shape_drop_down.initialize = self.CreateDropDownMinimapShape
        UIDropDownMenu_SetWidth(self.ui_frame.minimap_shape_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.minimap_shape_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(MTSLUI_SAVED_VARIABLES:GetMinimapShape()))

        self.ui_frame.minimap_shape_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.minimap_shape_drop_down, "Shape", 0, 20, "LABEL", "CENTER")

        self.minimap_radiuses = {}

        local current_radius = tonumber(MTSLUI_SAVED_VARIABLES.MIN_MINIMAP_RADIUS)

        while current_radius <= tonumber(MTSLUI_SAVED_VARIABLES.MAX_MINIMAP_RADIUS) do
            local new_radius = {
                ["id"] = current_radius,
                ["name"] = current_radius .. " px",
            }
            -- steps of 1
            current_radius = current_radius + 4
            table.insert(self.minimap_radiuses, new_radius)
        end

        self.ui_frame.minimap_radius_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_MINIMAP_RADIUS", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.minimap_radius_drop_down:SetPoint("TOPLEFT", self.ui_frame.minimap_shape_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.minimap_radius_drop_down.initialize = self.CreateDropDownMinimapButtonRadius
        UIDropDownMenu_SetWidth(self.ui_frame.minimap_radius_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.minimap_radius_drop_down, MTSLUI_SAVED_VARIABLES:GetMinimapButtonRadius() .. " px")

        self.ui_frame.minimap_radius_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.minimap_radius_drop_down, "Radius", 0, 20, "LABEL", "CENTER")

        self.ui_frame.minimap_reset_btn = MTSLUI_TOOLS:CreateBaseFrame("Button", "MTSLOPTUI_MINIMLAP_BTN_RESET", self.ui_frame, "UIPanelButtonTemplate", self.WIDTH_DD + 20, 26)
        self.ui_frame.minimap_reset_btn:SetPoint("TOPLEFT", self.ui_frame.minimap_radius_drop_down, "TOPRIGHT", -5, 0)
        self.ui_frame.minimap_reset_btn:SetText(MTSLUI_TOOLS:GetLocalisedLabel("reset"))
        self.ui_frame.minimap_reset_btn:SetScript("OnClick", function ()
            MTSLUI_MINIMAP:ResetButton()
        end)

        self.ui_frame.minimap_radius_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.minimap_reset_btn, "Position", 0, 20, "LABEL", "CENTER")
    end,

    InitialiseOptionsTooltip = function(self, margin_top)
        self.ui_frame.tooltip_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "Enhance tooltip", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.tooltip_check = CreateFrame("CheckButton", "MTSLOPTUI_ConfigFrame_TooltipEnhance", self.ui_frame, "ChatConfigCheckButtonTemplate");
        self.tooltip_check:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT + 110, margin_top + 5)
        -- ignore the event for ticking checkbox
        self.tooltip_check:SetScript("OnClick", function() end)

        if MTSLUI_SAVED_VARIABLES:GetEnhancedTooltipActive() == 1 then
            self.tooltip_check:SetChecked(true)
            -- using false or 0 does not work, has to be nil
        else
            self.tooltip_check:SetChecked(nil)
        end

        -- UI Split Orientation
        self.tooltip_factions = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("current character"),
                ["id"] = "current character",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("any"),
                ["id"] = "any",
            }
        }

        self.ui_frame.tooltip_faction_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_TOOLTIP_FACTION", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.tooltip_faction_drop_down:SetPoint("TOPLEFT", self.tooltip_check, "TOPRIGHT", -5, 2)
        self.ui_frame.tooltip_faction_drop_down.initialize = self.CreateDropDownTooltipFaction
        UIDropDownMenu_SetWidth(self.ui_frame.tooltip_faction_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.tooltip_faction_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(MTSLUI_SAVED_VARIABLES:GetEnhancedTooltipFaction()))

        self.ui_frame.tooltip_faction_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.tooltip_faction_drop_down, "Factions", 0, 20, "LABEL", "CENTER")
    end,

    InitialiseOptionsMTSLPatchLevel = function (self, margin_top)
        self.patch_levels = {}

        local current_patch_level = MTSL_DATA.MIN_PATCH_LEVEL

        while current_patch_level <= MTSL_DATA.MAX_PATCH_LEVEL do
            local patch_level = {
                ["id"] = current_patch_level,
                ["name"] =  current_patch_level,
            }
            current_patch_level = current_patch_level + 1
            table.insert(self.patch_levels, patch_level)
        end

        -- drop downs split orientation
        self.ui_frame.patch_level_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "Content patch level", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.ui_frame.patch_level_mtsl_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_PATCH_LEVEL_MTSL", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.patch_level_mtsl_drop_down:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT, margin_top + 7)
        self.ui_frame.patch_level_mtsl_drop_down.initialize = self.CreateDropDownPatchLevelMTSL
        UIDropDownMenu_SetWidth(self.ui_frame.patch_level_mtsl_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.patch_level_mtsl_drop_down, MTSL_DATA.CURRENT_PATCH_LEVEL)
    end,

    InitialiseOptionsMTSLFrameLocation = function (self, margin_top)
        -- UI Split Orientation
        self.locations = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("left"),
                ["id"] = "left",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("right"),
                ["id"] = "right",
            }
        }

        -- drop downs split orientation
        self.ui_frame.location_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "MTSL frame location", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.ui_frame.location_mtsl_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_MTSL", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.location_mtsl_drop_down:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT, margin_top + 7)
        self.ui_frame.location_mtsl_drop_down.initialize = self.CreateDropDownLocationMTSL
        UIDropDownMenu_SetWidth(self.ui_frame.location_mtsl_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.location_mtsl_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetMTSLLocation())))
    end,

    InitialiseOptionsUISplitOrientation = function (self, margin_top)
        -- UI Split Orientation
        self.orientations = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("vertical"),
                ["id"] = "Vertical",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("horizontal"),
                ["id"] = "Horizontal",
            }
        }

        -- drop downs split orientation
        self.ui_frame.orientation_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "UI Split orientation", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.ui_frame.orientation_mtsl_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_MTSL", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.orientation_mtsl_drop_down:SetPoint("TOPLEFT", self.ui_frame.location_mtsl_drop_down, "BOTTOMLEFT", 0, -18)
        self.ui_frame.orientation_mtsl_drop_down.initialize = self.CreateDropDownOrientationMTSL
        UIDropDownMenu_SetWidth(self.ui_frame.orientation_mtsl_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.orientation_mtsl_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("MTSL"))))
        -- center text above the dropdown
        self.ui_frame.orientation_mtsl_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.orientation_mtsl_drop_down, "MTSL", 0, 20, "LABEL", "CENTER")

        self.ui_frame.orientation_account_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_ACC", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.orientation_account_drop_down:SetPoint("TOPLEFT", self.ui_frame.orientation_mtsl_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.orientation_account_drop_down.initialize = self.CreateDropDownOrientationAccount
        UIDropDownMenu_SetWidth(self.ui_frame.orientation_account_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.orientation_account_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("ACCOUNT"))))
        -- center text above the dropdown
        self.ui_frame.orientation_account_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.orientation_account_drop_down, "Account Explorer", 0, 22, "LABEL", "CENTER")

        self.ui_frame.orientation_database_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_DB", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.orientation_database_drop_down:SetPoint("TOPLEFT", self.ui_frame.orientation_account_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.orientation_database_drop_down.initialize = self.CreateDropDownOrientationDatabase
        UIDropDownMenu_SetWidth(self.ui_frame.orientation_database_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.orientation_database_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("DATABASE"))))
        -- center text above the dropdown
        self.ui_frame.orientation_database_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.orientation_database_drop_down, "Database Explorer", 0, 22, "LABEL", "CENTER")

        self.ui_frame.orientation_npc_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_ORIENTATION_NPC", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.orientation_npc_drop_down:SetPoint("TOPLEFT", self.ui_frame.orientation_database_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.orientation_npc_drop_down.initialize = self.CreateDropDownOrientationNpc
        UIDropDownMenu_SetWidth(self.ui_frame.orientation_npc_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.orientation_npc_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("NPC"))))
        -- center text above the dropdown
        self.ui_frame.orientation_npc_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.orientation_npc_drop_down, "NPC Explorer", 0, 22, "LABEL", "CENTER")
    end,

    InitialiseOptionsUISplitScale = function (self, margin_top)
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

        self.ui_frame.scale_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "UI Scale", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

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

        self.ui_frame.scale_npc_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_SCALE_NPC", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.scale_npc_drop_down:SetPoint("TOPLEFT", self.ui_frame.scale_database_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.scale_npc_drop_down.initialize = self.CreateDropDownScaleNpc
        UIDropDownMenu_SetWidth(self.ui_frame.scale_npc_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.scale_npc_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("NPC"))
        -- center text above the dropdown
        self.ui_frame.scale_npc_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.scale_npc_drop_down, "NPC Explorer", 0, 22, "LABEL", "CENTER")

        self.ui_frame.scale_optionsmenu_drop_down = CreateFrame("Frame", "MTSLOPTUI_CONFIG_FRAME_DD_SCALE_OPTIONS", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.scale_optionsmenu_drop_down:SetPoint("TOPLEFT", self.ui_frame.scale_npc_drop_down, "TOPRIGHT", -20, 0)
        self.ui_frame.scale_optionsmenu_drop_down.initialize = self.CreateDropDownScaleOptionsMenu
        UIDropDownMenu_SetWidth(self.ui_frame.scale_optionsmenu_drop_down, self.WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.scale_optionsmenu_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("OPTIONSMENU"))
        -- center text above the dropdown
        self.ui_frame.scale_options_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.scale_optionsmenu_drop_down, "Options menu", 0, 22, "LABEL", "CENTER")
    end,

    InitialiseOptionsFonts = function (self, margin_top)
        -- Fonts
        self.font_names = MTSLUI_FONTS.AVAILABLE_FONT_NAMES
        self.font_name =  MTSLUI_PLAYER.FONT.NAME
        self.font_sizes = MTSLUI_FONTS.AVAILABLE_FONT_SIZES
        self.font_size = {
            title = MTSLUI_PLAYER.FONT.SIZE.TITLE,
            label = MTSLUI_PLAYER.FONT.SIZE.LABEL,
            text = MTSLUI_PLAYER.FONT.SIZE.TEXT,
        }

        self.ui_frame.font_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("font") .. " (" .. MTSLUI_TOOLS:GetLocalisedLabel("reload UI") .. ")", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

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
    -- Intialises drop downs for the minimap options
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownMinimapShape = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.minimap_shapes, MTSLOPTUI_CONFIG_FRAME.ChangeMinimapShapeHandler)
    end,

    CreateDropDownMinimapButtonRadius = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.minimap_radiuses, MTSLOPTUI_CONFIG_FRAME.ChangeMinimapButtonRadiusHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for tooltip faction
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownTooltipFaction = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.tooltip_factions, MTSLOPTUI_CONFIG_FRAME.ChangeTooltipFactionHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for patch level mtsl
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownPatchLevelMTSL = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.patch_levels, MTSLOPTUI_CONFIG_FRAME.ChangePatchLevelMTSLHandler)
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

    CreateDropDownOrientationNpc = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.orientations, MTSLOPTUI_CONFIG_FRAME.ChangeOrientationNpcHandler)
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

    CreateDropDownScaleNpc = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.scales, MTSLOPTUI_CONFIG_FRAME.ChangeScaleNpcHandler)
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
    -- Handles DropDown Change event after changing minimap shape
    ----------------------------------------------------------------------------------------------------------
    ChangeMinimapShapeHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeMinimapShape(value, text)
    end,

    ChangeMinimapShape = function(self, value, text)
        self.minimap_shape = value
        UIDropDownMenu_SetText(self.ui_frame.minimap_shape_drop_down, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the minimap button radius
    ----------------------------------------------------------------------------------------------------------
    ChangeMinimapButtonRadiusHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeMinimapButtonRadius(value, text)
    end,

    ChangeMinimapButtonRadius = function(self, value, text)
        self.minimap_radius = value
        UIDropDownMenu_SetText(self.ui_frame.minimap_radius_drop_down, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the patch level
    ----------------------------------------------------------------------------------------------------------
    ChangeTooltipFactionHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeTooltipFaction(value, text)
    end,

    ChangeTooltipFaction = function(self, value, text)
        self.tooltip_faction = value
        UIDropDownMenu_SetText(self.ui_frame.tooltip_faction_drop_down, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the patch level
    ----------------------------------------------------------------------------------------------------------
    ChangePatchLevelMTSLHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangePatchLevel(value, text)
    end,

    ChangePatchLevel = function(self, value, text)
        self.patch_level_mtsl = value
        UIDropDownMenu_SetText(self.ui_frame.patch_level_mtsl_drop_down, text)
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

    ChangeOrientationNpcHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeOrientation("NPC", value, text)
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

    ChangeScaleNpcHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeScale("NPC", value, text)
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
    -- Save the current values
    ----------------------------------------------------------------------------------------------------------
    Save = function(self)
        MTSLUI_SAVED_VARIABLES:SetShowWelcomeMessage(self.welcome_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetAutoShowMTSL(self.autoshow_check:GetChecked())

        MTSLUI_SAVED_VARIABLES:SetMinimapShape(self.minimap_shape)
        MTSLUI_SAVED_VARIABLES:SetMinimapButtonRadius(self.minimap_radius)
        MTSLUI_SAVED_VARIABLES:SetMinimapButtonActive(self.minimap_button_check:GetChecked())

        MTSLUI_SAVED_VARIABLES:SetEnhancedTooltipActive(self.tooltip_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetEnhancedTooltipFaction(self.tooltip_faction)

        MTSLUI_SAVED_VARIABLES:SetMTSLLocation(self.location_mtsl)

        MTSLUI_SAVED_VARIABLES:SetSplitModes(self.split_modes)
        MTSLUI_SAVED_VARIABLES:SetUIScales(self.ui_scales)

        -- if Font was actually changed, reload ui
        if MTSLUI_SAVED_VARIABLES:SetFont(self.font_name, self.font_size) == true then
            MTSLUI_FONTS:Initialise()
            ReloadUI()
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Reset the current values
    ----------------------------------------------------------------------------------------------------------
    ResetUI = function(self)
        MTSLUI_SAVED_VARIABLES:SetShowWelcomeMessage(self.welcome_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetAutoShowMTSL(self.autoshow_check:GetChecked())

        MTSLUI_SAVED_VARIABLES:SetMinimapButtonActive(self.minimap_button_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetMinimapShape(self.minimap_shape)
        MTSLUI_SAVED_VARIABLES:SetMinimapButtonRadius(self.minimap_radius)

        MTSLUI_SAVED_VARIABLES:SetEnhancedTooltipActive(self.tooltip_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetEnhancedTooltipFaction(self.tooltip_faction)

        -- MTSLUI_SAVED_VARIABLES:SetPatchLevelMTSL(self.patch_level_mtsl)

        MTSLUI_SAVED_VARIABLES:SetMTSLLocation(self.location_mtsl)

        UIDropDownMenu_SetText(self.ui_frame.orientation_mtsl_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("MTSL"))))
        UIDropDownMenu_SetText(self.ui_frame.orientation_account_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("ACCOUNT"))))
        UIDropDownMenu_SetText(self.ui_frame.orientation_database_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("DATABASE"))))
        UIDropDownMenu_SetText(self.ui_frame.orientation_npc_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(MTSLUI_SAVED_VARIABLES:GetSplitMode("NPC"))))

        UIDropDownMenu_SetText(self.ui_frame.scale_mtsl_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("MTSL"))
        UIDropDownMenu_SetText(self.ui_frame.scale_account_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("ACCOUNT"))
        UIDropDownMenu_SetText(self.ui_frame.scale_database_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("DATABASE"))
        UIDropDownMenu_SetText(self.ui_frame.scale_npc_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("NPC"))
        UIDropDownMenu_SetText(self.ui_frame.scale_optionsmenu_drop_down, MTSLUI_SAVED_VARIABLES:GetUIScaleAsText("OPTIONSMENU"))

        UIDropDownMenu_SetText(self.ui_frame.font_type_drop_down, MTSLUI_PLAYER.FONT.NAME)
        UIDropDownMenu_SetText(self.ui_frame.font_title_drop_down, MTSLUI_PLAYER.FONT.SIZE.TITLE)
        UIDropDownMenu_SetText(self.ui_frame.font_label_drop_down, MTSLUI_PLAYER.FONT.SIZE.LABEL)
        UIDropDownMenu_SetText(self.ui_frame.font_text_drop_down, MTSLUI_PLAYER.FONT.SIZE.TEXT)
    end,
}