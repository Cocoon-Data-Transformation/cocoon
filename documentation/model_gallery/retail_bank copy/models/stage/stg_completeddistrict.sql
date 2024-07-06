-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"completeddistrict_renamed" AS (
    -- Rename: Renaming columns
    -- state_abbrev -> state_abbreviation
    -- region -> census_region
    -- division -> census_division
    SELECT 
        "district_id",
        "city",
        "state_name",
        "state_abbrev" AS "state_abbreviation",
        "region" AS "census_region",
        "division" AS "census_division"
    FROM "completeddistrict"
)

-- COCOON BLOCK END
SELECT * FROM "completeddistrict_renamed"