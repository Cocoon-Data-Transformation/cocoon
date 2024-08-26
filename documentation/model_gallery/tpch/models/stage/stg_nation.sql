-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-25 23:24:16.330008+00:00
WITH 
"nation_renamed" AS (
    -- Rename: Renaming columns
    -- N_NATIONKEY -> nation_id
    -- N_NAME -> country_name
    -- N_REGIONKEY -> region_id
    -- N_COMMENT -> country_description
    SELECT 
        "N_NATIONKEY" AS "nation_id",
        "N_NAME" AS "country_name",
        "N_REGIONKEY" AS "region_id",
        "N_COMMENT" AS "country_description"
    FROM "memory"."main"."nation"
)

-- COCOON BLOCK END
SELECT *
FROM "nation_renamed"