------------------------------------------
-- Contains all functions for the world --
------------------------------------------

MTSL_LOGIC_WORLD = {
    ------------------------------------------------------------------------------------------------
    -- Returns a list of Continents ordered by name
    --
    -- returns 		Array		The contintents
    ------------------------------------------------------------------------------------------------
    GetContinents = function(self)
        return MTSL_TOOLS:SortArrayByLocalisedProperty(MTSL_DATA["continents"], "name")
    end,

    ------------------------------------------------------------------------------------------------
    -- Returns a continent by id
    --
    -- @id          Number      The id of the continent
    --
    -- returns 		Array		The continent
    ------------------------------------------------------------------------------------------------
    GetContinentById = function(self, id)
        return MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["contitents"], "id", id)
    end,

    ------------------------------------------------------------------------------------------------
    -- Returns a continent by name
    --
    -- @name        String      The name of the continent
    --
    -- returns 		Array		The continent
    ------------------------------------------------------------------------------------------------
    GetContinentByName = function(self, name)
        return MTSL_TOOLS:GetItemFromLocalisedArrayByKeyValue(MTSL_DATA["contitents"], "name", name)
    end,

    ------------------------------------------------------------------------------------------------
    -- Returns a list of Zones ordered by name
    --
    -- returns 		Array		The zones
    ------------------------------------------------------------------------------------------------
    GetZones = function(self)
        return MTSL_TOOLS:SortArrayByLocalisedProperty(MTSL_DATA["zones"], "name")
    end,

    ------------------------------------------------------------------------------------------------
    -- Returns a zone by name
    --
    -- @name        String      The name of the zone
    --
    -- returns 		Array		The continent
    ------------------------------------------------------------------------------------------------
    GetZoneByName = function(self, name)
        return MTSL_TOOLS:GetItemFromLocalisedArrayByKeyValue(MTSL_DATA["zones"], "name", name)
    end,

    ------------------------------------------------------------------------------------------------
    -- Returns the name (localised) of a zone by id
    --
    -- @zone_id		Number		The id of the zone
    --
    -- returns 		String		The localised name of the zone
    ------------------------------------------------------------------------------------------------
    GetZoneNameById = function(self, id)
        local zone = MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["zones"], "id", id)
        if zone then
            return MTSLUI_TOOLS:GetLocalisedData(zone)
        end
        return ""
    end,

    ------------------------------------------------------------------------------------------------
    -- Returns a list of Zones for a contintent
    --
    -- @continent_name      String      The name of the contintent
    --
    -- returns 		        Array		The zones
    ------------------------------------------------------------------------------------------------
    GetZonesInContinentByName = function(self, continent_name)
        local cont_id = self:GetContintent(continent_name)["id"]
        local zones_continent = MTSL_TOOLS:GetAllItemsFromArrayByKeyValue(MTSL_DATA["zones"], "cont_id", cont_id)
        return MTSL_TOOLS:SortArrayByLocalisedProperty(zones_continent, "name")
    end,

    ------------------------------------------------------------------------------------------------
    -- Returns a list of Zones for a contintent by id
    --
    -- @continent_id      Number      The id of the contintent
    --
    -- returns 		        Array		The zones
    ------------------------------------------------------------------------------------------------
    GetZonesInContinentById = function(self, continent_id)
        local zones_continent = MTSL_TOOLS:GetAllItemsFromArrayByKeyValue(MTSL_DATA["zones"], "cont_id", continent_id)
        return MTSL_TOOLS:SortArrayByLocalisedProperty(zones_continent, "name")
    end,
}