---------------------------------------------
-- Contains all functions for a profession --
---------------------------------------------

MTSL_NAME_PROFESSIONS = {
    "Alchemy",
    "Blacksmithing",
    "Enchanting",
    "Engineering",
    "Leatherworking",
    "Mining",
    "Tailoring",
    "Cooking",
    "First Aid",
    "Poisons",
}

MTSL_LOGIC_PROFESSION = {
    ----------------------------------------------------------------------------------------
    -- Returns the current rank learned for a profession (1 Apprentice to  4 Artisan)
    --
    -- @profession_name     String      The name of the profession
    -- @max_level           Number      The current maximum number of skill that can be gained
    --
    -- returns              Array       The array with the ids of the missing levels
    -----------------------------------------------------------------------------------------
    GetRankForProfessionByMaxLevel = function(self, profession_name, max_level)
        for k, v in pairs(self:GetLevelsForProfession(profession_name)) do
            if v.max_skill == max_level then
                return v.rank
            end
        end
        -- always return lowest possible rank (for poisons)
        return 1
    end,

    ----------------------------------------------------------------------------------------
    -- Searches for skill levels the player hasn't learned yet and add them to list
    --
    -- @profession_name     String      The name of the profession
    --
    -- returns              Array       The array with the ids of the missing levels
    -----------------------------------------------------------------------------------------
    GetLevelsNotKnownForProfession = function(self, profession_name)
        local missing_level_ids  = {}
        local profession_levels = self:GetLevelsForProfession(profession_name)

        local i = 1

        -- Loop levels until we find the one we know
        while not IsSpellKnown(profession_levels[i].id) do
            i = i + 1
        end
        -- skip the learned spell
        i = i + 1
        -- add all the next/remaining levels as missing
        while profession_levels[i] ~= nil do
            table.insert(missing_level_ids, profession_levels[i].id)
            i = i + 1
        end

        return missing_level_ids
    end,

    -----------------------------------------------------------------------------------------------
    -- Get all the levels of a profession, ordered by rank (Apprentice, Journeyman, Expert, Artisan)
    --
    -- @profession_name     String      The name of the profession
    --
    -- returns              Array       The array with levels
    -----------------------------------------------------------------------------------------------
    GetLevelsForProfession = function(self, profession_name)
        return MTSL_TOOLS:SortArrayByProperty(MTSL_DATA[profession_name]["levels"], "rank")
    end,

    -----------------------------------------------------------------------------------------------
    -- Returns a list of skills based on the filters
    --
    -- @list_skills         Array       The list of skills to filter
    -- @profession_name     String      The name of the profession
    -- @skill_name          String      The (partial) name of the skill
    -- @source_type         String      The sourcetype for the skill
    -- @specialisation      String      The name of the specialisation
    -- @max_phase			Number		The maximum content phase for skill to be included (default = current)
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill (0 = all)
    -- @faction_id			Number		The id of the faction from which we must be able to learn skill (0 = all)
    --
    -- returns              Array       The skills passed the filter
    -----------------------------------------------------------------------------------------------
    FilterListOfSkills = function(self, list_skills, profession_name, skill_name, source_type, specialisation, max_phase, zone_id, faction_id)
        local filtered_list = {}
        -- add all the skills
        if list_skills ~= nil then
            for _, v in pairs(list_skills) do
                local skill_passed_filter = true
                -- Check if name is ok
                if skill_name ~= nil and skill_name ~= "" then
                    local name = string.lower(MTSLUI_TOOLS:GetLocalisedData(v))
                    local contains = string.lower(skill_name)
                    local start_index, _ = string.find(name, contains)
                    -- if we dont have a start index, the name does not contain the pattern
                    if start_index == nil then
                        skill_passed_filter = false
                    end
                end
                --  check specialisation (added check for no specialisation = -1)
                if skill_passed_filter == true and specialisation ~= nil and (specialisation > 0 and v.specialisation ~= specialisation) or (specialisation < 0 and v.specialisation ~= nil) then
                    skill_passed_filter = false
                end
                -- Check availability in zone & phase
                if skill_passed_filter == true and MTSL_LOGIC_SKILL:IsSkillAvailableInPhaseAndZone(v, profession_name, max_phase, zone_id) == false then
                    skill_passed_filter = false
                end
                -- check if source type is ok
                if skill_passed_filter == true and source_type ~= "any" and source_type ~= nil and source_type ~= "" and MTSL_LOGIC_SKILL:IsAvailableForSourceType(v.id, profession_name, source_type) == false then
                    skill_passed_filter = false
                end
                -- check if faction is ok
                if skill_passed_filter == true and faction_id ~= 0 and faction_id ~= nil and faction_id ~= "" and MTSL_LOGIC_SKILL:IsAvailableForFaction(v.id, profession_name, faction_id) == false then
                    skill_passed_filter = false
                end
                -- passed all filters so add it to list
                if skill_passed_filter then
                    table.insert(filtered_list, v)
                end
            end
        end
        return filtered_list
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the available (in the given phase) skills and levels in a zone for one profession sorted by minimim skill
    --
    -- @profession_name		String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included (default = current)
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill (0 = all)
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllAvailableSkillsAndLevelsForProfessionInZone = function(self, profession_name, max_phase, zone_id)
        local profession_skills = {}

        if MTSL_DATA[profession_name] ~= nil then
            -- add all the skills
            for _, v in pairs(MTSL_DATA[profession_name]["skills"]) do
                if MTSL_LOGIC_SKILL:IsSkillAvailableInPhaseAndZone(v, profession_name, max_phase, zone_id) then
                    table.insert(profession_skills, v)
                end
            end
            -- add all the levels (no need to check, always all available)
            for _, v in pairs(MTSL_DATA[profession_name]["levels"]) do
                -- check if learned in zone or not
                if MTSL_LOGIC_SKILL:IsSkillAvailableInPhaseAndZone(v, profession_name, max_phase, zone_id) then
                    table.insert(profession_skills, v)
                end
            end
            -- sort the array by minimum skill
            MTSL_TOOLS:SortArrayByProperty(profession_skills, "min_skill")
        end
        return profession_skills
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the skills and levels for one profession sorted by minimim skill (regardless the zone, phase)
    --
    -- @prof_name			String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included (default = current)
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill (0 = all)
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllSkillsAndLevelsForProfession = function(self, profession_name)
        -- MAX_PHASE to allow all skills to be considered
        -- pass 0 as zone_id for all zones
        return self:GetAllAvailableSkillsAndLevelsForProfessionInZone(profession_name, MTSL_DATA.MAX_PATCH_LEVEL, 0)
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the skills and levels for one profession sorted by minimim skill
    --
    -- @profession_name			String		The name of the profession
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllSkillsAndLevelsForProfessionForCurrentPhase = function(self, profession_name)
        -- pass 0 as zone_id for all zones
        return self:GetAllAvailableSkillsAndLevelsForProfessionInZone(profession_name,MTSL_DATA.CURRENT_PATCH_LEVEL, 0)
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the skills and levels for one profession sorted by minimim skill with at least one sources in the given zone
    --
    -- @profession_name		String		The name of the profession
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllSkillsAndLevelsForProfessionForCurrentPhaseInZone = function(self, profession_name, zone_id)
        return self:GetAllAvailableSkillsAndLevelsForProfessionInZone(profession_name,MTSL_DATA.CURRENT_PATCH_LEVEL, zone_id)
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the available (in the given phase) skills (EXCL the levels) in a zone for one profession sorted by minimim skill
    --
    -- @prof_name			String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included (default = current)
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill (0 = all)
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllAvailableSkillsForProfessionInZone = function(self, profession_name, max_phase, zone_id)
        local profession_skills = {}

        if MTSL_DATA[profession_name] ~= nil then
            -- add all the skills
            for _, v in pairs(MTSL_DATA[profession_name]["skills"]) do
                if MTSL_LOGIC_SKILL:IsSkillAvailableInPhaseAndZone(v, profession_name, max_phase, zone_id) then
                    table.insert(profession_skills, v)
                end
            end
            -- sort the array by minimum skill
            MTSL_TOOLS:SortArrayByProperty(profession_skills, "min_skill")
        end
        return profession_skills
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the skills for one profession sorted by minimim skill (regardless the zone, phase)
    --
    -- @profession_name		String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included (default = current)
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill (0 = all)
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllSkillsForProfession = function(self, profession_name)
        -- MAX_PHASE to allow all skills to be considered
        -- pass 0 as zone_id for all zones
        return self:GetAllAvailableSkillsForProfessionInZone(profession_name, MTSL_DATA.MAX_PATCH_LEVEL, 0)
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the skills for one profession sorted by minimim skill
    --
    -- @profession_name			String		The name of the profession
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllSkillsForProfessionForCurrentPhase = function(self, profession_name)
        -- pass 0 as zone_id for all zones
        return self:GetAllAvailableSkillsForProfessionInZone(profession_name,MTSL_DATA.CURRENT_PATCH_LEVEL, 0)
    end,

    -----------------------------------------------------------------------------------------------
    -- Get All the skills for one profession sorted by minimim skill with at least one sources in the given zone
    --
    -- @profession_name		String		The name of the profession
    -- @zone_id				Number		The id of the zone in which we must be able to learn skill
    --
    -- return				Array		All the skills for one profession sorted by name or minimim skill
    ------------------------------------------------------------------------------------------------
    GetAllSkillsForProfessionForCurrentPhaseInZone = function(self, profession_name, zone_id)
        return self:GetAllAvailableSkillsForProfessionInZone(profession_name,MTSL_DATA.CURRENT_PATCH_LEVEL, zone_id)
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a list of localised skill names for the current craft that are learned
    --
    -- return				Array		Array containing all the names
    ------------------------------------------------------------------------------------------------
    GetSkillNamesCurrentCraft = function(self)
        local learned_skill_names = {}
        -- Loop all known skills
        for i=1,GetNumCrafts() do
            local skill_name,skill_type = GetCraftInfo(i)
            -- Skip the headers, only check real skills
            if skill_name ~= nil and skill_type ~= "header" then
                table.insert(learned_skill_names, skill_name)
            end
        end
        -- return the found list
        return learned_skill_names
    end,

    -----------------------------------------------------------------------------------------------
    -- Gets a list of localised skill names for the current tradeskill that are learned
    --
    -- return				Array		Array containing all the names
    ------------------------------------------------------------------------------------------------
    GetSkillNamesCurrentTradeSkill = function(self)
        local learned_skill_names = {}
        -- Loop all known skills
        for i=1,GetNumTradeSkills() do
            local skill_name,skill_type = GetTradeSkillInfo(i)
            -- Skip the headers, only check real skills
            if skill_name ~= nil and skill_type ~= "header" then
                table.insert(learned_skill_names, skill_name)
            end
        end
        -- return the found list
        return learned_skill_names
    end,

    ------------------------------------------------------------------------------------------------
    -- Gets the status for a player for a skill of a Profession
    --
    -- @player				Object		The player for who to check
    -- @profession_name	    String		The name of the profession
    -- @skill_id			Number		The id of the skill to search
    --
    -- return				Number		Status of the skill
    ------------------------------------------------------------------------------------------------
    IsSkillKnownForPlayer = function(self, player, profession_name, skill_id)
        local trade_skill = player.TRADESKILLS[profession_name]
        -- returns 0 if tadeskill not trained, 1 if trained but skill not learned and current skill to low, 2 if skill is learnable, 3 if skill learned
        local known_status
        if trade_skill == nil or trade_skill == 0 then
            known_status = 0
        else
            local skill_known = MTSL_TOOLS:ListContainsNumber(trade_skill.MISSING_SKILLS, skill_id)
            if skill_known == true then
                known_status = 3
            else
                -- try to find the skill
                local skill = MTSL_TOOLS:GetItemFromUnsortedListById(MTSL_DATA[profession_name]["skills"], skill_id)
                -- its a level
                if skill == nil then
                    skill = MTSL_TOOLS:GetItemFromUnsortedListById(MTSL_DATA[profession_name]["levels"], skill_id)
                end
                if trade_skill.SKILL_LEVEL < skill.min_skill then
                    known_status = 1
                else
                    known_status = 2
                end
            end
        end
        return known_status
    end,

    -----------------------------------------------------------------------------------------------
    -- Get number of available skills for one profession up to max content phase
    --
    -- @profession_name		String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included
    --
    -- return				Number		the number
    ------------------------------------------------------------------------------------------------
    GetTotalNumberOfAvailableSkillsForProfession = function(self, profession_name, max_phase)
        if max_phase == MTSL_DATA.CURRENT_PATCH_LEVEL then
            return MTSL_DATA["AMOUNT_SKILLS_CURRENT_PHASE"][profession_name]
        else
            return MTSL_DATA["AMOUNT_SKILLS"][profession_name]
        end
    end,

    -----------------------------------------------------------------------------------------------
    -- Counts/Calculates the number of available skills for one profession up to max content phase
    --
    -- @profession_name		String		The name of the profession
    -- @max_phase			Number		The maximum content phase for skill to be included
    --
    -- return				Number		the number
    ------------------------------------------------------------------------------------------------
    CountTotalNumberOfAvailableSkillsForProfession = function(self, profession_name, max_phase)
        -- levels are always availble so start counter there
        local counter = MTSL_TOOLS:CountItemsInArray(MTSL_DATA[profession_name]["levels"])
        -- loop all skills for the profession and check if its available
        for t, s in pairs(MTSL_DATA[profession_name]["skills"]) do
            if MTSL_LOGIC_SKILL:IsSkillAvailableInPhase(s, profession_name, max_phase) then
                counter = counter + 1
            end
        end

        return counter
    end,

    -----------------------------------------------------------------------------------------------
    -- Get list of specialisations for a profession
    --
    -- @profession_name		String		The name of the profession
    --
    -- return				Array		List or {}
    ------------------------------------------------------------------------------------------------
    GetSpecialisationsForProfession = function(self, profession_name)
        return MTSL_DATA["specialisations"][profession_name] or {}
    end,

    -----------------------------------------------------------------------------------------------
    -- Get list of specialisations for a profession
    --
    -- @profession_name		    String		The name of the profession
    -- @specialisation_id	    Number		The id of the specialisation
    --
    -- return				    String		Name or nil
    ------------------------------------------------------------------------------------------------
    GetNameSpecialisation = function(self, profession_name, specialisation_id)
        local spec = MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["specialisations"][profession_name], "id", specialisation_id)
        if spec ~= nil then
            return MTSLUI_TOOLS:GetLocalisedData(spec)
        end
        return ""
    end,

    -----------------------------------------------------------------------------------------------
    -- Get the name of the profession based on a skill
    --
    -- @skill               Object      The skill for which we search the profession
    --
    -- return				String      The name of the profession
    ------------------------------------------------------------------------------------------------
    GetProfessionNameBySkill = function(self, skill)
        local profession_name = ""
        local p = 1
        -- loop each profession until we find it
        while profession_name == "" and MTSL_NAME_PROFESSIONS[p] ~= nil do
            -- loop each skill for this profession and compare to skill we seek
            local skills = self:GetAllSkillsAndLevelsForProfession(MTSL_NAME_PROFESSIONS[p])
            local s = 1
            while profession_name == "" and skills[s] ~= nil do
                if skills[s] == skill then
                    profession_name = MTSL_NAME_PROFESSIONS[p]
                end
                -- next skill
                s = s + 1
            end
            -- next profession
            p = p + 1
        end
        return profession_name
    end,
}