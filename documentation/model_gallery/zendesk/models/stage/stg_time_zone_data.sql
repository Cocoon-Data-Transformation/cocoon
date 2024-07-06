-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"time_zone_data_projected" AS (
    -- Projection: Selecting 2 out of 3 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "time_zone",
        "standard_offset"
    FROM "time_zone_data"
),

"time_zone_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- time_zone -> location
    -- standard_offset -> utc_offset
    SELECT 
        "time_zone" AS "location",
        "standard_offset" AS "utc_offset"
    FROM "time_zone_data_projected"
)

-- COCOON BLOCK END
SELECT * FROM "time_zone_data_projected_renamed"