----------------------------------------------------------
-- Name: FilterFrame									--
-- Description: Shows all the filters for a list        --
-- Parent Frame: -          							--
----------------------------------------------------------

MTSLUI_FILTER_FRAME = {
    -- Keeps the current created frame
    ui_frame,
    -- width of the frame
    FRAME_WIDTH_VERTICAL = 385,
    FRAME_WIDTH_HORIZONTAL = 515,
    -- height of the frame
    FRAME_HEIGHT = 110,
    -- keeps track of current phase used for filtering
    current_phase,
    phases= {},
    -- all contintents
    continents = {},
    -- all zones for each contintent
    zones_in_continent = {},
    -- all zones for the current continent
    current_available_zones = {},
    current_contintent_id,
    current_zone_id,
    -- current specialization for profession
    current_profession,
    current_spec_id,
    -- source type to show
    current_source_id,
    -- widhts of the drops downs according to layout
    VERTICAL_WIDTH_DD = 152,
    HORIZONTAL_WIDTH_DD = 217,
    DOUBLE_VERTICAL_WIDTH_DD = 266,
    DOUBLE_HORIZONTAL_WIDTH_DD = 332,
    -- widhts of the search box according to layout
    VERTICAL_WIDTH_TF = 270,
    HORIZONTAL_WIDTH_TF = 398,
    -- Filtering active (flag indicating if changing drop downs has effect, default on)
    filtering_active = 1,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises the MissingSkillsListFrame
    --
    -- @parent_frame		Frame		The parent frame
    ----------------------------------------------------------------------------------------------------------
    Initialise = function(self, parent_frame, filter_frame_name)
        self.filter_frame_name = filter_frame_name
        self:InitialiseData()
        -- create the container frame
        self.ui_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", "", parent_frame, nil, self.FRAME_WIDTH_VERTICAL, self.FRAME_HEIGHT, false)
        -- Search box with button
        self.ui_frame.search_box = CreateFrame("EditBox", filter_frame_name .. "_TF", self.ui_frame)
        self.ui_frame.search_box:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }
        })
        --  Black background
        self.ui_frame.search_box:SetBackdropColor(0,0,0,1)
        -- make cursor appear in the textbox
        self.ui_frame.search_box :SetTextInsets(6, 0, 0, 0)
        self.ui_frame.search_box:SetWidth(self.VERTICAL_WIDTH_TF)
        self.ui_frame.search_box:SetHeight(24)
        self.ui_frame.search_box:SetMultiLine(false)
        self.ui_frame.search_box:SetAutoFocus(false)
        self.ui_frame.search_box:SetMaxLetters(30)
        self.ui_frame.search_box:SetFontObject(GameFontNormal)
        -- search by pressing "enter"
        self.ui_frame.search_box:SetScript("OnEnterPressed", function() _G[filter_frame_name]:SearchRecipes() end)
        self.ui_frame.search_btn = MTSLUI_TOOLS:CreateBaseFrame("Button", "", self.ui_frame, "UIPanelButtonTemplate", self.VERTICAL_WIDTH_DD - 38, 25)
        self.ui_frame.search_btn:SetText(MTSLUI_LOCALES_LABELS["search"][MTSLUI_CURRENT_LANGUAGE])
        self.ui_frame.search_btn:SetScript("OnClick", function() _G[filter_frame_name]:SearchRecipes() end)
        -- create a filter for source type
        self.ui_frame.source_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_LOCALES_LABELS["learned from"][MTSLUI_CURRENT_LANGUAGE], 5, -34, "LABEL", "TOPLEFT")
        self.ui_frame.source_drop_down = CreateFrame("Frame", filter_frame_name .. "_DD_SOURCES", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.source_drop_down.filter_frame_name = filter_frame_name
        self.ui_frame.source_drop_down.initialize = self.CreateDropDownSources
        UIDropDownMenu_SetWidth(self.ui_frame.source_drop_down, 95)
        UIDropDownMenu_SetText(self.ui_frame.source_drop_down, MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE])
        -- default select the "current" phase
        self.current_phase = MTSL_CURRENT_PHASE
        -- create a filter for content phase
        self.ui_frame.phase_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_LOCALES_LABELS["phase"][MTSLUI_CURRENT_LANGUAGE], 215, -34, "LABEL", "TOPLEFT")
        self.ui_frame.phase_drop_down = CreateFrame("Frame", filter_frame_name .. "_DD_PHASES", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.phase_drop_down.filter_frame_name = filter_frame_name
        self.ui_frame.phase_drop_down.initialize = self.CreateDropDownPhases
        UIDropDownMenu_SetWidth(self.ui_frame.phase_drop_down, 95)
        UIDropDownMenu_SetText(self.ui_frame.phase_drop_down, self.phases[self.current_phase]["name"])
        -- Specializations
        self.ui_frame.specs_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_LOCALES_LABELS["specialization"][MTSLUI_CURRENT_LANGUAGE], 5, -64, "LABEL", "TOPLEFT")
        self.ui_frame.specs_drop_down = CreateFrame("Frame", filter_frame_name .. "_DD_SPECS", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.specs_drop_down.filter_frame_name = filter_frame_name
        self.ui_frame.specs_drop_down.initialize = self.CreateDropDownSpecializations
        UIDropDownMenu_SetWidth(self.ui_frame.specs_drop_down, self.DOUBLE_VERTICAL_WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.specs_drop_down, MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE])
        -- Contintents & zones
        self.ui_frame.zone_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_LOCALES_LABELS["zone"][MTSLUI_CURRENT_LANGUAGE], 5, -94, "LABEL", "TOPLEFT")
        -- Continent more split up with types as well, to reduce number of items shown
        self.ui_frame.continent_drop_down = CreateFrame("Frame", filter_frame_name .. "_DD_CONTS", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.continent_drop_down:SetPoint("TOPLEFT", self.ui_frame.zone_text, "TOPRIGHT", -10, 9)
        self.ui_frame.continent_drop_down.filter_frame_name = filter_frame_name
        self.ui_frame.continent_drop_down.initialize = self.CreateDropDownContinents
        UIDropDownMenu_SetWidth(self.ui_frame.continent_drop_down, self.VERTICAL_WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.continent_drop_down, MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE])
        -- default contintent "any" so no need for sub zone to show
        self.ui_frame.zone_drop_down = CreateFrame("Frame", filter_frame_name .. "_DD_ZONES", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.zone_drop_down:SetPoint("TOPLEFT", self.ui_frame.continent_drop_down, "TOPRIGHT", -30, 0)
        self.ui_frame.zone_drop_down.filter_frame_name = filter_frame_name
        self.ui_frame.zone_drop_down.initialize = self.CreateDropDownZones
        UIDropDownMenu_SetWidth(self.ui_frame.zone_drop_down, self.VERTICAL_WIDTH_DD)
        UIDropDownMenu_SetText(self.ui_frame.zone_drop_down, "")
        -- reposition some elements
        self.ui_frame.specs_drop_down:SetPoint("BOTTOMRIGHT", self.ui_frame.zone_drop_down, "TOPRIGHT", 0, -2)
        self.ui_frame.phase_drop_down:SetPoint("BOTTOMRIGHT", self.ui_frame.specs_drop_down, "TOPRIGHT", 0, -2)
        self.ui_frame.source_drop_down:SetPoint("BOTTOMRIGHT", self.ui_frame.continent_drop_down, "TOPRIGHT", 0, 28)
        self.ui_frame.search_btn:SetPoint("BOTTOMRIGHT", self.ui_frame.phase_drop_down, "TOPRIGHT", -15, 2)
        self.ui_frame.search_box:SetPoint("TOPRIGHT", self.ui_frame.search_btn, "TOPLEFT", 0, -1)
        -- enable filtering by default
        self:EnableFiltering()
        -- add it to global vars to access later on
        _G[filter_frame_name] = self
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Reset the filters to default value (when parent window is hidden/closed)
    ----------------------------------------------------------------------------------------------------------
    ResetFilters = function(self)
        -- reset name to search
        self.ui_frame.search_box:SetText("")
        self.ui_frame.search_box:ClearFocus()
        -- reset source type
        self.current_source_id = "any"
        UIDropDownMenu_SetText(self.ui_frame.source_drop_down, MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE])
        -- reset phase to current
        self.current_phase = 1
        UIDropDownMenu_SetText(self.ui_frame.phase_drop_down, MTSLUI_LOCALES_LABELS["current"][MTSLUI_CURRENT_LANGUAGE] .. " (" .. MTSL_CURRENT_PHASE .. ")")
        -- reset specialization
        self.current_spec_id = 0
        UIDropDownMenu_SetText(self.ui_frame.specs_drop_down, MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE])
        -- reset contintent & zone
        self.current_contintent_id = 0
        UIDropDownMenu_SetText(self.ui_frame.continent_drop_down, MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE])
        UIDropDownMenu_SetText(self.ui_frame.zone_drop_down, "")
    end,

    -- Limit the filter for phase to current only
    UseOnlyCurrentPhase = function(self)
        self.phases = {
            {
                ["name"] = MTSLUI_LOCALES_LABELS["current"][MTSLUI_CURRENT_LANGUAGE] .. " (" .. MTSL_CURRENT_PHASE .. ")",
                ["id"] = 1,
            }
        }
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Sets the list frame to handle the changes in filter
    ----------------------------------------------------------------------------------------------------------
    SetListFrame = function(self, list_frame)
        self.list_frame = list_frame
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Build the fixed arrays with all continents & zones available
    ----------------------------------------------------------------------------------------------------------
    InitialiseData = function(self)
        self:BuildPhases()
        self:BuildSources()
        self:BuildSpecializations()
        self:BuildContinents()
        self:BuildZones()
    end,

    BuildPhases = function(self)
        self.phases = {
            {
                ["name"] = MTSLUI_LOCALES_LABELS["current"][MTSLUI_CURRENT_LANGUAGE] .. " (" .. MTSL_CURRENT_PHASE .. ")",
                ["id"] = 1,
            },
            {
                ["name"] = MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = 2,
            }
        }
        self.current_phase = 1
    end,

    BuildSources = function(self)
        self.sources = {
            {
                ["name"] = MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "any",
            },
            {
                ["name"] = MTSLUI_LOCALES_LABELS["trainer"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "trainer",
            },
            {
                ["name"] = MTSLUI_LOCALES_LABELS["drop"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "drop",
            },
            {
                ["name"] = MTSLUI_LOCALES_LABELS["object"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "object",
            },
            {
                ["name"] = MTSLUI_LOCALES_LABELS["quest"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "quest",
            },
            {
                ["name"] = MTSLUI_LOCALES_LABELS["vendor"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = "vendor",
            },
        }
        -- auto select "any" as source
        if self.current_source_id == nil  then
            self.current_source_id = "any"
        end
    end,

    BuildSpecializations = function(self)
        self.specializations = {
            {
                ["name"] = MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = 0,
            },
        }
        -- only add current zone if possible (gives trouble while changing zones or not zone not triggering on load)
        local specs = MTSL_LOGIC_PROFESSION:GetSpecializationsForProfession(self.current_profession)
        -- sort by name
        if MTSL_TOOLS:CountItemsInNamedArray(specs) > 0 then
            table.sort(specs, function(a, b) return  a["name"][MTSLUI_CURRENT_LANGUAGE] < b["name"][MTSLUI_CURRENT_LANGUAGE] end)
            -- add each type of "continent
            for k, v in pairs(specs) do
                local new_specialization = {
                    ["name"] = v["name"][MTSLUI_CURRENT_LANGUAGE],
                    ["id"] = v.id,
                }
                table.insert(self.specializations, new_specialization)
            end
        end
        -- auto select "any" as continent
        if self.current_spec_id == nil  then
            self.current_spec_id = 0
        end
    end,

    BuildContinents = function(self)
        -- build the arrays with contintents and zones
        self.continents = {
            {
                ["name"] = MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = 0,
            },
        }
        -- only add current zone if possible (gives trouble while changing zones or not zone not triggering on load)
        local current_zone_name = GetRealZoneText()
        local current_zone = MTSL_LOGIC_WORLD:GetZoneByName(current_zone_name)
        if current_zone ~= nil then
            local zone_filter = {
                ["name"] = MTSLUI_LOCALES_LABELS["current"][MTSLUI_CURRENT_LANGUAGE] .. " (" .. current_zone_name .. ")",
                -- make id negative for filter later on
                ["id"] = (-1 * current_zone.id),
            }
            table.insert(self.continents, zone_filter)
        end
        -- add each type of "continent
        for k, v in pairs(MTSL_DATA["continents"]) do
            local new_continent = {
                ["name"] = v["name"][MTSLUI_CURRENT_LANGUAGE],
                ["id"] = v.id,
            }
            table.insert(self.continents, new_continent)
        end
        -- auto select "any" as continent
        if self.current_contintent_id == nil  then
            self.current_contintent_id = 0
        end
    end,

    BuildZones = function(self)
        -- build the arrays with contintents and zones
        self.zones_in_continent = {}

        -- add each zone of current "continent unless its "Any" or "Current location"
        for k, c in pairs(MTSL_DATA["continents"]) do
            self.zones_in_continent[c.id] = {}
            for l, z in pairs(MTSL_LOGIC_WORLD:GetZonesInContinentById(c.id)) do
                local new_zone = {
                    ["name"] = z["name"][MTSLUI_CURRENT_LANGUAGE],
                    ["id"] = z.id,
                }
                table.insert(self.zones_in_continent[c.id], new_zone)
            end
            -- sort alfabethical
            table.sort(self.zones_in_continent[c.id], function(a, b) return a.name < b.name end)
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for source types
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownSources = function(self)
        MTSLUI_TOOLS:FillDropDown(_G[self.filter_frame_name].sources, _G[self.filter_frame_name].ChangeSourceHandler, self.filter_frame_name)
    end,

    ChangeSourceHandler = function(self, value, text)
        -- Only trigger update if we change to a different continent
        if value ~= nil and value ~= self.current_source_id then
            self:ChangeSource(value, text)
        end
    end,

    ChangeSource = function(self, id, text)
        self.current_source_id = id
        UIDropDownMenu_SetText(self.ui_frame.source_drop_down, text)
        -- Apply filter if we may
        if self:IsFilteringEnabled() then
            self.list_frame:ChangeSource(id)
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for specializations
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownSpecializations = function(self)
        MTSLUI_TOOLS:FillDropDown(_G[self.filter_frame_name].specializations, _G[self.filter_frame_name].ChangeSpecializationHandler, self.filter_frame_name)
    end,

    ChangeSpecializationHandler = function(self, value, text)
        -- Only trigger update if we change to a different continent
        if value ~= nil and value ~= self.current_spec_id then
            self:ChangeSpecialization(value, text)
        end
    end,

    ChangeSpecialization = function(self, id, text)
        self.current_spec_id = id
        UIDropDownMenu_SetText(self.ui_frame.specs_drop_down, text)
        -- Apply filter if we may
        if self:IsFilteringEnabled() then
            self.list_frame:ChangeSpecialization(id)
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for continents/zones
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownContinents = function(self)
        MTSLUI_TOOLS:FillDropDown(_G[self.filter_frame_name].continents, _G[self.filter_frame_name].ChangeContinentHandler, self.filter_frame_name)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the continent
    ----------------------------------------------------------------------------------------------------------
    ChangeContinentHandler = function(self, value, text)
        -- Only trigger update if we change to a different continent
        if value ~= nil and value ~= self.current_contintent_id then
            self:ChangeContinent(value, text)
        end
    end,

    ChangeContinent = function(self, id, text)
        -- do not set continent id if id < 0 or we choose "Any"
        if id > 0 then
            self.current_contintent_id = id
            -- selected current zone so trigger changezone
        else
            self.current_contintent_id = nil
            -- revert negative id to positive
            self.current_zone_id = math.abs(id)
            self.list_frame:ChangeZone(self.current_zone_id)
        end
        UIDropDownMenu_SetText(self.ui_frame.continent_drop_down, text)

        -- Update the drop down with available zones for this continent
        self.current_available_zones = self.zones_in_continent[id]
        if self.current_available_zones == nil then
            self.current_available_zones = {}
        end
        MTSLUI_TOOLS:FillDropDown(self.current_available_zones, self.ChangeZoneHandler, self.ui_frame.zone_drop_down.filter_frame_name)
        -- auto select first zone in the continent if possible
        if id > 0 then
            local key, zone = next(self.current_available_zones)
            UIDropDownMenu_SetText(self.ui_frame.zone_drop_down, zone.name)
            -- Apply filter if we may
            if self:IsFilteringEnabled() then
                self.list_frame:ChangeZone(zone.id)
            end
        else
            UIDropDownMenu_SetText(self.ui_frame.zone_drop_down, "")
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for zones
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownZones = function(self)
        MTSLUI_TOOLS:FillDropDown(_G[self.filter_frame_name].current_available_zones, _G[self.filter_frame_name].ChangeZoneHandler, self.filter_frame_name)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the zone
    ----------------------------------------------------------------------------------------------------------
    ChangeZoneHandler = function(self, value, text)
        -- Only trigger update if we change to a different zone
        if value ~= nil and value ~= self.current_zone_id then
            self:ChangeZone(value, text)
        end
    end,

    ChangeZone = function(self, id, text)
        self.current_zone_id = id
        UIDropDownMenu_SetText(self.ui_frame.zone_drop_down, text)
        -- Apply filter if we may
        if self:IsFilteringEnabled() then
            self.list_frame:ChangeZone(id)
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for phases
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownPhases = function(self)
        MTSLUI_TOOLS:FillDropDown(_G[self.filter_frame_name].phases, _G[self.filter_frame_name].ChangePhaseHandler, self.filter_frame_name)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the phases
    ----------------------------------------------------------------------------------------------------------
    ChangePhaseHandler = function(self, value, text)
        -- Only trigger update if we change to a different phase
        if value ~= nil and value ~= self.current_phase then
            self:ChangePhase(value, text)
        end
    end,

    ChangePhase = function(self, id, text)
        self.current_phase = id
        UIDropDownMenu_SetText(self.ui_frame.phase_drop_down, text)
        -- change filter to new phase
        local phase = MTSL_CURRENT_PHASE
        if id > 1 then
            phase = MTSL_MAX_PHASE
        end
        -- Apply filter if we may
        if self:IsFilteringEnabled() then
            self.list_frame:ChangePhase(phase)
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Switch to vertical split layout
    ----------------------------------------------------------------------------------------------------------
    ResizeToVerticalMode = function(self)
        self.ui_frame:SetWidth(self.FRAME_WIDTH_VERTICAL)
        self.ui_frame.search_box:SetWidth(self.VERTICAL_WIDTH_TF)
        UIDropDownMenu_SetWidth(self.ui_frame.specs_drop_down, self.DOUBLE_VERTICAL_WIDTH_DD)
        UIDropDownMenu_SetWidth(self.ui_frame.continent_drop_down, self.VERTICAL_WIDTH_DD)
        UIDropDownMenu_SetWidth(self.ui_frame.zone_drop_down, self.VERTICAL_WIDTH_DD)
        self.ui_frame.phase_text:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", 215, -34)
    end,
    ----------------------------------------------------------------------------------------------------------
    -- Switch to horizontal split layout
    ----------------------------------------------------------------------------------------------------------
    ResizeToHorizontalMode = function(self)
        self.ui_frame:SetWidth(self.FRAME_WIDTH_HORIZONTAL)
        self.ui_frame.search_box:SetWidth(self.HORIZONTAL_WIDTH_TF)
        UIDropDownMenu_SetWidth(self.ui_frame.specs_drop_down, self.DOUBLE_HORIZONTAL_WIDTH_DD)
        UIDropDownMenu_SetWidth(self.ui_frame.continent_drop_down, self.HORIZONTAL_WIDTH_DD)
        UIDropDownMenu_SetWidth(self.ui_frame.zone_drop_down, self.HORIZONTAL_WIDTH_DD)
        self.ui_frame.phase_text:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", 280, -34)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Shows if the filtering is enabled
    ----------------------------------------------------------------------------------------------------------
    IsFilteringEnabled = function (self)
        return self.filtering_active == 1
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Enable the filtering
    ----------------------------------------------------------------------------------------------------------
    EnableFiltering = function (self)
        self.filtering_active = 1
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Disable the filtering
    ----------------------------------------------------------------------------------------------------------
    DisableFiltering = function (self)
        self.filtering_active = 0
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Disable the filtering
    ----------------------------------------------------------------------------------------------------------
    GetCurrentZone = function (self)
        return self.current_zone_id
    end,

    ----------------------------------------------------------------------------------------------------------
    -- GetCurrentPhase
    ----------------------------------------------------------------------------------------------------------
    GetCurrentPhase = function(self)
        return self.current_phase
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Change Profession so update specialisations
    ----------------------------------------------------------------------------------------------------------
    ChangeProfession = function(self, profession_name)
        self.current_profession = profession_name
        self.current_spec_id = 0
        UIDropDownMenu_SetText(self.ui_frame.specs_drop_down, MTSLUI_LOCALES_LABELS["any"][MTSLUI_CURRENT_LANGUAGE])
        -- Update the list of specialisations for the current profession
        self:BuildSpecializations()
        self:CreateDropDownSpecializations()
        self.list_frame:ChangeSpecialization(self.current_spec_id)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Search Recipes
    ----------------------------------------------------------------------------------------------------------
    SearchRecipes = function(self)
        -- remove focus field
        self.ui_frame.search_box:ClearFocus()
        self.list_frame:ChangeSearchNameSkill(self.ui_frame.search_box:GetText())
    end,
}