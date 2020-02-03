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
    current_continent_id,
    current_zone_id,
    -- current specialisation for profession
    current_profession,
    current_spec_id,
    -- source type to show
    current_source_id,
    -- widths of the drops downs according to layout
    VERTICAL_WIDTH_DD = 173, -- (+/- half of the width of frame)
    HORIZONTAL_WIDTH_DD = 238,
    -- widths of the search box according to layout
    VERTICAL_WIDTH_TF = 268,
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
        -- Initialise each row of the filter frame
        self:InitialiseFirstRow()
        self:InitialiseSecondRow()
        self:InitialiseThirdRow()
        self:InitialiseFourthRow()
        -- enable filtering by default
        self:EnableFiltering()
        -- save name of each DropDown for access when resizing later
        self.drop_down_names = { "_DD_SOURCES", "_DD_PHASES", "_DD_FACTIONS", "_DD_SPECS", "_DD_CONTS", "_DD_ZONES" }
        -- add it to global vars to access later on
        _G[filter_frame_name] = self
    end,

    ----------------------------------------------------------------------------------------------------------
    -- First row of the filter frame = search bar + button
    ----------------------------------------------------------------------------------------------------------
    InitialiseFirstRow = function (self)
        -- Search box with button
        self.ui_frame.search_box = CreateFrame("EditBox", self.filter_frame_name .. "_TF", self.ui_frame)
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
        self.ui_frame.search_box:SetTextInsets(6, 0, 0, 0)
        self.ui_frame.search_box:SetWidth(self.VERTICAL_WIDTH_TF)
        self.ui_frame.search_box:SetHeight(24)
        self.ui_frame.search_box:SetMultiLine(false)
        self.ui_frame.search_box:SetAutoFocus(false)
        self.ui_frame.search_box:SetMaxLetters(30)
        self.ui_frame.search_box:SetFontObject(GameFontNormal)
        -- search by pressing "enter"
        self.ui_frame.search_box:SetScript("OnEnterPressed", function() _G[self.filter_frame_name]:SearchRecipes() end)
        self.ui_frame.search_btn = MTSLUI_TOOLS:CreateBaseFrame("Button", "", self.ui_frame, "UIPanelButtonTemplate", 118, 25)
        self.ui_frame.search_btn:SetText(MTSLUI_TOOLS:GetLocalisedLabel("search"))
        self.ui_frame.search_btn:SetScript("OnClick", function() _G[self.filter_frame_name]:SearchRecipes() end)
        -- Position the elements
        self.ui_frame.search_box:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", 0, 0)
        self.ui_frame.search_btn:SetPoint("TOPLEFT", self.ui_frame.search_box, "TOPRIGHT", -1, 0)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Second row of the filter frame = drop down source types & drop down phase
    ----------------------------------------------------------------------------------------------------------
    InitialiseSecondRow = function (self)
        -- create a filter for source type
        -- self.ui_frame.source_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("learned from"), 5, -34, "LABEL", "TOPLEFT")
        self.ui_frame.source_drop_down = CreateFrame("Frame", self.filter_frame_name .. "_DD_SOURCES", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.source_drop_down:SetPoint("TOPLEFT", self.ui_frame.search_box, "BOTTOMLEFT", -15, -2)
        self.ui_frame.source_drop_down.filter_frame_name = self.filter_frame_name
        self.ui_frame.source_drop_down.initialize = self.CreateDropDownSources
        UIDropDownMenu_SetText(self.ui_frame.source_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("any source"))
        -- default select the "current" phase
        self.current_phase = MTSL_DATA.CURRENT_PATCH_LEVEL
        -- create a filter for content phase
        -- self.ui_frame.phase_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("phase"), 215, -34, "LABEL", "TOPLEFT")
        self.ui_frame.phase_drop_down = CreateFrame("Frame", self.filter_frame_name .. "_DD_PHASES", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.phase_drop_down:SetPoint("TOPLEFT", self.ui_frame.source_drop_down, "TOPRIGHT", -31, 0)
        self.ui_frame.phase_drop_down.filter_frame_name = self.filter_frame_name
        self.ui_frame.phase_drop_down.initialize = self.CreateDropDownPhases
        UIDropDownMenu_SetText(self.ui_frame.phase_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("current phase") .. " (" .. MTSL_DATA.CURRENT_PATCH_LEVEL .. ")")
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Third row of the filter frame = drop down factions & drop down specialisation
    ----------------------------------------------------------------------------------------------------------
    InitialiseThirdRow = function (self)
        -- Factions drop down
        -- self.ui_frame.factions_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("faction"), 215, -34, "LABEL", "TOPLEFT")
        self.ui_frame.faction_drop_down = CreateFrame("Frame", self.filter_frame_name .. "_DD_FACTIONS", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.faction_drop_down:SetPoint("TOPLEFT", self.ui_frame.source_drop_down, "BOTTOMLEFT", 0, 2)
        self.ui_frame.faction_drop_down.filter_frame_name = self.filter_frame_name
        self.ui_frame.faction_drop_down.initialize = self.CreateDropDownFactions
        UIDropDownMenu_SetText(self.ui_frame.faction_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("any faction"))
        -- Specialisations
        -- self.ui_frame.specs_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("specialisation"), 5, -64, "LABEL", "TOPLEFT")
        self.ui_frame.specialisation_drop_down = CreateFrame("Frame", self.filter_frame_name .. "_DD_SPECS", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.specialisation_drop_down:SetPoint("TOPLEFT", self.ui_frame.faction_drop_down, "TOPRIGHT", -31, 0)
        self.ui_frame.specialisation_drop_down.filter_frame_name = self.filter_frame_name
        self.ui_frame.specialisation_drop_down.initialize = self.CreateDropDownSpecialisations
        UIDropDownMenu_SetText(self.ui_frame.specialisation_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("any specialisation"))
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Fourth row of the filter frame = drop down continents & drop down zone
    ----------------------------------------------------------------------------------------------------------
    InitialiseFourthRow = function (self)
        -- Contintents & zones
        -- self.ui_frame.zone_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("zone"), 5, -94, "LABEL", "TOPLEFT")
        -- Continent more split up with types as well, to reduce number of items shown
        self.ui_frame.continent_drop_down = CreateFrame("Frame", self.filter_frame_name .. "_DD_CONTS", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.continent_drop_down:SetPoint("TOPLEFT", self.ui_frame.faction_drop_down, "BOTTOMLEFT", 0, 2)
        self.ui_frame.continent_drop_down.filter_frame_name = self.filter_frame_name
        self.ui_frame.continent_drop_down.initialize = self.CreateDropDownContinents
        UIDropDownMenu_SetText(self.ui_frame.continent_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("any zone"))
        -- default contintent "any" so no need for sub zone to show
        self.ui_frame.zone_drop_down = CreateFrame("Frame", self.filter_frame_name .. "_DD_ZONES", self.ui_frame, "UIDropDownMenuTemplate")
        self.ui_frame.zone_drop_down:SetPoint("TOPLEFT", self.ui_frame.continent_drop_down, "TOPRIGHT", -31, 0)
        self.ui_frame.zone_drop_down.filter_frame_name = self.filter_frame_name
        self.ui_frame.zone_drop_down.initialize = self.CreateDropDownZones
        UIDropDownMenu_SetText(self.ui_frame.zone_drop_down, "")
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
        UIDropDownMenu_SetText(self.ui_frame.source_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("any"))
        -- reset phase to current
        self.current_phase = MTSL_DATA.CURRENT_PATCH_LEVEL
        UIDropDownMenu_SetText(self.ui_frame.phase_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("current") .. " (" .. MTSL_DATA.CURRENT_PATCH_LEVEL .. ")")
        -- reset specialisation
        self.current_spec_id = 0
        UIDropDownMenu_SetText(self.ui_frame.specialisation_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("any specialisation"))
        -- reset contintent & zone
        self.current_continent_id = 0
        UIDropDownMenu_SetText(self.ui_frame.continent_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("any zone"))
        UIDropDownMenu_SetText(self.ui_frame.zone_drop_down, "")
    end,

    -- Limit the filter for phase to current only
    UseOnlyCurrentPhase = function(self)
        self.phases = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("current phase") .. " (" .. MTSL_DATA.CURRENT_PATCH_LEVEL .. ")",
                ["id"] = MTSL_DATA.CURRENT_PATCH_LEVEL,
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
        self:BuildSpecialisations()
        self:BuildFactions()
        self:BuildContinents()
        self:BuildZones()
    end,

    -- Refresh the label of the current phase (Called after changing in the menu option)
    UpdateCurrentPhase = function(self, new_phase)
        self.phases[1]["name"] = MTSLUI_TOOLS:GetLocalisedLabel("current phase") .. " (" .. new_phase .. ")"
        self.phases[1]["id"] = new_phase
        -- update text in dropdown itself if not any is picked
        if UIDropDownMenu_GetText(self.ui_frame.phase_drop_down) ~= MTSLUI_TOOLS:GetLocalisedLabel("any phase") then
            UIDropDownMenu_SetText(self.ui_frame.phase_drop_down, self.phases[1]["name"])
            -- Trigger Refresh
            self:ChangePhase(new_phase)
        end
    end,

    -- Refresh the label of the current zone (Called after changing zone to a new area in the game EVENT ZONE_NEW_AREA)
    UpdateCurrentZone = function(self, new_zone_name)
        local new_zone = MTSL_LOGIC_WORLD:GetZoneByName(new_zone_name)
        -- only update if we actually found a zone
        if new_zone ~= nil then
            self.continents[2]["name"] = MTSLUI_TOOLS:GetLocalisedLabel("current zone") .. " (" .. new_zone_name .. ")"
            self.continents[2]["id"] = (-1 * new_zone.id)
            -- update text in dropdown itself if current is picked
            if self.current_continent_id == nil and UIDropDownMenu_GetText(self.ui_frame.continent_drop_down) ~= MTSLUI_TOOLS:GetLocalisedLabel("any zone") then
                UIDropDownMenu_SetText(self.ui_frame.continent_drop_down, self.continents[2]["name"])
                self.current_zone_id = new_zone.id
                -- Trigger Refresh
                self.list_frame:ChangeZone(self.current_zone_id)
            end
        end
    end,

    BuildPhases = function(self)
        self.phases = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("current phase") .. " (" .. MTSL_DATA.CURRENT_PATCH_LEVEL .. ")",
                ["id"] = MTSL_DATA.CURRENT_PATCH_LEVEL,
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("any phase"),
                ["id"] = MTSL_DATA.MAX_PATCH_LEVEL,
            }
        }
        -- add any phase between current and max level
        local patch_level = MTSL_DATA.CURRENT_PATCH_LEVEL + 1
        while patch_level < MTSL_DATA.MAX_PATCH_LEVEL do
            local new_phase = {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("phase") .. " " .. patch_level,
                ["id"] = patch_level,
            }
            table.insert(self.phases, new_phase)
            patch_level = patch_level + 1
        end
        self.current_phase = MTSL_DATA.CURRENT_PATCH_LEVEL
    end,

    BuildSources = function(self)
        local source_types = { "any source", "trainer", "drop", "object", "quest", "vendor", "holiday" }
        self.sources = {}
        for _, v in pairs(source_types) do
            local new_source = {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel(v),
                ["id"] = v,
            }
            table.insert(self.sources, new_source)
        end
        -- auto select "any" as source
        if self.current_source_id == nil  then
            self.current_source_id = "any source"
        end
    end,

    BuildFactions = function(self)
        self.factions = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("any faction"),
                ["id"] = 0,
            },
            -- Alliance (id: 469)
            {
                ["name"] =  MTSL_LOGIC_FACTION_REPUTATION:GetFactionNameById(469),
                ["id"] = 469,
            },
            -- Horde (id: 67)
            {
                ["name"] =  MTSL_LOGIC_FACTION_REPUTATION:GetFactionNameById(67),
                ["id"] = 67,
            },
        }
        -- Ids of reputations used for recipes, add those factions too
        local reputation_ids = { 59, 270, 529, 576, 609 }
        local rep_factions = {}
        for _, v in pairs(reputation_ids) do
            local new_faction = {
                ["name"] = MTSL_LOGIC_FACTION_REPUTATION:GetFactionNameById(v),
                ["id"] = v,
            }
           table.insert(rep_factions, new_faction)
        end
        -- Sort them by name
        MTSL_TOOLS:SortArrayByProperty(rep_factions, "name")
        -- Add them sorted to factions
        for _, r in pairs(rep_factions) do
            table.insert(self.factions, r)
        end
        -- auto select "any" as current faction
        if self.current_faction_id == nil  then
            self.current_faction_id = 0
        end
    end,

    BuildSpecialisations = function(self)
        self.specialisations = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("any specialisation"),
                ["id"] = 0,
            },
        }
        -- only add current zone if possible (gives trouble while changing zones or not zone not triggering on load)
        local specs = MTSL_LOGIC_PROFESSION:GetSpecialisationsForProfession(self.current_profession)
        -- sort by name
        if MTSL_TOOLS:CountItemsInNamedArray(specs) > 0 then
            -- if there are specialisations add an option for "no specialisation" too
            local new_specialisation = {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("no specialisation"),
                ["id"] = -1,
            }
            table.insert(self.specialisations, new_specialisation)
            MTSL_TOOLS:SortArrayByLocalisedProperty(specs, "name")
            -- add each type of "continent
            for k, v in pairs(specs) do
                local new_specialisation = {
                    ["name"] = MTSLUI_TOOLS:GetLocalisedData(v),
                    ["id"] = v.id,
                }
                table.insert(self.specialisations, new_specialisation)
            end
        end
        -- auto select "any specialisation"
        if self.current_spec_id == nil  then
            self.current_spec_id = 0
        end
    end,

    BuildContinents = function(self)
        -- build the arrays with continents and zones
        self.continents = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("any zone"),
                ["id"] = 0,
            },
        }
        -- only add current zone if possible (gives trouble while changing zones or not zone not triggering on load)
        local current_zone_name = GetRealZoneText()
        local current_zone = MTSL_LOGIC_WORLD:GetZoneByName(current_zone_name)
        if current_zone ~= nil then
            local zone_filter = {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("current zone") .. " (" .. current_zone_name .. ")",
                -- make id negative for filter later on
                ["id"] = (-1 * current_zone.id),
            }
            table.insert(self.continents, zone_filter)
        end
        -- add each type of "continent
        for k, v in pairs(MTSL_DATA["continents"]) do
            local new_continent = {
                ["name"] = MTSLUI_TOOLS:GetLocalisedData(v),
                ["id"] = v.id,
            }
            table.insert(self.continents, new_continent)
        end
        -- auto select "any" as continent
        if self.current_continent_id == nil  then
            self.current_continent_id = 0
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
                    ["name"] = MTSLUI_TOOLS:GetLocalisedData(z),
                    ["id"] = z.id,
                }
                table.insert(self.zones_in_continent[c.id], new_zone)
            end
            -- sort alfabethical
            MTSL_TOOLS:SortArrayByProperty(self.zones_in_continent[c.id], "name")
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
    -- Intialises drop down for faction types
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownFactions = function(self)
        MTSLUI_TOOLS:FillDropDown(_G[self.filter_frame_name].factions, _G[self.filter_frame_name].ChangeFactionHandler, self.filter_frame_name)
    end,

    ChangeFactionHandler = function(self, value, text)
        -- Only trigger update if we change to a different continent
        if value ~= nil and value ~= self.current_faction_id then
            self:ChangeFaction(value, text)
        end
    end,

    ChangeFaction = function(self, id, text)
        self.current_faction_id = id
        UIDropDownMenu_SetText(self.ui_frame.faction_drop_down, text)
        -- Apply filter if we may
        if self:IsFilteringEnabled() then
            self.list_frame:ChangeFaction(id)
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for specialisations
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownSpecialisations = function(self)
        MTSLUI_TOOLS:FillDropDown(_G[self.filter_frame_name].specialisations, _G[self.filter_frame_name].ChangeSpecialisationHandler, self.filter_frame_name)
    end,

    ChangeSpecialisationHandler = function(self, value, text)
        -- Only trigger update if we change to a different continent
        if value ~= nil and value ~= self.current_spec_id then
            self:ChangeSpecialisation(value, text)
        end
    end,

    ChangeSpecialisation = function(self, id, text)
        self.current_spec_id = id
        UIDropDownMenu_SetText(self.ui_frame.specialisation_drop_down, text)
        -- Apply filter if we may
        if self:IsFilteringEnabled() then
            self.list_frame:ChangeSpecialisation(id)
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
        if value ~= nil and value ~= self.current_continent_id then
            self:ChangeContinent(value, text)
        end
    end,

    ChangeContinent = function(self, id, text)
        -- do not set continent id if id < 0 or we choose "Any"
        if id > 0 then
            self.current_continent_id = id
            -- selected current zone so trigger changezone
        else
            self.current_continent_id = nil
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
        -- Apply filter if we may
        if self:IsFilteringEnabled() then
            self.list_frame:ChangePhase(self.current_phase)
        end
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Switch to vertical split layout
    ----------------------------------------------------------------------------------------------------------
    ResizeToVerticalMode = function(self)
        self.ui_frame:SetWidth(self.FRAME_WIDTH_VERTICAL)
        self.ui_frame.search_box:SetWidth(self.VERTICAL_WIDTH_TF)
        for _, v in pairs(self.drop_down_names) do
            UIDropDownMenu_SetWidth(_G[self.filter_frame_name .. v], self.VERTICAL_WIDTH_DD)
        end
    end,
    ----------------------------------------------------------------------------------------------------------
    -- Switch to horizontal split layout
    ----------------------------------------------------------------------------------------------------------
    ResizeToHorizontalMode = function(self)
        self.ui_frame:SetWidth(self.FRAME_WIDTH_HORIZONTAL)
        self.ui_frame.search_box:SetWidth(self.HORIZONTAL_WIDTH_TF)
        for _, v in pairs(self.drop_down_names) do
            UIDropDownMenu_SetWidth(_G[self.filter_frame_name .. v], self.HORIZONTAL_WIDTH_DD)
        end
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
        UIDropDownMenu_SetText(self.ui_frame.specialisation_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("any specialisation"))
        -- Update the list of specialisations for the current profession
        self:BuildSpecialisations()
        self:CreateDropDownSpecialisations()
        self.list_frame:ChangeSpecialisation(self.current_spec_id)
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